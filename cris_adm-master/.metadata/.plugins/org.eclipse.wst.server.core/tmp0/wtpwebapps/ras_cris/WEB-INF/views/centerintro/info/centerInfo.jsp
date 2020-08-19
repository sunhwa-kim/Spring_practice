<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
$(function(){
	//tab		
	$("ul.tabs li").eq(0).addClass("active").css("color", "#003964");
    $("ul.tabs li").eq(0).click(function(){
    	location.href="${ctxt}/centerintro/info/centerInfo.do";
    })
    $("ul.tabs li").eq(1).click(function(){
    	location.href="${ctxt}/centerintro/info/centerHistory.do";
    })
    $("ul.tabs li").eq(2).click(function(){
    	location.href="${ctxt}/centerintro/info/centerMap.do";
    })
    $("ul.tabs li").eq(3).click(function(){
    	location.href="${ctxt}/centerintro/info/centerWork.do";
    })
});		
</script>


<style>
.tabContainer {
	padding-top:40px;
	display:none;
}
ul.tabs>li:first-child{
	margin-left:40px;
}

ul.tabs li{
	width:auto; 
	padding:0 15px;
}
.sub_center_text:after{
display:block;
clear:both;
content:"";
}
.content_box>.content_list>.list:nth-child(2n){
	float:right;
}
@media all and (max-width:1062px) {
	.content_box>.content_list>.list{
		min-height:200px;
		margin-bottom: 0px;
	}
}
@media all and (max-width:1036px) {
	.content_box>.content_list>.list{
		min-height:220px;
	}
}
@media all and (max-width:990px){
	.tabContainer{
		display:block;
	}
}	
@media all and (max-width:768px) {
	.circle_row{
		width:auto;
		max-width:360.25px;
	}
	.content_box>.circle_row>li{
		margin-bottom:20px;
		margin-right:0;
	}
	.content_box>.circle_row>li:nth-child(2n-1){
		margin-right:0;
		margin-left:20px;
	}
	.content_box>.content_list>.list{
		margin-bottom:0;
		min-height:260px;	
	}
}	
@media all and (max-width:602px) {
	.content_box>.content_list>.list{
		width:90%;
		margin:0 5%;
		float:none;
		min-height:auto;
		display:block;
		padding-bottom:15px;
		transition: all 0.3s;
	    -webkit-transition: all 0.3s;
	}
	.content_box>.content_list>.list:nth-child(2n){
		float:none;
		transition: all 0.3s;
	    -webkit-transition: all 0.3s;
	}
}
@media all and (max-width:502px) {
	ul.tabs>li:first-child{
		margin-left:0px;
	}
	.content_box>.circle_row>li {
	    width: 130px;
	    height: 130px;
	    transition: all 0.3s;
	    -webkit-transition: all 0.3s;
	}
	
	.content_box>.circle_row>li>div>p.line {
	    width: 110px;
	    transition: all 0.3s;
	    -webkit-transition: all 0.3s;
	}
	.content_box>.circle_row>li>div>p:last-child {
	    padding-top: 5px;
	    font-size:14px;
	    transition: all 0.3s;
	    -webkit-transition: all 0.3s;
	}
	.content_box>.circle_row{
		width:auto;
		text-align:center;
		display:inline-block;
		margin:0 auto;
		margin-left:10%;
	}
	.content_box>.circle_row>li:nth-child(2n-1){
		margin-left:0;
	}
}
@media all and (max-width:494px) {
	.box{
		padding:10px;
	}
}
@media all and (max-width:444px) {
	.tabContainer>.tabs>li{
		width:21%;
		padding:0;
		font-size:12px;
	}
	.tabContainer>.tabs>li:nth-child(3){
		width:33%;
		padding:0;
	}
	.tabContainer>.tabs>li:nth-child(4){
		width:25%;
		padding:0;
	}
}
</style>

<div class="sub_center_text">
      <div class="sub_center_nav"> 
	      <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
	      <span> > </span> 
	      <span>센터 소개</span>
	      <span> > </span>
	      <span class="active">센터 소개</span>        
      </div>
	  <span class="center_text_01">센터 소개</span>
</div> 
<div class="under_bar"></div>
<div class="box">
	<div class="tabContainer"> 		
		<ul class="tabs">
			<li rel="tab1" style="box-sizing:border-box;">소개</li>
			<li rel="tab2" style="box-sizing:border-box;">연혁</li>
			<li rel="tab3" style="box-sizing:border-box;">찾아오시는길</li>	
			<li rel="tab4" style="box-sizing:border-box;">담당업무</li>				    
		</ul>
		<div class="tab_container" style="width:100%; box-sizing:border-box;"></div>
	</div>

	<div class="content_wrap">
				<p style="width:100%;margin:0;"><img src="${ctxt}/resources/images/sub/centerInfo1a.png" style="width:100%;"></p>			 
	
		<div class="content_box">
			<div class="circle_title">국내외 의과학지식 정보자원의 모든 것을<br><span>국립의과학지식센터</span>에서 만날 수 있습니다.</div>

			<div class="content_list">
				<div class="list_title"><p>비전  Vision</p></div>
				<img style="width:90%; margin:0 5%;" src="${ctxt}/resources/images/sub/centerInfo_0_1.png">
			</div>
			<div class="content_list">
				<div class="list_title"><p> 주요기능  Main Function</p></div>
				<img style="width:90%; margin:10px 5% 0 5%;" src="${ctxt}/resources/images/sub/centerInfo_1.png">
				<ul class="list">
					<li class="list_number">01</li>
					<li>
						<ul>
							<p class="sub_title">국내외 의과학 정보자원의 망라적 수집, 가공, 보존 및 제공</p>	
							<li class="hyphen">의과학 정보의 제공 및 공유 환경의 실현</li>		
							<li class="hyphen">의과학 국가서지(National Biomedical Bibliography) 구축</li>	
							<li class="hyphen">의학학술정보분류체계<br>MeSH(Medical Subject Headings) 색인</li>	
						</ul>
					</li>
				</ul>
				<ul class="list">
					<li class="list_number">02</li>
					<li>
						<ul>
							<p class="sub_title">의과학 연구성과물 통합관리 및 제공</p>	
							<li class="hyphen">국가연구비 지원을 받은 연구성과물의<br>공공접근정책(Public Access Policy) 실현</li>		
							<li class="hyphen">의과학 연구보고서 등 회색문헌의<br> 원문데이터베이스 구축</li>		
						</ul>
					</li>
				</ul>
				<ul class="list">
					<li class="list_number">03</li>
					<li>
						<ul>
							<p class="sub_title">의과학 연구 데이터의 수집, 보존 및 공유 인프라 구축</p>	
							<li class="hyphen">국가 연구과제에서 생산된 데이터의 공유정책<br>(Data Sharing Policy) 실현</li>		
							<!-- <li class="hyphen">임상유전체 데이터 수집·공유 시스템, CODA운영</li>		 -->
						</ul>
					</li>
				</ul>
				<ul class="list">
					<li class="list_number">04</li>
					<li>
						<ul>
							<p class="sub_title">의과학 최신 정보 및 교육 프로그램 제공</p>	
							<li class="hyphen">의과학 연구활동 지원을 위한<br>교육프로그램 개발 및 제공</li>		
							<li class="hyphen">최신 의과학 연구 동향 및 성과 제공</li>	
						</ul>
					</li>
				</ul>
			</div>
		</div>
	
	
	
	</div>
</div>

<!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" />
