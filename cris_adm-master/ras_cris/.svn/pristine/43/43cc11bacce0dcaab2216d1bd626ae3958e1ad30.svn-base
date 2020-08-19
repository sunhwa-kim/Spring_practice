<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
body { font-family: "Noto Sans Korean", sans-serif !important; width: 100%; height: 100%; margin: 0; padding: 0; }

.sub_center_nav{ 
	font-size: 12px; 
	font-weight: 400; 
	color: #666; 
	text-align:right; 
	padding-right:5px; 
	font-weight:normal;
}
.sub_center_nav>span{ 
	margin-left:3px; 
	color:#4CACC4;
	font-weight:bold;
}
.under_bar {
    border-top: 1px solid #e6e6e6;
    width: 100%;
    margin: 5px 0 15px 0;
}
.content_wrap {
    width: 100%;
    position: relative;
}
.content_list {
    text-align: left;
    width:90%;
    margin:0 auto;
    padding:40px 0;
    display: block;
}
.content_list>.list_title{
	color: #6f6f6f;
    font-weight: bold;
    display: inline-block;
    padding-top: 0px;
    margin-bottom: 5px;
    display: block;
}
.content_list>.list_title>p{
	margin: 0;
    display: inline-block;
    border-top: 0px solid rgba(0,0,0,0.3);
    font-size: 13px;
}
.content_list>.list_title>span{
	font-size: 14px;
	font-weight:bold;
	margin:10px 0;
	color:#003964; 
	margin-left:10px;
}
.content_list>.list_title>p:before{
	display: inline-block;
    content: "■";
    padding-right: 5px;
}
.circle {
    padding-left: 10px;
    font-size: 14px;
    font-weight: normal;
    color: #666;
    margin-bottom:5px;
}
.circle:before {
    display: inline-block;
    width: 15px;
    height: 10px;
    content: "●";
    color: #939393;
    font-size: 10px;
    padding-left: 0px;
}
#divUcont_cont{
	text-indent:10px;
	text-align:justify;
	font-size:14px;
}
/* .under_bar {
    border-top: 2px solid #e6e6e6;
    width: 976px;
    height: 3px;
    margin-left: 15px;
} */

</style>

	<div class="content_wrap" >
		<div class="content_list">
			<div class="sub_center_nav">      
			     <span class="active">초록내용</span> 
		    </div>			
			<div class="under_bar"></div>
			
			<div class="list_title">
				<p class="title">제목</p>
				<span>	${title}</span>
			</div>
			
			<p class="circle">영문</p>
			<div id="divUcont_cont">
				${str_abstract}
			</div>
			
			<p class="circle">국문</p>
			<div id="divUcont_cont">
				${str_abstract2}
			</div>
		</div>
	</div>


<%-- <div id="container" class="container" style="margin-top: 10%;">
	<div  style="float:left;margin-left: 5%;margin-right: 5%;">
		${title}
	</div> 
	<div class="under_bar" style="float:left;margin-left: 5%;margin-right: 5%;"></div>
	<br />
	<br />
	<div id="divUcont_cont" style="margin-left: 5%;margin-right: 5%;"> 
		${str_abstract}
		<br />
		${str_abstract2}
	</div>
</div> --%>

