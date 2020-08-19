<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Map"%>
<%
/**
  * @Class Name : getVolinfo.jsp
  * @Description : 볼륨정보
  * @Modification Information
  * @
  * @  수정일   	수정자		수정내용
  * @ ----------	------		---------------------------
  * @ 2015.07.15	명재홍		최초 생성
  * 
  /
  *  @author 온라인 개발팀 명재홍
  *  @since 2015.07.15
  *  @version 1.0
  *  @see t_melementinfo
  SELECT  *
  FROM t_melementinfo
  START WITH elementid in ('100000')
  CONNECT BY PRIOR elementid=parentelement
  ORDER SIBLINGS BY elementid  
  */
%>
<%--  변수저장 --%>
<script type="text/javascript">
function meshSch(type,stext){
	var meshFrm = document.meshSchForm;
	var fltWhereQuery ="";
	
	if (type == "MeSHMainHeading")
		fltWhereQuery =fltWhereQuery +" and meshMainHeading='"+stext+"'";
	if (type == "MeSHSubHeading")	
		fltWhereQuery =fltWhereQuery +" and meshSubHeading='"+stext+"'";
	if (type == "MeSHCheckTag")	
		fltWhereQuery =fltWhereQuery +" and flt_MeSHCheckTag_l in {'"+stext+"'}";
	if (type == "MeSHGeoDesc")	
		fltWhereQuery =fltWhereQuery +" and flt_MeSHGeoDesc_l in {'"+stext+"'}";
	if (type == "MeSHPubType")	
		meshFrm.searchArticleList.value=stext;
	if (type == "MeSHTopicalDesc")	
		fltWhereQuery =fltWhereQuery +" and flt_MeSHTopicalDesc_l in {'"+stext+"'}";
	meshFrm.submit();  
}

</script>

<c:if test="${! empty resultList}">
	<ul id="meshmenu" class="meshInputUL">
		<li  class="black3bold" style="margin: 10px 0 0 0"><a href="#" style="font-size:14px; color: #985735;">(+)Publication Types, MeSH Terms</a>
		<ul class="meshPubTypeInputUL">
		  <li id="JOU_smallbox_22" style="margin-top:15px;" class="ar_dr_t">Publication Types</li>
		  <c:forEach var="reqstVO" items="${resultList}" varStatus="status"> 	
			<c:if test="${reqstVO.elementName eq 'MeSHPubType' }">
			  <li id="meshPubTypeInput" class="black2_Uline"  style="word-break:normal;height:19px;padding-bottom:15px;">
			  	<a class="meshPubTypeInput"  style="height:19px;" href="javascript:meshSch('<c:out value="${reqstVO.elementName}" escapeXml="false" />','<c:out value="${reqstVO.elementText}" escapeXml="false" />')"><c:out value="${reqstVO.elementText}" escapeXml="false" /></a>
			  </li>
			</c:if>	    
		  </c:forEach>		
			<li id="JOU_smallbox_23" style="margin-top: 10px;" class="ar_dr_t">MeSH Terms<!-- Publication Types, MeSH Terms --></li>
			<c:forEach var="reqstVO" items="${resultList}" varStatus="status"> 	  
			   <c:if test="${reqstVO.elementName ne 'MeSHPubType' }">
				<li id="meshTermsInput" class="black2_Uline"  style="word-break:normal;"><a style="color: #14376c;" href="javascript:meshSch('<c:out value="${reqstVO.elementName}" escapeXml="false" />','<c:out value="${reqstVO.elementText}" escapeXml="false" />')"><c:out value="${reqstVO.elementText}" escapeXml="false" /></a></li>
			   </c:if>	
			</c:forEach>	
		</ul>
	    </li>
	</ul> 
</c:if>	
           
<%-- <form id="meshSchForm" name="meshSchForm" method="post" action="<c:out value="/ncmiklib"/>/elib/kom/listArticle.do"  >
    <input type="hidden" name="category" value="INKOREA" />
	<input name="searchArticleGroupList" value="" type="hidden">	
</form>     --%>     
<form id="meshSchForm" name="meshSchForm" action="${ctxt}/elib/kom/listArticle.do" method="post">  
	<input type="hidden" id="searchQueryMove" name="searchQuery" value="${vo.searchQuery}" />
	<input type="hidden" id="pageNumMove" name="pageNum" value="${vo.pageNum}" />
	<input type="hidden" id="pageSizeMove" name="pageSize" value="${vo.pageSize}" />
	<input type="hidden" id="searchSortMove" name="searchSort" value="${vo.searchSort}" />
	<input type="hidden" id="searchTargetMove" name="searchTarget" value="${vo.searchTarget}" />
	<input type="hidden" id="searchSubTargetMove" name="searchSubTarget" value="${vo.searchSubTarget}" />
	<input type="hidden" id="searchYearMove" name="searchYear" value="${vo.searchYear}" />
	<input type="hidden" id="searchNlmcMove" name="searchNlmc" value="${vo.searchNlmc}" />
	<input type="hidden" id="searchLangMove" name="searchLang" value="${vo.searchLang}" />
	<input type="hidden" id="abstract_ynMove" name="abstract_yn" value="${vo.abstract_yn}" />
	<input type="hidden" id="fulltext_ynMove" name="fulltext_yn" value="${vo.fulltext_yn}" />
	<input type="hidden" id="startDateMove" name="startDate" value="${vo.startDate}" />
	<input type="hidden" id="endDateMove" name="endDate" value="${vo.endDate}" />
	<input type="hidden" id="searchCondition1" name="searchCondition1" value="${vo.searchCondition1}" />
	<input type="hidden" id="detailInput1" name="detailInput1" value="${vo.detailInput1}" />
	<input type="hidden" id="selectOption1" name="selectOption1" value="${vo.selectOption1}" />
	<input type="hidden" id="searchCondition2" name="searchCondition1" value="${vo.searchCondition1}" />
	<input type="hidden" id="detailInput2" name="detailInput2" value="${vo.detailInput2}" />
	<input type="hidden" id="selectOption2" name="selectOption2" value="${vo.selectOption2}" />
	<input type="hidden" id="searchCondition3" name="searchCondition3" value="${vo.searchCondition3}" />
	<input type="hidden" id="detailInput3" name="detailInput3" value="${vo.detailInput3}" />
	<input type="hidden" id="selectOption3" name="selectOption3" value="${vo.selectOption3}" />
	<input type="hidden" id="subjectArea" name="subjectArea" value="${vo.subjectArea}" />
	<input type="hidden" id="detailInput4" name="detailInput4" value="${vo.detailInput4}" />
	<input type="hidden" id="detailInput5" name="detailInput5" value="${vo.detailInput5}" />
	<input type="hidden" name="searchArticleList" value="${searchArticleList}" />

</form>


<script type="text/javascript">
/*메뉴슬라이딩 */
function initMenu() {
 
  $('#meshmenu ul').hide();
  $('#meshmenu ul').children('.on').parent().show();
  //$('#menu ul:first').show();
  $('#meshmenu li a').click(
    function() {
      var checkElement = $(this).next();
      if((checkElement.is('ul')) && (checkElement.is(':visible'))) {
    	$('#meshmenu ul:visible').slideUp(300);
        return false;
        }
      if((checkElement.is('ul')) && (!checkElement.is(':visible'))) {
        $('#meshmenu ul:visible').slideUp(300);
        checkElement.slideDown(300);
        return false;
        }
      }
    );
  }
window.onload=initMenu;
</script>             

	 


