<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="com.buildnine.util.VOSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>연구결과 및 발표 | 임상연구등록</title>
	<%@include file="../include/title.jsp" %>
	<%@include file="../include/write_session.jsp" %>

	<script type="text/javascript" src="../js/common.js"></script>
	<script type="text/javascript" src="../js/write.js"></script>
	<script type="text/javascript" src="../js/byteCheck.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function (){	

		lf_final_result_yn();
		
		$('[name=final_result_yn]').click(function(){
			lf_final_result_yn();
		});	
		
		function lf_final_result_yn()
		{
			if($('#final_result_y').prop('checked')==true)
			{
				$('#final_enrollment').prop('disabled', false);
				$('#final_enrollment').css('background', '');	
				
				$('#results_kr_file').prop('disabled', false);
				
				$('#protocol_url').prop('disabled', false);
				$('#protocol_url').prop("placeholder","URL 입력");
				$('#protocol_url').css('background', '');	
				
				$('#protocol_file').prop('disabled', false);
				
				$('#research_result').prop('disabled', false);
				$('#research_result_en').prop("placeholder","연구결과를 요약하여 기입해 주십시오.(국문)");
				$('#research_result').css('background', '');	
				$('#research_result_en').prop('disabled', false);
				$('#research_result_en').prop("placeholder","연구결과를 요약하여 기입해 주십시오.(영문)");
				$('#research_result_en').css('background', '');	
				
				//GST_kdh_20180327 논문 입력 막음
 				$('.pub_table').find('img').show();
				$('.pub_table').find('input').prop('disabled', false);
				$('.pub_table').find('textarea').prop('disabled', false);
				$('.pub_table').find('select').prop('disabled', false);
				
			} else {
				$('#final_enrollment').val('');	
				$('#final_enrollment').prop('disabled', true);	
				$('#final_enrollment').css('background', '#EFEFEF');	
				
				$('#results_kr_file').prop('disabled', true);
				
				$('#protocol_url').val('');	
				$('#protocol_url').prop('disabled', true);
				$('#protocol_url').prop("placeholder","");
				$('#protocol_url').css('background', '#EFEFEF');	
				
				$('#protocol_file').prop('disabled', true);
				
				$('#research_result').val('');	
				$('#research_result').prop('disabled', true);	
				$('#research_result').prop("placeholder","");
				$('#research_result').css('background', '#EFEFEF');	
				
				$('#research_result_en').val('');	
				$('#research_result_en').prop('disabled', true);	
				$('#research_result_en').prop("placeholder","");
				$('#research_result_en').css('background', '#EFEFEF');	
				
				//GST_kdh_20180327 논문 입력 막음
 				$('.pub_table').find('img').hide();
				$('.pub_table').find('input').prop('disabled', true);
				$('.pub_table').find('textarea').prop('disabled', true);
				$('.pub_table').find('select').prop('disabled', true); 
				
			}
		}
		
		
		
		lf_cal_add($(".rdatepicker"));	
		
		$(".rdatepicker").on('keyup', function(){
			fn_calInput(); 
		});

		
		$('#results_kr_file').change(function(){
			
			//GST_kdh_20171226 업로드 파일 확장자 제한
			var strFileExt = $("#results_kr_file").val();
			strFileExt = strFileExt.substring(strFileExt.lastIndexOf('.')+1,strFileExt.length).toLowerCase();
			if(strFileExt != "jpg" && strFileExt != "gif" && strFileExt != "pdf"
				&& strFileExt != "hwp" && strFileExt != "doc" && strFileExt != "docx" && strFileExt != "zip")
			{
				alert("jpg gif pdf hwp doc zip 파일만 업로드 가능합니다.");
				 $('#results_kr_file').val("");
				return;
			}	
			
			if(!lf_filename_chk($('#results_kr_file').val()))
			{
				if (/msie/.test(navigator.userAgent.toLowerCase())) 
				{
		            $('#results_kr_file').replaceWith($('#results_kr_file').clone(true) );
		        } else {
		            $('#results_kr_file').val("");
		        }			
			}
		});
		
		$('#protocol_file').change(function(){
			//GST_kdh_20171226 업로드 파일 확장자 제한
			var strFileExt = $("#protocol_file").val();
			strFileExt = strFileExt.substring(strFileExt.lastIndexOf('.')+1,strFileExt.length).toLowerCase();
			if(strFileExt != "jpg" && strFileExt != "gif" && strFileExt != "pdf"
				&& strFileExt != "hwp" && strFileExt != "doc" && strFileExt != "docx" && strFileExt != "zip")
			{
				alert("jpg gif pdf hwp doc zip 파일만 업로드 가능합니다.");
				 $('#protocol_file').val("");
				return;
			}		
			
			if(!lf_filename_chk($('#protocol_file').val()))
			{
				if (/msie/.test(navigator.userAgent.toLowerCase())) 
				{
		            $('#protocol_file').replaceWith($('#protocol_file').clone(true) );
		        } else {
		            $('#protocol_file').val("");
		        }	
			}
		});
		
		$('[name="final_result_yn"]').click(function(){
			if($(this).val()=='Y') {
				$('#rryes').show();
			} else {
				$('#rryes').hide();
				$('[name="final_result_type"]').prop('checked', false);
				$('#frpt').hide();
				$('#frft').hide();
			}
		});
		
		$('[name="final_result_type"]').click(function(){
			alert($(this).prop('checked'));
			if($(this).prop('checked')==true)
			{
				if($(this).val() == 'P') {
					$('#frpt').show();
				} else if($(this).val() == 'F') {
					$('#frft').show();
				}
			} else {
				if($(this).val() == 'P') {
					$('#frpt').hide();
				} else if($(this).val() == 'F') {
					$('#frft').hide();
				}				
			}
			
			
/* 			if(this.value == 'P'){
				$('#frft').hide();
				$('#frpt').show();
			} else if(this.value == 'F') {
				$('#frpt').hide();
				$('#frft').show();
			} else {
				$('#frft').hide();
				$('#frpt').hide();
			} */
		});
	});
	
	function lf_cal_add(ths){
		ths.one().datepicker({
			changeMonth: true,
			changeYear: true,
			showMonthAfterYear: true,
			yearRange: '1950:c',
			dateFormat: 'yy-mm-dd', //데이터 포멧형식
			buttonImageOnly: true,
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], // 요일의 한글 형식.
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
			//년월 셀박크기는 js에..
		}); 

		$(".cal").click(function(){
			$(this).parent().find(".rdatepicker").focus();
		});
	}	
	
	
	function lf_filename_chk(fname)
	{
		//alert("%00==="+fname.indexOf("%00")+"  ;==="+fname.indexOf(";")+"  .==="+fname.indexOf(".")+"   last.==="+fname.lastIndexOf("."));
		if(fname.indexOf("%00")>-1 || fname.indexOf(";")>-1 || (fname.indexOf(".")>-1 && (fname.indexOf(".")!=fname.lastIndexOf("."))))
		{
			alert("파일명에 다음문자가 들어간 파일은 업로드 할 수 없습니다.\n[%00 , ; , . ]");
			return false;
		}
		return true;
		/*
		if(fname!="" && fname.indexOf(".")==-1)
		{
			alert("jpg pdf gif doc hwp ppt xls zip 파일만 업로드 가능합니다.");
			return false;
		}			
  		else if(fname.indexOf(";")>-1)
		{
			alert("파일명에 ; 이 들어간 파일은 업로드 할 수 없습니다.");
			return false;
		}
		else if(fname.indexOf(".")>-1 && (fname.indexOf(".")!=fname.lastIndexOf(".")) )
		{
			alert("파일명에 . 이 두개이상 들어간 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true; */
	}
	
	<!--
		function jsMulti11(str, idx)
		{
			cnt = document.form.paper_count.value;

			if(str == "add")
			{
				sum = eval(cnt) + 1;
				for( var i = eval(idx)+eval("1"); i <= 50; i++) {
					if(document.getElementById("paper_"+i).style.display == "none")
					{
						document.getElementById("paper_"+i).style.display = "";
						break;
					}
				}
			}
			else
			{
				sum = eval(cnt) - 1;
				document.getElementById("paper_author_"+eval(idx)).value='';
				document.getElementById("paper_title_"+eval(idx)).value='';
				document.getElementById("journal_title_"+eval(idx)).value='';
				
				document.getElementById("journal_gubun_"+eval(idx)).value='';
				document.getElementById("journal_title_"+eval(idx)).value='';
				
				document.getElementById("paper_ym_"+eval(idx)).value='';
				document.getElementById("paper_vol_"+eval(idx)).value='';
				document.getElementById("paper_start_page_"+eval(idx)).value='';
				document.getElementById("paper_end_page_"+eval(idx)).value='';
				document.getElementById("paper_url_"+eval(idx)).value='';

				document.getElementById("paper_"+eval(idx)).style.display = "none";
			}
			document.form.paper_count.value = sum;
			//step11_paper_count();
		}
	
		function entCheck(evt)
		{
			if(evt.keyCode==13)
			{
				evt.returnValue=false;
			}
		}

	//-->
	</script>
</head>
<body onload="RemoveForm(11);">
<%
	ValueObject sVO = new ValueObject();
	ValueObject vo = new ValueObject();
	String temp = "";
	try {

		sVO.set(request);
		
		//GST_kdh_20181112 자신이 작성한 연구인지 확인 절차 추가
		String myin = "";
		sVO.put("rid",(String)session.getAttribute("session_userid"));
		myin = QueryAction.getQueryColumn("CRIS_DATA.myinter", sVO);

		if(myin.equals("") || myin==null) {
			out.println(StringUtil.alert("삭제되었거나 존재하지 않는 게시물입니다."));
			return;
		}
		
		if( !sVO.equals("seq", "")){
			vo = QueryAction.getQueryView("CRIS_DATA.step11", sVO);
		}

		VOSet paperList = QueryAction.getQueryList("CRIS_DATA.paper_list", sVO);
		
		int pCnt = paperList.size();
		
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
		String todate = fm.format(new java.util.Date());
		
		String s_research_title_kr = StringUtil.getTitleLimit(vo.getInputbox("research_title_kr"),83);
		String s_seq = vo.getInputbox("seq");
		String s_status = vo.getInputbox("status");
		String s_seq_group = vo.getInputbox("seq_group");
		String s_version = vo.getInputbox("version");
		String s_version_temp = vo.getInputbox("version_temp");
		String str_mod = sVO.getInputbox("mod");
		String s_final_result_y = vo.get("final_result_yn").equals("Y")?"checked":"";
		String s_final_result_n = vo.get("final_result_yn").equals("N")?"checked":"";
		String s_share_method_etc = vo.getInputbox("share_method_etc");
		String s_share_method_etc_en = vo.getInputbox("share_method_etc_en");
		String str_seq = sVO.get("seq");
		String s_study_start_date = vo.getInputbox("study_start_date");
		int s_pCnt = pCnt == 0 ? 1 : pCnt;
		String s_final_result_p = vo.getInputbox("final_result_type").indexOf("P")>-1?"checked":"";
		String s_final_result_f = vo.getInputbox("final_result_type").indexOf("F")>-1?"checked":"";
		String s_final_style_p = vo.getInputbox("final_result_type").indexOf("P")>-1?"":"style='display:none;'";
		String s_final_style_f = vo.getInputbox("final_result_type").indexOf("F")>-1?"":"style='display:none;'";
		String s_final_result_display = vo.get("final_result_yn").equals("Y")?"":"style='display:none;'";
		String s_research_result_en = vo.getInputbox("research_result_en");
		String s_research_result = vo.getInputbox("research_result");
		
		String s_protocol_file = vo.getInputbox("protocol_file");
		String s_protocol_path = vo.getInputbox("protocol_path");
		String s_final_enrollment = vo.getInputbox("final_enrollment");
		String s_results_kr_file = vo.getInputbox("results_kr_file");
		String s_results_kr_path = vo.getInputbox("results_kr_path");
		String s_protocol_url = vo.getInputbox("protocol_url");
%>
<div id="wrapper">

	<%@include file="../include/top.jsp" %>

	<div id="container">
		<div id="content">

		<div class="cris_inpset">
			<div class="cris_inpbox">    
    
			<%@include file="../include/write_left.jsp" %>

      		<% if( !vo.equals("seq", "")){ %>
				<div class="research_smy">
					<ul class="resmy_list">
						<li>상 태 : <span class="resmy_txtc01">
							<%if(vo.equals("status", "0")) {temp = ""; %>작성중<%} %>
							<%if(vo.equals("status", "1")) {temp = ""; %>제출<%} %>
							<%if(vo.equals("status", "2")) {temp = ""; %>보류<%} %>
							<%if(vo.equals("status", "3")) {temp = ""; %>보완<%} %>
							<%if(vo.equals("status", "4")) {temp = ""; %>반려<%} %>
							<%if(vo.equals("status", "5")) {temp = ""; %>승인<%} %>
							<%if(vo.equals("status", "6")) {temp = ""; %>임시저장<%} %>
						</span></li>
						<li>제 목 : <span><c:out value="<%=s_research_title_kr %>" /></span></li>
					</ul>
				</div>
			<% } %>

			<div id="sideB" class="research_tit">
				<h3><img src="../images/resch/tit2014_wstep11.gif" alt="11. 연구발표 (Publication)" /></h3>
			</div>
			
			<iframe name="iframe" title="의미없는 아이프레임" style="display:none;" width="0" height="0"></iframe>		
			<form name="form" id="form" method="post"  enctype="multipart/form-data">
			<input type="hidden" name="seq" 			id="seq" 			value="<c:out value="<%=s_seq%>" />" />
			<input type="hidden" name="status" 			id="status" 		value="<c:out value="<%=s_status%>" />" />
			<input type="hidden" name="seq_group"		id="seq_group" 		value="<c:out value="<%=s_seq_group%>" />" />
			<input type="hidden" name="version"			id="version" 		value="<c:out value="<%=s_version%>" />" />
			<input type="hidden" name="version_temp"	id="version_temp" 	value="<c:out value="<%=s_version_temp%>" />" />
			
			<input type="hidden" name="mode" 			id="mode" 			value="" />
			<input type="hidden" name="mod" id="mod" value="<c:out value="<%=str_mod%>" />" />
			<input type="hidden" name="step" id="step" />
			<input type="hidden" name="paper_count" id="paper_count" value="<c:out value="<%= s_pCnt %>" />" />
			<input type="hidden" name="title" 			id="title" 			value="<c:out value="<%=s_research_title_kr %>" />" />
			<input type="hidden" name="to_date" id="to_date" value="<%=todate%>" />
			<input type="hidden" name="study_start_date" id="study_start_date" value="<c:out value="<%=s_study_start_date%>" />" /> 
			<!-- GST_kdh_20171226 연구결과 종류 다중선택 -->
			<input type="hidden" name="rrtype_arr" id="rrtype_arr" />
			

			<div class="research_tb">
				<div class="reshtb_tit">
					<h4>연구결과 (Results)</h4>
				</div>
				
				<table cellspacing="0" cellpadding="0" border="0" summary="연구결과 등록여부, 최종 연구대상자 수, 결과 업로드, 프로토콜 URL 또는 파일 업로드 결과요약으로 구성된 연구결과 정보 입력테이블입니다.">
					<caption>연구결과 정보 입력</caption>
					<colgroup>
						<col width="170px" /><col width="70px" /><col width="*" />
					</colgroup>
					<tbody>		
						<tr>
							<th colspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" /><label for="final_result_y">연구결과 등록여부</label><a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(11,2);"><img src="../images/resch/icon2014_help.png" alt="연구결과 등록여부 설명" class="img_set" /></a>
							<br />(Result Registered)
							</th>							
							<td>

							연구결과가 논문으로 출판되었거나, 연구결과를 등록하시겠습니까?<br />
							<input type="radio" name="final_result_yn" id="final_result_y" value="Y" <c:out value="<%=s_final_result_y %>" /> /><label for="final_result_y"> 예(Yes)</label>
							<input type="radio" name="final_result_yn" id="final_result_n" value="N" <c:out value="<%=s_final_result_n %>" /> /><label for="final_result_n"> 아니오(No)</label>
							
							<span id="rryes" <c:out value="<%=s_final_result_display %>" /> >
							<br />
							<input type="checkbox" name="final_result_type" id="final_result_type_p" value="P" <c:out value="<%=s_final_result_p %>" /> /> <label for="final_result_type_p">논문으로 출판됨(Published)</label><span class="font_red" id="frpt" <c:out value="<%=s_final_style_p %>" />>* 아래 논문 항목을 작성하여 주십시오.</span><br />
							<input type="checkbox" name="final_result_type" id="final_result_type_f" value="F" <c:out value="<%=s_final_result_f %>" /> /> <label for="final_result_type_f">연구결과 파일 업로드(Results Upload)</label><span class="font_red" id="frft" <c:out value="<%=s_final_style_f %>" />>* 아래 결과 업로드 항목에 결과 파일을 업로드하여 주십시오.</span>
							</span>
							
							</td>
						</tr>						
								
						<tr>
							<th colspan="2" scope="row"><label for="final_enrollment">최종 연구대상자 수</label><a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(11,1);"><img src="../images/resch/icon2014_help.png" alt="최종 연구대상자 수 설명" class="img_set" /></a>
							<br />(Final Enrollment Number)
							</th>	
							<td>
								<input type="number" name="final_enrollment" id="final_enrollment" onkeypress="javascript:onlyNumber()" value="<%out.print(s_final_enrollment); %>" maxlength="6" oninput="fn_maxlchk(this)" style="ime-mode:disabled;width:60px;" /> 명
							</td>
						</tr>							
								 
						<tr>
							<th colspan="2" scope="row"><label for="results_kr_file">결과 업로드</label><a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(11,3);"><img src="../images/resch/icon2014_help.png" alt="결과 업로드 설명" class="img_set" /></a>
							<br />(Results Upload)
							</th>							
							<td id="result_field">
							* 연구대상자 기본정보, Participant flow, 주요 연구결과, 이상반응 등이 포함된 연구결과를 정리하여 PDF 파일로 업로드하여 주십시오.<br />
								<% String file_name = conf.get("environment.savefile.rootpath") + vo.get("results_kr_path"); file_name = file_name.replaceAll("&&&&","");
								if(!vo.equals("results_kr_file", "") && new File(file_name).exists() ) { %>
								 결과 파일 : <strong><a href="../file_download.jsp?seq=<c:out value="<%=s_seq%>" />&rf=R&fname=<c:out value="<%=s_results_kr_file%>" />"><c:out value="<%=s_results_kr_file %>" /></a></strong>
								<input type="hidden" name="results_kr_file" value="<%out.print(s_results_kr_file);%>" />
								<input type="hidden" name="results_kr_path" value="<%out.print(s_results_kr_path);%>" />
								<input type="checkbox" name="results_lastfile_del" id="results_lastfile_del" value="Y" /><span><label for="results_lastfile_del"> * 체크 후 저장하시면 파일이 삭제됩니다.</label></span><br/>
								<% } %>
								<label for="results_kr_file" class="dp_no">결과 첨부파일</label>									
								<input type="file" name="rfile" id="results_kr_file" style="width:450px;" /> <span id="result_file_text">예) JPG, GIF, PDF, HWP, DOC, ZIP 등 (단, 10M 이하)</span><!--<br />※ 예시파일 참조하여 작성 (단, 10M 이하) <a href="#">(영문)예시파일 다운로드</a></span>-->									
							</td>
						</tr>										
										

						
						<tr>
							<th colspan="2" scope="row"><label for="protocol_url">프로토콜 URL 또는 파일 업로드</label><a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(11,4);"><img src="../images/resch/icon2014_help.png" alt="연구결과 설명" class="img_set" /></a>
							<br />(Protocol URL or File Upload)
							</th>							
							<td>  
								<div class="resch_inset">
									<p>(<span id="byte_protocol_url">0</span>&#47;200Byte)</p><br />
									<input type="text" name="protocol_url" id="protocol_url" value="<%out.print(s_protocol_url);%>" placeholder="URL 입력" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="width:100%;" />
								</div>
								<%file_name = conf.get("environment.savefile.rootpath") + vo.get("protocol_path"); file_name = file_name.replaceAll("&&&&",""); 
								if(!vo.equals("protocol_file", "") && new File(file_name).exists() ) { %>
								 프로토콜 파일 : <strong><a href="../file_download.jsp?seq=<c:out value="<%=s_seq%>" />&rf=P&fname=<c:out value="<%=s_protocol_file%>" />"><c:out value="<%=s_protocol_file %>" /></a></strong>
								<input type="hidden" name="protocol_file" value="<%out.print(s_protocol_file);%>" /> 
								<input type="hidden" name="protocol_path" value="<%out.print(s_protocol_path);%>" /> 
								<input type="checkbox" name="protocol_lastfile_del" id="protocol_lastfile_del" value="Y" /><span><label for="protocol_lastfile_del"> * 체크 후 저장하시면 파일이 삭제됩니다.</label></span><br/>
								<% } %>	
								<label for="protocol_file" class="dp_no">프로토콜 첨부파일</label>										
								<input type="file" name="pfile" id="protocol_file" style="width:450px;" /> <span id="protocol_file_text">예) JPG, GIF, PDF, HWP, DOC, ZIP 등 (단, 10M 이하)</span><!--<br />※ 예시파일 참조하여 작성 (단, 10M 이하) <a href="#">(영문)예시파일 다운로드</a></span>-->									
							</td>
						</tr>																	
						<tr>
							<th rowspan="2" scope="row"><label for="research_result">결과요약</label><a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(11,5);"><img src="../images/resch/icon2014_help.png" alt="연구결과 설명" class="img_set" /></a>
							<br />(Brief Summary)
							</th>						
							<th class="textc borderset" scope="row"><label for="research_result" class="magset2">국문<br />(KOR)</label></th>
							<td>
								<div class="resch_inset">
									<p>(<span id="byte_research_result">0</span>&#47;4000Byte)</p><br />
									<textarea name="research_result" id="research_result" maxlength="4000" placeholder="연구결과를 요약하여 기입해 주십시오.(국문)" maxByte="4000" onKeyDown="byteCheck(this.id,4000);" onKeyUp="byteCheck(this.id,4000);" onChange="byteCheck(this.id,4000);" style="ime-mode:active;width:100%;height:55px;"><%out.print(s_research_result);%></textarea>
									<% if(!vo.getInputbox("research_result").equals("")){%><script type="text/javascript">byteCheck("research_result",4000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc borderset" scope="row"><label for="research_result_en" class="magset2">영문<br />(ENG)</label></th>
							<td>
								<div class="resch_inset">
									<p>(<span id="byte_research_result_en">0</span>&#47;4000Byte)</p><br />
									<textarea name="research_result_en" id="research_result_en" maxlength="4000" placeholder="연구결과를 요약하여 기입해 주십시오.(영문)"  maxByte="4000" onKeyDown="byteCheck(this.id,4000);" onKeyUp="byteCheck(this.id,4000);" onChange="byteCheck(this.id,4000);" style="ime-mode:inactive;width:100%;height:55px;"><%out.print(s_research_result_en);%></textarea>
									<% if(!vo.getInputbox("research_result_en").equals("")){%><script type="text/javascript">byteCheck("research_result_en",4000);</script><%}%>
								</div>
							</td>
						</tr>
					</tbody>
				</table>	

				<div class="reshtb_tit margintop15">
					<h4>연구발표 (Publication)</h4>
					<span>: 본 연구의 수행으로 게재한 논문을 영문으로 작성</span>
				</div>
			<%
			ValueObject paperVo = null;
			for( int i = 1; i <= 50; i++) 
			{
				if( paperList.size() >= i ){
					paperVo = paperList.get(i-1);
				} else {
					paperVo = new ValueObject();
				}
			String s_class = i==1?"":"class='bobor'";	
			String s_style = i <=(pCnt == 0 ? 1 : pCnt) ? "display:;":"display:none;";	
			String s_paper_author = paperVo.getInputbox("paper_author");	
			String s_paper_title = paperVo.getInputbox("paper_title");	
			String s_journal_title = paperVo.getInputbox("journal_title");	
			String s_paper_ym = paperVo.getInputbox("paper_ym");	
			String s_paper_vol = paperVo.getInputbox("paper_vol");	
			String s_paper_start_page = paperVo.getInputbox("paper_start_page");	
			String s_paper_end_page = paperVo.getInputbox("paper_end_page");	
			String s_paper_url = paperVo.getInputbox("paper_url");	
			String s_paper_1 = paperVo.getInputbox("journal_gubun").equals("")?"selected":"";
			String s_paper_2 = paperVo.getInputbox("journal_gubun").equals("SCI")?"selected":"";
			String s_paper_3 = paperVo.getInputbox("journal_gubun").equals("Non SCI")?"selected":"";
			
			%>						
				<table class="pub_table" <c:out value="<%=s_class%>" /> id="paper_<c:out value="<%=i%>" />" style="<c:out value="<%= s_style %>" />" cellspacing="0" cellpadding="0" border="0" summary="저자명, 논문제목, 저널명, 발행일, 논문 URL로 구성된 연구발표 정보 입력테이블입니다.">
					<caption>연구발표 정보 입력</caption>
					<colgroup>
						<col width="200px" /><col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th colspan="2" class="tbtit" scope="col">논문 <%=i %>
								<ul class="retb_list">
									<li><a href="#add" onclick="jsMulti11('add','<%=i%>')" ><img src="../images/resch/btn2014_add.png" alt="추가" /></a></li>
									<%if(i!=1){%><li><a href="#minus" onclick="jsMulti11('del','<%=i%>')" ><img src="../images/resch/btn2014_del.png" alt="삭제" /></a></li><%}%>										
								</ul>
							</th>
						<tr>
						<tr>
							<th scope="row"><label for="paper_author_<%=i %>">저자명(Author)</label></th>
							<td>
								<div class="resch_inset">
									<p>(<span id="byte_paper_author_<%=i %>">0</span>&#47;200Byte)</p><br />
									<input type="text" name="paper_author_<%=i%>" id="paper_author_<%=i %>" value="<%out.print(s_paper_author);%>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="width:100%;" />
									<% if(!paperVo.get("paper_author").equals("")){%><script type="text/javascript">byteCheck("paper_author_<%=i %>",200);</script><%}%>
								</div>
							</td>   
						</tr>
						<tr>
							<th scope="row"><label for="paper_title_<%=i %>">논문제목(Title)</label></th>
							<td>
								<div class="resch_inset">
									<p>(<span id="byte_paper_title_<%=i %>">0</span>&#47;4000Byte)</p><br />
									<textarea name="paper_title_<%=i%>" id="paper_title_<%=i %>" maxlength="4000"  maxByte="4000"  onKeyDown="byteCheck(this.id,4000);" onKeyUp="byteCheck(this.id,4000);" onChange="byteCheck(this.id,4000);" style="width:100%;height:50px;"><%out.print(s_paper_title);%></textarea>
									<% if(!paperVo.get("paper_title").equals("")){%><script type="text/javascript">byteCheck("paper_title_<%=i %>",4000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th rowspan="2" scope="row"><label for="journal_gubun_<%=i %>">저널명(Journal Name)</label></th>
							<td class="borderset">
								<select name="journal_gubun_<%=i%>" id="journal_gubun_<%=i %>" title="저널명 선택">
									<option value="" <c:out value="<%=s_paper_1%>" />>::선택::</option>
									<option value="SCI" <c:out value="<%=s_paper_2%>" />>SCI</option>
									<option value="Non SCI" <c:out value="<%=s_paper_3%>" />>Non SCI</option>
								</select>	
							</td>						
						</tr>
						<tr>
							<td>
								<div class="resch_inset">
									<p>(<span id="byte_journal_title_<%=i %>">0</span>&#47;200Byte)</p>
									<input type="text" name="journal_title_<%=i%>" id="journal_title_<%=i %>" title="논문 <%=i %> 저널명" value="<%out.print(s_journal_title);%>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="width:100%;" />
									<% if(!paperVo.get("journal_title").equals("")){%><script type="text/javascript">byteCheck("journal_title_<%=i %>",200);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="paper_ym_<%=i %>">발행일(Publication Date)</label></th>
							<td>

								<input type="text" class="rdatepicker" name="paper_ym_<%=i%>" id="paper_ym_<%=i%>" value="<%out.print(s_paper_ym);%>" maxlength="10" style="width:75px;" />
								<img id="paper_ym_<%=i%>_cal_btn" src="../images/resch/btn2014_calendar.png" alt="논문 발행일자 달력버튼" class="cal" />


<%-- 								<select name="paper_year_<%=i%>" id="paper_year_<%=i %>" title="발행연도 선택">
									<option value="">년도</option>
									<% for( int j = StringUtil.toInt(StringUtil.getYear()); j > 1980; j-- ){ %>
									<option value="<%=j%>" <%=paperVo.equalsGet("paper_year", String.valueOf(j), "selected", "") %>><%=j %> 년</option>
									<% } %>
								</select>
								<select name="paper_month_<%=i%>" id="paper_month_<%=i %>" style="width:70px;" title="발행월 선택">
									<option value="">월</option>
									<% for( int j = 1; j <= 12; j++ ){ %>
									<option value="<%=StringUtil.addZero(j,2) %>" <%=paperVo.getInputbox("paper_month").equals(StringUtil.addZero(j,2))?"selected":""%>><%=StringUtil.addZero(j,2) %> 월</option>
									<% } %>
								</select> --%>
								<label for="paper_vol_<%=i %>" class="magset">vol</label><input type="tel" name="paper_vol_<%=i%>" id="paper_vol_<%=i %>" title="논문 <%=i %> vol"  value="<%out.print(s_paper_vol);%>" onkeypress="javascript:onlyNumber();" maxlength="5" style="ime-mode:disabled;width:100px;" />
								<label for="paper_start_page_<%=i %>" class="magset">page</label><input type="tel" name="paper_start_page_<%=i%>" id="paper_start_page_<%=i %>" title="논문 <%=i %> 시작페이지" value="<%out.print(s_paper_start_page);%>" onkeypress="javascript:onlyNumber();" maxlength="5" style="ime-mode:disabled;width:100px;" />
								 ~ <input type="tel" name="paper_end_page_<%=i%>" id="paper_end_page_<%=i %>" title="논문 <%=i %> 끝페이지" value="<%out.print(s_paper_end_page);%>" onkeypress="javascript:onlyNumber();" maxlength="5" style="ime-mode:disabled;width:100px;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="paper_url_<%=i %>">논문 URL(Publication URL)</label></th>
							<td>
								<input type="text" name="paper_url_<%=i%>" id="paper_url_<%=i %>" value="<%out.print(s_paper_url);%>"  maxlength="200" style="width:100%;" />
							</td>
						</tr>
					<%} %>	 
					</tbody>
				</table>
			</form>
				<ul class="research_noice">
					<li class="font_red"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />WHO ICTRP (International Clinical Trial Registry Platform)에서 요구하는 필수등록항목입니다.</li>
					<li class="font_blue"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />CRIS 필수등록항목입니다.</li>
				</ul>
			</div>
			
			<div class="res_btnbox">		
				<ul class="research_btn">
					<li><a href="#preview" title="(새창으로 이동)" onclick="preView(11);" ><img src="../images/resch/btn_preview.gif" alt="미리보기" /></a></li>			
					<li><a href="#removeAll" onclick="Remove(11);" ><img src="../images/resch/btn_allcancel.gif" alt="모두 지우기" /></a></li>
					<li><a href="#tempSave" onclick="TempSave(11);" ><img src="../images/resch/btn_storage.gif" alt="임시저장" /></a></li>
				<% if(sVO.equals("mod", "")){ %>
					<li><a href="#save" onclick="Save(11);" ><img src="../images/resch/btn_nextstep2.gif" alt="다음 단계로" /></a></li>
				<% }else{ %>
					<li><a href="#cancel" onclick="javascript:fn_cancel('<c:out value="<%=str_seq%>" />')" ><img src="../images/resch/btn_cancel2.gif" alt="취소" /></a></li>
				<% } %>									
				</ul>
			</div>

		</div><!-- cris_inpbox -->
		</div><!-- cris_inpset -->
		
		</div><!-- content -->
		</div><!-- container --> 
	<%@include file="../include/footer.jsp" %>
</div>
<%
	} catch(NullPointerException e){
    	System.err.println("NP 오류 발생");
	} catch(NumberFormatException e){
		System.err.println("NF 오류 발생");
	} catch(Exception e){
		System.err.println("EX 오류 발생");
    } finally {

	}
%>
</body>
</html>