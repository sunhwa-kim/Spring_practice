<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="java.io.*"%>
<%@page import="kr.go.cris.ptl.eds.bean.*" language="java"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:if test="${file_type eq 'csv'}">
	 <%response.setHeader("Content-Disposition", "attachment; filename=CSV_result.csv"); 
	response.setHeader("Content-Description", "JSP Generated Data"); 
	response.setContentType("application/vnd.ms-excel:UTF-8");  
	out.write(65279);%>ArticleTitle,Author,Journal Title,ISSN,Publication Date,Volume,Issue,First Page ,Page Count,Accession Number, DOI, PubType ,Subjects,Abstract, PLink
	${fn:replace(articleTitle, ',', ' ')}, ${fn:replace(author, ',', ' ')}, ${fn:replace(journalTitle, ',', ' ')}, ${issn != 'null' ?  issn : ''}, ${publicationDate != 'null' ? publicationDate : ''}, ${volume != 'null' ? volume : ''}, ${issue != 'null' ? issue : ''}, ${firstPage != 'null' ? firstPage : ''}, ${pageCount != 'null' ? pageCount : ''}, ${accessionNumber}, ${fn:replace(doi, ',', ' ') != 'null' ? fn:replace(doi, ',', '/') : ''}, ${pubType != 'null' ? pubType : ''}, ${fn:replace(subj, ',', ' ') != 'null'? fn:replace(subj, ',', ' ') : ''}, ${fn:replace(abs, ',', ' ')}, ${pLink != 'null' ? pLink : ''}<% out.newLine(); %> 
</c:if>
 <c:if test="${file_type eq 'nbib'}">
 <% response.setHeader("Content-Disposition", "attachment; filename=NBIB_result.nbib"); 
 response.setHeader("Content-Description", "JSP Generated Data"); %> 
<c:out value="AN - ${accessionNumber}" /> <% out.newLine(); %>
<c:out value="ID - ${accessionNumber}" /> <% out.newLine(); %>
<c:out value="T1 - ${articleTitle}" /> <% out.newLine(); %>

<c:set value="${fn:split(author,';')}" var="authorList" /> <c:forEach var="authorListArray" items="${authorList}" varStatus="f"> <c:set value="${fn:split(authorListArray,'#')}" var="authorTxt" /> <% out.newLine(); %>
<c:if test = "${fn:trim(authorTxt[0]) != 'null' and fn:trim(authorTxt[0]) != ''}">
<c:out value="AU - ${fn:trim(authorTxt[0])}" /> </c:if> </c:forEach>  <% out.newLine(); %>

<c:out value="Y1 - ${publicationDate}" /> <% out.newLine(); %>
<c:out value="N1 - Accession Number : ${accessionNumber}." />			
		<c:if test = "${lang != 'null' and lang != ''}"><c:out value = "Language: ${lang}." /></c:if>			
		<c:if test = "${publicationDate != 'null' and publicationDate != ''}"><c:out value = "Publication Date:${publicationDate}. " /> </c:if>
		<c:if test = "${entryDate != 'null' and entryDate != ''}"><c:out value = "Entry Date: ${entryDate}. " /></c:if>
		<c:if test = "${revisionDate != 'null' and revisionDate != ''}"><c:out value = "Revision Date: ${revisionDate}." /> </c:if>
		<c:if test = "${typPub != 'null' and typPub != ''}"><c:out value = "Publication Type: ${typPub}. " /></c:if>
		<c:if test = "${src != 'null' and src != ''}"><c:out value = "Source:${src}. " /> </c:if>
		<c:if test = "${subset != 'null' and subset != ''}"><c:out value = "Journal Subset: ${subset}. " /></c:if>
		<c:if test = "${subset != 'null' and subset != ''}"> <c:out value = "${medline}. "/> </c:if>
		<c:if test = "${cpyrght != 'null' and cpyrght != ''}"><c:out value = "Copyright: ${cpyrght}" /></c:if>
		<% out.newLine(); %>

<c:set value="${fn:split(subj,';')}" var="subjList" /> <c:forEach var="subjListArray" items="${subjList}" varStatus="f"> <c:set value="${fn:split(subjListArray,'#')}" var="subjTxt" /> <% out.newLine(); %>
<c:if test = "${fn:trim(subjTxt[0]) != 'null' and fn:trim(subjTxt[0]) != ''}">
<c:out value="KW - ${fn:trim(subjTxt[0])}" /> </c:if></c:forEach> <% out.newLine(); %>

<c:if test = "${firstPage != 'null' and firstPage != ''}">
	<c:out value="SP - ${firstPage}" /> <% out.newLine(); %>
</c:if>
<c:if test = "${totalPage != 'null' and totalPage != ''}">
	<c:out value="EP - ${totalPage}" /> <% out.newLine(); %>
</c:if>
<c:if test = "${journalTitle != 'null' and journalTitle != ''}">
	<c:out value="JO - ${journalTitle}" /> <% out.newLine(); %>
	<c:out value="JF - ${journalTitle}" /> <% out.newLine(); %>
</c:if>
<c:if test = "${pubInfo != 'null' and pubInfo != ''}">
	<c:out value="PB - ${pubInfo}" /> <% out.newLine(); %>
</c:if>
<c:if test = "${volume != 'null' and volume != ''}">
	<c:out value="VL - ${volume}" /> <% out.newLine(); %>
</c:if>
<c:if test = "${issue != 'null' and issue != ''}">
	<c:out value="IS - ${issue}" /> <% out.newLine(); %>
</c:if>
<c:if test = "${abs != 'null' and abs != ''}">
	<c:out value="AB - ${abs}" /> <% out.newLine(); %>
</c:if>
<c:if test = "${issn != 'null' and issn != ''}">
	<c:out value="SN - ${issn}" /> <% out.newLine(); %>
</c:if>
<c:if test = "${doi != 'null' and doi != ''}">
	<c:out value="DO - ${doi}" /> <% out.newLine(); %>
</c:if>

<c:if test = "${pLink != 'null' and pLink != ''}">
	<c:out value="UR - ${pLink}" /> <% out.newLine(); %>
</c:if>
<c:out value="DP - EBSCOhost" /> <% out.newLine(); %>
<c:out value="DB - ${dbid}" /> <% out.newLine(); %>
</c:if>