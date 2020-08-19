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
    	location.href="${ctxt}/centerintro/hope/hopeReg.do";
    })
    $("ul.tabs li").eq(1).click(function(){
    	location.href="${ctxt}/centerintro/orgCopy/listOrgCopy.do";
    })
    $("ul.tabs li").eq(2).click(function(){
    	location.href="${ctxt}/centerintro/mobile/mobileService.do";
    })
});
</script>
<style>
	table{
		 text-align: center; 
		 color: #555;
	}
	tbody>tr{
		 height:160px;
	}
	tbody>tr:first-child>td:first-child{ 
		 border-right: 1px solid rgba(51, 122, 183, 0.1);
	}
	thead>tr{
		height:40px;
	}
	thead>tr>th:first-child{
		 border-right: 1px solid rgba(51, 122, 183, 0.1);
	}
	#bodyInfo>tr>td:first-child{
		text-align:center;
	}
	#bodyInfo>tr:nth-child(2){
		height:50px;
	}
	#bodyInfo>tr:nth-child(2)>.last{
		text-align:left;
	}
	td>a>img{
		width:37.362637362637362637362637362637%;
		max-width:170px;
		min-width:160px;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
	.tabContainer{
		display:none;
	}
	
	ul.tabs li{
		width:auto; 
		padding:0 15px;
	}
	@media all and (max-width:990px) {
		.tabContainer{
			display:block;
			margin-bottom:10px;
		}
	}
	@media (max-width: 600px){
		td>a>img{
			min-width:140px;
			transition:all 0.3s;
			-webkit-transition:all 0.3s;
		}	
		tbody>tr{
			height:100px;
		}
	}
	@media all and (max-width:444px) {
		.tabContainer>.tabs>li{
			width:33.333333333333333333333333333333%;
			padding:0;
			font-size:12px;
		}
	}
	@media (max-width: 400px){
		td>a>img{
			min-width:120px;
			transition:all 0.3s;
			-webkit-transition:all 0.3s;
		}
		tbody>tr{
			height:70px;
		}	
	}
	@media (max-width: 360px){
		td>a>img{
			min-width:100px;
			transition:all 0.3s;
			-webkit-transition:all 0.3s;
		}	
	}
</style>
<div class="sub_center_text">
      <div class="sub_center_nav"> 
	      <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
	      <span> > </span> 
	      <span>서비스</span>
	      <span> > </span>
	      <span class="active">모바일 서비스</span>        
      </div>
	  <span class="center_text_01">모바일 서비스</span>
</div> 
<div class="under_bar"></div>
	
<div class="content_wrap">
	<div class="content_box">		
		<div class="content_list">
		<div class="tabContainer"> 		
			<ul class="tabs">
				<li rel="tab1" style="box-sizing:border-box;" onclick="">도서신청</li>
				<li rel="tab2" style="box-sizing:border-box;" onclick="">원문복사</li>
				<li rel="tab3" style="box-sizing:border-box;" onclick="" class="active">모바일서비스</li>					    
			</ul>
			<div class="tab_container" style="width:100%; box-sizing:border-box;"></div>
		</div>
			<div class="list_title"><p>Korea OpenMed Mobile App</p></div><br>
				<div class="tab_container" style="width:100%;border:0;padding-bottom: 30px;">
		        	<table class="basic_table" cellspacing="0" cellpadding="0" style="table-layout: fixed; margin: 0px; display: table;" summary="">
						<caption>모바일서비스</caption>
						<colgroup>
							<col width="50%">
							<col width="50%">
						</colgroup>
						<thead>
							<tr class="first">
								<th scope="col">애플</th>
								<th scope="col">안드로이드</th>
							</tr>
						</thead>
						<tbody id="bodyInfo">
						<tr>
						 <td><a href="https://itunes.apple.com/kr/app/k-pubmed/id1269455002?mt=8" target="_blank" rel="noopener noreferrer"><img src="${ctxt}/resources/images/main/appStore.png"></a></td>
						 <td><a href="https://play.google.com/store/apps/details?id=kr.go.nih.library.kpubmed" target="_blank" rel="noopener noreferrer"><img src="${ctxt}/resources/images/main/playStore.png"></a></td>
					    </tr>
						<tr>
						 <td class="last" colspan="2">※ 위 아이콘 클릭 시 앱프로그램을 다운로드 받을 수 있는 페이지로 이동합니다.</td>
					    </tr>
					    </tbody>
					</table>
			</div>
			
			
			<div class="list_title"><p>PHRP Mobile App</p></div><br>
			<div class="tab_container" style="width:100%;border:0;">
	        	<table class="basic_table" cellspacing="0" cellpadding="0" style="table-layout: fixed; margin: 0px; display: table;" summary="">
					<caption>모바일서비스</caption>
					<colgroup>
						<col width="50%">
						<col width="50%">
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col">애플</th>
							<th scope="col">안드로이드</th>
						</tr>
					</thead>
					<tbody id="bodyInfo">
					<tr>
					 <td><a href="https://itunes.apple.com/kr/app/new-phrp/id1352659894?mt=8" target="_blank" rel="noopener noreferrer"><img src="${ctxt}/resources/images/main/appStore.png"></a></td>
					 <td><a href="https://play.google.com/store/apps/details?id=org.kcdcphrp.phrp" target="_blank" rel="noopener noreferrer"><img src="${ctxt}/resources/images/main/playStore.png"></a></td>
				    </tr>
					<tr>
					 <td class="last" colspan="2">※ 위 아이콘 클릭 시 앱프로그램을 다운로드 받을 수 있는 페이지로 이동합니다.</td>
				    </tr>
				    </tbody>
				</table>
			</div>		
		</div>
		</div>
				
</div>

<!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" />


