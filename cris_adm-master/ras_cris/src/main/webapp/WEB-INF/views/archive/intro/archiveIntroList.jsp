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
<link rel="stylesheet" href="${ctxt}/resources/js/chart/jui/jquery-ui.min.css" />
<!-- 차트 구성 SCRIPT END-->


<script type="text/javascript">
var xmlList;
var html="";

var recentlyXmlList;
var topdownXmlList;
var recentlyHtml="";
var topdownHtml="";

var subXmlList;
var subHtml="";


$(function(){
	  
	if($("#messege").val() != ''){
    	fn_alert( $("#messege").val());
    }
    $("#messege").val('');
	
    var page =$('#page').val();
	if(page == '' ){
		page=1;
	}
	// 권한에 따라 화면 view 와 버튼 제어
	var auth_control = $("#archive_auth_gbn").val();	
	
	
	// 최근 등록 자료 조회
	fn_recently_search();
	
	// TOP 다운로드 조회
	fn_topDown_search();

	fn_asub_select();

// 	fn_search();
// 	fn_search2();
	

    $(".tab_content").hide();
    $(".tab_content:first").show();

    
    $("ul.tabs li").eq(0).addClass("active").css("color", "#003964");
    $("ul.tabs li").click(function () {
        $("ul.tabs li").removeClass("active").css("color", "#7f7f7f");       
        $(this).addClass("active").css("color", "#003964");
        $(".tab_content").hide()
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn()
    });
});

function fn_page(param , paramRow){
	
	$('#fillterSubjectList_s').val(param);
	$('#fillterSubjectCnt').val(paramRow);
	var form=document.reqForm;
	form.action="${ctxt}/archive/report/reportList.do";
	form.submit();	
}


function fn_right_viewPage(archiveId , paramGbn , returnPage){
	
	var form=document.reqForm;
    	$('#returnPageGbn').val(returnPage);
	
	if(paramGbn == 'report'){
		$('#rep_id').val(archiveId);	
		form.action="${ctxt}/archive/report/reportView.do?upd_yn=Y";
	}else if(paramGbn == 'rnd'){
		$('#rnd_id').val(archiveId);
		form.action="${ctxt}/archive/rnd/rndView.do?upd_yn=Y";
	}
	
	form.submit();
}


/* 아카이브 소개 보고서(발행년도)  */
function fn_search(){
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/

	var params = {};

    $.ajax({
        url: '${ctxt}/archive/intro/archiveIntroRead.do',
        data: params,
        type: 'POST',
        dataType: 'text',
        cache: false,
        success: function(rtnXml) {
        	
        	//차트 초기화
        	$("#gridChart").children().remove();
        	
        	xmlList = $(rtnXml).find('item');
        
			if(xmlList.length > 0){
			
				var archive_list  = new Array();	
				xmlList.each(function(cnt){
					
					var obj = $(this);
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					
					var pubyear = obj.find('pubyear').text(); // 발주부서 code
					var pubyear_cnt = obj.find('pubyear_cnt').text(); // 발주부서명			
					 
					var data = new Object();
					data.quarter = parseInt(pubyear);
					data.count = parseInt(pubyear_cnt);
					
					archive_list.push(data);
		        });
			
			
				var chart = jui.include("chart.builder");
				var jsonData  = JSON.stringify(archive_list);
		
				chart("#gridChart", {
					width : 400,
					height : 300,
					padding : {
						left:30,
						top : 20
					},
				    axis : {				       
				        x : {
				        	type : "block",
				            domain : "quarter",
				            line : true  
				        },
				        y : {
				        	type : "range",
				            domain : function(d) { return  chartMax(d.count); },
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
				    /* 	{ type : "title", text : "Column Sample" }, */
				        { type : "tooltip"}
			     /* 	{ type : "legend" } */
				    ],
				    style:{
				    	backgroundColor: "none"
     				}
				});
			
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				
				$("#bodyInfo").html('<div>조회된 내용이 없습니다.</div>');
			}
        },
        error : function(xmlHttpRequest , textStatus, errorThrown){                              // Ajax 전송 에러 발생시 실행
        	if(xmlHttpRequest.readyState == 0 || xmlHttpRequest.status ==0){        	
        		return;        		
        	}else{
        		 alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        	}        	        
        }
    });
}


/* 아카이브 소개 성과논문(발행년도)  */
function fn_search2(){
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/

	var params = {};

    $.ajax({
        url: '${ctxt}/archive/intro/archiveIntroReadRnd.do',
        data: params,
        type: 'POST',
        dataType: 'text',
        cache: false,
        success: function(rtnXml) {
        	
        	//차트 초기화
        	$("#gridChart2").children().remove();
        	
        	xmlList = $(rtnXml).find('item');
        	
			if(xmlList.length > 0){
			
				var archive_list  = new Array();	
				xmlList.each(function(cnt){
					
					var obj = $(this);
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					
					var pubyear = obj.find('pubyear').text(); // 발주부서 code
					var pubyear_cnt = obj.find('pubyear_cnt').text(); // 발주부서명			
					 
					var data = new Object();
					data.quarter = parseInt(pubyear);
					data.count = parseInt(pubyear_cnt);
					
					archive_list.push(data);
		        });
			
				
				var chart = jui.include("chart.builder");
				var jsonData  = JSON.stringify(archive_list);
				chart("#gridChart2", {
					width : 400,
					height : 300,
					padding : {
						left:30,
						top : 20
					},
				    axis : {				       
				        x : {
				        	type : "block",
				            domain : "quarter",
				            line : true  
				        },
				        y : {
				        	type : "range",
				            domain : function(d)  { return chartMax(d.count); },
				            step : 5,
				            line : true
				        },
				        data : eval(jsonData)
				    },
				    brush : {
				        type : "column",
				        size : 20,
				        target : [ "count" ]
// 				        ,colors : function(data) {
// 				        	for(var i=0; i<colorCode.length; i++){
// 				        		alert(colorCode[i]); 
// 				        		return colorCode[i];
// 				        	}
// 				        }
				    },
				    widget : [
				        { type : "tooltip"}
				    ],
				    style:{
				    	backgroundColor: "none"
     				}
				});
			  
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$("#bodyInfo").html('<div>조회된 내용이 없습니다.</div>');
			}
        },
        error : function(xmlHttpRequest , textStatus, errorThrown){                              // Ajax 전송 에러 발생시 실행
        	if(xmlHttpRequest.readyState == 0 || xmlHttpRequest.status ==0){        	
        		return;        		
        	}else{
        		 alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        	}        	        
        }
    });
}


function cutByLen(str, maxByte) {

	for(b=i=0;c=str.charCodeAt(i);) {

	b+=c>>7?2:1;

	if (b > maxByte)

	break;

	i++;

	}

	return str.substring(0,i);

}




// 최근 등록 자료를 조회한다.
function fn_recently_search(){

	var params = {};

    $.ajax({
        url: '${ctxt}/archive/intro/archiveIntroRecentlyRead.do',
        data: params,
        type: 'POST',
        dataType: 'text',
        cache: false,
        success: function(rtnXml) {
   
        	recentlyXmlList = $(rtnXml).find('item');
        	
        	recentlyHtml="";    
        	
			if(recentlyXmlList.length > 0){

				recentlyXmlList.each(function(cnt){			
					
					var obj = $(this);
					var dataGbn = '';
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/					
					var archive_id = obj.find('archive_id').text(); // ID
					var archive_sj = obj.find('archive_sj').text(); // 제목
					var archive_gbn = obj.find('archive_gbn').text(); // 제목
										 
					recentlyHtml += "<li>";	
					
					if(archive_gbn == '1'){
						dataGbn = "report";
						recentlyHtml += '<span class = "a0" title = "">보고서</span> &nbsp;&nbsp;'; 	
					}else if(archive_gbn == '2'){
						dataGbn = "rnd";
						recentlyHtml += '<span class = "a0" title = ""><span class="letter2">논</span>문</span> &nbsp;&nbsp;'; 	
					}				
								    
					recentlyHtml += '<span class="t1" title = "Recently Added Items">';
					
					if(byteCheck2(archive_sj) > 43){
						recentlyHtml += '<a href="javascript:fn_right_viewPage(\''+archive_id+'\',\''+dataGbn+'\',\'aMain\')">'+cutByLen(archive_sj,43)+'...'+'</a>';	
					}else{
						recentlyHtml += '<a href="javascript:fn_right_viewPage(\''+archive_id+'\',\''+dataGbn+'\',\'aMain\')">'+cutByLen(archive_sj,43)+'</a>';
					}
					
					recentlyHtml += '</span>';  
					recentlyHtml += '</li>';
					
		        });
							
			    $("#recently_list").html(recentlyHtml);
			  
				
			}else{
				// 존재 하지 않으면 더보기만 나오도록.
				
				$("#recently_list").html('<li><span class="t1" title = "최근 자료 없음">조회된 내용이 없습니다.</span></li>');
			   
			}
        },
        error : function(xmlHttpRequest , textStatus, errorThrown){                              // Ajax 전송 에러 발생시 실행
        	if(xmlHttpRequest.readyState == 0 || xmlHttpRequest.status ==0){        	
        		return;        		
        	}else{
        		 alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        	}        	        
        }
    });
}


// top 다운로드 수를 구성한다.
function fn_topDown_search(){

	var params = {};
	
	$.ajax({
	    url: '${ctxt}/archive/intro/archiveIntroTopDownRead.do',
	    data: params,
	    type: 'POST',
	    dataType: 'text',
	    cache: false,
	    success: function(rtnXml) {
	
	    	topdownXmlList = $(rtnXml).find('item');
	    	
	    	topdownHtml = "";    
	    	
			if(topdownXmlList.length > 0){
	
				topdownXmlList.each(function(cnt){			
					
					var obj = $(this);
					
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/					
					var archive_id = obj.find('archive_id').text(); // ID
					var archive_sj = obj.find('archive_sj').text(); // 제목
					var archive_gbn = obj.find('archive_gbn').text(); // 제목
					 
					topdownHtml += "<li>";	
					if(archive_gbn == '1'){
						dataGbn = "report";
						topdownHtml += '<span class = "a0" title = "">보고서</span> &nbsp;&nbsp;'; 	
					}else if(archive_gbn == '2'){
						dataGbn = "rnd";
						topdownHtml += '<span class = "a0" title = ""><span><span class="letter2">논</span>문</span> &nbsp;&nbsp;'; 	
					}
					
								
					topdownHtml += '<span class="t1" title = "Top Downloads">';

					if(byteCheck2(archive_sj) > 48){
						topdownHtml += '<a href="javascript:fn_right_viewPage(\''+archive_id+'\',\''+dataGbn+'\',\'aMain\')">'+cutByLen(archive_sj,48)+'...'+'</a>';	
					}else{
						topdownHtml += '<a href="javascript:fn_right_viewPage(\''+archive_id+'\',\''+dataGbn+'\',\'aMain\')">'+cutByLen(archive_sj,48)+'</a>';	
					}
					
					topdownHtml += '</span>';
					topdownHtml += '</li>';    

		        });
							
			    $("#topDown_list").html(topdownHtml);
			  
				
			}else{
				// 존재 하지 않으면 더보기만 나오도록.
				
				$("#topDown_list").html('<li><span class="t1" title = "자료 없음">조회된 내용이 없습니다.</span></li>');
			   
			}
	    },
	    error : function(xmlHttpRequest , textStatus, errorThrown){                              // Ajax 전송 에러 발생시 실행
        	if(xmlHttpRequest.readyState == 0 || xmlHttpRequest.status ==0){        	
        		return;        		
        	}else{
        		 alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        	}        	        
        }
	});
}


//최근 등록 자료를 조회한다.
function fn_asub_select(){

	var params = {};
	
 $.ajax({
     url: '${ctxt}/archive/intro/archiveIntroAsubList.do',
     data: params,
     type: 'POST',
     dataType: 'text',
     cache: false,
     success: function(rtnXml) {

    	 subXmlList = $(rtnXml).find('item');
     	
    	 subHtml="";    
     	
			if(subXmlList.length > 0){

				subXmlList.each(function(cnt){			
					
					var obj = $(this);
					var dataGbn = '';
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/	
					var subject_cd = obj.find('subject_cd').text(); // 코드
					var subject = obj.find('subject').text(); // 이름
					var subRow = obj.find('subrow').text(); // 선택된 row  
					var subject_cnt = obj.find('subject_cnt').text(); // cnt
			
										 
					/* subHtml += "<li class='hover'><a href='javascript:fn_page(\""+subject_cd+"\",\""+subRow+"\")' >" + subject +"("+subject_cnt+")<a class='more_button' style='color:#fff; font-size:0.1em; line-height:20px;' href='#'>▶</a></li>"; */
				
					
					
					
				    
		               subHtml += "<li class='hover'>";
		               
		               if(subject_cd == 'ASUB_01'){       // 1.의생명과학
		                  subHtml += "<img src = '${ctxt}/resources/images/sub/archive_icon1.png' />";
		               }else if(subject_cd == 'ASUB_02'){  //2.임상의학
		                  subHtml += "<img src = '${ctxt}/resources/images/sub/archive_icon2.png' />";
		               }else if(subject_cd == 'ASUB_03'){  //3.의약품/의약품개발
		                  subHtml += "<img src = '${ctxt}/resources/images/sub/archive_icon3.png' />";
		               }else if(subject_cd == 'ASUB_04'){  //4.치료/진단기기
		                  subHtml += "<img src = '${ctxt}/resources/images/sub/archive_icon4.png' />";
		               }else if(subject_cd == 'ASUB_05'){  //5.의료정보/시스템
		                  subHtml += "<img src = '${ctxt}/resources/images/sub/archive_icon5.png' />";
		               }else if(subject_cd == 'ASUB_06'){  // 6.보건학
		                  subHtml += "<img src = '${ctxt}/resources/images/sub/archive_icon6.png' />";
		               }else if(subject_cd == 'ASUB_07'){  //7.간호과학
		                  subHtml += "<img src = '${ctxt}/resources/images/sub/archive_icon7.png' />";
		               }else if(subject_cd == 'ASUB_08'){  //8.영양관리
		                  subHtml += "<img src = '${ctxt}/resources/images/sub/archive_icon8.png' />";
		               }else if(subject_cd == 'ASUB_09'){  //9.독성/안전성 관리기반 기술
		                  subHtml += "<img src = '${ctxt}/resources/images/sub/archive_icon9.png' />";
		               }else if(subject_cd == 'ASUB_10'){  //10.기타 보건의료
		                  subHtml += "<img src = '${ctxt}/resources/images/sub/archive_icon10.png' />";
		               }else{
		                  subHtml += "<img src = '${ctxt}/resources/images/sub/archive_icon10.png' />";
		               }
		               
		               subHtml += "<a class='archive_list_name' href='javascript:fn_page(\""+subject_cd+"\",\""+subRow+"\")' >" + subject +"("+subject_cnt+")";
		               subHtml += "<a class='more_button' style='color:#fff; font-size:smaller; line-height:20px;' href='#'>▶</a>";
		               subHtml += "</li>";
					
		        });
							
			    $("#subInfo").html(subHtml);
			  
				
			}else{
				// 존재 하지 않으면 더보기만 나오도록.
				
				$("#recently_list").html('<li><span class="t1" title = "최근 자료 없음">조회된 내용이 없습니다.</span></li>');
			   
			}
     },
     error : function(xmlHttpRequest , textStatus, errorThrown){                              // Ajax 전송 에러 발생시 실행
     	if(xmlHttpRequest.readyState == 0 || xmlHttpRequest.status ==0){        	
     		return;        		
     	}else{
     		 alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
     	}        	        
     }
 });
}
function fn_recentlyPage(){   
	var form=document.reqForm;
	form.action="${ctxt}/archive/intro/archiveRecentlyList.do";
	form.submit();	
}

function fn_topDownloadPage(){
	var form=document.reqForm;
	form.action="${ctxt}/archive/intro/archiveTopDownloadList.do";
	form.submit();
}


</script>
<style>
.content_box>.content_list ul{
	width:-webkit-fill-available;
}
.sub_archive_wrap p.text_box{
	line-height:160%;
	padding-top:5px;
}
.sub_archive_wrap2 {
	margin-top:40px;
}
#subInfo > li{
	margin-top:6px;
}
.flist li{
	width:100%;
	overflow:hidden;
}
.flist li>span:first-child{
	width:20%;
}
.a0 .letter2{
	letter-spacing:13px;
}
.flist li>span:last-child{
	width: 80%;
	max-width:328px;
}
.left_box{
	height:520px;
}
@media (max-width: 768px){
	.left_box{
		height:auto;
	}
}
</style>

<form name="reqForm" method="post">
	
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>아카이브</span>
			<span> > </span>
			<span class="active">아카이브 소개</span>        
		</div>
		<span class="center_text_01" >아카이브 소개</span>
	</div> 
			
	<div class="under_bar"></div>
			
	
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div class="left_box">
					<div class="sub_archive_wrap" style="width:96%; margin:0 auto;">				
						<p class="text_box">국가 보건의료 분야의 레포지터리입니다.<br> 
						연구 결과물에 대한 연구성과 활용을 목적으로 운영하고 있으며
						보건의료<br>분야에서 생산되는 <span class="emphasize">보고서, 논문 등을 수집·보존하여 서비스</span>
						를 제공하고 있습니다.</p>			
					</div>
					<!--  <div class="under_bar3" style="border-top:1px solid #fff;margin-bottom:10px;"></div> -->
					<div class= "sub_archive_wrap2">				
						<div class="sub_archive_data_wrap"> 	
						
							<div class="tabContainer" style="margin:20px 0;"> 
								<ul class="tabs">
							        <li class="active" rel="tab1" style="width:33.333333333333333333333333333333%; box-sizing:border-box; color:#003964;">주제분류</li>
							        <li rel="tab2" style="width:33.333333333333333333333333333333%; box-sizing:border-box;" onclick="fn_search();">보고서 현황</li>
							  		<!-- 성과논문 임시 숨김 display:none-->
							        <li rel="tab3" style="width:33.333333333333333333333333333333%; box-sizing:border-box; display: none;" onclick="fn_search2();">성과논문 현황</li>					    
								</ul>
							    <div class="tab_container" style="width:100%; box-sizing:border-box;">
							        <div id="tab1" class="tab_content">
							        	<ul id = subInfo>
							        	</ul>							            
							        </div>
							     
							        <div id="tab2" class="tab_content">							        
						            	<div id ="gridChart" class="right"> <!-- style="width: 400px; height: 400px"> -->
										</div>
							        </div>
							      
							        
							        <div id="tab3" class="tab_content">
						            	<div id ="gridChart2" class="right"> <!-- style="width: 400px; height: 400px"> -->
										</div>
							        </div>
							      
								</div>
							</div>				 
					    </div>
				    </div>
				</div>
	
				
				<!--검색제한-->
				<div id="sidebar-right2" style="height:542px;">
					<div class = "sideArea" style="height:237px;">
						<div class="sidebar-right-text2">
							<span  style="vertical-align: middle">최신자료  <a class="more" href="javascript:fn_recentlyPage()">more +</a> </span>	
						</div>
						<div class="under_bar3"></div>
						<div style="width : 100%;  height: auto; margin-bottom:7px;">
							<ul id="recently_list" class="flist">				
							</ul>
						</div>
					</div>
					<div class = "sideArea" style="margin-bottom:0;height:237px;">
						<div class="sidebar-right-text2">
							<span  style="vertical-align: middle">인기자료	 <a class="more"  href="javascript:fn_topDownloadPage()"> more +</a> </span>
						</div>
							<div class="under_bar3"></div>
						<div style="width : 100%;  height: auto; margin-bottom:7px;">
							<ul id="topDown_list" class="flist">			
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
	
	
	<!-- 목록화면에 주제분류 PARAM과 필터 열린 갯수를 셋팅해주기위해 -->
 	<input type="hidden" name="fillterSubjectList_s" id="fillterSubjectList_s" alt="주제분류date" />
	<input type="hidden" name="fillterSubjectCnt" id="fillterSubjectCnt" alt="주제분류row" />
	
	<!-- 우측 목록에서 상세 정보로 이동하기 위한 PARAM -->
	<input type="hidden" name="rep_id" id="rep_id" value="" alt="보고서 id" /> 	
	<input type="hidden" name="rnd_id" id="rnd_id" value="" alt="성과논문 id" />

		
	<!-- 추가 PARAM -->
	<input type="hidden" id="messege" name="messege" value="${messege}" alt="message">
 	 
 	<!-- 공통  필수 PARAM -->
 	<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/> --%>
	
	<!-- 리턴 페이지  -->
	<input type="hidden" id="returnPageGbn" name="returnPageGbn"  alt="returnPageGbn">

</form>