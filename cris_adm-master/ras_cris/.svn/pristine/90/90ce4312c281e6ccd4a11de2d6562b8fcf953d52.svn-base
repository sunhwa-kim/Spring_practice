<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<script type="text/javascript">
var del_file_list = "";

$(function(){
	
	if($("#message").val() != ''){
		var msg = $("#message").val();
	
			alert(msg);
	}
	
    $("#message").val('');
	
    
    // 달력구성
	cmmfn_set_datepicker($("#private_str_dt"), "yy-mm-dd");
	cmmfn_set_datepicker($("#private_end_dt"), "yy-mm-dd");
	
	// 년도 셋팅
	getYear("pubyear",10,0);

	/* //발주부서
	var combo_order_dept = $("#combo_order_dept").val();	 
	if(combo_order_dept != '' ){
		$('#order_dept option[value='+combo_order_dept+']').attr('selected',true);
	}	  */
	
	// 발행년도	
	var combo_pubyear = $("#combo_pubyear").val();	 
	if(combo_pubyear != '' ){
		$('#pubyear option[value='+combo_pubyear+']').attr('selected',true);
	}
	var combo_annual_gbn = $("#combo_annual_gbn").val();	 
	if(combo_pubyear != '' ){
		$('#annual_gbn option[value='+combo_annual_gbn+']').attr('selected',true);
	}
	// 주제분류
	var combo_subject = $("#combo_subject").val();	 
	if(combo_subject != '' ){
		$('#subject option[value='+combo_subject+']').attr('selected',true);
	}
	
	
	
	
	if( $('input[name = con_type]:checked').val() == "1"){	
		$(".research_result").hide();
	}else{
		$(".research_result").show();
	}
	
	if( $('input[name = security_level]:checked').val() == "1"){	
		$(".security_result").hide();
	}else{
		$(".security_result").show();
	}
});

function fn_conType(){
	
	if($('input[name = con_type]:checked').val() == "1"){	
		$(".research_result").hide();
	}else{
		$(".research_result").show();
	}
}

function fn_security(){
	
	if( $('input[name = security_level]:checked').val() == "1"){	
		$(".security_result").hide();
	}else{
		$(".security_result").show();
	}
	
}

// 파일을 삭제하고 올린다.
function fn_fileChk(){

	if( $("#file_yn").val() !=undefined){
		alert("기존 파일을 삭제후 등록하여 주십시오.");
		
		event.returnValue=false;
	}
	
}

//수정
function fn_save(){
	
	// 널 체크
	if(cmmfn_check_inputnull($("#busino,  #proj_tit_kor ,#proj_tit_eng, #pi  ,#order_dept , #charger_nm , #org_name, #pubyear ,#annual_gbn, #annual_num , #subject ")) == false){
		
		return;
	}
	
	
	if( $('input[name = security_level]:checked').val() != "1"){	
 		if(cmmfn_check_inputnull($("#security_rs")) == false){	
			return;
		} 
	}

	if($('input[name = con_type]:checked').val() != "1"){	
		if(cmmfn_check_inputnull($("#private_rs, #private_str_dt , #private_end_dt")) == false){	
			return;
		} 
	}
	
	
	
	if(confirm("보고서 내용을 저장 하시겠습니까?") ==false){
		return;
	}
		
	
	var form  = document.reqForm;
		
	form.submit();
}


function fn_delete(){


		
	var form  = document.reqForm;
	form.action = "${ctxt}/archive/report/deleteArchiveReport.do";
	form.submit();
	
}


/* 보고서 목록 조회  */
function fn_rndLinkSearch(){
	
	
 
}


//파일 추가	
function addAnnual(form){
    if($('input[name=research_dt]').length > 10) return false;
    var getTable = document.getElementById("insertAnnaulTable");
    var rowNum = Number(getTable.rows.length);
	var oCurrentRow = getTable.insertRow(getTable.rows.length);

    var html = '<tr>';
   		html += 	'<th class = "dtTitle'+rowNum+'">'+rowNum+'차년도 연구기간</th>';
	    html += 	'<td>';					
	    html += 		'<input type="text"  name="research_dt" style="width:80% ;display:inline;" title="차년도 연구기간" />';		
	    html += 		'<input type="hidden"  name="period_gbn" class = "gbn'+rowNum+'" value = "'+rowNum+'" title="차년도 연구비" />';	
	    html += 	'</td>';
	    html += 	'<th class = "costTitle'+rowNum+'">'+rowNum+'차년도 연구비</th>';
	    html += 	'<td>';											
	    html += 		'<input type="text"  name="research_fund" style="width:80% ;display:inline;" title="1차년도 연구비" />';										
	    html += 	'</td>';
	    html += 	'<td>';   		
	    html += 		'<input type="button" name="del_btn" value="삭제" onClick="deleteAnnual(this)" border=0 style="cursor:hand">';
	    html += 	'</td>';
	    html += '</tr>';
    oCurrentRow.innerHTML =html;
}



function deleteAnnual(obj){

	var agent = navigator.userAgent.toLowerCase(); 
	if($(obj).parent().parent().index() == 0){
		if (agent.indexOf("msie") != -1) {
			$(obj).parent().find('input[name=research_dt]').replaceWith( $(obj).parent().find('input[name=research_dt]').clone(true) );
		} else {
			$(obj).parent().find('input[name=research_dt]').val('');
		}
    }else{
    	
    	var rowIndexChk = $(obj).parent().parent().index();    
    	var getTableChk = document.getElementById("insertAnnaulTable");
 	    var rowNumChk = Number(getTableChk.rows.length);
 	    
 	    if( rowIndexChk != (rowNumChk-1) ){
 	    	alert("다음년도 데이터를 먼저 삭제처리 해주십시오.");
 	    	return;
 	    }
    	
    	var rowIndex = $(obj).parent().parent().index();    
    	
    	$(obj).parent().parent().remove();
    	 
    	var getTable = document.getElementById("insertAnnaulTable");
 	    var rowNum = Number(getTable.rows.length);
 
    	for(var i = rowIndex ; i <= rowNum ; i++){  

	    	$(".dtTitle"+i).text((i-1)+"차년도 연구기간");
		    $(".costTitle"+i).text((i-1)+"차년도 연구비");
		    $(".gbn"+i).val((i-1));
		    
		 	$(".dtTitle"+i).attr("class" ,"dtTitle"+ (i-1) );
			$(".costTitle"+i).attr("class" ,"costTitle"+ (i-1) );
			$(".gbn"+i).attr("class" ,"gbn"+ (i-1) );		
	 	}

   }
}

function numberChk(event) {
	
    event = event || window.event;

    var keyID = (event.which) ? event.which : event.keyCode;

    if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) )

    {

        return;

    }

    else

    {

        return false;

    }


}


//뒤로
function fn_backPage(param){
	
	var form=document.reqForm;
	if(param == 'V'){
		form.action="${ctxt}/archive/report/reportView.do";	
	}else{
		form.action="${ctxt}/archive/report/reportList.do";
	}
	
	form.submit();
	
}
	
	

// 첨부파일(공통) 수정
function fileModify() {
 
	var atchLinkId = $("#atch_link_id").val();
	
 	var contextName = "ncmik";
    var fileKey = atchLinkId;
 	var userId = "<c:out value='${userVo.emplyrkey}'/>";
    var savePath = "archive_report";
	var pageTitle = "";
	
	if($("#proj_tit_kor").val() != ""){
		pageTitle = $("#proj_tit_kor").val();
	}else{
		pageTitle = $("#proj_tit_eng").val();
	}

    popAttfileModify(fileKey, contextName, userId, savePath, pageTitle);
}

// 첨부파일(공통) 보기
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

//첨부파일(공통) 삭제
function allDatafileDelete() {
	
	
	   
	var params = {};
  	
	params.rep_id = $('#rep_id').val(); 
	
	
    $.ajax({
        url: '${ctxt}/archive/rnd/rndLinkCnt.do',
        data: params,
        type: 'POST',
        dataType: 'xml',
        async: false, 
        cache: false,
        success: function(rtnXml) {
 
        	var linkCnt = $(rtnXml).find('int').text();
        	var resultStateFalse = false;
        	var resultStateTrue = true;
        	if(linkCnt > 0){ 
        		if(confirm("성과논문의 연계과제가 ( " + linkCnt + " ) 건 존재합니다. 삭제하시겠습니까?") == false){
        			return;
        		}
			}else{
				if(confirm("삭제 하시겠습니까?") ==false){
					return;
				}
			}
        	
        	
        	
        	var atchLinkId = $("#atch_link_id").val();
        	var contextName = "ncmik";
        	var fileKey = atchLinkId;
        		
        	deleteContents(fileKey, contextName);
//         	  alert('첨부파일 삭제처리 완료 : orgFormSubmit() 함수를 Call 함');
        	  // 여기서 자동으로 orgFormSubmit() 함수를 불러줌
        	
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
	
	

}

function orgFormSubmit() {
	fn_delete();
}


	</script>


 
		
 <form id="reqForm" name="reqForm" action="${ctxt}/archive/report/updateArchiveReport.do" method="post" enctype="multipart/form-data">
			
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
					<p>보고서 수정</p>
				</div>
		<table class= "view_table">
			<caption>보고서 수정</caption>
			<colgroup>
						<col width='15%' />						
						<col width='35%' />
						<col width='15%' />
						<col width='35%' />			
			</colgroup>
			<tbody class="report">
				<tr>
					<th scope='row'>과제번호 <span class="txt_red">*</span></th>
					<td colspan="3" class="padding_l">   
						<input id="busino" name="busino" value="${resultVO.busino}"  class="full"  type="text"  style="width: 80%;"  title="과제번호"/>				
					</td>					
				</tr>
				 <tr>
					<th scope='row'>연구과제명<span class="txt_red">*</span></th>
					<td colspan="3" class="padding_l">  	
					    <table class="one_row">
			              <caption>연구과제명</caption>
							<colgroup>
								<col width='6.9%' />						
								<col width='*' />							
							</colgroup>
							<tbody>								
								<tr style="position:relative;">
									<th scope='row' style="text-align:left;">국&nbsp; &nbsp; &nbsp;문</th>
									<td style="position:absolute; right:0; width:699px;">   
										<input id="proj_tit_kor" name="proj_tit_kor" value="<c:out value='${resultVO.proj_tit_kor}'/>"  class="full"  type="text" title="연구과제명_한글"/><br>
									</td>
								</tr>	
								<tr style="position:relative;">
									<th scope='row' style="text-align:left;">영&nbsp; &nbsp; &nbsp;문</th>
									<td style="position:absolute; right:0; width:699px;">   
										<input id="proj_tit_eng" name="proj_tit_eng" value="<c:out value='${resultVO.proj_tit_eng}'/>"  class="full"  type="text"  title="연구과제명_영문"/>
									</td>						
								</tr>		
							</tbody>
			              </table>							  				
					</td>																	
				</tr>
				<tr>
					<th scope='row'>책임연구원<span class="txt_red">*</span></th>
					<td colspan="3" class="padding_l">  							
						<div>
			                <table>
				              <caption>책임연구원</caption>
								<colgroup>
									<col width='20%' />						
									<col width='80%' />								
								</colgroup>
							<tbody>									
								<tr>
									<td class="labels">	
										<label><span class="text">성 &nbsp; &nbsp;명</span></label>
										<input id="pi" name="pi"  class="full right_0" style="width:90%" value="${resultVO.pi}" type="text"  title="책임연구원"> <br>
										<%-- <label><span class="text">소 &nbsp; &nbsp;속</span></label>
										<input id="pi_dept" name="pi_dept"  class="full right_0" value="${resultVO.pi_dept}"  type="text"  title="책임연구원_소속"/> --%>
									</td>						
								</tr>	
							</tbody>
			              </table>
						</div>	 								  				
					</td>
				</tr>
				<tr>
					<th scope='row'>참여연구원</th>
					<td colspan="3" class="padding_l">
						<div>
			              <table>
				              <caption>참여연구원</caption>
				              <colgroup>
									<col width='20%' />						
									<col width='80' />								
								</colgroup>
	
								<tbody>
									<tr>
										<td class="labels">
											<label><span class="text">성&nbsp; &nbsp;명</span></label>   
											<input id="rp" name="rp"  class="full right_0" style="width:90%" value="${resultVO.rp}" type="text"  title="참여연구원"/><br>
											<%-- <label><span class="text">소&nbsp; &nbsp;속</span></label>
											<input id="rp_dept" name="rp_dept"  value="${resultVO.rp_dept}" class="full right_0"  type="text"  title="참여연구원_소속"/> --%>
										</td>						
									</tr>	
								</tbody>
			              </table>
						</div>	 								  				
					</td>																	
				</tr>
				<tr>
					<th scope='row'>발주부서<span class="txt_red">*</span></th>					
					<td colspan="3" class="labels padding_l">   							 
					<%--    <label for="center_nm"><span class="text">센 &nbsp; &nbsp;터</span> </label> <input id="center_nm" name="center_nm"  value="${resultVO.center_nm}"  class="full right_0"  type="text"  title="센터"/><br>--%>
						<label for="order_dept"><span class="text">부 &nbsp; &nbsp;서</span> </label> <input id="order_dept" name="order_dept"  value="${resultVO.order_dept}" class="full right_0" style="width:90%"  type="text"  title="발주부서"/><br>
						<label for="charger_nm"><span class="text">담당자</span> </label> <input id="charger_nm" name="charger_nm" value="${resultVO.charger_nm}"   class="full right_0" style="width:90%"  type="text"  title="담당자"/>									
					</td>
				</tr>
				<tr>
					<th scope='row'>발행자<span class="txt_red">*</span></th>
					<td colspan="3" class="padding_l">   
						<input id="org_name" name="org_name" value="${resultVO.org_name}"  class="full"  type="text"  style="width: 30%;" title="발행자"/>					
					</td>						
				</tr>			
				<tr>
					<th scope='row' >발행년도<span class="txt_red">*</span></th>
					<td>   
						<select id="pubyear"  name="pubyear" title="발행년도">
						</select>
					</td>
					<th scope='row' >연차구분<span class="txt_red">*</span></th>
					<td class="annual_num padding_l">   
					  	<select id="annual_gbn" name="annual_gbn" title="연차구분">
							<option value="1">단년도</option>
							<option value="2">다년도</option>
						</select>				        							
					 	<input id="annual_num" name="annual_num" value="${resultVO.annual_num}"  class="full" style = "width:67%" type="number"  title="연차" style="height:29px;"/>
					</td>													
				</tr>
				<tr>
					<th scope='row' >주제<span class="txt_red">*</span></th>
					<td colspan="3" class="padding_l">   
						<select id="subject"  name="subject" title="주제분류">
							<c:forEach items="${codeSubjectList}" var="subList">
								<option value="${subList.cd}">${subList.cd_nm}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<%--
				<tr>
					<th scope='row'>사업명<span class="txt_red">*</span></th>
					<td colspan="3" class="padding_l"> 						
						<input id="busi_nm" name="busi_nm" value="${resultVO.busi_nm}"   class="full input285"  type="text"  title="사업명"/>
					</td>						
				</tr>				
				<tr>
					<th scope='row'>세부사업명</th>
					<td colspan="3" class="padding_l">   												
						<input id="detail_busi_nm" name="detail_busi_nm" value="${resultVO.detail_busi_nm}" class="full input285"  type="text"  title="세부사업명"/>
					</td>						
				</tr>
				--%>
														 			  										
			    <tr>
					<th scope='row'>색인단어</th>
					<td colspan="3" class="padding_l">    		
						<div>
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
										<input id="keyword_kor" name="keyword_kor" value="<c:out value='${resultVO.keyword_kor}'/>"  class="full" type="text"  title="색인단어_한글"/>			<br/>
									</td>						
								</tr>
								<tr style="position:relative;">
									<th scope='row'>영&nbsp; &nbsp; &nbsp;문</th>
									<td style="position:absolute; right:0; width:699px;">   
										<input id="keyword_eng" name="keyword_eng" value="<c:out value='${resultVO.keyword_eng}'/>" class="full"  type="text"  title="색인단어_영문"/>
									</td>						
								</tr>	
							</tbody>
			              </table>
						</div>	 								  				
					</td>																	
				</tr>	
				<tr>
					<th scope='row' >초록</th>
					<td colspan="3" style="padding-right:0;">  
					  <div  class="item">
						<textarea id="rep_abs" name="rep_abs"    rows="15"  style= "width:100%;"    title="초록" ><c:out value="${resultVO.rep_abs}"></c:out></textarea>		
					  </div>					
					</td>							
				</tr>
				<tr>
		            <th>연차정보 </th>
		            <td colspan="3">
		              <div class="annualList">
			              <table id='insertAnnaulTable' >
			              <caption>보고서 등록</caption>
							<colgroup>
								<col width='18%' />						
								<col width='40%' />
								<col width='18%' />
								<col width='*' />	
								<col width='15%' />											
							</colgroup>
							<tbody>
								<c:choose>
								<c:when test="${fn:length(resultAnnualVO) eq 1}">		
					                 	<c:forEach items="${resultAnnualVO}" var="result" varStatus="status">
											<tr>
												<th>총연구기간</th>		              			
												<td>			
													<input type="text"  name="research_dt" value="<c:out value='${result.research_dt}'/>"	 style="width:80% ;display:inline;" title="총연구기간" />								
													<input type="hidden"  name="period_gbn" value ="<c:out value='${result.period_gbn}'/>" title="총연구기간" />									
												</td>				
												<th>총연구비</th>

												<td>		
													<input type="number" min ="0"    name="research_fund" value="<c:out value='${result.research_fund}'/>" style="width:80% ;display:inline;"   title="1차년도 연구비" />																																													
												</td>
												<td>										
												</td>											
											</tr>
										</c:forEach>
											<tr>
							              		<th>1차년도 연구기간</th>
												<td>											
													<input type="text"  name="research_dt" style="width:80% ;display:inline;"  title= "1차년도 연구기간" />
													<input type="hidden"  name="period_gbn" value ="1" title="1차년도 연구비" /> 										
												</td>
												<th>1차년도 연구비</th>
												<td>											
													<input type="number" min="0" name="research_fund" style="width:80% ;display:inline;"  title="1차년도 연구비" /> 									
												</td>
												<td>
												 	<!-- <input type="button" name="del_btn1" value="삭제" onClick="deleteAnnual(this)" border=0 style="cursor:hand"> -->
													<input type="button" name="save_btn1" value="추가" onClick="addAnnual(this.form)" border=0 style='cursor:hand'>	
												</td>
											</tr>
									</c:when>
									<c:when test="${fn:length(resultAnnualVO) > 0}">		
					                 	<c:forEach items="${resultAnnualVO}" var="result" varStatus="status">
											<tr>					              			
											<c:choose>
												<c:when test="${result.period_gbn eq '0'}">
													<th>총연구기간</th>
												</c:when>
												<c:otherwise>
													<th>${status.index}차년도 연구기간</th>
												</c:otherwise>	
											</c:choose>					              			
												<td>			
													<input type="text"  name="research_dt" value="<c:out value='${result.research_dt}'/>"	 style="width:80% ;display:inline;" title="총연구기간" />								
													<input type="hidden"  name="period_gbn" value ="<c:out value='${result.period_gbn}'/>" title="총연구기간" />									
												</td>				
											<c:choose>
												<c:when test="${result.period_gbn eq '0'}">
													<th>총연구비</th>
												</c:when>
												<c:otherwise>
													<th>${status.index}차년도 연구비</th>
												</c:otherwise>	
											</c:choose>	
												<td>		
													<input type="text"   name="research_fund" value="${result.research_fund}" style="width:80% ;display:inline;"   title="1차년도 연구비" />																																													
												</td>
												<td>
												<c:choose>
													<c:when test="${result.period_gbn eq '0'}">											
													</c:when>
													<c:when test="${result.period_gbn eq '1'}">
														<input type="button" name="save_btn1" value="추가" onClick="addAnnual(this.form)" border=0 style='cursor:hand'>
													</c:when>											
													<c:otherwise>
														<input type="button" name="del_btn1" value="삭제" onClick="deleteAnnual(this)" border=0 style="cursor:hand">											
													</c:otherwise>	
												</c:choose>			
												</td>											
											</tr>
										</c:forEach>
									</c:when>									
				             		<c:otherwise>
				             		 	<tr>
						              		<th>총연구기간</th>
											<td>											
												<input type="text"  name="research_dt"style="width:80% ;display:inline;" title="총연구기간" />	
												<input type="hidden"  name="period_gbn" value ="0" title="총연구기간" />									
											</td>
											<th>총연구비</th>
											<td>											
												<input type="text"  name="research_fund" style="width:80% ;display:inline;" title="총연구비" />										
											</td>
											<td></td>
										</tr>
										<tr>
						              		<th>1차년도 연구기간</th>
											<td>											
												<input type="text"  name="research_dt" style="width:80% ;display:inline;"  title= "1차년도 연구기간" />
												<input type="hidden"  name="period_gbn" value ="1" title="1차년도 연구비" /> 										
											</td>
											<th>1차년도 연구비</th>
											<td>											
												<input type="text"  name="research_fund" style="width:80% ;display:inline;"  title="1차년도 연구비" /> 									
											</td>
											<td>
											 	<!-- <input type="button" name="del_btn1" value="삭제" onClick="deleteAnnual(this)" border=0 style="cursor:hand"> -->
												<input type="button" name="save_btn1" value="추가" onClick="addAnnual(this.form)" border=0 style='cursor:hand'>	
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
							<input type="radio" class="radio_style2" id ="security_level_on" name="security_level" value="1" ${resultVO.security_level eq '1'?'checked="checked"':''} onclick="javascript:fn_security();"  /> <label for="security_level_on">일반과제</label>
							<input type="radio" class="radio_style2"  id ="security_level_off" name="security_level" value="0" ${resultVO.security_level eq '0'?'checked="checked"':''} onclick="javascript:fn_security();" />  <label for="security_level_off">보안과제</label>
					  	</div>
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
										<td>   
										 	<input id="security_rs" name="security_rs"  value="${resultVO.security_rs}"   class="full"  type="text"  title="보안과제 사유"/>		 			 								  				
										</td>						
									</tr>												
								</tbody>
				              </table>
						</div>	 		 								  																						  				
					</td>	
				--%>	
					
						<th scope='row'>연구결과 공개</th>
						<td colspan="3" class="padding_l">  											 
							<input type="radio" id = "con_type_visi" name="con_type" value="1" ${resultVO.con_type eq '1'?'checked="checked"':''} onclick="javascript:fn_conType();" /> <label for="con_type_visi">공개</label>
							<input type="radio" id = "con_type_hide" name="con_type" value="0" ${resultVO.con_type eq '0'?'checked="checked"':''} onclick="javascript:fn_conType();" />  <label for="con_type_hide">비공개</label>
								
							<div class="research_result">
							  <table style="width: 100%">
							  <caption>연구결과 공개</caption>
								<colgroup>
									<col width='15%' />						
									<col width='*' />								
								</colgroup>
								<tbody>
									<tr>
										<th scope='row'>비공개 사유</th>
										<td>   
											<input id="private_rs" name="private_rs" value="<c:out value='${resultVO.private_rs}'/>"  class="full"  type="text"  title="비공개 사유"/>		 								  				
										</td>						
									</tr>
									<tr>
										<th scope='row'>비공개 기간</th>
										<td>   
											  <label for="private_str_dt" class="hide"><!-- 시작일: --></label><input type="text" style="width:70px;"  maxlength="8" id="private_str_dt" value="${resultVO.private_str_dt}"  title="비공개 시작일자" name="private_str_dt" onblur="javascript:fn_validDate(this)" >
													   ~ &nbsp; <label for="private_end_dt" class="hide"><!-- 종료일: --></label><input type="text" style="width:70px;" maxlength="8" id="private_end_dt" value="${resultVO.private_end_dt}" title="비공개 종료일자"  name ="private_end_dt" onblur="javascript:fn_validDate(this)">		 								  				
										</td>						
									</tr>	
								</tbody>
							  </table>
							</div>	 								  				
						</td>				
					</tr>	
     				<tr>
				        <th scope="row">파일</th>
				        <td colspan="3" >
							<c:if test="${resultVO.atch_link_id != null}">
								<div>									
									<c:import charEncoding="utf-8"
										url="/cmm/fms/selectLinkFileInfs.do">
										<c:param name="param_atchFileId"
											value="${resultVO.atch_link_id}" />
									</c:import>
								</div>
							</c:if>
				        </td>
		       		</tr>				
					<tr id = "fileRow">
			        	<th>첨부파일</th>
			            <td id="uploadFiles" colspan="3">
						   <input type='button' onClick='fileModify();' value='파일 수정'> 
					       <input type='button' onClick='fileView();' value='파일 보기'> 
			            </td>			           
     				</tr>							
			</tbody>
		</table>
				
		<div class="btn-group">
					<a href="javascript:fn_backPage('V');" class='basic-btn'><span>취소</span></a>
					<a href="javascript:fn_backPage('R');" class='basic-btn'><span>목록으로</span></a>
					<a href="javascript:allDatafileDelete();"  class='basic-btn'><span>삭제</span></a>
					<a href="javascript:fn_save();"  class='basic-btn'><span>저장</span></a>
		</div>
	
		</div>
	</div>
</div>

	<!-- 공통  필수 PARAM  -->
	
	
   <!-- 검색 PARAM -->
	<input type="hidden" name="page" id="page" value="<c:out value='${resultVO.page}'/>" alt="pageNum" /> 
	<input type="hidden" id="searchCondition" name="searchCondition" value="<c:out value='${resultVO.searchCondition}'/>"  alt="검색콤보" />
	<input type="hidden" id="searchKeyword" name="searchKeyword" value="<c:out value='${resultVO.searchKeyword}'/>" alt="검색어" />
	
	<input type="hidden" id="rep_id" name="rep_id" value="<c:out value='${resultVO.rep_id}'/>"  alt="id" />
	
	<!-- 콤보 셋팅 -->
	
	<input type="hidden" id="combo_pubyear" name="combo_pubyear" value="<c:out value='${resultVO.pubyear}'/>" alt="pubyear">
	<input type="hidden" id="combo_annual_gbn" name="combo_annual_gbn" value="<c:out value='${resultVO.annual_gbn}'/>" alt="annual_gbn">
	<input type="hidden" id="combo_subject" name="combo_subject" value="<c:out value='${resultVO.subject}'/>" alt="subject">

	
	<!-- 처리 메세지 PARAM -->
	<input type="hidden" id="message" name="message" value="<c:out value='${message}'/>" alt="message">		
	
	
	<!-- 필터 유지 위한 PARAM -->
	<input type="hidden" name="fillterYearList_s" id="fillterYearList_s" value = "<c:out value='${resultVO.fillterYearList_s}'/>" alt="필터 발행년도" />
	
	<input type="hidden" name="fillterDeptList_s" id="fillterDeptList_s" value = "<c:out value='${resultVO.fillterDeptList_s}'/>" alt="필터 발주부서" />
	
	<input type="hidden" name="fillterSubjectList_s" id="fillterSubjectList_s" value = "<c:out value='${resultVO.fillterSubjectList_s}'/>" alt="필터 주제분류" />
	
	<input type="hidden" name="fillterYearCnt" id="fillterYearCnt" value = "<c:out value='${resultVO.fillterYearCnt}'/>" alt="필터 발행년도 CNT" />

	<input type="hidden" name="fillterDeptCnt" id="fillterDeptCnt" value = "<c:out value='${resultVO.fillterDeptCnt}'/>" alt="필터 발주부서 CNT" />
	
	<input type="hidden" name="fillterSubjectCnt" id="fillterSubjectCnt" value = "<c:out value='${resultVO.fillterSubjectCnt}'/>" alt="필터 주제분류 CNT" />
		
	<!-- 리턴 페이지  -->
	<input type="hidden" id="returnPageGbn" name="returnPageGbn" value="<c:out value='${resultVO.returnPageGbn}'/>"  alt="returnPageGbn">
	
	<input type="hidden" name="del_file_list" id="del_file_list" value="" />
	
	
	<input type="hidden" id="atch_link_id" name="atch_link_id" value="<c:out value='${resultVO.atch_link_id}'/>" alt="atch_link_id">		
</form>

<!-- 파일 다운로드폼  -->
<form id= "downForm" name=  "downForm" action ="" method="post"  enctype="multipart/form-data">
	<input type="hidden" value="<c:out value='${resultVO.rep_id}'/>" id="down_file_id" name = "down_file_id" >
</form>	
