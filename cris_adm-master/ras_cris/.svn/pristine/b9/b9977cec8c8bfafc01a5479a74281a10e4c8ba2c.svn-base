<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.11/css/all.css" integrity="sha384-p2jx59pefphTFIpeqCcISO9MdVfIm4pNnsL08A6v5vaQc4owkQqxMV8kg4Yvhaw/" crossorigin="anonymous">
<!-- 워드클라우드 시작 -->
<script type="text/javascript" src="${ctxt}/resources/js/jqcloud/jqcloud-1.0.4.js"></script>
<link rel="stylesheet" href="${ctxt}/resources/css/jqcloud.css" type="text/css" media="screen">
<!-- 워드클라우드  끝-->
<!-- listArticle차트 시작 -->
<script type="text/javascript" src="${ctxt}/resources/js/chart/jui/jquery-ui.min.js"></script>
<script type="text/javascript" src="${ctxt}/resources/js/chart/jui/core.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctxt}/resources/js/chart/jui/chart.js" ></script>
<!-- listArticle차트  끝-->
<link rel="stylesheet" href="${ctxt}/resources/css/jquery-ui.min.css" type="text/css" />

<script type="text/javascript" src="${ctxt}/resources/js/jquery.FadeWideBgImg.js"></script>
<script type="text/javascript">

function preload(arrayOfImages) {

	$('.slideshow').FadeWideBgImg({interval:10000});		
}
  
jQuery(document).ready(function(){

    var select = $("select#color");
    
    select.change(function(){
        var select_name = $(this).children("option:selected").text();
        $(this).siblings("label").text(select_name);
    });
    
    $('#Round_box2 div').mouseenter(function(){
    	$(this).css('z-index', 5);
    });
    $('#Round_box2>a>div').mouseleave(function(){
    	$('#Round0001').css('z-index', 4);
    	$('#Round0002').css('z-index', 3);
    	$('#Round0003').css('z-index', 2);
    	$('#Round0004').css('z-index', 1);
    });
    
});

 $(window).load(function () { 
	preload([
    '${ctxt}/resources/images/main/slide_image_2.png'
    ,'${ctxt}/resources/images/main/slide_image_3.png'
	]); 
	
}); 

function cutByLen(str, maxByte) {

	for(b=i=0;c=str.charCodeAt(i);) {

	b+=c>>7?2:1;

	if (b > maxByte)

	break;

	i++;

	}
	return str.substring(0,i);
}

//아카이브
function fn_right_viewPage(archiveId , paramGbn , returnPage){
	if(paramGbn == 'report'){
		location.href = "${ctxt}/archive/report/reportView.do?upd_yn=Y&rep_id="+archiveId+"";
	}else if(paramGbn == 'rnd'){
		location.href = "${ctxt}/archive/rnd/rndView.do?upd_yn=Y&rnd_id="+archiveId+"";
	}
}

//워드클라우드 시작
function fn_link(obj){
	location.href="${ctxt}/search/search.do?searchQuery="+obj;
}   

//hamburger_btn
$(function() {
	//listArticle차트 시작
	fn_search();
	//listArticle차트끝
	//아카이브 주제분류 시작
	fn_stats_orderDept();
	//아카이브 주제분류 끝
	
	//워드클라우드 시작
	var some_words = new Array();
	
	$('.tc_list').each(function(cnt){
		var strLink = "javascript:fn_link('"+$(this).attr('value')+"')";
		var strWeight = 0.7 - (cnt * 0.15);
		some_words.push({text: $(this).attr('value'), weight: strWeight, link: {href: strLink} })
	});
	$("#container").jQCloud(some_words);
  	//워드클라우드 끝
	
	$(".hamburger").on("click",function(){        
	    $(".hamburger_drop").toggleClass("on");
	    $(".curtain").fadeToggle("2000");
	    $(".hamburger_drop>.hamburger_drop_box").attr("style" , "display:block");
	    $(".dorp_in_drop").click(function(){
	    	   var submenu = $(this).children("ul");
	            if( submenu.is(":visible") ){
	                submenu.slideUp();
	            }else{
	                submenu.slideDown();
	            }
	    });
	    
	});
});

//listArticleStat 차트시작
function fn_search(){
	//현재 페이지 세팅
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/
	var params = {};


    $.ajax({
        url: '${ctxt}/elib/kom/selectArticleYearStat.do',
        data: params,
        type: 'POST',
        dataType: 'text',
        cache: false,
        success: function(rtnXml) {
   
        	xmlList = $(rtnXml).find('item');

        	//"PUB_YEAR","CNT"
        	
        	html="";
        	var totalCnt=0;
			if(xmlList.length > 0){
				
				xmlList.each(function(cnt){
			
					var obj = $(this);
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					html += '<tr class="div_journal" >';
					html += ' <td>'+obj.find('PUB_YEAR').text() +'</td>';
					html += ' <td>'+obj.find('CNT').text() +'</td>';
					html += ' <td>'+obj.find('CNT_RT').text() +' </td>';
					html += '</tr>';
					
					totalCnt += parseInt(obj.find('CNT').text());
					$('.chart_name').text('KoreaOpenMed 구축현황 (누적: 345000건)');//Number(totalCnt).toLocaleString('en').split(".")[0]
		        });
			    $("#bodyInfo").html(html);
			    
			    fn_createChart($(rtnXml).find('chart_data').text());
			  
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$("#bodyInfo").html('<tr><td colspan="5" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
} 

function fn_createChart(chart_data){
	var chart = jui.include("chart.builder");
	var data =[
	           {quarter:2015,sales:30000},
	           {quarter:2016,sales:183500},
	           {quarter:2017,sales:285000},
	           {quarter:2018,sales:345000}
			  ];
	var c = chart("#result", {
		padding:{
			top:17,
			right:25,
			left:45,
			bottom:25
		},
	    axis : [{
	        x : {
	            type : "block",
	            domain : "quarter",
	            line : true
	        },
	        y : {
	            type : "range",
	            domain :[0,400000],
	            step : 8,
	            line : true
	        },    
	        data : data
	    }],
	    brush : [{
	        type : "column",
	        target : "sales",
	        size:25,
	        display : "max",
	        active : 5,
	        activeEvent : "mouseover",
	        animate : true,
	        outerPadding : 10
	    }],
	/*     widget : [
	          	{ type : "title", text : "국내학술논문 구축현황" }
	          ], */
	    event : {
	        click : function(obj, e) {
	        	location.href="${ctxt}/elib/kom/listArticle.do?startDate="+ obj.data["PUB_YEAR"]+"0101" + "&endDate=" + obj.data["PUB_YEAR"]+"1231";
	        }
	    }
	});
     
	// Events defined by the method
// 	c.on("rclick", function(obj, e) {
// 	});
      
}
// listArticleStat 차트끝

// 아카이브 주제분류 통계 시작

<!--주제분류별통계-->
function fn_stats_orderDept(){
	var params = {};
	
	   $.ajax({
	        url: '${ctxt}/archive/statistics/statsOrderDept.do',
	        data: params,
	        type: 'POST',
	        dataType: 'text',
	        cache: false,
	        success: function(rtnXml) {
	        	
	        	//차트 초기화
	        	$("#gridChart").children().remove();
	   
	        	xmlList = $(rtnXml).find('item');
	        
				if(xmlList.length > 0){
				
					var archive_list  = new Array();	
					xmlList.each(function(cnt){
						
						var obj = $(this);
						/***************************************************************
						* 화면별로 따로 세팅 테이블 데이터
						****************************************************************/
						var subject = obj.find('subject').text(); 
						var subject_cnt = obj.find('subject_cnt').text();
						
						var data = new Object();
						data.quarter = subject;
						data.count = parseInt(subject_cnt);
						
						
						archive_list.push(data);
			        });
				
					var chart = jui.include("chart.builder");
					var jsonData  = JSON.stringify(archive_list);
			
					chart("#gridChart", {
						padding : {
							top:25,
							right:25,
							left:90,
							bottom:25
						},
					    axis : {				       
					        x : {
					            type : "range",
					            domain : function(d) { return [0 ,d.count ]; },
					            step : 5,
					            line : true
					        },
					        y : {
					        	type : "block",
					            domain : "quarter",
					            line : true
					        },
					        data : eval(jsonData)
					    },
					    brush : 
// 					    {
// 					        type : "column",
// 					        size : 20,
// 					        target : ["count" ],
// 					    },
					    
					    [{
					        type : "focus",
					    }, {
					        type : "bar",
					        target : ["count" ],
					        display : "max",
					        active : 5,
					        activeEvent : "mouseover",
					        animate : true
					    }],
					    widget : [
					        { type : "tooltip"}
					        ,{ 
						          type : "title",
						          text : "아카이브 주제별 현황"
						     }
					    ],
					    style:{
					    	backgroundColor: "none"
	     				}
					});
				}else{
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
					****************************************************************/
					
					$("#gridChart").html('<div>조회된 내용이 없습니다.</div>');
				}
	        },
	        error : function(xmlHttpRequest , textStatus, errorThrown){ // Ajax 전송 에러 발생시 실행
	        	if(xmlHttpRequest.readyState == 0 || xmlHttpRequest.status ==0){        	
	        		return;        		
	        	}else{
	        		 alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
	        	}        	        
	        }
	    })
}

// 아카이브 주제분류 통계 끝


//Banner 호출
/* $(function(){
	InitializeStaticMenu();
})


//Banner
 var stmnLEFT = 10; // 오른쪽 여백 
 var stmnGAP1 = 0; // 위쪽 여백 
 var stmnGAP2 = 150; // 스크롤시 브라우저 위쪽과 떨어지는 거리 
 var stmnBASE = 180; // 스크롤 시작위치 
 var stmnActivateSpeed = 35; //스크롤을 인식하는 딜레이 (숫자가 클수록 느리게 인식)
 var stmnScrollSpeed = 15; //스크롤 속도 (클수록 느림)
 var stmnTimer; 
 
 function RefreshStaticMenu() { 
  var stmnStartPoint, stmnEndPoint; 
  stmnStartPoint = parseInt(document.getElementById('STATICMENU').style.top, 10); 
  stmnEndPoint = Math.max(document.documentElement.scrollTop, document.body.scrollTop) + stmnGAP2; 
  if (stmnEndPoint < stmnGAP1) stmnEndPoint = stmnGAP1; 
  if (stmnStartPoint != stmnEndPoint) { 
   stmnScrollAmount = Math.ceil( Math.abs( stmnEndPoint - stmnStartPoint ) / 15 ); 
   document.getElementById('STATICMENU').style.top = parseInt(document.getElementById('STATICMENU').style.top, 10) + ( ( stmnEndPoint<stmnStartPoint ) ? -stmnScrollAmount : stmnScrollAmount ) + 'px'; 
   stmnRefreshTimer = stmnScrollSpeed; 
   }
  stmnTimer = setTimeout("RefreshStaticMenu();", stmnActivateSpeed); 
  } 
 function InitializeStaticMenu() {
  document.getElementById('STATICMENU').style.right = stmnLEFT + 'px';  //처음에 오른쪽에 위치. left로 바꿔도.
  document.getElementById('STATICMENU').style.top = document.body.scrollTop + stmnBASE + 'px'; 
  RefreshStaticMenu();
  } */
//Banner 끝
</script>

<script type="text/javascript">
    

//하단롤링배너
/* var pmTime = 3000; // 타이밍
var pmBtnext = "#rollBanner #box1Wrap p.next"; // 다음 버튼 클래스명
var pmBtprev = "#rollBanner #box1Wrap p.prev"; // 이전 버튼 클래스명
var pmBox1 = ".box1"; // 배너들을 감싸고 있는 클래스명

$(document).ready(function(){
	pmLove = setInterval("boxAni01()",pmTime);
	$(pmBtnext).click(function(){
		clearInterval(pmLove);
		boxAni01();
		pmLove = setInterval("boxAni01()",pmTime);
	});
	$(pmBtprev).click(function(){
		clearInterval(pmLove);
		boxAni02();
		pmLove = setInterval("boxAni02()",pmTime);
	});
});

function boxAni01(){
	var pp = $(pmBox1+" div:first").width();
	if($(pmBox1).is(":animated") == false ){
		$(pmBox1).animate(
			{
				left:-pp
			},800,
			function(){
				$(pmBox1).append($(pmBox1+" div:first"));
				$(pmBox1).css({"left":"0px"});
			}
		);
	}
}
function boxAni02(){
	var pp = $(pmBox1+" div:last").width();
	if($(pmBox1).is(":animated") == false ){
		$(pmBox1).prepend($(pmBox1+" div:last"));
		$(pmBox1).css({"left":-pp});
		$(pmBox1).animate(
			{
				left:0
			},800
		);
	}
} */
</script>
<script type="text/javascript">
// window.onload = function() {
// 	var slideIndex = 0;
// 	showSlides();
	
// 	function showSlides() {
// 	    var i;
// 	    var slides = document.getElementsByClassName("mySlides");
// 	    for (i = 0; i < slides.length; i++) {
// 	       slides[i].style.display = "none";  
// 	    }
// 	    slideIndex++;
// 	    if (slideIndex > slides.length) {slideIndex = 1}    

// 	    slides[slideIndex-1].style.display = "block";  
// 	    setTimeout(showSlides, 3000); // Change image every 2 seconds
// 	}
	
// }

</script> 
<style>
	ul.slideshow>li{
		min-height:400px;
		margin-top:0;
		top:0;
	}
	.chart_name{
		color:#7D7D8E;
		font-size:12px;
		letter-spacing:-0.4px;
	}
 	@media all and (max-width:1100px) {
		#myCarousel, .carousel{
			height:370px;
		}
	} 	
	@media all and (max-width:1000px) {
		#myCarousel, .carousel{
			height:330px;
		}
	} 
	@media all and (max-width:900px) {
		#myCarousel, .carousel{
			height:300px;
		}
	}
	@media all and (max-width:800px) {
		#myCarousel, .carousel{
			height:270px;
		}
	}
	@media all and (max-width:700px) {
		#myCarousel, .carousel{
			height:240px;
		}
	}
	@media all and (max-width:600px) {
		#myCarousel, .carousel{
			height:210px;
		}
		ul.slideshow>li>img{
			height:210px !important;
			width:auto;
		}
	}
	@media all and (max-width:640px) {
		.container{
			padding-right: 0;
    		padding-left: 0;
    		width:65%;
    		float:right;
    		position:absolute;
    		top:0;
		}
		.container .container{
			right:10px;
		}
		.navbar-wrapper{
			height:0;
			top:0;
		}
	}
	@media all and (max-width:502px){
		.container{
			float:none;
			width:100%;
			top:19px;
		}
			.container .container{
				right:0;
			}
			.overlay{
			display:none;
			}
			.carousel{
			height:auto;
		}
	}
	.radio, .checkbox{
		display: inline-block;
	}
	label{
		display: inline;
	}
 </style>
	
<!-- BootStrap -->
	
	<!-- NAVBAR
================================================== -->

<body id="본래 설정">
	<div class="navbar-wrapper">
      <div class="container">
        <nav class="navbar navbar-static-top" style="z-index:0;">
          <div class="container">
          </div>
        </nav>
      </div>
    </div>
  
	 <!-- Carousel
    ================================================== -->
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
	     <!-- -- Indicators -->
	        <!-- <ol class="carousel-indicators"> 
	         	<li data-target="#myCarousel" data-slide-to="0" class="active"></li> 
	         	<li data-target="#myCarousel" data-slide-to="1"></li> 
	        	<li data-target="#myCarousel" data-slide-to="2"></li> 
	      </ol> -->   
<!-- 		<div class="carousel-inner" role="listbox"> -->
	<%-- 	<div class="item item1 active">
				<!-- <span class="first-slide"></span> -->
				<img class="first-slide" src="${ctxt}/resources/images/main/slide_image_1.png">
				<div class="container">
					<div class="carousel-caption">
					</div>
				</div>
			</div>
	        <div class="item item2 active">
	        	<span class="second-slide"></span>
				<img class="second-slide" src="${ctxt}/resources/images/main/slide_image_2.png">
				<div class="container">
					<div class="carousel-caption">
					</div>
				</div>
			</div>
	        <div class="item item3 active">
				<span class="third-slide"></span>
				<img class="third-slide" src="${ctxt}/resources/images/main/slide_image_3.png"> 
				<div class="container">
					<div class="carousel-caption">
					</div>
				</div>
			</div>	 --%> 
			<!-- 메인 이미지 Fade -->
			 <div style="width:100%;height:100%;" class="slideshow_box">
			    <ul class="slideshow">		    	    
			    	<li><img src="${ctxt}/resources/images/main/slide_image_2.png" alt="슬라이드 이미지"/></li>
			    	
			    	<li><img src="${ctxt}/resources/images/main/slide_image_3.png" alt="슬라이드 이미지"/></li>
			    	
			    	<li><img src="${ctxt}/resources/images/main/slide_image_1.png" alt="슬라이드 이미지"/></li>
				</ul>
			</div>
	     </div>    
		  <!-- <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev" style="background-image:none">
	        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	        <span class="sr-only">Previous</span>
	      </a>
	      <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next" style="background-image:none">
	        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	        <span class="sr-only">Next</span>
	      </a>  --> 
<!--     </div> -->
    <!-- /.carousel -->
	<!-- BootStrap END -->
<!-- 	</div> -->
</body>

<script type="text/javascript" src="${ctxt}/resources/js/jquery.bxSlider1.js" charset="utf-8"></script>	
<script type="text/javascript" src="${ctxt}/resources/js/jquery.bxSlider2.js" charset="utf-8"></script>		
<script type="text/javascript">

	$(function() {			
		slide=	$(".box1").bxSlider({
			mode:"horizontal",
			auto:true,
			speed:500,
			pager:false,
			controls:false, 
			displaySlideQty : 8,
			width : 900
			}
		);
	
		  // "다음" 버튼 클릭시 
	    $('.next').click(function(){

	    	slide.goToNextSlide();
	    
	    });
	    // "이전" 버튼 클릭시 
	    $(".prev").click(function(){
	
	    	slide.goToPreviousSlide();
	
	    });
	});
	
	
	
	<c:if test="${NCMIK_ELIB_AGREE eq 'Y'}">
		var elibAgree = "Y";
	</c:if>
	<c:if test="${NCMIK_ELIB_AGREE ne 'Y'}">
		var elibAgree = "N";
	</c:if>
	
	
	var PUBMED = "http://www.ncbi.nlm.nih.gov/pubmed?Db=pubmed&Cmd=Search&Term=&otool=ikrkccdlib";
	var SCIENCEDIRECT = "http://www.sciencedirect.com/";
	var SCOPUS = "http://www.scopus.com/";
	var JCR = "http://www.webofknowledge.com/jcr";
	var CLINICAL = "https://www.clinicalkey.com/" ;
	var PROTOCOL = "http://www.currentprotocols.com";
	var MICROMEDEX = "http://www.micromedexsolutions.com/micromedex2/librarian/";
	var ITHENTICATE = "https://app.ithenticate.com/ko/login";
	var COCHRANE = "http://www.cochranelibrary.com/";
	
	function openLink(target){
		var url;
		var use_kb = 0; //0:소속직원, 1:일반사용자, 9: 모든이용자   
		
		var userId = "<c:out value='${userVo.loginid}'/>";
		
		
		if(target == "PUBMED"){
			url = PUBMED;
			use_kb = 9;
			
		}else if(target == "COCHRANE"){
			url = COCHRANE;
			use_kb = 1;
			
		}else if(target == "JCR"){
			url = JCR;
			
		}else if(target == "SCOPUS"){
			url = SCOPUS;
			
		}else if(target == "ITHENTICATE"){
			url = ITHENTICATE;  //현재 전자자원에 등록되어 있지않으므로 바로 연결
			use_kb = 9;
			
		}else if(target == "MICROMEDEX"){
			url = MICROMEDEX;
			use_kb = 1;
			
		}else if(target == "CLINICAL"){
			
			url = CLINICAL;
			
		}else if(target == "PROTOCOL"){
			url = PROTOCOL;
			
		}
		
		var appl = '${userVo.instttyid}';

		var cURL;
		
		//임시
		cURL = url;
		
		//비로그인
// 		if(userId == ""){
// 			if (elibAgree == "Y") {
// 				cURL = "http://152.99.73.136/_Lib_Proxy_Url/" + url;
// 			}
			
// 			if (elibAgree == "N") {
// 				if(use_kb == 9){
// 					cURL = url;
					
// 				}else{
// 					cURL = "http://152.99.73.136/_Lib_Proxy_Url/" + url;
// 				}
// 			}
// 		}
		
		//로그인
// 		else {
// 			if (elibAgree == "Y") {
// 				cURL = "http://152.99.73.136/_Lib_Proxy_Url/" + url;
// 				alert("1");
// 			}
// 			if (elibAgree == "N") {
// 				if(appl == "1" || appl == "2" ){
// 					cURL = "http://152.99.73.136/_Lib_Proxy_Url/" + url;
// 					alert("2");
// 				}else{
// 					alert("사용중인 IP 주소는 허용되지 않은 IP로 등록되어 있어 서비스 이용이 불가능 합니다.");
// 					return;				
// 				}
// 			}
// 		}
		
		window.open(cURL);
	}
	
	

</script>					
					 		
		
		
		
		
		
		
		