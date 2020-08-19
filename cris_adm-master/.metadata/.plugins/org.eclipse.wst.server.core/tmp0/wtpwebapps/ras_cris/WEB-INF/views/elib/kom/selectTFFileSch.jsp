<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
/**
  * @Class Name : getVolInfoListDetail.jsp
  * @Description : 선후행저널
  * @Modification Information
  * @
  * @  수정일   	수정자		수정내용
  * @ ----------	------		---------------------------
  * @ 2016.05.31	명재홍		최초 생성
  * 
  /
  *  @author 온라인 개발팀 명재홍
  *  @since 2016.05.31
  *  @version 1.0
  *  @see
  */
%>


<c:forEach var="reqstVO" items="${resultList}">
<li style="cursor: pointer;" onclick="location.href='http://is.cdc.go.kr/upload_comm/file.do?cmd=fileDownload&SEQ=<c:out value="${reqstVO.fileSn}" escapeXml="false" />'"><img src="<c:url value='/images/cmmn/ico_pdf.png' />" border="0" alt="pdf" /> <span class="Nfont_f11_Uline">PDF</span></li>	
</c:forEach>







       