<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
function fileView() {
	
	  var form =document.reqForm;
	  var contextName = "ncmik";
	  var fileKey = form.atch_link_id.value;
    var pageTitle = form.sj.value;
    popAttfileViewIn(fileKey, contextName, pageTitle);
}	
$(function(){
	$(".museum_cn img").css('width','90%');
	$(".museum_cn img").css('height','auto');
});


</script>
<style>
table{
	 width:100%; 
	 margin:0 auto; 
	 margin-top:30px;
}
tr>td img{
	width:90%;
	height:auto;
	margin:0 5%;
}
</style>
<form:form name="reqForm" method="post">
	
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>전시관</span>
			<span> > </span>
			<span class="active">기획 전시</span>        
		</div>
		<span class="center_text_01">기획 전시</span>
    </div> 
	<div class="under_bar"></div>
	
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
				<!-- <h2 class="depth-title">기획전시 상세</h2> -->
				<div class="list_title">
				 	<p>기획전시 상세</p>
				</div> 
		
				<table class = 'basic_table spexhbtn_view_table'>
						<caption>
						 	 기획전시 상세 - 전시기간, 전시장소, 관람료 
						</caption>
						<colgroup>
							<col style="width:40%">				
							<col style="width:60%">
						</colgroup>
						<tbody>
							<tr><th colspan="2" class="title_tr">	${spexhbtnList.exhibition_sj}</th></tr>
							<tr><th>전시기간</th><td>					${spexhbtnList.begin_de} ~ ${spexhbtnList.end_de}</td></tr>
							<tr><th>전시장소</th><td>					${spexhbtnList.exhibition_loc}</td></tr>
							<tr><th>관람료</th><td>					${spexhbtnList.exhibition_cost}</td></tr>
							<tr><td class="museum_cn" colspan="2" style="text-align:center; font-size:0.1em;">		${spexhbtnList.exhibition_cn}</td></tr>
							
						</tbody>
					</table>
			
			<%-- <h3 style="margin-left: 130px;">${spexhbtnList.exhibition_sj}</h3>	
    		<div>	
    			<ul class="towLayout">
    				<li>전시기간<span>${spexhbtnList.begin_de} ~ ${spexhbtnList.end_de}</span></li>
    				<li>전기장소<span>${spexhbtnList.exhibition_loc}</span></li>
    				<li>관람료<span>${spexhbtnList.exhibition_cost}</span></li>
					<li class="tx">${spexhbtnList.exhibition_cn}</li>
				</ul>
			</div> --%>	
					
				<div class="btn-group">
					<a href="javascript:fn_returnListUrl()" class="basic-btn">목록으로</a>
				</div> 
			</div>
		</div>
	</div>
	
	<!-- 검색 PARAM -->
	<input type="hidden" id="page" name="page" value="${spexhbtnList.page}" alt="pageNum" />
	<input type="hidden" id="searchCondition" name="searchCondition" value="${spexhbtnList.searchCondition}"  alt="검색콤보" />
	<input type="hidden" id="searchKeyword" name="searchKeyword" value="${spexhbtnList.searchKeyword}" alt="검색어" />
	
	<!-- 파일 다운로드 PARAM  -->
	<input type="hidden" id="atch_link_id" name="atch_link_id" value="${spexhbtnList.atch_link_id}" alt="첨부파일ID "/>
	<input type="hidden" id="exhibition_sj" name="exhibition_sj" value="${spexhbtnList.exhibition_sj}" alt="공지 제목 "/>
	
	<!-- 목록 화면 주소  -->
	<input type="hidden" id="returnListPage" name="returnListPage" value="${ctxt}/centerintro/spexhbtn/listSpexhbtn.do" alt= "returnPage" />
	
	<!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" />
	
</form:form>
