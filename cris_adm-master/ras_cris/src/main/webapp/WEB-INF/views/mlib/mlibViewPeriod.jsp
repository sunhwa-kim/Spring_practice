<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="BOOK_GOOGLE_KEY" value="AIzaSyCXpuS-S_8MAGBv_s-c8FIlZyoA_OGrYHI" /> <!-- Google(imjholee) Real Key -->
<!-- 차트 구성 SCRIPT STR-->
<link rel="stylesheet" href="${ctxt}/resources/js/chart/jui/jquery-ui.min.css" />
<!-- 차트 구성 SCRIPT END-->
<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn", "\n"); //Space, Enter
      pageContext.setAttribute("br", "<br/>"); //br 태그
%> 


<script type="text/javascript">
var xmlList;
var html="";
var cuurPage;
var pageTotalCnt = 0;
var dataTotalCnt = 0;
var lookBoolean = true;  
var returnGbn ='';
var bibctrlno="<c:out value='${mlibVo.bibctrlno}'/>";
var html2 = '';

$(function(){
	
	// 프린트
	$('.print-preview').printPreview();
	// 프린트 할 영역 숨기기 
	$("#print_hidden").hide();
	
	fn_vol();
	fn_won();
	fn_tapView();
	$(".tab_content").hide();
    $(".tab_content:first").show();

    
    $("ul.tabs li").eq(0).addClass("active").css("color", "#003964");
    $("ul.tabs li").click(function () {
        $("ul.tabs li").removeClass("active").css("color", "#7f7f7f");       
        $(this).addClass("active").css("color", "#003964");
        $(".tab_content").hide()
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn()
    });
	
	//ISBN을 통한 Google Book Cover 가져오기
	var isbnObjs = $(".bibISBN");
	$.each(isbnObjs, function(i, o) {
		o = $(o);
		 if (o.val() != "") {
			$.ajax({
				"url" : "https://www.googleapis.com/books/v1/volumes",
				"data" : {
					"q" : "isbn:"+o.val().replace(/-/gi,"")
					,"key" : "<c:out value='${BOOK_GOOGLE_KEY}'/>"
				},
				"type" : "get",
				"dataType" : "jsonp",
				"success" : function(data) {
					var findImageFlag = false;
					if (data.totalItems && data.totalItems != 0 ) {
						for(var i=0; i<data.totalItems;i++) {
							if(data.items[i].volumeInfo.imageLinks) {
								bookCoverImgUrl = data.items[i].volumeInfo.imageLinks.thumbnail;
								if (bookCoverImgUrl) {
									o1 = o.parent();
									/* o1.css('background', 'url('+bookCoverImgUrl+') no-repeat');  
									o1.css('background-size', '99% 99%');
									o1.css('display', 'block'); */
									o1.html("<img class='bkImg' src="+bookCoverImgUrl+"/>");
									findImageFlag = true;
									break;
								}
							}
						}
					} 
				}
			});
		 }
	});
	

});



function fn_vol(){
	$.ajax({
        url: '${ctxt}/mlib/volumeInfoOption.do',
        data: {"bibctrlno":bibctrlno},
        type: 'POST',
        async: false,   // 다완료 되고 가야한다.
        dataType: 'text',
        cache: false,
        success: function(rtnXml) {
        	   
        	xmlList = $(rtnXml).find('item');

        	html2="";
        	html2 += '<select id="searchCondition" name="years" title="년도별" onchange="fn_won(this.value)">';
			if(xmlList.length > 0){
				//총페이지수
								
				xmlList.each(function(cnt){
			
					var obj = $(this);
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
// 					if(selectValue == obj.find('years').text()){
// 						html2 +='<option  value='+obj.find('years').text()+' selected="selected">'+obj.find('years').text()+'</option>';
// 					}
					html2 += '<option value='+obj.find('years').text()+'>'+obj.find('years').text()+'</option>';
					if(cnt == 0){
						selectValue = obj.find('years').text();
					}
		        });
				html2 += '</select>';
				
				$('#ab').html(html2);
			}else{
				html2 += '<option value="선택">선택</option>';
				html2 += '</select>';
				$('#ab').html(html2);
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}

function fn_goJournal(str_bibctrlno){
	var form = document.junalForm;
	$('#bibctrlnoLink').val(str_bibctrlno);
	form.action = "${ctxt}/elib/kom/junalHistory.do";
	form.submit();
}

function fn_won(selectValue){
	
	var params = {};
	params.bibctrlno = bibctrlno;
	params.selectValue = selectValue;
	
	$.ajax({
        url: '${ctxt}/mlib/mlibTapView2.do',
        data: params,
        type: 'POST',
        dataType: 'text',
        cache: false,
        async: false,
        success: function(rtnXml) {
        	   
        	xmlList = $(rtnXml).find('item');

        	html="";
			if(xmlList.length > 0){
				//총페이지수
								
				xmlList.each(function(cnt){
			
					var obj = $(this);
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					  
					  
					html += '<tr>';
					
					html += ' <td style="text-align: center" >'+obj.find('volumename').text() +'</td>';
					
					html += ' <td style="text-align: center;" >'+obj.find('pubdate').text()+ '</td>';
					
					html += ' <td style="text-align: center" >'+obj.find('indate').text() + '</td>';
					
					html += ' <td style="text-align: center" >'+obj.find('mtrlstatus').text() + '</td>';
					
					html += '<td></td>';
					
					html += '</tr>';
					 
		        });
			    $("#bodyInfo").html(html);
			    
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

$(window).load(function(){
	if( $('img').hasClass('bkImg') != true ){
		$(".bookthumImg").remove();
	}
});

var print_acsno = "";
var print_callno = "";
function fn_tapView(){
	
	$.ajax({
     url: '${ctxt}/mlib/mlibTapView.do',
     data: {"bibctrlno":bibctrlno},
     type: 'POST',
     dataType: 'text',
     cache: false,
     async: false,
     success: function(rtnXml) {

     	xmlList = $(rtnXml).find('item');

     	html="";
     	
			if(xmlList.length > 0){
				//총페이지수
				var rowChk = 0;		
				xmlList.each(function(cnt){
						
					var obj = $(this);
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					
					//연속간행물에서는 등록번호가 WS랑 ES로 시작되는것만 보이도록. 
					if(obj.find('acsno').text().substring(0,2) == 'WS' || obj.find('acsno').text().substring(0,2) == 'ES'){		
						var reserve = obj.find('reserve').text();
						
						html += '<tr>';
						
						html += ' <td style="text-align: center" >'+obj.find('acsno').text() +'</td>';
						print_acsno += obj.find('acsno').text() + '<br>';
						
						html += ' <td style="text-align: left;" >'+obj.find('callno').text()+ '</td>';
						if(cnt == 0){
							print_callno = 	obj.find('callno').text();
						}
						
						html += ' <td style="text-align: center" >'+obj.find('volumeno').text() + '</td>';
						
						html += ' <td style="text-align: center" >'+obj.find('mtrlstatus').text() + '</td>';
						
						html += ' <td style="text-align: center" >'+obj.find('bookcasetype').text() + '</td>';
	
						if(reserve == '예약가능' ){
							html += ' <td style="text-align: center" ><a href = "javascript:void(0)" onclick = "javascript:fn_rsvReq(\''+obj.find('acsno').text()+'\')" >'+ reserve + '</a></td>';
						}else{
							html += ' <td style="text-align: center" >'+ reserve + '</td>';	
						}
						
						html += '</tr>';
						rowChk++; 
					}
					
					
		        });
				//연속간행물에서는 등록번호가 WS랑 ES로 시작되는것만 보이도록.  없으면 표시
			
				if(rowChk == 0 ){
					html+='<tr><td colspan="6" style="text-align: center" >조회된 내용이 없습니다.</td></tr>';
				}
				
			    $("#bodyInfo1").html(html);
			  	$("#print_acsno").html(print_acsno);
				$("#print_callno").html(print_callno);
			
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$("#bodyInfo1").html('<tr><td colspan="6" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
     },
     error : function(){                              // Ajax 전송 에러 발생시 실행
       fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
     }
 });
} 

function fn_printShow(){
	$("#print_hidden").show();
	
}


function print2(printArea)
{
		printArea = $("#print_hidden").html();
		
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
		/* win.document.write('<link rel="stylesheet" href="${ctxt}/resources/css/ncmik/KoreaOpenMed.css" type="text/css" />');   */
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



function go_DetailView(bibctrlno,sub){
	var parameterName = "${_csrf.parameterName}";
	var token = "${_csrf.token}";
	location.href = "${ctxt}/mlib/mlibView05.do?bibctrlno="+bibctrlno+"&"+parameterName+"="+token+"&sub="+sub;
}



function fn_rsvReq(acsNoP) {
	
	//#' + idAlias
	var isLogin  = "<c:out value='${userVo.loginid}'/>";
	if (isLogin == "") {
		if (confirm("예약 기능을 선택하실 경우 로그인 하셔야합니다.\n로그인 화면으로 이동하시겠습니까?")) {
			location.href = "${ctxt}/login/user/login.do?returnURL=/mlib/mlibView05.do?bibctrlno="+bibctrlno;
			return;
		} else {
			return;
		}
	}
	
	if (confirm("해당 도서를 예약 하시겠습니까 ?")) {
		var acsNo = acsNoP;
		$.ajax({
			url : "${ctxt}/mylib/loan/landStatRes.do",
			data : {
				acsnokind : acsNo,
				acsno : acsNo
			},
			type : "post",
			dataType : "json",
			success : function(args) {
				if (args.isSuc == "1") {
					alert("정상적으로 예약 완료되었습다.");
				} else if (args.isSuc == "2") {
					alert("이미 예약하셨습니다.\n예약내역을 확인 바랍니다.");
				} else if (args.isSuc == "3") {
					alert("도서 대출한도는 " + args.loanCnt + "권 입니다.\n대출내역을 확인 바랍니다.");
				}
				fn_tapView();
			}
		});
	}
} 
 

</script>
<style>
.basic_table>tbody>tr:last-child{
	border-bottom:0;
}
.bkImg{
	width:80%;
}

@media (max-width: 768px){
	#bibElement {
	    font-size: 11px;
	    width:100%;
	}
	.bookthumImg{
		width:100%;
		text-align:center;
	}
	.bkImg{
		width:40%;
	}
	#searchCondition{
		font-size: 11px;
    	min-width: 45px;
	}
	
}

@media (max-width: 600px){
    #printButton{
    	display:none;
   	}
}

</style>
<form name="reqForm" method="post">
	<!-- 컨텐츠 영역 -->
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>소장자료</span>
			<span> > </span>
			<span class="active">연속간행물</span>        			      
		</div>
		<span class="center_text_01">연속간행물 상세</span>
	</div> 
	<div class="under_bar"></div>
	
	<div  class= "content_wrap">
		<div class="content_box">
			<div class="content_list">
			
			<div class="selectbox_wrap1" style="height:30px; position:relative; margin:0; padding-top:0;float: right; width: 100px;">									
				<button id = "printButton" onclick="javascript:fn_printShow();" style="padding:0 10px 0 0; vertical-align:middle;" type="button" class="print-preview print_h print_btn" >Print<i class="fas fa-print"></i></button>
			</div>
			
				<div class="list_title">
					<p><c:out value='${mlibVo.title}'/></p>
				</div>
				<div id="bibContent">
					<div id="JOU_bigbox">
		
						<!-- 서지 요소상세 영역 -->
						<div id="bibElement"> 
           					<!--  연속간행물 -->
							<%-- <c:if test="${not empty mlibVo.acronymTtitle}">
								<dl>
									<dt>축약표제</dt>
									<dd>${mlibVo.acronymTtitle}</dd>
								</dl>
							</c:if>
							<c:if test="${not empty mlibVo.abbreviationTtitle}">
								<dl>
									<dt>기타표제</dt>
									<dd>${mlibVo.abbreviationTtitle}</dd>
								</dl>
							</c:if> --%>
							
							<c:if test="${not empty mlibVo.alternativetitle}">	
								<dl>
									<dt>대등서명</dt>
									<dd>${mlibVo.alternativetitle}</dd>
								</dl>
						    </c:if>
						    
						    <c:if test="${not empty mlibVo.abbreviationTtitle}">	
								<dl>
									<dt>약어명</dt>
									<dd>${mlibVo.abbreviationTtitle}</dd>
								</dl>
						    </c:if>
						    
						    <c:if test="${not empty mlibVo.startYear}">	
								<dl>
									<dt>창간/폐간연도</dt>
									<dd>${mlibVo.startYear}</dd>
								</dl>
						    </c:if>
							
							<c:if test="${not empty mlibVo.publisher}">
								<dl>
									<dt>발행처</dt>	
									<dd><c:out value='${mlibVo.publisher}' /></dd>
								</dl>
							</c:if>
							
							<c:if test="${not empty mlibVo.pages || not empty mlibVo.illustrativecontent || not empty mlibVo.extent}">
								<dl>
									<dt>형태사항</dt>
									<dd>${mlibVo.pages}&nbsp;:${mlibVo.illustrativecontent };${mlibVo.extent }</dd>
								</dl>
							</c:if>
							
							<c:if test="${not empty mlibVo.publicationFrequencyNote}">
								<dl>
									<dt>간행빈도</dt> 
									<dd><c:out value='${mlibVo.publicationFrequencyNote }' /></dd>
								</dl>
							</c:if>
							
							<c:if test="${not empty mlibVo.language}">
								<dl>
									<dt>언어</dt> 
									<dd><c:out value='${mlibVo.language }' /></dd>
								</dl>
							</c:if>
							
							<c:if test="${not empty mlibVo.description}">
								<dl>
									<dt>주기사항</dt>	
									<dd><c:out value='${mlibVo.description }' /></dd>
								</dl>
							</c:if>
							
							<c:if test="${not empty mlibVo.pissn || not empty mlibVo.eissn || not empty mlibVo.doi}">
								<dl>
									<dt>표준번호</dt>
									<c:if test="${not empty mlibVo.pissn}">		
										<dd>
											<c:out value='${mlibVo.pissn}' />(print)
										</dd>
									</c:if>
									<c:if test="${not empty mlibVo.eissn}">		
										<dd>
											<c:out value='${mlibVo.eissn}' />(electronic)
										</dd>
									</c:if>
									<c:if test="${not empty mlibVo.doi}">		
										<dd>
											<c:out value='${mlibVo.doi}' />(DOI)
										</dd>
									</c:if>
								</dl>
						   </c:if>
						   
						   <c:if test="${not empty mlibVo.continues}">
								<c:set value="${fn:split(mlibVo.continues,':')}" var="continuesSp" />
								<dl>
									<dt>선행저록</dt>	
								    <%-- <dd>${continuesSp[0]}</dd> --%>
								    <dd><a href="javascript:go_DetailView('${continuesSp[1]}','inPeriod')">${continuesSp[0]}</a></dd>
								</dl>
							</c:if>
							
							<c:if test="${not empty mlibVo.continuedBy}">
								<c:set value="${fn:split(mlibVo.continuedBy,':')}" var="continuedBySp" />
								<dl>
									<dt>후행저록</dt>
									<%-- <dd>${continuedBy[0]}</dd> --%>	
									<dd><a href="javascript:go_DetailView('${continuedBySp[1]}','inPeriod')">${continuedBySp[0]}</a></dd>
								</dl>
							</c:if>
							
							<c:if test="${not empty mlibVo.linkoutURL || not empty mlibVo.ncmikid}">
								<dl>
									<dt>링크주소</dt>	
									
									<c:if test="${not empty mlibVo.ncmikid}">
										<%-- <dd><a href="#" onclick="" title="이동">http://library.nih.go.kr/<fmt:parseNumber value="${mlibVo.ncmikid}" type="number"/></a></dd> --%>
										<dd>
										<a href="javascript:fn_goJournal('${mlibVo.bibctrlno}');">http://library.nih.go.kr/${mlibVo.ncmikid}</a>									
										</dd>
									</c:if>
									
									<c:if test="${not empty mlibVo.linkoutURL}">
										<c:forTokens items="${mlibVo.linkoutURL}" delims="," var="linkoutURL"  varStatus="status">
											<dd>
												<%-- <a href="<c:out value="${linkoutURL}" />" target="_blank"  rel="noopener noreferrer" title="새창"><c:out value="${linkoutURL}" /></a> --%>
													<a href="<c:out value='${linkoutURL}' />" target="_blank" rel="noopener noreferrer"  title="새창"><c:out value="${linkoutURL}" /></a><br/>
											</dd>
										</c:forTokens>
									</c:if>
								
								</dl>
							</c:if>
						 	 
						 	 <!-- MeSH 주제어표제 -->
						 	 <c:if test="${not empty mlibVo.meshTopicalDesc}">
								 <dl>
									<dt>MeSH</dt>
									<c:forTokens items="${mlibVo.meshTopicalDesc}" delims=";" var="valueMeSHTopicalDesc"  varStatus="status">
										<dd>
											<%-- <a href="#"><c:out value="${valueMeSHTopicalDesc}" /></a> --%>
											<c:out value="${valueMeSHTopicalDesc}" />
										</dd>
								 	</c:forTokens>
								 </dl>
						 	 </c:if>
						 	 
						 	 <c:if test="${not empty mlibVo.wordsubject}">
								 <dl>
									<dt>일반주제</dt>
									<dd>
										<c:out value='${mlibVo.wordsubject}'/>
									</dd>
								 </dl>
						 	 </c:if>
							
							<c:if test="${not empty mlibVo.authorno || not empty mlibVo.kdcValue || not empty mlibVo.nlmc}">
								 <dl>
									<dt>도서기호</dt>
										<dd><c:out value='${mlibVo.kdcValue}'/><c:out value='${mlibVo.nlmc}'/>&nbsp;<c:out value='${mlibVo.authorno}'/> </dd>
								 </dl>
						    </c:if>
						    
							<!--선행저록,후행저록 링크이동시에만 보여줌 -->
						    <c:if test="${sub eq 'inPeriod'}"> 
						    	<dl>
									<dt>KNLM ID</dt>
										<dd><c:out value='${mlibVo.ncmikid}'/></dd>
								 </dl>
						    </c:if>
						    
							
							<%-- <c:if test="${not empty mlibVo.keyword}">
								<dl style="border-bottom:0;">
									<dt>주제</dt>	
									<dd>${mlibVo.keyword }</dd>
								</dl>
							</c:if> --%>
						 	<input type="hidden" name="pageIndex" id="pageIndex" value="1">
							<input type="hidden" name="searchCondition" id="searchCondition" value="title">
							<input type="hidden" name="searchKeyword" id="searchKeyword" value="">
							<input type="hidden" name="bibctrlno" id="bibctrlno" value="<c:out value='${mlibVo.bibctrlno}'/>">
						</div>
					</div>
					
				
				<c:if test="${sub ne 'inPeriod'}">
					<div class="tab-group mlibView" style="margin:40px auto 10px auto;">
								<ul class="tabs">
							        <li class="active" rel="tab1" style="width:20%; box-sizing:border-box; color:#003964;">소장정보</li>
							        <li rel="tab2" style="width:20%; box-sizing:border-box;"><!-- 보고서(발행년도) -->제본정보</li>
							        <li rel="tab3" style="width:20%; box-sizing:border-box;"><!-- 보고서(발행년도) -->권호정보</li>
							        <li rel="tab4" style="width:20%; box-sizing:border-box;"><!-- 보고서(발행년도) -->원문정보</li>
								</ul>
							    <div class="tab_container" style="width:100%;">
							        <!-- <div id="tab1" class="tab_content"> -->
							        	<table  id="tab1" class="basic_table tab_content" style="border-top:0;" cellspacing="0" cellpadding="0" style=" table-layout: fixed; margin: 0 0 0 0" summary="번호, 등록번호, 청구기호, 배가위치, 도서상태, 반납예정일, 예약 정보를 가지고 있는 소장정보 테이블 입니다.">
											<caption>소장정보 표</caption>
											<colgroup>
												<col width="20%">
												<col width="20%"> 
												<col width="*">
												<col width="10%">	
												<col width="15%">
												<col width="10%">
											</colgroup>
											<thead>
												<tr>
													<th scope="col">등록번호</th>
													<th scope="col">청구기호</th>
													<th scope="col">권차사항</th>
													<th scope="col">자료상태</th>
													<th scope="col">배가위치</th>
													<th scope="col">예약</th>
												</tr>
											</thead>
											<tbody id="bodyInfo1"></tbody>
										</table>
							        <!-- </div> -->
							        <!-- #tab1 -->
							        <div id="tab2" class="tab_content">
							        </div>
							         <!-- #tab2 -->
							        <div id="tab3" class="tab_content">
							        <table class="basic_table" cellspacing="0" cellpadding="0" style="border-top:0; table-layout: fixed; margin: 0 0 0 0" summary="번호, 등록번호, 청구기호, 배가위치, 도서상태, 반납예정일, 예약 정보를 가지고 있는 소장정보 테이블 입니다.">
							        <colgroup>
								        <col width="*">
										<col width="20%">
										<col width="20%">
										<col width="15%">
										<col width="15%">
									</colgroup>
									<thead>
									<tr>
										<th scope="col">권호</th>
										<th scope="col">발행일</th>
										<th scope="col">입수일</th>
										<th scope="col">자료상태</th>
										<th scope="col" id="ab"></th>
									</tr>
									</thead>
											<tbody id="bodyInfo"></tbody>
										</table>
							        </div>
							         <!-- #tab2 -->
							        <div id="tab4" class="tab_content">
	        								<a href="${ctxt}/search/AdvancedSearch?query=<c:out value='${mlibVo.title}'/>" class="basic-btn" >원문보기</a>									        
							        </div>
							         <!-- #tab2 -->
								</div> 
					</div>
				</c:if>	
					
						
				</div>
				<div class="btn-group">			
					<a href="javascript:history.back();"  style="float: right;margin-bottom:10px;"  class="basic-btn">목록</a>
				</div> 
				<!-- 컨텐츠 영역 -->
			</div>
		</div>

<div id = "print_hidden" >
		<div style="width: 100%; text-align: center; border-bottom: dotted; padding-bottom: 15px;">[자료위치 안내]</div>
		<table style = "width:100%;">
           <caption>프린트영역</caption>
            <colgroup>
			<col width='30%' />						
			<col width='80%' />								
			</colgroup>
		<tbody>
			<tr>
				<th scope='row' style="text-align: left;">청구기호</th>
				<td id = "print_callno"></td>							
			</tr>
			<tr>
				<th scope='row' style="text-align: left;">서명</th>
				<td><c:out value='${mlibVo.title}'/></td>							
			</tr>
			<tr>
				<th scope='row' style="text-align: left;">소장사항</th>
				<td></td>							
			</tr>
			<tr>
				<th scope='row' style="vertical-align: top; text-align: left;">등록번호</th>
				<td id = "print_acsno"></td>							
			</tr>	
		</tbody>
        </table>
        <div style="height:50px;">
        </div>		
</div>


	</div>




<!-- 처리 메세지 PARAM -->
	<input type="hidden" id="message" name="message" value="<c:out value='${message}'/>" alt="message">	

    <!-- 검색 PARAM -->
	<input type="hidden" id="page" name="page" value="<c:out value='${resultVO.page}'/>" alt="pageNum" />
	<input type="hidden" id="searchCondition" name="searchCondition" value="<c:out value='${resultVO.searchCondition}'/>"  alt="검색콤보" />
	<input type="hidden" id="searchKeyword" name="searchKeyword" value="<c:out value='${resultVO.searchKeyword}'/>" alt="검색어" />
	
	
	
</form>


<form id="junalForm" name="junalForm" method="post" action="" >
	<input type="hidden" id="bibctrlnoLink" name="bibctrlno" value="" />
	<input type="hidden" id="page" name="page" value="" />
</form>  
