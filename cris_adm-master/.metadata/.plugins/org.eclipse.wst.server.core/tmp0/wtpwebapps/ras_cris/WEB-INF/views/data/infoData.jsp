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
	    $("ul.tabs li").eq(0).addClass("active").css("color", "#003964");
		
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
		
		table.basic_table {
			margin:0 auto;
			margin-top:11px;
			width: 94%;
		}
		table.basic_table th{
			border-right: 1px solid #D6E4F1;
		}
		table.basic_table th:last-child{
			border-right:0;
		}
		.exhibit_image_box img{   
			width: 23.8%;
		}   
		.exhibit_image_box .margin_r{
			margin-right:1.2%;    
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
			<span class="active">소개</span>        
		</div>
		<span class="center_text_01">데이터분석실 소개</span>
	</div> 
	<div class="under_bar"></div>
		
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div class="tabContainer"> 
					<ul class="tabs">
				        <li class="active" rel="tab1" style="box-sizing:border-box; color:#003964;">소개</li>
				        <li rel="tab2" style="box-sizing:border-box;" onclick="">이용안내</li>
				        <li rel="tab3" style="box-sizing:border-box;" onclick="">데이터목록</li>				    
					</ul>
				    <div class="tab_container" style="width:100%; box-sizing:border-box; padding-top:10px;"></div>
				</div>

				<div class="list_title"><p>데이터분석실 소개</p></div>
				<ul class="list_full">
					<li>심평원, 건강보험공단 등 빅데이터정보검색 및 분석환경을 제공합니다.</li>
					<li class="circle" style="margin-top:15px;">제공자료
						<ul>
							<li class="">
							
								<table class="basic_table othersetting" >
									<colgroup>
										<col style="width:33%">				
										<col style="width:34%">
										<col style="width:33%">
									</colgroup>
									<thead>
										<tr class="first">
											<th  class="border_r" scope="col" style="border-left: 1px solid #D6E4F1;">제목</th>
											<th  class="border_r" scope="col">제공기관</th>
											<th  class="border_r" scope="col" style="border-right: 1px solid #D6E4F1;">제공년도</th>
										</tr>
									</thead>    
									<tbody id="bodyInfo2">  
								    <tr>
								        <td  class="border_r" style="border-left: 1px solid #D6E4F1;" >건강보험통계연보</td>
								        <td  class="border_r">건강보험공단</td>
								        <td  class="border_r" style="text-align: center;">2002년 ~ 2015년</td>
								    </tr>
								    <tr>  
								        <td  class="border_r" style="border-left: 1px solid #D6E4F1;">통계청사망원인 데이터</td>
								        <td  class="border_r">통계청</td>
								        <td  class="border_r" style="text-align: center;">2000년 ~ 2015년</td>
								    </tr>
								    <tr>
								        <td  class="border_r" style="border-left: 1px solid #D6E4F1;">법정감염병(118종)</td>
								        <td  class="border_r">건강보험심사평가원</td>
								        <td  class="border_r" style="text-align: center;">2011년 ~ 2017년</td>
								    </tr>
								    <tr >
								        <td  class="border_r" style="border-left: 1px solid #D6E4F1;">기후데이터</td>
								        <td  class="border_r">기상청</td>
								        <td  class="border_r" style="text-align: center;">2000년 ~ 2016년</td>
								    </tr>  
								    </tbody>
								</table>  
							</li>
						</ul>  
					</li>	
    
				</ul>
				<ul class="list_full">
				</ul>
				
				<div class="list_title"><p>분석환경</p></div>    
				<ul class="list_full">
					<li>Ri386 3.3.3, SAS 9.4(32bit), IBM SPSS Statistics 25 등 통계 분석 패키지를 지원합니다. </li>	
				</ul>

				<div class="list_title"><p>설치장소</p></div>
				<ul class="list_full" style="margin-bottom:10px;">        
					<li>국립의과학지식센터 4층 자료분석실(6좌석)</li>	
				</ul>			
				<div class="exhibit_image_box">
					<img class="margin_r" src="${ctxt}/resources/images/sub/analysis_room1.png"/>
					<img class="margin_r" src="${ctxt}/resources/images/sub/analysis_room2.png"/>
					<img class="margin_r" src="${ctxt}/resources/images/sub/analysis_room3.png"/>	
					<img src="${ctxt}/resources/images/sub/analysis_room4.png"/>	
				</div>		
			</div>
		</div>
	</div>	     