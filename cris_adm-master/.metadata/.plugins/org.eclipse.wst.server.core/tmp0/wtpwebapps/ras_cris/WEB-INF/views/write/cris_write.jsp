<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
*{margin:0px; padding:0px;}

#navigation{
	position:fixed; 
	top:0px;
	left:0px;
	height:80px;
	width:100%; 
	background:#000;	  
	text-align:center;
	font-size:14px;
}
#navigation ul { list-style:none; margin-top:150px; }		   		
#navigation li { display:inline; margin-right:10px; }
#navigation li a { text-decoration:none; color:black;}
#navigation li a:hover {color:#0F0;}

#wrap { width:100%;margin:0 auto;margin-top:80px; }

#step1{background:white; height:1200px;}
#step2{background:RoyalBlue; height:1200px;}
#step3{background:Gold; height:1200px;}
#step4{background:RoyalBlue; height:1200px;}
#step5{background:white; height:1200px;}
#step6{background:RoyalBlue; height:1200px;}
#step7{background:white; height:1200px;}
#step8{background:RoyalBlue; height:1200px;}
#step9{background:white; height:1200px;}
#step10{background:RoyalBlue; height:1200px;}
#step11{background:white; height:1200px;}
#step12{background:RoyalBlue; height:1200px;}
</style>

<script type="text/javascript">
	var cur_scoll=1;
	var old_scoll=1;
	var speed = 300;	// 스크롤 스피드 수치로 사용할 변수 
	var cur_top =0;
	var scroll_event = true;
	var page_height = 1200;
	//로직
	function scrolling(obj){
		if (!obj){	// 예외처리, 현재는 기능적으로 필요한 부분은 아님, 관례적 사용
			$('html, body').animate({scrollTop:0},speed);
		}else{
			var posTop = $(obj).offset().top -80;	// posTop = 매개변수로 들어온 컨텐츠 obj 의 offset().top - 네비게이션 높이
			$('html, body').animate({scrollTop:posTop}, speed )	// body의 스크롤이동 : posTop
		}
	};
	
	
	$(function(){
		$("#step1").load("${ctxt}/write/step/step1.do");
		$("#step2").load("${ctxt}/write/step/step1.do");
		$("#step3").load("${ctxt}/write/step/step1.do");
		$("#step4").load("${ctxt}/write/step/step1.do");
		$("#step5").load("${ctxt}/write/step/step1.do");
		$("#step6").load("${ctxt}/write/step/step1.do");
		$("#step7").load("${ctxt}/write/step/step1.do");
		$("#step8").load("${ctxt}/write/step/step1.do");
		$("#step9").load("${ctxt}/write/step/step1.do");
		$("#step10").load("${ctxt}/write/step/step1.do");
		$("#step11").load("${ctxt}/write/step/step1.do");
		$("#step12").load("${ctxt}/write/step/step1.do");

		$("ul li a").click(function(){	// 네비게이션 클릭시
			var direction = $(this).attr("href");	// direction = 클릭한 요소의 href 속성
			cur_scoll = Number(direction.replace('#step',''));
			scrolling( direction );	// direction 을 인자로 함수 실행
			cur_top = $(window).scrollTop();
			return false;	// 본래 이벤트 방지    
		});
		
  		$(document).on('mousewheel ',function(e) {
			cur_top = $(window).scrollTop();
			var cur_add = cur_top % page_height;
			if(cur_top >= page_height){
				cur_scoll = Math.round(cur_top / page_height) ;
				if(cur_add > 1000){
					cur_scoll = cur_scoll +1;
				}
				if(Number(cur_scoll) > 12){  
					cur_scoll = 12;
				}
			}else{
				cur_scoll=1;
			}   
		});  
  		
		$(document).keyup(function(e){
			if(e.keyCode ==38){
				if(cur_scoll != 1){
					cur_scoll = Number(cur_scoll) -1;	
					$("#nav"+cur_scoll).trigger('click');
				}
			}else if(e.keyCode ==40){
				cur_scoll = Number(cur_scoll) + 1;   
				if(Number(cur_scoll) > 12){
					cur_scoll = 12;	
				}else{
					$("#nav"+cur_scoll).trigger('click');
				}
			}
		});
	});	
	
	function fn_setScroll(){
		cur_top = $(window).scrollTop();
		var cur_add = cur_top % page_height;
		if(cur_top >= page_height){
			cur_scoll = Math.round(cur_top / page_height) ;
			if(cur_add > 1000){
				cur_scoll = cur_scoll +1;
			}
			if(Number(cur_scoll) > 12){  
				cur_scoll = 12;
			}
		}else{
			cur_scoll=1;
		}  
	}
	
</script>
  
<div id="navigation">
    <ul>
        <li><a href="#step1" id="nav1"> SALMON </a></li>
        <li><a href="#step2" id="nav2"> ROYALBLUE </a> </li>    
        <li><a href="#step3" id="nav3"> GOLD </a> </li>
        <li><a href="#step4" id="nav4"> BLACK </a> </li>
        <li><a href="#step5" id="nav5"> SALMON </a> </li>
        <li><a href="#step6" id="nav6"> ROYALBLUE </a> </li>
        <li><a href="#step7" id="nav7"> GOLD </a> </li>
        <li><a href="#step8" id="nav8"> BLACK </a> </li>
        <li><a href="#step9" id="nav9"> SALMON </a> </li>
        <li><a href="#step10" id="nav10"> ROYALBLUE </a> </li>
        <li><a href="#step11" id="nav11"> GOLD </a> </li>
        <li><a href="#step12" id="nav12"> BLACK </a> </li>  
    </ul>
</div>

<div id="wrap" onclick="fn_setScroll();">
    <div id="step1"></div>
    <div id="step2"></div>
    <div id="step3"></div>
    <div id="step4"></div>  
    <div id="step5"></div>  
    <div id="step6"></div>  
    <div id="step7"></div>
    <div id="step8"></div>
    <div id="step9"></div>
    <div id="step10"></div>
    <div id="step11"></div>
    <div id="step12"></div> 
</div>   

