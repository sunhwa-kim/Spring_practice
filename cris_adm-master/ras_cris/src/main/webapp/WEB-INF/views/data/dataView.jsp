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
    var pageTitle = form.data_center_sj.value;

    popAttfileViewIn(fileKey, contextName, pageTitle);
}	

</script>
<form:form name="reqForm" method="post">
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>데이터센터</span>
			<span> > </span>
			<span class="active">데이터 목록</span>        			      
		</div>
		<span class="center_text_01">데이터 목록</span>
	</div> 
	<div class="under_bar"></div>
		
	<div class = "content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div class="list_title">
					<p id="search_cn">데이터목록 상세</p>
				</div>	
				<table class=  "view_table">
					<caption>
						데이터목록 - 제목,구분,정보제공처,최초등록일,내용
					</caption>
					<colgroup>
						<col style="width:20%">
						<col>							
					</colgroup>
					<tbody class="report">
						<tr>
							<th scope="row">제목</th>
							<td>
								${dataList.data_center_sj}
							</td>
						</tr>
						<tr>
							<th scope="row">구분</th>
							<td>
								${dataList.data_center_gbnm}
							</td>
						</tr>
						<tr>
							<th scope="row">정보제공처</th>
							<td>
								${dataList.data_info}
							</td>
							
						</tr>
						<tr>
							<th scope="row">최초등록일</th>
							<td>
								${dataList.frst_regist_pnttm}
							</td>
							
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td>
							${dataList.data_center_cn}
								<%-- <div id = dataCenterCn style="width: 100%;">${dataList.dataCenterCn}</div> --%>
							</td>
					 	</tr>
					 	<%-- <tr>
					 		<th scope="row">첨부파일</th>
					 		<td>
								  <c:if test="${dataList.atch_link_id != null}">
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
					</tbody>
				</table>			
				<div class="btn-group">
					<a href="javascript:fn_returnListUrl()" class="basic-btn"  >목록으로</a>
				</div> 
			</div>
		</div>
	</div>
	
	<!-- 검색 PARAM -->
	<input type="hidden" id="page" name="page" value="${dataList.page}" alt="pageNum" />
	<input type="hidden" id="searchCondition" name="searchCondition" value="${dataList.searchCondition}"  alt="검색콤보" />
	<input type="hidden" id="searchKeyword" name="searchKeyword" value="${dataList.searchKeyword}" alt="검색어" />
	<input type="hidden" id="data_center_gbn" name=data_center_gbn value="${dataList.data_center_gbn}" alt="데이터 구분" />
	
	
	<!-- 파일 다운로드 PARAM  -->
	<input type="hidden" id="atch_link_id" name="atch_link_id" value="${dataList.atch_link_id}" alt="첨부파일ID "/>
	<input type="hidden" id="data_center_sj" name="data_center_sj" value="${dataList.data_center_sj}" alt="공지 제목 "/>
	
	<!-- 목록 화면 주소  -->
	<input type="hidden" id="returnListPage" name="returnListPage" value="${ctxt}/data/listData.do" alt= "returnPage" />
	
	<!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" />
	
</form:form>
