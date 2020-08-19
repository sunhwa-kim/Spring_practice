<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%  

%>
<script type="text/javascript">

	function fn_egov_downFile(atchFileId, fileSn){

		fileView();
	}

	function fn_egov_deleteFile(atchFileId, fileSn) {
		forms = document.getElementsByTagName("form");

		for (var i = 0; i < forms.length; i++) {
			if (typeof(forms[i].atchFileId) != "undefined" &&
					typeof(forms[i].fileSn) != "undefined" &&
					typeof(forms[i].fileListCnt) != "undefined") {
				form = forms[i];
			}
		}

		//form = document.forms[0];
		form.atchFileId.value = atchFileId;
		form.fileSn.value = fileSn;
		form.action = "<c:url value='/cmm/fms/deleteFileInfs.do'/>";
		form.submit();
	}

	function fn_egov_check_file(flag) {
		if (flag=="Y") {
			document.getElementById('file_upload_posbl').style.display = "block";
			document.getElementById('file_upload_imposbl').style.display = "none";
		} else {
			document.getElementById('file_upload_posbl').style.display = "none";
			document.getElementById('file_upload_imposbl').style.display = "block";
		}
	}
</script>

<!-- <form name="fileForm" action="" method="post" >  -->
<input type="hidden" name="atch_file_id" value="<c:out value='${atch_file_id}'/>">
<input type="hidden" name="file_sn" >
<input type="hidden" name="fileListCnt" id="fileListCnt" value="<c:out value='${fileListCnt}'/>">

<!-- </form>  -->

<!--<title>파일목록</title> -->

	<table style="margin:0px 0">
	
 
		<c:forEach var="fileVO" items="${fileList}" varStatus="status">
		<tr>
			<td style="border-top:0px;border-bottom:0px;">		
				<a href="javascript:fn_egov_downFile('<c:out value="${fileVO.atch_file_id}"/>','<c:out value="${fileVO.file_sn}"/>')">
				<c:out value="${fileVO.orignl_file_nm}"/>&nbsp;[<c:out value="${fileVO.file_size}"/>&nbsp;byte]
				</a>			
			</td>
		</tr>
		</c:forEach>
	  	
		
		<c:if test="${fn:length(fileList) == 0}">
			<tr>
				<td style="border-top:hidden;border-bottom:hidden;"></td>
			</tr>
	    </c:if>
	</table>
