<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="java.io.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${file_type eq 'RIS'}"> <%--RIS --%>
<% response.setHeader("Content-Disposition", "attachment; filename=RIS_result.ris");
response.setHeader("Content-Description", "JSP Generated Data"); %>
<c:out value="TY - ${inKoreaList.TYPE}" /> <% out.newLine(); %>
<c:out value="TI - ${inKoreaList.TITLE}" /><% out.newLine(); %>
T2 - <c:if test="${inKoreaList.ABBREVIATIONTTITLE ne '' && not empty inKoreaList.ABBREVIATIONTTITLE}">
<c:out value="${inKoreaList.ABBREVIATIONTTITLE}" /> </c:if> AU - ${inKoreaList.AUTHOR}"/><% out.newLine(); %> <% out.newLine(); %>
<c:out value="SP - ${inKoreaList.PAGESTART}" /> <% out.newLine(); %> <c:out value="EP - ${inKoreaList.PAGEEND}" /> <% out.newLine(); %>
 <c:out value="KW - ${inKoreaList.KEYWORD}" /> <% out.newLine(); %> <c:out value="LA - ${inKoreaList.LANGUAGE}" /> <% out.newLine(); %> 
 <c:out value="AB - ${inKoreaList.ABSTRACT1}" /> <% out.newLine(); %> <c:out value="DO - ${inKoreaList.DOI}" /> <% out.newLine(); %>
 <c:out value="PMID - ${inKoreaList.PMID}" /> <% out.newLine(); %> <c:out value="PMCID - ${item.PMCID}" /> <% out.newLine(); %>
 <c:out value="PUBLISHER - ${inKoreaList.PUBLISHER}" /> <% out.newLine(); %> <% out.newLine(); %> 
 </c:if>
 <c:if test="${file_type eq 'JSON'}">
 <%  
 response.setHeader("Content-Disposition", "attachment; filename=JSON_result.json");
 response.setHeader("Content-Description", "JSP Generated Data"); %>
 </c:if>
 <c:if test="${file_type eq 'Bibtex'}">
 <%
 response.setHeader("Content-Disposition", "attachment; filename=BIBTEX_result.txt"); 
 response.setHeader("Content-Description", "JSP Generated Data"); %>
 <c:forEach var="item" items="${inKoreaList}" varStatus="loop"> [${loop.count}] 
 <c:set value="${fn:split(item.authorList,'^^')}" var="authorList" /> 
 <c:forEach var="authorListArray" items="${authorList}" varStatus="f"> 
 <c:set value="${fn:split(authorListArray,'#')}" var="authorTxt" />
 <c:out value="${authorTxt[0]}" /> <c:if test="${!f.last}">,</c:if> 
 </c:forEach>.${item.title} ${item.subTitle} </c:forEach> 
 </c:if> 
 <c:if test="${file_type eq 'csv'}">
  <%response.setHeader("Content-Disposition", "attachment; filename=CSV_result.csv"); 
	response.setHeader("Content-Description", "JSP Generated Data"); 
	response.setContentType("application/vnd.ms-excel:UTF-8");  
	out.write(65279);%> <c:if test="${db_gbn eq 'KMBASE'}">KMBASEID</c:if><c:if test="${db_gbn ne 'KMBASE'}">KNLMID</c:if>,Title,Author,Language,Page,Doi,JournalName,Publisher
<c:out value='${inKoreaList.KNLMID}'/>,<c:out value='${inKoreaList.TITLE}'/>,${fn:replace(inKoreaList.AU, ',', '/')},${fn:replace(inKoreaList.LA, '^^', ',')},<c:out value='${inKoreaList.PAGE}'/>,<c:out value='${inKoreaList.DOI}'/>,<c:out value='${inKoreaList.JT}'/>,<c:out value='${inKoreaList.PUBLISHER}'/><% out.newLine(); %> 
 </c:if>
 <c:if test="${file_type eq 'nbib'}">
 <% response.setHeader("Content-Disposition", "attachment; filename=NBIB_result.nbib"); 
 response.setHeader("Content-Description", "JSP Generated Data"); %> 
<c:if test="${db_gbn eq 'KMBASE'}"><c:out value="KMBASEID - ${inKoreaList.KNLMID}" /> <% out.newLine(); %></c:if>
<c:if test="${db_gbn ne 'KMBASE'}"><c:out value="KNLMID - ${inKoreaList.KNLMID}" /> <% out.newLine(); %></c:if>
<c:out value="OWN - ${inKoreaList.OWN}" /> <% out.newLine(); %>
<c:out value="ISSN - ${inKoreaList.PISSN}" /> <% out.newLine(); %>
<c:out value="ISSN - ${inKoreaList.EISSN}" /> <% out.newLine(); %>
<c:out value="DP - ${inKoreaList.DP}" /> <% out.newLine(); %>
<c:out value="TI - ${inKoreaList.TITLE}" /> <% out.newLine(); %>
<c:out value="LID - ${inKoreaList.LID}" /> <% out.newLine(); %>
<c:out value="AB - ${inKoreaList.AB}" /> <% out.newLine(); %>
<c:out value="AB - ${inKoreaList.AB2}" /> <c:set value="${inKoreaList.AU}" var="item" /> 
<c:set value="${fn:split(item,',')}" var="authorList" /> <c:forEach var="authorListArray" items="${authorList}" varStatus="f"> <c:set value="${fn:split(authorListArray,'#')}" var="authorTxt" /> <% out.newLine(); %>
<c:out value="AU - ${fn:trim(authorTxt[0])}" /> </c:forEach> <% out.newLine(); %>
<c:out value="LA - ${inKoreaList.LA}" /> <% out.newLine(); %><c:out value="PT - ${inKoreaList.PT}" /> <% out.newLine(); %>
<c:out value="JT - ${inKoreaList.JT}" /> <% out.newLine(); %> <% out.newLine(); %> 
</c:if>
<c:if test="${file_type eq 'XML'}">
<% response.setHeader("Content-Disposition", "attachment; filename=XML_result.xml"); 
response.setHeader("Content-Description", "JSP Generated Data"); %>   
<?xml version="1.0" encoding="UTF-8"?> 
<!DOCTYPE MedlineCitationSet PUBLIC "-//NLM//DTD Medline Citation, 1st January, 2015//EN" "http://www.nlm.nih.gov/databases/dtd/nlmmedlinecitationset_150101.dtd"> 
<MedlineCitationSet> 
<c:forEach var="item" items="${inKoreaList}" varStatus="loop"> 
<MedlineCitation Owner="NLM" Status="PubMed-not-MEDLINE"> 
<PMID Version="1">${item.PMID}</PMID>
<DateCreated> <Year></Year> <Month></Month> <Day></Day> 
</DateCreated> <DateCompleted> <Year></Year> <Month></Month> <Day></Day> </DateCompleted> <DateRevised> <Year></Year> <Month></Month> <Day></Day> </DateRevised> <Article PubModel="Print"> <Journal> <ISSN IssnType="Print"></ISSN> <JournalIssue CitedMedium="Print"> <Volume></Volume> <Issue></Issue> <PubDate> <Year></Year> <Month></Month> <Day></Day> </PubDate> </JournalIssue> <Title><c:out value='${item.title}'/></Title> <ISOAbbreviation> <c:set value="${fn:split(item.authorList,'^^')}" var="authorList" /> <c:forEach var="authorListArray" items="${authorList}" varStatus="f"> <c:set value="${fn:split(authorListArray,'#')}" var="authorTxt" /> <c:out value="${authorTxt[0]}" /> <c:if test="${!f.last}">/</c:if> </c:forEach></ISOAbbreviation> </Journal> <ArticleTitle><c:out value='${item.abstract}'/></ArticleTitle> <Pagination> <MedlinePgn><c:out value='${item.pageStart}'/></MedlinePgn> </Pagination> <AuthorList CompleteYN="Y"> <Author ValidYN="Y"> <LastName></LastName> <ForeName></ForeName> <Initials></Initials> </Author> </AuthorList> <Language>${fn:replace(item.language, '^^', ',')}</Language> <PublicationTypeList> <PublicationType UI=""></PublicationType> </PublicationTypeList> </Article> <MedlineJournalInfo> <Country></Country> <MedlineTA></MedlineTA> <NlmUniqueID></NlmUniqueID> <ISSNLinking></ISSNLinking> </MedlineJournalInfo> <OtherID Source="NLM"><c:out value='${item.PMCID}'/></OtherID> </MedlineCitation> </c:forEach> </MedlineCitationSet> </c:if> <c:if test="${file_type eq 'clipboard'}"> <script src="http://www.koreapmc.net/corehtml/pmc/js/jquery-1.4.4.min.js"></script> <script language='Javascript'> $(document).ready(function() { var trident = navigator.userAgent.match(/Trident\/(\d)/i); if(trident != null){ } else { temp = prompt("Copy to clipboard: Ctrl+C, Enter", $("#copyTxt").text()); } }); function copyClip(){ var copyFrom = $('<textarea/>'); copyFrom.text($("#copyTxt").text()); $('body').append(copyFrom); document.execCommand('copy', null, null); copyFrom.remove(); alert("Content copied to clipboard!"); } </script> <body> <input id="copyClip" type="button" value="copyClip" onclick="copyClip()" /> <div id="copyTxt"></div> </body> </c:if>