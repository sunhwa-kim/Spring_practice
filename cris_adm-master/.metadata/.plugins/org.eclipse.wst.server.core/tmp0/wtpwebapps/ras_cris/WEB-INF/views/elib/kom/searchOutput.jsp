<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ page import="java.io.*"%>
<c:if test="${file_type eq 'RIS'}">
<%response.setHeader("Content-Disposition", "attachment; filename=RIS_result.ris"); 
response.setHeader("Content-Description", "JSP Generated Data"); %>
MA - <c:out value='${ma}'/>
<% out.newLine(); %>
LA - <c:out value='${la}'/>
<% out.newLine(); %>
PA - <c:out value='${pa}'/>
</c:if>
<c:if test="${file_type eq 'NBIB'}">
<% response.setHeader("Content-Disposition", "attachment; filename=NBIB_result.nbib"); 
response.setHeader("Content-Description", "JSP Generated Data"); %>
MA - <c:out value='${ma}'/><% out.newLine(); %>
LA - <c:out value='${la}'/><% out.newLine(); %>
PA - <c:out value='${pa}'/><% out.newLine(); %>
</c:if>
<c:if test="${file_type eq 'JSON'}">
<%response.setHeader("Content-Disposition", "attachment; filename=JSON_result.json");
response.setHeader("Content-Description", "JSP Generated Data"); %> 
<c:out value='${inKoreaList}'/>
</c:if>
<c:if test="${file_type eq 'Bibtex'}">
<%response.setHeader("Content-Disposition", "attachment; filename=BIBTEX_result.txt"); 
response.setHeader("Content-Description", "JSP Generated Data"); %> 
<c:forEach var="item" items="${inKoreaList}" varStatus="loop">
[${loop.count}]  <c:set value="${fn:split(item.authorList,'^^')}" var="authorList" /><c:forEach var="authorListArray" items="${authorList}" varStatus="f">
<c:set value="${fn:split(authorListArray,'#')}" var="authorTxt" />
<c:out value="${authorTxt[0]}"/><c:if test="${!f.last}">,</c:if>
</c:forEach>.${item.title} ${item.subTitle} 
</c:forEach>
</c:if>

<%--CSV  --%>
<c:if test="${file_type eq 'CSV'}">
	<%
	 response.setHeader("Content-Disposition", "attachment; filename=CSV_result.csv"); 
	 response.setHeader("Content-Description", "JSP Generated Data"); 
	 //response.setHeader("Content-Type", "text/csv; charset=MS949");
	 response.setContentType("application/vnd.ms-excel:UTF-8");
	 // Your method that generate the CSV content
	// 	out.write(0xEF);   
	// 	out.write(0xBB);
	// 	out.write(0xBF); 
		out.write(65279);
	%>
	Title,Subtitle,Author,Language,PageStart,PageEnd,Doi,Pmid,Pmcid,Publisher
	<c:forEach var="item" items="${inKoreaList}" varStatus="loop">
		${fn:replace(item.title, ',', '/')},${fn:replace(item.subTitle, ',', '/')},<c:set value="${fn:split(item.authorList,'^^')}" var="authorList" />
		<c:forEach var="authorListArray" items="${authorList}" varStatus="f">
			<c:set value="${fn:split(authorListArray,'#')}" var="authorTxt" />
			<c:out value="${authorTxt[0]}"/><c:if test="${!f.last}">/</c:if>
		</c:forEach>,${fn:replace(item.language, '^^', '/')},${item.pageStart},${item.pageEnd},${item.DOI},${item.PMID},${item.PMCID},${item.publisher}<% out.newLine(); %>
	</c:forEach>
</c:if>
<%--XML  --%>
<c:if test="${file_type eq 'XML'}">
<%
response.setHeader("Content-Disposition", "attachment; filename=XML_result.xml"); 
response.setHeader("Content-Description", "JSP Generated Data"); 
%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE MedlineCitationSet PUBLIC "-//NLM//DTD Medline Citation, 1st January, 2015//EN"
                                    "http://www.nlm.nih.gov/databases/dtd/nlmmedlinecitationset_150101.dtd">
<MedlineCitationSet>
<c:forEach var="item" items="${inKoreaList}" varStatus="loop">
<MedlineCitation Owner="NLM" Status="PubMed-not-MEDLINE">
<PMID Version="1">${item.PMID}</PMID>
<DateCreated>
<Year></Year>
<Month></Month>
<Day></Day>
</DateCreated>
<DateCompleted>
<Year></Year>
<Month></Month>
<Day></Day>
</DateCompleted>
<DateRevised>
<Year></Year>
<Month></Month>
<Day></Day>
</DateRevised>
<Article PubModel="Print">
<Journal>
<ISSN IssnType="Print"></ISSN>
<JournalIssue CitedMedium="Print">
<Volume></Volume>
<Issue></Issue>
<PubDate>
<Year></Year>
<Month></Month>
<Day></Day>
</PubDate>
</JournalIssue>
<Title><c:out value='${item.title}'/></Title>
<ISOAbbreviation><c:set value="${fn:split(item.authorList,'^^')}" var="authorList" /><c:forEach var="authorListArray" items="${authorList}" varStatus="f">
<c:set value="${fn:split(authorListArray,'#')}" var="authorTxt" />
<c:out value="${authorTxt[0]}"/><c:if test="${!f.last}">/</c:if>
</c:forEach></ISOAbbreviation>
</Journal>
<ArticleTitle>${item.abstract}</ArticleTitle>
<Pagination>
<MedlinePgn>${item.pageStart}</MedlinePgn>
</Pagination>
<AuthorList CompleteYN="Y">
<Author ValidYN="Y">
<LastName></LastName>
<ForeName></ForeName>
<Initials></Initials>
</Author>
</AuthorList>
<Language>${fn:replace(item.language, '^^', ',')}</Language>
<PublicationTypeList>
<PublicationType UI=""></PublicationType>
</PublicationTypeList>
</Article>
<MedlineJournalInfo>
<Country></Country>
<MedlineTA></MedlineTA>
<NlmUniqueID></NlmUniqueID>
<ISSNLinking></ISSNLinking>
</MedlineJournalInfo>
<OtherID Source="NLM"><c:out value='${item.PMCID}'/></OtherID>
</MedlineCitation>
</c:forEach>
</MedlineCitationSet>
</c:if>

<c:if test="${file_type eq 'clipboard'}"> 
<!-- 클립보드일경우 -->
<script src="http://www.koreapmc.net/corehtml/pmc/js/jquery-1.4.4.min.js"></script>
<script language='Javascript'>
$(document).ready(function() {
	var trident = navigator.userAgent.match(/Trident\/(\d)/i);
	    if(trident != null){  //IE일경우
	    	copyClip();
		} else {
			//copyClip();
		temp = prompt("Copy to clipboard: Ctrl+C, Enter", $("#copyTxt").text());
		}
});

// $(document).ready(function()
// {
// //     var copyFrom = $('<textarea/>');
// //     copyFrom.text($("#copyTxt").text());
// //     $('body').append(copyFrom);
// //     copyFrom.select();
// //     document.execCommand('copy');
// //     copyFrom.remove();
    
// //     alert("Copy to clipboard.");
// /*
// 	var trident = navigator.userAgent.match(/Trident\/(\d)/i);
//     if(trident != null){
//  	 if(confirm("이 글의 트랙백 주소를 클립보드에 복사하시겠습니까?"))
// 	 window.clipboardData.setData("Text", $("#copyTxt").text());
// 	} else {
// 	temp = prompt("이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", $("#copyTxt").text());
// 	}
//  */
//   // window.clipboardData.setData('Text',$("#copyTxt").text()); // IE용
// /* zclip용
//     $('#chk').zclip({
//         path:'/pmc/js/zclip/ZeroClipboard.swf',
//         copy:$('#copyTxt').text(),
//         clickAfter:false 
//     });
//  */
// });
function copyClip(){

    var copyFrom = $('<textarea/>');
    copyFrom.text($("#copyTxt").text());
    $('body').append(copyFrom);
   // alert($("#copyTxt").text());
    copyFrom.select();
    document.execCommand('copy', null, null);
    copyFrom.remove();
   alert("Content copied to clipboard!");
}
</script>

<body>
<input id="copyClip" type="button" value="copyClip" onclick="copyClip()"/>
<div id="copyTxt" >

</div>
</body>
</c:if>
