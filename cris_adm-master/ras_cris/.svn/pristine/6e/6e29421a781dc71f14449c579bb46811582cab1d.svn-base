<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  
<!-- 차트 구성 SCRIPT STR-->
<script type="text/javascript" src="${ctxt}/resources/js/chart/jui/core.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctxt}/resources/js/chart/jui/chart.js" ></script>
<link rel="stylesheet" href="${ctxt}/resources/js/chart/jui/jquery-ui.min.css" />
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
	
			alert(msg);
	
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
	            domain : function(d) { return  chartMax(d.count); },
	            step :  5,
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
	var rep_id = $("#rep_id").val();
	var contextName = "ncmik";
	var fileKey = atchLinkId;
	var pageTitle = "";
	
	if($("#proj_tit_kor").val() != ""){
		pageTitle = $("#proj_tit_kor").val();
	}else{
		pageTitle = $("#proj_tit_eng").val();
	}

	
	fn_downloadUpdate(fileKey, contextName, pageTitle , rep_id , 'report');
}

// 초록 DIV의 더보기 / 닫기 버튼 
function fn_openDiv(){
	
	if(lookBoolean == true){
		
		$("#divEtcarea").html('<span>' + $("#rep_abs").html() +'</span>');
	
		lookBoolean = false;
		
		$("#moreAbs").text("close");
		
	}else if(lookBoolean == false){
	
		$("#divEtcarea").html($("#rep_abs").html().substring(0,1000)+"....");
	
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
    	returnPage= "${ctxt}/archive/report/reportEdit.do";
    }
	
	form.action = returnPage;
	form.submit();	
}

//첨부 파일 다운로드
function fn_downLoad(file_sn){	

	var downform = document.downForm;
	downform.action = '${ctxt}/archive/report/downFile.do?upd_yn=Y&down_file_sn='+file_sn;
	downform.submit();
	
	
}	


function fn_move(param){
	var form = document.reqForm;	
	form.upd_yn.value = 'Y';
	form.rnd_id.value = param;
	form.action = "${ctxt}/archive/rnd/rndView.do";	
	form.submit();	
}

</script>
<form name="reqForm" method="post">
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>아카이브</span>
			<span> > </span>
			<span class="active">보고서</span>        			      
		</div>
		<span class="center_text_01">보고서</span>
	</div> 
	<div class="under_bar"></div>
	
	<div class= "content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div class="list_title">
					<p>보고서 상세정보</p>
				</div>	
				<table class= "view_table"  id="userOff">
					<caption>보고서 상세</caption>
					<colgroup>
						<col width="15%">
						<col width="35%">
						<col width="15%">
						<col width="35%">															
					</colgroup>
					<tbody class="report">
						<tr>
							<th scope='row'>과제번호</th>
							<td colspan="3" class="padding_l">   										
								<c:out value='${resultVO.busino}'/>	
							</td>
							
						</tr>
						 <tr>
							<th scope='row'>연구과제명</th>
							<td colspan="3" class="padding_l">    
								<ul class="table_in_ul" style="padding:5px 0;">	
									<li>
										<p class="text middle_title">국 &nbsp; &nbsp;문</p> <p class="middle_content"><c:out value='${resultVO.proj_tit_kor}'/></p>
									</li>
									<li>
										<p class="text middle_title">영 &nbsp; &nbsp;문</p> <p class="middle_content"><c:out value='${resultVO.proj_tit_eng}'/></p>
									</li>
								</ul>	
					              <%-- <table class="one_row">
					              <caption>연구과제명</caption>
									<colgroup>
										<col width='6.9%' />				
										<col width='*' />								
									</colgroup>
									<tbody>
										<tr style="position:relative;">
											<th scope='row' style="text-align:left;">국&nbsp; &nbsp; &nbsp;문</th>
											<td style=""><p class="p_style">${resultVO.proj_tit_kor}</p></td>						
										</tr>
										<tr style="position:relative;">
											<th scope='row' style="text-align:left;">영&nbsp; &nbsp; &nbsp;문</th> 
											<td style=""><p class="p_style">${resultVO.proj_tit_eng}</p></td>						
										</tr>	
									</tbody>
					              </table> --%>	  				
							</td>																	
						</tr>	
						<tr>
							<th scope='row'>책임연구원</th>
							<td colspan="3" class="padding_l">  
								<ul class="table_in_ul" style="padding:5px 0;">	
									<li>
										<p class="text middle_title">성&nbsp; &nbsp;명</p> <p class="middle_content"><c:out value='${resultVO.pi}'/></p>
									</li>
									<%-- <li>
										<p class="text middle_title" style="width:17%;">소 &nbsp; &nbsp;속</p> <p class="middle_content" style="width:83%;">${resultVO.pi_dept}</p>
									</li> --%>
								</ul> 															
							</td>
						</tr>
						<tr>
							<th scope='row'>참여연구원</th>
							<td colspan="3" class="padding_l">
							<ul class="table_in_ul" style="padding:5px 0;">	
									<li>
										<p class="text middle_title">성&nbsp; &nbsp;명</p> <p class="middle_content"><c:out value='${resultVO.rp}'/></p>
									</li>
									<%-- <li>
										<p class="text middle_title" style="width:17%;">소 &nbsp; &nbsp;속</p> <p class="middle_content" style="width:83%;">${resultVO.rp_dept}</p>
									</li> --%>
								</ul>										
							</td>																																		
						</tr>	
						<tr>
						<th scope='row'>연구비지원기관</th>
							<td colspan="3" class="padding_l">
								<ul class="table_in_ul" style="padding:5px 0;">	
									<%--
									<li>
										<p class="text middle_title" style="width:17%;">센 &nbsp; &nbsp;터</p> <p class="middle_content" style="width:83%;">${resultVO.center_nm}</p>
									</li> 
									--%>	
									<li>
										 <p class="middle_content"><span><c:out value='${resultVO.order_dept}'/></span></p>
									</li>
									<li>
										 <p class="middle_content"><span><c:out value='${resultVO.charger_nm}'/></span></p>
									</li>
								</ul> 
							</td>							
							<%-- <td class="labels padding_l">   							 
								    <label for="center_nm"><span class="text">센 &nbsp; &nbsp;터</span> </label> ${resultVO.center_nm}	<br>
									<label for="order_dept"><span class="text">부 &nbsp; &nbsp;서</span> </label> 	${resultVO.order_dept} 	<br>
									<label for="charger_nm"><span class="text">담당자</span> </label> ${resultVO.charger_nm}										
							</td> --%>
						</tr>
						<tr>
							<th scope='row'>주관연구기관</th>
							<td colspan="3"  class="padding_l">      
								<c:out value='${resultVO.org_name}'/>					
							</td>						
						</tr>
						<tr>
							<th scope='row' >발행년도</th>
							<td>   
								<c:out value='${resultVO.pubyear}'/>	
							</td>
							<th scope='row'>연차구분</th>
							<td class="annual_num padding_l">      		
								<c:choose>
									<c:when test="${resultVO.annual_gbn eq '01'}">
									<label for="gbn1">단년도</label>
									</c:when>
									<c:otherwise>
									<label for="gbn2">다년도</label>
									</c:otherwise>
								</c:choose>											  
							  	 <label for="gbn">&nbsp;&nbsp;|&nbsp;&nbsp; </label> ${resultVO.annual_num}				    						
							</td>													
						</tr>
						<tr>
							<th scope='row'>주제</th>
							<td colspan="3" class="padding_l">    
								<c:out value='${resultVO.subject}'/>					
							</td>						
						</tr>
							<%--
						<tr>
							<th scope='row'>사업명</th>
							<td colspan="3" class="padding_l">    
								${resultVO.busi_nm}							
							</td>						
						</tr>
						<tr>
							<th scope='row'>세부사업명</th>
							<td colspan="3" class="padding_l">      
								${resultVO.detail_busi_nm}												
							</td>						
						</tr>
							--%>
							
					    <tr>
							<th scope='row'>색인단어</th>
							<td colspan="3">   
								<ul class="table_in_ul" style="padding:5px 0;">	
									<li>
										<p class="text middle_title">국&nbsp; &nbsp;문</p> <p class="middle_content"><c:out value='${resultVO.keyword_kor}'/></p>
									</li>
									<li>
										<p class="text middle_title">영&nbsp; &nbsp;문</p> <p class="middle_content"><c:out value='${resultVO.keyword_eng}'/></p>
									</li>
								</ul> 		
								<%-- <div>
			                      <table class="one_row">
					              <caption>색인단어</caption>
									<colgroup>
										<col width='6.9%' />						
										<col width='*' />									
									</colgroup>
									<tbody>
										<tr style="position:relative;">
											<th scope='row'>국&nbsp; &nbsp; &nbsp;문</th>
											<td style="position:absolute; right:0; width:699px;">   
												${resultVO.keyword_kor}	<br/>
											</td>						
										</tr>																							
										<tr style="position:relative;">
											<th scope='row'>영&nbsp; &nbsp; &nbsp;문</th>
											<td style="position:absolute; right:0; width:699px;">   
												${resultVO.keyword_eng}
											</td>						
										</tr>		
									</tbody>
					              </table>
								</div> --%>	 								  				
							</td>																	
						</tr>	
						<tr>
							<th scope="row">초록</th>
							<td colspan="3" style="padding:10px 2% 15px 2%;">   
								<c:choose>							
									<c:when test="${fn:length(resultVO.rep_abs) > 1000}">
										<div id = 'divEtcarea'  style="width: 100%; line-height:170%; margin-bottom:10px; word-break:break-word; ">${fn:replace(fn:substring(resultVO.rep_abs, 0 , 1000), crcn , br)}....</div>
										<a id="moreAbs" href="javascript:fn_openDiv()" class="amore">more +</a> 
									</c:when>
									<c:otherwise>
								        <div id = 'divEtcarea' style="width: 100%; line-height:170%; margin-bottom:10px; word-break:break-word;">${fn:replace(fn:substring(resultVO.rep_abs, 0 , 1000), crcn , br)}</div>
								    </c:otherwise>
								</c:choose>						
							</td>						
						</tr>										
						<tr>
				            <th>연차정보</th>
				            <td colspan="3" class="padding_l">
				              <div class="annualList">
					              <table id='insertAnnaulTable'>
					              <caption>보고서 등록</caption>
									<colgroup>
<%--  										<col width='18%' />						 --%>
<%-- 										<col width='35%' /> --%>
<%-- 										<col width='18%' /> --%>
<%-- 										<col width='*' />								 --%>
									</colgroup>
									<tbody>		
										<c:choose>
											<c:when test="${fn:length(resultAnnualVO) > 0}">				
								              	<c:forEach items="${resultAnnualVO}" var="result" varStatus="status" >
<%-- 							              			 <tr>					              			
							              			<c:choose>
							              				<c:when test="${result.period_gbn eq '0'}">
							              					<th style="text-align:left;">총연구기간</th>
							              				</c:when>
							              				<c:otherwise>
							              					<th style="text-align:left;">${status.index}차년도 연구기간</th>
							              				</c:otherwise>	
							              			</c:choose>					              			
														<td>
															${result.research_dt}
															<input type="hidden"  name="period_gbn" value ="${result.period_gbn}" title="총연구기간" />
														</td>
													<c:choose>
							              				<c:when test="${result.period_gbn eq '0'}">
							              					<th style="text-align:left;">총연구비</th>
							              				</c:when>				              							              				
							              				<c:otherwise>
							              					<th style="text-align:left;">${status.index}차년도 연구비</th>
							              				</c:otherwise>	
							              			</c:choose>	
														<td>		
															${result.research_fund}																																	
														</td>											
													</tr> --%> 
									 				<tr>
														<td class="paddig_l responsive_td">    
															<ul class="table_in_ul" style="padding:5px 0;">	
																<c:choose>
																	<c:when test="${result.period_gbn eq '0'}">
										              					<li>
																			<span class="text middle_title">총연구기간</span> <span class="middle_content"><c:out value='${result.research_dt}'/></span>
																			<input type="hidden"  name="period_gbn" value ="<c:out value='${result.period_gbn}'/>" title="총연구기간" />
																		</li>
										              				</c:when>
										              				<c:otherwise>
											              				<li>
																			<span class="text middle_title">${status.index}차년도 연구기간</span> <span class="middle_content"><c:out value='${result.research_dt}'/></span>
																			<input type="hidden"  name="period_gbn" value ="<c:out value='${result.period_gbn}'/>" title="총연구기간" />
																		</li>
												              		</c:otherwise>	
																</c:choose>
															</ul>	    
															<ul class="table_in_ul" style="padding:5px 0;">	
																<c:choose>
																	<c:when test="${result.period_gbn eq '0'}">
										              					<li>
																			<span class="text middle_title">총연구비</span> <span class="middle_content">${result.research_fund}</span>
																		</li>
										              				</c:when>
										              				<c:otherwise>
											              				<li>
																			<span class="text middle_title">${status.index}차년도 연구비</span> <span class="middle_content">${result.research_fund}</span>
																		</li>
												              		</c:otherwise>	
																</c:choose>
															</ul>	
														</td>															
													</tr> 
								              	</c:forEach>
						             		</c:when>
						             		<c:otherwise>
						             		 	<tr>
								              		<th>총연구기간</th>
													<td>											
														<!-- <input type="text"  name="research_dt"style="width:80% ;display:inline;" title="총연구기간" />	
														<input type="hidden"  name="period_gbn" value ="0" title="총연구기간" /> -->									
													</td>
													<th>총연구비</th>
													<td>											
														<!-- <input type="text"  name="research_fund"style="width:80% ;display:inline;" onkeydown="numberChk();" title="총연구비" /> -->										
													</td>
													<td></td>
												</tr>
												<tr>
								              		<th>1차년도 연구기간</th>
													<td>											
													<!-- 	<input type="text"  name="research_dt" style="width:80% ;display:inline;"  title= "1차년도 연구기간" />
														<input type="hidden"  name="period_gbn" value ="1" title="1차년도 연구비" /> -->										
													</td>
													<th>1차년도 연구비</th>
													<td>											
														<!-- <input type="text"  name="research_fund" style="width:80% ;display:inline;"  title="1차년도 연구비" /> -->										
													</td>
													<td>
													<!-- 	<input type="button" name="del_btn" value="삭제" onClick="deleteAnnual(this)" border=0 style="cursor:hand">
														<input type="button" name="save_btn" value="추가" onClick="addAnnual(this.form)" border=0 style='cursor:hand'> -->	
													</td>
												</tr>
						             		</c:otherwise>
						              </c:choose>
									</tbody>
					              </table>
								</div>
				            </td>
        				</tr>	
						<tr>
						<%--
							<th scope='row'>보안등급</th>						
							<td>   
								<div>							
									<input type="radio" class="radio_style2" name="security_level" value="1" ${resultVO.security_level eq '1'?'checked="checked"':''} disabled="disabled"  /> 
									<label for="security_level_on" class="margin_r_20" >일반과제</label>
									<input type="radio" class="radio_style2" name="security_level" value="0" ${resultVO.security_level eq '0'?'checked="checked"':''} disabled="disabled"  />  
									<label for="security_level_off"  >보안과제</label>
							  	</div>
							  	<c:if test="${resultVO.security_level eq '0'}" >
								  	<div class="security_result" style="width:100%; display:block;">
							              <table id='security_resultTable'>
							              <caption>보안등급 </caption>
											<colgroup>
												<col width='30%' />						
												<col width='*' />								
											</colgroup>
											<tbody>
												<tr class="con_hide">
													<th scope='row'>보안과제 사유</th>
													<td>${resultVO.security_rs}</td>						
												</tr>												
											</tbody>
							              </table>
									</div>
								</c:if>	 		 								  															  				
							</td>
						--%>							
							<th scope='row'>연구결과 공개</th>
							<td colspan="3" class="padding_l">  	 	
								<div>						
									<input type="radio" class="radio_style2 radio" name="con_type" value="1" ${resultVO.con_type eq '1'?'checked="checked"':''} disabled="disabled"  />   
									<label for="con_type_visi" style="margin-right:44px;">공개</label>
					 				<input type="radio" class="radio_style2 radio" name="con_type" value="0" ${resultVO.con_type eq '0'?'checked="checked"':''} disabled="disabled"  />   
					 				<label for="con_type_hide">비공개</label>
								</div>	
							 	<c:if test="${resultVO.con_type eq '0'}" >
									<div class="research_result">
						              <table style="width: 100%">
						              <caption>연구결과 공개</caption>
										<colgroup>
											<col width='12%' />						
											<col width='*' />								
										</colgroup>
										<tbody>
											<tr>
												<th scope='row' style="text-align:left; min-width:58px;">비공개 사유</th>
												<td style="line-height:140%;"><c:out value='${resultVO.private_rs}'/></td>						
											</tr>
											<tr>
												<th scope='row' style="text-align:left; min-width:58px;">비공개 기간</th>
												<td>    
													 <c:out value='${resultVO.private_str_dt}'/>	 ~  <c:out value='${resultVO.private_end_dt}'/>		 								  				
												</td>						
											</tr>	
										</tbody>
						              </table>
									</div>
								</c:if>	 								  				
							</td>																		
						</tr>	
						<tr> <!-- 성과논문 임시 숨김 -->
							<th scope='row'>성과논문</th>
								<td colspan="3">  		
									<div>
									<c:forEach items="${resultRnd}" var="resultRnd" varStatus="status"> 
							              <table style="width: 100%">
							              <caption>성과논문</caption>
											<colgroup>
												<col width='15%' />						
												<col width='25%' />	
												<col width='15%' />										
											</colgroup>
											<tbody>											
												<tr  style= "line-height: 20px;">
													<th scope='row' style="text-align:left;">제목</th>
													<td colspan="3">   
														<c:choose>
															<c:when test="${resultRnd.atc_title_kor ne null}">
																<a href = "javascript:fn_move('${resultRnd.rnd_id}')">${resultRnd.atc_title_kor}</a>
															</c:when>
															<c:otherwise>
																<a href = "javascript:fn_move('${resultRnd.rnd_id}')">${resultRnd.atc_title_eng}</a>
															</c:otherwise>
														</c:choose>
													</td>						
												</tr>
												<tr>
													<th scope='row' style="text-align:left;">저자</th>
													<td colspan="3">   
														<c:out value='${resultRnd.author}'/>
													</td>						
												</tr>	
												<tr>
													<th scope='row' style="text-align:left;">학술지명</th>
													<td colspan="3">   
														<c:out value='${resultRnd.journal_nm}'/>
													</td>						
												</tr>												
											</tbody>
							              </table>
							                <c:if test="${status.last eq false}">
							           	 <hr>
							              </c:if> 
						              </c:forEach>
									</div>	 								  				
								</td>						
						</tr>					
						<tr>
							<th>첨부파일</th>
							 <td colspan="3" >
								<c:if test="${resultVO.atch_link_id != null}">
									<div>
										<input type='button' onClick='fileView();' value='파일 보기'
											class="gray" style="padding: 5px;">
										<c:import charEncoding="utf-8" url="/cmm/fms/selectLinkFileInfs.do">
											<c:param name="param_atchFileId" value="${resultVO.atch_link_id}" />
										</c:import>
									</div>
								</c:if>
				      		</td>		
						</tr>
					</tbody>
				</table>
				<!--  -->
				<table class= "view_table" id ="userOn">
					<caption>보고서 상세</caption>
					<colgroup>
						<col width="15%">
						<col width="85%">																			
					</colgroup>
					<tbody class="report">
						<tr>
							<th scope='row'>연구과제명</th>
							<td class="padding_l"> 
								<ul class="table_in_ul" style="padding:5px 0;">	
									<li>
										<p class="text middle_title">국 &nbsp; &nbsp;문</p> <p class="middle_content"><c:out value='${resultVO.proj_tit_kor}'/></p>
									</li>
									<li>
										<p class="text middle_title">영 &nbsp; &nbsp;문</p> <p class="middle_content"><c:out value='${resultVO.proj_tit_eng}'/></p>
									</li>
								 </ul>   						             	
							</td>																	
						</tr>	
						<tr>
							<th scope='row'>책임연구원</th>
							<td>
								<ul class="table_in_ul" style="padding:5px 0;">	
									<li>
										<p class="text middle_title">성 &nbsp; &nbsp;명</p><p class="middle_content"> <c:out value='${resultVO.pi}'/></p>
									</li>
									<%-- <li>
										<p class="text middle_title">소 &nbsp; &nbsp;속</p><p class="middle_content"> ${resultVO.pi_dept}</p>
									</li> --%>
								 </ul>  															
							</td>																																				
						</tr>
						<tr>							
							<th scope='row'>연구비지원기관</th>							
							<td class="labels padding_l">  
								<ul class="table_in_ul" style="padding:5px 0;">	
									 <%-- 
									 <li>
										<p class="middle_title text"><label for="center_nm">센 &nbsp; &nbsp;터</label></p><p class="middle_content">${resultVO.center_nm}</p>
									</li>
										--%>
									<li>
										<p class="middle_content"><c:out value='${resultVO.order_dept}'/></p>
									</li>
									 <%-- 
									<li>
										<p class="middle_content">${resultVO.charger_nm}</p>
									</li>
									--%>
								 </ul>										
							</td>
						</tr>	
						<tr>
							<th scope='row'>주관연구기관</th>
							<td class="padding_l">      
								<c:out value='${resultVO.org_name}'/>					
							</td>						
						</tr>
						<tr>
							<th scope='row' >발행년도</th>
							<td class="padding_l">   
								<c:out value='${resultVO.pubyear}'/>	
							</td>
						</tr>	
						<tr>
							<th scope='row'>주제</th>
							<td class="padding_l">    
								<c:out value='${resultVO.subject}'/>							
							</td>						
						</tr>
						<%-- 						
						<tr>
							<th scope='row'>사업명</th>
							<td class="padding_l">    
								${resultVO.busi_nm}							
							</td>						
						</tr>
						<tr>
							<th scope='row'>세부사업명</th>
							<td class="padding_l">      
								${resultVO.detail_busi_nm}												
							</td>						
						</tr>															 					   	
						--%>
					    <tr>
							<th scope='row'>색인단어</th>
							<td class="padding_l">
								<ul class="table_in_ul" style="padding:5px 0;">	
									<li>
										<p class="text middle_title">국&nbsp; &nbsp;문</p><p class="middle_content"> <c:out value='${resultVO.keyword_kor}'/></p>
									</li>
									<li>
										<p class="text middle_title">영&nbsp; &nbsp;문</p><p class="middle_content"> <c:out value='${resultVO.keyword_eng}'/></p>
									</li>
								 </ul> 							    																	  				
							</td>																	
						</tr>	
						<tr>
							<th scope="row">초록</th>
							<td  style="padding:10px 2% 15px 2%;">   
								<c:choose>							
									<c:when test="${fn:length(resultVO.rep_abs) > 1000}">
										<div id = 'divEtcarea'  style="width: 100%; line-height:170%; margin-bottom:10px; word-break:break-word; ">${fn:replace(fn:substring(resultVO.rep_abs, 0 , 1000), crcn , br)}....</div>
										<a id="moreAbs" href="javascript:fn_openDiv()" class="amore">more +</a> 
									</c:when>
									<c:otherwise>
								        <div id = 'divEtcarea'  style="width: 100%; line-height:170%; margin-bottom:10px; word-break:break-word; ">${fn:replace(fn:substring(resultVO.rep_abs, 0 , 1000), crcn , br)}</div>
								    </c:otherwise>
								</c:choose>						
							</td>						
						</tr>
						<tr> <!-- 성과논문 임시 숨김 -->
							<th scope='row'>성과논문</th>
								<td colspan="3">  		
									<div>
									<c:forEach items="${resultRnd}" var="resultRnd" varStatus="status"> 
							              <table style="width: 100%">
							              <caption>성과논문</caption>
											<colgroup>
												<col width='15%' />						
												<col width='25%' />	
												<col width='15%' />										
											</colgroup>
											<tbody>											
												<tr style= "line-height: 20px;">
													<th scope='row' style="text-align:left;">제목</th>
													<td colspan="3" >   
														<c:choose>
															<c:when test="${resultRnd.atc_title_kor ne null}">
																<a href = "javascript:fn_move('${resultRnd.rnd_id}')"><c:out value='${resultRnd.atc_title_kor}'/></a>
															</c:when>
															<c:otherwise>
																<a href = "javascript:fn_move('${resultRnd.rnd_id}')"><c:out value='${resultRnd.atc_title_eng}'/></a>
															</c:otherwise>
														</c:choose>
													</td>						
												</tr>
												<tr>
													<th scope='row' style="text-align:left;">저자</th>
													<td colspan="3">   
														<c:out value='${resultRnd.author}'/>
													</td>						
												</tr>	
												<tr>
													<th scope='row' style="text-align:left;">학술지명</th>
													<td colspan="3">   
														<c:out value='${resultRnd.journal_nm}'/>
													</td>						
												</tr>												
											</tbody>
							              </table>
							             <c:if test="${status.last eq false}">
							            <hr>
							              </c:if> 
							            
						              </c:forEach>
									</div>	 								  				
								</td>						
						</tr>												
						<tr>
							<th>첨부파일</th>
							 <td>
								<c:if test="${resultVO.atch_link_id != null}">
									<div>
										<br /> <input type='button' onClick='fileView();' value='파일 보기'
											class="gray" style="padding: 5px;">
										<c:import charEncoding="utf-8" url="/cmm/fms/selectLinkFileInfs.do">
											<c:param name="param_atchFileId" value="${resultVO.atch_link_id}" />
										</c:import>
									</div>
								</c:if>
				      		</td>		
						</tr>
					</tbody>
				</table>
				<div class="btn-group">
				 <!-- <a href="javascript:fn_returnPage('U')" class="basic-btn" id="btn_gbn">수정</a> -->
					<a href="javascript:fn_returnPage('R')"  style="float: right;margin-bottom:10px;"  class="basic-btn">목록</a>
				</div> 
				<div id="archive-chart" class="center">
					<div class="sidebar-chart-right-text"></div>
					<div id ="gridChart"> <!-- style="width: 400px; height: 400px"> -->
					</div>	
				</div>
			</div>
		</div>
	</div>


   <%--  <input type="hidden" id="rep_abs" name="rep_abs" value="${fn:replace(resultVO.rep_abs, crcn , br)}"  alt="초록" /> --%>
    <div id = "rep_abs" style= "display:none;" >
    	${fn:replace(resultVO.rep_abs, crcn , br)}
    </div>

<!-- 처리 메세지 PARAM -->
	<input type="hidden" id="message" name="message" value="<c:out value='${message}'/>" alt="message">		
    <!-- 검색 PARAM -->
	<input type="hidden" id="page" name="page" value="<c:out value='${resultVO.page}'/>" alt="pageNum" />
	<input type="hidden" id="searchCondition" name="searchCondition" value="<c:out value='${resultVO.searchCondition}'/>"  alt="검색콤보" />
	<input type="hidden" id="searchKeyword" name="searchKeyword" value="<c:out value='${resultVO.searchKeyword}'/>" alt="검색어" />
	
	<input type="hidden" id="rep_id" name="rep_id" value="<c:out value='${resultVO.rep_id}'/>"  alt="id" />
	<input type="hidden" id="rdcnt" name="rdcnt" value="<c:out value='${resultVO.rdcnt}'/>"  alt="조회수" />
	<input type="hidden" id="downcnt" name="downcnt" value="<c:out value='${resultVO.downcnt}'/>"  alt="다운로드수" />
	
	<input type="hidden" id="upd_yn" name="upd_yn" value="" alt="업데이트">	
	<input type="hidden" id="rnd_id" name="rnd_id" value="" alt="성과논문 id ">	
	
	<!-- 파일 다운로드 PARAM  -->
	<input type="hidden" id="atch_link_id" name="atch_link_id" value="<c:out value='${resultVO.atch_link_id}'/>" alt="첨부파일ID "/>
	<input type="hidden" id="proj_tit_kor" name="proj_tit_kor" value="<c:out value='${resultVO.proj_tit_kor}'/>" alt="보고서_한글"/>
	<input type="hidden" id="proj_tit_eng" name="proj_tit_eng" value="<c:out value='${resultVO.proj_tit_eng}'/>" alt="보고서_영문"/>
	
	<!-- 목록 화면 주소  -->
	<input type="hidden" id="returnListPage" name="returnListPage" value="${ctxt}/archive/report/reportList.do"  alt= "returnPage" />
	<input type="hidden" id="returnArchiveMainPage" name="returnArchiveMainPage" value="${ctxt}/archive/intro/archiveIntro.do"  alt= "returnArchiveMainPage" />
	<input type="hidden" id="returnRecentlyPage" name="returnRecentlyPage" value="${ctxt}/archive/intro/archiveRecentlyList.do"  alt= "returnRecentlyPage" />
	<input type="hidden" id="returnDownloadPage" name="returnDownloadPage" value="${ctxt}/archive/intro/archiveTopDownloadList.do"  alt= "returnRecentlyPage" />
		
	<!-- 공통  필수 PARAM  -->

	
	<!-- 필터 유지 위한 PARAM -->
	<input type="hidden" name="fillterYearList_s" id="fillterYearList_s" value = "<c:out value='${resultVO.fillterYearList_s}'/>" alt="필터 발행년도" />
 	
 	<input type="hidden" name="fillterDeptList_s" id="fillterDeptList_s" value = "<c:out value='${resultVO.fillterDeptList_s}'/>" alt="필터 발주부서" />
 	
 	<input type="hidden" name="fillterSubjectList_s" id="fillterSubjectList_s" value = "<c:out value='${resultVO.fillterSubjectList_s}'/>" alt="필터 주제분류" />
 	
 	<input type="hidden" name="fillterYearCnt" id="fillterYearCnt" value = "<c:out value='${resultVO.fillterYearCnt}'/>" alt="필터 발행년도 CNT" />
	
	<input type="hidden" name="fillterDeptCnt" id="fillterDeptCnt" value = "<c:out value='${resultVO.fillterDeptCnt}'/>" alt="필터 발주부서 CNT" />
	
	<input type="hidden" name="fillterSubjectCnt" id="fillterSubjectCnt" value = "<c:out value='${resultVO.fillterSubjectCnt}'/>" alt="필터 주제분류 CNT" />
	
	<!-- 리턴 페이지  -->
	<input type="hidden" id="returnPageGbn" name="returnPageGbn" value="<c:out value='${resultVO.returnPageGbn}'/>"  alt="returnPageGbn">
	
	<!-- 권한에 따라 view 보여주기 제어  -->
	<input type="hidden" id="archive_auth_gbn" name="archive_auth_gbn"   alt="archive_auth_gbn">
	
</form>

<!-- 파일 다운로드폼  -->
<form id= "downForm" name=  "downForm" action ="" method="post"  enctype="multipart/form-data">
	<input type="hidden" value="<c:out value='${resultVO.rep_id}'/>" id="down_file_id" name = "down_file_id" >
</form>	
