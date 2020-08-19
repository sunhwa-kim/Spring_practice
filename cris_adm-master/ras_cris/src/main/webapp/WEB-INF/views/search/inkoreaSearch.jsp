<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script> 
 
$(function(){	
	if($("#messege").val() != ''){
    	fn_alert( $("#messege").val());
    }
    $("#messege").val('');
	
   /* 
    var strPage =$('#page').val();
	if(strPage == '' ){
		strPage=1;   
	} 
	*/

	$('.check_chlid').click(function(){
		if($(this).parent().find('input').is(":checked")){
			$(this).parent().find('input').prop('checked',false);
		}else{
			$(this).parent().find('input').prop('checked',true);
		}
	});
	
	
	// 화면 목록 조회
	//fn_search(strPage);
	
	//cmmfn_set_datepicker($("#str_dt"), "yy-mm-dd");
	//cmmfn_set_datepicker($("#end_dt"), "yy-mm-dd");
	 
	
	$('.langClass').click(function(){
		$("#searchMove").find("input[name='searchLangList']").remove();
		$(".langClass input").each(function(i){
			if($(this).is(":checked")){
				$("#searchMove").append("<input type='hidden' name='searchLangList' value='"+$(this).val()+"' />");
			}
		});
		
		$("#searchMove").submit();
	});
	
	$('.date_span').each(function(){
		var mon = "";
		var date_pattern = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/; 
		if(date_pattern .test($(this).text())){
			
			switch($(this).text().split('-')[1]){
				case "01" : mon = "Jan";
					break;
				case "02" : mon = "Feb";
					break;
				case "03" : mon = "Mar";
					break;
				case "04" : mon = "Apr";
					break;
				case "05" : mon = "May"; 
					break;
				case "06" : mon = "Jun";
					break;
				case "07" : mon = "Jul";
					break;
				case "08" : mon = "Aug";
					break;
				case "09" : mon = "Sep";
					break;
				case "10" : mon = "Oct";
					break;
				case "11" : mon = "Nov";
					break;
				case "12" : mon = "Dec";
					break;
				default : 
					mon = "Dec";
					break;
			}
			
			if(mon != ""){
				var str_pub = $(this).text().split('-')[0]+" " + mon + " " +$(this).text().split('-')[2];
				$(this).text(str_pub);
			}
		}
	});
	if($('#startDate').val() == ''){
		$('#startDate').val('1950');
	}
	if($('#endDate').val() == ''){
		var sysDate = new Date();
		$('#endDate').val(sysDate.getFullYear());
	}
});

var xmlList;
var html="";
var cuurPage;
var pageTotalCnt = 0;
var dataTotalCnt = 0;

//검색결과제한 controll
//추후 5개로 변경
var initFillter  = 3 ;  // 최초 보여줄 갯수
var cntYear = 2;
var cntLang = 2;
var cntDept = 2;
var resultYear = 3; //최초 보여줄 갯수(parameter)
var resultLang = 3; //최초 보여줄 갯수(parameter)
var resultDept = 3; //최초 보여줄 갯수(parameter)

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

function fn_journal(journal,type){
	
	$('#s1').val(type);
	$('#d1').val(journal);
	var form = document.journalForm;
	form.submit();
}

function fn_view(type , artctrlno, junalnm, doi){
	var l, t;
	l = (screen.width-1000);
	t = (screen.height-700)/2;
	
	var contextName = "ncmik";
	var atchFileId = "";
	var pageTitle = artctrlno;
	
	if(type == 'a'){
		
		if(junalnm == '주간 건강과 질병'){
		
			$.ajax({url: '${ctxt}/elib/search/selectTFFileSch.do',
		            data:{"bibCtrlNo": artctrlno},
				 	type: 'GET',
				 	cache: false,   
			        success: function(rtnXml) {
		        		/*if($(rtnXml).find('atch_file_id').text() != ''){
			        		location.href='http://is.cdc.go.kr/upload_comm/file.do?cmd=fileDownload&SEQ='+$(rtnXml).find('file_sn').text();
			        	}else{
			        		alert("파일 정보가 없습니다.");
			        	} */
			        	var rXmlList = $(rtnXml).find('item');
			         	if(rXmlList.length > 0){
			         		var numId = "";
							rXmlList.each(function(cnt){			
								var obj = $(this);
								var atchFileId = obj.find('atch_file_id').text(); // code
								if(cnt == 0){
									numId = atchFileId;
								}
					        });
							if (numId != "") {
								popAttfileViewIn(numId, contextName, pageTitle);
							}
			   	  		}else{
							alert("파일 정보가 없습니다.");
						}
			     	 }
		     });
		}else{
			if(doi != ''){
				window.open("http://doi.org/"+doi,'_pop','width='+1000+',height='+800+',left='+l+',top='+t+',resizable=0,scrollbars=1');
			}else{
				alert("Full Text 정보가 없습니다.");
			}
		}
	}else if(type == 'b'){
		fn_openSelectAb(artctrlno);
	}else if(type == 'c'){
		fn_openSelectArticle(artctrlno);
	}else if(type == 'd'){
		fn_selMyLib(artctrlno);
	}
}

function fn_openSelectAb(artctrlno){
	$("#paramNo").val(artctrlno);
	var form = document.paramForm;
	var url = "${ctxt}/elib/kom/selectAbstract.do";
	var w = "1000";
	var h = "600";
	var l, t;
	l = (screen.width-1000);
	t = (screen.height-700)/2;
	
	window.open('','paramForm','width='+w+',height='+h+',left='+l+',top='+t+',resizable=0,scrollbars=1');
	
	form.action =url; 
	form.method="post";
	form.target="paramForm";

	form.submit();	
	
}
function fn_openSelectArticle(artctrlno){
	$("#paramNo").val(artctrlno);
	var form = document.paramForm;
	var url = "${ctxt}/elib/kom/selectArticleInfo.do";
	var w = "1000";
	var h = "400";
	var l, t;
	l = (screen.width-1000);
	t = (screen.height-700)/2;
	
	window.open('','paramForm','width='+w+',height='+h+',left='+l+',top='+t+',resizable=0,scrollbars=1');
	
	form.action =url; 
	form.method="post";
	form.target="paramForm";

	form.submit();	
	
}

function fn_search(page){
	//현재 페이지 세팅
	cuurPage= page;
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/

	$('#page').val(cuurPage);

	$('#searchType').val($('#srchChoice option:selected').val());
	
	var params = {};
  		params.page=cuurPage;
  		params.artctrlno='';
  		params.title='1'== ''?'':'1';
  		
	 	params.f1="";
	 	params.v1="";
	 	params.and1="";
	 	params.f2="";
	 	params.v2="";
	 	params.and2="";
	 	params.f3="";
	 	params.v3="";
	 	params.and3="";
	 	params.broadSubject="";
	 	params.listGbn="";
	 	params.orderType="";
	 	params.str_dt="";
	 	params.end_dt="";
	 	params.journalinfo="";
    $.ajax({
        url: '${ctxt}/elib/kom/selectArticleList.do',
        data: params,
        type: 'POST',
        dataType: 'text',
        cache: false,
        success: function(rtnXml) {
   
        	xmlList = $(rtnXml).find('item');

        	pageTotalCnt=0;
        	dataTotalCnt=0;
        	
        	html="";
			
        	if(xmlList.length > 0){
				//총페이지수
				pageTotalCnt = Number($(rtnXml).find('totalPageCnt').text());
				dataTotalCnt = Number($(rtnXml).find('totalDataCnt').text());
				
				$('#total').text("("+numberWithCommas(dataTotalCnt)+")");
				
				xmlList.each(function(cnt){
			
					var obj = $(this);
					alert(obj.find('db_gbn').text());
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					 html += '<div class="dtl_list"  id="data_'+cnt+'" style="padding-bottom:0px;" >';
					// html += ' <input id="option" type="checkbox" name="field" value="option">';
					 html += '<label for="option"><span><span></span></span></label>';
					 html += '<div style = "display:inline;float:left;overflow:visible;margin-top:3px;margin-left:37px;"><input id="option" type="checkbox" name="field" value="option"></div>';
					 html += '<div style = "display:inline;float:left;overflow:visible;clear:both;margin-left:43px;">'+obj.find('order_sn').text()+'. </div>';	
					 html += '<div style = "margin-left:28px;">';
					 html += '<ul>';
					 html += '	  <li class="sub_center_cont_text" style=""><a class="d_title" href="javascript:fn_dtl(\''+ obj.find("artctrlno").text() +'\')">'+ obj.find('title').text() +'</a>';
					 if(obj.find('db_gbn').text() == 'KMBASE'){
						 html += '<img src="${ctxt}/resources/images/sub/kmbase.png" style="vertical-align: sub;"/>';
					 }
					 html += '</li>'; 
					 html += '	  <li class="sub_center_cont_text02" style=""><font style="font-weight:bold;"></font >'+ obj.find('author').text() ; 
					 if(obj.find('author').text() != ''){
						 html += '*</li>';  
					 }else{
						 html += '</li>';  
					 }
					 html += '	  <li class="sub_center_cont_text02" style="">'+ obj.find('journalname').text() +" . "+ obj.find('pubdate').text();
					 html += '	  '+ obj.find('volumename').text() + " : "  + obj.find('startpage').text();
					 
					 if(obj.find('doi').text() != ''){html += ', doi :' +obj.find('doi').text() ;}
					 
					 html += '</li>';   
					 html += '	  <li class="sub_center_cont_text02" style=""><a class="a_btn" href="javascript:fn_view(\'a\',\''+ obj.find('artctrlno').text()  +'\')">원문보기</a> <a class="a_btn" href="javascript:fn_greenInfo(\''+ obj.find('artctrlno').text()  +'\',\''+ cnt  +'\')">초록내용</a> <a class="a_btn" href="javascript:fn_view(\'c\',\''+ obj.find('artctrlno').text()  +'\')">서지정보</a><a class="a_btn" href="javascript:fn_view(\'d\',\''+ obj.find('artctrlno').text()  +'\')">내서재담기</a></li>';
					 html += '	 </ul>';
					 html += '<div id = "greenInfo'+cnt +'">';
					 html += '</div>';
					 html += '	 </div>';
					 html += '</div>';   
					
		        });
				//페이징처리
			    $('#paging').paging({
					 current:cuurPage
					,max:pageTotalCnt
					,length:pageLen
					,onclick:function(e,page){
						cuurPage=page; 
						fn_search(cuurPage);
					}
				});
				$("#topInfo").html("<strong>["+ cuurPage +" / "+pageTotalCnt+" Pages] <span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.</strong>");
			    $("#bodyInfo").html(html);
			  
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$('#paging').children().remove();
				
				$("#bodyInfo").html('<tr><td colspan="5" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}


function fn_dtl(artctrlno , db_gbn){
	$('#artctrlno').val(artctrlno);
	var form = document.artctrlForm;
	
	if(db_gbn != "KMBASE"){
		form.action = "${ctxt}/search/articleDtl.do";	
	}else{
		form.action = "${ctxt}/search/articleKmbaseDtl.do";
	}
	
	form.submit();
	
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

/**
 * 내서재담기 row
 */
function fn_selMyLib(artctrlno) {
	
 	if ("${userVo.emplyrnm}" == "") {
		if (confirm("내서재 담기 기능을 선택하실 경우 로그인 하셔야합니다.\n로그인 화면으로 이동하시겠습니까?")) {
			location.href = "${ctxt}/login/user/login.do";
			return;
		} else {
			return;
		}
	} 
 	var params = {};
	params.key = artctrlno;
	params.gbn = "acticle";
	
	$.ajax({
		url : "<c:url value='/mylib/lib/multiMylibSave.do'/>",
		data : params,
		type : 'post',
		dataType : 'json',
		success : function(data) {
			if(confirm("선택하신 총 1건 중\n내 서재 담기에 성공한 건수: "+data.sucCnt+"건\n이미 내 서재에 등록된 건수(내 서재 담기에 실패한 건수): "+data.dupCnt+"건 \n입니다.\n\n※ 내 서재 화면으로 이동하시겠습니까?")){
				location.href="<c:url value='/mylib/lib/listMyLib.do'/>";
				return;
			}else{
				return;
			}
		}
	}); 
}

/**
 * 내서재담기 multi
 */
function selMultiMyLib() {
	var chk_mylib_cnt = 0;
	var mylibChk = "";
 	if ("${userVo.emplyrnm}" == "") {
		if (confirm("내서재 담기 기능을 선택하실 경우 로그인 하셔야합니다.\n로그인 화면으로 이동하시겠습니까?")) {
			location.href = "${ctxt}/login/user/login.do";
			return;
		} else {
			return;
		}
	} 
 	
	$("input[name=chk_mylib]:checked").each(function() {
		mylibChk += $(this).val() + ",";
	
		if(mylibChk != "" ){
			chk_mylib_cnt++;	
		}
		
	});

	var params = {};
	params.key = mylibChk.substring(0 ,mylibChk.length-1);
	params.gbn = "acticle";

	$.ajax({
		url : "<c:url value='/mylib/lib/multiMylibSave.do'/>",
		data : params,
		type : 'get',
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


function fn_article(){
	$('#fillter_article input').each(function(cnt){
		if($(this).parent().attr('class') == 'on'){
			$('#article_type input[name='+$(this).attr('name')+']').prop('checked',true);
		}
	}); 
	
	popOpen('article_type');
}

function fn_year(){
	popOpen('years');
}

function fn_show(){
	
	$('#fillter_article li').attr('class','articleClass off');
	$('#view_list').children().remove();
	
	$('#article_type :checked').each(function(cnt){
		var text1 = $(this).val();
		$('#fillter_article input').each(function(cnt){
			var text2 = $(this).val();
			if(text1 == text2){
				$(this).parent().attr('class','articleClass on');
				$("#view_list").append('<input type="hidden" name="searchArticleViewList" value="'+$(this).val()+'" />');
			}   
		});      
	});       
	       
	$('#fillter_article li[class=off] input').prop('checked',false);
	$('#add_article').attr('class','on');
	 
	popClose('article_type');
}


/* 소장정보 조회  STR*/
var dupleChk="";
function fn_greenInfo(artctrlno , rowVal, lang , db_gbn){	
	
	var rowIdx = rowVal; 
	var urlVal = "";
	var params = {};   
		params.artctrlno = artctrlno;
	if(dupleChk == rowIdx){ //열었던것 다시 닫기
		 $("div[id^='greenInfo']").children().remove();
		 $(".abtn").attr('style','');
		 dupleChk = "";		 
		 return;
	}
	if(db_gbn == 'NCMIK'){
		urlVal = '${ctxt}/elib/kom/selectAbstract.do';
	}else{
		urlVal = '${ctxt}/elib/kom/selectKmbaseAbstract.do';
	}
    $.ajax({
        url:urlVal,
        data: params,
        type: 'get',
        dataType: 'text', 
        success: function(rtnXml) {
   
        	html="";
        	
			html +='<div id="bibElement" class="view_dl_box">';
		
			if($(rtnXml).find('ABSTRACT').text() != '' ||  $(rtnXml).find('ABSTRACT2').text() != '' ){

				var obj = $(rtnXml);	 								
				var title = obj.find('TITLE').text(); //
				var eng_abstract = obj.find('ABSTRACT').text(); //   
				var kor_abstract = obj.find('ABSTRACT2').text(); //
				
				if(lang != 'Korean'){
					html += '<dl><dt>Abstract</dt><dd>'+eng_abstract+'</dd></dl>';
				}else{
					if(kor_abstract == '' || kor_abstract == '[No Abstract Available]'){
						kor_abstract = eng_abstract;
					}
					html += '<dl><dt>Abstract</dt><dd>'+kor_abstract+'</dd></dl>';
					
					}
					  
			}else{
	
				html += '<dl><dt>Abstract</dt><dd>[No Abstract Available]</dd></dl>';
				
			}
		
			html += '</div>';
			
			dupleChk = rowVal;
			 
			$("div[id^='greenInfo']").children().remove();
			 
			$("#greenInfo"+rowIdx).hide();
			 
			$("#greenInfo"+rowIdx).html(html);
		
			$("#greenInfo"+rowIdx).fadeIn(2000);
			 			 
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}
/* 소장정보 END  */
function fn_fillterControll(){
	$('#sidebar-pumed-right > input').val('');
	$('#sidebar-pumed-right input[type=checkbox]').attr('checked',false);
			
	$("#searchYearMove").val('');			
	$("#searchNlmcMove").val('');			
	$("#searchLangMove").val('');			
	$("#abstract_ynMove").val('');			
	$("#fulltext_ynMove").val('');			
	$("#startDateMove").val('');			
	$("#endDateMove").val('');			
	$("input[name=searchLangList]").val(null);			
			
	$("#searchMove").submit();
}

function kpmcArticleView(type, kpmcId) {
	
	if (type=="classic") {
		//var url = "<c:url value='/jsp/ncmik/ptl/kdr/jrnl/KDRView.jsp'/>" + "?type=" + type + "&kpmcId=" + kpmcId;
		//location.href=url;
        var url = "${ctxt}/elib/kom/kpmcArticle.do" + "?type=" + type + "&kpmcId=" + kpmcId;
		popup(url,1000,700,1);
	} else if (type=="pubreader") {
		var url = "${ctxt}/elib/kom/kpmcArticle.do" + "?type=" + type + "&kpmcId=" + kpmcId;
		popup(url,1000,700,1);
	} else {
		var url = "${ctxt}/elib/kom/kpmcArticle.do" + "?type=" + type + "&kpmcId=" + kpmcId;
        //location.href=url;
        popup(url,1000,700,1);
	}	
}

</script>


<style>
.acc-menu li ul.sub li>a.date-picker-control {
    position: relative;
    margin-left: 5px;
    margin-bottom: 0px;
}
.content_box>.content_list>.list_title>p:before, 
.content_box .content_list .list_title p:before, 
.content_box>.content_list>.sub_book_wrap>.list_title>p:before {
    content: "";
}
#search-group{
	margin-top:0; 
	float:left; 
	height:38px;
	margin:4px 0;
	text-align:left;
	left:40px;
}
#bibElement {
	width:100%;
    max-width: 640px;
    display:inline-block;
/*     border-top: 0px solid rgba(51,122,183,0.5); */
/*     border-bottom: 0px solid rgba(51,122,183,0.5); */
	border: 1px solid #B2CCFF;
    border-collapse: collapse;
    margin-top: 0px;
    margin-right: 20px;
    margin-bottom: 20px;
    font-size: 13px;
    color: #7f7f7f;
    font-weight: normal;
    overflow: visible;
    border-collapse: collapse;
    border-spacing: 0;
    float:left;
    text-align:justify;
}

#bibElement dl {
    width: 96%;
    margin:3% 2%;
    min-height: 20px;
    line-height: 20px;
     border-bottom: 0px solid rgba(51,122,183,0.5); 
     background:none; 
}

#bibElement dd {
    width: 96%;
    margin-left:2%;
    margin-right:2%; 
    padding-left:0;
    min-height:20px;
    float:right;
    background:#fff;
    text-indent:7px;
}

#bibElement dt {
	width:96%;
 	margin-left:2%; 
     margin-right:2%; 
    font-weight: 400;
    text-align: center;
    /* float: left; */
    height: 100%;  
}
#div_body{
	position:relative;
}
.txt-red{
	font-size:13px;
	position:absolute;
}


.center_text_01 {
	position:relative;
}

.btn-group{height: 70px;}


#btnSearch{
	vertical-align: top;
}
#all_chk{
	width:90px;
}
.bibliography{
	width:145px;
}
@media (max-width: 1160px){
	.txt-red{
		top:75px;
	}
}
@media (max-width: 762px){
	#search-group {
		z-index:100;
		top:55px;
	    left: 0%;
	    width: 100%;
	    text-align: center;
    }
	.selectbox_wrap {
	    margin-top: 0;
	    margin-bottom:10px;
	    position: relative;
	}
	.txt-red {
    	top: 90px;
    }
}
@media (max-width: 600px){

	.selectbox_wrap {
		display:block;
		width:100%;
		text-align:center;
		/* position: absolute; */
	    left: 50%;
	    /* padding-bottom:50px; */
	    /* margin-top:-95px; */
	    /* padding-bottom:40px; */
	    transform: translate(-50%,0);  
	    transition: all 0.3s;
	    -webkit-transition: all 0.3s;
	    padding-top:0;
	    height: 25px;
	}   
	.txt-red{
		top:125px;
	}
	.center_text_02{
	padding-left: 12px;
	}
}
@media (max-width: 502px){
	#search-group {   
	    left: 50%;
	    width: 100%;
	    text-align: center;
    }
}
@media (max-width: 494px){
	.category_select {
	    left: 71%;
	    top: 2.1%;
	    position: absolute;
	}  
	.selectbox_wrap{
	}
	.sub_book_wrap{
		margin-top:0px;
	}
	.txt-red{
		top:115px;
	}   
	.under_bar2 {
		margin-top: 0px; 
	}
	.selectbox_wrap button.print_btn{
		display: none;
	}   
	#selectbox2{
		margin-left: 3px;
	}
}
 
li .on{
}
li .off{display: none !important;   
} 

</style>
<form id="journalForm" name="journalForm" method="post" action="${ctxt}/elib/kom/listArticle.do"  >
	<input type="hidden" id="cate" name="subCategory" value="in"/>
	<input type="hidden" id="sba" name="subjectArea" value="all"/>
	<input type="hidden" id="s1" name="searchCondition1" value="journal"/>
	<input type="hidden" id="s2" name="searchCondition2" value="title"/>  
	<input type="hidden" id="s3" name="searchCondition3" value="author"/>
	<input type="hidden" id="d1"  name="detailInput1" value=""/>
	<input type="hidden" id="o1"  name="selectOption1" value="and"/>  
	<input type="hidden" id="o2"  name="selectOption2" value="and"/>
	<input type="hidden" id="o3"  name="selectOption3" value="and"/>
	<input type="hidden" id="d2"  name="detailInput2" value=""/>  
	<input type="hidden" id="d3"  name="detailInput3" value=""/>
	<input type="hidden" id="d4"  name="detailInput4" value=""/>
	<input type="hidden" id="d5"  name="detailInput5" value="all"/>
	<input type="hidden" id="sd"  name="startDate" value=""/>
	<input type="hidden" id="ed"  name="endDate" value=""/>
	<input type="hidden" id="isNull"  name="isNull" value="true"/>
	<input type="hidden" id="hstrDiv"  name="hstrDiv" value="2"/>
	<input type="hidden" id="jwkid"  name="wkid" value=""/>
	<input type="hidden" name="detailYn" value="Y"/>
	<input type="hidden" name="searchGubun" value="board"/>
</form>
<form id="artctrlForm" name="artctrlForm"
	action="" method="get">
	<input type="hidden" id="page" name="page" value="" /> <input
		type="hidden" id="artctrlno" name="artctrlno" value="" />
</form>

<div class="sub_center_text">
	<div class="sub_center_nav">
		<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>
		<span> > </span> 
		<span>통합검색</span>
		<span> > </span>
		<span class="active">Korea OpenMed</span>
	</div>
	<span class="center_text_01">Korea OpenMed<span class="category_select">▼</span></span>
	
</div>
<div class="under_bar"></div>


<div class="content_wrap">
	<div class="content_box">
		<div class="content_list">
			<div class="sub_book_wrap">
				
				<%-- <form id="inkoreaForm" name="inkoreaForm" action="${ctxt}/search/search.do" method="post">
					<input type="hidden" name="searchTarget" value="inkorea"/>
					<div id="search-group" style="margin-top:0;" class="sub">
						<div class="search-input">
							<label for="searchCombo"></label> 
							<select id="searchCondition" name="searchCondition" title="분류">
								<option value="total">전체</option>
								<option value="author">저자</option>
								<option value="title">제목</option>
								<option value="journal">저널명</option>
								<option value="keyword">키워드</option>
								<option value="publisher">발행자</option>
							</select> 
							<label for="searchBox"></label> 
							<input type="text" id="searchKeyword" name="searchQuery" value="" placeholder="검색어를 입력해주세요." onkeypress="javascript:if(event.keyCode == 13) { inkoreaGoSearch(); return false;}" /> 
							<input type="button" id="btnSearch" value="검색" onclick="inkoreaGoSearch();" />
						</div>
					</div>
				</form> --%>

					
				<div class="list_title">
					<!-- <p>국내학술논문</p> -->
				</div>
				<div class="under_bar2" style="margin-bottom:5px;"></div>
				<div class="selectbox_wrap clear k_om" style="margin-bottom:10px;">
					<select id="selectbox1" name="pageSize" class="sub_select nomargin" onchange="moveSize(this.value);">
					  <span class="sub_arr"></span>
					  <option value="10" <c:if test="${vo.pageSize == 10}">selected="selected"</c:if>>10</option>
					  <option value="20" <c:if test="${vo.pageSize == 20}">selected="selected"</c:if>>20</option>
					  <option value="30" <c:if test="${vo.pageSize == 30}">selected="selected"</c:if>>30</option>
					  <option value="50" <c:if test="${vo.pageSize == 50}">selected="selected"</c:if>>50</option>
					</select>
					<select id=selectbox2 name="searchSort" class="sub_select" onchange="moveSort(this.value);">
					  <span class="sub_arr"></span>
					  <option value="recent" <c:if test="${vo.searchSort eq 'recent'}">selected="selected"</c:if>>Most Recent</option>
					  <option value="weight" <c:if test="${vo.searchSort eq 'weight'}">selected="selected"</c:if>>Best Match</option>
					  <%-- <option value="old" <c:if test="${vo.searchSort eq 'old'}">selected="selected"</c:if>>Date Oldest</option> --%>
					</select>			
					 <a href="javascript:fn_all()" id="all_chk" class="center_text_02 check_button" >All Check</a>
					 <a href="javascript:selMultiMyLib()" class="center_text_02 bibliography">My Bibliography<i class="fas fa-download"></i></a>
					 <button type="button" class="print-preview print print_btn" >Print<i class="fas fa-print"></i></button>
				</div>
				<!-- <div class="under_bar"></div> -->
				<!-- <div style="width: 100%;  padding-left: 10px; float: left;" id="div_body">
				소장전체 -->
				<div class="sub_book_wrap" id = "div_body">
					<div id="bodyInfo" style="min-height:490px;">
						<c:choose>
							 <c:when test="${data.inkorea_totalSize >0}">
								<c:forEach var="inkoreaList" items="${data.inkoreaList}" varStatus="status">
									<div class="dtl_list" id="data_0" style="padding-bottom:7px;">
										<label for="option"><span><span></span></span></label>
										<div style="display:inline;overflow:visible;margin-top:3px;">
										<input id="option" type="checkbox" name="chk_mylib" value="<c:out value='${inkoreaList.artctrlno}'/>"></div>
										<div style="margin-left:28px;">
											<ul>
												<li class="sub_center_cont_text" style="">
												<span>${ (data.inkorea_totalSize) - (data.inkorea_totalSize - ((vo.pageNum-1) * vo.pageSize) - status.index) +1}. </span>
												<a href="javascript:fn_dtl('${inkoreaList.artctrlno}'  , '${inkoreaList.db_gbn}')">${inkoreaList.title}</a>
												<c:if test = "${inkoreaList.db_gbn eq 'KMBASE'}">
													<img src="${ctxt}/resources/images/sub/kmbase.png" style="vertical-align: sub;"/>
												</c:if>
												</li>	  
												<li class="sub_center_cont_text02" style=""><font style="font-weight:bold;"></font> 
												<c:if test="${inkoreaList.author ne '[No Authors Listed]'}"><c:if test="${inkoreaList.author != '' and inkoreaList.author ne null}"><c:set var="author" value="${fn:split(inkoreaList.author,',')}" /><c:forEach var="item" items="${author}" varStatus="g"><c:if test="${g.index > 0}">, </c:if><c:set var="auth_name" value="${fn:trim(item)}" /><a class="auth_name" href="javascript:fn_journal('${fn:replace(auth_name, '*', '')}','author')">${auth_name}</a></c:forEach></c:if></c:if>
												<c:if test="${inkoreaList.author eq '[No Authors Listed]'}">
												[No Authors Listed]
												</c:if>
												</li>
												<li class="sub_center_cont_text02" style=""><a class="auth_name" href="javascript:fn_journal('${inkoreaList.journalname}')">${inkoreaList.journalname}</a>. <span class="date_span">${inkoreaList.pubdate}</span>. ${inkoreaList.volumename}. ${inkoreaList.startpage}. ${inkoreaList.language}. <c:if test="${inkoreaList.doi != ''}">doi:<a href="http://doi.org/${inkoreaList.doi }" target="_blank" rel="noopener noreferrer">${inkoreaList.doi }</a></c:if></li>
												<li class="sub_center_cont_text02" style="">
													<c:if test="${inkoreaList.kpmcid ne ''}"> 
														<a class="a_btn"  style="cursor: pointer;"  href="javascript:kpmcArticleView('classic', '${inkoreaList.kpmcid}')">ARTICLE</a>
													    <a class="a_btn"  style="cursor: pointer;"  href="javascript:kpmcArticleView('pubreader', '${inkoreaList.kpmcid}')">PUBREADER</a>
														<a class="a_btn"  style="cursor: pointer;"  href="javascript:kpmcArticleView('pdf', '${inkoreaList.kpmcid}')">PDF</a>
													</c:if>
													<c:if test="${inkoreaList.fulltext_yn eq 'Y'}">
														<a class="a_btn" href="javascript:fn_view('a','${inkoreaList.artctrlno}','${inkoreaList.journalname}','${inkoreaList.doi}')">Full Text</a> 
													</c:if> 
													<c:if test="${inkoreaList.abstract_yn eq 'Y'}"> 
														<a class="a_btn" id="inkorea${status.index }" href="javascript:fn_greenInfo('${inkoreaList.artctrlno}', '${status.index}','${inkoreaList.language}' , '${inkoreaList.db_gbn}' )">Abstract</a>
													</c:if> 
													<a class="a_btn" href="javascript:fn_view('d','${inkoreaList.artctrlno}')">My Bibliography</a>
												</li>
											</ul>
										 <div id = "greenInfo<c:out value='${status.index}'/>"  >
										 </div> 
										</div>
									</div> 
								</c:forEach>
							</c:when> 
						<c:otherwise>
						<div class="not_found">검색조건에 해당하는 결과가 없습니다. 다른 검색조건을 선택해 주세요.</div>
						</c:otherwise>
						</c:choose>
					</div>
				</div>
<!-- 				<div class="under_bar2" ></div> -->
				${data.inkorea_totalPage}
			    <div id="paging" class="paginate"></div> 
 				<div class="btn-group back"> 
					<a href="${ctxt}/elib/kom/listKom.do" title="이전" class="basic-btn back">Korea OpenMed</a>
				</div>
			</div>
			<!-- 도서 목록 끝 --> 

			<div id="sidebar-right" style="margin-top:40px;">
				<!-- <div class="sidebar-right-text">Fillter검색결과제한</div> -->
				<ul class="acc-menu" id="pumed-accordionMenu1">
					<li class="sidebar-right-text acc-menu_bg"><i
							class="fas fa-tasks"></i>Restrict Result</li>
					<li data-extension="close">
						<div class="main-title">
							<span class="folder"></span><a>Article types</a>
						</div>
						<ul class="sub" id="fillter_article">
							<c:forEach var="articleGroupList" items="${data.articleGroupList}" varStatus="status">
								<c:choose>
									<c:when test="${articleGroupList.view_yn eq 'Y' }">
										<li class="articleClass on">
											<input type="checkbox" name="searchArticleGroupList" value="${articleGroupList.groupNm}"   <c:forEach var="searchArticleList" items="${vo.searchArticleList}" varStatus="status"><c:if test="${searchArticleList eq articleGroupList.groupNm}"> checked="checked" </c:if> </c:forEach> />
											<span class="check_chlid">${articleGroupList.groupNm}</span>
										</li>
									</c:when> 
									<c:otherwise>
										<li class="articleClass off">
											<input type="checkbox" name="searchArticleGroupList" value="${articleGroupList.groupNm}"   <c:forEach var="searchArticleList" items="${vo.searchArticleList}" varStatus="status"><c:if test="${searchArticleList eq articleGroupList.groupNm}"> checked="checked" </c:if> </c:forEach> />
											<span class="check_chlid">${articleGroupList.groupNm}</span>
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>  
							<li id="add_article"><a href="javascript:fn_article()">Customize
									...</a></li>
						</ul>
					</li>
					<div class="schedule" id="article_type" style="width:200px;">
						<a href="javascript:fn_show();">[Show]</a>
						<div>
							<c:forEach items="${data.articleGroupList}" var="item">
								<li><input type="checkbox" name="${item.groupNm}" value="${item.groupNm}" <c:if test="${item.view_yn eq 'Y' }" >checked="checked"</c:if> ><span
									class="check_chlid" style="cursor: pointer;">${item.groupNm}</span></li>
							</c:forEach>	
						</div>
					</div>
			
					<li data-extension="close">
						<div class="main-title">
							<span class="folder"> </span><a>Text availability</a>
						</div>
						<ul class="sub" id="">
							<li><input type="checkbox" id="abstract_yn" name="abstract_yn" onclick="textAvailable('abstract');" <c:if test="${vo.abstract_yn eq 'Y'}">checked="checked"</c:if>>
							<span class="check_chlid" onclick="textAvailable2('abstract');">Abstract</span></li>
							<li><input type="checkbox" id="fulltext_yn" name="fulltext_yn" onclick="textAvailable('fulltext');" <c:if test="${vo.fulltext_yn eq 'Y'}">checked="checked"</c:if>>
							<span class="check_chlid" onclick="textAvailable2('fulltext');">Full text</span></li>
						</ul>
					</li>
					<li data-extension="close">
						<div class="main-title">
							<span class="folder"> </span><a>Publication dates</a>
						</div>
						<ul class="sub" id="fillter_dept">
							<c:set var="now" value="<%=new java.util.Date()%>" />
							<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set> 
							<li>
									<input type="radio" id="startDate" name="yearRadio" value="5" onclick="publicationDate('5');" <c:if test="${vo.startDate eq (sysYear-5)}"> checked="checked"</c:if>>
									<span class="check_chlid" onclick="publicationDate('5');">5 years</span>
								</li>
								<li>
									<input type="radio" id="endDate" name="yearRadio" value="10" onclick="publicationDate('10');" <c:if test="${vo.startDate eq (sysYear-10)}"> checked="checked"</c:if>>
									<span class="check_chlid" onclick="publicationDate('10');">10 years</span>
								</li>
							<li style="height: 100%;">
								<label for="str_dt" class="hide"></label>  
								<input type="text" value="<c:out value='${vo.startDate}'/>" style="width: 55px;text-align: center; margin-left: 1%;" maxlength="4" id="str_dt" title="start_dt" name="str_dt" >
								<!-- onblur="javascript:fn_validDate(this)" -->
								 -<label for="end_dt" class="hide"></label>
								 <input type="text" value="<c:out value='${vo.endDate}'/>" style="width: 55px;text-align: center; margin-left: 1%; margin-top: 1%;" maxlength="4"
								id="end_dt" title="end_dt" name="end_dt" >
								<li id="moreYear"><a class="more_btn2" href="javascript:publicationDateApply();" >적용</a></li>
								<!-- onblur="javascript:fn_validDate(this)" -->
								<!-- <a>Apply</a> -->
							</li>
						</ul>   
					</li>
					<li data-extension="close">
						<div class="main-title">
							<span class="folder"> </span><a>Language</a>
						</div>
						<ul class="sub" id="fillter_lang">
							<c:forEach var="langGroupList" items="${data.langGroupList2}" varStatus="status">
								<li class="langClass" <c:if test="${langGroupList.groupNm ne 'KOREAN' and langGroupList.groupNm ne 'ENGLISH'}">style="display:none;"</c:if>>
									<input type="checkbox" name="searchLangList" value="${langGroupList.groupNm}" <c:forEach var="searchLangList" items="${vo.searchLangList}" varStatus="status"><c:if test="${searchLangList eq langGroupList.groupNm}"> checked="checked" </c:if> </c:forEach> />
									<span class="check_chlid">${langGroupList.groupNm}</span>
								</li>
							</c:forEach>
						</ul>
					</li>
				</ul>
				<a class="sidebar-right-text clearall" href="javascript:fn_fillterControll()"> ClearAll</a>
			</div>
		</div>
	</div>
</div>

<form id="searchMove" name="searchMove" action="${ctxt}/search/search.do" method="post">
	<input type="hidden" id="searchQueryMove" name="searchQuery" value="<c:out value='${vo.searchQuery}'/>" />
	<input type="hidden" id="pageNumMove" name="pageNum" value="1" /> 
	<input type="hidden" id="pageSizeMove" name="pageSize" value="<c:out value='${vo.pageSize}'/>" />
	<input type="hidden" id="searchSortMove" name="searchSort" value="<c:out value='${vo.searchSort}'/>" />
	<input type="hidden" id="searchTargetMove" name="searchTarget" value="<c:out value='${vo.searchTarget}'/>" />
	<input type="hidden" id="searchSubTargetMove" name="searchSubTarget" value="<c:out value='${vo.searchSubTarget}'/>" />
	<input type="hidden" id="searchYearMove" name="searchYear" value="<c:out value='${vo.searchYear}'/>" />
	<input type="hidden" id="searchNlmcMove" name="searchNlmc" value="<c:out value='${vo.searchNlmc}'/>" />
	<input type="hidden" id="searchLangMove" name="searchLang" value="<c:out value='${vo.searchLang}'/>" />
	<input type="hidden" id="abstract_ynMove" name="abstract_yn" value="<c:out value='${vo.abstract_yn}'/>" />
	<input type="hidden" id="fulltext_ynMove" name="fulltext_yn" value="<c:out value='${vo.fulltext_yn}'/>" />
	<input type="hidden" id="startDateMove" name="startDate" value="<c:out value='${vo.startDate}'/>" />
	<input type="hidden" id="endDateMove" name="endDate" value="<c:out value='${vo.endDate}'/>" />
	<div id="view_list">
		<c:forEach var="searchArticleViewList" items="${vo.searchArticleViewList}" varStatus="var">
			<input type="hidden" name="searchArticleViewList" value="${searchArticleViewList}" />
		</c:forEach>    
	</div>  
	<c:if test ="${not empty vo.searchArticleList}">
		<c:forEach var="searchArticleList" items="${vo.searchArticleList}" varStatus="var">
			<input type="hidden" name="searchArticleList" value="${searchArticleList}" />
		</c:forEach>
	</c:if>
	<c:if test ="${not empty vo.searchLangList}">
		<c:forEach var="searchLangList" items="${vo.searchLangList}" varStatus="var">
			<input type="hidden" name="searchLangList" value="${searchLangList}" />
		</c:forEach>
	</c:if>
</form>

<form name ="paramForm">
		<input type="hidden" id="paramNo" name="paramNo" value="" alt="논문번호">
</form>