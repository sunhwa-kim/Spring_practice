<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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

var str_kwd = '${keyword}';

$(function(){
	  
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
	fn_search(page);
	
	cmmfn_set_datepicker($("#str_dt"), "yy-mm-dd");
	cmmfn_set_datepicker($("#end_dt"), "yy-mm-dd");
	 
});

function fn_view(type , artctrlno){
	var l, t;
	l = (screen.width-1000);
	t = (screen.height-700)/2;

	if(type == 'a'){

	}else if(type == 'b'){
		//window.open('${ctxt}/elib/kom/selectAbstract.do?artctrlno='+artctrlno,'_pop','width='+1000+',height='+600+',left='+l+',top='+t+',resizable=0,scrollbars=1');
	}else if(type == 'c'){
		//window.open('${ctxt}/elib/kom/selectArticleInfo.do?artctrlno='+artctrlno,'_pop','width='+1000+',height='+600+',left='+l+',top='+t+',resizable=0,scrollbars=1');
	}else if(type == 'd'){
		selMyLib(artctrlno);
	}
}



function fn_search(page){
	
	//현재 페이지 세팅
	cuurPage= page;
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/

	$('#page').val(cuurPage);

	$('#searchType').val($('#srchChoice option:selected').val());
	
	var params = {};
  		params.page=cuurPage;
  		params.artctrlno='';
  		params.title=str_kwd== ''?'':str_kwd;
  		
	 	params.f1="${artbriefVo.f1}";
	 	params.v1="${artbriefVo.v1}";
	 	params.and1="${artbriefVo.and1}";
	 	params.f2="${artbriefVo.f2}";
	 	params.v2="${artbriefVo.v2}";
	 	params.and2="${artbriefVo.and2}";
	 	params.f3="${artbriefVo.f3}";
	 	params.v3="${artbriefVo.v3}";
	 	params.and3="${artbriefVo.and3}";
	 	params.broadSubject="${artbriefVo.broadSubject}";
	 	params.listGbn="${artbriefVo.listGbn}";
	 	params.orderType="${artbriefVo.orderType}";
	 	params.str_dt="${artbriefVo.str_dt}";
	 	params.end_dt="${artbriefVo.end_dt}";
	 	params.journalinfo="${artbriefVo.journalinfo}";
    $.ajax({
        url: '${ctxt}/elib/kom/selectArticleList.do',
        data: params,
        type: 'POST',
        dataType: 'text',
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
				
				$('#total').text("("+numberWithCommas(dataTotalCnt)+")");
				
				xmlList.each(function(cnt){
			
					var obj = $(this);
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					 html += '<div class="dtl_list"  id="data_'+cnt+'" style="padding-bottom:0px;" >';
					// html += ' <input id="option" type="checkbox" name="field" value="option">';
					 html += '<label for="option"><span><span></span></span></label>';
					 html += '<div style = "display:inline;float:left;overflow:visible;margin-top:3px;margin-left:37px;"><input id="option" type="checkbox" name="field" value="option"></div>';
					 html += '<div style = "display:inline;float:left;overflow:visible;clear:both;margin-left:43px;">'+obj.find('order_sn').text()+'. </div>';	
					 html += '<div style = "margin-left:28px;">';
					 html += '<ul>';
					 html += '	  <li class="sub_center_cont_text" style=""><a class="d_title" href="javascript:fn_dtl(\''+ obj.find("artctrlno").text() +'\')">'+ obj.find('title').text() +'</a></li>'; 
					 html += '	  <li class="sub_center_cont_text02" style=""><font style="font-weight:bold;"></font >'+ obj.find('author').text() ; 
					 if(obj.find('author').text() != ''){
						 html += '*</li>';  
					 }else{
						 html += '</li>';  
					 }
					 html += '	  <li class="sub_center_cont_text02" style="">'+ obj.find('journalname').text() +" . "+ obj.find('pubdate').text();
					 html += '	  '+ obj.find('volumename').text() + " : "  + obj.find('startpage').text();
					 
					 if(obj.find('doi').text() != ''){html += ', doi :' +obj.find('doi').text() ;}
					 
					 html += '</li>';   
					 html += '	  <li class="sub_center_cont_text02" style=""><a class="a_btn" href="javascript:fn_view(\'a\',\''+ obj.find('artctrlno').text()  +'\')">원문보기</a> <a class="a_btn" href="javascript:fn_view(\'b\',\''+ obj.find('artctrlno').text()  +'\')">초록내용</a> <a class="a_btn" href="javascript:fn_view(\'c\',\''+ obj.find('artctrlno').text()  +'\')">서지정보</a><a class="a_btn" href="javascript:fn_view(\'d\',\''+ obj.find('artctrlno').text()  +'\')">내서재담기</a></li>';
					 html += '	 </ul>';
					 html += '	 </div>';
					 html += '</div>';   
					
		        });
				//페이징처리
			    $('#paging').paging({
					 current:cuurPage
					,max:pageTotalCnt
					,length:pageLen
					,onclick:function(e,page){
						cuurPage=page; 
						fn_search(cuurPage);
					}
				});
				$("#topInfo").html("<strong>["+ cuurPage +" / "+pageTotalCnt+" Pages] <span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.</strong>");
			    $("#bodyInfo").html(html);
			  
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$('#paging').children().remove();
				
				$("#bodyInfo").html('<tr><td colspan="5" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
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
			location.href = "${ctxt}/login/user/login.do?returnURL=/elib/kom/listArticle.do?keyword="+str_kwd;
			return;
		} else {
			return;
		}
	} 

	$.ajax({
		url : "<c:url value='/mylib/lib/saveMylib.do'/>",
		data : {"key":artctrlno},
		type : 'post',
		dataType : 'text',
		success : function(args) {
			if(confirm("선택하신 총 1건 중\n내 서재 담기에 성공한 건수: 1건\n이미 내 서재에 등록된 건수(내 서재 담기에 실패한 건수): "+args.dupCnt+"건 \n입니다.\n\n※ 내 서재 화면으로 이동하시겠습니까?")){
				location.href="<c:url value='/mylib/lib/listMyLib.do'/>";
				return;
			}else{
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

</script>


<style>
#div_body , #sidebar-pumed-right{
	font-family: sans-serif !important;
	font: 80.5%/1.3846 arial, helvetica, clean, sans-serif;
	margin: 0;
}

.dtl_list .d_title {
	text-decoration: underline;
	color: #2222cc;
}

.sub_center_cont_text {
	font-size: 1.108em;
	margin: 0;
}

.off {
	display: none;
}

.a_btn {
	text-decoration: none !important;
}
</style>
<form id="artctrlForm" name="artctrlForm"
	action="${ctxt}/elib/kom/articleDtl.do" method="get">
	<input type="hidden" id="page" name="page" value="" /> <input
		type="hidden" id="artctrlno" name="artctrlno" value="" />
</form>


<div class="sub_center_text">
	<div class="sub_center_nav">
		<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>
		<span> > </span> <span>전자자원</span> <span> > </span> <span  class="active">KoreaOpenMed</span>
	</div>
	<div class="sub_center_wrap">
		<a href="#" class="center_text_01">국내학술논문</a>
	</div>
</div>
<div class="under_bar"></div>

<div class="content_wrap" >
	<div class="sub_book_wrap">
		<div class="search_wrap">
			<div id="search-group">
				<div class="search-input">
					<label for="searchCombo"></label> <select id="searchCondition"
						name="searchCondition" title="분류">
						<option value="ALL">전체</option>
						<option value="TITL">제목</option>
					</select> <label for="searchBox"></label> <input type="text"
						id="searchKeyword" name="searchKeyword"
						value="${archiveReportVo.searchKeyword}"
						onkeydown="fn_enter_search(this);" /> <input type="button"
						id="btnSearch" value="검색" onclick="javascript:fn_search(1)" />
				</div>
			</div>
		</div>

		<div class="selectbox_wrap">
			<select id="selectbox1" class="sub_select">
				<span class="sub_arr"></span>
				 <option value="1">정렬</option>
				 <option value="2">10</option>
				 <option value="3">20</option>
				 <option value="4">30</option>
				 <option value="5">50</option>
			</select>
			 <select id="selectbox2" class="sub_select">
				<span class="sub_arr"></span>
			 	 <option value="1">최신순</option>
			     <option value="2">인기순</option>
			</select>			
			 <select id="selectbox2" class="sub_select">
				<span class="sub_arr"></span>
				<option value="1">전체선택</option>
				<option value="2">전체선택</option>
				<option value="3">전체선택</option>
				<option value="4">전체선택</option>
				<option value="5">전체선택</option>
			</select>
			 <a href="#" class="center_text_02" style="padding-top: 9px">내서재담기<div id="library1"></div></a>
			<!-- <a href="#" class="center_text_02">서지사항내려받기<div id="library2"></div></a> -->
		</div>

		<span class="center_text_001">국내학술논문</span><span id="total"></span>
		<div class="under_bar2"></div>

		<!-- <div class="under_bar"></div> -->
		<!-- <div style="width: 100%;  padding-left: 10px; float: left;" id="div_body">
		소장전체 -->
		<div class="sub_book_wrap" id = "div_body">
			<div id="bodyInfo"></div>
		</div>
		<div id="paging" class="paginate" style=""></div>
	</div>

	<!-- </div>      -->
</div>
<!-- 도서 목록 끝 -->

<div id="sidebar-pumed-right">
	<div class="sidebar-right-text">Fillter</div>
	<ul class="acc-menu" id="pumed-accordionMenu1">
		<li data-extension="close">
			<div class="main-title">
				<span class="folder"> </span><a>Article types</a>
			</div>
			<ul class="sub" id="fillter_article">
				<c:forEach items="${mesh_type}" var="item">
					<c:choose>
						<c:when test="${item.cd == 'D016430' || item.cd == 'D016454' }">
							<li class="on"><input type="checkbox" name="${item.cd}"
								value="${item.cd}"><span class="check_chlid">${item.cd_nm}</span></li>
						</c:when>
						<c:otherwise>
							<li class="off"><input type="checkbox" name="${item.cd}"
								value="${item.cd}"><span class="check_chlid">${item.cd_nm}</span></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<li id="add_article"><a href="javascript:fn_article()">Customize
						...</a></li>
			</ul>
		</li>
		<div class="schedule" id="article_type">
			<a href="javascript:fn_show();">[Show]</a>
			<div>
				<c:forEach items="${mesh_type}" var="item">
					<li style="margin-left: 2%;"><input type="checkbox"
						name="${item.cd}" value="${item.cd}"><span
						class="check_chlid" style="cursor: pointer;">${item.cd_nm}</span></li>
				</c:forEach>
			</div>
		</div>

		<li data-extension="close">
			<div class="main-title">
				<span class="folder"> </span><a>Text availability</a>
			</div>
			<ul class="sub" id="">
				<li><input type="checkbox" name="abstract" value="A"><span
					class="check_chlid">Abstract</span></li>
				<li><input type="checkbox" name="full_text" value="F"><span
					class="check_chlid">Full text</span></li>
			</ul>
		</li>
		<li data-extension="close">
			<div class="main-title">
				<span class="folder"> </span><a>Publication dates</a>
			</div>
			<ul class="sub" id="fillter_dept">
				<li><input type="checkbox" name="years_5" value="5"><span
					class="check_chlid">5 years</span></li>
				<li><input type="checkbox" name="years_10" value="10"><span
					class="check_chlid">10 years</span></li>
				<li style="height: 100%;"><label for="str_dt" class="hide"></label><input
					type="text" style="width: 70px; margin-left: 1%;" maxlength="8"
					id="str_dt" title="start_dt" name="str_dt"
					onblur="javascript:fn_validDate(this)"> -<br /> <label
					for="end_dt" class="hide"></label><input type="text"
					style="width: 70px; margin-left: 1%; margin-top: 1%;" maxlength="8"
					id="end_dt" title="end_dt" name="end_dt"
					onblur="javascript:fn_validDate(this)"> <a>Apply</a></li>
			</ul>
		</li>
		<li data-extension="close">
			<div class="main-title">
				<span class="folder"> </span><a>Language</a>
			</div>
			<ul class="sub" id="fillter_lang">
				<li><input type="checkbox" name="kor" value="kor"><span
					class="check_chlid">Korean</span></li>
				<li><input type="checkbox" name="eng" value="eng"><span
					class="check_chlid">English</span></li>
			</ul>
		</li>
	</ul>
	<a class="sidebar-right-text" href="javascript:fn_fillterControll()">ClearAll</a>
</div>
<div class="btn-group">
	<a href="${ctxt}/elib/kom/listKom.do" title="이전" style="float: right;margin-bottom:10px;" class="basic-btn">이전으로</a>
</div>

