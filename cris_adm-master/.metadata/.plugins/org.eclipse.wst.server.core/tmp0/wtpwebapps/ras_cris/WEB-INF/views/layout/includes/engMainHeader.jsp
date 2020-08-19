<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page
	import="org.springframework.web.servlet.i18n.SessionLocaleResolver"%>


<%
	String locale = String.valueOf(request.getSession().getAttribute(
			SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME));
%>
<script type="text/javascript">

function logout(){
	var form = $('<form action="${ctxt}/login/logout.do" method="post"></form>');
	//form.append('<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/></form>');
	form.append('</form>');
	form.appendTo('body');
	form.submit();
}
function fn_mylibarary(){
	location.href="${ctxt}/mylib/lib/listMyLib.do";
}
function mainOpen(){
	location.href="${ctxt}/index/index.do";
}
</script>

<header id="header">
	<!-- 상단 로그인 부분 -->
        <div class="top_login" style="z-index: 1;">
        				
           		<a href="${ctxt}/index/engindex.do"  id="top_a">HOME</a>
                <!--<a id="top_b">ㅣ</a>
                 <a href="#" id="top_a">사이트맵</a> -->
                 <span id="top_b">ㅣ</span>
                 <a href="javascript:mainOpen()" class="eng" id="top_a">KOREAN</a>
        </div>


	<!-- 메뉴 -->
	<div class="menu_div">
			<!-- 메뉴 드롭다운 -->
			<%@include file="./engMainMenu.jsp"%>
	</div>
	
	
	<div id="under_bar"></div>
</header>
