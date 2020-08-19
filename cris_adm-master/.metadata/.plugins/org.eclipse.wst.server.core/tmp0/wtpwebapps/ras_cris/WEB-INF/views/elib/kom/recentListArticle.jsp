<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
 
var xmlList;
var html="";
var cuurPage;
var pageTotalCnt = 0;
var dataTotalCnt = 0;

//검색결과제한 controll
//추후 5개로 변경
var initFillter  = 3 ;  // 최초 보여줄 갯수
var cntYear = 2;
var cntLang = 2;
var cntDept = 2;
var resultYear = 3; //최초 보여줄 갯수(parameter)
var resultLang = 3; //최초 보여줄 갯수(parameter)
var resultDept = 3; //최초 보여줄 갯수(parameter)

var isChk= false;

$(function(){
	  
	$('.print-preview').printPreview();
	
	if($("#messege").val() != ''){
    	fn_alert( $("#messege").val());
    }
    $("#messege").val('');
	
    var page =$('#page').val();
	if(page == '' ){
		page=1;
	}

	$('.check_chlid').click(function(){
		if($(this).parent().find('input').is(":checked")){
			$(this).parent().find('input').prop('checked',false);
		}else{
			$(this).parent().find('input').prop('checked',true);
		}
	});
	
	
	// 화면 목록 조회
	//fn_search(page);
	
	cmmfn_set_datepicker($("#str_dt"), "yy-mm-dd");
	cmmfn_set_datepicker($("#end_dt"), "yy-mm-dd");
	 
});

function print2(printArea)
{
		win = window.open(); 
		win.document.open();
		
		/*
			1. div 안의 모든 태그들을 innerHTML을 사용하여 매개변수로 받는다.
			2. window.open() 을 사용하여 새 팝업창을 띄운다.
			3. 열린 새 팝업창에 기본 <html><head><body>를 추가한다.
			4. <body> 안에 매개변수로 받은 printArea를 추가한다.
			5. window.print() 로 인쇄
			6. 인쇄 확인이 되면 팝업창은 자동으로 window.close()를 호출하여 닫힘
		*/

		win.document.write('<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">');
		win.document.write('<html>');
		win.document.write('<head>');
  		win.document.write('<link rel="stylesheet" href="${ctxt}/resources/css/ncmik/subIndex.css" type="text/css" />');
		win.document.write('<link rel="stylesheet" href="${ctxt}/resources/css/popup.css"  type="text/css" /> ');
		win.document.write('<link rel="stylesheet" href="${ctxt}/resources/css/jquery-ui.min.css" type="text/css" />');  
		win.document.write('<link rel="stylesheet" href="${ctxt}/resources/css/ncmik/wonkiIndex.css" type="text/css" />');
		win.document.write('<link rel="stylesheet" href="${ctxt}/resources/css/ncmik/KoreaOpenMed.css" type="text/css" />');  
        win.document.write('<title></title><style type="text/css"> #sidebar-left {display:none !important;}  ');
    	win.document.write('#sidebar-pumed-right {display:none !important;}  ' );
    	win.document.write('.print-preview {display:none !important;}  ');
    	win.document.write('.sub_center_text {display:none !important;}  ' );
    	win.document.write('.sub_book_wrap {width: 96% !important;}  </style> <script>function fn_print(){window.print();window.close();}<\/script>' );
        win.document.write('</head>');
        win.document.write('<body onload="fn_print()">');
        win.document.write(printArea);		
        win.document.write('</body>' );
        win.document.write('</html>');
        win.document.close();
     
}

function fn_view(type , artctrlno){
	var l, t;
	l = (screen.width-1000);
	t = (screen.height-700)/2;

	if(type == 'a'){
		$.ajax({url: '${ctxt}/elib/search/selectTFFileSch.do',
	            data:{"bibCtrlNo": artctrlno},
			 	type: 'GET',
			 	cache: false,   
		        success: function(rtnXml) {
		        	location.href='http://is.cdc.go.kr/upload_comm/file.do?cmd=fileDownload&SEQ='+$(rtnXml).find('atchFileId').text();
		      }
	     });
	}else if(type == 'b'){
		//window.open('${ctxt}/elib/kom/selectAbstract.do?artctrlno='+artctrlno,'_pop','width='+1000+',height='+600+',left='+l+',top='+t+',resizable=0,scrollbars=1');
	}else if(type == 'c'){
		//window.open('${ctxt}/elib/kom/selectArticleInfo.do?artctrlno='+artctrlno,'_pop','width='+1000+',height='+400+',left='+l+',top='+t+',resizable=0,scrollbars=1');
	}else if(type == 'd'){
		selMyLib(artctrlno);
	}
}

function fn_all(){
	$("input[name=chk_mylib]").each(function() {
		if(isChk){
			$('#all_chk').text("All Check");
			$(this).prop("checked",false);
		}else{
			$('#all_chk').text("All Cancel");
			$(this).prop("checked",true);
		}
	});
	isChk=!isChk;

}

function fn_dtl(artctrlno){
	$('#artctrlno').val(artctrlno);
	var form = document.artctrlForm;
	form.submit();
	
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

/**
 * 내서재담기
 */
function selMyLib(artctrlno) {
	
 	if ("${userVo.emplyrnm}" == "") {
		if (confirm("내서재 담기 기능을 선택하실 경우 로그인 하셔야합니다.\n로그인 화면으로 이동하시겠습니까?")) {
			location.href = "${ctxt}/login/user/login.do?returnURL=/elib/kom/listArticle.do";
			return;
		} else {
			return;
		}
	} 
 	var params = {};
	params.key = artctrlno;
	params.gbn = "acticle";
	
	$.ajax({
		url : "<c:url value='/mylib/lib/multiMylibSave.do'/>",
		data : params,
		type : 'post',
		dataType : 'json',
		success : function(data) {
			//"선택하신 총 1건 중\n내 서재 담기에 성공한 건수: 1건\n이미 내 서재에 등록된 건수(내 서재 담기에 실패한 건수): "+args.dupCnt+"건 \n입니다.\n\n※ 내 서재 화면으로 이동하시겠습니까?"
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
 * 선택된 로우 내서재 담기
 */
function selMyLibs(){
	if ("${userVo.emplyrnm}" == "") {
		if (confirm("내서재 담기 기능을 선택하실 경우 로그인 하셔야합니다.\n로그인 화면으로 이동하시겠습니까?")) {
			location.href = "${ctxt}/login/user/login.do?returnURL=/elib/kom/listArticle.do";
			return;
		} else {
			return;
		}
	} 
	var chk_mylib_cnt = 0;
	var mylibChk = "";
	$("input[name=chk_mylib]:checked").each(function() {
		mylibChk += $(this).val() + ",";
	
		if(mylibChk != "" ){
			chk_mylib_cnt++;	
		}
		
	});

	var params = {};
	params.key = mylibChk.substring(0 ,mylibChk.length-1);
	params.gbn = "acticle";

	$.ajax({
		url : "<c:url value='/mylib/lib/multiMylibSave.do'/>",
		data : params,
		type : 'post',
		dataType : 'json',
		success : function(data) {	
			//"선택하신 총 "+chk_mylib_cnt+"건 중\n내 서재 담기에 성공한 건수: "+data.sucCnt+"건\n이미 내 서재에 등록된 건수(내 서재 담기에 실패한 건수): "+data.dupCnt+"건 \n입니다.\n\n※ 내 서재 화면으로 이동하시겠습니까?"
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

function fn_article(){
	$('#fillter_article input').each(function(cnt){
		if($(this).parent().attr('class') == 'on'){
			$('#article_type input[name='+$(this).attr('name')+']').prop('checked',true);
		}
	}); 
	
	popOpen('article_type');
}

function fn_year(){
	popOpen('years');
}

function fn_show(){
	
	$('#fillter_article li').attr('class','off');
	
	$('#article_type :checked').each(function(cnt){
		$('#fillter_article input[name='+$(this).attr('name')+']').parent().attr('class','on');
	}); 
	
	$('#fillter_article li[class=off] input').prop('checked',false);
	$('#add_article').attr('class','on');
	
	popClose('article_type');
}




/* 소장정보 조회  STR*/
var dupleChk="";
function fn_greenInfo(artctrlno , rowVal){	
	
	var rowIdx = rowVal; 

	var params = {};  
		params.artctrlno = artctrlno;
	if(dupleChk == rowIdx){ //열었던것 다시 닫기
		 $("div[id^='greenInfo']").children().remove();
		 $(".abtn").attr('style','');
		 dupleChk = "";		 
		 return;
	} 

    $.ajax({
        url: '${ctxt}/elib/kom/selectAbstract.do',
        data: params,
        type: 'get',
        dataType: 'text',
        success: function(rtnXml) {
   
        	html="";
        	
			html +='<div id="bibElement" class="view_dl_box">';
		
			if($(rtnXml).find('ABSTRACT').text() || $(rtnXml).find('ABSTRACT2').text()){
							    
					var obj = $(rtnXml);									
					var title = obj.find('TITLE').text(); //
					var eng_abstract = obj.find('ABSTRACT').text(); //
					var kor_abstract = obj.find('ABSTRACT2').text(); //
					
					if(eng_abstract != ''){
						html += '<dl><dt>영문</dt><dd>'+eng_abstract+'</dd></dl>';
					}else{
						html += '<dl><dt>영문</dt><dd>no abstract</dd></dl>';
					}
					
					//if(kor_abstract != ''){
					//	html += '<dl><dt>국문</dt><dd>'+kor_abstract+'</dd></dl>';
					//}else{
					//	html += '<dl><dt>국문</dt><dd>no abstract</dd></dl>';
					//}
  
			}else{

				html += '<div class="sub_center_nav">';
				html += 	'<span class="active">초록내용</span>';
				html += '</div>';
				html += '<div class="under_bar"></div>';
			
				html += '<div class="list_title">';
				html += 	'<p class="title">제목</p>';
				html += 	'<span></span>';
				html += '</div>';				
				
				html += '<p class="circle">영문</p>';
				html +=	'<div id="divUcont_cont">';
				//html +=  str_abstract;
				html +=	'</div>';
				
			
				//html += '<p class="circle">국문</p>';
				//html +=	'<div id="divUcont_cont">';
				////html +=  str_abstract2;
				//html +=	'</div>';

			}
		
			html += '</div>';
			
			dupleChk = rowVal;
			 
			$("div[id^='greenInfo']").children().remove();
			 
			$("#greenInfo"+rowIdx).hide();
			 
			$("#greenInfo"+rowIdx).html(html);
		
			$("#greenInfo"+rowIdx).fadeIn(2000);
			 			 
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}
/* 소장정보 END  */

</script>
<style>
.acc-menu li ul.sub li>a.date-picker-control {
    position: relative;
    margin-left: 5px;
    margin-bottom: 0px;
}
/* .content_box>.content_list>.list_title>p:before,  */
/* .content_box .content_list .list_title p:before,  */
/* .content_box>.content_list>.sub_book_wrap>.list_title>p:before { */
/*     content: ""; */
/* } */
#search-group{
	margin-top:0; 
	float:left; 
	height:38px;
	margin:4px 0;
	margin-left:20px;
}
#bibElement {
	width:100%;
    max-width: 640px;
    display:inline-block;
    border-top: 1px solid rgba(51,122,183,0.5);
    border-bottom: 1px solid rgba(51,122,183,0.5);
    border-collapse: collapse;
    margin-top: 0px;
    margin-bottom: 20px;
    font-size: 13px;
    color: #7f7f7f;
    font-weight: normal;
    overflow: visible;
    border-collapse: collapse;
    border-spacing: 0;
    float:left;
    text-align:justify;
}

#bibElement dl {
    width: 100%;
    min-height: 20px;
    line-height: 20px;
    margin:0;
    border-bottom: 1px solid #CCDDED;
    background:#EBEEF0;
}

#bibElement dd {
    width: 100%;
    min-height:20px;
    margin-left:0;
    padding-left:3%;
    float:right;
    background:#fff;
}

#bibElement dt {
	width:100%;
    font-weight: 400;
    text-align: center;
    /* float: left; */
    height: 100%;  
}

.txt-red{
	font-size:14px;
}
#selectbox2{
	width: 95px;
	background: url(${ctxt}/resources/images/sub/sub_op.PNG) 85px center no-repeat;
}
.center_text_02{
	padding-left: 25px;
}
.selectbox_wrap > button.print_btn{
	padding: 9px 0 0 25px;
}
@media (max-width: 600px){
	.list_title>p{
		padding-bottom:20px;
	}
	.selectbox_wrap{
		padding-top:35px
	}
}


</style>

<form id="artctrlForm" name="artctrlForm" action="${ctxt}/elib/kom/articleDtl.do" method="get">
	<input type="hidden" id="page" name="page" value="" /> 
	<input type="hidden" id="artctrlno" name="artctrlno" value="" />
</form>
<form id="searchMove" name="searchMove" action="${ctxt}/elib/kom/listArticle.do?${_csrf.parameterName}=${_csrf.token}" method="post">
	<input type="hidden" id="searchQueryMove" name="searchQuery" value="${vo.searchQuery}" />
	<input type="hidden" id="pageNumMove" name="pageNum" value="${vo.pageNum}" />
	<input type="hidden" id="pageSizeMove" name="pageSize" value="${vo.pageSize}" />
	<input type="hidden" id="searchSortMove" name="searchSort" value="${vo.searchSort}" />
	<input type="hidden" id="searchTargetMove" name="searchTarget" value="${vo.searchTarget}" />
	<input type="hidden" id="searchSubTargetMove" name="searchSubTarget" value="${vo.searchSubTarget}" />
	<input type="hidden" id="searchYearMove" name="searchYear" value="${vo.searchYear}" />
	<input type="hidden" id="searchNlmcMove" name="searchNlmc" value="${vo.searchNlmc}" />
	<input type="hidden" id="searchLangMove" name="searchLang" value="${vo.searchLang}" />
	<input type="hidden" id="abstract_ynMove" name="abstract_yn" value="${vo.abstract_yn}" />
	<input type="hidden" id="fulltext_ynMove" name="fulltext_yn" value="${vo.fulltext_yn}" />
</form>


	<div class="sub_center_text">
		<div class="sub_center_nav">
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>
			<span> > </span> <span>전자자원</span> <span> > </span> <span class="active">KoreaOpenMed</span>
		</div>
		
	</div>
	<div class="under_bar"></div>
	
	<div class="content_wrap" >
		<div class="content_box">
			<div class="content_list">
	
					<div class="selectbox_wrap">
						<a href="javascript:fn_all()" id="all_chk" class="center_text_02" >All Check</a>
						 <a href="javascript:selMyLibs()" class="center_text_02">My Bibliography<div id="library1"></div></a>
						 <button type="button" class="print-preview print print_btn" >Print<i class="fas fa-print"></i></button>
					</div>
					
					<div class="list_title">
						<p>TOP10 articles</p>
					</div>
	
					<div class="sub_book_wrap" style="width: 100%; borde:1px solid #f0f;" id = "div_body">
						<div class="under_bar2"></div>
						
						<div id="bodyInfo">
							<c:choose>
							 <c:when test="${data.inkorea_totalSize > 0 }">
								<c:forEach var="inkoreaList"  begin="0" end="9" items="${data.inkoreaList}" varStatus="status">
									<div class="dtl_list" id="data_0" style="padding-bottom:7px;">
										<label for="option"><span><span></span></span></label>
										<div style="display:inline;overflow:visible;margin-top:3px;">
										<input id="option" type="checkbox" name="chk_mylib" value="${inkoreaList.artctrlno}"></div>
										<div style="margin-left:28px;">
											<ul>
												<li class="sub_center_cont_text" style="">
												<span>${ (data.inkorea_totalSize) - (data.inkorea_totalSize - ((vo.pageNum-1) * vo.pageSize) - status.index) +1}. </span>
												<a href="javascript:fn_dtl('${inkoreaList.artctrlno}')">${inkoreaList.title}</a>
												</li>	  
												<li class="sub_center_cont_text02" style=""><font style="font-weight:bold;"></font>${inkoreaList.author}</li>
												<li class="sub_center_cont_text02" style="">${inkoreaList.journalname}. <span class="date_span">${inkoreaList.pubdate}</span>. ${inkoreaList.volumename}. ${inkoreaList.startpage}. ${inkoreaList.language}. <c:if test="${inkoreaList.doi != ''}">doi:<a href="http://doi.org/${inkoreaList.doi }" target="_blank" rel="noopener noreferrer">${inkoreaList.doi }</a></c:if></li>
												<li class="sub_center_cont_text02" style="">
												<a class="a_btn" href="javascript:fn_view('a','${inkoreaList.artctrlno}')">Full Text</a> 
												<a class="a_btn" href="javascript:fn_greenInfo('${inkoreaList.artctrlno}', '${status.index}' )">Abstract</a>
<%-- 												<a class="a_btn" href="javascript:fn_view('c','${inkoreaList.artctrlno}')">서지정보</a> --%>
												<a class="a_btn" href="javascript:fn_view('d','${inkoreaList.artctrlno}')">My Bibliography</a></li>
											</ul>
										 <div id = "greenInfo${status.index}"  >
										 </div> 
										</div>
									</div>
								</c:forEach>
							</c:when> 
							<c:otherwise>
							검색조건에 해당하는 결과가 없습니다. 다른 검색조건을 선택해 주세요.
							</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="btn-group back">
						<a href="${ctxt}/elib/kom/listKom.do" title="이전" class="basic-btn back margin_b_45">이전으로</a>
					</div>

				<!-- 도서 목록 끝 --> 
	
			</div>
		</div>
	</div>
	