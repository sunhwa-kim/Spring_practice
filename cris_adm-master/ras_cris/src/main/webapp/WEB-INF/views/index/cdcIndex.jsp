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
    
    /* $('#Round_box2 div').mouseenter(function(){
    	$(this).css('z-index', 5);
    });
    $('#Round_box2>a>div').mouseleave(function(){
    	$('#Round0001').css('z-index', 4);
    	$('#Round0002').css('z-index', 3);
    	$('#Round0003').css('z-index', 2);
    	$('#Round0004').css('z-index', 1);
    }); */
    
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
	fn_createChart('');
	//fn_search();
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
	
	    var duration = 300;

	    // aside ----------------------------------------
//		    var $drop_box = $('.dorp_in_drop > .dorp_in_drop_box');
//		    var $button = $('.dorp_in_drop')
//		        .on('click', function(){
//		            $drop_box.toggleClass('open');
//		            if($drop_box.hasClass('open')){
//		                $drop_box.stop(true).slideDown('$drop_box');

//		            }else{
//		                $drop_box.stop(true).slideUp('$drop_box');
//		            };
//		        });
	    
	    $(".dorp_in_drop").click(function(){
	    	
	    	   //var submenu = $(this).next("ul");
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
// 					$('.chart_name').text('KoreaOpenMed 구축현황 (누적: 345000건)');//Number(totalCnt).toLocaleString('en').split(".")[0]
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
	           {quarter:2015,해당년도:39868,이전년도:0,total:39868},
	           {quarter:2016,해당년도:143563,이전년도:39868,total:183431},
	           {quarter:2017,해당년도:65839,이전년도:183431,total:249270},
	           {quarter:2018,해당년도:"${data.inkorea_totalSize}"-249270,이전년도:249270,total: "${data.inkorea_totalSize}"},
	           {quarter:2019,해당년도:0,이전년도:249270,total: "${data.inkorea_totalSize}"}
			  ];
	var c = chart("#result", {
		padding:{
			top:40,
			right:25,
			left:20,
			bottom:25
		},
	    axis : [{
	        x : {
	            type : "block",
	            domain : "quarter",
	            //line : true
	        },
	        y : {
	            type : "range",
	            domain :[0,400000],
	            step : 1,
	            //line : true,
// 	            hide:true
	        },    
	        data : data
	    }],
	    brush : [
           {type : "stackcolumn",
	        target : ["이전년도","해당년도"],
	        size:40,
// 	        display : "all",
	        active : 5,
	        activeEvent : "mouseover",
	        animate : true,
	        outerPadding : 10},
	        {
	        	type:"line",
	        	target:"total",
	        	colors:["#39d"]
	        },
	        {
	        	type:"scatter",
	        	target:"total",
	        	colors:["#A97D5D"],
	        	display : "all"
	        }
	    ],
	     widget : [
	          	{type : "tooltip", orient: "top" },
	          	{type : "tooltip", brush: 2 },
	          ], 
	          format : function(value ,gbn) {
	        	if(gbn != undefined){
	        		return value;
	        	}else{
	        		return comma(value);
	        	}
	      	}
	});
     
     
	// Events defined by the method
// 	c.on("rclick", function(obj, e) {
// 	});
	$('.grid-range ').find('text').text('');
	$('#result ').find('svg').attr('style','height:90%');
// 	$('.brush-line ').find('text').attr('style','margin-bottom:50px;');
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


function mainGoSearch(){
	var search = $("#searchQuery").val();
	if(search==""){
		alert("검색어를 입력해 주십시오.");
	}else{
		var gsWin = window.open('about:blank','searchForm');
		$("#searchForm").attr("onsubmit", "");
		$("#searchForm").attr("target", "searchForm");
		$("#searchForm").submit(); 
	}
}
</script>

<style>
	#header {
    	width:100%;
    	position:relative;
    	transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
	#logo{
		width:17%;
	    min-width:218px;
	    transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
  	.navbar-wrapper {
	    width: 60%;
	    position:absolute;
	    transition:all 0.3s;
		-webkit-transition:all 0.3s;
		top: -10px;
  	}
  	#container-wrap {
	  	width: 100%;
	  	transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
  	.container{
		width:100%;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
	ul.gnb2{
		width:20%;
		max-width:200px;
	}

	.top_login>a{
 		display:none;
		transition:all 0.3s;
		-webkit-transition:all 0.3s; 
	}
	.mainsearchbox{
		display:inline-block;
		width:100%;
		max-width:536px;
		position:relative;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
 	.webdesigntuts-workshop input{	 	
		min-width:300px;
		position:relative;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
		
	} 
	.webdesigntuts-workshop button{
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
	#noticnpop{
		width: 40%;
		margin: 0;
		float:right;
		height:100%;
	}
	
	#notic_body>.Notice2:first-child{
		margin-bottom: 0;
	}
	.Notice3{
	    height: 90px;
	}
	.Notice2, .Notice3{
		box-shadow: none;
    	-o-box-shadow: none;
    	-ms-box-shadow: none;
    	-moz-box-shadow: none;
		-webkit-box-shadow: none;
	 	border: none;
	 	overflow:unset;
	}
	#notic_body:nth-child(1){
		margin-left:auto;
		height: 200px;
	}

	#notic_body {
		width: 100%;
	    transition: all 0.5s;
	    -webkit-transition: all 0.5s;
    	margin:0 auto;
    	float:none;
    	display:block;
	}
	/* select-box width사이즈 */
	.select-width{
		width: 25%;
	}	

	.Notice3>ul{
		margin-top: 0;
	}
 
 	#header{
 		padding:0;
 	}
 	#logo{
		position:absolute;
		left:0;
		top:0;
	}
 	#nav_gnb{
 		height:115px;
 	}
 	.navbar-wrapper .navbar{
 		margin:20px 0 0 0;
 	}
 	.webdesigntuts-workshop input{	 	
 		width:70%;
		position:absolute;
		right:45px;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
	    height: 38px;
	} 
	.webdesigntuts-workshop button{
		float:right;
		height:38px;
		width:38px;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
	.navbar-wrapper .navbar{
	    top: 0;
	    left: 0;
   		transform: translate(0,0);
   		-o-transform: translate(0,0);
   		-ms-transform: translate(0,0);
   		-moz-transform: translate(0,0);
   		-webkit-transform: translate(0,0);
   		transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
	.mainsearchbox {
	    background: rgba(0,0,0,0.0);
	    border: 0px solid rgba(0,0,0,0.15);
	    padding: 0;
	    padding-bottom: 0;
	    transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
	.mainsearchbox>.help{
		display:none;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
	.webdesigntuts-workshop input{
		border:1px solid #ccc;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
		font-size:13px;
	}
	.mainsearchbox button{
		font-size:12px;
	}
	
	#Round_box2{
		top:150px;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}

	.webdesigntuts-workshop input{	 	
 		min-width:180px;
 		width:190px;
	} 	

	.headerWrap{
		height:50px;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;	
	}
	ul.gnb1{
		display:none;	
	}
	.menu_div{
		height:96px;
	}
	#under_bar{
		top:50px;
	}
	.hamburger{
		display:block;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;	
	}
	.hamburger_drop.on {
	    display: block;
	}
	.carousel{
	    width: 60%;
	    height:100%;
        max-width: 688.8px;
        margin: 0;
        display: inline-block;
        top:0px;
        
	}	
	#myCarousel>.carousel-inner{
		width: 100%;
		height:100%;
		left: 0;
		margin: 0;
		transform: none; 
	    -o-transform: none;
	    -ms-transform: none;
	    -moz-transform: none;
	    -webkit-transform: none;
	}
	
	#Round0001, #Round0002, #Round0003, #Round0004{
		width:40%;		
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
	#Round_box2 {
	    height: 270px;
	    top: 70px;
	    z-index: 2;
	    transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
	#Round_box2>div{
		width:80%;
		display:block;
		margin:0 auto;
	}
	#Round0001{ width:33%;	left:18%; }
	#Round0002{ width:33%;	left:13%; }
	#Round0003{ width:35%;	left:18%; }
	#Round0004{ width:33%;	left:11%; }
	

	#Round0003{ margin-top:-4%; }
	#Round0004{ margin-top:-4%; }
	
	
	/*호버되는이미지*/
	#Round0001:hover .overlay {
	  display:none !important;
	}
	#Round0002:hover .overlay {
	  display:none !important;
	}
	#Round0003:hover .overlay {
	  display:none !important;
	}
	#Round0004:hover .overlay {
	  display:none !important;
	}
	
	/* notic_body */
	.Notice{
		height:100%;
		padding:10px;
		position:relative;
		border: 1px solid #E7E7E7;
		box-shadow: none;
    	-o-box-shadow: none;
    	-ms-box-shadow: none;
    	-moz-box-shadow: none;
    	-webkit-box-shadow: none;
		border-top: none;
	}
	.boardTab{
		font-size:17px;
		margin-left: 0;
	}
	.plus>a {
    width: 20px;
    height: 20px;
	}
	.plus>a>span {
    	font-size: 27px;
	}
	.Notice li ul li a{
		font-size:13px;
		padding: 5px 0px;
		margin:0px;
	}
	.Notice>ul>li>ul>li:last-child{
		border-bottom:0;
	}
	.plus {
    top: 10px;
    right: 10px;
	}
	.t2 {
    	font-size: 12px;
	}
	.mainsearchbox{
		width:370px;
	}
	
	.webdesigntuts-workshop input{
		left:0;
		min-width:324px;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
		float:left;
	}
	.webdesigntuts-workshop button {
	    margin:0;
	    width: 43px;
	    height: 40px;
	    margin-left: 7px;
	    float:right;
	}
	.webdesigntuts-workshop input{
		height:40px;
		margin:0;
		padding-left: 7px;
	}
	.mainsearchbox button {
	    font-size: 11px;
	}

	.Notice li ul li {
	 	border-bottom: 1px dashed #ccc;
	    padding: 3px 0px;
	}
	.t0{
		width: 30px;
	}
	.Notice > #brd_notice01{
		padding:0;
	}

	#brd_list1, #brd_list2, #brd_list3 {
	    max-width: 100%;
	    margin-top:0;
	}
	.Notice li a.boardTab{
		font-size: 18px;
    	padding-left: 0;
    	margin-left: 0;
	}
	
	#result svg{
		height:90%;
	}
 </style>
	
<!-- BootStrap -->
	
	<!-- NAVBAR
================================================== -->
<div class="mainSampleWrap" style="height:400px; position:relative;">
	<div class="navbar-wrapper">
      <div class="container">
        <nav class="navbar navbar-static-top" style="z-index:0;">
          <div class="container">
          	<form id="searchForm" name="searchForm" action="${ctxt}/search/search.do" method="post" onsubmit="return false;">
          		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
          		<input type="hidden" name="searchTarget" value="book"/>
	           <div id="Search_bg">
					<section class="webdesigntuts-workshop">
						<div class="mainsearchbox">
							<input type="search" id="searchQuery" name="searchQuery" placeholder=" 검색어를 입력하여 주십시오">
							<!--  
							<button style="background-image: url(${ctxt}/resources/images/main/icon1.PNG);"></button>
							<button style="background-image: url(${ctxt}/resources/images/main/icon2.PNG);">상세검색</button>
							<button id="mark" style="background-image: url(${ctxt}/resources/images/main/icon3.PNG);">  
							</button> -->
							<button onclick="mainGoSearch();"><!-- <i class="fas fa-search"></i> -->검색</button>
							<!--  <button>상세검색</button>
							<button id="mark">?<span></span></button> -->
							
							<div class="help">
								 <%-- <a href="${ctxt}/search/dtlSearch.do">상세검색</a> --%>
								<a href="javascript:detailSearch();">상세검색</a> 
								<span>|</span>
								<a href="">도움말&nbsp; </a>
							</div>
						</div>
						
					</section>
					
				</div>
			</form>
          </div>
        </nav>
      </div>
    </div>
  
	 <!-- Carousel
    ================================================== -->
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
		<div class="carousel-inner" role="listbox">
		<div id="Round_box2">
	        	<div>
		  			<a rel="noopener noreferrer" href="${ctxt}/elib/kom/listKom.do" target="_blank">
						<div id="Round0001">
							<div class="overlay" style="display:none;">
								<div class="round_text0001">국내 의과학 학술논문<br>정보입니다.</div>
							    <div class="round_text0002">KoreaOpenMed</div>
							</div>
							
						</div>
					</a>
		
		  			<a rel="noopener noreferrer" href="http://search.ebscohost.com/login.aspx?direct=true&site=eds-live&scope=site&type=0&custid=s1244029&groupid=main&profid=eds" target="_blank">
						<div id="Round0002">
							<div class="overlay" style="display:none;">
								<div class="round_text0001">EBSCO Discovery<br>서비스입니다.</div>
								<div class="round_text0002">Digital Library</div>
							</div>
						</div>
					</a>
					
		  			<a rel="noopener noreferrer" href="${ctxt}/archive/intro/archiveIntro.do" target="_blank">
						<div id="Round0003">
							<div class="overlay" style="display:none;">
								<div class="round_text0001"> R&D보고서<br>성과논문 정보를 <br>서비스 합니다.</div>
								<div class="round_text0002">ARCHIVE</div>
							</div>
						</div>
					</a>
		
		  			<a rel="noopener noreferrer" href="http://www.kcdcphrp.org/" target="_blank">
						<div id="Round0004">
							<div class="overlay"  style="display:none;">
								<div class="round_text0001">Public Health and<br>Research Perspectives</div>
								<div class="round_text0002">PHRP</div>
		
							</div>
						</div>
					</a>
				</div>
	        </div>
    </div>
    </div>
    <!-- /.carousel -->
	<!-- BootStrap END -->

	<!-- 그래프,공지사항 -->
	 <div id="noticnpop"> 
	
		<!-- tag cloud -->
		<%-- <div id="notic_body">
			<div class="Notice">
				<c:forEach var="hotSearchList" items="${hotData.hotSearchList}" varStatus="status">
					<c:if test="${status.index < 30}">
						<li id="hotKeyword${status.index}" class="tc_list" style="display: none;" value="${hotSearchList.keyword}">${hotSearchList.ranking }. ${hotSearchList.keyword}</li>
					</c:if>
				</c:forEach>
			<div id="container" style="width:100%; height:100%; border: 0px solid #ccc; margin: 1%;"></div>
			</div>
		</div> --%>
		
		<!-- graph  -->
		<div id="notic_body" style="border:1px solid #E7E7E7;">
			<h3 style="position:absolute;margin-top: 0;padding-left:10px; ">
					<span class="boardTab"><span style="font-size:15px; padding-top:1.5px;">Korea<span><img src="${ctxt}/resources/images/sub/o.png" style="width:17px; margin-left:10px;margin-top:-8px;"><span>penMed</span> 현황</span>
				</h3>
			<div class="Notice2">
				<div id="result" style="height: 100%; width: 95%; margin:0 auto;margin-top:25px;">
		
				</div>
<!-- 				<span class="chart_name" style="font-size: 13px;"></span> -->
			</div>
			<!-- <div class="Notice3">
				<ul class="circle_row">
					<li style="background:rgba(77,137,99,0.7);">
						<div>
							<p><strong>1,200</strong>여종</p>
							<p class="line"></p>
							<p>국내 의과학<br>학술지</p>   
						</div>
					</li>
					<li style="background:rgba(156,159,132,0.7);">
						<div>
							<p><strong>1만</strong>여종</p>
							<p class="line"></p>
							<p>보건복지 <br>관련 보고서</p>
						</div>
					</li>
					<li style="background:rgba(170,125,94,0.7);">
						<div>
							<p><strong>16</strong>여종</p>
							<p class="line"></p>
							<p>Web DB</p>
						</div>
					</li>
					<li style="background:rgba(92,117,95,0.7);">
						<div>
							<p><strong>1만</strong>여종</p>
							<p class="line"></p>
							<p>전자저널</p>
						</div>
					</li>
				</ul>
			</div> -->
		</div>
	
	
		
		<!-- 공지사항 -->
		 <div id="notic_body" style="height:200px;">
			<div class="Notice">
				<ul id="brd_notice01" class="main_tab1">
					<li class="brd_tab1">
						<h3>
							<span class="boardTab">공지사항</span>
						</h3>				
						<script type="text/javascript">
						//메인 공지사항 영역
						$(function(){
								$.ajax({
								        url: '${ctxt}/centerintro/noti/mainNotiList.do',		
								        data: {},
								        type: 'GET',
								        dataType: 'text',
								        cache: false,
								        success: function(result) {	
								        
								        	var rtnObj = $(result);
								        	var html = "";
								        		        	
								        if (rtnObj.find('item').length > 0 ){
								        	rtnObj.find('item').each(function(idx){
											
								            	var alit_id = $(this).find('alit_id').text(); // 공지사항 ID
									        	var alit_sj = $(this).find('alit_sj').text(); // 제목
									        	var reg_date = $(this).find('reg_date').text(); // 등록일
									        	var new_img = $(this).find('new_img').text(); // new 여부				
									        	var alit_type = $(this).find('alit_type').text();  // 1 : 공지 , 2 : 홍보, 3 : 보도 , 4 : 과학(의생명과학소식1,2,3,4) 
									        	
									        	html +='<li>';
									        	
									    	 	if(alit_type == '1'){
								        	 		html += '<span class = "t0" title = "">공지</span>'; 										        	 		
								        	 	}else if(alit_type == '2'){
								        	 		html += '<span class = "t0" title = "">홍보</span>'; 	
								        	 	}else if(alit_type == '3'){
								        	 		html += '<span class = "t0" title = "">교육</span>';
								        	 	}else if(alit_type == '4'){
								        	 		html += '<span class = "t0" title = "">과학</span>'; 	
								        	 	}							        				
									    	 	
									        	if(new_img == 'Y'){
									        		if(byteCheck2(alit_sj) > 30){
									        			html += '<span class="t1" title = "'+alit_sj+'"><a rel="noopener noreferrer" href="${ctxt}/centerintro/noti/notiView.do?alit_id='+alit_id+'" target="_blank">'+cutByLen(alit_sj,30)+'...'+'</a></span> <span class="t2" title = "등록일">'+reg_date+'</span> <img src="${ctxt}/resources/images/main/ico_new_red.gif" alt="신규 공지사항" style="width:8%"/>';
									        		}else{
									        			html += '<span class="t1" title = "'+alit_sj+'"><a rel="noopener noreferrer" href="${ctxt}/centerintro/noti/notiView.do?alit_id='+alit_id+'" target="_blank">'+cutByLen(alit_sj,30)+'</a></span> <span class="t2" title = "등록일">'+reg_date+'</span> <img src="${ctxt}/resources/images/main/ico_new_red.gif" alt="신규 공지사항" style="width:8%"/>';
									        		}
									        	}else{								        		
									        		if(byteCheck2(alit_sj) > 30){
									        			html += '<span class="t1" title = "'+alit_sj+'"><a rel="noopener noreferrer" href="${ctxt}/centerintro/noti/notiView.do?alit_id='+alit_id+'" target="_blank">'+cutByLen(alit_sj,30)+'...'+'</a></span> <span class="t2" title = "등록일">'+reg_date+'</span>';	
									        		}else{
									        			html += '<span class="t1" title = "'+alit_sj+'"><a rel="noopener noreferrer" href="${ctxt}/centerintro/noti/notiView.do?alit_id='+alit_id+'" target="_blank">'+cutByLen(alit_sj,30)+'</a></span> <span class="t2" title = "등록일">'+reg_date+'</span>';
									        		}
									        										        		
									        	}
									        	
								        		html +='</li>';
											
								        	});
								        	
								        	$('#brd_list3').children().remove();
								        	$('#brd_list3').html(html);
								 		}else{
								 			$('#brd_list3').children().remove();
											
											$("#brd_list3").html(' <li><a href="#">공지사항된 사항이 없습니다.</a></li> ');
								 		}
											
								        	
								        },
								        error : function(){                              // Ajax 전송 에러 발생시 실행
								        	fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
								        }
								    });
							});
						</script>
	
						<ul id="brd_list3"></ul>
						<p class="plus" id="btn_more1">
							<a rel="noopener noreferrer" href="${ctxt}/centerintro/noti/notiList.do" target="_blank">
								<span>+</span>
							</a>
						</p>
					</li>
				</ul>
			</div>
		</div> 
		<!-- 공지사항 -->
	
	
	</div>
	<!-- 그래프,공지사항 끝-->
	
	
	
	</div>
		