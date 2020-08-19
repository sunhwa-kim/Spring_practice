<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
function updateHopeLib(){
	form = document.reqForm;
	form.action = "${ctxt}/mylib/hopeLib/viewUpdatehopeLib.do";
	form.submit();
}
function deleteHopeLib(){
	if(confirm("취소하시겠습니까?")){
		form = document.reqForm;
		form.action = "${ctxt}/mylib/hopeLib/updateStathopeLib.do";
		form.submit();
	}

	
}
</script>
<form name="reqForm" method="post">	 
	
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>My Library</span>
			<span> > </span>
			<span class="active">희망도서 상세정보</span>        
		</div>
		<span class="center_text_01">희망도서 상세정보</span>
	</div> 
	<div class="under_bar"></div>
	
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
		<table class="view_table">
		<caption>
			희망도서상세정보 - 도서구분,서명,저자,출판사,수량,	출판연도,ISBN,비고
		   </caption>
		<colgroup>
			<col width="20%">
			<col width="30%">
			<col width="10%">
			<col width="40%">
		</colgroup>
		<tbody class="report">
			  <tr>
			  	<th>도서구분<font style="color:red">*</font></th>
			    <td  colspan="3">
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${result.jobGubun == 'm'}"> --%>
<%--                 			<c:out value="단행본(${result.jobGubun})" /> --%>
<%--                 		</c:when> --%>
<%--                 		<c:when test="${result.jobGubun == 'k'}"> --%>
<%--                 			<c:out value="비도서(${result.jobGubun})" /> --%>
<%--                 		</c:when> --%>
<%-- 						<c:otherwise> --%>
<%-- 							<c:out value="E-Book(${result.jobGubun})" /> --%>
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
				<c:out value="${result.jobGubun}" />
				</td>
			  </tr>		  
		
			  <tr>
			  	<th>서명<font style="color:red">*</font></th>
			    <td colspan="3"><c:out value="${result.title}" /></td>
			  </tr>
			  
			  <tr>
			  	<th>저자<font style="color:red">*</font></th>
			    <td colspan="3"><c:out value="${result.author}" /></td>
			  </tr>
			  
			  <tr>
			  	<th scope="row">출판사<font style="color:red">*</font></th>
			    <td><c:out value="${result.publisher}" /></td>
			    <th scope="row">수량</th>
			    <td><c:out value="${result.bookCnt}"/></td>
			  </tr>
			  
			  <tr>
			  	<th scope="row">출판연도</th>
			    <td> <c:out value="${result.publisherYear}"/></td>
			    <th scope="row">ISBN</th>
			    <td> <c:out value="${result.isbn}"/></td>
			  </tr>
			  
			  <tr>
			  	<th>비고</th>
			    <td colspan="3"><c:out value="${result.remark}" /></td>
			  </tr>  
			  		  
		  </tbody>
		</table>
	
		<div class="btn-group">
			
		<c:if test="${result.processState == '신청'}">
			<a href="javascript:deleteHopeLib();" class="basic-btn">신청취소</a>
			<a href="javascript:updateHopeLib();" class="basic-btn">수정</a>
		</c:if>	
			
			
			<a href="javascript:fn_returnListUrl();" class="basic-btn">목록으로</a>
		</div>	
		
	</div>
	</div>
	</div>	

	<!-- 검색 PARAM -->
	<input type="hidden" id="page" name="page" value="${result.page}" alt="pageNum" />
	<input type="hidden" id="searchCondition" name="searchCondition" value="${result.searchCondition}"  alt="검색콤보" />
	<input type="hidden" id="searchKeyword" name="searchKeyword" value="${result.searchKeyword}" alt="검색어" />

	<!-- 목록 화면 주소  -->
	<input type="hidden" id="returnListPage" name="returnListPage" value="${ctxt}/mylib/hopeLib/hopeLibList.do"  alt= "returnPage" />

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" name="hopeno" value="${param.hopeno}">

</form>
