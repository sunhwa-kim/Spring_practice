<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page
	import="org.springframework.web.servlet.i18n.SessionLocaleResolver"%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.11/css/all.css" integrity="sha384-p2jx59pefphTFIpeqCcISO9MdVfIm4pNnsL08A6v5vaQc4owkQqxMV8kg4Yvhaw/" crossorigin="anonymous">

<%
	String locale = String.valueOf(request.getSession().getAttribute(
			SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME));
%>
<script type="text/javascript">
$(function() {
	$(".hamburger").on("click",function(){ 
	    $(".hamburger_drop").toggleClass("on");
	    $(".curtain").fadeToggle("2000");
	});
});
</script>
<style>
html, body {
    width: 100%;
    overflow-x: none;
}
	ul.gnb1 {
    display: block;
    width: 100%;
    max-width: 1000px;
    height: 45px;
    margin: 0 auto;
    position: absolute;
    left: 50%;
    transform: translate(-50%, 0);
    -o-transform: translate(-50%, 0);
    -ms-transform: translate(-50%, 0);
    -moz-transform: translate(-50%, 0);
    -webkit-transform: translate(-50%, 0);
    padding-left: 0;
    z-index: 100;
}
ul.gnb1>li {
    float: left;
    font-size: 0.9em;
    width: auto;
    margin: 0;
    width: 23%;
}
ul.gnb1>li:last-child {
    width: 31%;
}
.hamburger_drop{
		display:none;
	}
@media (max-width: 990px){
	#content {
	    width: 98%;
	    margin: 10px 1%;
	}
}
@media (max-width: 850px){
	.infor_list>p:first-child{
		width:13%;
	}
	.infor_list>p:last-child{
		padding-left:7px;
	}
}
@media (max-width: 750px){
	.infor_list>p:first-child{
		width:85px;
	}
}
@media (max-width: 640px){
	#cssmenu > ul > li {
	    width: 22%;
	}
	#cssmenu > ul > li:last-child {
	    width: 34%;
	}
}
@media (max-width: 620px){
	ul.gnb1>li  {
	    font-size: 0.8em;
	}
	.content_box>.content_list{
		min-height:auto;
	}
}
@media (max-width: 520px){
	#cssmenu > ul > li {
	    width: 20%;
	}
	#cssmenu > ul > li:first-child {
	    width: 24%;
	}
	#cssmenu > ul > li:last-child {
	    width: 36%;
	}
}
@media (max-width: 502px){
	#englogo{
		margin:0;
	}
	#cssmenu{
		display:none;
	}
	.hamburger_drop.on {
		display:block !important;
		left:55% !important;
		transition:left 0.5s;
		-webkit-transition:left 0.5s;
	}
	.hamburger_drop>ul>li{
		padding: 10px 0 10px 15px;
	}
	.img_box{
		margin-bottom:5px;
	}
}
@media (max-width: 480px){
	.foot {
	    display: block;
	}	
}
</style>
 <header id="header">
 
 			<div class="top_login">
							
						<a href="${ctxt}/index/engindex.do" id="top_a">HOME</a>
						<!-- <a id="top_b">ㅣ</a>
						<a href="#" id="top_a">사이트맵</a> -->
						<span id="top_b">ㅣ</span>
						<a href="${ctxt}/index/index.do" id="top_a">KOREAN</a>
						
			</div>
			<!-- 상단 전체 div1 -->
			<div class="headerWrap">
				<!-- 로고 -->
				<a id="englogo" href="${ctxt}/index/engindex.do"></a>
			</div>
			<div class="hamburger">
					<p>
						<span></span><span></span><span></span>
					</p>
		</div>
		<div class="curtain"></div>
		<div class="hamburger_drop">
			<ul class="hamburger_drop_box">	
				<li class="hamburger_drop_login"><a href="${ctxt}/login/user/login.do" id="top_a">Login <!--  <i class="fas fa-sign-in-alt"></i> --> </a></li>
								
				<li class="dorp_in_drop">
					<a href="/ncmiklib<c:out value='/eng/engAbout.do'/>"> <span>About NCMIK</span></a>
				</li>	
				<li class="dorp_in_drop">
					<a href="/ncmiklib<c:out value='/eng/engFacilities.do'/>"><span>Facilities</span></a>
				</li>	
				<li class="dorp_in_drop">
					<a href="/ncmiklib<c:out value='/eng/engServices.do'/>"> <span>Services</span></a>
				</li>
				<li class="dorp_in_drop">
					<a href="/ncmiklib<c:out value='/eng/engContact.do'/>"> <span>Contact Information</span></a>
				</li>							
			</ul>
		</div>
			<!-- 상단 전체 div 끝 -->
		
		    <!-- 메뉴 -->
			<div class="menu_div">
				<!-- 메뉴 드롭다운-->
				<div id='cssmenu'>
					<ul class="gnb1 clear">
								<li>
								<a href="/ncmiklib<c:out value='/eng/engAbout.do'/>"  style = "padding: 15px 10px;"> <span> <c:out value="About NCMIK" /></span></a> 
								</li>
								<li>
								<a href="/ncmiklib<c:out value='/eng/engFacilities.do'/>" style = "padding: 15px 10px;"> <span> <c:out value="Facilities" /></span></a> 
								</li>
							<%-- <li>
								<a href="/ncmiklib<c:out value='/eng/engOperationHour.do'/>"> <span> <c:out value="Operation Hour" /></span></a> 
								</li> --%>
								<li>
								<a href="/ncmiklib<c:out value='/eng/engServices.do'/>" style = "padding: 15px 10px;"> <span> <c:out value="Services" /></span></a> 
								</li>
								<li>
								<a href="/ncmiklib<c:out value='/eng/engContact.do'/>" style = "padding: 15px 10px;"> <span> <c:out value="Contact Information" /></span></a> 
								</li>
					</ul>
				</div>
			</div>
			<!-- 메뉴 끝-->
 </header>
