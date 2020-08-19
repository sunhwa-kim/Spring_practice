<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script>
 
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
var id_by_classBefore="";
$(function(){
	
	
	$('.a_btn').click(function(){
// 		var id_by_class = $(this).attr('id');
		
// 		alert(id_by_class);
		$(this).attr('style','background-color: rgba(0, 57, 100, 1);color:#Fff;');
// 		if(id_by_classBefore ==''){
// 			id_by_classBefore = id_by_class;
// 			$("#"+id_by_class).attr('style','background-color: rgba(0, 57, 100, 1);color:#Fff;');
// 		}else{
// 			$("#"+id_by_classBefore).attr('style','');
// 		}
		
		
// 		if(id_by_classBefore != id_by_class){
// 			$("#"+id_by_class).attr('style','background-color: rgba(0, 57, 100, 1);color:#Fff;');
// 		}
// 		id_by_classBefore = id_by_class;
	});
	
	$('.print-preview').printPreview();
	
	if($("#messege").val() != ''){
    	fn_alert( $("#messege").val());
    }
    $("#messege").val('');
	
    var page =$('#page').val();
	if(page == '' ){
		page=1;
	}

	$('.check_chlid').click(function(){
		if($(this).parent().find('input').is(":checked")){
			$(this).parent().find('input').prop('checked',false);
		}else{
			$(this).parent().find('input').prop('checked',true);
		}
	});
	
	// 화면 목록 조회
	fn_search(page);
	
	cmmfn_set_datepicker($("#str_dt"), "yy-mm-dd");
	cmmfn_set_datepicker($("#end_dt"), "yy-mm-dd");
	
});



function fn_view(type , artctrlno, junalnm, doi){
	var l, t;
	l = (screen.width-1000);
	t = (screen.height-700)/2;

	if(type == 'a'){
		if(junalnm == '주간 건강과 질병'){
			
			$.ajax({url: '${ctxt}/elib/search/selectTFFileSch.do',
		            data:{"bibCtrlNo": artctrlno},
				 	type: 'GET',
				 	cache: false,   
				 	dataType: 'text',
			        success: function(rtnXml) {
			        	location.href='http://is.cdc.go.kr/upload_comm/file.do?cmd=fileDownload&SEQ='+$(rtnXml).find('atchFileId').text();
			      }
		     });
		}else{
			if(doi != ''){
				window.open("http://doi.org/"+doi,'_pop','width='+1000+',height='+800+',left='+l+',top='+t+',resizable=0,scrollbars=1');
			}else{
				alert("Full Text 정보가 없습니다.");
			}
		}
	}else if(type == 'b'){ // 호출하는곳 없음. 20181204
	//	window.open('${ctxt}/elib/kom/selectAbstract.do?artctrlno='+artctrlno,'_pop','width='+1000+',height='+600+',left='+l+',top='+t+',resizable=0,scrollbars=1');
	}else if(type == 'c'){// 호출하는곳 없음. 20181204
	//	window.open('${ctxt}/elib/kom/selectArticleInfo.do?artctrlno='+artctrlno,'_pop','width='+1000+',height='+600+',left='+l+',top='+t+',resizable=0,scrollbars=1');
	}else if(type == 'd'){
		selMyLib(artctrlno);
	}
}

/* 소장정보 조회  STR*/
var dupleChk="";
function fn_greenInfo(artctrlno , rowVal, lang){	
	
	var rowIdx = rowVal; 

	var params = {};  
		params.artctrlno = artctrlno;
	if(dupleChk == rowIdx){ //열었던것 다시 닫기
		 $("div[id^='greenInfo']").children().remove();
		 $(".abtn").attr('style','');
		 dupleChk = "";		 
		 return;
	}
 
    $.ajax({
        url: '${ctxt}/elib/kom/selectAbstract.do',
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
		params.bibctrlno='${bibctrlno}';
		params.seqno='${seqno}';

    $.ajax({
        url: '${ctxt}/elib/kom/selectJuanlDtlList.do',
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
        		
        		$('#lb_title').html($(rtnXml).find('lb_title').text());
				//총페이지수
				pageTotalCnt = Number($(rtnXml).find('totalPageCnt').text());
				dataTotalCnt = Number($(rtnXml).find('totalDataCnt').text());
				
				xmlList.each(function(cnt){
			
					var obj = $(this);
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					 html += '<div class="dtl_list"  id="data_'+cnt+'" style="padding-bottom:7px;" >';
					// html += ' <input id="option" type="checkbox" name="field" value="option">';
					 html += '<label for="option"><span><span></span></span></label>';
					 html += '<div style = "display:inline;float:left;overflow:visible;margin-top:3px;"><input id="option" type="checkbox" name="chk_mylib" value="'+ obj.find("artctrlno").text() +'"></div>';
					 //html += '<div style = "display:inline;float:left;overflow:visible;clear:both;margin-left:43px;">'+obj.find('order_sn').text()+'. </div>';	
					 html += '<div style = "margin-left:28px;">';
					 html += '<ul>';
					 html += '	  <li class="sub_center_cont_text" style=""><a class="" href="javascript:fn_dtl(\''+ obj.find("artctrlno").text() +'\')">'+ obj.find('title').text() +'</a></li>'; 
					 var authorList = obj.find('author').text().split(",");
					 html += '<li class="sub_center_cont_text02" style="">';
					 for(var i=0; i< authorList.length;i++ ){
						 if(i>0){html += ", ";}
						 html += '<a class="auth_name" href=\"javascript:fn_journal(\''+ jQuery.trim(authorList[i]) +'\',\'author\')\">'+jQuery.trim(authorList[i])+'</a>' ; 
					 }
					 html += '</li>';   
					 
					 html += '	  <li class="sub_center_cont_text02" style=""><a class="auth_name" href=\"javascript:fn_journal(\''+ obj.find('journalname').text() +'\',\'journal\')\">'+ obj.find('journalname').text() +"</a>. "+ obj.find('pubdate').text()+". ";
					 html += '	  '+ obj.find('volumename').text() + ". "  + obj.find('startpage').text()+". ";
					 html += '	  '+ obj.find('language').text();
					 if(obj.find('doi').text() != ''){
						 var doi = obj.find('doi').text();
						 html += '. doi : <a href="http://doi.org/'+doi+'" target="_blank" rel="noopener noreferrer">'+doi+'</a>';
 						 //html += '. doi :' +obj.find('doi').text();      
					}
					 
					 html += '</li>';   
					 /* html += '	  <li class="sub_center_cont_text02" style=""><a class="a_btn" href="javascript:fn_view(\'a\',\''+ obj.find('artctrlno').text()  +'\')">원문보기</a> <a class="a_btn" href="javascript:fn_greenInfo(\''+ obj.find('artctrlno').text()  +'\',\''+ cnt  +'\')">초록내용</a> <a class="a_btn" href="javascript:fn_view(\'c\',\''+ obj.find('artctrlno').text()  +'\')">서지정보</a><a class="a_btn" href="javascript:fn_view(\'d\',\''+ obj.find('artctrlno').text()  +'\')">내서재담기</a></li>'; */
					 html += '	  <li class="sub_center_cont_text02" style="">';
					 if(obj.find('abstract1').text() == 'Y'){
					 	html += ' <a class="a_btn" href="javascript:fn_view(\'a\',\''+ obj.find('artctrlno').text()  +'\',\''+ obj.find('journalname').text()  +'\',\''+ obj.find('doi').text()  +'\')">Full Text</a>';
					 }
					 
					 if(obj.find('abstract').text() != 'Y'){
					 	html += ' <a class="a_btn" id="historyDtl'+cnt+'" href="javascript:fn_greenInfo(\''+ obj.find('artctrlno').text()  +'\',\''+ cnt  +'\',\''+ obj.find('language').text()  +'\')">Abstract</a> ';
					 }
					 html += ' <a class="a_btn" href="javascript:fn_view(\'d\',\''+ obj.find('artctrlno').text()  +'\')">My Bibliography</a>';
					 html += '</li> ';
					 
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

function fn_all(){
	$("input[name=chk_mylib]").each(function() {
		if(isChk){
			$('#all_chk').text("All Check");
			$(this).prop("checked",false);
		}else{
			$('#all_chk').text("All Cancel");
			$(this).prop("checked",true);
		}
	});
	isChk=!isChk;

}



function fn_dtl(artctrlno){
	$('#artctrlno').val(artctrlno);
	var form = document.artctrlForm;
	form.submit();
	
}

function fn_journal(journal, type){
	
	$('#s1').val(type);
	$('#d1').val(journal);
	var form = document.journalForm;
	form.submit();
}


function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

/**
 * 내서재담기
 */
function selMyLib(artctrlno) {
	
 	if ("${userVo.emplyrnm}" == "") {
		if (confirm("내서재 담기 기능을 선택하실 경우 로그인 하셔야합니다.\n로그인 화면으로 이동하시겠습니까?")) {
			location.href = "${ctxt}/login/user/login.do?returnURL=/elib/kom/historyDtl.do?bibctrlno=${bibctrlno}&seqno=${seqno}";
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
 * 선택된 로우 내서재 담기
 */
function selMyLibs(){
	if ("${userVo.emplyrnm}" == "") {
		if (confirm("내서재 담기 기능을 선택하실 경우 로그인 하셔야합니다.\n로그인 화면으로 이동하시겠습니까?")) {
			location.href = "${ctxt}/login/user/login.do?returnURL=/elib/kom/historyDtl.do?bibctrlno=${bibctrlno}&seqno=${seqno}";
			return;
		} else {
			return;
		}
	} 
	var chk_mylib_cnt = 0;
	var mylibChk = "";
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
		type : 'post',
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
	
	$('#fillter_article li').attr('class','off');
	
	$('#article_type :checked').each(function(cnt){
		$('#fillter_article input[name='+$(this).attr('name')+']').parent().attr('class','on');
	}); 
	
	$('#fillter_article li[class=off] input').prop('checked',false);
	$('#add_article').attr('class','on');
	
	popClose('article_type');
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
    max-width: 700px;
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
#selectbox2{
	width: 98px;
	background: url(${ctxt}/resources/images/sub/sub_op.PNG) 88px center no-repeat;
	background-size:10px auto;
}
.center_text_02{
	height:28px;
	line-height:28px;
	padding:0;
	padding-left: 25px;
}

.btn-group{height: 40px;}


#btnSearch{
	vertical-align: top;
}
</style>

<form id="artctrlForm" name="artctrlForm"
	action="${ctxt}/elib/kom/articleHisDtl.do" method="get">
	<input type="hidden" id="page" name="page" value="" /> <input
		type="hidden" id="artctrlno" name="artctrlno" value="" />
</form>

<div id="divUcont_cont">
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>전자자원</span>
			<span> > </span>
			<span class="active">KoreaOpenMed</span>        
		</div>
		<span class="center_text_01">Article List</span>
	</div> 
</div>

<div class="under_bar"></div>
<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div class="selectbox_wrap" style="">		
					<a href="javascript:fn_all()" id="all_chk" class="center_text_02" >All Check</a>
					<a href="javascript:selMyLibs()" class="center_text_02" style="margin-left:20px;">My Bibliography<div id="library1" style="margin-top:6px"></div></a>
					<button type="button" class="print-preview print print_btn" style="margin-top:6px;">Print<i class="fas fa-print"></i></button>
				</div>
				<div class="list_title" style="width: 60%;">     
					${sel_title} <br />
					<p><c:if test="${meshDesc ne ''}">${meshDesc}</c:if><c:if test="${vol_title ne ''}">${vol_title}</c:if></p>
				</div> 
				<!-- <div class="under_bar"></div> -->
				<!-- <div style="width: 100%;  padding-left: 10px; float: left;" id="div_body">
				소장전체 -->
				
				<div class="sub_book_wrap" style="width: 100%; borde:1px solid #f0f;" id = "div_body">
				<div class="under_bar2"></div>
					<div id="bodyInfo"></div>  
				</div>
				<!-- <div id="paging" class="paginate" style=""></div> -->
				<div class="btn-group"  style="float: right;">
					<a href="javascript:history.back()" title="이전" style="float: right;margin-bottom:10px;" class="basic-btn" >Journal History</a>
				</div>
			</div>
			<!-- </div>      -->
		</div> 
		<!-- 도서 목록 끝 -->
	</div>
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
