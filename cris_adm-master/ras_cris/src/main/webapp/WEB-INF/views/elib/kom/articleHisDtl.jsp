<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 차트 구성 SCRIPT STR-->
<script type="text/javascript" src="${ctxt}/resources/js/chart/jui/core.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctxt}/resources/js/chart/jui/chart.js" ></script>

<link rel="stylesheet" href="${ctxt}/resources/js/chart/jui/jquery-ui.min.css" />
<script>
//차트 그리기

var isLoad =false;
var view_cnt = "<c:out value='${record.VIEW_CNT}'/>";
var down_cnt = "<c:out value='${record.DOWNLOAD_CNT}'/>";

$(function(){
	$('.print-preview').printPreview();
	
	fn_chartGrid();
	 
}); 

function print2(printArea)
{
		win = window.open(); 
		win.document.open();
		
		/*
			1. div 안의 모든 태그들을 innerHTML을 사용하여 매개변수로 받는다.
			2. window.open() 을 사용하여 새 팝업창을 띄운다.
			3. 열린 새 팝업창에 기본 <html><head><body>를 추가한다.
			4. <body> 안에 매개변수로 받은 printArea를 추가한다.
			5. window.print() 로 인쇄
			6. 인쇄 확인이 되면 팝업창은 자동으로 window.close()를 호출하여 닫힘
		*/

		win.document.write('<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">');
		win.document.write('<html>');
		win.document.write('<head>');
  		win.document.write('<link rel="stylesheet" href="${ctxt}/resources/css/ncmik/subIndex.css" type="text/css" />');
		win.document.write('<link rel="stylesheet" href="${ctxt}/resources/css/popup.css"  type="text/css" /> ');
		win.document.write('<link rel="stylesheet" href="${ctxt}/resources/css/jquery-ui.min.css" type="text/css" />');  
		win.document.write('<link rel="stylesheet" href="${ctxt}/resources/css/ncmik/wonkiIndex.css" type="text/css" />');
		win.document.write('<link rel="stylesheet" href="${ctxt}/resources/css/ncmik/KoreaOpenMed.css" type="text/css" />');  
        win.document.write('<title></title><style type="text/css"> #sidebar-left {display:none !important;}  ');
    	win.document.write('#sidebar-pumed-right {display:none !important;}  ' );
    	win.document.write('.print-preview {display:none !important;}  ');
    	win.document.write('.sub_center_text {display:none !important;}  ' );
    	win.document.write('.sub_book_wrap {width: 96% !important;}  </style> <script>function fn_print(){window.print();window.close();}<\/script>' );
        win.document.write('</head>');
        win.document.write('<body onload="fn_print()">');
        win.document.write(printArea);		
        win.document.write('</body>' );
        win.document.write('</html>');
        win.document.close();
     
}
function fn_send(pop_id){ 
	popOpen(pop_id);
}

function fn_chartGrid(){
	//화면 첫 로드시에만 차트 생성
	if(isLoad){
		return false;
	}
	
	var chart = jui.include("chart.builder");
	
	chart("#gridChart", {    
/* 		width : 400,
		height : 250, */
		width:400,
		height:200,
		padding : {
			left:35,
			right:1,
			top:20
		},
	    axis : {
	        x : {
	            type : "block",
	            domain : "quarter",
	            line : true
	        },
	        y : {
	            type : "range",
	            domain : function(d) { if(d.count > 10000) {return 11000;}
									   else if(d.count > 5000) {return 6000;}
									   else if(d.count > 4000) {return 5000;}
									   else if(d.count > 3000) {return 4000;}
									   else if(d.count > 2000) {return 3000;}
									   else if(d.count > 1000) {return 2000;}
									   else if(d.count > 500) {return 600;}
									   else if(d.count > 300) {return 400;}
									   else {return 300;}
									 },
	            step : 5,
	            line : true,
	            orient : "left"
	        },
	        data : [
	            { quarter : "View", count : Number(view_cnt)},
	            { quarter : "Download", count : Number(down_cnt)},
	        ]
	    },
	    brush : {
	        type : "column",
	        size : 30,
	        target : [ "count" ]
	    },
	    widget : [
	        { type : "tooltip" }
    
	    ],
	    style:{
	    	backgroundColor: "none"
	    }
	    
	});
	
}
/* 파일생성  */
function fn_createFile(){
	
	$('#file_type').val($('input[name=save_file]:checked').val());
	
	var file_form = document.file_form;
	if($('input[name=save_file]:checked').val() == 'xml'){
		file_form.action="${ctxt}/mng/sys/xmlDownload.do";
	}else{
		file_form.action="${ctxt}/mng/sys/csvDownload.do";
	}
	
	//file_form.action="${ctxt}/elib/kom/searchOutput.do";
	file_form.submit(); 
	
}

/* 파일생성  */
function fn_createFile2(){
	
	$('#file_type').val('nbib');
	
	var file_form = document.file_form;
	file_form.action="${ctxt}/mng/sys/csvDownload.do";
	file_form.submit(); 
	
}

/* 메일전송 */
function fn_sendMail(){
	
	var strRegEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	
	// null체크 - e-mail 
	if ($("#email").val() == '') {
		alert('E-mail을 입력하세요');
		$("#email").focus();
		return;
	}
	
    if(!strRegEmail.test($('#email').val())) {
        alert('올바른 전자우편를 입력하세요.');
        $('#mail_id').focus();
        return;
    } 
	
	$.ajax({
		url : "${ctxt}/elib/kom/sendMail.do",
		data : {"artctrlno": $('#artctrlno').val()
				,"email":$('#email').val()
				},
		type : 'post',
		dataType : 'text',
		success : function(args) {
		}
	}); 
}

function fn_close(pop_id){ 
	popClose(pop_id);
}



/*SNS로전송 */
function sendSNS(sns,title){
	
 		var TITLE = $("#title").val();
 	  	var val = "<c:out value='${url}'/>";
 	  	
	  	var FACEBOOK = 'http://www.facebook.com/sharer/sharer.php?u='+encodeURIComponent(val);
	  	var TWITTER = "https://twitter.com/intent/tweet?text=" + TITLE + "&url=" + encodeURIComponent(val);
	  	var GOOGLEPLUS ='https://plus.google.com/share?url='+ encodeURIComponent(val); 
	  		
		switch(sns){
		 case "facebook":
		  window.open(FACEBOOK, "facebookWindow",'width=960,height=500,directories=0,resizable=1,menubar=0,status=0,toolbar=0,scrollbars=1');
		  break;
		 case "twitter":
		  window.open(TWITTER, "twitterWindow",'width=960,height=500,directories=0,resizable=1,menubar=0,status=0,toolbar=0,scrollbars=1');
		  break;
		 case "googleplus":
		  window.open(GOOGLEPLUS, "googleWindow",'width=960,height=500,directories=0,resizable=1,menubar=0,status=0,toolbar=0,scrollbars=1');
		  break;	 
		} 
}


</script>

<style>
	#fillter_article{
		width:100%;
	}
	#gridChart.right2 > svg{
		margin-top:-15px;
	}
	.under_bar2{
	    border-top: 4px solid rgba(51,122,183,0.5);
   	 	margin-top: 35px;
   		margin-bottom: 25px;
	}
	.art_tit{
		color:#003964; margin-bottom:0px; font-size:17px; margin-top: 0px;
	}
	
	.under_bar3{
		border-top: 1px solid rgba(51,122,183,0.5);
   		margin-top: 25px;
   		margin-bottom: 10px;
   		width: 100%;
	}
	.ar_dr_font{
		font-size:13px;
	}
	.ar_dr_t{
		color: #4397e0;
	}
	.btn-group.back{
		margin-top: 18px
	}
	.btn-group.back >a{
   		padding-right: 15px;
	}
	.metrics{
		font-size: 12px;
	    color: #6F6F6F;
	    margin-bottom: 5px;
	    text-align: center;
	    font-family: "Noto Sans Korean", sans-serif !important;
	    text-align: left;
	    border:1px solid #e6e6e6;
	    padding:10px auto;
	}
	.metrics>div>p{
		width:50%;
		display:inline-block;
		color:#6F6F6F;
		text-align:right;
	}
	.metrics>div>span{
		background:#5C755F;
		border-radius:10px;
		padding: 1px 10px;
		color:#fff;
		margin-left:5px;
	}
</style>



<div id="" class="content_wrap" style="">

	<div class="sub_center_text">
		<div class="sub_center_nav"> 
		 <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
		 <span> > </span> 
		 <span>전자자원</span>
		 <span> > </span>
		 <span class="active">KoreaOpenMed</span>        
		</div>
		<span class="center_text_01">학술논문 상세정보</span> 
	</div> 


	
	<div id="sub_center_text" class="" >
	
	<div class="under_bar"></div>	
		
	
		<div class="">
				<!-- <button type="button" class="print-preview print" >인쇄</button> -->
			
			<div class="content_box">
				<div class="content_list">
					<div class="sub_book_wrap">
						<div class="sub_book_wrap" id = "div_body">
							<div id="bodyInfo" style="min-height:200px; padding:0; margin:0; vertical-align:top; color:#606060;">
									
									<div style="font-size:13px;">
									${article.JOURNALNAME}.&nbsp;${article.DATEISSUEDPAPER}.&nbsp;${article.VOLUMENAME}.&nbsp;${article.STARTPAGE}.&nbsp;<c:if test="${article.LANGUAGE eq '한국어' }">Korean.</c:if><c:if test="${article.LANGUAGE ne '한국어' }">${article.LANGUAGE }.</c:if>&nbsp; 
									
									<c:if test="${article.DOI != null}">Doi: ${article.DOI}</c:if>  
									<h3 class="art_tit">${article.TITLE} <c:if test="${article.ALTERNATIVETITLE != '' and article.ALTERNATIVETITLE ne null}">=${article.ALTERNATIVETITLE}</c:if> </h3> 	
									${article.AUTHOR} <c:if test="${article.FIRSTAUTHOR != null and article.FIRSTAUTHOR ne null}"><c:if test="${article.AUTHOR != null and article.AUTHOR ne null}">,</c:if>
									<c:set var="author" value="${fn:split(article.FIRSTAUTHOR,',')}" />
										<c:forEach var="item" items="${author}" varStatus="g">
											<c:if test="${g.index > 0}">, </c:if>
										    ${item}<sup>*</sup>
										</c:forEach> 
									</c:if>   <c:if test="${article.AUTHOR != null}">.</c:if>   
									</div>


	
								<!-- <div>     
									<h3>Abstract</h3>             
								</div>
								<div style="border:1px solid #f0f;">${article.ABSTRACT}
									<c:if test="${article.ABSTRACT2 != null}"><br />${article.ABSTRACT2}</c:if> 
								</div>
								
								<div>
									<font>Keywords :</font> <c:out value='${article.KEYWORD}'/>
								</div>
								<div>
									<font>KNIM ID</font> <c:out value='${article.NCMIKID}'/>
								</div>
								<div>
									<font>DOI : </font><c:out value='${article.DOI}'/>
								</div> -->
								
								<div class="selectbox_wrap" style="height:38px; position:relative; margin:0; padding-top:0;">
									<a href="javascript:sendSNS('twitter','국립의과학지식센터>센터 이용안내')" class="sns_br_none"><img style="height: 25px; width: 25px;" src="${ctxt}/resources/images/sub/ic_twitter.gif" alt="twitter-새창" title="twitter-새창" /></a>
									<a href="javascript:sendSNS('facebook','국립의과학지식센터>센터 이용안내')" class="sns_br_none"><img style="height: 25px; width: 25px; margin-left: 5px;" src="${ctxt}/resources/images/sub/ic_facebook.gif" alt="facebook-새창" title="facebook-새창"/></a>
									<a href="javascript:sendSNS('googleplus','국립의과학지식센터>센터 이용안내')" class="sns_br_none"><img style="height: 25px; width: 25px; margin-left: 5px;" src="${ctxt}/resources/images/sub/google-plus.png" alt="google-새창" title="google-새창"/></a>
									<button style="padding: 0px 10px 10px 5px;" type="button" class="print-preview print print_btn" ><i class="fas fa-print"></i></button>
								</div>
								
								
								
								<div class="under_bar3"></div>
								
								<div class="ar_dr_t">초록(Abstract)</div>
								<div class="ar_dr_font">${article.ABSTRACT}<c:if test="${article.ABSTRACT2 != null}"><br/><br/>${article.ABSTRACT2}</c:if> </div>
								
								<div class="under_bar3"></div>
								
								<div class="ar_dr_t">Keywords</div>
								<div class="ar_dr_font">${article.KEYWORD} <c:if test="${article.KEYWORD2 != null}"><br/></c:if>${article.KEYWORD2}</div>
								<ul id="titleMeshUL" class="toggleHide" >
											<!-- TEXT -->
							            <c:import url="/search/getDetailRDBMESH.do" >
							               <c:param name="metaNo" value="${article.ARTCTRLNO}"/>
							               <c:param name="wkId" value="21"/>
							           </c:import>
								</ul>	
								<div class="under_bar3"></div>
								
								<div class="ar_dr_t">KNLM ID</div>
								<div class="ar_dr_font"><c:out value='${article.ARTCTRLNO}'/></div>
								
								
								
								<%-- <table class="view_table">
									<colgroup>
										<col width='25%' />						
										<col width='25%' />									
										<col width='25%' />									
										<col width='25%' />									
									</colgroup>
									<tbody class="report">
										<tr>
											<th colspan="1" class="detail_list">Abstract</td>
											<td colspan="3" class="detail_content" style="line-height:150%; padding:10px; text-align:justify;">
												<div>${article.ABSTRACT}<c:if test="${article.ABSTRACT2 != null}"><br />${article.ABSTRACT2}</c:if> </div>
											</td>
										</tr>
										<tr>
											<th colspan="1" class="detail_list">Keywords</th>
											<td colspan="3" class="detail_content">${article.KEYWORD}</td>
										</tr>
										<tr>
											<th colspan="1" class="detail_list">KNIM ID</th>
											<td colspan="1" class="detail_content">${article.NCMIKID}</td>
											<th colspan="1" class="detail_list">DOI</th>
											<td colspan="1" class="detail_content">${article.DOI}</td>
										</tr>
									</tbody>
								</table> --%>
								
								
								
								
								
								
								
								
								
								
								<%-- <div class="view_ul_box">
									<!-- <h3>Abstract</h3>
									<div>${article.ABSTRACT}
										<c:if test="${article.ABSTRACT2 != null}"><br />${article.ABSTRACT2}</c:if> 
									</div> -->
									<ul class="detaile_box">
										<li>
											<p class="detail_list">Keywords</p>
											<p class="detail_content">${article.KEYWORD}</p>
										</li>
										<li>
											<p class="detail_list">KNIM ID</p>
											<p class="detail_content">${article.NCMIKID}</p>
										</li>
										<li>
											<p class="detail_list">DOI</p>
											<p class="detail_content">${article.DOI}</p>
										</li>
										<li>
											<p class="detail_list">Abstract</p>
											<div>${article.ABSTRACT}<c:if test="${article.ABSTRACT2 != null}"><br />${article.ABSTRACT2}</c:if> </div>
										</li>
									</ul>
								</div> --%>
								

								<div class="btn-group" style="margin-bottom:0;"> 
									<a href="javascript:history.back(-1)" title="목록" style="float: right;margin-bottom:10px;" class="basic-btn" >목록</a>
								</div>
							</div>
						</div>
					</div>		
					
					<div id="sidebar-pumed-right"> 
						<div class="sidebar-right-text">Send to</div>
							<ul class="acc-menu" id="pumed-accordionMenu1">
								<li data-extension="close">
									<!--<div class="main-title">
										 <span class="folder"> </span> 
										 <a>Send to</a>
									</div>-->
									<ul class="sub" id="fillter_article" style="padding:10px 0; border-bottom: 1px solid #e6e6e6;">
										<li class="on"><a href="javascript:fn_send('popup_file')">File</a></li>
										<li class="on"><a href="javascript:fn_send('popup_mail')">E-mail</a></li>
										<li class="on"><a href="javascript:fn_send('popup_citation')">Citation manager</a></li>
									</ul>
								</li>
								<div class="schedule" id="popup_file" style="">
									<div class="main-title">
										File
										<ul class="sub" id="fillter_article">
											<!--<li class="on"><input type="radio" name="save_file" value="" />RIS<br /></li>
											<li class="on"><input type="radio" name="save_file" value="" />Bibtex<br /></li> -->
											<li class="on"><input type="radio" name="save_file" value="csv" />CSV<br /></li>
											<li class="on"><input type="radio" name="save_file" value="xml" />XML<br /></li>
											<li class="on"><button style="margin-left: 5%;" type="button" id="excelUp" onclick="fn_createFile()">파일생성</button>
											<button style="margin-left: 5%;" type="button" id="excelUp" onclick="fn_close('popup_file');">닫기</button></li>
										</ul>
									</div>
								</div>
								<div class="schedule" id="popup_mail" style="">
									<div>
										E-mail
										<table>
											<tr>
												<td><label>Format</label><br /></td>
												<td>
													<select>
														<option>Summary</option>
														<option>Abstract</option>
														<option>MEDLINE</option>
														<option>XML</option>
													</select>
												</td>
											</tr>
											<tr>
												<td><label>E-mail</label></td>
												<td>
													<input type="text" id="email" name="email" value="" style="pardding-bottom: 1%;"/>
												</td>
											</tr>
										</table>					
										<button style="margin-left: 5%;" type="button" id="excelUp" onclick="fn_sendMail()">발송</button>
										<button style="margin-left: 5%;" type="button" id="excelUp" onclick="fn_close('popup_mail');">닫기</button>
									</div>
								</div>
								<div class="schedule" id="popup_citation" style="">
									<div>
										Citation manager
										<button style="margin-left: 5%;" type="button" id="excelUp" onclick="fn_createFile2()">파일생성</button>
										<button style="margin-left: 5%;" type="button" id="excelUp" onclick="fn_close('popup_citation');">닫기</button>
									</div>
								</div>
							</ul>
							
							
							<div class="under_bar2"></div>
						
							<div class="sidebar-right-text" style="margin-top:20px;">Full Text links</div>
						    <ul class="acc-menu" id="pumed-accordionMenu1" ">
								<li data-extension="close">
									<!-- <div class="main-title"><span class="folder"> </span> --><!-- <a>Full Text links</a> --><!--</div> -->
									<ul class="sub" id="fillter_article" style="padding:5px 0;">
										<li style="text-align:center;">
											<img src="${ctxt}/resources/images/_cmmn/ico_doi.png" border="0" alt="DOI" style="vertical-align:bottom;" onclick="doiPopupOpen('${article.DOI}')">
											<a href="javascript:doiPopupOpen('${article.DOI}')" style=""><!-- <span class="Nfont_f11_Uline"style="margin-left:3px;"> DOI</span> --></a>
										</li>
									</ul>
								</li>     
<!-- 								<li data-extension="close">
									<div class="main-title"><span class="folder"> </span><a>Archives</a> </div>
									<ul class="sub" id ="fillter_dept">	
									</ul>
								</li> -->
							
							</ul>
							
							<div class="under_bar2"></div>
							
							<div class="metrics">
								<div class="view">
									<p style="margin-bottom:0;">View</p>
									<span><c:out value='${record.VIEW_CNT}'/></span>
								</div>	
								<div class="Download">
									<p>download</p>
									<span><c:out value='${record.DOWNLOAD_CNT}'/></span>
								</div>	
							</div>
						</div> 
					</div> 
					<!-- <div id="archive-chart" class="center">
						<div class="sidebar-chart-right-text">Item View & Download Count</div>
						<div id ="gridChart" class="center" style="position: relative; user-select: none;"> style="width: 400px; height: 400px"></div>	
					</div> -->
					     
				</div>
			</div>
		</div>
		
		

	<input type="hidden" id="artctrlno" value="<c:out value='${article.ARTCTRLNO}'/>">
	<input type="hidden" id="title" name="title" value="<c:out value='${article.TITLE}'/>">
	
	<form  id="file_form" name="file_form" action="" >
		<input type="hidden" name="artctrlno" value="<c:out value='${article.ARTCTRLNO}'/>">
		<input type="hidden" id="file_type" name="file_type" value="">
	</form>


</div>

