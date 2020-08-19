<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
#divEtcarea img{
	width:100%;
}
.view_table>tbody.report>tr{
	line-height: 170%; 
}
</style>


<script type="text/javascript">



function fileView() {
	
	  var form =document.reqForm;
	  var contextName = "ncmik";
	  var fileKey = form.atch_link_id.value;
      var pageTitle = form.alit_sj.value;

      popAttfileViewIn(fileKey, contextName, pageTitle);
}

</script>
<form name="reqForm" method="post">

	<!-- 컨텐츠 영역 -->
	<div class="sub_center_text">
		<div class="sub_center_nav">
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>
			<span> > </span> <span>센터소개</span> <span> > </span> <span class="active">공지사항</span>
		</div>

		<span class="center_text_01">공지사항</span>

	</div>

	<div class="under_bar"></div>
		<div class="content_wrap">
			<div class="content_box">
					<div class="content_list">

		<!-- 컨텐츠 영역 -->
		<div class="list_title">
			<p>공지사항 상세</p>
		</div>
		<!-- <h2 class="depth-title">알림마당 상세</h2> -->

		<table class="view_table">
			<caption>공지사항 - 제목, 등록일 , 조회수 , 내용, 첨부파일</caption>
			<colgroup>
				<col style="width: 20%">
				<col>
			</colgroup>
			<tbody class="report">
				<tr>
					<th scope="row">제목</th>
					<td align="left">${resultVO.alit_sj}</td>
				</tr>
				<tr>
					<th scope="row">등록일</th>
					<td align="left">${resultVO.frst_regist_pnttm}</td>
				</tr>
				<tr>
					<th scope="row">조회수</th>
					<td align="left">${resultVO.rdcnt}</td>

				</tr>
				<tr>
					<th scope="row">내용</th>
					<td align="left">
						<div id='divEtcarea' style="width: 100%;">${resultVO.alit_cn}</div>
					</td>

				</tr>

				<tr>
					<th scope="row">첨부파일</th>
					<td><c:if test="${resultVO.atch_link_id != null}">
							<div>
								<br /> <input type='button' onClick='fileView();' value='파일 보기'
									class="gray" style="padding: 5px;">
								<c:import charEncoding="utf-8"
									url="/cmm/fms/selectLinkFileInfs.do">
									<c:param name="param_atchFileId"
										value="${resultVO.atch_link_id}" />
								</c:import>
							</div>
						</c:if></td>
				</tr>
			</tbody>
		</table>




		<div class="btn-group">
			<a href="javascript:fn_returnListUrl()" class="basic-btn">목록으로</a>
		</div>



		<!-- 컨텐츠 영역 -->


	</div>
	</div>
	</div>
	



	<!-- 검색 PARAM -->
	<input type="hidden" id="page" name="page" value="${resultVO.page}"
		alt="pageNum" /> <input type="hidden" id="searchCondition"
		name="searchCondition" value="${resultVO.searchCondition}" alt="검색콤보" />
	<input type="hidden" id="searchKeyword" name="searchKeyword"
		value="${resultVO.searchKeyword}" alt="검색어" />

	<!-- 파일 다운로드 PARAM  -->
	<input type="hidden" id="atch_link_id" name="atch_link_id"
		value="${resultVO.atch_link_id}" alt="첨부파일ID " /> <input type="hidden"
		id="alit_sj" name="alit_sj" value="${resultVO.alit_sj}" alt="공지 제목 " />

	<!-- 목록 화면 주소  -->
	<input type="hidden" id="returnListPage" name="returnListPage"
		value="${ctxt}/centerintro/noti/notiList.do" alt="returnPage" />

	<!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}"
		value="${_csrf.token}" alt="token" />

</form>
