<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
var startVr = true; 

$(function() {
	
	$("#dialog").dialog({ 
		//이벤트 발생했을때 보여주려면 autoOpen : false로 지정해줘야 한다.
		autoOpen: false, 
		//레이어팝업 넓이 
		width: 1200, 
		height : 900,
		//뒷배경을 disable 시키고싶다면 true 
		modal: true, 
		//버튼종류
		buttons: [ { 
			//버튼텍스트 
			text: "Close",
			//클릭이벤트발생시 동작
			click: function() { 
		
				$( this ).dialog( "close" );
			
			
				} 
		}		
		]
	});
	
});

function fn_test(){
	 
	if (isVRModeRequested()){
		accessWebVr();
	}else{
		accessStdVr();
	} 
	
	$("#dialog").dialog("open");
	$(".ui-dialog > .ui-widget-header").css("background" , "#188688");
	$(".ui-dialog > .ui-widget-header").css("border" , "1px solid #188688");

	
}
$(function(){
	//tab		
	$("ul.tabs li").eq(3).addClass("active").css("color", "#003964");
    $("ul.tabs li").eq(0).click(function(){
    	location.href="${ctxt}/centerintro/exhibitIntro/galleryIntro.do";
    })
    $("ul.tabs li").eq(1).click(function(){
    	location.href="${ctxt}/centerintro/museum/listMuseum.do";
    })
    $("ul.tabs li").eq(2).click(function(){
    	location.href="${ctxt}/centerintro/spexhbtn/listSpexhbtn.do";
    })
    $("ul.tabs li").eq(3).click(function(){
    	location.href="${ctxt}/centerintro/online/onlineExhibit.do";
    })
});	
</script>
<style>
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
			width:25%;
			padding:0;
			font-size:12px;
		}
	}
</style>

	<div class="sub_center_text">
		<div class="sub_center_nav">
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>
			<span> > </span> <span>전시관</span> <span> > </span> 
			<span class="active">온라인 전시관</span>
		</div>
		<span class="center_text_01">온라인 전시관</span>
	</div>
	<div class="under_bar"></div>
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
			<div class="tabContainer"> 		
				<ul class="tabs">
					<li rel="tab1" style="box-sizing:border-box;">전시관소개</li>
					<li rel="tab2" style="box-sizing:border-box;">박물자료</li>
					<li rel="tab3" style="box-sizing:border-box;">기획전시</li>
					<li rel="tab3" style="box-sizing:border-box;">온라인전시관</li>					    
				</ul>	
				<div class="tab_container" style="width:100%; box-sizing:border-box;"></div>
			</div>
				<div class="sub_archive_wrap" style="letter-spacing:-1px;">
					우리나라 <span class="emphasize">공중보건 및 질병관리의 역사, 질병정보, 미래의학</span>에 대한<br>
					전시를 온라인 전시관을 통해 제공하고 있습니다.
				</div>
		
				<div class="exhibit_image_box">
					<img class="margin_r" src="${ctxt}/resources/images/sub/vr_1.png"/>
					<img class="margin_r" src="${ctxt}/resources/images/sub/vr_2.png"/>
					<img src="${ctxt}/resources/images/sub/vr_3.png"/>	
				</div>			
				<div class="btn-group">
					<a href="javascript:fn_test()" class="basic-btn">온라인 전시관 둘러보기</a>	
				</div>
				<div id = "dialog"  title="온라인 전시관 둘러보기">
				 	 <jsp:include page="./listGallery.jsp" ></jsp:include> 
				</div>			
			</div>
		</div>
	</div>







<%-- 
		<div class="sub_archive_wrap3">
			<div style="margin-top: 50px; position: relative; float: left;" >
				<p>우리나라 <span class="emphasize">공중보건 및 질병관리의 역사, 질병정보, 미래의학</span>에 대한</p>
				<p>전시를 온라인 전시관을 통해 제공하고 있습니다.</p>
			</div>
		
			<div style="margin-top: 20px; position: relative; float: left;" >
				<div style="float:left;">
					<img src="${ctxt}/resources/images/sub/vr_1.jpg" style="width:290px;height: 180px; margin-right: 5px;" />
				</div>
				<div style="float:left;" >
					<img src="${ctxt}/resources/images/sub/vr_2.JPG" style="width:290px;height: 180px;margin-right: 5px;"/>
				</div>
				<div style="float:left;">
					<img src="${ctxt}/resources/images/sub/vr_3.JPG" style="width:290px;height: 180px;"/>
				</div>
			</div>
		<!-- <div style="margin-top: 50px; position: relative; float: left;">
		
			<span class="center_text_101">관람안내</span>
	
			<p>
				<span class="center_text_100">평&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;일</span>&nbsp;&nbsp;&nbsp;
				:&nbsp;&nbsp;&nbsp; 09:00 ~ 18:00
			</p>
			<p>
				<span class="center_text_100">휴&nbsp;&nbsp;관&nbsp;&nbsp;일</span>&nbsp;&nbsp;&nbsp;
				: &nbsp;&nbsp;&nbsp;토, 일, 공휴일
			</p>
			<p>
				<span class="center_text_100">단체관람</span> &nbsp;&nbsp;&nbsp;:
				&nbsp;&nbsp;&nbsp;전화문의(249-3035)
			</p>
		</div> -->
			
			<div style = "margin-top: 50px; position: relative; float: left; clear: both; width: 100% ; text-align: center;">
				<a href="javascript:fn_test()" class="vr-basic-btn">온라인 전시관 둘러보기</a>	
			</div>
		
		</div>
	
		<div id = "dialog"  title="온라인 전시관 둘러보기">
	  <!-- dialog 생성 -->
		   <%@include file="./listGallery.jsp"   %>
		 	 <jsp:include page="./listGallery.jsp" ></jsp:include> 

		</div> --%>