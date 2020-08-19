<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 차트 구성 SCRIPT STR-->
<script type="text/javascript" src="${ctxt}/resources/js/chart/jui/core.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctxt}/resources/js/chart/jui/chart.js" ></script>
 <%-- <link rel="stylesheet" href="${ctxt}/resources/js/chart/jui/jquery-ui.min.css" /> --%>
<!-- 차트 구성 SCRIPT END-->
<script type="text/javascript">

$(function(){
	$(".ui-datepicker-trigger").attr("style", "margin-left:2px; vertical-align:middle; cursor: Pointer;"); 
});

function fn_select_srch(val) {
	switch(val) {
	case '1':
		$("#type_archive").show();
		break;
	case '2':
		$("#type_archive").show();
		break;
	case '3':
		$("#type_archive").show();
		break;		
	case '4':
		$("#type_archive").hide();
		break;
	case '5':
		$("#type_archive").hide();
		break;
	case '6':
		$("#type_archive").hide();
		break;
	case '7':
		$("#type_archive").show();
		break;
	}
}

$(function(){
	//초기 값 셋팅
	fn_select_srch("1");
	fn_stats_orderDept();

	var date = new Date(); 
	var year = date.getFullYear(); 
	var month = new String(date.getMonth()+1); 
	var day = new String(date.getDate()); 

	// 한자리수일 경우 0을 채워준다. 
	if(month.length == 1){ 
	  month = "0" + month; 
	} 

	fdate("select_fdate");
	ldate("select_ldate");
	
	$("#select_fdate").val(year + "-" + "01");
	$("#select_ldate").val(year + "-" + month);
	$("#chartOption").hide();
});

function fn_selectChartOption(option){
	fn_btn_stat();
}


function fn_btn_stat() {
	//new Date();
		$("#chartOption").show();
		var fdateArr = $("#select_fdate").val().split("-");
		var ldateArr = $("#select_ldate").val().split("-");
		var fdate = fdateArr[0]+fdateArr[1];
		var ldate = ldateArr[0]+ldateArr[1];
	
	if(fdate == "undefined"){
		alert('첫번째 날짜를 선택하여 주십시오.');
		return;
	}else if(ldate == "undefined"){
		alert('마지막 날짜를 선택하여 주십시오.');
		return;
	}
	
	if(fdate > ldate){
		alert('종료월은 시작월보다 적을 수 없습니다.');
		return;
	}
	
	if($("#searchCondition").val() == '1'){
		//연도별 구축현황(소장통계)
		fn_stats_possession(fdate,ldate);
	}else if($("#searchCondition").val() == '2'){
		//다운로드 수
		fn_stats_download(fdate,ldate);
	}else if($("#searchCondition").val() == '3'){
			
			fn_stats_view(fdate,ldate);
	}
	/*
	else if($("#searchCondition").val() == '4'){
		//주제분류
		fn_stats_orderDept();
	}else if($("#searchCondition").val() == '6'){
		//SCI논문 수 
		fn_stats_rndSCI();
	}else if($("#searchCondition").val() == '7'){
		//첨부파일 수 
		fn_stats_file();
	}
	*/
}

function fn_select_menu(val){
	var id_val = $(val).attr('id');	
	var comboVal = $("#"+id_val).val();
	
// 	if(comboVal == 'report'){
// 		$("#searchCondition option[value = '6']").hide();
// 		$("#searchCondition option[value = '4']").show();
// 	}else if(comboVal == 'rnd'){
// 		$("#searchCondition option[value = '6']").show();
// 		$("#searchCondition option[value = '4']").hide();
// 	}
}

<!--연도별 구축현황(소장통계)-->
function fn_stats_possession(fdate,ldate){
	
	var chartOption =  $("#chartOption option:selected").val();
	if(chartOption == 'bar'){
    		$("#gridChartBar").attr("style","margin-top: 100px;");
    		$("#gridChartLine").attr("style","display:none;margin-top: 100px;");
    		$("#gridChartPie").attr("style","display:none;margin-top: 100px;");
    	}else if(chartOption == 'line'){
    		$("#gridChartBar").attr("style","display:none;margin-top: 100px;");
    		$("#gridChartLine").attr("style","margin-top: 100px;");
    		$("#gridChartPie").attr("style","display:none;margin-top: 100px;");
    	}else{
    		$("#gridChartBar").attr("style","display:none;margin-top: 100px;");
    		$("#gridChartLine").attr("style","display:none;margin-top: 100px;");
    		$("#gridChartPie").attr("style","margin-top: 100px;");
    	}
	var params = {};
	params.archive_gbn = $('#archive_gbn').val();
	params.fdate = fdate;
	params.ldate = ldate;
	
	
	   $.ajax({
	        url: '${ctxt}/archive/statistics/statsPossession.do',
	        data: params,
	        type: 'POST',
	        dataType: 'text',
	        cache: false,
	        success: function(rtnXml) {
	        	//차트 초기화
	        		$("#gridChartBar").children().remove();
	        		$("#gridChartLine").children().remove();
	        		$("#gridChartPie").children().remove();
	        		
	        		
	        		
	        	xmlList = $(rtnXml).find('item');
	        	var pie = {};
				if(xmlList.length > 0){
				
					var archive_list  = new Array();
					
					xmlList.each(function(cnt){
						
						var obj = $(this);
						/***************************************************************
						* 화면별로 따로 세팅 테이블 데이터
						****************************************************************/
						
						var pubyear = obj.find('pubyear').text(); 
						var pubyear_cnt = obj.find('pubyear_cnt').text(); 			
						 

						if(chartOption == 'bar' || chartOption == 'line'){
							var data = new Object();
							data.quarter = parseInt(pubyear);
							data.count = parseInt(pubyear_cnt);
							
							archive_list.push(data);
						}else if(chartOption == 'pie'){
							 pie[pubyear] =  parseInt(pubyear_cnt);
						}
						
			        });
				
					if(chartOption == 'pie'){
						archive_list.push(pie);
					}
					
					var chart = jui.include("chart.builder");
					var jsonData  = JSON.stringify(archive_list);
		
					if(chartOption == 'bar'){
						
					chart("#gridChartBar", {
						width : 900,
						height : 500,
						padding : {
							left: 30,
							top : 60
						},
					    axis : {				       
					        x : {
					        	type : "block",
					            domain : "quarter",
					            line : true  
					        },
					        y : {
					        	type : "range",
					            domain : function(d) { return chartMax(d.count); },
					            step : 5,
					            line : true
					        },
					        data : eval(jsonData)
					    },
					    brush : {
					        type : "column",
					        size : 20,
					        target : ["count" ],
					    },
					    widget : [
					        { type : "tooltip"}
					       ,{ 
					          type : "title",
					          text : "구축현황"
					         }
					    ],
					    style:{
					    	backgroundColor: "none"
	     				}
					});
					
				}else if(chartOption == 'line'){		
					chart("#gridChartLine", {
						width : 900,
						height : 500,
						padding : {
							left: 30,
							top : 60
						},
					    axis : {
					        x : {
					            type : "fullblock",
					            domain : "quarter",
					            line : true
					        },
					        y : {
					            type : "range",
					            domain : function(d) { return chartMax(d.count); },
					            step : 10
					        },
					        data : eval(jsonData)
					    },
					    brush : [{
					        type : "line",
					        animate : true
					    }, {
					        type : "scatter",
					        hide : true
					    }],
					    widget : [
					    	{ type : "title", text : "구축현황" },
					        { type : "tooltip", brush : 1 }
					    ]
					});

				}else{
					chart("#gridChartPie", {
						width : 900,
						height : 500,
						padding : {
							left: 30,
							top : 70,
							bottom:70
						},
						axis : {
							  data : eval(jsonData)
					    },
					    brush : {
					        type : "pie",
					        showText : true,
					        format : function(k, v) {
					            return k+ ": " +v +"건" ;
					        }
					    },
					    widget : [{
					        type : "title",
					        text : "구축현황"
					    }, {
					        type : "tooltip",
					        orient : "left"
					    }],
					    style:{
					    	backgroundColor: "none"
	     				}
					});
					
				}
				
				}else{
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
					****************************************************************/
					if(chartOption == 'bar'){
		        	//차트 초기화
						$("#gridChartBar").html('<div style="padding-top:200px;">데이터가 존재하지 않습니다.</div>');
		        	}else if(chartOption == 'line'){
		        		$("#gridChartLine").html('<div style="padding-top:200px;">데이터가 존재하지 않습니다.</div>');
		        	}else{
		        		$("#gridChartPie").html('<div style="padding-top:200px;">데이터가 존재하지 않습니다.</div>');
		        	}
				}
	        },
	        error : function(xmlHttpRequest , textStatus, errorThrown){ // Ajax 전송 에러 발생시 실행
	        	if(xmlHttpRequest.readyState == 0 || xmlHttpRequest.status ==0){        	
	        		return;        		
	        	}else{
	        		 alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
	        	}        	        
	        }
	    })
}



<!--다운로드수-->
function fn_stats_download(fdate,ldate){
	
	var chartOption =  $("#chartOption option:selected").val();
	if(chartOption == 'bar'){
    		$("#gridChartBar").attr("style","margin-top: 100px;");
    		$("#gridChartLine").attr("style","display:none;margin-top: 100px;");
    		$("#gridChartPie").attr("style","display:none;margin-top: 100px;");
    	}else if(chartOption == 'line'){
    		$("#gridChartBar").attr("style","display:none;margin-top: 100px;");
    		$("#gridChartLine").attr("style","margin-top: 100px;");
    		$("#gridChartPie").attr("style","display:none;margin-top: 100px;");
    	}else{
    		$("#gridChartBar").attr("style","display:none;margin-top: 100px;");
    		$("#gridChartLine").attr("style","display:none;margin-top: 100px;");
    		$("#gridChartPie").attr("style","margin-top: 100px;");
    	}
	
	var params = {};
	params.archive_gbn = $('#archive_gbn').val(); 
	params.fdate = fdate;
	params.ldate = ldate;
	
	   $.ajax({
	        url: '${ctxt}/archive/statistics/statsDownload.do',
	        data: params,
	        type: 'POST',
	        dataType: 'text',
	        cache: false,
	        success: function(rtnXml) {
	        	
	        	//차트 초기화
	        	$("#gridChartBar").children().remove();
	        	$("#gridChartLine").children().remove();
        		$("#gridChartPie").children().remove();
	        	xmlList = $(rtnXml).find('item');
	        	var pie = {};
				if(xmlList.length > 0){
				
					var archive_list  = new Array();	
					xmlList.each(function(cnt){
						
						var obj = $(this);
						/***************************************************************
						* 화면별로 따로 세팅 테이블 데이터
						****************************************************************/
						var downcnt = obj.find('downcnt').text();
						var downDate = obj.find('downDate').text();
					
						if(chartOption == 'bar' || chartOption == 'line'){
							var data = new Object();
							data.quarter = parseInt(downDate);
							data.count = parseInt(downcnt);
							
							archive_list.push(data);
						}else if(chartOption == 'pie'){
							 pie[downDate] =  parseInt(downcnt);
						}
			        });
				

					if(chartOption == 'pie'){
						archive_list.push(pie);
					}
					
					var chart = jui.include("chart.builder");
					var jsonData  = JSON.stringify(archive_list);
			
					if(chartOption == 'bar'){
						
						chart("#gridChartBar", {
							width : 900,
							height : 500,
							padding : {
								left: 30,
								top : 60
							},
						    axis : {				       
						        x : {
						        	type : "block",
						            domain : "quarter",
						            line : true  
						        },
						        y : {
						        	type : "range",
						            domain : function(d) { return chartMax(d.count); },
						            step : 5,
						            line : true
						        },
						        data : eval(jsonData)
						    },
						    brush : {
						        type : "column",
						        size : 20,
						        target : ["count" ],
						    },
						    widget : [
						        { type : "tooltip"}
						       ,{ 
						          type : "title",
						          text : "다운로드 수"
						         }
						    ],
						    style:{
						    	backgroundColor: "none"
		     				}
						});
						
					}else if(chartOption == 'line'){
						
						chart("#gridChartLine", {
							width : 900,
							height : 500,
							padding : {
								left: 30,
								top : 60
							},
						    axis : {				       
						        x : {
						        	type : "fullblock",
						            domain : "quarter",
						            line : true  
						        },
						        y : {
						        	type : "range",
						            domain : function(d) { return chartMax(d.count); },
						            step : 10,
						        },
						        data : eval(jsonData)
						    },
						    brush : [{
						        type : "line",
						        animate : true
						    }, {
						        type : "scatter",
						        hide : true
						    }],
						    widget : [
						    	{ type : "title", text : "다운로드" },
						        { type : "tooltip", brush : 1 }
						    ]
						});
						
					}else{
						chart("#gridChartPie", {
							width : 900,
							height : 500,
							padding : {
								left: 30,
								top : 70,
								bottom:70
							},
							axis : {
								  data : eval(jsonData)
						    },
						    brush : {
						        type : "pie",
						        showText : true,
						        format : function(k, v) {
						        	  return k+ ": " +v +"건" ;
						        }
						    },
						    widget : [{
						        type : "title",
						        text : "다운로드 수"
						    }, {
						        type : "tooltip",
						        orient : "left",
						    }],
						    style:{
						    	backgroundColor: "none"
		     				}
						});
						
					}
				}else{
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
					****************************************************************/
					
					if(chartOption == 'bar'){
			        	//차트 초기화
							$("#gridChartBar").html('<div style="padding-top:200px;">데이터가 존재하지 않습니다.</div>');
			        	}else if(chartOption == 'line'){
			        		$("#gridChartLine").html('<div style="padding-top:200px;">데이터가 존재하지 않습니다.</div>');
			        	}else{
			        		$("#gridChartPie").html('<div style="padding-top:200px;">데이터가 존재하지 않습니다.</div>');
			        	}
				}
	        },
	        error : function(xmlHttpRequest , textStatus, errorThrown){ // Ajax 전송 에러 발생시 실행
	        	if(xmlHttpRequest.readyState == 0 || xmlHttpRequest.status ==0){        	
	        		return;        		
	        	}else{
	        		 alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
	        	}        	        
	        }
	    })
}


<!--조회수-->
function fn_stats_view(fdate,ldate){
	
	var chartOption =  $("#chartOption option:selected").val();
	if(chartOption == 'bar'){
    		$("#gridChartBar").attr("style","margin-top: 100px;");
    		$("#gridChartLine").attr("style","display:none;margin-top: 100px;");
    		$("#gridChartPie").attr("style","display:none;margin-top: 100px;");
    	}else if(chartOption == 'line'){
    		$("#gridChartBar").attr("style","display:none;margin-top: 100px;");
    		$("#gridChartLine").attr("style","margin-top: 100px;");
    		$("#gridChartPie").attr("style","display:none;margin-top: 100px;");
    	}else{
    		$("#gridChartBar").attr("style","display:none;margin-top: 100px;");
    		$("#gridChartLine").attr("style","display:none;margin-top: 100px;");
    		$("#gridChartPie").attr("style","margin-top: 100px;");
    	}
	
	var params = {};
	params.archive_gbn = $('#archive_gbn').val();
	params.fdate = fdate;
	params.ldate = ldate;
	
	   $.ajax({
	        url: '${ctxt}/archive/statistics/statsView.do',
	        data: params,
	        type: 'POST',
	        dataType: 'text',
	        cache: false,
	        success: function(rtnXml) {
	        	
	        	//차트 초기화
	        	$("#gridChartBar").children().remove();
	        	$("#gridChartLine").children().remove();
        		$("#gridChartPie").children().remove();
        		
	        	xmlList = $(rtnXml).find('item');
	        	var pie = {};
				if(xmlList.length > 0){
				
					var archive_list  = new Array();	
					xmlList.each(function(cnt){
						
						var obj = $(this);
						/***************************************************************
						* 화면별로 따로 세팅 테이블 데이터
						****************************************************************/
						
						var rdcnt = obj.find('rdcnt').text(); 
						var rdDate = obj.find('rdDate').text(); 			
					
						if(chartOption == 'bar' || chartOption == 'line'){
							var data = new Object();
							data.quarter = parseInt(rdDate);
							data.count = parseInt(rdcnt);
							
							archive_list.push(data);
						}else if(chartOption == 'pie'){
							 pie[rdDate] =  parseInt(rdcnt);
						}
			        });
					
					if(chartOption == 'pie'){
						archive_list.push(pie);
					}
					
					var chart = jui.include("chart.builder");
					var jsonData  = JSON.stringify(archive_list);
			
					if(chartOption == 'bar'){
						
						chart("#gridChartBar", {
							width : 900,
							height : 500,
							padding : {
								left: 30,
								top : 60
							},
						    axis : {				       
						        x : {
						        	type : "block",
						            domain : "quarter",
						            line : true  
						        },
						        y : {
						        	type : "range",
						            domain : function(d) {return chartMax(d.count);},
						            step : 5,
						            line : true
						        },
						        data : eval(jsonData)
						    },
						    brush : {
						        type : "column",
						        size : 20,
						        target : ["count" ],
						    },
						    widget : [
						        { type : "tooltip"}
						       ,{ 
						          type : "title",
						          text : "조회수"
						         }
						    ],
						    style:{
						    	backgroundColor: "none"
		     				}
						});
						
					}else if(chartOption == 'line'){
						
						chart("#gridChartLine", {
							width : 900,
							height : 500,
							padding : {
								left: 30,
								top : 60
							},
						    axis : {				       
						        x : {
						        	type : "fullblock",
						            domain : "quarter",
						            line : true  
						        },
						        y : {
						        	type : "range",
						            domain : function(d) { return chartMax(d.count); },
						            step : 10,
						        },
						        data : eval(jsonData)
						    },
						    brush : [{
						        type : "line",
						        animate : true
						    }, {
						        type : "scatter",
						        hide : true
						    }],
						    widget : [
						    	{ type : "title", text : "조회수" },
						        { type : "tooltip", brush : 1 }
						    ]
						});
						
					}else{
						chart("#gridChartPie", {
							width : 900,
							height : 500,
							padding : {
								left: 30,
								top : 70,
								bottom:70
							},
							axis : {
						        data :  eval(jsonData)
						    },
						    brush : {
						        type : "pie",
						        showText : true,
						        format : function(k, v) {
						            return k+ ": " +v +"건" ;
						        },
						    },
						    widget : [{
						        type : "title",
						        text : "조회수"
						    }, {
						        type : "tooltip",
						        orient : "left",
						    }],
						    style:{
						    	backgroundColor: "none"
		     				}
						});
						
					}
				}else{
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
					****************************************************************/
					
						if(chartOption == 'bar'){
			        	//차트 초기화
							$("#gridChartBar").html('<div style="padding-top:200px;">데이터가 존재하지 않습니다.</div>');
			        	}else if(chartOption == 'line'){
			        		$("#gridChartLine").html('<div style="padding-top:200px;">데이터가 존재하지 않습니다.</div>');
			        	}else{
			        		$("#gridChartPie").html('<div style="padding-top:200px;">데이터가 존재하지 않습니다.</div>');
			        	}
				}
	        },
	        error : function(xmlHttpRequest , textStatus, errorThrown){ // Ajax 전송 에러 발생시 실행
	        	if(xmlHttpRequest.readyState == 0 || xmlHttpRequest.status ==0){        	
	        		return;        		
	        	}else{
	        		 alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
	        	}        	        
	        }
	    })
}



<!--주제분류별통계-->
function fn_stats_orderDept(){
	$("#gridChartBar").attr("style","margin-top: 100px;");
	$("#gridChartLine").attr("style","display:none;margin-top: 100px;");
	$("#gridChartPie").attr("style","display:none;margin-top: 100px;");
	$("#chartOption").hide();
	var params = {};
	
	   $.ajax({
	        url: '${ctxt}/archive/statistics/statsOrderDept.do',
	        data: params,
	        type: 'POST',
	        dataType: 'text',
	        cache: false,
	        success: function(rtnXml) {
	        	
	        	//차트 초기화
	        	$("#gridChartBar").children().remove();
	        	$("#gridChartLine").children().remove();
	        	$("#gridChartPie").children().remove();
	        	xmlList = $(rtnXml).find('item');
	        
				if(xmlList.length > 0){
				
					var archive_list  = new Array();	
					xmlList.each(function(cnt){
						
						var obj = $(this);
						/***************************************************************
						* 화면별로 따로 세팅 테이블 데이터
						****************************************************************/
						var subject = obj.find('subject').text(); 
						var subject_cnt = obj.find('subject_cnt').text();
						
						var data = new Object();
						data.quarter = (subject);
						data.count = parseInt(subject_cnt);
						
						archive_list.push(data);
			        });
				
					var chart = jui.include("chart.builder");
					var jsonData  = JSON.stringify(archive_list);
			
					chart("#gridChartBar", {
						width : 900,
						height : 500,
						padding : {
							left:30,
							top : 60
						},
					    axis : {				       
					        x : {
					        	type : "block",
					            domain : "quarter",
					            line : true  
					        },
					        y : {
					        	type : "range",
					            domain : function(d) { return chartMax(d.count); },
					            step : 5,
					            line : true
					        },
					        data : eval(jsonData)
					    },
					    brush : {
					        type : "column",
					        size : 20,
					        target : ["count" ],
					    },
					    widget : [
					        { type : "tooltip"}
					        ,{ 
						          type : "title",
						          text : "주제분류"
						     }
					    ],
					    style:{
					    	backgroundColor: "none"
	     				}
					});
				}else{
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
					****************************************************************/
					
					$("#gridChartBar").html('<div style="padding-top:200px;">데이터가 존재하지 않습니다.</div>');
				}
	        },
	        error : function(xmlHttpRequest , textStatus, errorThrown){ // Ajax 전송 에러 발생시 실행
	        	if(xmlHttpRequest.readyState == 0 || xmlHttpRequest.status ==0){        	
	        		return;        		
	        	}else{
	        		 alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
	        	}        	        
	        }
	    })
}




<!--SCI논문-->
function fn_stats_rndSCI(){
	$("#gridChartBar").attr("style","margin-top: 100px;");
	$("#gridChartLine").attr("style","display:none;margin-top: 100px;");
	$("#gridChartPie").attr("style","display:none;margin-top: 100px;");
	$("#chartOption").hide();
	var params = {};
	
	   $.ajax({
	        url: '${ctxt}/archive/statistics/statsRndSCI.do',
	        data: params,
	        type: 'POST',
	        dataType: 'text',
	        cache: false,
	        success: function(rtnXml) {
	        	
	        	//차트 초기화
	        	$("#gridChartBar").children().remove();
	   
	        	xmlList = $(rtnXml).find('item');
	        
				if(xmlList.length > 0){
				
					var archive_list  = new Array();	
					xmlList.each(function(cnt){
						
						var obj = $(this);
						/***************************************************************
						* 화면별로 따로 세팅 테이블 데이터
						****************************************************************/
						var scicnt = obj.find('scicnt').text(); 
						
						var data = new Object();
						data.quarter = "SCI논문";
						data.count = parseInt(scicnt);
						
						archive_list.push(data);
			        });
				
					var chart = jui.include("chart.builder");
					var jsonData  = JSON.stringify(archive_list);
			
					chart("#gridChartBar", {
						width : 900,
						height : 500,
						padding : {
							left:30,
							top : 60
						},
					    axis : {				       
					        x : {
					        	type : "block",
					            domain : "quarter",
					            line : true  
					        },
					        y : {
					        	type : "range",
					            domain : function(d) {return chartMax(d.count);},
					            step : 5,
					            line : true
					        },
					        data : eval(jsonData)
					    },
					    brush : {
					        type : "column",
					        size : 20,
					        target : ["count" ],
					    },
					    widget : [
					        { type : "tooltip"}
					        ,{ 
						          type : "title",
						          text : "SCI논문"
						     }
					    ],
					    style:{
					    	backgroundColor: "none"
	     				}
					});
				}else{
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
					****************************************************************/
					
					$("#gridChartBar").html('<div style="padding-top:200px;">데이터가 존재하지 않습니다.</div>');
				}
	        },
	        error : function(xmlHttpRequest , textStatus, errorThrown){ // Ajax 전송 에러 발생시 실행
	        	if(xmlHttpRequest.readyState == 0 || xmlHttpRequest.status ==0){        	
	        		return;        		
	        	}else{
	        		 alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
	        	}        	        
	        }
	    })
}


<!--첨부파일수-->
function fn_stats_file(){
	var params = {};
	params.archive_gbn = $('#archive_gbn').val(); 
	
	   $.ajax({
	        url: '${ctxt}/archive/statistics/statsFile.do',
	        data: params,
	        type: 'POST',
	        dataType: 'text',
	        cache: false,
	        success: function(rtnXml) {
	        	
	        	//차트 초기화
	        	$("#gridChartBar").children().remove();
	   
	        	xmlList = $(rtnXml).find('item');
	        
				if(xmlList.length > 0){
				
					var archive_list  = new Array();	
					xmlList.each(function(cnt){
						
						var obj = $(this);
						/***************************************************************
						* 화면별로 따로 세팅 테이블 데이터
						****************************************************************/
						var filecnt = obj.find('filecnt').text(); 
						 
						var data = new Object();
						data.quarter = "file"
						data.count = parseInt(filecnt);
						
						archive_list.push(data);
			        });
				
					var chart = jui.include("chart.builder");
					var jsonData  = JSON.stringify(archive_list);
			
					chart("#gridChartBar", {
						width : 900,
						height : 500,
						padding : {
							left:30,
							top : 60
						},
					    axis : {				       
					        x : {
					        	type : "block",
					            domain : "quarter",
					            line : true  
					        },
					        y : {
					        	type : "range",
					            domain : function(d) { return chartMax(d.count);},
					            step : 5,
					            line : true
					        },
					        data : eval(jsonData)
					    },
					    brush : {
					        type : "column",
					        size : 20,
					        target : ["count" ],
					    },
					    widget : [
					        { type : "tooltip"}
					        ,{ 
						          type : "title",
						          text : "첨부파일"
						     }
					    ],
					    style:{
					    	backgroundColor: "none"
	     				}
					});
				}else{
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
					****************************************************************/
					
					$("#gridChartBar").html('<div>데이터가 존재하지 않습니다.</div>');
				}
	        },
	        error : function(xmlHttpRequest , textStatus, errorThrown){ // Ajax 전송 에러 발생시 실행
	        	if(xmlHttpRequest.readyState == 0 || xmlHttpRequest.status ==0){        	
	        		return;        		
	        	}else{
	        		 alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
	        	}        	        
	        }
	    })
}
</script>
<style>
.sub_archive_wrap2{
	width:100%;
	margin-top:-60px;
}
ul.tabs li{
    width: 129px;
}
div>select{
	height: 38px;
    border: 1px solid #ccc;
    padding: 0 10px;
    color: #7f7f7f;
    margin-right: 8px;
    margin-bottom: 5px;
}
.box_shadow{
	height: auto;
	padding:30px;
	box-sizing:border-box;
}
#searsch-group {
    position: relative;
    right:auto;
    text-align:center; 
    padding: 10px 0;
}
.sub_archive_data_wrap{
	width:96%;
	margin:0 auto;
}
#gridChartBar, #gridChartBar > svg{
	width:100% !important;
}
.select-width, #searchCondition{
	width:110px;
	margin-right:1px;
	display:inline-block;
}
#searchCondition{
	margin-right:20px;
}
#select_fdate, #select_ldate{
	width:90px;
	height:32px;"  
}
.ui-datepicker-trigger{ 
	margin:0 5px 2px 2px;
 	height:20px; 
 	vertical-align:middle; 
 	cursor: Pointer; 
 	font-size: 15px; 
} 
</style>
<form name="reqForm" method="post">
	
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>아카이브</span>
			<span> > </span>
			<span class="active">통계</span>        
		</div>
		<span class="center_text_01" >통계</span>
	</div> 		
	<div class="under_bar"></div>
	
	<!-- 아카이브 소개 목록 -->
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div class="box_shadow">
					<div id="searsch-group">
						<div class="search-input clear">
							<input type="button" id="btnSearch" value="주제분류별 현황" style="margin-left:0; width: 100px; float: left;" onclick="javascript:fn_stats_orderDept()">
							<input type="button" id="btnSearch" value="SCI논문 현황" style="margin:0 20px 0 2px; width: 100px; float: left;" onclick="javascript:fn_stats_rndSCI()">
							<select id="archive_gbn" class="select-width" name="archive_gbn" onchange="fn_select_menu(this);" title="조회조건 선택">
								   <option value="report">보고서</option>
								   <option value="rnd">성과논문</option>
					   		</select>
							<select id="searchCondition" class="select-width" name="searchCondition" title="조회조건 선택" >
								   <option value="1" selected>구축현황</option>
								   <option value="2">다운로드수</option>
								   <option value="3">조회수</option>
<!-- 								   <option value="4">주제분류</option> -->
<!-- 								   <option value="6">SCI논문</option> -->
							</select>
			            	<input id="select_fdate" name="select_fdate"  class="full"  type="text" title="first기간"/>
			            	<input id="select_ldate" name="select_ldate"  class="full"  type="text" title="last기간"/>
					   		<input type="button" id="btnSearch" value="검색" style="margin-left:0;" onclick="javascript:fn_btn_stat()">
						</div>
				 	</div>
				 	<div class="under_bar" style="width:95%; margin:0 auto; margin-bottom:20px;"></div>
					<div class= "sub_archive_wrap2">				
						<div class="sub_archive_data_wrap"> 	
						   
							<div id ="gridChartBar" class="right2" style="margin-top: 100px;"> 
						    </div>
							<div id ="gridChartLine" class="right2" style="margin-top: 100px; display: none;"> 
						    </div>
							<div id ="gridChartPie" class="right2" style="margin-top: 100px; display: none;"> 
						    </div>
							
					    </div>
				    </div>
				    <div class="btn-group" style="margin-top: 10px;">
				    	<select id="chartOption" class="select-width" name="chartOption" onchange="fn_selectChartOption(this);" style="float: right;margin: 10px 40px 10px 0 ;position: absolute;top: 630px;left: 760px;">
					   			<option value="bar" selected>바 그래프</option>
					   			<option value="line">꺾은선 그래프</option>
					   			<option value="pie">원 그래프</option>
				   		</select>
				    </div>	  
				</div>
			</div>
		</div>
	</div>		

			
<!-- 아카이브 소개 목록 -->
<!-- <div class="content_wrap">
	<div class="content_box">
		<div class="content_list">
		<div style="width: 100%; height:122px; padding:10px; border:1px solid #eee; box-shadow:3px 3px 5px rgba(0, 0, 0, 0.2); margin-bottom: 15px;">
			 
			   <div id=""> 
				  <select id="searchCondition" name="searchCondition"  title="조회조건 선택" onchange="fn_select_srch(this.value);">
							   <option value="1" selected>구축현황</option>
							   <option value="2">다운로드수</option>
							   <option value="3">조회수</option>
							   <option value="4">주제분류</option>
							   <option value="6">SCI논문</option>
							   <option value="7">첨부파일</option>
				   </select>
			   </div>
			   
			   <div style="float:right; margin-right: 70%; margin-top: -40px;">
			   		<input type="button" id="btnSearch" value="검색" onclick="javascript:fn_btn_stat()">
			   </div>
			   
			   
			   <div id="type_archive">
				  <select id="archive_gbn" name="archive_gbn" title="조회조건 선택">
							   <option value="report">보고서</option>
							   <option value="rnd">성과논문</option>
				   </select>
			   </div>
			   
		</div>
		
		<div style="width: 100%; height:450px; float: left; padding:10px; border:1px solid #f0f; border:1px solid #eee; box-shadow:3px 3px 5px rgba(0, 0, 0, 0.2)">
				<div class= "sub_archive_wrap2">				
					<div class="sub_archive_data_wrap"> 	
					   
						<div id ="gridChart"> 
					    </div>
						
				    </div>
			    </div>	  
		</div>  
		</div>
		</div>
		</div>  -->


	
	<!-- 주제분류 PARAM -->
 	<input type="hidden" name="fillterDeptList" id="fillterDeptList" alt="주제분류" />
	<input type="hidden" name="fillterDeptNmList" id="fillterDeptNmList" alt="주제분류" />
	
	<!-- 우측 목록에서 상세 정보로 이동하기 위한 PARAM -->
	<input type="hidden" name="rep_id" id="rep_id" value="" alt="보고서 id" /> 	
	<input type="hidden" name="rnd_id" id="rnd_id" value="" alt="성과논문 id" />

		
	<!-- 추가 PARAM -->
	<input type="hidden" id="messege" name="messege" value="${messege}" alt="message">
 	 
 	<!-- 공통  필수 PARAM -->
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/>
	
	<!-- 리턴 페이지  -->
	<input type="hidden" id="returnPageGbn" name="returnPageGbn"  alt="returnPageGbn">
	
</form>