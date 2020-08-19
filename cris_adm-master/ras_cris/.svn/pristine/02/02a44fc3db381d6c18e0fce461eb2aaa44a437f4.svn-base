<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="com.buildnine.util.VOSet"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>임상연구윤리심의 | 임상연구등록</title>
	<%@include file="../include/title.jsp" %>
	<%@include file="../include/write_session.jsp" %>
	<script type="text/javascript" src="../js/common.js"></script>
	<script type="text/javascript" src="../js/write.js"></script>
	<script type="text/javascript" src="../js/byteCheck.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function (){	
		if($("#status").val()!='5' && $("#status").val()!='6')
		{
			$(".datepicker").on('keyup',function(){
				fn_calInput();
			});
			
			lf_cal_add($(".datepicker"));				//달력
		}else{
			$(".datepicker").attr("readonly",true);
			$("#irb_file").hide();
			$("#irb_file_text").hide();
		}
		lf_irb_check();
		
		$('#irb_file').change(function(){
			if(!lf_filename_chk($('#irb_file').val()))
			{
				if (/msie/.test(navigator.userAgent.toLowerCase())) 
				{
		            $('#irb_file').replaceWith($('#irb_file').clone(true) );
		        } else {
		            $('#irb_file').val("");
		        }
			}
		});
		
	});
	
	function lf_filename_chk(fname)
	{
		//alert("%00==="+fname.indexOf("%00")+"  ;==="+fname.indexOf(";")+"  .==="+fname.indexOf(".")+"   last.==="+fname.lastIndexOf("."));
		if(fname.indexOf("%00")>-1 || fname.indexOf(";")>-1 || (fname.indexOf(".")>-1 && (fname.indexOf(".")!=fname.lastIndexOf("."))))
		{
			alert("파일명에 다음문자가 들어간 파일은 업로드 할 수 없습니다.\n[%00 , ; , . ]");
			return false;
		}
		if(fname!="" && fname.indexOf(".")==-1)
		{
			alert("jpg pdf gif doc hwp ppt xls zip 파일만 업로드 가능합니다.");
			return false;
		}					
		return true;
	}
	
	
	function lf_cal_add(ths){
		ths.one().datepicker({
			changeMonth: true,
			changeYear: true,
			showMonthAfterYear: true,
			yearRange: '1950:c+20',
			dateFormat: 'yy-mm-dd', //데이터 포멧형식
			buttonImageOnly: true,
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], // 요일의 한글 형식.
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
			//년월 셀박크기는 js에..
		}); 
		$(".cal").click(function(){
			$(this).parent().find(".datepicker").focus();
		});
	}
	
	function lf_irb_check()
	{
		if($("#status").val()=='5' || $("#status").val()=='6')
		{
			$("#irb_status option").not(":selected").attr("disabled","disabled");
			$("#irb_status").css({"background-color":"#EFEFEF"});
			$("#irb_number").attr('readonly',true);
			$("#irb_number").css({"background-color":"#EFEFEF"});
			$("#cal_irb_date").hide();
			$("#irb_date").css({"background-color":"#EFEFEF"});
		}
	}
	
	function entCheck(evt)
	{
		if(evt.keyCode==13)
		{
			evt.returnValue=false;
		}
	}

	function fn_irbSearch(){
		var IrbSearch = window.open("../pop/irb_search.jsp", "IrbSearch", "width=850px, height=532px, left=200px, top=100px");
		IrbSearch.focus();
	}
	
	</script>
</head>
<body onload="RemoveForm(2);">
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
		
		String strEmail = conf.getString("environment.email_list");

		if( !sVO.equals("seq", "")){
			vo = QueryAction.getQueryView("CRIS_DATA.step2", sVO);

			if( !vo.equals("irb_email", "")){

				String[] arrEmail = StringUtil.splitStr(vo.get("irb_email"), "@");
				vo.put("irb_email_id", arrEmail[0]);
				vo.put("irb_email_domain", arrEmail[1]);
			}

			if( !vo.equals("irb_email_domain", "") &&  strEmail.indexOf(vo.get("irb_email_domain")) == -1 ){
				vo.put("irb_emailDomain", "-");
			}

		}
		//VOSet nationList = QueryAction.getQueryList("CODE.nation_list2", sVO);
		//VOSet oversightList = QueryAction.getQueryList("CODE.oversight", sVO);
		
		sVO.put("code_grp", "AREACODE");
		VOSet areaList = QueryAction.getQueryList("CODE.cmcd_list", sVO);


		String irbpstr = vo.getInputbox("irb_phone");
 		String[] irbp = vo.getInputbox("irb_phone").split("-");

 			
/* 		irbp[0]="";
		irbp[1]="";
		irbp[2]="";  */
		/*
 		if(vo.get("irb_phone")!=""){
			irbp = vo.getInputbox("irb_phone").split("-");
		} */
		
		
		String aField = "";
		ValueObject ao;
		aField += "<select name='irb_phone1' class='nation0input' id='irb_phone1' title='위원회 전화번호 지역번호선택' style='width:90px;'>";
		
		if(areaList!=null && areaList.size()>0)
		{
			for(int i=0; i<areaList.size(); i++)
			{
				ao = areaList.get( i ) ;
				if(ao.get("code_id")!=""){
					aField += "<option value='"+ao.get("code_id")+"' "+(irbp[0].equals((String)ao.get("code_id"))?"selected":"")+">"+ao.get("code_name")+"("+ao.get("code_id")+")"+"</option>";
				} /* else {
					 aField += "<option value='"+ao.get("code_id")+"' "+(irbp[0].equals((String)ao.get("code_id"))?"selected":"")+">"+ao.get("code_name")+"</option>";
				} */
				
			}
		}
		aField += "</select>";
		
		String s_seq = sVO.get("seq");
		String v_seq = vo.getInputbox("seq");
		String v_status = vo.getInputbox("status");
		String v_seq_group = vo.getInputbox("seq_group");
		String v_mod = sVO.getInputbox("mod");
		String v_study_start_date = vo.getInputbox("study_start_date");
		String research_title_kr = StringUtil.getTitleLimit(vo.getInputbox("research_title_kr"),83);
		String v_irb_status_1 = vo.getInputbox("irb_status").equals("제출 전(Request not yet submitted)")?"selected":"";
		String v_irb_status_2 = vo.getInputbox("irb_status").equals("제출 후 심사중(Submitted pending)")?"selected":"";
		String v_irb_status_3 = vo.getInputbox("irb_status").equals("제출 후 승인(Submitted approval)")?"selected":"";
		String v_irb_status_4 = vo.getInputbox("irb_status").equals("제출 후 면제(Submitted exempt)")?"selected":"";
		String v_irb_status_5 = vo.getInputbox("irb_status").equals("제출 후 거부(Submitted denied)")?"selected":"";
		String v_irb_status_6 = vo.getInputbox("irb_status").equals("제출 불필요(Submission not required)")?"selected":"";
		String v_irb_number = vo.getInputbox("irb_number");
		String v_irb_date = vo.getInputbox("irb_date");
		String v_irb_file = vo.getInputbox("irb_file");
		String v_irb_path = vo.getInputbox("irb_path");
		String v_irb_committee_kr = vo.getInputbox("irb_committee_kr");
		String v_irb_committee_en = vo.getInputbox("irb_committee_en");
		String v_irb_agency_address_kr = vo.getInputbox("irb_agency_address_kr");
		String v_irb_agency_address_en = vo.getInputbox("irb_agency_address_en");
		String v_irb_seq = vo.getInputbox("irb_seq");
		String v_irb_agency_zip = vo.getInputbox("irb_agency_zip");
		String v_irbpstr_1 = irbpstr.equals("")?"":irbp[1];
		String v_irbpstr_2 = irbpstr.equals("")?"":irbp[2];
		String v_data_monitor_committee_y = vo.getInputbox("data_monitor_committee_yn").equals("Y")?"checked":"";
		String v_data_monitor_committee_n = vo.getInputbox("data_monitor_committee_yn").equals("N")?"checked":"";
		String v_data_monitor_committee_kr = vo.getInputbox("data_monitor_committee_kr");
		String v_data_monitor_committee_en = vo.getInputbox("data_monitor_committee_en");
		
		
		//ddddddddddddddddddddddddddd
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
						<li>제 목 : <span><c:out value="<%=research_title_kr %>" escapeXml="false" /></span></li>
					</ul>
				</div>
			<% } %>
			
			<div id="sideB" class="research_tit">
				<h3><img src="../images/resch/tit2014_wstep02.gif" alt="2. 임상연구윤리심의 (Institutional Review Board/Ethics Committee)" /></h3>
			</div>
			<div class="research_tb">

				<iframe name="iframe" title="의미없는 아이프레임" style="display:none;" width="0" height="0"></iframe>
					<form name="form" id="form" method="post" enctype="multipart/form-data">
					<input type="hidden" name="seq" 	id="seq"	value="<c:out value="<%=v_seq%>" />" />
					<input type="hidden" name="status" 	id="status" 	value="<c:out value="<%=v_status%>" />" />
					<input type="hidden" name="seq_group"	id="seq_group" 	value="<c:out value="<%=v_seq_group%>" />" />
					<input type="hidden" name="mode" 	id="mode" 	value="" />
					<input type="hidden" name="mod" id="mod" value="<c:out value="<%=v_mod%>" />" />
					<input type="hidden" name="step" id="step" />
					<input type="hidden" name="study_start_date" id="study_start_date" value="<c:out value="<%=v_study_start_date%>" />" />
					
				<table cellspacing="0" cellpadding="0" border="0" summary="승인상태, 승인번호, 승인일, 승인서제출, 위원회, 자료모니터링 위원회로 구성된 임상연구윤리심의 입력테이블입니다.">
					<caption>임상연구윤리심의 입력</caption>
					<colgroup>
						<col width="120px" /><col width="90px" /><col width="70px" /><col width="80px" /><col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th colspan="3" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" /><label for="irb_status">승인상태</label>
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(2,1);"><img src="../images/resch/icon2014_help.png" alt="승인상태 설명" class="img_set" /></a><br />
							(Board Approval Status)</th>
							<td colspan="2">CRIS에는 임상연구윤리심의위원회(IRB) 승인 또는 면제를 받은 연구만 등록이 가능함<br />‘제출 전, 제출 후 심사 중, 제출 후 거부’를 선택 시 CRIS 등록을 위한 임상연구제출이 되지 않음<br />
								<select name="irb_status" id="irb_status" onchange="step2_irb_status();" title="승인 상태 선택">
									<option value="">::: 선택 :::</option>
									<option value="제출 전(Request not yet submitted)" <c:out value="<%=v_irb_status_1%>" /> >제출 전(Request not yet submitted)</option>
									<option value="제출 후 심사중(Submitted pending)" <c:out value="<%=v_irb_status_2%>" /> >제출 후 심사중(Submitted pending)</option>
									<option value="제출 후 승인(Submitted approval)" <c:out value="<%=v_irb_status_3%>" /> >제출 후 승인(Submitted approval)</option>
									<option value="제출 후 면제(Submitted exempt)" <c:out value="<%=v_irb_status_4%>" /> >제출 후 면제(Submitted exempt)</option>
									<option value="제출 후 거부(Submitted denied)" <c:out value="<%=v_irb_status_5%>" /> >제출 후 거부(Submitted denied)</option>
									<option value="제출 불필요(Submission not required)" <c:out value="<%=v_irb_status_6%>" /> >제출 불필요(Submission not required)</option>
								</select>								
							</td>
						</tr>
						<tr>
							<th colspan="3" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" /><label for="irb_number">승인번호</label>
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(2,2);"><img src="../images/resch/icon2014_help.png" alt="승인번호 설명" class="img_set" /></a><br />
							(Board Approval Number)</th>
							<td colspan="2">다기관 연구의 경우 연구책임자 소속기관의 IRB  승인번호를 입력함<br />예) NIH-200901<br />
							<input type="text"  name="irb_number" id="irb_number" value="<%out.print(v_irb_number);%>" maxlength="100" maxByte="100" style="width:300px;" /></td>
						</tr>
						<tr>
							<th colspan="3" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" /><label for="irb_date">승인일</label>
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(2,3);"><img src="../images/resch/icon2014_help.png" alt="cris 필수항목 설명" class="img_set" /></a><br />
							(Approval Date)</th>
							<td colspan="2">
							첫 연구대상자 등록일자 : <%out.print(v_study_start_date);%> (첫 연구대상자 등록일자는 임상연구윤리심의의 승인날짜 보다 빠를 수 없음)<br />
							<input class="datepicker" type="text" name="irb_date" id="irb_date" value="<%out.print(v_irb_date);%>" maxlength="10" style="width:75px;" />
							<img id="cal_irb_date" src="../images/resch/btn2014_calendar.png" alt="승인일 달력버튼" class="cal" /></td>
						</tr>
						<tr>
							<th colspan="3" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" /><label for="irb_file">승인서제출</label>
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(2,4);"><img src="../images/resch/icon2014_help.png" alt="cris 필수항목 설명" class="img_set" /></a><br />
							(Approval Letter Upload)</th>
							<td colspan="2">
								<% String file_name = conf.get("environment.savefile.rootpath") + vo.get("irb_path"); file_name = file_name.replaceAll("&&&&","");
								if(!vo.equals("irb_file", "") && new File(file_name).exists() ) { %>
								 본 연구로 승인한 승인서 : <strong><a href="../file_download.jsp?seq=<c:out value="<%=v_seq%>" />&rf=I&fname=<c:out value="<%=v_irb_file%>" />"><%out.print(v_irb_file);%></a></strong><br/>
								<input type="hidden" name="irb_file" value="<%out.print(v_irb_file);%>" />
								<input type="hidden" name="irb_path" value="<%out.print(v_irb_path);%>" />
								<% } %>
								<input type="file" name="file" id="irb_file" allow="jpg pdf gif doc hwp ppt xls zip" style="width:300px;" /> <span id="irb_file_text">예) JPG, GIF, PDF, ZIP 등<br />※ 여러 개의 파일을 첨부하고자 하시는 경우 압축하여 한 개의 파일로 등록해주십시오. (단, 10M 이하)</span>
							</td>
						</tr>
<%-- 						<tr>
							<th colspan="2" rowspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />위원회명
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(2,5);"><img src="../images/resch/icon2014_help.png" alt="위원회명 설명" class="img_set" /></a><br />
							(Name of Board)</th>
							<th class="textc borderset" scope="row"><label for="irb_committee_kr">국문<br />(KOR)</label></th>
							<td colspan="2" class="borderset">해당 연구계획에 대하여 심의를 담당하는 위원회의 공식명칭<br />
								<div class="resch_inset">
									<p>(<span id="byte_irb_committee_kr">0</span>/200Byte)</p><br />
									<input type="text" name="irb_committee_kr" id="irb_committee_kr" title="위원회명 국문" value="<%=vo.getInputbox("irb_committee_kr") %>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:active;width:100%;" />
									<% if(!vo.getInputbox("irb_committee_kr").equals("")){%><script type="text/javascript">byteCheck("irb_committee_kr",200);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc" scope="row"><label for="irb_committee_en">영문<br />(ENG)</label></th>
							<td colspan="2">
								<div class="resch_inset">
									<p>(<span id="byte_irb_committee_en">0</span>/200Byte)</p><br />
									<input type="text" name="irb_committee_en" id="irb_committee_en" title="위원회명 영문" value="<%=v_irb_committee_en %>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:disabled;width:100%;" />
									<% if(!vo.getInputbox("irb_committee_en").equals("")){%><script type="text/javascript">byteCheck("irb_committee_en",200);</script><%}%>
								</div>
							</td>
						</tr> --%>
						
						<tr>
							<th rowspan="6" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />위원회
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(2,5);"><img src="../images/resch/icon2014_help.png" alt="위원회 설명" class="img_set" /></a><br />
							(Institutional<br />Review Board)</th>
							<th rowspan="3" scope="row"><label for="irb_committee_kr">위원회명<br />(Name<br />of Board)</label></th>
							<!-- <th class="textc" scope="row"><label for="irb_committee_en">국문<br />(KOR)</label></th> -->
							<td colspan="3" class="borderset">
								<div class="resch_inset">
									<a href="#irbsearch" onclick="fn_irbSearch();" ><img src="../images/resch/btn_rboard.png" alt="위원회검색" class="inpimg" /></a>
								</div>
							해당 연구계획에 대하여 심의를 담당하는 위원회의 공식명칭<br />
							</td>
						</tr>	
						<tr>
							<th class="textc" scope="row"><label for="irb_committee_en">국문<br />(KOR)</label></th>
							<td colspan="2" class="borderset">
								<div class="resch_inset">
									<p>(<span id="byte_irb_committee_kr">0</span>/200Byte)</p><br />
									<input type="text" name="irb_committee_kr" id="irb_committee_kr" title="위원회명 국문" value="<%out.print(v_irb_committee_kr);%>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:active;width:100%;" />
									<% if(!vo.getInputbox("irb_committee_kr").equals("")){%><script type="text/javascript">byteCheck("irb_committee_kr",200);</script><%}%>
								</div>
							</td>
						</tr>												
						<tr>
							<th class="textc" scope="row"><label for="irb_committee_en">영문<br />(ENG)</label></th>
							<td colspan="2">
								<div class="resch_inset">
									<p>(<span id="byte_irb_committee_en">0</span>/200Byte)</p><br />
									<input type="text" name="irb_committee_en" id="irb_committee_en" title="위원회명 영문" value="<%out.print(v_irb_committee_en);%>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:disabled;width:100%;" />
									<% if(!vo.getInputbox("irb_committee_en").equals("")){%><script type="text/javascript">byteCheck("irb_committee_en",200);</script><%}%>
								</div>
							</td>
						</tr>
						<input type="hidden" name="irb_seq" id="irb_seq" value="<%out.print(v_irb_seq); %>" />
						<input type="hidden" name="irb_agency_zip" id="irb_agency_zip" value="<%out.print(v_irb_agency_zip); %>" />						
						<tr>
							<th rowspan="2" scope="row"><label for="irb_agency_address_kr">주소<br />(Address)</label></th>
							<th class="textc" scope="row"><label for="irb_agency_address_kr">국문<br />(KOR)</label></th>
							<td colspan="2">
								<div class="resch_inset">
									<p>(<span id="byte_irb_agency_address_kr">0</span>/200Byte)</p><br />
									<input type="text" name="irb_agency_address_kr" id="irb_agency_address_kr" title="위원회주소 국문" value="<%out.print(v_irb_agency_address_kr);%>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:active;width:100%;" />
									<% if(!vo.getInputbox("irb_agency_address_kr").equals("")){%><script type="text/javascript">byteCheck("irb_agency_address_kr",200);</script><%}%>
								</div>
							</td>
						</tr>							
						<tr>
							<th class="textc" scope="row"><label for="irb_agency_address_en">영문<br />(ENG)</label></th>
							<td colspan="2">
								<div class="resch_inset">
									<p>(<span id="byte_irb_agency_address_en">0</span>/200Byte)</p><br />
									<input type="text" name="irb_agency_address_en" id="irb_agency_address_en" title="위원회주소 영문" value="<%out.print(v_irb_agency_address_en);%>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:disabled;width:100%;" />
									<% if(!vo.getInputbox("irb_agency_address_en").equals("")){%><script type="text/javascript">byteCheck("irb_agency_address_en",200);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th colspan="2" scope="row"><label for="irb_phone1">전화번호(Telephone)</label></th>
							<td colspan="2">
								<span>
									<c:out value="<%=aField %>" escapeXml="false" />
									 -
									<input type="tel" name="irb_phone2" id="irb_phone2" class="nation0input" title="위원회 전화번호 앞자리" onkeypress="javascript:onlyNumber()" value="<%out.print(v_irbpstr_1); %>" maxlength="4" maxbyte="4" style="ime-mode:disabled;width:60px;" /> -
									<input type="tel" name="irb_phone3" id="irb_phone3" class="nation0input" title="위원회 전화번호 뒷자리" onkeypress="javascript:onlyNumber()" value="<%out.print(v_irbpstr_2); %>" maxlength="4" maxbyte="4" style="ime-mode:disabled;width:60px;" />
								</span>
							</td>
						</tr>
						<tr>
							<th colspan="3" rowspan="3" scope="row">자료모니터링 위원회
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(2,5);"><img src="../images/resch/icon2014_help.png" alt="자료모니터링 위원회 설명" class="img_set" /></a><br />
							(Data Monitoring Committee)</th>
							<td rowspan="2" class="borderset01">
								<input type="radio" name="data_monitor_committee_yn" id="data_monitor_committee_yn_Y" <c:out value="<%=v_data_monitor_committee_y%>" /> value="Y" onclick="step2_data_monitor_committee_yn();" /><label for="data_monitor_committee_yn_Y">있음</label>
							</td>
							<td class="borderset">
								<div class="resch_inset">
									<p>(<span id="byte_data_monitor_committee_kr">0</span>/200Byte)</p><br />
									<div class="spset01">
										<label for="data_monitor_committee_kr">국문</label>
										<input type="text" name="data_monitor_committee_kr" id="data_monitor_committee_kr" title="자료모니터링 위원회 국문" value="<%out.print(v_data_monitor_committee_kr); %>" maxlegnth="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:active;width:85%;" />
										<% if(!vo.getInputbox("data_monitor_committee_kr").equals("")){%><script type="text/javascript">byteCheck("data_monitor_committee_kr",200);</script><%}%>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="resch_inset">
									<p>(<span id="byte_data_monitor_committee_en">0</span>/200Byte)</p><br />
									<div class="spset01">
										<label for="data_monitor_committee_en">영문</label>
										<input type="text" name="data_monitor_committee_en" id="data_monitor_committee_en" title="자료모니터링 위원회 영문" value="<%out.print(v_data_monitor_committee_en); %>" maxlegnth="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:disabled;width:85%;" />
										<% if(!vo.getInputbox("data_monitor_committee_en").equals("")){%><script type="text/javascript">byteCheck("data_monitor_committee_en",200);</script><%}%>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="radio" name="data_monitor_committee_yn" id="data_monitor_committee_yn_N" <c:out value="<%=v_data_monitor_committee_n%>" /> value="N" onclick="step2_data_monitor_committee_yn();" /><label for="data_monitor_committee_yn_N">없음</label>
							</td>
						</tr>
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
					<li><a href="#preview" title="(새창으로 이동)" onclick="preView(2);" ><img src="../images/resch/btn_preview.gif" alt="미리보기" /></a></li>
					<% if(sVO.equals("mod", "")){ %>
						<li><a href="./step1.jsp?seq=<c:out value="<%=s_seq%>" />"><img src="../images/resch/btn_prevstep.gif" alt="이전 단계로" /></a></li>
					<% } %>
					<li><a href="#removeAll" onclick="Remove(2);" ><img src="../images/resch/btn_allcancel.gif" alt="모두 지우기" /></a></li>
					<li><a href="#tempSave" onclick="TempSave(2);" ><img src="../images/resch/btn_storage.gif" alt="임시저장" /></a></li>
				<% if(sVO.equals("mod", "")){ %>
					<li><a href="#save" onclick="Save(2);" ><img src="../images/resch/btn_nextstep2.gif" alt="다음 단계로" /></a></li>
				<% }else{ %>
					<li><a href="#cancel" onclick="javascript:fn_cancel('<c:out value="<%=s_seq%>" />')" ><img src="../images/resch/btn_cancel2.gif" alt="취소" /></a></li>
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