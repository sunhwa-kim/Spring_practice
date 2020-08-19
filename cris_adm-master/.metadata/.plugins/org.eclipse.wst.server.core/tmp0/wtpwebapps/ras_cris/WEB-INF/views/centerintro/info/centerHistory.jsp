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
	$("ul.tabs li").eq(1).addClass("active").css("color", "#003964");
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
.history_box > .left_box.first{padding-top:70px;}
.tabContainer{
	display:none;
}

ul.tabs li{
	width:auto; 
	padding:0 15px;
}

@media all and (max-width:1200px) {
 	.history_box > div > .list > .years > .dotted {
		width:70%;
	}
}
@media all and (max-width:1130px) {
 	.history_box > div > .list > .years > .dotted {
		width:65%;
	}
}
@media all and (max-width:1090px) {
 	.history_box > div > .list > .years > .dotted {
		width:60%;
	}
}
@media all and (max-width:1040px) {
 	.history_box > div > .list > .years > .dotted {
		width:55%;
	}
}
@media all and (max-width:990px) {
 	.history_box > div > .list > .years > .dotted {
		width:75%;
	}
	.tabContainer{
		display:block;
		margin-bottom:10px;
	}
}

@media all and (max-width:970px) {
 	.history_box > div > .list > .years > .dotted {
		width:68%;
	}
}
@media all and (max-width:920px) {
 	.history_box > div > .list > .years > .dotted {
		width:58%;
	}
}
@media all and (max-width:850px) {
 	.history_box > div > .list > .years > .dotted {
		width:50%;
	}
}
@media all and (max-width:750px) {
 	.history_box > div > .list > .years > .dotted {
		width:45%;
	}
}
@media all and (max-width:722px) {
 	.right_box>.list:nth-child(2){
 		margin-top:41px;
	}
}
@media all and (max-width:650px) {
 	.right_box>.list:nth-child(3){
 		margin-top:23px;
	}
}
@media all and (max-width:620px) {
 	.left_box>.list:nth-child(2){
 		margin-top:42px;
	}
}
@media all and (max-width:600px) {
 	.left_box>.list:nth-child(3){
 		margin-top:21px;
	}
}
@media all and (max-width:570px) {
 	.history_box{
 		background:none;
 	}
 	.history_box > .left_box.first{
 		padding-top:0px;
 	}
 	.history_box>.right_box, .history_box>.left_box{
 		width:100%;
 		max-width:100%;
 	}
 	.history_box > div > .list{
 		height:auto;
 		padding-bottom:15px;
 	}
 	.history_box > div > .list > .years > .dotted {
		width:78.947368421052631578947368421053%;
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
			<span>센터안내</span>
			<span> > </span>
			<span class="active">연혁</span>        
		</div>
		<span class="center_text_01">연혁</span>
	</div> 
	<div class="under_bar"></div>
	<div class = "content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div class="tabContainer"> 		
					<ul class="tabs">
						<li rel="tab1" style="box-sizing:border-box;">소개</li>
						<li rel="tab2" style="box-sizing:border-box;">연혁</li>
						<li rel="tab3" style="box-sizing:border-box;">찾아오시는길</li>	
						<li rel="tab4" style="box-sizing:border-box;">담당업무</li>				    
					</ul>
					<div class="tab_container" style="width:100%; box-sizing:border-box;"></div>
				</div>		
	
				<div class="list_title">
					<p id="search_cn">History</p>
				</div>
				<div class="history_box">
					<div class="right_box">
						<div class="list">
							<p class="years"><span class="dotted"></span><span class="year">2006</span></p>
							<p class="month">12 December</p>
							<p class="explanation">대통령 직속 도서관정보정책위원회 발족(도서관법 12조)</p>
						</div>
					</div>
					<div class="left_box first">
						<div class="list">
							<p class="years"><span class="year">2007</span><span class="dotted"></span></p>
							<p class="month">09 September</p>
							<p class="explanation">오송생명과학단지 연구지원시설 건립방안 추진</p>
						</div>
					</div>
					<div class="right_box">
						<div class="list"">
							<p class="years"><span class="dotted"></span><span class="year">2008</span></p>
							<p class="month">07 July</p>
							<p class="explanation">도서관발전종합계획(2009-2013)수립:<br>보건복지부 소관과제로 국립의학도서관 건립 선정</p>
						</div>
					</div>
					<div class="left_box">
						<div class="list">
							<p class="years"><span class="year">2010</span><span class="dotted"></span></p>
							<p class="month">03 March</p>
							<p class="explanation">보건복지부 국립의학도서관<br>건립 사업의 주관기관을 질병관리본부로 결정</p>
						</div>
					</div>
					<div class="right_box">
						<div class="list">
							<p class="years"><span class="dotted"></span><span class="year">2011</span></p>
							<p class="month">03 March</p>
							<p class="explanation">국립의학도서관 건립추진TF(전담) 구성</p>
						</div>
					</div>
					<div class="left_box">
						<div class="list">
							<p class="years"><span class="year">2012</span><span class="dotted"></span></p>
							<p class="month">02 February</p>
							<p class="explanation">시설공사 착공</p>
							<p class="month">12 December</p>
							<p class="explanation">의과학지식센터 정보화전략계획(ISP)수립</p>
						</div>
					</div>
					<div class="right_box">
						<div class="list">
							<p class="years"><span class="dotted"></span><span class="year">2013</span></p>
							<p class="month">11 November</p>
							<p class="explanation">의과학지식센터 시설 준공</p>
						</div>
					</div>
					<div class="left_box">
						<div class="list">
							<p class="years"><span class="year">2014</span><span class="dotted"></span></p>
							<p class="month">03 March</p>
							<p class="explanation">국립의과학지식센터 개관</p>
							<p class="month">07 July</p>
							<p class="explanation">의과학지식관리과 직제 신설</p>
						</div>
					</div>
					<div class="right_box">
						<div class="list">
							<p class="years"><span class="dotted"></span><span class="year">2015</span></p>
							<p class="month">03 March</p>
							<p class="explanation">국립의과학지식센터 운영규정 개정</p>
							<p class="month">05 May</p>
							<p class="explanation">의과학 학술논문 국가서지 구축</p>
						</div>
					</div>
					<div class="left_box">
						<div class="list">
							<p class="years"><span class="year">2016</span><span class="dotted"></span></p>
							<p class="month">01 January</p>
							<p class="explanation">질병관리본부 국제학술지<br>Osong Public Health and Research Perspectives(PHRP)발간</p>
							
						</div>
					</div>
					<div class="right_box">
						<div class="list">
							<p class="years"><span class="dotted"></span><span class="year">2017</span></p>
							<p class="month">06 June</p>
							<p class="explanation">주간건강과질병(PHWR)발간</p>
						</div>
					</div>
					
					
					
					
				
				</div>				
			</div>
		</div>
	</div>
	


