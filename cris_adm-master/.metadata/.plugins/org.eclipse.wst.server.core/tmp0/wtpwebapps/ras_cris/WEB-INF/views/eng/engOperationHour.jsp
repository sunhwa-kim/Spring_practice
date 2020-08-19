<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="sub_center_text">
		      <div class="sub_center_nav"> 
			      <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			      <span> > </span> 
			      <span class="active">Operation Hour</span>
		      </div>     
		      <span class="center_text_01">Operation Hour</span>
		</div> 
		<div class="under_bar"></div>
	
<div class="content_wrap">
	<div class="content_box">		
		<div class="content_list">
			<p class="eng_text"><span>9 a.m. - 8 p.m. every weekdays</span></p>
			<p class="reference"><span>※</span> The <strong>NCMIK</strong> services and resources are open accessible to anyone.</p>
		</div>
	</div>		
</div>

<!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" />


