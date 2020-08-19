<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

  
<script type="text/javascript">
  
var xmlList;
var html="";

var rXmlList;
var yearHtml="";
var deptHtml="";
var subjectHtml="";

var cuurPage;
var pageTotalCnt = 0;
var dataTotalCnt = 0;

var fillterYearList=""; // 발행연도 필터조건 담기위한 param
var fillterDeptList=""; // 연구비지원기관 필터조건 담기위한 param
var fillterSubjectList=""; // 주제분류 필터조건 담기위한 param

// 검색결과제한 controll
//추후 5개로 변경
var initFillter  = 3 ;  // 최초 보여줄 갯수
var cntYear = 2;
var cntDept = 2;
var cntSubject = 2;

var resultYear = 3; //최초 보여줄 갯수(parameter)
var resultDept = 3; //최초 보여줄 갯수(parameter)
var resultSubject = 3; //최초 보여줄 갯수(parameter)


$(function(){
	
	if($("#message").val() != ''){
		var msg = $("#message").val();
	
			alert(msg);
	
    }
    $("#message").val('');
	
    var page =$('#page').val();
	if(page == '' ){
		page=1;
	}
	
	var searchOption = $("#searchOption").val();  
	if(searchOption != '' ){
		$('#searchCondition option[value='+searchOption+']').attr('selected',true);
	}	 

	// 화면 목록 조회
	fn_rightMenu();
	//fn_fillterControll(initParam);  // 필터 초기화
	

	fn_search(page);

	$('.sub_select').bind('change',function(){fn_search(1)});
		
});  
  

function fn_tt(){
	var params = {};

	$.ajax({
		url : "<c:url value='/archive/report/testList.do'/>",
		data : params,
		type : 'post',
		dataType : 'json',
		success : function(data) {	
			if(data.result){
				try{
					// 함수 구현
					alert("1");
				}catch(err){
					alert('삭제처리 중 오류가 발생하였습니다.');
				}
				
			} else {
				alert(data.resultMsg);
			}
			
		},
		error: function(request,status,error) {
			//win = window.open('http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi'); 
			//win.close(); 

			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
		
	}); 
}

function fn_page(param){
	
	$("#fillterYearCnt").val($("input:checkbox[name=fillterYear]").length);
	$("#fillterDeptCnt").val($("input:checkbox[name=fillterDept]").length);
	$("#fillterSubjectCnt").val($("input:checkbox[name=fillterSubject]").length);
	
	$('#rep_id').val(param);
	var form=document.reqForm;
	form.action="${ctxt}/archive/report/reportView.do?upd_yn=Y";
	form.submit();
	
}

function fn_linkPage(){
	alert("원문정보");
}

/* 보고서 목록 조회  */
function fn_search(page){
	
	fillterYearList=""; // 발행연도 필터조건 담기위한 param
	fillterDeptList=""; // 연구비지원기관 필터조건 담기위한 param
	fillterSubjectList=""; // 주제분류 필터조건 담기위한 param
	
	fillterDeptKor = "";  // 연구비지원기관은 코드값이 한글이라서 따로 별도 셋팅 해준다.
	
	//현재 페이지 세팅
	cuurPage= page;
	$('#page').val(cuurPage);
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/
	
	// 필터 조건 리스트 
	
	$("input[name=fillterYear]:checked").each(function() {
		fillterYearList += $(this).val() + ",";
	});

	$("input[name=fillterDept]:checked").each(function() {
		fillterDeptList += $(this).val() + ",";
		fillterDeptKor += $(this).attr("id")+ ",";
		
	});
	
	$("input[name=fillterSubject]:checked").each(function() {
		fillterSubjectList += $(this).val() + ",";
	});
   
	var params = {};
  		params.page=cuurPage;
		params.orderBy = $('#orderBy :checked').val();
		params.pageSize =  $("#selectbox1 option:selected").val();
		
		params.fillterYearList = fillterYearList.substring(0 ,fillterYearList.length-1);
		params.fillterDeptList = fillterDeptList.substring(0 ,fillterDeptList.length-1);
		params.fillterSubjectList = fillterSubjectList.substring(0 ,fillterSubjectList.length-1);

		$("#fillterYearList_s").val(fillterYearList.substring(0 ,fillterYearList.length-1));
		$("#fillterDeptList_s").val(fillterDeptKor.substring(0 ,fillterDeptKor.length-1));
		$("#fillterSubjectList_s").val(fillterSubjectList.substring(0 ,fillterSubjectList.length-1));
		
		params.searchKeyword = $('#searchKeyword').val();
		params.searchCondition = $('#searchCondition option:selected').val(); 
	
	
    $.ajax({
        url: '${ctxt}/archive/report/reportRead.do',
        data: params,
        type: 'POST',
        dataType: 'text',
        async: false, 
        cache: false,
        success: function(rtnXml) {
   
        	xmlList = $(rtnXml).find('item');

        	pageTotalCnt=0;
        	dataTotalCnt=0;
        	
        	html="";
			if(xmlList.length > 0){
				//총페이지수
				pageTotalCnt = Number($(rtnXml).find('totalPageCnt').text());
				dataTotalCnt = Number($(rtnXml).find('totalDataCnt').text());
				$('#topCnt').html("("+dataTotalCnt+"건)");				
				xmlList.each(function(cnt){
			
					var obj = $(this);
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					var proj ="";					
					var rep_id = obj.find('rep_id').text(); // 보고서 id										
					var proj_tit_kor = obj.find('proj_tit_kor').text(); // 연구과제명_국문
					var proj_tit_eng = obj.find('proj_tit_eng').text(); // 연구과제명_영문
					var pi = obj.find('pi').text();   // 연구 책임자
					var org_name = obj.find('org_name').text();   // 주관연구기관					
				
					var order_dept= obj.find('order_dept').text();   // 연구비지원기관
					var order_dept_nm= obj.find('order_dept_nm').text();   // 연구비지원기관
					var pubyear = obj.find('pubyear').text();   // 기준연도
					var order_sn = obj.find('order_sn').text();   // 정렬순서
					var atch_link_id = obj.find('atch_link_id').text();   // 정렬순서

					//보고서 과제명
					if(proj_tit_kor != ""){
						proj = proj_tit_kor;
					}else{
						proj = proj_tit_eng;
					}
					
				
						
					
				
					html += '<div class="dtl_list"  id="data_'+cnt+'" style="padding-bottom:7px;" >';
						// html += ' <input id="option" type="checkbox" name="field" value="option">';
				    html += '<label for="option"><span><span></span></span></label>';
				    html += '<div style = "display:inline;overflow:visible;margin-top:3px;"><input type="checkbox" class= "option" name="chk_mylib" value=\''+rep_id+'\'></div>';
				    //html += '<div style = "display:inline;overflow:visible;clear:both;margin-left:43px;">'+(dataTotalCnt  - (order_sn -1))+'. </div>';	
					html += '<div style = "margin-left:28px;">';
		
					html +=	'<ul>';
				//	html +=	  '<li class="sub_center_cont_text"> <span>' + (dataTotalCnt  - (order_sn -1)) + '&nbsp;&nbsp;&nbsp;&nbsp;</span><a href="javascript:fn_page(\''+rep_id+'\')" >'+proj+'</a></li>';
				
					html +=	  '<li class="sub_center_cont_text"><a href="javascript:fn_page(\''+rep_id+'\')" >'+proj+'</a></li>';
				    
					html +=	  '<li class="sub_center_cont_text02" style="letter-spacing:-0.7px;"><span class="text02_1">연구책임자 : '+pi+'</span>&nbsp;&nbsp;|&nbsp;&nbsp;<span class="text02_1"> 주관연구기관 : '+org_name+'</span>&nbsp;&nbsp;|&nbsp;&nbsp;<span class="text02_1">연구비지원기관  : ' +order_dept + '</span> &nbsp;&nbsp;|&nbsp;&nbsp;<span class="text02_1">발행년도 : '+pubyear+'</span></li>';      			
					html +=	  '<li class="sub_center_cont_text02">';
					html +=	  '<a class="a_btn" href="javascript:fileView(\''+atch_link_id+'\',\''+proj+'\',\''+rep_id+'\');">원문정보</a>&nbsp;&nbsp;&nbsp;<a class="a_btn" href="javascript:fn_selMyLib(\''+rep_id+'\');">내서재담기</a></li>';
					html +=	 '</ul>';
					html += '</div>';
					html += '</div>';   
		        });
				//페이징처리
			    $('#paging').paging({
			    	
					 current:cuurPage
					,max:pageTotalCnt
					,length:pageLen
					,onclick:function(e,page){
						cuurPage=page;
						
						// 페이지 이동시 PARAM 초기화
						//$("#searchKeyword").val("");
						//$("#searchCondition").val("ALL");
						
						fn_search(cuurPage);
					}
				});
				//$("#topInfo").html("<strong>["+ cuurPage +" / "+pageTotalCnt+" Pages] <span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.</strong>");
			    $("#bodyInfo").html(html);


			    fn_rightMenu();
			    
			    //if($("#searchKeyword").val() != ''){
			    	//$("#search_cn").html($("#searchKeyword").val());
			    //}else{
// 			    	$("#search_cn").html("보고서("+dataTotalCnt+"건)");
			    //}
			  
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$('#paging').children().remove();
				
				$("#bodyInfo").html('<div>조회된 내용이 없습니다.</div>');
				fn_rightMenu();
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
} 

// 우측 검색 결과 제한을 구성한다.
function fn_rightMenu(param){
	
	var plusYear = 0;
	var plusDept = 0;
	var plusSubject = 0;
	
	if($("#fillterYearCnt").val() != ''){
		resultYear = $("#fillterYearCnt").val();
		plusYear = resultYear;	
		$("#fillterYearCnt").val("");
	}
	if($("#fillterDeptCnt").val() != ''){
		resultDept = $("#fillterDeptCnt").val();
		plusDept = resultDept;	
		$("#fillterDeptCnt").val("");
	}
	
	if($("#fillterSubjectCnt").val() != ''){
		resultSubject = $("#fillterSubjectCnt").val();
		if(resultSubject < 3 ){ // 소개 페이지 넘어왔을때 row 갯수가 1 or 2 넘어왔을때 , 기본 3개를 열어준다
			resultSubject = 3;
		}
		plusSubject = resultSubject;	
		$("#fillterSubjectCnt").val("");
	}

	// 검색결과 제한의 더보기 구성을 위한 param
	if (param == 'year'){
		resultYear = (initFillter * cntYear) + plusYear;	
		cntYear++;
	}else if(param == 'dept'){
		resultDept = (initFillter * cntDept) + plusDept;
		cntDept++;
	}else if(param == 'subject'){	
		resultSubject = (initFillter * cntSubject) + plusSubject;  
		cntSubject++;
	}
	
	var params = {};
  		params.fillterYear = resultYear;
  		params.fillterDept = resultDept;
  		params.fillterSubject = resultSubject;
  		params.searchKeyword = $('#searchKeyword').val();
		params.searchCondition = $('#searchCondition option:selected').val(); 
		
    $.ajax({
        url: '${ctxt}/archive/report/reportRightMenuRead.do',
        data: params,
        type: 'POST',
        dataType: 'text',
        async: false,   // 다완료 되고 가야한다.
        cache: false,
        success: function(rtnXml) {
   
        	rXmlList = $(rtnXml).find('item');
        	
        	yearHtml="";
        	deptHtml="";
        	subjectHtml="";
        	
			if(rXmlList.length > 0){

				rXmlList.each(function(cnt){			
					
					var obj = $(this);
					
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/					
					var fillter_code = obj.find('fillter_code').text(); // code
					var fillter_name = obj.find('fillter_data').text(); // name
					var fillter_cnt = obj.find('fillter_cnt').text(); // 갯수
					var fillter_gbn = obj.find('fillter_gbn').text(); // 구분					 
					
					if(fillter_gbn == 'YEAR'){
						if(fillter_name != 0){
							yearHtml += '<li><input type="checkbox" id =  "'+fillter_code+'" name = "fillterYear" onclick = "fn_fillterSearch()" value = "'+fillter_code+'"></input><label for = "'+fillter_code+'" >'+fillter_name+'(' + fillter_cnt + ')'+'</label></li>';																		
						}
					}else if(fillter_gbn == 'DEPT'){
							var fillterDeptChk = "";
							fillterDeptChk = regExp_test(fillter_code);
							deptHtml += '<li><input type="checkbox" id =  "'+fillterDeptChk+'" name = "fillterDept" onclick = "fn_fillterSearch()" value = "'+fillter_code+'"></input><label for = "'+fillterDeptChk+'" >'+fillter_name+'(' + fillter_cnt + ')'+'</label></li>';
					}else if(fillter_gbn == 'SUBJECT'){			
							subjectHtml += '<li><input type="checkbox" id =  "'+fillter_code+'" name = "fillterSubject" onclick = "fn_fillterSearch()" value = "'+fillter_code+'"></input><label for = "'+fillter_code+'" >'+fillter_name+'(' + fillter_cnt + ')'+'</label></li>';
													
					}
					
		        });
					
				yearHtml += '<li><a class="more_btn2" href="javascript:fn_rightMenu(\'year\')" >더보기</a></li>';	
				deptHtml += '<li><a class="more_btn2" href="javascript:fn_rightMenu(\'dept\')" >더보기</a></li>';
				subjectHtml += '<li><a class="more_btn2" href="javascript:fn_rightMenu(\'subject\')" >더보기</a></li>';
				
			    $("#fillter_year").html(yearHtml);
			    $("#fillter_dept").html(deptHtml);
			    $("#fillter_subject").html(subjectHtml);
  
				// 더보기 할때 기존의 checkBox를 살려주기 위해
				// 발행연도
			    var splitYear = $("#fillterYearList_s").val().split(",");
				for(var i in splitYear){
					var val = splitYear[i];
					var chkId = $("#"+val).attr("id");
					$("#"+chkId).prop('checked', true);
				}			
				//연구비지원기관
			    var splitDept = $("#fillterDeptList_s").val().split(",");
				
				for(var i in splitDept){
					var val = splitDept[i];
					var chkId = $("#"+val).attr("id");
					$("#"+chkId).prop('checked', true);
				}
				//주제분류
			    var splitSubject = $("#fillterSubjectList_s").val().split(",");
				for(var i in splitSubject){
					var val = splitSubject[i];
					var chkId = $("#"+val).attr("id");
					$("#"+chkId).prop('checked', true);
				}
				
			}else{
				// 존재 하지 않으면 더보기만 나오도록.
				
				yearHtml += '<li><a class="more_btn2" href="#" >더보기</a></li>';	
				deptHtml += '<li><a class="more_btn2" href="#" >더보기</a></li>';
				subjectHtml += '<li><a class="more_btn2" href="#" >더보기</a></li>';
				
			    $("#fillter_year").html(yearHtml);
			    $("#fillter_dept").html(deptHtml);
			    $("#fillter_subject").html(subjectHtml);
			   
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}

function fn_fillterSearch(){
	//$("#search_cn").html("보고서");
	fn_search(1);

	
}

// 초기화
// 필터는 최초 3개 까지만 보여준다. 추후 5개로 변경  
// 발행연도, 부서, 언어 
// param = "init : 최초 로딩"
function fn_fillterControll(param)
{

	 // 파라미터 초기화 
	 cntYear = 2;
	 cntDept = 2;
	 cntSubject = 2;
	 resultYear = 3; //최초 보여줄 갯수(parameter)
     resultDept = 3; //최초 보여줄 갯수(parameter)
     resultSubject = 3; //최초 보여줄 갯수(parameter)
	 
     // checkBox  모두 초기화
     $("input[name=fillterYear]").prop("checked", false);
     $("input[name=fillterDept]").prop("checked", false);
     $("input[name=fillterSubject]").prop("checked", false);
   
	 $("#fillterYearList_s").val("");
	 $("#fillterDeptList_s").val("");
	 $("#fillterSubjectList_s").val("");
	

	 // 검색결과제한 필터 초기화
    $("#fillter_year").children().each(function(idx){	  
		if(idx >= initFillter &&  parseInt($("#fillter_year").children().size())-1  != idx ){
		    $("#fillter_year").children().eq(idx).hide();		  
		}else{
		    $("#fillter_year").children().eq(idx).show();
		}
	 });  
    $("#fillter_dept").children().each(function(idx){
	    if(idx >= initFillter &&  parseInt($("#fillter_dept").children().size())-1  != idx ){
		    $("#fillter_dept").children().eq(idx).hide();		  
	    }else{
		    $("#fillter_dept").children().eq(idx).show();
	    }
	 });    
    $("#fillter_subject").children().each(function(idx){
	    if(idx >= initFillter &&  parseInt($("#fillter_subject").children().size())-1  != idx ){
		    $("#fillter_subject").children().eq(idx).hide();		  
	    }else{
		    $("#fillter_subject").children().eq(idx).show();
	    }
	 });  
	
	
	
	$("#accordionMenu1 > li").attr("data-extension","open");
	$(".main-title > span").attr("class" , "folder open");
	$("#fillter_year").attr("style" , "margin-top : 0px;");
	$("#fillter_dept").attr("style" , "margin-top : 0px;");
	$("#fillter_subject").attr("style" , "margin-top : 0px;");
	
	//재검색
	if(param != 'init'){
		fn_search(1);
	}
	  
}
  
  

/**
 * 내서재담기 row
 */
function fn_selMyLib(rep_id) {
	
 	if ("${userVo.emplyrnm}" == "") {
		if (confirm("내서재 담기 기능을 선택하실 경우 로그인 하셔야합니다.\n로그인 화면으로 이동하시겠습니까?")) {
			location.href = "${ctxt}/login/user/login.do?returnURL=/archive/report/reportList.do";
			return;
		} else {
			return;
		}
	} 
 	var params = {};
	params.key = rep_id;
	params.gbn = "report";
	
	$.ajax({
		url : "<c:url value='/mylib/lib/multiMylibSave.do'/>",
		data : params,
		type : 'post',
		dataType : 'json',
		success : function(data) {
			if(confirm("선택하신 총 1건 중\n내 서재 담기에 성공한 건수: "+data.sucCnt+"건\n이미 내 서재에 등록된 건수(내 서재 담기에 실패한 건수): "+data.dupCnt+"건 \n입니다.\n\n※ 내 서재 화면으로 이동하시겠습니까?")){
				location.href="<c:url value='/mylib/lib/listMyLib.do'/>";
				return;
			}else{
				return;
			}
		}
	}); 
}

/**
 * 내서재담기 multi
 */
function selMultiMyLib() {
	var chk_mylib_cnt = 0;
	var mylibChk = "";
 	if ("${userVo.emplyrnm}" == "") {
		if (confirm("내서재 담기 기능을 선택하실 경우 로그인 하셔야합니다.\n로그인 화면으로 이동하시겠습니까?")) {
			location.href = "${ctxt}/login/user/login.do?returnURL=/archive/report/reportList.do";//?searchCondition="+$('#searchCondition option:selected').val()+"&searchKeyword="+$('#searchKeyword').val();
			return;
		} else {
			return;
		}
	} 
 	
	$("input[name=chk_mylib]:checked").each(function() {
		mylibChk += $(this).val() + ",";
	
		if(mylibChk != "" ){
			chk_mylib_cnt++;	
		}
		
	});

	var params = {};
	params.key = mylibChk.substring(0 ,mylibChk.length-1);
	params.gbn = "report";

	$.ajax({
		url : "<c:url value='/mylib/lib/multiMylibSave.do'/>",
		data : params,
		type : 'get',
		dataType : 'json',
		success : function(data) {	
	
			if(confirm("선택하신 총 "+chk_mylib_cnt+"건 중\n내 서재 담기에 성공한 건수: "+data.sucCnt+"건\n이미 내 서재에 등록된 건수(내 서재 담기에 실패한 건수): "+data.dupCnt+"건 \n입니다.\n\n※ 내 서재 화면으로 이동하시겠습니까?")){
				location.href="<c:url value='/mylib/lib/listMyLib.do'/>";
				return;
			}else{
			
				 $("input[name=chk_mylib]").prop("checked", false);
				
				return;
			}
		}
	}); 
}


function fileView(atch_link_id, proj , idVal) {
	
	var atchLinkId = atch_link_id
	
	var contextName = "ncmik";
	var fileKey = atchLinkId;
	var pageTitle = proj;	
	var rep_id = idVal;
	
	if(atch_link_id == "" || atch_link_id == null ){
		alert("원문정보가 존재 하지 않습니다.");	
		
		return;
	}
	
	fn_downloadUpdate(fileKey, contextName, pageTitle , rep_id , 'report');
}
function regExp_test(str){
    //함수를 호출하여 특수문자 검증 시작.
  
    var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
   
    
    return str.replace(regExp, "").replace(" " ,"");
 
}

</script>
<style>
.order-basic-btn{
	position:absolute; text-decoration:none; right:0; bottom:0;
}
.selectbox_wrap{
	height:38px; position:relative; margin:0; padding-top:0; margin-top: 3px;
}
#searchCondition{
	min-width: 110px;
}




.center_radio_03, .center_text_03/* , #orderBy */ {
    margin-top: 0px;
    height: 38px;
    line-height: 38px;
} 
.center_radio_03, .center_text_03, #selectbox1 {
    margin-top: 0px;
    height: 38px;
    line-height: 38px;
}
.center_text_02{
	padding-left:30px;
}
#library1{
	margin-top:5px;
}
#search-group.sub{
	margin-top:0;
}
#orderBy, #selectbox1{
  margin-top: 5px;
  border: 1px solid #ddd;
  width: 80px;
  height: 25px;
  line-height:25px;
  letter-spacing: 0.5px;
  border-radius: 0;
  color: #003964; 
  -webkit-appearance: none; 
  background:  url(${ctxt}/resources/images/sub/sub_op.PNG) 60px center no-repeat; /* 화살표 이미지 */
  background-size:7px auto;
  font-size: 12px;
  padding:0 10px;
  text-align:center;
  box-sizing:border-box;
}
#selectbox1{
	width: 60px;
	background:  url(${ctxt}/resources/images/sub/sub_op.PNG) 40px center no-repeat; /* 화살표 이미지 */
  	background-size:7px auto;
}
.bibliography{
	display:inline-block;
}
@media all and (max-width:1015px) {
	.center_radio_03 {
	    margin-left: 15px;
	}
}
@media all and (max-width:645px) {
	.content_box>.content_list{
		padding:20px;
	}
}
.sub_center_cont_text {
    margin-bottom: 7px;
}

@media all and (max-width:600px) {
	.order-basic-btn{
		position:relative;
	}
	.selectbox_wrap {
	    width: 280px;
	    left:auto;
	    margin:0 auto;
	    transform: translate(0,0);
	    -o-transform: translate(0,0);
	    -ms-transform: translate(0,0);
	    -moz-transform: translate(0,0);
	    -webkit-transform: translate(0,0);
	}  
	.center_text_02 {
    	padding-left: 15px;
	}
	.order-basic-btn{
		line-height: 30px;
		min-width: 40px;
		font-size: 13px;
		min-height: 30px;
	    margin-top: 3px;
	    width: 50px;
	}
	#search-group {
	    right: 0;
	    left: 50%;
	    width: 100%;
	    transform: translate(-50%, 0);
	    -o-transform: translate(-50%, 0);
	    -ms-transform: translate(-50%, 0);
	    -moz-transform: translate(-50%, 0);
	    -webkit-transform: translate(-50%, 0);
	    text-align: center;
	    transition: all 0.3s;
	    -webkit-transition: all 0.3s;
    }
}

@media all and (max-width:440px) {
	#searchCondition {
	    min-width: 90px;
	}
}
@media all and (max-width:360px) {
	#searchCondition {
	    min-width: 70px;
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
			<span class="active">보고서</span>        
		</div>     
		<span class="center_text_01">아카이브</span>
	</div> 
	<div class="under_bar"></div>
			
	<!-- 보고서 목록 -->
	<div class= "content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div class="sub_book_wrap">  
					<div id="search-group" class="sub">
						<div class="search-input">
							<label for="searchCombo"></label>
							<select id="searchCondition" name ="searchCondition" title="분류">
								<option value="ALL">전체</option>
								<option value="TITL">연구과제명</option>
								<option value="PI">연구책임자</option>
								<option value="ORG">주관연구기관</option>							
							</select>
							<label for="searchBox"></label>
							<input type="text" id="searchKeyword" name= "searchKeyword" value="${archiveReportVo.searchKeyword}" onkeydown="fn_enter_search(this);"/>
							<input type="button" id="btnSearch" value="검색" onclick="javascript:fn_search(1)"/>               		
						</div>
					</div>
					<div class="selectbox_wrap">						    	
						<select id="orderBy">
						  <option value="TYPE_A">최신순</option>
						  <option value="TYPE_B">오래된순</option>
						</select>
						<select id="selectbox1">
						  <option value="10">10</option>
						  <option value="20">20</option>
						  <option value="30">30</option>
						  <option value="50">50</option>
						</select>
					    <a href="#" onclick="javasctipt:selMultiMyLib()" class="bibliography"><i class="fas fa-book"></i>내서재담기<div id="library1"></div></a>
						<!-- <a class="order-basic-btn" style="" href="javascript:fn_search(1);">적용</a>		 -->
					</div>
					<div class="list_title">
						<p id="search_cn">보고서<span id="topCnt"></span></p>
					</div>					
					<div class="under_bar2"></div>
					<div class="sub_book_wrap">	 
						 <!-- 데이터 구성 STR -->
						 <div id = "bodyInfo">
						 </div>   
					 </div>
					<!-- 데이터 구성 END -->	
					
					<!-- <a class="more_btn" href="#">더보기</a> -->
					<div id="paging" class="paginate" ></div>
				</div>
				<!-- rightMenu -->
				<!--검색제한-->
				<div id="sidebar-right" style="margin-top:80px;">
					<div class="sidebar-right-text">검색결과제한</div>
						<ul class="acc-menu" id="accordionMenu1">
							<li data-extension="close">
								<div class="main-title"><span class="folder"> </span><a>기준년도</a></div>
								<ul class="sub" id="fillter_year">
									
								</ul>
							</li>
							<li data-extension="close">
								<div class="main-title"><span class="folder"> </span><a>연구비지원기관</a> </div>
								<ul class="sub" id ="fillter_dept">
									
								</ul>
							</li>
							<li data-extension="close">
								<div class="main-title"><span class="folder"> </span><a>주제분류</a> </div>
								<ul class="sub" id ="fillter_subject">
									
								</ul>
							</li>
						</ul>
						<a class="sidebar-right-text clearall" href="javascript:fn_fillterControll('clear')">Clear All</a>
				</div>
			</div> <!-- 보고서 목록 끝 -->  

	
			
		</div>
	</div>
<!--검색제한 끝-->
<!-- rightMenu End -->	
	<input type="button" onclick="javascript:fn_tt();" value="test" style="display: none">
	<!-- 추가 PARAM -->
	<input type="hidden" id="message" name="message" value="${message}" alt="message">
	<input type="hidden" name="page" id="page" value="${archiveReportVo.page}" alt="pageNum" /> 
	<input type="hidden" name="rep_id" id="rep_id" value="" alt="보고서 id" /> 
	<input type="hidden" name="searchOption" id="searchOption" value="${archiveReportVo.searchCondition}" alt="콤보param" /> 
 	
 	<!-- 필터 유지 위한 PARAM -->
 	<input type="hidden" name="fillterYearList_s" id="fillterYearList_s"  value ="${archiveReportVo.fillterYearList_s}" alt="필터 발행년도" /> 	
 	<input type="hidden" name="fillterDeptList_s" id="fillterDeptList_s"  value ="${archiveReportVo.fillterDeptList_s}" alt="필터 연구비지원기관" />
 	<input type="hidden" name="fillterSubjectList_s" id="fillterSubjectList_s"  value ="${archiveReportVo.fillterSubjectList_s}" alt="필터 주제분류" />
 	  	
 	<!-- 필터가 열린 갯수를 보내준다. -->
 	<input type="hidden" name="fillterYearCnt" id="fillterYearCnt" value = "${archiveReportVo.fillterYearCnt}" alt="필터 발행년도 CNT" />	
	<input type="hidden" name="fillterDeptCnt" id="fillterDeptCnt" value = "${archiveReportVo.fillterDeptCnt}"  alt="필터 연구비지원기관 CNT" />
	<input type="hidden" name="fillterSubjectCnt" id="fillterSubjectCnt" value = "${archiveReportVo.fillterSubjectCnt}"  alt="필터 주제분류 CNT" />
	 	 
 	<!-- 공통  필수 PARAM -->
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/>
	
	
	
</form>