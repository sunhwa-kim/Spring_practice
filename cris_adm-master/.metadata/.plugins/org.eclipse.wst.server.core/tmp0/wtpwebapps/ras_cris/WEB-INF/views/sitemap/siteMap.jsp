<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.springframework.web.servlet.i18n.SessionLocaleResolver"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
	String locale = String.valueOf(request.getSession().getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta name="decorator" content="index" http-equiv="Content-Type" >
<title>사이트맵 | 정부출연연구기관 채용정보서비스</title>
</head>
<body>
	<div id="container">
		<div id="content">
		<h2><spring:message code="header.siteMap" /></h2>

			<ul id="sitemap">
		      	<c:forEach var="menuVo" items="${sys_topMenu}" varStatus="stat">
			      	<li>
			        <p><a href="/ncmiklib<c:out value='${menuVo.url}'/>" ><c:out value="${menuVo.menuNm}"/></a></p>
				        <c:if test="${not empty menuVo.subList}">
					        
					        <c:forEach var="subMenuVo" items="${menuVo.subList}">
					          	<span><a href="<c:out value='${subMenuVo.url}'/>" ><c:out value="${subMenuVo.menuNm}"/></a></span>
					        </c:forEach>
				        </c:if>
			      	</li>
		      	</c:forEach>
			  	<div class="clear" ></div>
			</ul>
		</div>
	</div>
	
	<div class="clear"></div>

	<div class="col-d">

	<div class="fbanner">
		<div class="fbannerw">
			<div class="fbannercon">
				<script type="text/javascript" src="${ctxt}/resources/js/jquery.bxSlider.js" charset="utf-8"></script>
				<script type="text/javascript">
					
				$(function(){
					fn_rcrtRolling();  //하단채용공고 rolling
				});
		 		</script>
				
				<ul id="list-foot">
					
				</ul>
			</div>
			<div class="nav-prev" id ="prev"><a href="#"><img src="${ctxt}/resources/img/main/fprev.gif" alt="이전"></a></div>
			<div class="nav-next" id ="next"><a href="#"><img src="${ctxt}/resources/img/main/fnext.gif" alt="다음"></a></div>
		</div>
	</div>	

	
	</div>
	
</body>
</html>