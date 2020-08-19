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
			<span class="active">박물 자료</span>        
		</div>
		<span class="center_text_01">박물 자료</span>
	</div>
	<div class="under_bar"></div>
	      
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div class="list_title"><p id="search_cn">박물자료 상세</p></div>
				<div id="divRefreshArea" style="">
					<table class = 'basic_table museum_view_table'>
						<caption>
						 	 박물자료 상세 -  국적, 시대, 재잘, 크기, 수량, 전시장소, 기증자, 기증일자
						</caption>
						<colgroup>
							<col style="width:40%">				
							<col style="width:60%">
						</colgroup>
						<tbody>
							<tr><th colspan="2" class="title_tr">	${museumList.museum_sj}</th></tr>
							<tr><th>국적</th><td>		${museumList.museum_country}</td></tr>
							<tr><th>시대</th><td>		${museumList.museum_age}</td></tr>
							<tr><th>재질</th><td>		${museumList.museum_quality}</td></tr>
							<tr><th>크기</th><td>		${museumList.museum_size}</td></tr>
							<tr><th>수량</th><td>		${museumList.museum_quanity}</td></tr>
							<tr><th>전시장소</th><td>	${museumList.museum_loc}</td></tr>
							<tr><th>기증자</th><td>	${museumList.museum_donor}</td></tr>
							<tr><th>기증일자</th><td>	${museumList.donor_de}</td></tr>
							<tr><td class="museum_cn" colspan="2" style="text-align:center; padding-top:20px;">	${museumList.museum_cn}</td></tr>
						</tbody>
					</table>
				</div>
				
				
				
				
				
				<%-- <h3 style="margin-left: 130px;">${museumList.museum_sj}</h3>
    			<ul class="towLayout">
    				<li>국적<span>${museumList.museum_country}</span></li>
    				<li>시대<span>${museumList.museum_age}</span></li>
    				<li>재질<span>${museumList.museum_quality}</span></li>
    				<li>크기<span>${museumList.museum_size}</span></li>
    				<li>수량<span>${museumList.museum_quanity}</span></li>
    				<li>전시장소<span>${museumList.museum_loc}</span></li>
    				<li>기증자<span>${museumList.museum_donor}</span></li>
    				<li>기증일자<span>${museumList.donor_de}</span></li>
    				<li class="li2"><span>${museumList.museum_cn}</span></li>				
				</ul> --%>
			 	<%-- <tr>
			 		<th scope="row">첨부파일</th>
			 		<td>
						  <c:if test="${eduList.atch_link_id != null}">
								<div>
								 <br/>
									<input type='button' onClick='fileView();' value='파일 보기' class="gray" style="padding:5px;">
									<c:import charEncoding="utf-8" url="/cmm/fms/selectLinkFileInfs.do">
										<c:param name="param_atchFileId" value="${dataList.atch_link_id}" />
									</c:import> 
								</div>
							</c:if>  
			 		</td>
			 	</tr> --%>
				
				<div class="btn-group">
					<a href="javascript:fn_returnListUrl()" class="basic-btn">목록으로</a>
				</div> 
			</div>			
		</div>
	</div>
	
	
	<!-- 검색 PARAM -->
	<input type="hidden" id="page" name="page" value="${museumList.page}" alt="pageNum" />
	<input type="hidden" id="searchCondition" name="searchCondition" value="${museumList.searchCondition}"  alt="검색콤보" />
	<input type="hidden" id="searchKeyword" name="searchKeyword" value="${museumList.searchKeyword}" alt="검색어" />
	
	<!-- 파일 다운로드 PARAM  -->
	<input type="hidden" id="atch_file_id" name="atch_file_id" value="${museumList.atch_file_id}" alt="첨부파일ID "/>
	<input type="hidden" id="museum_sj" name="museum_sj" value="${museumList.museum_sj}" alt="공지 제목 "/>
	
	<!-- 목록 화면 주소  -->
	<input type="hidden" id="returnListPage" name="returnListPage" value="${ctxt}/centerintro/museum/listMuseum.do" alt= "returnPage" />
	
	<!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" />
	
</form:form>
