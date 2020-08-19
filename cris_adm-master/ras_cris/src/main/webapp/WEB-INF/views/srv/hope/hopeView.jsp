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

</script>
<form:form name="reqForm" method="post">
	
	<div id="container" class="container">
		<%-- <div id="divLinemenu" class="path"><span>HOME</span> &gt; <span>ICKM</span> &gt; <span class="current">${nowMenuVO.menu_nm}</span></div>
		<h1 class="depth2-title">${nowMenuVO.menu_nm}</h1> --%>
	
		<div id="divUcont_cont">
			
			<!-- 컨텐츠 영역 -->
			<h2 class="depth3-title">교육일정 상세</h2>
			
				<table class="basic-table view">
					<caption>
						교육일정 - 교육명, 강사 , 정원, 기간, 내용, 첨부파일
					</caption>
					<colgroup>
						<col style="width:20%">
						<col>							
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">교육명</th>
							<td>
								${eduList.sj}
							</td>
						</tr>
						<tr>
							<th scope="row">강사</th>
							<td>
								${eduList.instrctr}
							</td>
						</tr>
						<tr>
							<th scope="row">정원</th>
							<td>
								${eduList.partcpt_psncpa}
							</td>
							
						</tr>
						<tr>
							<th scope="row">기간</th>
							<td>
								${eduList.begin_de} ~ ${eduList.end_de}
							</td>
							
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td>
							${eduList.intrcn_sub}
								<%-- <div id = dataCenterCn style="width: 100%;">${dataList.dataCenterCn}</div> --%>
							</td>
					 	</tr>
					 	<tr>
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
					 	</tr>
					</tbody>
				</table>
				
				
		
			
			<div class="btn-group">
				<a href="javascript:fn_returnListUrl()" class="basic-btn">목록으로</a>
			</div> 
	
			      
	
			<!-- 컨텐츠 영역 -->
	
	
		</div>
		
	</div>
	
	<!-- 검색 PARAM -->
	<input type="hidden" id="page" name="page" value="${eduList.page}" alt="pageNum" />
	<input type="hidden" id="searchCondition" name="searchCondition" value="${eduList.searchCondition}"  alt="검색콤보" />
	<input type="hidden" id="searchKeyword" name="searchKeyword" value="${eduList.searchKeyword}" alt="검색어" />
	
	<!-- 파일 다운로드 PARAM  -->
	<input type="hidden" id="atch_link_id" name="atch_link_id" value="${eduList.atch_link_id}" alt="첨부파일ID "/>
	<input type="hidden" id="sj" name="sj" value="${eduList.sj}" alt="공지 제목 "/>
	
	<!-- 목록 화면 주소  -->
	<input type="hidden" id="returnListPage" name="returnListPage" value="${ctxt}/edu/listEdu.do" alt= "returnPage" />
	
	<!-- 공통  필수 PARAM  -->
	<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" /> --%>
	
</form:form>
