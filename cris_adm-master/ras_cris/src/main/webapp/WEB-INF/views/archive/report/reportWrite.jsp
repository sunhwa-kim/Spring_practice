<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<script type="text/javascript">
$(function(){
	
	if($("#message").val() != ''){
		var msg = $("#message").val();
	
			alert(msg);

    }
    $("#message").val('');
    
    
    
	cmmfn_set_datepicker($("#private_str_dt"), "yy-mm-dd");
	cmmfn_set_datepicker($("#private_end_dt"), "yy-mm-dd");
	
	getYear("pubyear",10,0);

	//파일 링크 id
	GetDateTMS();
	
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
	
	//수정
	function fn_save(){
		
	
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
	 	
		var form  = document.reqForm;
			
		form.submit();
	}
	
	
	
    // 날짜 유효성 체크
	function fn_validDate(obj) {
 
	 	var str =  $(obj).val();
	
		  if(str!=""){
		
			  oDate = new Date();
			  oDate.setFullYear(str.substring(0, 4));
			  oDate.setMonth(parseInt(str.substring(5, 7)) - 1);
			  oDate.setDate(str.substring(8,10));
	
			  if( oDate.getFullYear()     != str.substring(0, 4)
			      || oDate.getMonth() + 1 != str.substring(5, 7)
			      || oDate.getDate()      != str.substring(8,10) ) {
		   	    
			  alert("날짜 형식이 유효하지 않습니다.");
			  $(obj).val("");
			  $(obj).focus();
			  
		      return false;
		      
		 	  }
		  }
    }
	
	
	// 파일 추가	
	function addFile(form){
	    if($('input[type=file]').length > 4) return false;
	    var getTable = document.getElementById("insertTable");
	var oCurrentRow = getTable.insertRow(getTable.rows.length);
	    var oCurrentCell = oCurrentRow.insertCell(0);
	    var html = '<tr><td><INPUT TYPE="FILE"  onchange="javascript:fileCheck(this , 100 , \'report\');" NAME="uploadFile" size=25 style="width:60%;"></td>';
	    	html += '&nbsp;<input type="button" name="del_btn" value="삭제" onClick="deleteFile(this)" border=0 style="cursor:hand"></tr>';
	    oCurrentCell.innerHTML =html;
	}
	
	//첨부파일 삭제
	function deleteFile(obj){
		var agent = navigator.userAgent.toLowerCase(); 
		
		if($(obj).parent().parent().index() == 0){
			if (agent.indexOf("msie") != -1) {
				$(obj).parent().find('input[type=file]').replaceWith( $(obj).parent().find('input[type=file]').clone(true) );
			} else {
				$(obj).parent().find('input[type=file]').val('');
			}
	    }else{
	    	$(obj).parent().parent().remove();
	   }
	}
	
	// 파일 추가	
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
	
	//첨부파일 삭제
	function deleteAnnual(obj){

		var agent = navigator.userAgent.toLowerCase(); 
		if($(obj).parent().parent().index() == 0){
			if (agent.indexOf("msie") != -1) {
				$(obj).parent().find('input[name=research_dt]').replaceWith( $(obj).parent().find('input[name=research_dt]').clone(true) );
			} else {
				$(obj).parent().find('input[name=research_dt]').val('');
			}
	    }else{
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
////*******  첨부파일(공통)	STR **********/// 
// 파일 첨부 id 셋팅
function GetDateTMS() { 
    var localTime = new Date(); 
	var year= localTime.getFullYear(); 
	var month= localTime.getMonth() +1; 
    var date = localTime.getDate(); 
    var hours = localTime.getHours(); 
    var minutes = localTime.getMinutes(); 
    var seconds = localTime.getSeconds(); 
    var milliseconds = localTime.getMilliseconds(); 
    var totalTime = leadingZeros(year,4)+leadingZeros(month,2)+leadingZeros(date,2)+leadingZeros(hours,2)+leadingZeros(minutes,2)+leadingZeros(seconds,2)+leadingZeros(milliseconds,3); 

    $("#atch_link_id").val(totalTime);
}
 

 function leadingZeros(n, digits) { 
     var zero = ''; 
 	n = n.toString(); 

 	if (n.length < digits) { 
       for (var i = 0; i < digits - n.length; i++) 
 		 zero += '0'; 
 	} 
 	  return zero + n; 
 }

	// 첨부파일(공통) 등록
	function fileUpload() {

		var atchLinkId = $("#atch_link_id").val();
		
		var contextName = "ncmik";
		var fileKey = atchLinkId;
		var userId = "${userVo.emplyrkey}";
		var savePath = "archive_report";
		var pageTitle = "";
		
		if($("#proj_tit_kor").val() != ""){
			pageTitle = $("#proj_tit_kor").val();
		}else{
			pageTitle = $("#proj_tit_eng").val();
		}

		popAttfileUpload(fileKey, contextName, userId, savePath, pageTitle);
	  }
	  
	// 첨부파일(공통) 수정
	function fileModify() {
	 
		var atchLinkId = $("#atch_link_id").val();
		
	 	var contextName = "ncmik";
	    var fileKey = atchLinkId;
	 	var userId = "${userVo.emplyrkey}";
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
		alert(atchLinkId);
		var contextName = "ncmik";
		var fileKey = atchLinkId;
		var pageTitle = "";
		
		if($("#proj_tit_kor").val() != ""){
			pageTitle = $("#proj_tit_kor").val();
		}else{
			pageTitle = $("#proj_tit_eng").val();
		}

		popAttfileViewIn(fileKey, contextName, pageTitle);
	}

	</script>


 
		
 <form id="reqForm" name="reqForm" action="${ctxt}/archive/report/insertArchiveReport.do?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
	
	
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>아카이브</span>
			<span> > </span>
			<span>보고서</span>        
			<span> > </span>
			<span class="active">보고서 신규등록</span>
		</div>
		<span href="#" class="center_text_01">아카이브</span>
	</div> 		
	<div class="under_bar"></div>
	
	<div class = "content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div class="list_title">
					<p id="search_cn">보고서 신규등록<span id="topCnt"></span></p>
				</div>	
				<table class="view_table">
						<caption>보고서 등록</caption>
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
									<input id="busino" name="busino"  class="full"  type="text"  title="과제번호"/>				
								</td>								
							</tr>
							 <tr>
								<th scope='row'>연구과제명  <span class="txt_red">*</span></th>
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
												<input id="proj_tit_kor" name="proj_tit_kor"  class="full"  type="text" title="연구과제명_한글"/><br>
											</td>
										</tr>	
										<tr style="position:relative;">
											<th scope='row' style="text-align:left;">영&nbsp; &nbsp; &nbsp;문</th>
											<td style="position:absolute; right:0; width:699px;">   
												<input id="proj_tit_eng" name="proj_tit_eng"  class="full"  type="text"  title="연구과제명_영문"/>
											</td>						
										</tr>	
									</tbody>
					              </table> 								  				
								</td>
							</tr>
							<tr>
								<th scope='row'>책임연구원  <span class="txt_red">*</span></th>
								<td colspan="3" class="padding_l">  							
									<div>
						              <table>
						              <caption>책임연구원</caption>
										<colgroup>
											<col width='20%' />						
											<col width='80' />								
										</colgroup>
										<tbody>
											<tr>
												<td class="labels">	
													<label><span class="text">성 &nbsp; &nbsp;명</span></label>
													<input id="pi" name="pi"  class="full right_0" style="width:90%" type="text"  title="책임연구원"> <br>
													<!-- <label><span class="text">소 &nbsp; &nbsp;속</span></label>
													<input id="pi_dept" name="pi_dept"  class="full right_19"  type="text"  title="책임연구원_소속"/> -->
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
													<input id="rp" name="rp"  class="full right_0" style="width:90%"  type="text"  title="참여연구원"/><br>
   													<!-- <label><span class="text">소&nbsp; &nbsp;속</span></label>
													<input id="rp_dept" name="rp_dept"  class="full right_0"  type="text"  title="참여연구원_소속"/> -->
												</td>						
											</tr>	
										</tbody>
						              </table>
									</div>	 								  				
								</td>																	
							</tr>
							<tr>
								<th scope='row'>발주부서  <span class="txt_red">*</span></th>
								<td colspan="3" class="labels padding_l">   							 
								    <!-- <label for="center_nm"><span class="text">센 &nbsp; &nbsp;터</span> </label> <input id="center_nm" name="center_nm"  class="full right_0"  type="text"  title="센터"/><br> -->
									<label for="order_dept"><span class="text">부 &nbsp; &nbsp;서</span> </label> <input id="order_dept" name="order_dept"  class="full right_0" style="width:90%" type="text"  title="발주부서"/><br>
									<label for="charger_nm"><span class="text">담당자</span> </label> <input id="charger_nm" name="charger_nm"  class="full right_0" style="width:90%" type="text"  title="담당자"/>									
								</td>
							</tr>
							<tr>
								<th scope='row'>발행자  <span class="txt_red">*</span></th>
								<td colspan="3" class="padding_l">   
									<input id="org_name" name="org_name"  class="full"  type="text" title="발행자"/>					
								</td>																
							</tr>								
							<tr>
								<th scope='row' >발행년도  <span class="txt_red">*</span></th>
								<td>   
									<select id="pubyear"  name="pubyear" title="발행년도">
									</select>
								</td>
								<th scope='row' >연차구분  <span class="txt_red">*</span></th>
								<td class="annual_num padding_l">   
								  	<select id="annual_gbn" name="annual_gbn" title="연차구분">
										<option value="1">단년도</option>
										<option value="2">다년도</option>
									</select>
							        <input id="annual_num" name="annual_num"  class="full" style = "width:67%"  type="number"  title="연차" style="height:29px;"/>							
								</td>													
							</tr>
							<tr>
								<th scope='row' >주제<span class="txt_red">*</span></th>
								<td colspan="3">   
									<select id="subject"  name="subject" title="주제분류">
										<c:forEach items="${codeSubjectList}" var="subList">
											<option value="${subList.cd}">${subList.cd_nm}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<!-- <tr>
								<th scope='row'>사업명   <span class="txt_red">*</span></th>
								<td colspan="3" class="padding_l">   
									<input id="busi_nm" name="busi_nm"  class="full input285"  type="text"  title="사업명"/>		
								</td>
							</tr>
							<tr>	
								<th scope='row'>세부사업명</th>
								<td colspan="3" class="padding_l">   		
									<input id="detail_busi_nm" name="detail_busi_nm"  class="full input285"  type="text"  title="세부사업명"/>						
								</td>						
							</tr>		 -->				
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
													<input id="keyword_kor" name="keyword_kor"  class="full" type="text"  title="색인단어_한글"/>			<br/>
												</td>						
											</tr>
											<tr style="position:relative;">
												<th scope='row'>영&nbsp; &nbsp; &nbsp;문</th>
												<td style="position:absolute; right:0; width:699px;">   
													<input id="keyword_eng" name="keyword_eng"  class="full"  type="text"  title="색인단어_영문"/>
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
									<textarea id="rep_abs" name="rep_abs"    rows="15"    title="초록" style="width:100%;"></textarea>		
								  </div>					
								</td>							
							</tr>		
							<tr>
					            <th>연차정보</th>
					            <td colspan="3">
					              <div class="annualList">
						              <table id='insertAnnaulTable'>
						              <caption>보고서 등록</caption>
										<colgroup>
											<col width='20%' />						
											<col width='*' />
											<col width='20%' />
											<col width='*' />	
											<col width='15%' />											
										</colgroup>
										<tbody>
							              	<tr>
							              		<th>총연구기간</th>
												<td>											
													<input type="text"  name="research_dt" style="width:80% ;display:inline;" title="총연구기간" />	
													<input type="hidden"  name="period_gbn" value ="0" title="총연구기간" />									
												</td>
												<th>총연구비</th>
												<td>											
													<input type="text"  name="research_fund"style="width:80% ;display:inline;" onkeydown="numberChk();" title="총연구비" />										
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
													<input type="text" name="research_fund" style="width:80% ;display:inline;"  title="1차년도 연구비" />										
												</td>
												<td>
													<!-- <input type="button" name="del_btn" value="삭제" onClick="deleteAnnual(this)" border=0 style="cursor:hand"> -->
													<input type="button" name="save_btn" value="추가" onClick="addAnnual(this.form)" border=0 style='cursor:hand'>	
												</td>
											</tr>
										</tbody>
						              </table>
									</div>
					            </td>
	        				</tr>

							<tr>
							<%-- 
								<th scope='row'>보안등급</th>
								<td>   
									<input type="radio" id ="security_level_on" name="security_level" value="1" checked="checked" onclick="javascript:fn_security();"  /> <label for="security_level_on">일반과제</label>
									<input type="radio" id ="security_level_off" name="security_level" value="0"  onclick="javascript:fn_security();" />  <label for="security_level_off">보안과제</label>
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
													 	<input id="security_rs" name="security_rs"  class="full"  type="text"  title="보안과제 사유"/>		 			 								  				
													</td>						
												</tr>												
											</tbody>
							              </table>
									</div>	 		 								  											
														  				
								</td>
							--%>								
								<th scope='row'>연구결과 공개</th>
									<td colspan="3" class="padding_l">  	
									<input type="radio" id = "con_type_visi" name="con_type" value="1" checked="checked" onclick="javascript:fn_conType();" /> <label for="con_type_visi">공개</label>
								 	<input type="radio" id = "con_type_hide" name="con_type" value="0" onclick="javascript:fn_conType();" />  <label for="con_type_hide">비공개</label>
									<div class="research_result">
						                <table style="width:100%;">
						              <caption>연구결과 공개</caption>
										<colgroup>
											<col width='25%' />					
											<col width='*' />								
										</colgroup>
										<tbody>
											<tr>
												<th scope='row'>비공개 사유</th>
												<td>   
													<input id="private_rs" name="private_rs"  class="full"  type="text"  title="비공개 사유"/>		 								  				
												</td>						
											</tr>
											<tr>
												<th scope='row'>비공개 기간</th>
													<td style="text-align:center;">   
													  <label for="private_str_dt" class="hide"><!-- 시작일: --></label><input type="text" style="width:70px;"  maxlength="8" id="private_str_dt"  title="비공개 시작일자" name="private_str_dt" onblur="javascript:fn_validDate(this)" >
													   ~ &nbsp; <label for="private_end_dt" class="hide"><!-- 종료일: --></label><input type="text" style="width:70px;" maxlength="8" id="private_end_dt" title="비공개 종료일자"  name ="private_end_dt" onblur="javascript:fn_validDate(this)">		 								  				
												</td>						
											</tr>	
										</tbody>
						              </table>
									</div>	 								  				
								</td>																		
							</tr>							
						<tr id = "fileRow">
					    	<th>첨부파일</th>
				        	<td id="uploadFiles" colspan="3">			
								 <input type='button' onClick='fileUpload();' value='파일 올리기'>
					             <input type='button' onClick='fileModify();' value='파일 수정'> 
					             <input type='button' onClick='fileView();' value='파일 보기'> 
				            </td>
        				</tr>								
					</tbody>
				</table>
				 
				<div class="btn-group">				
					<a href='javascript:fn_save()'  class='basic-btn' ><span>저장</span></a>
				</div>
			</div>
		</div>
	</div>
	<!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" />	
	<input type="hidden" id="message" name="message" value="${message}" alt="message">		
	<input type="hidden" id="atch_link_id" name="atch_link_id" value="" alt="atch_link_id">

</form>		
	
	