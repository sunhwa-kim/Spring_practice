<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
	$(function(){
		//tab		
		$("ul.tabs li").eq(3).addClass("active").css("color", "#003964");
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
	.view_table{
		width: 80%;margin-left: 10%;
	}
	.last-child{border-right:0px !important;}    
	
	.view_table>tbody.report>tr>td{
		line-height:150%;
	}
	.view_table>tbody.report>tr>td:first-child{
		text-align:left;
		padding-left:20px;
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
		.view_table {
		    width: 100%;
		    margin-left: 0%;
		}
	}
	
	@media (max-width: 768px){
		.view_table>tbody.report>tr>td:last-child {
    		width: 30%;
    	}
    	.view_table>tbody.report>tr>td:first-child {
    		width: 70%;
    	}
    }
    @media (max-width: 540px){
    	.view_table>tbody.report>tr>td:first-child {
    		padding-left:2%;
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
			<span class="active">담당업무</span>        
		</div>
		<span class="center_text_01">담당업무</span>
	</div> 
	<div class="under_bar"></div>
				
	
	<%-- <div class="content_wrap">
				<img style="width: 930px;" src="${ctxt}/resources/images/sub/centerInfo5.PNG">
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
				<table class=  "view_table">
						<colgroup>
							<col>
							<col style="width:35%">							
						</colgroup>
						<tbody class="report">
							<tr>
								<th scope="col">담당업무</th>
								<th scope="col">전화번호</th>
							</tr>
							<tr>
								<td>의과학지식센터 업무총괄</td>
								<td style="text-align: center;">043-249-3003</td>
							</tr>
							<tr>
								<td>운영 및 사업관리 등 업무 전반</td>
								<td style="text-align: center;">043-249-3067</td>
							</tr>
							<tr>
								<td>주무업무, 예산편성, 집행 및 결산</td>
								<td style="text-align: center;">043-249-3025</td>
							</tr>
							<tr>
								<td>자료 수집, 기획 및 대외협력 업무 지원</td>
								<td style="text-align: center;">043-249-3026</td>
							</tr>
							<tr>
								<td>질병관리백서 발간 업무, 포털관리, 운영실무</td>
								<td style="text-align: center;">043-249-3065</td>
							</tr>
							<tr>  
								<td>도서관 운영 관리(장서 관리 및 이용자서비스 등), 사업관리(국가서지, MeSH)</td>
								<td style="text-align: center;">043-249-3023</td>
							</tr>
							<tr>
								<td>PHWR 편집·발간, 의과학지식 연구분석 지원</td>
								<td style="text-align: center;">043-249-3028</td>
							</tr>
							<tr>
								<td>정보시스템 운영(컨텐츠 포함), 의과학 전시관 구축 및 운영</td>
								<td style="text-align: center;">043-249-3035</td>
							</tr>
							<tr>
								<td>전자자원 계약 및 서비스 실무, 교육 기획 및 운영</td>
								<td style="text-align: center;">043-249-3038</td>
							</tr>
							<tr>
								<td>MeSH 색인 및 관련 사업 지원, 국제협력업무, 영문에디팅 지원</td>
								<td style="text-align: center;">043-249-3030</td>
							</tr>
							<tr>
								<td>질병관리본부 국제학술지(PHRP)발간, 데이터분석센터 운영</td>
								<td style="text-align: center;">043-249-3039</td>
							</tr>
							<tr>
								<td>예산 편성·집행·결산, 행정업무, 홍보기획 촐괄, 물품 및 자산관리</td>
								<td style="text-align: center;">043-249-3022</td>
							</tr>
							<tr>
								<td>견학, 상호대차 서비스, 시설 및 예약시스템 운영·관리</td>
								<td style="text-align: center;">043-249-3036</td>
							</tr>
							<tr>
								<td>자료수집 및 아카이브 구축, 간행물등록번호 관리</td>
								<td style="text-align: center;">043-249-3024</td>
							</tr>
						</tbody>
					</table>
			</div>
		</div>
	</div>
		


