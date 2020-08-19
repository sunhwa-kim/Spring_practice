<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="kr.go.cris.ptl.eds.bean.*" language="java"%>
<%@page import="kr.go.cris.ptl.eds.Helpers.*" language="java"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.io.*"%>
<%@page import="org.json.*"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.log4j.Logger"%> 
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<head> 
<link rel="stylesheet" href="${ctxt}/resources/css/ncmik/edsStyle/style.css" type="text/css" media="screen" />
<link rel="stylesheet" href="${ctxt}/resources/css/ncmik/edsStyle/pubtype-icons.css" type="text/css" media="screen" />
<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'>
<script src="${ctxt}/resources/js/search/common.js"></script>
<script>
	function fn_getPdf(pdf_url){
		$.ajax({
	        url: pdf_url,
	        type: 'GET',
	        dataType: 'text',
	        cache: false,
	        success: function(result) {
	        	window.open(replaceAll(result,'+','%2B'));
	        }
		});
	}  
	
	function fn_getEookPdfAndPub(pdf_url) {
		window.open(replaceAll(pdf_url, '+', '%2B'));	
}

	
	function fn_edsLink(edsLink, text){
			
			var userId = "<c:out value='${userVo.loginid}'/>";
			var innerIp = '${INNER_IP}';
			var exceptionYn = '${EXCEPTION_YN}';
			
			if(text.indexOf("Full Text") != -1 || text.indexOf("proxy_check") != -1){
			   
				if(innerIp == 'Y'){
					window.open(replaceAll(edsLink,'+','%2B'));
				}else if(exceptionYn == 'Y'){
					window.open("http://152.99.73.136/_Lib_Proxy_Url/" +replaceAll(edsLink,'+','%2B'));
				}else{
					if(userId != ''){
						window.open("http://152.99.73.136/_Lib_Proxy_Url/" +replaceAll(edsLink,'+','%2B'));
					}else{
						if (confirm('로그인 후 이용 가능한 서비스 입니다.\n로그인 하시겠습니까?')){ 
							location.href="${ctxt}/login/user/login.do?returnURL=/index/index.do";
						}
					}
				}	
			}else{
				window.open(replaceAll(edsLink,'+','%2B'));
			} 
			
	}
	
	function fn_pdf(pdf_url){
		window.open(replaceAll(pdf_url,'+','%2B'));
	}
	function replaceAll(str, searchStr, replaceStr) {
	  return str.split(searchStr).join(replaceStr);
	}
	
    $(function() {
    	
        $("#applyLimiters").click(function() {   
            var actions = "";
            $("#limiterOptions input.selected-limiter-option:not(:checked)").each(function()
                    {
                        actions += "&" + $(this).val();
                    });
            $("#limiterOptions input.unselected-limiter-option:checked").each(function()
                    {
                        actions += "&" + $(this).val();
                    });
            var currentPageState = $("#currentState").val();
            window.location = [location.protocol, "//", location.host, location.pathname, "?", currentPageState, actions].join('') ;
            return false;           
        });

        
        $("#applyExpanders").click(function() {
            var actions = "";
            $("#expanderOptions input.selected-expander-option:not(:checked)").each(function()
                    {
                        actions += "&" + $(this).val();
                    });
            $("#expanderOptions input.unselected-expander-option:checked").each(function()
                    {
                        actions += "&" + $(this).val();
                    });
            var currentPageState = $("#currentState").val();
            window.location = [location.protocol, "//", location.host, location.pathname, "?", currentPageState, actions].join('') ;
            return false;           
        });
        
        $('.actionSelect').change(function() {
            var currentPageState = $("#currentState").val();
            var viewAction = "&action=" + $(this).find(":selected").val()+"&kwd="+'${kwd}';
            window.location = [location.protocol, "//", location.host, location.pathname, "?", currentPageState, viewAction].join('') ;
            return false;   
        });
        
        var kor ="";
        var eng ="";
        var lang_cnt =0;
        $("#1").siblings().children('li').each(function(cnt){
        	if(cnt == 0){
        		$(this).addClass('firstLang');
        	}
        	var lang_val = $(this).find('input').attr('id');
        	if(lang_val == 'korean'){
        		kor = $(this).html();
        		lang_cnt ++;
        		$(this).addClass('kor');
        	}else if(lang_val == 'english' ){
        		eng =$(this).html();
        		lang_cnt ++;
        		$(this).addClass('eng');
        	}
        	
        });

        $(".eng").insertAfter('.firstLang');
        $(".kor").insertAfter('.firstLang');
        

     $("#1").siblings().children('li').slice(lang_cnt).hide();

     
     $("#searchQuery").val('${kwd}');
     
     //$('#accordionMenu1 li').first().hide();
     
     if($('#edsCnt').text() != '0' && $('#edsCnt').text() != ''){
    	 
    	 var cnt = $('#edsCnt').text();
    	 $('#edsCnt').text(addComma(cnt,22));
     }
       
});
    
function fn_rightMenu(a){   
	 if($('#'+a).siblings().find('.more_btn2').text() == '접기'){
		 $('#'+a).siblings().children('li').slice(5).hide();
		 $('#'+a).siblings().find('.more_btn2').text('더보기')
	 }else{
		 $('#'+a).siblings().children('li').slice(5).show();
		 $('#'+a).siblings().find('.more_btn2').text('접기')
	 }
}


function applyFilter(applyFacetURL,checkId){

	if($("input[value='"+checkId+"']").is(":checked")){  
		location.href = '${ctxt}/'+applyFacetURL+"&kwd="+'${kwd}';
		$('#mloader').show();  
	}else{
		$('.search_param').each(function(){
			location.href = $("input[name='"+checkId+"']").val()+"&kwd="+'${kwd}'; 
		});
		$('#mloader').show();  
	}
}

function chkDel(){
	$('#mloader').show();
}

function moveYear(){
	$('#mloader').show();  
	
	$('#f_date').val();
	$('#t_date').val();
	
	var actions = "&action=AddLimiter(DT1:"+$('#f_date').val()   +"-01 / " + $('#t_date').val()+"-12)"

	$('#pubDate').val(actions);
	
	var currentPageState = $("#currentState").val();
	
	window.location = [location.protocol, "//", location.host, location.pathname, "?", currentPageState, actions].join('') +"&detailYn=${vo.detailYn}";	
}

function applyLimiters(){
	
	$('#mloader').show();  
	
    var actions = "";
    
    $("#limiterOptions input.selected-limiter-option:not(:checked)").each(function()
            {
                actions += "&" + $(this).val();
            });
    $("#limiterOptions input.unselected-limiter-option:checked").each(function()
            {
                actions += "&" + $(this).val();
            });
    var currentPageState = $("#currentState").val();

    window.location = [location.protocol, "//", location.host, location.pathname, "?", currentPageState, actions].join('') +"&detailYn=${vo.detailYn}";	
}

$(window).load(function(){  
 	
 	$('#mloader').hide();
	
	$('.search_param').each(function(){
		var checkId = $(this).find('input').attr('id');
		var checkVal = $(this).find('input').val(); 
		$("input[value='"+checkId+"']").attr('checked',true);
	});
	
});


function fn_open(obj,target){
	$(obj).parent().parent().find('.'+target).attr('style','');
	$(obj).parent().parent().find('.'+target).first().attr('style','display:none;');
}

function fn_close(obj,target){
	$(obj).parent().parent().find('.'+target).attr('style','display:none;');
	$(obj).parent().parent().find('.'+target).first().attr('style','');
}
    
function fn_search(){
	if($('#keyword').val() == ''){alert('검색어를 입력하세요.'); return;}
	$('#mloader').show();
	
	$('#searchKeyword').val($('#keyword').val());

	if($('#resultAdd').is(':checked')){
		location.href="listEds.do?"+$('#currentState').val()+"&action=AddQuery(AND,"+$('#keyword').val()+")";
	}else{
		if($('#pageType').val() == 'a'){
			$('#action').val('addfacetfilter(SourceType:Academic Journals)');
		}else{
			$('#action').val('addfacetfilter(SourceType:eBooks)');
		}
		
		var form = document.edsForm;  
		form.submit();	
	}
	   
}      

function fn_multiSave(){
	
	var chk_mylib_cnt = 0;
	var mylibChk = "";
	
 	if ("${userVo.emplyrnm}" == "") {
		if (confirm("내서재 담기 기능을 선택하실 경우 로그인 하셔야합니다.\n로그인 화면으로 이동하시겠습니까?")) {
			location.href = "${ctxt}/login/user/login.do;";  //?searchCondition="+$('#searchCondition option:selected').val()+"&searchKeyword="+$('#searchKeyword').val();
			return;
		} else {
			return;
		}
	} 
	
	var list = [];
	var cnt=0;
	
	$("input[name=chk_mylib]:checked").each(function() {
		
		mylibChk = $(this).val();
		
		if(mylibChk != "" ){
			chk_mylib_cnt++;	
		}
		
		var edsurl = $(".chkList"+mylibChk + "> input[name=edsUrl]").val();
		var edsdbid = $(".chkList"+mylibChk + "> input[name=edsDbid]").val();
		var edsan = $(".chkList"+mylibChk + "> input[name=edsAn]").val();
		var edsti = $(".chkList"+mylibChk + "> input[name=edsTi]").val();
		var edsau = $(".chkList"+mylibChk + "> input[name=edsAu_mylib]").val();
		var edsyear = $(".chkList"+mylibChk + "> input[name=edsYear]").val();
		
		list[cnt] = {
				"edsurl" : edsurl,
				"edsdbid" : edsdbid,
				"edsan" : edsan,
				"edsti" : edsti,
				"edsau" : edsau,	
				"edsyear" : edsyear
			}
		cnt++;					
			
	});
	
	var sendList = {"list" : list};

	$.ajax({
		url : "${ctxt}/mylib/lib/edsMultiMylibSave.do",
		data : JSON.stringify(sendList),
		processData : false,
		type : 'POST',	
		traditional : true,
		cache: false,
		dataType : 'json',
		success : function(data) {
			if(confirm("선택하신 총 "+chk_mylib_cnt+"건 중\n내 서재 담기에 성공한 건수: "+data.sucCnt+"건\n이미 내 서재에 등록된 건수(내 서재 담기에 실패한 건수): "+data.dupCnt+"건 \n입니다.\n\n※ 내 서재 화면으로 이동하시겠습니까?")){
				location.href="<c:url value='/mylib/lib/listMyLib.do'/>";
				return;
			}else{
			
				 $("input[name=chk_mylib]").prop("checked", false);
				
				return;
			}
		}
	}); 

}



var isChk= false;
//전체선택 / 취소
function fn_all(){
	$("input[name=chk_mylib]").each(function() {
		if(isChk){
			$('#all_chk').text("전체선택");
			$(this).prop("checked",false);
		}else{
			$('#all_chk').text("전체취소");
			$(this).prop("checked",true);
		}
	});
	isChk=!isChk;

}

function fn_outData(){
	
	
	var myDownChk = "";
	var list = [];
	var cnt=0;
	
	$("input[name=chk_mylib]:checked").each(function() {
		
		myDownChk = $(this).val();
			
	
		var edsan = $(".chkList"+myDownChk + "> input[name=edsAn]").val();
		var edsti = $(".chkList"+myDownChk + "> input[name=edsTi]").val();
		var edsau = $(".chkList"+myDownChk + "> input[name=edsAu]").val();
		var edsjourtitle = $(".chkList"+myDownChk + "> input[name=edsJournalTitle]").val();
		var edsissn = $(".chkList"+myDownChk + "> input[name=edsIssn]").val();
		var edsyeartext = $(".chkList"+myDownChk + "> input[name=edsYearText]").val();
		var edsvolume = $(".chkList"+myDownChk + "> input[name=edsVolume]").val();
		var edsissue = $(".chkList"+myDownChk + "> input[name=edsIssue]").val();
		var edspagecnt = $(".chkList"+myDownChk + "> input[name=edsPageCnt]").val();
		var edsfirstpage = $(".chkList"+myDownChk + "> input[name=edsFirstPage]").val();		
		var edsdoi = $(".chkList"+myDownChk + "> input[name=edsDoi]").val();
		var edssubject = $(".chkList"+myDownChk + "> input[name=edsSubject]").val();
		var edsdoctype = $(".chkList"+myDownChk + "> input[name=edsDoctype]").val();
	
		list[cnt] = {				
				"edsan" : edsan,
				"edsti" : edsti,
				"edsau" : edsau,	
				"edsjourtitle" : edsjourtitle ,
				"edsissn" : edsissn ,
				"edsyeartext" : edsyeartext ,
				"edsvolume" : edsvolume ,
				"edsissue" : edsissue ,
				"edspagecnt" : edspagecnt ,
				"edsfirstpage" :  edsfirstpage ,
				"edsdoi" : edsdoi ,
				"edssubject" : edssubject ,
				"edsdoctype" : edsdoctype
			}
		cnt++;					
	});
	
	var sendList = {"list" : list};
	var sendJson = JSON.stringify(sendList);
	
	$("input[name=chkUpload]").val(sendJson);
   	
	document.getElementById("chkUploadForm").action = "<c:url value='/elib/eds/xlsEdsDownLoad.do'/>";
	document.getElementById("chkUploadForm").submit();	
}

</script>
<style>
.content_wrap{
	font-family: 'Roboto', sans-serif;
}
.sub_book_wrap{width: 80%;}   
.author, .subject, .journal, .abstract {
    width: 80%;
    font-family: 'Roboto', sans-serif;
}
.center_text_01{
	position:relative;
}
.category_select{
	display:none;
}
.sidebar-right-text2{
	font-weight:400;
}
/* .sidebar-right-text2 a{
	letter-spacing:0;
	font-size:18px;
	color: #3c4a53;
} */
i{
	font-style: normal;
	letter-spacing:0;
}
.under_bar2 {
    border-top: 0px solid rgba(51,122,183,0.05);
	margin-bottom:10px;
}
.pubtype {
	width:12%;
    padding: 0 1.5% 15px 1.5%;
    margin:0;
    display:inline-block;
    max-width:100%;
    text-align:center;
    position:relative;
    box-sizing:border-box;
}
.right{
	width:100%;
	box-sizing:border-box;
}
.author, .journal{
    width: 100%;
    max-width:100%;
    margin:0;
    color: #78848e;
    font-size:13px;
    letter-spacing: 0.1px;
    line-height: 160%;
    padding-left: 22px;
    box-sizing: border-box;
}
.pt-icon{
	float:none;
}
.links{
	display:inline-block;
	margin:2px 0 19px 0;
	padding-left: 20px;
}
.info{
	max-width:99%;
	margin:0 auto;
	padding: 5px 0;
	border-bottom:0;
}
.info > .title_box {
    width: 100%;
    display: inline-block;
    font-weight: normal;
    max-width:100%;
    line-height:160%;
}
.info > .title_box > ul > .record-id {
    width: 3.5%;
    float: left;
    line-height: 120%;
}
.pubtype > a > img {
    width: 60px;
    margin:12px 0;
}
#eds-group {
    position: relative;
    text-align: center;
}
.search-input {
    position: relative;
    display: inline-block;
}
.media_span {
    position: absolute;
    right: 0;
    text-align: right;
    top: -100%;
    font-size: 11px;
    letter-spacing: -0.3px;
}
#keyword{
	width: 325px;
    height: 38px;
    padding-left: 10px;
    border: 1px solid #ccc;
    box-sizing: border-box;
    vertical-align: top;
    font-size: 12px;
}
.search-input>span>font>label {
    line-height: 55px;
}
.under_bar.media_bar {
    margin: 30px 0 5px 0;
}
.button_box {
    float: left;
}
.button_box a{
	vertical-align:bottom;
}
.sub_book_wrap>div>.selectbox_wrap {
    padding: 0;
    margin: 0;
    float: right;
    clear: none;
}
.sidebar-right-text2 li a{
	font-family: "Noto Sans Korean", sans-serif;
}
#sortoption.actionSelect{
	margin-left: 0;
}

.li_left_data{
	box-sizing:border-box;
}
 #mloader{
  position: fixed;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 99999;
  background-color: #000;
  opacity: 0.7;
  display:none;
}
.highlight2{
	width:40px;
	font-weight: bold;
}
.info .title_box ul .record-id{
	width:100%;
}
#mloader .masterkey_blink {   
	font-size:20px;  
	font-weight:bold;
	margin: 10% 45%;
    -webkit-animation: masterkey_blink 3s linear infinite;
    animation: masterkey_blink 3s linear infinite;
} 
.info > .title_box > ul > li:last-child {
    width: 100%;
    max-width: 100%;
    line-height:140%;
}

.center_text_02 {
    margin-left: 20px;
     height: 38px;
    line-height: 38px;
    padding: 0;
}
.info .pubtype .links a, .info .links a img{line-height:28px;}

.highlight{
	font-weight:normal;
}
#sortoption.actionSelect {
    margin-left: 0;
}
.acc-menu li ul.sub li.date input {
    width: 55px;
    text-align: center;
    height: 14px;
    border: 1px solid #ccc;
}
@media (max-width: 1100px){
	#edsForm {
	    text-align: center;
	}
	.media_span {
	    display: block;
	    text-align: right;
	}
}
@media (max-width: 990px){
	.category_select {
	    display: block;
	    position: absolute;
	    top: 0;
	    left:110%;
	    cursor: pointer;
	    font-size: 10px;
	}
	.li_left_no{
		float:left !important;
		/* width:9.5% !important; */
	    text-align: left !important;
	    margin-right: 0px !important;
	}
	.li_left_data{
		float:left !important;
		width:100% !important;
	}
	.right{
	/* 	margin-left: 9.5% !important; */
	}
}
@media (max-width: 820px){
	#content{
		width:100%;
	}
	.content_box>.content_list{
		width:100%;
		box-sizing:border-box;
	}
	.sub_book_wrap {
	    width: 100%;
	    
	}
	.sub_center_text{
		width:96%;
	}
	.li_left_no{
		float:left !important;
		/* width:9.5% !important; */
	    text-align: left !important;
	    margin-right: 0px !important;
	}
	.li_left_data{
		float:left !important;
		width:100% !important;
	}
	.right{
	/* 	margin-left: 9.5% !important; */
	}
}
@media (max-width: 690px){
	.content_list{
		margin-top:20px;
	}
	.li_left_no{
		float:left !important;
		/* width:9.5% !important; */
	    text-align: left !important;
	    margin-right: 0px !important;
	}
	.li_left_data{
		float:left !important;
		width:100% !important;
	}
	.right{
	/* 	margin-left: 9.5% !important; */
	}
}
@media all and (max-width:650px) {
	.button_box, .selectbox_wrap {
	    width: 100%;
	    float: none;
	    text-align: center;
	}
}
@media (max-width: 640px){
	.content_box>.content_list {
	    padding: 40px 20px;
	}
}
@media all and (max-width:600px) {
	.selectbox_wrap {
	    position: relative;
	}
	#sortoption{
		margin-left:0;
	}
	#keyword{
		height:30px;
	}
	.sub_book_wrap>div>.info{
		/* padding-bottom:70px; */
	}
	.info > .title_box > ul > li:last-child>a{
		width:100%;
	}
	.info > .title_box {
		width:100%;
	}
	.author, .subject,.journal, .abstract {
	    width: 100%;
	    margin-left:0;
    }
	.pubtype{
		width:100%;
		max-width:500px;
		display:inline-block;
		bottom:0;
		left:0;  
		margin-left:0;
		vertical-align:bottom;
	}
	.pt-icon{
		float:left;
	}
	.academic_journal{
		width:110px;
		float:left;
		padding-top:35px;
	}
	.info > .pubtype > .links{
		float:left;
		margin-top:27px;
		margin-left:7px;
	}
	.li_left_no{
		float:left !important;
		/* width:9.5% !important; */
	    text-align: left !important;
	    margin-right: 0px !important;
	}
	.li_left_data{
		float:left !important;
		width:100% !important;
	}
	.search-input>span>font {
	    height: 30px;
	}
	.search-input>span>font>label {
	    line-height: 40px;
	}
}
@-webkit-keyframes masterkey_blink {
	15% { color: white; }
    40% { color: black; }
    75% { color: white; }
}
@-moz-keyframes masterkey_blink {
	15% { color: white; }
    40% { color: black; }
    75% { color: white; }
}
@-ms-keyframes masterkey_blink {
	15% { color: white; }
    40% { color: black; }
    75% { color: white; }
} 
@-o-keyframes masterkey_blink {
	15% { color: white; }
    40% { color: black; }
    75% { color: white; }
} 
@keyframes masterkey_blink {
	15% { color: white; }
    40% { color: black; }
    75% { color: white; }
}
@media all and (max-width:530px) {
	#keyword {
    	width: 300px; 
    }
}
@media all and (max-width:502px) {
	.category_select{
		display: block;
	    position: absolute;
	    z-index: 100;
	    left: 75%;
	    cursor: pointer;
	}
	.content_box>.content_list {
	    margin-top: 10px;
	}
}
@media all and (max-width:450px) {
	.content_box>.content_list {
	    padding: 60px 20px;
	}
}


</style>
</head>

<div class="sub_center_text">
      <div class="sub_center_nav"> 
	      <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
	      <span> > </span> 
	      <span>통합검색</span>
	      <span> > </span>
	      <span class="active">전자자원</span>        
      </div>     
      <span class="center_text_01">전자자원 <font style="font-size: 19px;">(<span id="edsCnt">${edsCnt}</span>) 건</font><span class="category_select">▼</span></span>
     
      
</div>
<div class="under_bar"></div>
  
<div id="mloader"><div class="masterkey_blink">LOADING...</div></div>

	<div class="content_wrap" style="min-height: 700px;">
	<%   SearchResponse resultList = (SearchResponse) request.getSession().getAttribute("resultsList"); 
	     AuthToken authToken= (AuthToken)application.getAttribute("authToken");
	     SessionToken sessionToken=(SessionToken)request.getSession().getAttribute("sessionToken");
	     Info info = (Info)application.getAttribute("info");
	     ArrayList<AvailableLimiter> availableLimiterList = new ArrayList<AvailableLimiter>();
	     ArrayList<AvailableExpander> availableExpanderList = new ArrayList<AvailableExpander>();
	     ArrayList<AvailableSort> availableSortList = new ArrayList<AvailableSort>();		
	     String dateF="";
	     String dateT="";
	     
	     String accessGbn = "ok";
	 %>

		
		<div class="content_box">
			<div class="content_list">
				<div class="sub_book_wrap"> 
					<input type="hidden" name="currentState" id="currentState" value="<%=resultList.getQueryString() %>" />
					<form id="edsForm" name="edsForm" action="${ctxt}/elib/eds/listEds.do">
						<input type="hidden" id="detailYn" name="detailYn" value="Y" />	
						<input type="hidden" id="action" name="action" value="" />	
						<div id="eds-group">
						<div class="search-input">
							<label for="searchBox"></label> 
							<input type="text"
								id="keyword" name="keyword"
								value=""
								onkeypress="javascript:if(event.keyCode == 13) { fn_search(); return false;}" /> 
							<button type='button' id="btnSearch" onclick="fn_search();" ><i class="fas fa-search"></i></button>	
							<span class="media_span">
								<input type="checkbox" value="action" id="resultAdd" style="vertical-align: bottom; margin-right: 0;">
								<font style="font-size: 11px; width: 62px; vertical-align: bottom;">
									<label>결과내 검색</label>
								</font>
							</span>
						</div>
					</div>
					  
					<%
  						 QueryWithAction query = (null != resultList.getQueryList() && 0 < resultList.getQueryList().size()) ? resultList.getQueryList().get(0) : null;
   					     String value= (null == query) ? "" : query.getTerm();
 						 value=URLDecoder.decode(value).replace("\"", "&quot;");
 						 String displayValue = value;
   					     String defaultSelected = "";
 						 String fieldCode = (null == query || null == query.getFieldCode()) ? "" : query.getFieldCode();
 						 if(null == resultList || fieldCode.isEmpty()){
    					 	defaultSelected  = "selected=selected";
 						 }
					%>

						<div id="search-group" style="margin-top:0; display: none; ">
							<div class="search-input" style="padding-bottom:3px;">
							<select name="fieldcode" id="searchCondition">
								<option id="type-" value="" <%=defaultSelected %>>Keyword</option>
						  <% 
							ArrayList<AvailableSearchField> availableSearchFieldList=info.getAvailableSearchFieldsList();
							for(int i=0; i<availableSearchFieldList.size(); i++) {         
	    					AvailableSearchField availableSearchField=availableSearchFieldList.get(i);
	    					if(availableSearchField.getFieldCode().equals("TI") || availableSearchField.getFieldCode().equals("AU") ) {
	        				
	    							String label = availableSearchField.getLabel();
	        						String code = availableSearchField.getFieldCode();
	        						String selected = (0 == fieldCode.compareTo(code))? " selected='selected'" : "";    %>
									<option id="type-<%=code %>" value="<%=code %>" <%=selected %>>
										<%out.println(label); %>
									</option>
							<% }
							} %>
							</select> 
							
								<input type="text" name="query" id="searchKeyword" value="<%=value%>" />
								<input type="submit" value="Search" id="btnSearch">
							</div>
						</div>

					</form>
					<% 
						if(resultList.getApierrormessage()!=null) {
						    ApiErrorMessage aem=resultList.getApierrormessage();
						    String errorString=aem.getErrorDescription();
						    out.println("<div class='under_bar2'></div>");
						    out.println("<div class='not_found'>"+errorString+"</div>");
						}
						else {
					%>
								
						
				<div class="under_bar media_bar" ></div>
				<div class="clear">
					<div class="button_box">
						<a href="javascript:fn_all()" id="all_chk"><i class="far fa-check-square"></i>전체선택</a>
						<a href="#" onclick="javasctipt:fn_multiSave();"><i class="fas fa-book"></i>내서재담기 </a>
						<a href="#" onclick="javasctipt:fn_outData();"><i class="far fa-share-square"></i>내보내기</a>										
					</div>
					<div class="selectbox_wrap">
											<!-----------------------------------  SORTS --------------------------------------->
												<select class='actionSelect' id="sortoption" name="sortoption">
												
											<%
										    	if(null != info && null != info.getAvailableSortsList()){
										        	availableSortList = info.getAvailableSortsList();
										    	}
												for(AvailableSort availableSort : availableSortList) {
										        	String selected = "";
										        
										        	if(resultList.getSelectedSort().compareToIgnoreCase(availableSort.getId())==0){
										            	selected = "selected=selected";
													}
											%>
														<option <%=selected%>
															value="<%=availableSort.getAddAction()%>">
															<%
	                											out.println(availableSort.getLabel());
	      													%>
														</option>   
														<%
	               									}
	         											%>
												</select>
											<!-- ----------------------------------------- END SORTS --------------------------------------->


											<!------------------------------------ RESULTS PER PAGE --------------------------------------->
												<select class='actionSelect' id="perpageoption" name="perpage">
											  <%
	        									String resultsPerPage = resultList.getSelectedResultsPerPage();
											  	
	        									//display 6 options
											        for(int i=1;i<6;i++){
											            String current =i*5+"";
											            String selected  = "";
											            if(current.compareToIgnoreCase(resultsPerPage) == 0 ){
															selected = "selected=selected";
											            }
											   %>
														<option <%=selected%>
															value="<%="setresultsperpage("+current+")"%>">
															<%
	               												out.println(current);
	          												 %>
														</option>
														<%
													 }	
	     											%>
												</select>
<!-- 											</li> -->
											<!--------------------------------------- END RESULTS PER PAGE ------------------------------------->
						
						
					<!----------------------------------   VIEW OPTIONS  ------------------------------------------->
					<select class='actionSelect' id="pageoption" name="pageoption">
							<%
								 String pageOptionselect1 ="";
								 String pageOptionselect2 ="";
								 String pageOptionselect3 ="";
								 String view= resultList.getSelectedView();
								 //use default if view is empty
								 if(null == view || view.isEmpty()){
								     view = (null != info.getViewResultSettings()) ? info.getViewResultSettings().getResultListView() : "detailed";
								 }
								 if(view.compareToIgnoreCase("detailed")==0){
								    pageOptionselect1 ="selected=selected";
								 }else if(view.compareToIgnoreCase("brief")==0){
								    pageOptionselect2 ="selected=selected";
								 }else if(view.compareToIgnoreCase("title")==0){
								    pageOptionselect3 ="selected=selected";
								 }
							%>

							<option <%=pageOptionselect1%> value="setview(detailed)">
							<%
   								out.println("Detailed");
							%>
							</option>
							
							<option <%=pageOptionselect2%> value="setview(brief)">
							<%
    							out.println("Brief");
							%>
							</option>
							
							<option <%=pageOptionselect3%> value="setview(title)">
							<%
    							out.println("Title");
							%>
							</option>
						</select>
						<!------------------------------------------ END VIEW OPTIONS --------------------------------->
						
				</div><!-- END topbar-resultList -->
				</div>

				<!------------------------------------------ RESULTS --------------------------------->
				<div class="sub_book_wrap"><!-- 목록 리스트 -->
			<%
    			if(Integer.parseInt(resultList.getHits())<=0){
    				Logger.getLogger(SearchResponse.class).debug("IGNORED: resultList.getHits()");
			%>
				<div class="result-table-row">
					<div class="table-cell">
						<h2>
							<i>No results were found.</i>
						</h2>
					</div>
				</div>
			<%
        		} else {
   			%>
			<%
                for(Result result : resultList.getResultsList()){
            %>
				<!-- start tag of result content -->
				<div class="result">
					
				<%-- 	
					<!-- PubType and image -->
					<%
                    	if(result.getPubType()!= null){
                	%>
					
				<%
                    }
                %>
 			--%>
										
				<!-- Record data -->
				<!-- Get author,abstract,subject information -->
				<%
        			String title = "";
                    String author = "";
                    String abstracts = "";
                    String source ="";
                    String subject = "";
                    String rSubject = "";
                    String description="";
                    String categories="";
                    String publicationInformation="";
                    String url="";
                    String urlName="";  
                    List<HashMap<String,String>> listMap = null;
                    String authorList = "";
                    String typPub ="";  
                    
                    for(int c=0; c< result.getItemList().size();c++){
  	
                        Item item = result.getItemList().get(c);

                        if(item.getGroup().equals("Ti"))  {                      
                            title=item.getData();      
                        } 
                        if(item.getGroup().equals("Au")){
                            author =item.getData();
                            author=author.replace("<br />", ";  ");
                        }
                        if(item.getGroup().equals("Ab")){
                            abstracts= item.getData();
                        }       
                        if(item.getGroup().equals("Su")){
                            subject=item.getData();
                            rSubject += subject.replace("<br />", ";  ");
                        } 
                        if(item.getGroup().equals("TypPub")){
                        	typPub = item.getData();
                        }  
                        if(item.getGroup().equals("Src")){
                        	
                        	if(StringUtils.equals("Academic Journal", result.getPubType())){
                        		//System.out.println(source);
                        		/* source = source.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
                        		System.out.println(source); */
                        		if(StringUtils.isBlank(source)){
                        			source+=item.getData();
                                	source=source.replaceAll(";", " | <br />");
                            	}
                        	}else if(StringUtils.equals("eBook", result.getPubType())){
                        		source=item.getData();
                            	source=source.replaceAll(";", " <br />");
                        	}else{
                        		source=item.getData();
                            	source=source.replaceAll(";", " <br />");
                        	}
                        	  
                        } 
                        
                        if(item.getGroup().equals("URL")){  
                        	listMap = new ArrayList<HashMap<String,String>>();
                        	HashMap<String,String> map = null;
                        	url=item.getData();
                        	urlName=item.getLabel();      
                        	int pos = url.indexOf("linkTerm");

                        	while(pos != -1){
                        		map = new HashMap<String,String>();
                        		
                        		url.substring(pos +10, url.indexOf("\"", pos +11));
                        		map.put("linkTerm",url.substring(pos +10, url.indexOf("\"", pos +11)));
                        		map.put("linkLabel", urlName);
                        		listMap.add(map);                 		
                        	    pos =  url.indexOf("linkTerm", pos + 1); 
                        	}                            
                        } 

                    }
                    
                    String pubTypeList ="";
                    if(result.getPubType() != "null" && result.getPubType()!= null && result.getPubType()!= ""){
			    		if(result.getPubType().indexOf("Journal")  > 0){
			    			//pubTypeList = "Article"; 
			    			pubTypeList = result.getPubType();
			    		}else{
			    			pubTypeList = result.getPubType();
			    		}
			    		
			    	}
                %>
				
				<div class="info">
					<!-- ResultID -->	
					<div class="title_box">		
						<ul class="title sidebar-right-text2" style="margin:0;">
								<li style="float:left; text-align: right; margin-right: 7px;" class="li_left_no" >
								<input type="checkbox" name = "chk_mylib" value="<%=result.getResultId()%>" /> 							
								<%out.println(result.getResultId()+". "); %> <%=pubTypeList%>
							</li>
							<li style="float:left;width: 100%;" class="li_left_data">
							<a href="${ctxt}/search/Retrieve?dbid=<%=result.getDbId()%>&an=<%=result.getAn()%>&highlight=<%=URLEncoder.encode(query.getTerm() , "UTF-8")%>&edsCnt=${edsCnt}&kwd=${kwd}"><%=title%></a></li>
						</ul>
					</div>
						
					<div  class="right" >
					<!-- Author -->
					<%
                    if(!author.equals("")) {	
                    	int searchKey = author.indexOf("<searchLink fieldCode=\"AU\"");
                    	int searchKey2 = author.indexOf("<searchLink fieldCode=\"AR\"");
                    	String idxKey = "<searchLink fieldCode=\"AU\"";
                    	String idxKey2 = "</searchLink>";
                    	if( searchKey != -1){
                    		idxKey = "<searchLink fieldCode=\"AU\"";
                    		idxKey2 = "</searchLink>";
                    	}else if( searchKey2 != -1){
                    		idxKey = "<searchLink fieldCode=\"AR\"";
                    		idxKey2 = "</searchLink>";
                    	}
                    	
                        int idx = author.indexOf(idxKey);
                        int start = 0;
                        int end = 0;
                        int authorleng =0;
                        authorList = "";
                        while(idx != -1){
                     	   
                     	   start = author.indexOf(">",idx);
                     	   end = author.indexOf(idxKey2,idx);
                     	   idx = author.indexOf(idxKey,idx+1);
                     	   if(3 > authorleng){
                     		   if(authorleng > 0){
                     			   authorList += ", ";
                     		   }  
                     		   authorList += author.subSequence(start +1, end);
                     		   
                     	   }   
                     	   authorleng++;
                        }
                        
                        if(StringUtils.isBlank(authorList) ){
                        	String[] auth = author.split(";");
                        	for(int i=0; i < auth.length; i ++){
                        		if(i < 3){
                        			if(i > 0){
                        				authorList += "; ";
                        			}
                        			authorList += auth[i].replace(", Author", "") ;
                        		}
                        	}
                        	authorleng = auth.length;
                        }      
                        
                        if(authorleng-3 > 0 && authorList != ""){
                     	   authorList += "("+  String.valueOf(authorleng-3 ) + ")";
                        }

		                    %>
							<div class="author">
								<!-- <span class="highlight2" style="display:inline-block;height:19px;line-height:19px;color: #78848e;">By&nbsp;&nbsp;:</span> -->
								<span><%=authorList%></span>
							</div> 
							<%    
                    }
					if(!"".equals(source)){  
                    %> 
	 					<div class="journal"> 	
							<span><%=source%></span>
						</div> 
					<%}%>
					
					<div class = "chkList<%=result.getResultId()%>">
						 <%--   <input type="hidden" name = "edsUrl" value="${ctxt}/search/Retrieve?dbid=<%=result.getDbId()%>&an=<%=result.getAn()%>" > --%> 
					
					
					<!-- **** 내서재 담기 값 셋팅 및 내려 받기 값 셋팅  *****  str   -->					  
					   <input type="hidden" name = "edsUrl" value = "${ctxt}/search/Retrieve" >	 		<!-- 내서재 -->					
					
					  <%
					   if(result.getRecordInfo() != null){
						   if(result.getRecordInfo().size() > 0){
							  	for(RecordInfo recordInfo : result.getRecordInfo()){								  		
							
							     	String year = "";
							     	String tit =  "";
							     	String yearText = "";
							     						   
							    	String au = ""; // 저자 
							    	String au_mylib = ""; // 내서재 담기 저자 
							    	String journalTitle = ""; // 저널 제목 
							    	String issn = ""; //
							    	String numType = "";
							    	String numVal = ""; 
							    	
							    	String val1= "";
							    	String val2= "";
							    	
							    	String pageCount = "";
							    	String firstPage = "";
							    	
							    	String iden_type = "";
							    	String iden_val = "";
							    	
							    	String docType = "";
							    	String subjectXls =  "";
							    	
							    	String pubTypeXls = "";
							    	
							    	// year
							    	if(recordInfo.getDate_year() != "null" && recordInfo.getDate_year()!= null && recordInfo.getDate_year() != ""){
							    		year = recordInfo.getDate_year();
							    	}
							    	
							    	//title
							    	if(recordInfo.getTitle_full() != "null" && recordInfo.getTitle_full()!= null && recordInfo.getTitle_full() != ""){
							    		tit = recordInfo.getTitle_full();
							    	}
							    	// Oct2018
							    
							    	if(recordInfo.getDate_text() != "null" && recordInfo.getDate_text()!= null && recordInfo.getDate_text() != ""){							    	
							    		yearText = recordInfo.getDate_text();
							    	
							   		}else{							   			
							   			yearText = recordInfo.getDate_year();
							   			
							   		}
							    	
							    	// author
							    	if(recordInfo.getRecordHasConRel() != null){
								    	if(recordInfo.getRecordHasConRel().size() > 0 ){
									    	for(RecordHasConRel recordHasConRel : recordInfo.getRecordHasConRel()){		
									     		 au += recordHasConRel.getNameFull()+"; ";
									     		 //break;
									     	}
									    	au = au.substring(0, au.length()-2);
								    	}
							    	}
							    	// 내서재 담기author
							    	if(recordInfo.getRecordHasConRel() != null){
								    	if(recordInfo.getRecordHasConRel().size() > 0 ){
									    	for(RecordHasConRel recordHasConRel : recordInfo.getRecordHasConRel()){		
									     		 au_mylib = recordHasConRel.getNameFull();
									     		 break;
									     	}
									    	
								    	}
							    	}
							    	// journalTitle
							    	if(recordInfo.getRecordIsPartTitle() !=  null){
								    	if(recordInfo.getRecordIsPartTitle().size() > 0){
								    		for(RecordIsPartTitle recordIsPartTitle : recordInfo.getRecordIsPartTitle()){		
									    		 journalTitle = recordIsPartTitle.getTitleFull();
									     		 break;
									     	}
								    	}
							    	}
							    	// issn
							    	if(recordInfo.getRecordIsPartIdentifiers() != null){
							    		if(recordInfo.getRecordIsPartIdentifiers().size() > 0){
									    	for(RecordIsPartIdentifiers recordIsPartIdentifiers : recordInfo.getRecordIsPartIdentifiers()){		
									    		 issn = recordIsPartIdentifiers.getValue();
									     		 break;
									     	}
							    		}
							    	}
							    	// volume ,  Issue
							    	if(recordInfo.getRecordIsPartNumber() != null){
							    		if(recordInfo.getRecordIsPartNumber().size() > 0 ){
									    	for(RecordIsPartNumber recordIsPartNumber : recordInfo.getRecordIsPartNumber()){		
									    		numType = recordIsPartNumber.getType();
									    		numVal  = recordIsPartNumber.getValue();
									    		
									    		if(StringUtils.equals(numType, "volume")){
									    			val1 = numVal;
									    		}else{
									    			val2 = numVal;
									    		}					    		
									     	}
							    		}
							    	}
							    	// page count
							    	if(recordInfo.getPage_cnt() != "null" && recordInfo.getPage_cnt()!= null && recordInfo.getPage_cnt() != ""){
							    		pageCount= recordInfo.getPage_cnt();
							    	}
							    	 
							    	// first page			  
							    	if(recordInfo.getPage_str() != "null" && recordInfo.getPage_str()!= null && recordInfo.getPage_str() != ""){
							    		firstPage= recordInfo.getPage_str();
							    	}
							    	
							    	//DOI 
							    	if(recordInfo.getIdentifier_type() != "null" && recordInfo.getIdentifier_type()!= null && recordInfo.getIdentifier_type() != ""){
								    	iden_type = recordInfo.getIdentifier_type();  // type ... doi 
								    	iden_val = recordInfo.getIdentifier_value();
							    	}
							    	
							    	//subject							    
							    	subjectXls = rSubject.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
							  
							    								    								    
							    	if(result.getPubType() != "null" && result.getPubType()!= null && result.getPubType()!= ""){
							    		if(result.getPubType().indexOf("Journal")  > 0){
							    			//pubTypeXls = "Article"; 
							    			pubTypeXls = result.getPubType();
							    		}else{
							    			pubTypeXls = result.getPubType();
							    		}
							    		
							    	}
								  %>
								  						
	  							
								    <input type="hidden" name = "edsDbid" value = "<%=result.getDbId()%>" >  <!-- 내서재 -->
								    <input type="hidden" name = "edsAn" value = "<%=result.getAn()%>" >		<!--  내서재 , 내려받기  -->				   
						  			<input type="hidden" name = "edsYear" value="<%=year%>" >		<!-- 내서재 -->
						  			<input type="hidden" name = "edsTi" value="<%=tit%>" >	  <!-- 내서재 -->
						  			<input type="hidden" name = "edsAu" value="<%=au%>" >				  <!--내려받기 -->		
						  			<input type="hidden" name = "edsAu_mylib" value="<%=au_mylib%>" >				  <!--내서재 -->		
						  				
						  			<input type="hidden" name = "edsJournalTitle" value="<%=journalTitle%>" >  <!-- 내려받기 -->	
					  				<input type="hidden" name = "edsIssn" value="<%=issn%>" > <!-- 내려받기 -->
				  					<input type="hidden" name = "edsYearText" value="<%=yearText%>" >	<!-- 내려받기 -->
				  							  					
			  						<input type="hidden" name = "edsVolume" value="<%=val1%>" >	<!-- 내려받기 -->
		  							<input type="hidden" name = "edsIssue"  value="<%=val2%>" >	<!-- 내려받기 -->
		  							
									<input type="hidden" name = "edsPageCnt"  value="<%=pageCount%>" >	<!-- 내려받기 -->
									<input type="hidden" name = "edsFirstPage"  value="<%=firstPage%>" >			<!-- 내려받기 -->				
									<input type="hidden" name = "edsDoi"  value="<%=iden_val%>" >	<!-- 내려받기 -->
									<input type="hidden" name = "edsSubject"  value="<%=subjectXls%>" >	<!-- 내려받기 -->
									
									<input type="hidden" name = "edsDoctype"  value="<%=pubTypeXls %>" >	<!-- 내려받기 -->

							   	 <%  
						  		}
						   }
					   }
					  %> 
					  	<!-- **** 내서재 담기 값 셋팅 및 내려 받기 값 셋팅  *****  end   -->		
					</div>
					
					<div class="links">  
					  
					 <%
                        if(null != result.getHtmlAvailable() && result.getHtmlAvailable().equalsIgnoreCase("1")) {
                     %>
						<%-- <a class="html fulltext" href="Retrieve?an= <%=result.getAn()%>&dbid=<%=result.getDbId()%>&highlight=<%=URLEncoder.encode(query.getTerm())%>&edsCnt=${edsCnt}&kwd=${kwd}#html">HTML<!--  Full Text --></a> --%>
						<a class="html fulltext" href="${ctxt}/elib/eds/Retrieve?an= <%=result.getAn()%>&dbid=<%=result.getDbId()%>&highlight=<%=URLEncoder.encode(query.getTerm(), "UTF-8")%>&edsCnt=${edsCnt}&kwd=${kwd}#html"><span class="btn_name">HTML</span><!--  Full Text --></a>
					 <%
                        }
                     %>
					 
					 <%
                        if(null != result.getPdfAvailable()&& result.getPdfAvailable().equalsIgnoreCase("1")) {
                      %>
						<%-- <a class="pdf" href="Retrieve?an= <%=result.getAn()%>&dbid=<%=result.getDbId()%>&highlight=<%=URLEncoder.encode(query.getTerm())%>&type=pdf">PDF<!--  Full Text --></a> --%>
						<%-- <a class="pdf fulltext" style="height: 20px;" href="${ctxt}/elib/eds/Retrieve?an= <%=result.getAn()%>&dbid=<%=result.getDbId()%>&highlight=<%=URLEncoder.encode(query.getTerm(), "UTF-8")%>&type=pdf"><img width="70%" src="${ctxt}/resources/images/_cmmn/ico_pdf.png"><!--  Full Text --></a> --%>
						<a class="pdf fulltext" href="javascript:fn_getPdf('${ctxt}/search/getPdf?an= <%=result.getAn()%>&dbid=<%=result.getDbId()%>&highlight=<%=URLEncoder.encode(query.getTerm(), "UTF-8")%>&type=pdf');"><img src="${ctxt}/resources/images/sub/pdf.png"><span class="btn_name">PDF</span> <!--  Full Text --></a>
                      <%
                         }
					 %>
					 
					 <%
						if (null != result.getEbookPdfAvailable() && result.getEbookPdfAvailable().equalsIgnoreCase("1")) {
					%>
					<%-- <a class="fulltext" href="Retrieve?an= <%=result.getAn()%>&dbid=<%=result.getDbId()%>&highlight=<%=URLEncoder.encode(query.getTerm())%>&type=pdf">PDF<!--  Full Text --></a> --%>
					<%-- <a class="pdf fulltext" style="height: 20px;" href="${ctxt}/search/Retrieve?an= <%=result.getAn()%>&dbid=<%=result.getDbId()%>&highlight=<%=URLEncoder.encode(query.getTerm(), "UTF-8")%>&type=pdf"><img width="70%" src="${ctxt}/resources/images/_cmmn/ico_pdf.png"><!--  Full Text --></a> --%>
						<a class="fulltext" href="javascript:fn_getEookPdfAndPub('http://search.ebscohost.com/login.aspx?direct=true&amp;site=eds-live&amp;db=<%=result.getDbId()%>&amp;AN=<%=result.getAn()%>&amp;ebv=EB&amp;ppid=');">
							<img src="${ctxt}/resources/images/sub/pdf.png"><span class="btn_name">PDF</span> <!--  Full Text -->
						</a>
					<%
						}
					%>
					
					<%
						if (null != result.getEbookPubAvailable() && result.getEbookPubAvailable().equalsIgnoreCase("1")) {
					%>
					
					<%-- <a class="fulltext" href="Retrieve?an= <%=result.getAn()%>&dbid=<%=result.getDbId()%>&highlight=<%=URLEncoder.encode(query.getTerm())%>&type=pdf">PDF<!--  Full Text --></a> --%>
					<%-- <a class="pdf fulltext" style="height: 20px;" href="${ctxt}/search/Retrieve?an= <%=result.getAn()%>&dbid=<%=result.getDbId()%>&highlight=<%=URLEncoder.encode(query.getTerm(), "UTF-8")%>&type=pdf"><img width="70%" src="${ctxt}/resources/images/_cmmn/ico_pdf.png"><!--  Full Text --></a> --%>
						<a class="fulltext" href="javascript:fn_getEookPdfAndPub('http://search.ebscohost.com/login.aspx?direct=true&amp;site=eds-live&amp;db=<%=result.getDbId()%>&amp;AN=<%=result.getAn()%>&amp;ebv=EK&amp;ppid=');">
							<img src="${ctxt}/resources/images/sub/epub.PNG"><span class="btn_name">EPUB</span> <!--  Full Text -->
						</a>
					<%
						}
					%>
					<!-- FullText str 추가 이고장님 -->
					   <%

						if(result.getFullTextList() != null){
							  if(result.getFullTextList().size()>0){
							  	for(FullTextRas fullTextRas : result.getFullTextList()){								  		
							  %>
							 	 	<%-- <%=fullTextRas.getAvailability()%>  --%>
							     <%
							     if(fullTextRas.getFullTextRas() != null){						     		
						     		if(fullTextRas.getFullTextRas().size() >0){
								  		for(FullTextCustomLink fullTextCustomLink : fullTextRas.getFullTextRas()){		
								  			if(fullTextCustomLink.getText().indexOf("Access") >  0 ){
								  				accessGbn = "no";
								  			}
								  			String reUrl = fullTextCustomLink.getUrl().replaceAll("%27","");
									  %>	
									  
									   <a  class="fulltext" href="javascript:fn_edsLink('<%=reUrl%> ','proxy_check')"><img src="<%=fullTextCustomLink.getIcon()%>"><span class="btn_name"><%=fullTextCustomLink.getText()%></span><!--  Full Text --></a>					   
									    			   	 
										<%--    	
											<%=fullTextCustomLink.getName()%>    
										   	<%=fullTextCustomLink.getCategory()%> 
										   	<%=fullTextCustomLink.getText()%>							   	 
										   	<%=fullTextCustomLink.getMouseOverText()%>  
									   	--%>
								   	 <%  
							  		}
							  	}
							  }					  	
						  	}
						  }
					  }
					  %>				  
					  <!-- FullText end 추가 이고장님 -->
					
					 <%
					    if(listMap != null){
	 				  		for(HashMap map : listMap){
	 				  		   if(accessGbn == "no"){ // 앞에 OpenAccess 가 있으면  없애자
	                       		   accessGbn = "ok";
	                       	   }else{
		 				  		%>
	                            <a class="fulltext" href="javascript:fn_pdf('<%=map.get("linkTerm")%>')"><span class="btn_name"><%=map.get("linkLabel")%></span><!--  Full Text --></a>
                  	          <%
                  	           }
 				  			}
	 				    }  
                       %>
					  
					  <%
                         if(!result.getOtherFullTextLinks().isEmpty()) {
                            for(Link link : result.getOtherFullTextLinks()){
                       %>
							<a class="fulltext" href="${ctxt}/elib/eds/Retrieve?an=<%=result.getAn()%>&dbid=<%=result.getDbId()%>&highlight=<%=URLEncoder.encode(query.getTerm() , "UTF-8")%>&type=<%=link.getType() %>"><span class="btn_name"><%=link.getType()%><span><!--  Full Text --></a> 
					   <%  
                           }
                          }   
                        %>
					  <%
                         if(!result.getCustomLinkList().isEmpty()) {
                             for(CustomLink clink : result.getCustomLinkList()){
                             	if(StringUtils.equals("등재",clink.getText())){
 		                       %>
 		                       <a  class="fulltext" href="javascript:fn_edsLink('<%=clink.getUrl()%>','proxy_check')"><img src="<%=clink.getIcon()%>" style="height:13px; margin-top:4px;"><%-- <span class="btn_name"><%=clink.getText()%></span> --%><!--  Full Text --></a>
 								   <%  
 	                           }else{
 	                        	   %>
 	                               <a  class="fulltext" href="javascript:fn_edsLink('<%=clink.getUrl()%>','proxy_check')"><img src="<%=clink.getIcon()%>"><span class="btn_name"><%=clink.getText()%></span><!--  Full Text --></a>
 	        					   <%     
 	                           }
                            }
                          }
	 				 %> 

						</div>  
					</div>
					<!-- Subject -->
					<%
                        if(!subject.equals("")) {
                           SearchLinkBuilder bsl=new SearchLinkBuilder();
                           String subjectvalue=bsl.buildLink(subject);
                           int subjectlen= subjectvalue.length()   ;// 
                           if(subjectlen > 300){
                        	   String str = "";
                        	   int cnt = 270;
                        	   while(subjectvalue.indexOf(";",cnt) == -1){
                        		   cnt = cnt -10;
                        		   if(cnt == 30){
                        			   break;
                        		   }
                        	   }
                        	  
                        	 
                        	   //str = subjectvalue.substring(0,subjectvalue.indexOf(";", cnt))+" ...";
                        	  
		                    %>
								<%-- <div class="subject">
									<span class="highlight2" style="margin-right: 2px;float: left;width: 8%;">주제 :</span>
									<span style="margin-left: 2px;float: left;width: 90%;"><%=str%></span>
								</div>  --%>
							<%  
                           }
                        }
                    %>
					<!-- Abstract -->
					<%
                        if(!abstracts.equals("")) {
                    %>
					<div class="abstract">
						<span class="highlight2">Abstract :</span>
						<%=abstracts%>
					</div> 
					<%
                        }
                    %>
					 
					
					</div>
				</div> <!--result table-row -->
				<!-- end of table row -->
									
									
		<%
            	}
            }
       	}
        %>
    
			</div>
			<!--  end results table -->
			<!------------------------------------------ END RESULTS --------------------------------->
								
								
			<!------------------------------------------ PAGINATION --------------------------------->
				<div id="paging" class="paginate" style="text-align: center;">
					   <%
				       		String kwd = (String)request.getAttribute("kwd").toString().replace("<","");
				          	String output= PageNumberHelper.buildPageNumber(resultList.getHits(),resultList.getSelectedResultsPerPage(),resultList.getSelectedPageNumber(), "listEds.do?" + resultList.getQueryString() + "&kwd=" + kwd);
				      	%>
				      	<%=output%>
                </div>
							
		
			</div> <!-- end toptabcontent -->
	
	<c:if test="${edsCnt != '0'}">  
		
	<div id="sidebar-right" style="margin-top:67px;">  
	
	<!-- 필터 숨기기 -->
	<div class="filters">
		<!-------------------------------------  LIMITERS  -------------------------------------------->
		<ul style="padding-left: 0; list-style: none; font-size: 12px;" >
		<%//Create a map of available limiters
    HashMap<String,Object> availableLimiterMap=new HashMap<String,Object>();   
									
    if(null != info && null != info.getAvailableLimitersList()){
        availableLimiterList=info.getAvailableLimitersList();
        for(AvailableLimiter al : availableLimiterList){            
            if(al.getType().equals("select")){
               availableLimiterMap.put(al.getId(), al.getLabel());  
            }else  {      
                availableLimiterMap.put(al.getId(), al.getLimiterValues());
            }
        }
    }
    //process selected limiters
    ArrayList<LimiterWithAction> selectedLimiterList=resultList.getSelectedLimiterList();
    HashMap<String,String> limiterRemovemap=new HashMap<String,String>();
    for(int i=0;i<selectedLimiterList.size();i++){  
    	
        LimiterWithAction lwa=selectedLimiterList.get(i);
        Object obj= availableLimiterMap.get(lwa.getId());
        String limiterName = "";
        String multiselectValue="";
        if (obj instanceof String) {
            limiterName = (String) obj;  
        }else{
            ArrayList<LimiterValueWithAction>  lvwaList = lwa.getLvalist();
            for(LimiterValueWithAction lvwa : lvwaList){
                multiselectValue=multiselectValue+lvwa.getValue();  
            }
            limiterName = multiselectValue;
        }
        
        ArrayList<LimiterValueWithAction>  lvwaList = lwa.getLvalist();
        if(lwa.getId().equals("DT1")){
   	    	dateF="";
	    	dateT=""; 
	    	if(limiterName != ""){
	    		dateF=limiterName.split("/")[0].substring(0,4);
	    		dateT=limiterName.split("/")[1].substring(0,4);
	    	}
        }
        
        limiterRemovemap.put(lwa.getId(),lwa.getRemoveAction());%>
									<li><p>
											<a
												href="${ctxt}/elib/eds/listEds.do?<%=resultList.getQueryString() %>&action=<%=lwa.getRemoveAction()%>"><img src="style/delete.png" />
												<% out.println("Limiter: " + (limiterName == "" ? "pubDate":limiterName) ); %></a>
										</p>
									</li>
									<%}
    
    HashMap<String,String> expanderMap=new HashMap<String,String>();   
    if(null != info && null != info.getAvailableExpandersList()){
        availableExpanderList=info.getAvailableExpandersList();
        for(AvailableExpander ae : availableExpanderList){
            expanderMap.put(ae.getId(), ae.getLabel()); 
        }
    }
    
    ArrayList<ExpandersWithAction> expanderRemoveActionList=resultList.getExpanderwithActionList();
    HashMap <String,String> expanderRemovemap=new HashMap<String,String>();
    for(int i=0;i<expanderRemoveActionList.size();i++){
        ExpandersWithAction ewa=expanderRemoveActionList.get(i);
        String label=expanderMap.get(ewa.getId());
        expanderRemovemap.put(ewa.getId(), ewa.getRemoveAction());%>
									<li><p>
											<a
												href="${ctxt}/elib/eds/listEds.do?<%=resultList.getQueryString() + "&action=" + ewa.getRemoveAction()%>"><img
												src="style/delete.png" />
												<%out.println("Expander: " + label);%></a>
										</p></li>
									<%
        }
        ArrayList<FacetFilterWithAction> facetfiltersList=resultList.getFacetfiltersList();
        HashMap<String,String> facetMap=new HashMap<String,String>();
        for(int i=0;i<facetfiltersList.size();i++){
            FacetFilterWithAction ffwa=facetfiltersList.get(i);
            ArrayList<FacetValueWithAction> fvwalist=ffwa.getFacetValueWithAction();
            for(int j=0;j<fvwalist.size();j++){
                FacetValueWithAction fvwa=fvwalist.get(j);
                String removeAction=fvwa.getRemoveAction();
                EachFacetValue efv=fvwa.getEachfacetvalue();
                facetMap.put(efv.getValue(), removeAction);// here we treat facet value as a key. used to record chekbox status
                
                if(!efv.getValue().equals("eBooks") &&   !efv.getValue().equals("Academic Journals")){
                
    %>
									<li class="search_param">

											<a href="${ctxt}/elib/eds/listEds.do?<%=resultList.getQueryString()+"&action=" + removeAction%>+&kwd=${kwd}" id="<%=efv.getValue()%>" onclick="chkDel();">
											<img src="${ctxt}/resources/css/ncmik/edsStyle/delete.png"/>
												<%out.println(efv.getId() + ": " + efv.getValue());%> </a> 
												
											<input type="hidden" id="<%=efv.getValue()%>" name ="<%=efv.getValue()%>" value="${ctxt}/elib/eds/listEds.do?<%=resultList.getQueryString()+"&action=" + removeAction%>"/>
													
									</li>
									<%
                	}else{
                		if(efv.getValue().equals("Academic Journals")){
                			%><li><input type="hidden" id="pageType" value="a" ></li><% 
                		}else{
                			%><li><input type="hidden" id="pageType" value="e" ></li><%
                		}
                	}
                }
    }%>
								</ul>
							</div>
			
							<ul class="acc-menu" id="accordionMenu1">
								<li class="sidebar-right-text acc-menu_bg"><i
								class="fas fa-tasks"></i>검색결과제한</li>
								<%if(availableLimiterList!=null){%>
								
										<%for(AvailableLimiter availableLimiter : availableLimiterList){
											
							                if(availableLimiter.getId().equals("FT")){
							                	
							                	%>
							                	 <li data-extension="close">
														<div class="main-title"><span class="folder"> </span><a>Text availability</a></div>
															<ul class="sub" id="limiterOptions">
							                	<%
							                    if(limiterRemovemap.containsKey(availableLimiter.getId())){ 
							                        String removeAction = limiterRemovemap.get(availableLimiter.getId());%>
							                       
																<li name = "basic_li">
																	<input class="selected-limiter-option" type="checkbox"
																		name="<%=availableLimiter.getId()%>" checked="checked"
																		value="<%="action=" + removeAction%>" onclick="applyLimiters()" />
																	<%out.println(availableLimiter.getLabel());%>   
																</li>
																<%}else{%>
																<li name = "basic_li">
																	<input class="unselected-limiter-option" type="checkbox"
																		name="<%=availableLimiter.getId()%>"
																		value="<%="action=" + availableLimiter.getAddAction()%>" onclick="applyLimiters()" />
																	<%out.println(availableLimiter.getLabel());%>
																</li>
														
													<%}%>
							                   	 	</ul>
												</li>
											<%
							                }else if(availableLimiter.getId().equals("DT1")){
							                	%>
							               
							                	<li data-extension="close">
							                	<div class="main-title"><span class="folder"> </span><a>PubDate</a></div>
							                		<ul class="sub" >
							                			<li style="text-align: center" class="date">
							                				<label for="str_dt" class="hide"></label>
															<input type="text" id="f_date" name="f_date" 
															maxlength="4" id="startDate" title="startDate" 
															value="<%=dateF%>"> 
															-
															<label for="end_dt" class="hide"></label>
															<input type="text" id="t_date" name="t_date" 
															maxlength="4" id="endDate" title="endDate" value="<%=dateT%>" >
															<input type="hidden" id="pubDate" name="<%=availableLimiter.getId()%>" value="" >
												 		</li>
												 	 <li id="moreYear"><a class="more_btn2" href="javascript:moveYear();" >적용</a></li>
							                	</ul>
							                	</li>
							                	<%
							                }
							            }%>
					
									<!-- <input id="applyLimiters" type="button" value="update" /> -->
						
								<%}%>
       
							<!-------------------------------------  END LIMITERS  -------------------------------------------->
							<!--------------------------------------  FACETS ---------------------------------------------->
								<% ArrayList<Facet> facetsList=resultList.getFacetsList();
    								int facetId = 0;
    								//ArrayList<String> arrayList = new ArrayList<String>(Arrays.asList("Source Type","Subject","Language"));
    								ArrayList<String> arrayList = new ArrayList<String>(Arrays.asList("Language"));
									for(Facet facet : facetsList){
										 if(!arrayList.contains(facet.getLabel())){
											continue;
										} 
										/* if(facet.getId().equals(anObject)){
											
										} */
									facetId++;	
								%>
								<li data-extension="close">											
									<div class="main-title" id="<%=facetId%>"><span class="folder"> </span><a><%out.println(facet.getLabel());%></a></div>
										<ul class="sub">
										<%      
				 						ArrayList<FacetValue> facetsValueList=facet.getFacetsValueList();
				                		int facetsize=facetsValueList.size();
				                		int facetValueSize = 0;
				                		for(FacetValue facetValue : facetsValueList){
						                	
						                	String key=facetValue.getValue();
						                    String applyFacetURL = "elib/eds/listEds.do?" + resultList.getQueryString() + "&action=" + facetValue.getAddAction();
						                    
				// 		                    System.out.println(facetsize);
						                    facetValueSize++;
				// 		                    System.out.println(facetValueSize);
								                    
						                  %>							
											
											
											<li>
												<c:set var="facetValue" value="<%=facetValue.getValue()%>" scope="session"/> 
												
											
											<input type="checkbox" id="<%=facetValue.getValue()%>" onclick="javascript:applyFilter('<%=applyFacetURL%>','<%=facetValue.getValue()%>');" value = "<%=facetValue.getValue()%>" />
											
												<%-- <c:if test="${facetValue eq efvValue}"> checked="checked" </c:if> --%>


												<label for = "<%=facetValue.getValue()%>" ><%=facetValue.getValue()%></label>


<%-- 												<%out.println("("+facetValue.getCount()+")");%> --%>
											</li>
											
											<%if(facetsize == facetValueSize ){%>
												<span><li><a class="more_btn2" href="javascript:fn_rightMenu('<%=facetId%>');">더보기</a></li></span>
											<%}%>
					<%}%>
					</ul>
								</li>
								<%}%>
							
							
							</ul> 
							<!---------------------------------------- END FACETS ---------------------------------------->
						
						
		</div>

</c:if>
  
		</div>
	</div>
</div>

	
	

<form:form name="chkUploadForm" id="chkUploadForm" enctype="multipart/form-data" method="post">
 	<input type="hidden" name="chkUpload" value="" />
</form:form>
