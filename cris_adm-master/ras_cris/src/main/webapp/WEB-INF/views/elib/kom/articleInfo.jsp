<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<!-- default header name is X-CSRF-TOKEN -->
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>	

<!-- jquery -->
<script src="${ctxt}/resources/js/jquery-1.11.3.min.js"></script>
<script src="${ctxt}/resources/js/chart/jui/jquery-ui.min.js"></script>
<script src="${ctxt}/resources/js/jquery.easing.min.js"></script>
<script src="${ctxt}/resources/js/html5shiv.min.js"></script>
<!--[if lt ie 9]><![endif]-->
<script src="${ctxt}/resources/js/_front_end_main.js"></script>
<script src="${ctxt}/resources/js/_front_end_gnb.js"></script>
<script src="${ctxt}/resources/js/_front_end_footer.js"></script>    
<script src="${ctxt}/resources/js/_front_end_sub.js"></script>
<script src="${ctxt}/resources/js/visual.js"></script>
<!-- common js -->
<script src="${ctxt}/resources/js/common.js"></script>

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
	margin-left:10px;
	font-size:14px;
	margin-bottom:20px;
}
a {
	color: #666;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: rgba(0, 57, 100, 0.0);
    text-align: center;
    font-weight: 400;
    font-size: 13px;
    padding: 5px 7px;
    text-align: center;
    text-decoration: none;
    transform: translate(0, -50%);
    -o-transform: translate(0, -50%);
    -ms-transform: translate(0, -50%);
    -moz-transform: translate(0, -50%);
    -webkit-transform: translate(0, -50%);
    background-color: white;
}
a:hover, a:active {
    color: #B15735;
    text-decoration:underline;
}
/* .under_bar {
    border-top: 2px solid #e6e6e6;
    width: 976px;
    height: 3px;
    margin-left: 15px;
} */
</style>

<script>
//내려받기
function sendToFile(file_type) {
	
		$('#file_type').val(file_type);
		
        document.sendToFileForm.submit();
}	
</script>
			
<form id="artctrlForm" name="sendToFileForm" action="${ctxt}/elib/kom/searchOutput.do" method="get">
	<input type="hidden" id="artctrlno" name="artctrlno" value="${artctrlno}" />
	<input type="hidden" id="file_type" name="file_type" value="" />
</form>
<div class="content_wrap" >
	<div class="content_list">
		<div class="sub_center_nav">      
		     <span class="active">서지정보</span> 
	    </div>
	    
	    <div class="under_bar"></div>
	    
	    <div class="list_title">
			<p class="title">MA</p>
		</div>
		<div id="divUcont_cont">
			${ma}
		</div>
		
		<div class="list_title">
			<p class="title">LA</p>
		</div>
		<div id="divUcont_cont">
			${la}
		</div>
		
		<div class="list_title">
			<p class="title">PA</p>
		</div>
		<div id="divUcont_cont">
			${pa}
		</div>
		
		<div class="under_bar"></div>
		
		<div id="divUcont_cont" style="text-align:center;color: #666;"> 
		Download as <a href="javascript:sendToFile('RIS')">RIS</a> 
					<a href="javascript:sendToFile('NBIB')">NBIB</a> 
					<a href="javascript:sendToFile('JSON')">JSON</a>
		</div>
	</div>
</div>

<%-- <form id="artctrlForm" name="sendToFileForm" action="/elib/kom/searchOutput.do" method="get">
	<input type="hidden" id="artctrlno" name="artctrlno" value="${artctrlno}" />
	<input type="hidden" id="file_type" name="file_type" value="" />
</form>

<div id="container" class="container" style="margin-top: 10%;">
	<div  style="float:left;margin-left: 5%;margin-right: 5%;">
	</div> 
	<div class="under_bar" style="float:left;margin-left: 5%;margin-right: 5%;"></div>
	
	<div id="divUcont_cont" style="margin-left: 5%;margin-right: 5%;"> 
		<br />
		<br /> 
		${ma}
		<br />
		<br /> 
	</div>
	<div class="under_bar" style="float:left;margin-left: 5%;margin-right: 5%;"></div>
	
	<div id="divUcont_cont" style="margin-left: 5%;margin-right: 5%;"> 
		<br />
		<br /> 
		${la}
		<br />
		<br />
	</div>
	<div class="under_bar" style="float:left;margin-left: 5%;margin-right: 5%;"></div>
	<div id="divUcont_cont" style="margin-left: 5%;margin-right: 5%;"> 
		<br />
		<br /> 
		${pa}
		<br />
		<br />
	</div>
	<div id="divUcont_cont" style="margin-left: 30%;"> 
	Download as <a href="javascript:sendToFile('RIS')">RIS</a> 
				<a href="javascript:sendToFile('NBIB')">NBIB</a> 
				<a href="javascript:sendToFile('JSON')">JSON</a>
	</div>
</div>
 --%>