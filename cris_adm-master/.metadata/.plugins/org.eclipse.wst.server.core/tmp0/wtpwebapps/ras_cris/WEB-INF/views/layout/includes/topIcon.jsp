<%--
  Class Name : footer.jsp
  Description : JSP코딩
  Modification Information
 
          수정일                     수정자                   수정내용
    -------    --------    ---------------------------
  2015.02.12    명재홍                  초기 버전 생성
 
    author   : 온라인팀 명재홍 
    since    : 2015.02.12  
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
<!--

//-->

function print(){
	$(".print-preview").printPreview();
	
}
</script>
<span>글씨</span>
<a href="#" onclick="contentsZoom(this)" onkeypress="contentsZoom(this)" class="zoom-in" id="larger" title="확대">확대</a>
<a href="#" onclick="contentsZoom(this)" onkeypress="contentsZoom(this)" class="zoom-out" id="smaller" title="축소">축소</a>
<c:choose>
	<%-- 미니라벨프린터 출력 --%>
	<c:when test="${params.detailType eq 'book' || params.detailType eq 'nonbook' || params.detailType eq 'report' || params.detailType eq 'journal'}">
		<a href="#" onclick="javascript:miniLabelPrint();" class="br_none"><img src="${ctxt}/resources/images/common/icon-print.png" width="14" height="14" alt="프린트" title="프린트" /></a>
	</c:when>
	
	<%-- 일반 프린터 출력 --%>
	<c:otherwise>
		<a href="#" onclick ="javascript:print();" class="print-preview br_none"><img src="${ctxt}/resources/images/common/icon-print.png" width="14" height="14" alt="프린트" title="프린트" /></a>	
	</c:otherwise>
</c:choose>
<!-- /<button type="button" class="print-preview print" >인쇄</button> / -->
<!-- <button type="button" class="save">저장</button> -->

<a href="javascript:sendSNS('facebook','국립의과학지식센터>센터 이용안내')" class="sns_br_none"><img  src="${ctxt}/resources/images/common/ic_facebook.gif" alt="facebook-새창" title="facebook-새창"/></a>
<a href="javascript:sendSNS('twitter','국립의과학지식센터>센터 이용안내')" class="sns_br_none"><img src="${ctxt}/resources/images/common/ic_twitter.gif" alt="twitter-새창" title="twitter-새창" /></a>

<input type="hidden" id="dataToDisplay" name="dataToDisplay" />