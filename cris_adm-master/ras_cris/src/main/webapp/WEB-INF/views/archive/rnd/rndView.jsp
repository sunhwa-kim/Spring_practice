<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 차트 구성 SCRIPT STR-->
<script type="text/javascript" src="${ctxt}/resources/js/chart/jui/jquery-ui.min.js"></script>
<script type="text/javascript" src="${ctxt}/resources/js/chart/jui/core.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctxt}/resources/js/chart/jui/chart.js" ></script>
<%-- <link rel="stylesheet" href="${ctxt}/resources/js/chart/jui/jquery-ui.min.css" /> --%>
<!-- 차트 구성 SCRIPT END-->
<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn", "\n"); //Space, Enter
      pageContext.setAttribute("br", "<br/>"); //br 태그
%> 

<script type="text/javascript">
   
var lookBoolean = true;  
var returnGbn ='';
$(function(){
	if($("#message").val() != ''){
		var msg = $("#message").val();
		if(msg == 'fail'){
			alert("저장에 실패하였습니다.");
		}else if(msg =='success'){
			alert("저장이 완료 되었습니다.");
		}else if(msg =='login'){
			alert("로그인을 수행해 주십시오.");
		}
    }
    $("#message").val('');
    
	if($("#returnPageGbn").val() != ''){
		returnGbn = $("#returnPageGbn").val();
	}

	
	// 권한에 따라 화면 view 와 버튼 제어
	var auth_control = $("#archive_auth_gbn").val();	

	if(auth_control == "on"){
		$('table').remove( '#userOn' );	
	}else{
		$('table').remove( '#userOff' );
		$('#btn_gbn').attr('style','display:none;');
	}
	
	fn_chartGrid();

});

// 차트 그리기
function fn_chartGrid(){
	
	var chart = jui.include("chart.builder");
	
	chart("#gridChart", {
		width : 400,
		height : 300,
		padding : {
// 			left:30,
			top : 20
		},
	    axis : {
	        x : {
	            type : "block",
	            domain : "quarter",
	            line : true
	        },
	        y : {
	            type : "range",
	            domain : function(d) {  return  chartMax(d.count); },
	            step : 5,
	            line : true,
	            orient : "left"
	        },
	        data : [
	            { quarter : "View", count : $("#rdcnt").val() },
	            { quarter : "Download", count : $("#downcnt").val() },
	        ]
	    },
	    brush : {
	        type : "column",
	        size : 50,
	        target : [ "count" ]
	    },
	    widget : [
	    /* 	{ type : "title", text : "Column Sample" }, */
	        { type : "tooltip" }
        /* 	{ type : "legend" } */
	    ]
	});
	
}

function fileView() {
	
	var atchLinkId = $("#atch_link_id").val();
	var rnd_id = $("#rnd_id").val();
	var contextName = "ncmik";
	var fileKey = atchLinkId;
	var pageTitle = "";
	
	if($("#atc_title_kor").val() != ""){
		pageTitle = $("#atc_title_kor").val();
	}else{
		pageTitle = $("#atc_title_eng").val();
	}

	fn_downloadUpdate(fileKey, contextName, pageTitle , rnd_id , 'rnd');
}


// 초록 DIV의 더보기 / 닫기 버튼 
function fn_openDiv(){
	
	if(lookBoolean == true){
		
		$("#divEtcarea").html($("#rnd_abs").html());		
		lookBoolean = false;
		
		$("#moreAbs").text("close");
		
	}else if(lookBoolean == false){
	
		$("#divEtcarea").html($("#rnd_abs").html().substring(0,1000)+"....");
		lookBoolean = true;
		
		$("#moreAbs").text("more +");
			
	}

}

function fn_returnPage(param){  
	
	var form = document.reqForm;
	
	var returnPage ='';
	
	if("<c:out value='${returnSearchPageGbn}'/>" == 'T'){
	
		history.back(-1);
		
		return false;
    }	

	if(param == 'R'){
		if(returnGbn != ''){
			if(returnGbn == 'aMain'){ // 아카이브 메인 우측 목록에서 옴. - 메인으로 이동
				returnPage = form.returnArchiveMainPage.value;
			}else if(returnGbn == 'recently'){ // 아카이브 recently , download  목록에서 옴 - 해당 목록으로 이동 
				returnPage = form.returnRecentlyPage.value;
			}else if(returnGbn == 'download'){
				returnPage = form.returnDownloadPage.value;			
			}		
		}else{
			returnPage = form.returnListPage.value;
		}
	}else if(param == 'U'){
	    	returnPage= "${ctxt}/archive/rnd/rndEdit.do";
    }
	
	form.action = returnPage;
	form.submit();	
}

//첨부 파일 다운로드
function fn_downLoad(file_sn){	

	var downform = document.downForm;
	downform.action = '${ctxt}/archive/rnd/downFile.do?down_file_sn='+file_sn;
	downform.submit();
}	

// 연계과제 > 연구과제 클릭시 상세로 이동
function fn_detailReport(u, idParam){
	
	var detailForm = document.detailForm;
	
	detailForm.rep_id.value = idParam;
	detailForm.upd_yn.value = u;
	
	detailForm.submit();
}

function fn_authorSearch(au){
	var form = document.reqForm;	
	form.searchCondition.value = 'AUTHOR';
		form.searchKeyword.value = au;
	form.action = "${ctxt}/archive/rnd/rndList.do";	
	form.submit();	
}

</script>

<style>
.padding_none_box{
	width:100%;
}
.padding_none_box:after{
	clear:both;
	displayL:block;
	content:"";
}
.padding_none_box>p{
	width:25%;
	display:inline-block;
	float:left;
	padding:0;
	margin:0;
}
.padding_none_box>p:nth-child(2n-1){
	background:#EBEEF0;
	text-align:center;
}
.padding_none_box>p:nth-child(2n){
	text-indent:10px;
}	
</style>
<form name="reqForm" method="post">
	<!-- 컨텐츠 영역 -->
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>아카이브</span>
			<span> > </span>
			<span class="active">성과논문</span>        			      
		</div>
		<span class="center_text_01">성과논문</span>
	</div> 
	<div class="under_bar"></div>
	<div class= "content_wrap">
	 	<div class="content_box">
			<div class="content_list">	
				<div class="list_title">
					<p id="search_cn">성과논문 상세</p>
				</div>
					<table class="view_table"  id="userOff">
						<caption>성과논문 </caption>
						<colgroup>
							<col width='17%' />						
							<col width='33%' />
							<col width='17%' />
							<col width='*' />														
						</colgroup>
						<tbody class="report">
							<tr>
								<th scope='row' class=>발행년도</th>
								<td>
									<c:out value='${resultVO.pubyear}'/>
								</td>
								<th scope='row'>성과발생년도</th>
								<td>
									<c:out value='${resultVO.occu_year}'/>
								</td>		
							</tr>
												
							<tr>
								<th scope='row'>논문명</th>
								<td colspan="3">  	
									<ul class="table_in_ul" style="padding:5px 0;">	
										<li>
											<p class="middle_content"><c:out value='${resultVO.atc_title_kor}'/></p>
										</li>
										<%-- <li>
											<p class="text middle_title">영 &nbsp; &nbsp;문</p> <p class="middle_content">${resultVO.atc_title_eng}</p>
										</li> --%>
									</ul> 
									
					            	<%-- <table class="table_in_table">
					        			<caption>논문명</caption>
										<colgroup>
											<col width='5%' />						
											<col width='95%' />								
										</colgroup>
										<tbody>
											<tr>
												<th scope='row' >국문</th>
												<td>   
													${resultVO.atc_title_kor}		
												</td>						
											</tr>
											<tr>
												<th scope='row'>영문</th>
												<td">   
													${resultVO.atc_title_eng}
												</td>						
											</tr>	
										</tbody>
									</table> --%> 								  				
								</td>																	
							</tr>	
							<tr>								
								<th scope='row'  >국내외구분</th>
								<td colspan="3">
									<input type="radio" class="radio_style2 radio" name="inoutflag" value="I" ${resultVO.inoutflag eq 'I'?'checked="checked"':''} disabled="disabled"  /> 
									<label for="inoutflag_in" class="margin_r_20">국내</label>
									<input type="radio" class="radio_style2 radio" name="inoutflag" value="O" ${resultVO.inoutflag eq 'O'?'checked="checked"':''} disabled="disabled"  />  
									<label for="inoutflag_out" class="margin_r_20">국외</label>
								</td>						
							</tr>
							<tr>
								<th scope='row'>학술지명</th>
								<td colspan="3">
									<c:out value='${resultVO.journal_nm}'/>
								</td>						
							</tr>
							<tr>
								<th scope='row'>ISSN</th>
								<td>
									<c:out value='${resultVO.rnd_issn}'/>
								</td>
								<th scope='row'>DOI</th>
								<td>
									<a href= "<c:out value='${resultVO.doi}'/>" target="_blank" rel="noopener noreferrer"><c:out value='${resultVO.doi}'/></a>
								</td>						
							</tr>
							<tr>
								<th scope='row'>주저자명(제1저자)</th>
								<td colspan="3">
									<a href= "javascript:fn_authorSearch('${resultVO.author}');">${resultVO.author} </a>
								</td>
							</tr>	
							<tr>
								<th scope='row'>공동저자</th>
								<td colspan="3">
									<c:out value='${resultVO.co_author}'/>
								</td>	
							</tr>	
							<tr>
								<th scope='row'>교신저자</th>
								<td colspan="3">
									<c:out value='${resultVO.commu_author}'/>
								</td>
							</tr>	
							<tr>
								<th scope='row'>권/호</th>
								<td colspan="3">
									<c:out value='${resultVO.volumename}'/>
								</td>							
							</tr>	
							<tr>
								<th scope='row'>논문페이지</th>
								<td colspan="3" style="padding:0;">  		
									<div class="padding_none_box">
										<p>시작페이지</p>  
										<p><c:out value="<c:out value='${resultVO.jour_str_page}'/>" default="&nbsp;" escapeXml="false"/></p>
										<p>끝페이지</p>
										<p><c:out value="<c:out value='${resultVO.jour_end_page}'/>" default="&nbsp;" escapeXml="false"/></p>
						            	<%-- <table style="width: 100%">
							              	<caption>논문페이지</caption>
											<colgroup>
												<col width='20%' />						
												<col width='30%' />
												<col width='20%' />						
												<col width='30%' />								
											</colgroup>
											<tbody>
												<tr style="border-spacing:0; border-collapse:collapse; margin:0; padding:0; box-sizing:border-box; height:100%; table-collapse">
													<th scope='row' class="border_r">논문시작페이지</th>
													<td style="padding-left:10px;">   
														${resultVO.jour_str_page}		
													</td>
													<th scope='row' class="border_b border_r" style="border-spacing:0; border-collapse:collapse; margin:0; padding:0; box-sizing:border-box; height:100%; table-collapse">논문끝페이지</th>
													<td style="padding-left:10px;">   
														${resultVO.jour_end_page}
													</td>						
												</tr>	
											</tbody>
										</table> --%>
									</div>	 								  				
								</td>																	
							</tr>	
							<tr>
								<th scope='row'  >SCI구분</th>
								<td colspan="3">
									<input type="radio" name="sci_gbn" class="radio_style2 radio" value="Y" ${resultVO.sci_gbn eq 'Y'?'checked="checked"':''} disabled="disabled"  /> <label for="sci_gbn_y" class="margin_r_20" >예</label>
									<input type="radio" name="sci_gbn" class="radio_style2 radio" value="N" ${resultVO.sci_gbn eq 'N'?'checked="checked"':''} disabled="disabled"  />  <label for="sci_gbn_n"  class="margin_r_20">아니오</label>
								</td>
							</tr>
							<tr>
								<th scope='row'  >학술지 출판일자</th>
								<td colspan="3">
									<c:out value='${resultVO.publishing_date}'/>
								</td>
							</tr>
							<tr>
								<th scope='row'  >학술지 임팩트팩터</th>
								<td colspan="3">
									<c:out value='${resultVO.impact_factor}'/>
								</td>
							</tr>
							
							<tr>
								<th scope='row'  >키워드</th>
								<td colspan="3">
									<c:out value='${resultVO.keyword}'/>
								</td>						
							</tr>	
							<tr>
								<th scope='row'  >초록</th>
								<td colspan="3" style="padding:10px 2% 15px 2%;">
								<c:choose>							
										<c:when test="${fn:length(resultVO.rnd_abs) > 1000}">
											<div id = 'divEtcarea'  style="width: 98%; line-height:150%; margin-bottom:10px; word-break:break-word;" >${fn:replace(fn:substring(resultVO.rnd_abs, 0 , 1000), crcn , br)}....</div>
											<a id="moreAbs" href="javascript:fn_openDiv()" class="amore" >more +</a> 
										</c:when>
										<c:otherwise>
									        <div id = 'divEtcarea'  style="width: 98%; word-break:break-word;">${fn:replace(fn:substring(resultVO.rnd_abs, 0 , 1000), crcn , br)}</div>
									    </c:otherwise>
								</c:choose>				
								
								</td>						
							</tr>	
							<tr>
								<th>첨부파일</th>
							    <td colspan="3" >
									<c:if test="${resultVO.atch_link_id != null}">
										<div>
											<br /> <input type='button' onClick='fileView();' value='파일 보기' class="gray" style="padding: 5px;">
											<c:import charEncoding="utf-8" url="/cmm/fms/selectLinkFileInfs.do">
												<c:param name="param_atchFileId" value="${resultVO.atch_link_id}" />
											</c:import>
										</div>
									</c:if>
				      			</td>								
							</tr>
							<tr>
								<th scope='row'>연계과제</th>
								<td colspan="3">  		
									<div>
						              <table style="width: 100%">
						              <caption>연계과제</caption>
										<colgroup>
											<col width='15%' />						
											<col width='25%' />	
											<col width='15%' />		
											<col width='*' />									
										</colgroup>
										<tbody>
											<tr>
												<th scope='row' style="text-align:left;">과제번호</th>
												<td colspan="3">   
													<c:out value='${resultVO.busino}'/>		
												</td>						
											</tr>
											<tr>
												<th scope='row' style="text-align:left;">연구과제명</th>
												<td colspan="3">   
													<c:choose>
														<c:when test="${resultVO.proj_tit_kor ne null}">
															<a href = "javascript:fn_detailReport('Y','${resultVO.rep_id}');">${resultVO.proj_tit_kor}</a>
														</c:when>
														<c:otherwise>
															<a href = "javascript:fn_detailReport('Y','${resultVO.rep_id}');">${resultVO.proj_tit_eng}</a>
														</c:otherwise>
													</c:choose>
												</td>						
											</tr>	
											<tr>
												<th scope='row' style="text-align:left;">책임연구원</th>
												<td>   
													<c:out value='${resultVO.pi}'/>
												</td>	
												<%-- <th scope='row'>주관연구기관</th>
												<td>   
													${resultVO.org_name}
												</td> --%>						
											</tr>
											<tr>
												<th scope='row' style="text-align:left;">발행자</th>
												<td>   
													<c:out value='${resultVO.org_name}'/>
												</td>
											</tr>	
										</tbody>
						              </table>
									</div>	 								  				
								</td>																	
							</tr>	
						</tbody>
					</table>
<!--  -->
			<table class="view_table"  id="userOn">
						<caption>성과논문 </caption>
						<colgroup>
							<col width='17%' />						
							<col width='33%' />
							<col width='17%' />
							<col width='*' />														
						</colgroup>
						<tbody class="report">						
							<tr>
								<th scope='row'>논문명</th>
								<td colspan="3">  	
									<ul class="table_in_ul" style="padding:5px 0;">	
										<li>
											 <p class="middle_content"><c:out value='${resultVO.atc_title_kor}'/></p>
										</li>
								   <%-- <li>
											<p class="text middle_title">영&nbsp; &nbsp;문</p> <p class="middle_content">${resultVO.atc_title_eng}</p>
										</li> --%>
									</ul>	
									<%-- <div>
						            	<table style="width: 100%">
						        			<caption>논문명</caption>
											<colgroup>
												<col width='10%' />						
												<col width='*' />								
											</colgroup>
											<tbody>
												<tr>
													<th scope='row'>국문</th>
													<td>   
														${resultVO.atc_title_kor}		
													</td>						
												</tr>
												<tr>
													<th scope='row'>영문</th>
													<td style="line-height:150%; padding:10px 2%;">   
														${resultVO.atc_title_eng}
													</td>						
												</tr>	
											</tbody>
										</table>
									</div> --%>	 								  				
								</td>																	
							</tr>								
							<tr>
								<th scope='row'  >학술지명</th>
								<td colspan="3">
									<c:out value='${resultVO.journal_nm}'/>
								</td>						
							</tr>
							<tr>
								<th scope='row'  >ISSN</th>
								<td>
									<c:out value='${resultVO.rnd_issn}'/>
								</td>
								<th scope='row'  >DOI</th>
								<td>
									<a href= "<c:out value='${resultVO.doi}'/>" target="_blank" rel="noopener noreferrer"><c:out value='${resultVO.doi}'/></a>
								</td>						
							</tr>
							<tr>
								<th scope='row'  >주저자명(제1저자)</th>
								<td colspan="3">
										<a href= "javascript:fn_authorSearch('${resultVO.author}');">${resultVO.author} </a>
								</td>
							</tr>	
							<tr>
								<th scope='row'  >공동저자</th>
								<td colspan="3">
									<c:out value='${resultVO.co_author}'/>
								</td>	
							</tr>	
							<tr>
								<th scope='row'  >교신저자</th>
								<td colspan="3">
									<c:out value='${resultVO.commu_author}'/>
								</td>
							</tr>	
							<tr>
								<th scope='row'>권/호</th>
								<td colspan="3">
									<c:out value='${resultVO.volumename}'/>
								</td>							
							</tr>	
							<tr>
								<th scope='row'>논문페이지</th>
								 <td colspan="3" style="padding:0;">  		
									<div class="padding_none_box">
										<p>시작페이지</p>
										<p><c:out value="<c:out value='${resultVO.jour_str_page}'/>" default="&nbsp;" escapeXml="false"/></p>
										<p>끝페이지</p>
										<p><c:out value="<c:out value='${resultVO.jour_end_page}'/>" default="&nbsp;" escapeXml="false"/></p>
						            	<%-- <table style="width: 100%">
							              	<caption>논문페이지</caption>
											<colgroup>
												<col width='20%' />						
												<col width='30%' />
												<col width='20%' />						
												<col width='30%' />								
											</colgroup>
											<tbody>
												<tr style="border-spacing:0; border-collapse:collapse; margin:0; padding:0; box-sizing:border-box; height:100%; table-collapse">
													<th scope='row' class="border_r">논문시작페이지</th>
													<td style="padding-left:10px;">   
														${resultVO.jour_str_page}		
													</td>
													<th scope='row' class="border_b border_r" style="border-spacing:0; border-collapse:collapse; margin:0; padding:0; box-sizing:border-box; height:100%; table-collapse">논문끝페이지</th>
													<td style="padding-left:10px;">   
														${resultVO.jour_end_page}
													</td>						
												</tr>	
											</tbody>
										</table> --%>
									</div>	 								  				
								</td> 																	
							</tr>	
							
							<tr>
								<th scope='row'  >키워드</th>
								<td colspan="3">
									<c:out value='${resultVO.keyword}'/>
								</td>						
							</tr>	
							<tr>
								<th scope='row'  >초록</th>
								<td colspan="3" style="padding:10px 2% 15px 2%;">
								<c:choose>							
										<c:when test="${fn:length(resultVO.rnd_abs) > 1000}">
											<div id = 'divEtcarea'  style="width: 98%; line-height:150%; margin-bottom:10px; word-break:break-word;" >${fn:replace(fn:substring(resultVO.rnd_abs, 0 , 1000), crcn , br)}....</div>
											<a id="moreAbs" href="javascript:fn_openDiv()" class="amore" >more +</a> 
										</c:when>
										<c:otherwise>
									        <div id = 'divEtcarea'  style="width: 98%; word-break:break-word;">${fn:replace(fn:substring(resultVO.rnd_abs, 0 , 1000), crcn , br)}</div>
									    </c:otherwise>
								</c:choose>				
								
								</td>						
							</tr>	
							<%-- <tr>
								<th>첨부파일</th>
							    <td colspan="3" >
									<c:if test="${resultVO.atch_link_id != null}">
										<div>
											<br /> <input type='button' onClick='fileView();' value='파일 보기' class="gray" style="padding: 5px;">
											<c:import charEncoding="utf-8" url="/cmm/fms/selectLinkFileInfs.do">
												<c:param name="param_atchFileId" value="${resultVO.atch_link_id}" />
											</c:import>
										</div>
									</c:if>
				      			</td>								
							</tr> --%>
							<tr>
								<th scope='row'>연계과제</th>
								<td colspan="3">  	
									<ul class="table_in_ul" style="padding:5px 0;">	
										<%-- <li>
											<p class="text middle_title" style="width:13%; text-align:center;">과제번호</p> <p class="middle_content" style="width:87%">${resultVO.archive_busino}</p>
										</li> --%>
										<li>
											<p class="text middle_title middle_title2">연구과제명</p> <p class="middle_content middle_content2">																							
												<c:choose>
													<c:when test="${resultVO.proj_tit_kor ne null}">
														<c:choose>
															<c:when test="${resultVO.conParam eq 'N'}">
																<a onclick="javascript:alert('비공개 보고서 자료입니다.');">${resultVO.proj_tit_kor}</a>
															</c:when>
															<c:otherwise>
																<a href ="javascript:fn_detailReport('Y','${resultVO.rep_id}');">${resultVO.proj_tit_kor}</a>		
															</c:otherwise>
														</c:choose>													
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${resultVO.conParam eq 'N'}">
																<a onclick="javascript:alert('비공개 보고서 자료입니다.');">${resultVO.proj_tit_eng}</a>
															</c:when>
															<c:otherwise>
																<a href ="javascript:fn_detailReport('Y','${resultVO.rep_id}');">${resultVO.proj_tit_eng}</a>		
															</c:otherwise>
														</c:choose>														
													</c:otherwise>
												</c:choose>
											</p>
										</li>
										<li>
											<p class="text middle_title middle_title2">책임연구원</p> <p class="middle_content middle_content2"><c:out value='${resultVO.pi}'/></p>
										</li>
										<li>
											<p class="text middle_title middle_title2">발행자</p> <p class="middle_content middle_content2"><c:out value='${resultVO.org_name}'/></p>
										</li>
									</ul>								
									
									<%-- <div>
						              <table style="width: 100%">
						              <caption>연계과제</caption>
										<colgroup>
											<col width='15%' />						
											<col width='25%' />	
											<col width='15%' />		
											<col width='*' />									
										</colgroup>
										<tbody>
											<tr>
												<th scope='row' style="text-align:left;">과제번호</th>
												<td colspan="3">   
													${resultVO.archive_busino}		
												</td>						
											</tr>
											<tr>
												<th scope='row' style="text-align:left;">연구과제명</th>
												<td colspan="3">   
													<c:choose>
														<c:when test="${resultVO.proj_tit_kor ne null}">
															${resultVO.proj_tit_kor}
														</c:when>
														<c:otherwise>
															{resultVO.proj_tit_eng}
														</c:otherwise>
													</c:choose>
												</td>						
											</tr>	
											<tr>
												<th scope='row' style="text-align:left;">책임연구원</th>
												<td>   
													${resultVO.pi}
												</td>	
												<th scope='row'>주관연구기관</th>
												<td>   
													${resultVO.org_name}
												</td>						
											</tr>	
										</tbody>
						              </table>
									</div> --%>	 								  				
								</td>																	
							</tr>	
						</tbody>
					</table>
		
		
				<div class="btn-group">
					<!-- <a href="javascript:fn_returnPage('U')" class="basic-btn" id="btn_gbn">수정</a> -->
					<a href="javascript:fn_returnPage('R')" style="float: right;margin-bottom:10px;"  class="basic-btn">목록</a>
				</div> 

				<div id="archive-chart" class="center">
					<div class="sidebar-chart-right-text"></div>
					<div id ="gridChart"> <!-- style="width: 400px; height: 400px"> -->
					</div>	
				</div>      
			</div><!-- 컨텐츠 영역 -->
		</div>
	</div>
			
		
	


	<%-- <input type="hidden" id="rnd_abs" name="rnd_abs" value="${fn:replace(resultVO.rnd_abs, crcn , '<br/>')}"  alt="검색콤보" /> --%>
 	<div id = "rnd_abs" style= "display:none;" >
    	${fn:replace(resultVO.rnd_abs, crcn , br)}
    </div>
    
<!-- 처리 메세지 PARAM -->
	<input type="hidden" id="message" name="message" value="<c:out value='${message}'/>" alt="message">	

    <!-- 검색 PARAM -->
	<input type="hidden" id="page" name="page" value="<c:out value='${resultVO.page}'/>" alt="pageNum" />
	<input type="hidden" id="searchCondition" name="searchCondition" value="<c:out value='${resultVO.searchCondition}'/>"  alt="검색콤보" />
	<input type="hidden" id="searchKeyword" name="searchKeyword" value="<c:out value='${resultVO.searchKeyword}'/>" alt="검색어" />
	
	<input type="hidden" id="rnd_id" name="rnd_id" value="<c:out value='${resultVO.rnd_id}'/>"  alt="id" />
	<input type="hidden" id="rdcnt" name="rdcnt" value="<c:out value='${resultVO.rdcnt}'/>"  alt="검색콤보" />
	<input type="hidden" id="downcnt" name="downcnt" value="<c:out value='${resultVO.downcnt}'/>"  alt="검색콤보" />
	
	
	
	<!-- 파일 다운로드 PARAM  -->
	<input type="hidden" id="atch_link_id" name="atch_link_id" value="<c:out value='${resultVO.atch_link_id}'/>" alt="첨부파일ID "/>
	<input type="hidden" id="atc_title_kor" name="atc_title_kor" value="<c:out value='${resultVO.atc_title_kor}'/>" alt="논문_한글"/>
	<input type="hidden" id="atc_title_eng" name="atc_title_eng" value="<c:out value='${resultVO.atc_title_eng}'/>" alt="보고서_영문"/>
	
	<!-- 목록 화면 주소  -->
	<input type="hidden" id="returnListPage" name="returnListPage" value="${ctxt}/archive/rnd/rndList.do"  alt= "returnPage" />
	<input type="hidden" id="returnArchiveMainPage" name="returnArchiveMainPage" value="${ctxt}/archive/intro/archiveIntro.do"  alt= "returnArchiveMainPage" />
	<input type="hidden" id="returnRecentlyPage" name="returnRecentlyPage" value="${ctxt}/archive/intro/archiveRecentlyList.do"  alt= "returnRecentlyPage" />
	<input type="hidden" id="returnDownloadPage" name="returnDownloadPage" value="${ctxt}/archive/intro/archiveTopDownloadList.do"  alt= "returnRecentlyPage" />
	
	<!-- 공통  필수 PARAM  -->

	
	<!-- 필터 유지 위한 PARAM -->
	<input type="hidden" name="fillterYearList_s" id="fillterYearList_s" value = "<c:out value='${resultVO.fillterYearList_s}'/>" alt="필터 발행년도" />
 	
 	<input type="hidden" name="fillterYearCnt" id="fillterYearCnt" value = "<c:out value='${resultVO.fillterYearCnt}'/>" alt="필터 발행년도 CNT" />
	
	<!-- 리턴 페이지  -->
	<input type="text" id="returnPageGbn" name="returnPageGbn" value="<c:out value='${resultVO.returnPageGbn}'/>"  alt="returnPageGbn">

	<!-- 권한에 따라 view 보여주기 제어  -->
	<input type="hidden" id="archive_auth_gbn" name="archive_auth_gbn"   alt="archive_auth_gbn">
</form>


	

<!-- 파일 다운로드폼  -->
<form id= "downForm" name=  "downForm" action ="" method="post"  enctype="multipart/form-data">
	<input type="hidden" value="<c:out value='${resultVO.rnd_id}'/>" id="down_file_id" name = "down_file_id" >
</form>	


<!-- 상세 팝업 -->
<form id="detailForm" name="detailForm" action = "${ctxt}/archive/report/reportView.do" method="post" >
	<input type="hidden" id="rep_id" name="rep_id"  value=""  alt="rep_id">
	<input type="hidden" id="upd_yn" name="upd_yn"  value="Y"  alt="upd_yn">	
</form>

