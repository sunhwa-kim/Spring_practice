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

var cuurPage;
var pageTotalCnt = 0;
var dataTotalCnt = 0;

var fillterYearList=""; // 발행연도 필터조건 담기위한 param


// 검색결과제한 controll
//추후 5개로 변경
var initFillter  = 3 ;  // 최초 보여줄 갯수
var cntYear = 2;

var resultYear = 3; //최초 보여줄 갯수(parameter)

var initParam ='';


$(function(){
	
	if($("#message").val() != ''){
		var msg = $("#message").val();
		if(msg == 'fail'){
			alert("저장에 실패하였습니다.");
		}else if(msg =='success'){
			alert("저장이 완료 되었습니다.");
		}else if(msg =='login'){
			alert("로그인을 수행해 주십시오.");
		}
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
	fn_rightMenu(initParam);
	//fn_fillterControll(initParam);  // 필터 초기화
	
	
	fn_search(page);

	
	
	
});

function fn_page(param){
	$("#fillterYearCnt").val($("input:checkbox[name=fillterYear]").length);
	
	
	$('#rnd_id').val(param);
	var form=document.reqForm;
	form.action="${ctxt}/archive/rnd/rndView.do?upd_yn=Y";
	form.submit();
	
}
function fn_doi(param){  
	
	if(param != ''  && param.indexOf('http')  >= 0){
		window.open(param ,"원문정보" , "_blank" ,"rel=noopener");
	}else{
		alert("원문정보가 존재하지 않습니다.");
	}
	
}

/* 보고서 목록 조회  */
function fn_search(page){
	
	fillterYearList=""; // 발행연도 필터조건 담기위한 param

	
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
	
    
	var params = {};
  		params.page=cuurPage;
		params.orderBy = $('input[name = orderBy]:checked').val();
		params.pageSize =  $("#selectbox1 option:selected").val();
	
		params.fillterYearList = fillterYearList.substring(0 ,fillterYearList.length-1);
		
		$("#fillterYearList_s").val(fillterYearList.substring(0 ,fillterYearList.length-1));

		params.searchKeyword = $('#searchKeyword').val();
		params.searchCondition = $('#searchCondition option:selected').val(); 
	
	
    $.ajax({
        url: '${ctxt}/archive/rnd/rndRead.do',
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
					var atc_title = "";
					var rnd_id = obj.find('rnd_id').text(); // 보고서 id
					var atc_title_kor = obj.find('atc_title_kor').text(); // 타이틀
					var atc_title_eng = obj.find('atc_title_eng').text(); // 타이틀
					var volumename = obj.find('volumename').text(); // 권호명
					var journal_nm = obj.find('journal_nm').text(); // 저널명
					var jour_str_page = obj.find('jour_str_page').text(); // 저널 시작
					var jour_end_page = obj.find('jour_end_page').text(); // 저널 끝
					var co_author = obj.find('co_author').text();   // 공동저자
					var author = obj.find('author').text();   // 주저자
					var doi = obj.find('doi').text();   // doi
					var order_sn = obj.find('order_sn').text();   // 정렬순서
					var publishing_date = obj.find('publishing_date').text();   // 출판일자
					var atch_link_id = obj.find('atch_link_id').text();   // 정렬순서
					//보고서 과제명
					if(atc_title_kor != ""){
						atc_title = atc_title_kor;
					}else{
						atc_title = atc_title_eng;
					}
					
					
					html += '<div class="dtl_list"  id="data_'+cnt+'" style="padding-bottom:7px;" >';
					// html += ' <input id="option" type="checkbox" name="field" value="option">';
			        html += '<label for="option"><span><span></span></span></label>';
			        html += '<div style = "display:inline;overflow:visible;margin-top:3px;"><input name="chk_mylib"  class="option" type="checkbox"  value=\''+rnd_id+'\'></div>';
			        //html += '<div style = "display:inline;float:left;overflow:visible;clear:both;margin-left:43px;">'+(dataTotalCnt  - (order_sn -1))+'. </div>';	
				    html += '<div style = "margin-left:28px;">';	
				    
					html +=	 '<ul>';
				
					html +=	  '<li class="sub_center_cont_text"><a href="javascript:fn_page(\''+rnd_id+'\')" >'+atc_title+'</a></li>';	
							
				//	html +=	  '<li class="sub_center_cont_text02" style="float:left;">'+author+'</li>';
					html +=	  '<li class="sub_center_cont_text02">'+author+'&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;'+journal_nm+'&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;'+publishing_date+'&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;'+volumename+'&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;'+jour_str_page+'-'+jour_end_page+'</li>';					
					html +=	  '<li class="sub_center_cont_text02">'; 
				    //첨부파일 보기에서 doi로 변경
				    //html +=	  '<a class="a_btn" href="javascript:fileView(\''+atch_link_id+'\',\''+atc_title+'\',\''+rnd_id+'\');">원문정보</a>&nbsp;&nbsp;&nbsp;<a class="a_btn" href="javascript:fn_selMyLib(\''+rnd_id+'\');">내서재담기</a></li>';			
				    html +=	  '<a class="a_btn" href="javascript:fn_doi(\''+doi+'\');">원문정보</a>&nbsp;&nbsp;&nbsp;<a class="a_btn" href="javascript:fn_selMyLib(\''+rnd_id+'\');">내서재담기</a></li>';
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
			    
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$('#paging').children().remove();
				
				$("#bodyInfo").html('<div>조회된 내용이 없습니다.</div>');
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
	var plusLang = 0;
	
	if($("#fillterYearCnt").val() != ''){
		resultYear = $("#fillterYearCnt").val();
		plusYear = resultYear;	
		$("#fillterYearCnt").val("");
	}
	
	// 검색결과 제한의 더보기 구성을 위한 param
	if (param == 'year'){
		resultYear = (initFillter * cntYear) + plusYear;	
		cntYear++;
	}
	
	var params = {};
  		params.fillterYear = resultYear;
  		params.searchKeyword = $('#searchKeyword').val();
		params.searchCondition = $('#searchCondition option:selected').val(); 
		
    $.ajax({
        url: '${ctxt}/archive/rnd/rndRightMenuRead.do',
        data: params,
        type: 'POST',
        dataType: 'text',
        async: false,   // 다완료 되고 가야한다.
        cache: false,
        success: function(rtnXml) {
   
        	rXmlList = $(rtnXml).find('item');
        	
        	yearHtml="";
       
        	
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
						yearHtml += '<li><input type="checkbox" id =  "'+fillter_code+'" name = "fillterYear" onclick = "fn_fillterSearch()" value = "'+fillter_code+'"></input><label for = "'+fillter_name+'" >'+fillter_name+'(' + fillter_cnt + ')'+'</label></li>';						
					}
					
		        });
					
				yearHtml += '<li><a class="more_btn2" href="javascript:fn_rightMenu(\'year\')" >더보기</a></li>';	


			    $("#fillter_year").html(yearHtml);
			    
  
				// 더보기 할때 기존의 checkBox를 살려주기 위해
				// 발행연도
			    var splitYear = $("#fillterYearList_s").val().split(",");
				for(var i in splitYear){
					var val = splitYear[i];
					var chkId = $("#"+val).attr("id");
					$("#"+chkId).prop('checked', true);
				}
			
			}else{
				// 존재 하지 않으면 더보기만 나오도록.
				
				yearHtml += '<li><a class="more_btn2" href="#" >더보기</a></li>';	
			
			    $("#fillter_year").html(yearHtml);
			   
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}

function fn_fillterSearch(){
	
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

	 resultYear = 3; //최초 보여줄 갯수(parameter)
	 
     // checkBox  모두 초기화
     $("input[name=fillterYear]").prop("checked", false);
   
	 $("#fillterYearList_s").val("");	

	 // 검색결과제한 필터 초기화
    $("#fillter_year").children().each(function(idx){	  
		if(idx >= initFillter &&  parseInt($("#fillter_year").children().size())-1  != idx ){
		    $("#fillter_year").children().eq(idx).hide();		  
		}else{
		    $("#fillter_year").children().eq(idx).show();
		}
	 });  
   
	
	$("#accordionMenu1 > li").attr("data-extension","open");
	$(".main-title > span").attr("class" , "folder open");
	$("#fillter_year").attr("style" , "margin-top : 0px;");

	
	//재검색
	if(param != 'init'){
		fn_search(1);
	}
	  
}
/**
 * 내서재담기 row
 */
function fn_selMyLib(rnd_id) {
	
 	if ("${userVo.emplyrnm}" == "") {
		if (confirm("내서재 담기 기능을 선택하실 경우 로그인 하셔야합니다.\n로그인 화면으로 이동하시겠습니까?")) {
			location.href = "${ctxt}/login/user/login.do?returnURL=/archive/rnd/rndList.do";
			return;
		} else {
			return;
		}
	} 
 	var params = {};
	params.key = rnd_id;
	params.gbn = "rnd";
	
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
 * 내서재담기
 */
function selMultiMyLib() {
	var chk_mylib_cnt = 0;
	var mylibChk = "";
 	if ("${userVo.emplyrnm}" == "") {
		if (confirm("내서재 담기 기능을 선택하실 경우 로그인 하셔야합니다.\n로그인 화면으로 이동하시겠습니까?")) {
			location.href = "${ctxt}/login/user/login.do?returnURL=/archive/rnd/rndList.do";//?searchCondition="+$('#searchCondition option:selected').val()+"&searchKeyword="+$('#searchKeyword').val();
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
	params.gbn = "rnd";

	$.ajax({
		url : "<c:url value='/mylib/lib/multiMylibSave.do'/>",
		data : params,
		type : 'post',
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




function fileView(atch_link_id, atc_title , idVal) {
	
	var atchLinkId = atch_link_id
	
	var contextName = "ncmik";
	var fileKey = atchLinkId;
	var pageTitle = atc_title;
	var rnd_id = idVal;
	
	if(atch_link_id == "" || atch_link_id == null ){
		alert("원문정보가 존재 하지 않습니다.");	
		
		return;
	}
	
	fn_downloadUpdate(fileKey, contextName, pageTitle , rnd_id , 'rnd');
}
</script>
<style>
.order-basic-btn{
	position:absolute; text-decoration:none; right:0; bottom:0;
}
.selectbox_wrap{
	height:38px; 
	position:relative; 
	padding-right:65px; 
	margin:0; 
	padding-top:0;
	margin-top: 3px;
}
#searchCondition{
	min-width: 110px;
}
.sub_center_cont_text {
    margin-bottom: 7px;
}
#selectbox1{
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
  margin-left:10px;
}
.bibliography{
	display:inline-block;
}
.center_radio_03, .center_text_03, #selectbox1, .bibliography{
    margin-top: 0px;
    height:38px;
    line-height:38px;
}
#search-group.sub{
	margin-top:0;
}
.center_text_02{
	padding-left:30px;
}
#library1{
	margin-top:5px;
}
@media all and (max-width:1015px) {
	.center_radio_03 {
	    margin-left: 15px;
	}
}
@media all and (max-width:646px) {
	.center_text_02{
		padding-left:20px;
	}
	#selectbox1{
		margin-left:20px;
	}
	.center_radio_03:first-child{
		margin-left:0;
	}
}
@media all and (max-width:613px){
	.center_text_02{
		padding-left:15px;
	}
}

@media all and (max-width:600px) {
	.order-basic-btn{
		position:relative;
	}
	.selectbox_wrap {
	   	width: 300px;
	   	padding-right: 10px;
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
	.center_radio_03, .center_text_03, #selectbox1, .bibliography {
	    height: 30px;
	    line-height: 30px;
	    vertical-align:top;
    }
	.center_radio_03:first-child{
		margin-left:15px;
	}
	.order-basic-btn{
		margin-left:0;
		margin-top:0;
	}
}
@media (max-width: 600px){
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

</style>
<form name="reqForm" method="post">
	
	
	<div class="sub_center_text">
	    <div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>아카이브</span>
			<span> > </span>
			<span class="active">성과논문</span>        
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
								<option value="TITL">논문명</option>
								<option value="JOURNALNM">학술지명</option>
								<option value="AUTHOR">주저자</option>
							</select>
							<label for="searchBox"></label>
							<input type="text" id="searchKeyword" name= "searchKeyword" value="${archiveRndVo.searchKeyword}" onkeydown="fn_enter_search(this);"/>
			            	<input type="button" id="btnSearch" value="검색" onclick="javascript:fn_search(1)"/>	                		
						</div>
					</div>
				 
				 
				 <div class="selectbox_wrap">
										
				    <input class="center_radio_03" name="orderBy" id="orderBy1" type="radio" value="TYPE_A" checked="checked"/><label for="orderBy1" class="center_text_03">최신순</label>
					<!-- <input class="center_radio_03" name="orderBy" id="orderBy2" type="radio" value="TYPE_B" /><label for="orderBy2" class="center_text_03">유사도순</label> -->			   
			    	<input class="center_radio_03" name="orderBy" id="orderBy3" type="radio" value="TYPE_C" /><label for="orderBy3" class="center_text_03">제목오름차순</label>
				    <input class="center_radio_03" name="orderBy" id="orderBy4" type="radio" value="TYPE_D" /><label for="orderBy4" class="center_text_03">제목내림차순</label>			    	
					
					<select id="selectbox1" class="sub_select">
					  <option value="10">목록건수</option>
					  <option value="10">10</option>
					  <option value="20">20</option>
					  <option value="30">30</option>
					  <option value="50">50</option>
					</select>
			 		<a href="#" onclick="javasctipt:selMultiMyLib()"  class="bibliography"><i class="fas fa-book"></i>내서재담기<div id="library1"></div></a>
					<a class="order-basic-btn" href="javascript:fn_search(1);">적용</a>		
		
				</div>
				 
				 	<!-- <span class="center_text_001" id="search_cn">성과논문</span><span id ="topCnt"></span> -->
				<div class="list_title">
					<p id="search_cn">성과논문<span id="topCnt"></span></p>
				</div>
				<div class="under_bar2" ></div>
				 
				<!-- 데이터 구성 STR -->
				<div id = "bodyInfo">
				 
				</div>   
				<!-- 데이터 구성 END -->	
				
				<!-- <a class="more_btn" href="#">더보기</a> -->
				<div id="paging" class="paginate"  style = "text-align: center;"></div>
			</div>
			<!-- rightMenu -->
			<!--검색제한-->
			<div id="sidebar-right" style="margin-top:80px;">
				<div class="sidebar-right-text">검색결과제한</div>
					<ul class="acc-menu" id="accordionMenu1">
						<li data-extension="close">
							<div class="main-title"><span class="folder"> </span><a>발행년도</a></div>
							<ul class="sub box" id="fillter_year">
								
							</ul>
						</li>		
					</ul>
					<a class="sidebar-right-text clearall" href="javascript:fn_fillterControll('clear')">Clear All</a>
			</div>
			<!--검색제한 끝-->
			<!-- rightMenu End -->	
	</div> <!-- 보고서 목록 끝 -->  
	
		
	
	<!-- 추가 PARAM -->
	<input type="hidden" id="message" name="message" value="${message}" alt="message">
	<input type="hidden" name="page" id="page" value="${archiveRndVo.page}" alt="pageNum" /> 
	<input type="hidden" name="rnd_id" id="rnd_id" value="" alt="보고서 id" /> 
	<input type="hidden" name="searchOption" id="searchOption" value="${archiveRndVo.searchCondition}" alt="콤보param" /> 
 	
 	<!-- 필터 유지 위한 PARAM -->
 	<input type="hidden" name="fillterYearList_s" id="fillterYearList_s" value ="${archiveRndVo.fillterYearList_s}" alt="필터 발행년도" />
	 
	 <!-- 필터가 열린 갯수를 보내준다. -->
 	<input type="hidden" name="fillterYearCnt" id="fillterYearCnt" value = "${archiveRndVo.fillterYearCnt}" alt="필터 발행년도 CNT" />
	
 	<!-- 공통  필수 PARAM -->
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/>
</div>
</div>
	
</form>