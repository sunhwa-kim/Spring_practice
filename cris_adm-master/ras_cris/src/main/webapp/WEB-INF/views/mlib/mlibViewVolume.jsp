<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="BOOK_GOOGLE_KEY" value="AIzaSyCXpuS-S_8MAGBv_s-c8FIlZyoA_OGrYHI" /> <!-- Google(imjholee) Real Key -->
<!-- 차트 구성 SCRIPT STR-->
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
var bibctrlno='${mlibVo.bibctrlno}'; 

$(function(){

	// 프린트
	$('.print-preview').printPreview();
	// 프린트 할 영역 숨기기 
	$("#print_hidden").hide();

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
						,"key" : "${BOOK_GOOGLE_KEY}"
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
	
	
	
	$("a.tab-btn").eq(0).addClass("active").css("color", "#003964");
    $("a.tab-btn").click(function () {
        $("a.tab-btn").removeClass("active").css("color", "#7f7f7f");       
        $(this).addClass("active").css("color", "#003964");
    });
	
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
					 
		        });
			    $("#bodyInfo").html(html);
			  	$("#print_acsno").html(print_acsno);
				$("#print_callno").html(print_callno);
			
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$("#bodyInfo").html('<tr><td colspan="6" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
     },
     error : function(){                              // Ajax 전송 에러 발생시 실행
       fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
     }
 });
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

function fn_printShow(){
	$("#print_hidden").show();
	
}

//원문정보
function fileView(bibCtrlNo) {
	
	var contextName = "ncmik";
	var atchFileId = "";
	var pageTitle = "";
	
	$.ajax({url: '${ctxt}/cmm/fms/selectTFFileSch.do',
        data:{"bibCtrlNo":bibCtrlNo},
	 	type: 'POST',
	 	cache: false,   
        success: function(rtnXml) {
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
				alert("원문정보가 존재 하지 않습니다.");
			}
      	}
 	});
}
 
function fn_rsvReq(acsNoP) {
	
	//#' + idAlias
	var isLogin  = "<c:out value='${userVo.loginid}'/>";
	if (isLogin == "") {
		if (confirm("예약 기능을 선택하실 경우 로그인 하셔야합니다.\n로그인 화면으로 이동하시겠습니까?")) {
			location.href = "${ctxt}/login/user/login.do?returnURL=/mlib/mlibView03.do?bibctrlno="+bibctrlno;
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
 
 
$(window).load(function(){
	if( $('img').hasClass('bkImg') != true ){
		$(".bookthumImg").remove();
	}
}); 


</script>
<style>
.basic_table>tbody>tr:last-child, #bibElement>dl:last-child{
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
			<span class="active">단행본</span>        			      
		</div>
		<span class="center_text_01">단행본 상세</span>
	</div> 
	<div class="under_bar"></div>	
		
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
		<div class="selectbox_wrap1" style="height:30px; position:relative; margin:0; padding-top:0; float: right; width: 100px;">									
			<button id ="printButton" onclick="javascript:fn_printShow();" style="padding:0 10px 0 0; vertical-align:middle;" type="button" class="print-preview print_h print_btn" >Print<i class="fas fa-print"></i></button>
		</div>

				<div class="list_title">
					<p>
					<c:choose>  
						<c:when test = "${not empty mlibVo.subtitle}"  >
							${mlibVo.title}<br />&nbsp;&nbsp;&nbsp;&nbsp;${mlibVo.subtitle}
						</c:when>
						<c:otherwise>
							${mlibVo.title}
						</c:otherwise>
					</c:choose>
					</p>
				</div>
				
				<div id="bibContent">
					<div id="JOU_bigbox">
						
						<!-- 서지 요소상세 영역 -->
						<div id="bibElement" class="view_dl_box"> 
				        <!--  단행본 -->
						<c:if test="${not empty mlibVo.subtitle}">	
							<dl>
								<dt>부표제</dt>
								<dd>${mlibVo.subtitle}</dd>
							</dl>
						</c:if>
						
						<c:if test="${not empty mlibVo.alternativetitle}">	
							<dl>
								<dt>대등표제</dt>
								<dd>${mlibVo.alternativetitle}</dd>
							</dl>
						</c:if>
						
						<c:if test="${not empty mlibVo.varianttitle}">	
							<dl>
								<dt>이형표제</dt>
								<dd>${mlibVo.varianttitle}</dd>
							</dl>
						</c:if>
						
						<c:if test="${not empty mlibVo.orginal}">	
							<dl>
								<dt>원서명</dt>
								<dd>${mlibVo.orginal}</dd>
							</dl>
						</c:if>
						
						<c:if test="${not empty mlibVo.firstauthor || not empty mlibVo.author}">
							<dl>
								<dt>저자</dt>	
								<c:choose>
									<c:when test="${mlibVo.firstauthor eq null || mlibVo.firstauthor eq ''}">
										<c:choose>
											<c:when test="${mlibVo.author eq null || mlibVo.author eq ''}">
												<dd></dd>
											</c:when>
											<c:otherwise>
												<dd>${mlibVo.author}</dd>
											</c:otherwise>
										</c:choose>	
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${mlibVo.author eq null || mlibVo.author eq ''}">
												<dd>${mlibVo.firstauthor}</dd>
											</c:when>
											<c:otherwise>
												<dd>${mlibVo.firstauthor}&nbsp;;${mlibVo.author}</dd>
											</c:otherwise>
										</c:choose>	
									</c:otherwise>
								</c:choose>
							</dl>
						 </c:if>
						 
						  <c:if test="${not empty mlibVo.edition}">
							<dl>
								<dt>판사항</dt>	
								<dd>${mlibVo.edition}</dd>
							</dl>
						  </c:if>
						  
						 <c:if test="${not empty mlibVo.placeofpublication || not empty mlibVo.publisher || not empty mlibVo.dateissued}">
							<dl>
								<dt>발행사항</dt>
								<dd>${mlibVo.placeofpublication}&nbsp;:${mlibVo.publisher},&nbsp;${mlibVo.dateissued}</dd>
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
									<dd>${mlibVo.publicationFrequencyNote }</dd>
								</dl>
						</c:if>
						
						<c:if test="${not empty mlibVo.language}">
							<dl>
								<dt>언어</dt> 
								<dd>${mlibVo.language }</dd>
							</dl>
						</c:if>
						
						<c:if test="${not empty mlibVo.seriesTitle}">
							<dl>
								<dt>총서사항</dt> 
								<dd>${mlibVo.seriesTitle }</dd>
							</dl>
						</c:if>
						
						<c:if test="${not empty mlibVo.description}">
							<dl>
								<dt>주기사항</dt>	
								<dd>${mlibVo.description }</dd>
							</dl>
						</c:if>
						
						<c:if test="${not empty mlibVo.isbn10 || not empty mlibVo.isbn13 || not empty mlibVo.pissn || not empty mlibVo.eissn}">
							<dl>
								<dt>표준번호</dt>
								<c:if test="${not empty mlibVo.isbn10}">
									<dd>
										${mlibVo.isbn10 }
									</dd>
								</c:if>
								<c:if test="${not empty mlibVo.isbn13}">				
									<dd>
										${mlibVo.isbn13 }
									</dd>
								</c:if>
								<c:if test="${not empty mlibVo.pissn}">		
									<dd>
										${mlibVo.pissn }(print)
									</dd>
								</c:if>
								<c:if test="${not empty mlibVo.eissn}">		
									<dd>
										${mlibVo.eissn }(electronic)
									</dd>
								</c:if>
							</dl>
						 </c:if>
						 
						 <c:if test="${not empty mlibVo.grantId || not empty mlibVo.reportNo}">
							 <dl>
								<dt>표준번호</dt>
								<dd>
									${mlibVo.grantId}${mlibVo.reportNo}
								</dd>
							 </dl>
						 </c:if>

						 <!-- MeSH 주제어표제 -->
						 <c:if test="${not empty mlibVo.meshTopicalDesc}">
							 <dl>
								<dt>주제어</dt>
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
									${mlibVo.wordsubject}
								</dd>
							 </dl>
						 </c:if>
						 
						 <c:if test="${not empty mlibVo.linkoutURL}">
							 <dl>
								<dt>원문정보</dt>
									<c:forTokens items="${mlibVo.linkoutURL}" delims="," var="linkoutURL"  varStatus="status">
										<dd>
											<%-- <a href="<c:out value="${linkoutURL}" />" target="_blank"  rel="noopener noreferrer" title="새창"><c:out value="${linkoutURL}" /></a> --%>
											<c:out value="${linkoutURL}" />
										</dd>
									</c:forTokens>
							 </dl>
						 </c:if>
						 
						 <c:if test="${not empty mlibVo.authorno || not empty mlibVo.kdcValue || not empty mlibVo.nlmc}">
							 <dl>
								<dt>도서기호</dt>
								<dd>${mlibVo.kdcValue}${mlibVo.nlmc}&nbsp;${mlibVo.authorno} </dd>
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
					<input type="hidden" name="bibctrlno" id="bibctrlno" value="${mlibVo.bibctrlno}">
					<%-- <input type="hidden" name="a" id="a" value="${a}"> --%>
				 
						</div>
				
				
						<!-- 북 커버 이미지 영역 -->		
						<div class="bookthumImg"> 
							<c:choose>
								<c:when  test="${not empty mlibVo.isbn10}">
									<input type="hidden" class="bibISBN" value="${mlibVo.isbn10 }">				
								</c:when>
								<c:otherwise>
									<input type="hidden" class="bibISBN" value="${mlibVo.isbn13 }">
								</c:otherwise>
							</c:choose>
							<img alt="Performance standards for antimicrobial disk and dilution susceptibility tests for bacteria isolated from animals" src="${ctxt}/resources/images/sub/noimage.jpg" style="margin-left: 1px; margin-top: 1px; display: none;" width="65" height="93">
						</div>	
						
					</div>
					<!-- 서지 소장정보 영역 -->
					<div class="tab-group mlibView" style="margin:40px auto 10px auto;">
								<ul class="tabs">
							        <li class="active" rel="tab1" style="width:20%; box-sizing:border-box; color:#003964;">소장정보</li>
									<!-- <li rel="tab2" style="width:15%; box-sizing:border-box;">원문정보</li> 2018.11.06 단행본 원문정보 숨김(사용안함)-->
								</ul>
							    <div class="tab_container" style="width:100%;">
							        	<table id="tab1" class="basic_table tab_content" cellspacing="0" cellpadding="0" style=" table-layout: fixed; margin: 0 0 0 0" summary="번호, 등록번호, 청구기호, 배가위치, 도서상태, 반납예정일, 예약 정보를 가지고 있는 소장정보 테이블 입니다.">
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
											<tbody id="bodyInfo"></tbody>
										</table>
							        <!-- #tab1 -->
							        <div id="tab2" class="tab_content">
	        								<a href="javascript:fileView('${mlibVo.bibctrlno}');" class="basic-btn" >원문보기</a>									        
							        </div>
							         <!-- #tab2 -->
								</div> 
					</div>
				
				<div class="btn-group">			
					<a href="javascript:history.back();"  style="float: right;margin-bottom:10px;"  class="basic-btn">목록</a>
				</div> 
				<!-- 컨텐츠 영역 -->
			</div>
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
				<td>${mlibVo.title}</td>							
			</tr>
			<tr>
				<th scope='row' style="text-align: left;">저자</th>
					<c:choose>
						<c:when test="${mlibVo.firstauthor eq null || mlibVo.firstauthor eq ''}">
							<c:choose>
								<c:when test="${mlibVo.author eq null || mlibVo.author eq ''}">
									<td></td>
								</c:when>
								<c:otherwise>
									<td>${mlibVo.author}</td>
								</c:otherwise>
							</c:choose>	
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${mlibVo.author eq null || mlibVo.author eq ''}">
									<td>${mlibVo.firstauthor}</td>
								</c:when>
								<c:otherwise>
									<td>${mlibVo.firstauthor}&nbsp;;${mlibVo.author}</td>
								</c:otherwise>
							</c:choose>	
						</c:otherwise>
					</c:choose>
			</tr>
			<tr>
				<th scope='row' style="padding-bottom: 50px; text-align: left;">발행사항</th>
				<td style="padding-bottom: 50px;">${mlibVo.placeofpublication}&nbsp;:${mlibVo.publisher},&nbsp;${mlibVo.dateissued}</td>							
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
	<input type="hidden" id="message" name="message" value="${message}" alt="message">	

    <!-- 검색 PARAM -->
	<input type="hidden" id="page" name="page" value="${resultVO.page}" alt="pageNum" />
	<input type="hidden" id="searchCondition" name="searchCondition" value="${resultVO.searchCondition}"  alt="검색콤보" />
	<input type="hidden" id="searchKeyword" name="searchKeyword" value="${resultVO.searchKeyword}" alt="검색어" />
	
	<!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" />
	
	
	
	
	
</form>
