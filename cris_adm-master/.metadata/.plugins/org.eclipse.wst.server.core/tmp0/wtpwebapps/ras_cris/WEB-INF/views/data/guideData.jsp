<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
	$(function(){
		//tab

	    
	    $("ul.tabs li").eq(1).addClass("active").css("color", "#003964");
		
	    $("ul.tabs li").eq(0).click(function(){
	    	location.href="${ctxt}/data/infoData.do";
	    })
	    $("ul.tabs li").eq(1).click(function(){
	    	location.href="${ctxt}/data/gurideData.do";
	    })
	    $("ul.tabs li").eq(2).click(function(){
	    	location.href="${ctxt}/data/listData.do";
	    })
	});
	</script>
	<style>
		.tabContainer{
			display:none;
		}
		.content_box>.content_list ul:after{
			   display: inline;
		}
		ul.tabs li{
			width:auto; 
			padding:0 15px;
		}
		
		@media all and (max-width:990px){
			.tabContainer{
				display:block;
			}
		}	
		
		
			
	</style>



	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>데이터센터</span>
			<span> > </span>
			<span>데이터분석실</span>
			<span> > </span>
			<span class="active">이용안내</span>        
		</div>
		<span class="center_text_01">데이터 분석실 이용안내</span>
	</div> 
	<div class="under_bar"></div>
		
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div class="tabContainer"> 
					<ul class="tabs">
				        <li rel="tab1" style="box-sizing:border-box;">소개</li>
				        <li rel="tab2" style="box-sizing:border-box;" onclick="">이용안내</li>
				        <li rel="tab3" style="box-sizing:border-box;" onclick="">데이터목록</li>				    
					</ul>
				    <div class="tab_container" style="width:100%; box-sizing:border-box; padding-top:10px;">
				        <div id="tab1" class="tab_content">
				        	<ul id ="">
				        	</ul>							            
				        </div>
				        <!-- #tab1 -->
				        <div id="tab2" class="tab_content">							        
			            	<div id ="" class="right"> 
							</div>
				        </div>
				         <!-- #tab2 -->
				        
				        <div id="tab3" class="tab_content">
			            	<div id ="" class="right"> 
							</div>
				        </div>
				        <!-- #tab3 -->
				        
				        <div id="tab4" class="tab_content">
			            	<div id ="" class="right"> 
							</div>
				        </div>
				        <!-- #tab4 -->
					</div>
				</div>
				<!-- 데이터분석실 이용안내 시작-->
				<div class="list_title"><p>이용시간</p></div>
				<ul class="list_full">
					<li class="dashed">평일09:00 ~ 18:00 (토요일, 공휴일 휴관)</li>	
				</ul>
				<div class="list_title"><p>이용대상</p></div>
				<ul class="list_full">
					<li class="dashed">질병관리본부 직원</li>	
					<li class="dashed">기타 의과학지식관리과장이 필요하다고 인정하는 경우
						<br /><span style="font-size:13px;font-weight:400;color:#888;">* 현재 외부 이용자의 사용은 제한합니다.</span>
					</li>
				</ul> 
				<!-- 데이터분석실 이용안내 끝-->
		
				<!-- 이용수칙  시작-->
				<div class="list_title"><p>신청방법</p></div>
				<ul class="list_full">
					<li class="dashed">내부(유니모) 예약시스템을 통해서 사전 예약만 가능합니다.</li>
				</ul>
				<!-- 이용수칙  끝-->
				<!-- 예약시 주의 및 참고사항  시작-->
				<div class="list_title"><p>유의사항</p></div>
				<ul class="list_full">
					<li class="dashed">모든 이용자는 승인절차가 완료되어야 이용이 가능합니다. </li>
					<li class="dashed">중복 예약된 경우 먼저 예약한 순서대로 승인합니다.</li>
					<li class="dashed">취소시에는 즉시 예약취소를 해주시기 바랍니다.</li>
					<li class="dashed">질병관리본부 내 직원의 외부 사용자에 대한 대리 신청은 불가합니다.</li>
					<li class="dashed">이용시 발생하는 문제(예, 저작권 침해, 개인 정보 보호 침해 등)에 대하여 책임지지 않습니다.</li>
				</ul>
			</div>
		</div> 
	</div>
			

