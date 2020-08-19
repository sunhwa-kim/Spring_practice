<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.springframework.web.servlet.i18n.SessionLocaleResolver"%>



<%
	String locale = String.valueOf(request.getSession().getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME));
%>

<header id="header">
	<div class="headerWrap">
		<h1 class="logo"><img src="${ctx}/images/main/header_title.png" alt=""></h1>
		<div class="hamburger">
			<p>
				<span></span><span></span><span></span>
			</p>
		</div>
		<div class="hamburger_drop">
			<ul class="hamburger_drop_box">
				<li class="dorp_in_drop">전자자원<i class="fa fa-caret-down" aria-hidden="true"></i>
					<ul class="dorp_in_drop_box">
						<li><a href="">Korea Open Med</a></li>
						<li><a href="">WebDB</a></li>
						<li><a href="">E-Journals</a></li>
						<li><a href="">E-Books</a></li>
						<li><a href="">OpenAPI</a></li>
					</ul>
				</li>
				<li class="dorp_in_drop">아카이브<i class="fa fa-caret-down" aria-hidden="true"></i>
					<ul class="dorp_in_drop_box">
						<li><a href="">아카이브 소개</a></li>
						<li><a href="">보고서</a></li>
						<li><a href="">성과 논문</a></li>
					</ul>
				</li>
				<li class="dorp_in_drop">소장자료<i class="fa fa-caret-down" aria-hidden="true"></i>
					<ul class="dorp_in_drop_box">
						<li><a href="">단행본</a></li>
						<li><a href="">보고서</a></li>
						<li><a href="">연속간행물</a></li>
						<li><a href="">비도서</a></li>
					</ul>
				</li>
				<li class="dorp_in_drop">데이터센터<i class="fa fa-caret-down" aria-hidden="true"></i>	
					<ul class="dorp_in_drop_box">
						<li><a href="">데이터분석실</a></li>
						<li><a href="">데이터목록</a></li>
						<li><a href="">보건의료 데이터</a></li>
						<li><a href="">유관기관 데이터</a></li>
					</ul>
				</li>
				<li class="dorp_in_drop">센터안내<i class="fa fa-caret-down" aria-hidden="true"></i>
					<ul class="dorp_in_drop_box">
						<li><a href="">센터안내</a></li>
						<li><a href="">서비스</a></li>
						<li><a href="">전시관</a></li>
					</ul>
				</li>
			</ul>
		</div>
	 	<div id="gnbwrap" style="height: 85px;">
	 		  <div class="gnbwrap_bg"></div>
	 		  <div class="centerWrap" id="navigation">
						
						<%@include file="./menu.jsp" %>
						
			  </div>
		</div>
	</div>
</header>       
