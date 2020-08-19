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
	$("ul.tabs li").eq(2).addClass("active").css("color", "#003964");
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
	#daumRoughmapContainer1527147594772{
		width:100%;
	}
	td{
		line-height:140%;
	}
	.tabContainer{
	display:none;
	}
	
	ul.tabs li{
		width:auto; 
		padding:0 15px;
	}
	
	@media all and (max-width:990px){
		.tabContainer{
			display:block;
			margin-bottom:10px;
		}
	}
	@media all and (max-width: 768px){
		.view_table>tbody.report>tr>th {
		   width:15%;
		}
		.view_table>tbody.report>tr>td {
		   width:85%;
		}
	}
	@media all and (max-width: 733px){
		.view_table>tbody.report>tr>th {
		   min-width:100px;
		}
		.view_table>tbody.report>tr>td {
		   width:auto;
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
			<span class="active">찾아오시는길</span>        
		</div>
		<span class="center_text_01">찾아오시는길</span>
	</div> 
	<div class="under_bar"></div>
			
	<%--<div class="content_wrap">
				<img style="width: 930px;" src="${ctxt}/resources/images/sub/centerInfo4.PNG">
	</div> --%>
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
					<p id="search_cn">Map</p>
				</div>
				<div class="map_box"><!-- * Daum 지도 - 지도퍼가기 -->
					
					<!-- 1. 지도 노드 -->
					<div id="daumRoughmapContainer1527147594772" class="root_daum_roughmap root_daum_roughmap_landing"></div>
					
					<!-- 2. 설치 스크립트-->
					<script charset="UTF-8" class="daum_roughmap_loader_script" src="http://dmaps.daum.net/map_js_init/roughmapLoader.js"></script>
					
					<!-- 3. 실행 스크립트 -->
					<script charset="UTF-8">
						new daum.roughmap.Lander({
							"timestamp" : "1527147594772",
							"key" : "oah4"
						}).render();
					</script>
				</div>
				
				<div class="list_title">
					<p id="search_cn">교통안내</p>
				</div>
				<div class="transportation_box">
					<div class="transportation">
						<table class=  "view_table">
						<caption>
							교통안내 - 주소, 기차이용, 버스이용, 시외버스이용, 자가이용, 기타
						</caption>
						<colgroup>
							<col style="width:15%">
							<col>							
						</colgroup>
						<tbody class="report">
							<tr>
								<th scope="row">주소</th>
								<td>충북 청주시 흥덕구 오송읍 오송생명2로 202 국립의과학지식센터</td>
							</tr>
							<tr>
								<th scope="row">기차이용</th>
								<td>KTX : 오송역 하차 (택시로 5분 거리) / 일반기차 : 조치원역 하차 (택시로 20분 거리)</td>
							</tr>
							<tr>
								<th scope="row">버스이용</th>
								<td>오송역 : 500, 511 / 조치원역 : 525</td>	
							</tr>
							<tr>
								<th scope="row">시외버스이용</th>
								<td>서울남부터미널 출발&nbsp; ↔&nbsp; 오송역 3번 출구 앞&nbsp;  ↔&nbsp;  오송첨단복합단지 (1일 편도 2회 운행 : 07:10, 19:25)</td>	
							</tr>
							<tr>
								<th scope="row">자가이용</th>
								<td style=" line-height:150%; padding:10px 2%;">
									청주 IC(경부고속도로)&nbsp; →&nbsp; 조치원,행정도시 방면 우측&nbsp;  →&nbsp; 고가도로옆길(36번 국도)&nbsp; →&nbsp; 
									오송생명과학단지 방면 우측&nbsp; →&nbsp; 국책연구기관 방면 우회전(오송생명 3로)&nbsp; →&nbsp; 좌회전(오송생명 2로)&nbsp; →&nbsp; 도착
								</td>
							</tr>
							<tr>
								<th scope="row">기타</th>
								<td style=" line-height:150%; padding:10px 2%;">
									서청주 IC(중부고속도로)&nbsp; →&nbsp; 옥산,청주방면 우측 →&nbsp; 철주역 사거리(청주역로)&nbsp; →&nbsp; 월곡사거리(36번 국도)&nbsp; 
									→&nbsp; 고가도로옆길(36번 국도)&nbsp; →&nbsp; 오송생명과학단지 방면 우측 &nbsp; →&nbsp; 국책연구기관 방면 우회전(오송생명 3로)&nbsp; →&nbsp; 
									좌회전(오송생명 2로)&nbsp; →&nbsp; 도착
								</td>
						 	</tr>
						</tbody>
					</table>
					</div>
					
				</div>
			</div>
		</div>
	</div>


