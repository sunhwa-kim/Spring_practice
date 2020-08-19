<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.buildnine.util.VOSet"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>대상자선정기준 | 임상연구등록</title>
	<%@include file="../include/title.jsp" %>
	<%@include file="../include/write_session.jsp" %>

	<script type="text/javascript" src="../js/common.js"></script>
	<script type="text/javascript" src="../js/write.js"></script>
	<script type="text/javascript" src="../js/byteCheck.js"></script>
	<script type="text/javascript">
	<!--
	//GST_kdh_20121017 나이 초기화
	function fTargetAgeInit()
	{
		if(document.getElementById("target_in_start_age_unit").value=="No Limit")
		{
			document.getElementById("target_in_start_age").style.background = "#EFEFEF";
			document.getElementById("target_in_start_age").style.border = "1px solid #9999cc";
			document.getElementById("target_in_start_age").disabled = true;
		}
		if(document.getElementById("target_in_end_age_unit").value=="No Limit")
		{
			document.getElementById("target_in_end_age").style.background = "#EFEFEF";
			document.getElementById("target_in_end_age").style.border = "1px solid #9999cc";
			document.getElementById("target_in_end_age").disabled = true;			
		}
	}	
	//GST_kdh_20121017 나이 No Limit 선택시 처리
	function fTargetAge(target, mm)
	{
		if(target.value=="No Limit")
		{
			document.getElementById("target_in_"+mm+"_age").value='';
			document.getElementById("target_in_"+mm+"_age").style.background = "#EFEFEF";
			document.getElementById("target_in_"+mm+"_age").style.border = "1px solid #9999cc";
			document.getElementById("target_in_"+mm+"_age").disabled=true;
		}
		else
		{
			document.getElementById("target_in_"+mm+"_age").style.background = "#FFFFFF";
			document.getElementById("target_in_"+mm+"_age").style.border = "1px solid #9999cc";
			document.getElementById("target_in_"+mm+"_age").disabled=false;	
		}
		if(mm=="end")
		{
			if(document.getElementById("target_in_start_age_unit").value == "세(Year)")
			{
				if(document.getElementById("target_in_end_age_unit").value == "일(Day)"||document.getElementById("target_in_end_age_unit").value == "개월(Month)")
				{
					alert("최소기준을 세(Year)로 선택 시 최대 기준으로 일(Day), 월(Month)은 선택할 수 없습니다.");
					document.getElementById("target_in_end_age_unit").value = "";
					document.getElementById("target_in_end_age_unit").focus();
				}
			}
		}
		
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
<body onload="RemoveForm(9);fTargetAgeInit();">
<%
	ValueObject sVO = new ValueObject();
	ValueObject vo = new ValueObject();
	String temp = "";
	ValueObject icdVal = new ValueObject();

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
			vo = QueryAction.getQueryView("CRIS_DATA.step9", sVO);	
			
/* 			if( !vo.equals("icd10_code", "")){

				if( vo.getInputbox("icd10_code").length() >= 3 ){
					vo.put("icd_1", StringUtil.substring(vo.getInputbox("icd10_code"), 0, 3));
				}
				if( vo.getInputbox("icd10_code").length() >= 6 ){
					vo.put("icd_2", StringUtil.substring(vo.getInputbox("icd10_code"), 0, 6));
				}
				if( vo.getInputbox("icd10_code").length() >= 9 ){
					vo.put("icd_3", StringUtil.substring(vo.getInputbox("icd10_code"), 0, 9));
				}
				if( vo.getInputbox("icd10_code").length() >= 12 ){
					vo.put("icd_4", StringUtil.substring(vo.getInputbox("icd10_code"), 0, 12));
				}
			} */
		}

		icdVal = QueryAction.getQueryView("CRIS_DATA.icd10_view", sVO);		

		VOSet list = QueryAction.getQueryList("CRIS_DATA.icd10_list", sVO);
		
		String v_research_title_kr = StringUtil.getTitleLimit(vo.getInputbox("research_title_kr"),83);
		
		String v_seq = vo.getInputbox("seq");
		String s_seq = sVO.get("seq");
		String v_status = vo.getInputbox("status");
		String v_seq_group = vo.getInputbox("seq_group");
		String v_mod = sVO.getInputbox("mod");
		String v_study_population_desc_kr = vo.getInputbox("study_population_desc_kr");
		String v_study_population_desc_en = vo.getInputbox("study_population_desc_en");
		String v_sampling_method_kr = vo.getInputbox("sampling_method_kr");
		String v_sampling_method_en = vo.getInputbox("sampling_method_en");
		String v_cp_contents = vo.getInputbox("cp_contents");
		String v_cp_contents_en = vo.getInputbox("cp_contents_en");
		String v_target_rare_yn_y = vo.equals("target_rare_yn", "Y")?"checked":"";
		String v_target_rare_yn_n = vo.equals("target_rare_yn", "")||vo.equals("target_rare_yn", null)||vo.equals("target_rare_yn", "N")?"checked":"";
		String v_target_in_sex_1 = vo.getInputbox("target_in_sex").equals("둘다(Both)")?"selected":"";
		String v_target_in_sex_2 = vo.getInputbox("target_in_sex").equals("남성(Male)")?"selected":"";
		String v_target_in_sex_3 = vo.getInputbox("target_in_sex").equals("여성(Female)")?"selected":"";
		String v_target_in_start_age_unit_1 = vo.getInputbox("target_in_start_age_unit").equals("")?"selected":"";
		String v_target_in_start_age_unit_2 = vo.getInputbox("target_in_start_age_unit").equals("No Limit")?"selected":"";
		String v_target_in_start_age_unit_3 = vo.getInputbox("target_in_start_age_unit").equals("세(Year)")?"selected":"";
		String v_target_in_start_age_unit_4 = vo.getInputbox("target_in_start_age_unit").equals("개월(Month)")?"selected":"";
		String v_target_in_start_age_unit_5 = vo.getInputbox("target_in_start_age_unit").equals("일(Day)")?"selected":"";
		String v_target_in_start_age = vo.getInputbox("target_in_start_age");
		String v_target_end_age = vo.getInputbox("target_in_end_age");		
		String v_target_in_end_age_unit_1 = vo.getInputbox("target_in_end_age_unit").equals("")?"selected":"";
		String v_target_in_end_age_unit_2 = vo.getInputbox("target_in_end_age_unit").equals("No Limit")?"selected":"";
		String v_target_in_end_age_unit_3 = vo.getInputbox("target_in_end_age_unit").equals("세(Year)")?"selected":"";
		String v_target_in_end_age_unit_4 = vo.getInputbox("target_in_end_age_unit").equals("개월(Month)")?"selected":"";
		String v_target_in_end_age_unit_5 = vo.getInputbox("target_in_end_age_unit").equals("일(Day)")?"selected":"";
		String v_target_in_kr = vo.getInputbox("target_in_kr");
		String v_target_in_en = vo.getInputbox("target_in_en");
		String v_target_out_kr = vo.getInputbox("target_out_kr");
		String v_target_out_en = vo.getInputbox("target_out_en");
		String v_healthy_volunteers_y = vo.getInputbox("healthy_volunteers_yn").equals("Y")?"checked":"";
		String v_healthy_volunteers_n = vo.getInputbox("healthy_volunteers_yn").equals("N")?"checked":"";
		String v_icdselected = icdVal.getInputbox("my_code").equals("")?"selected":"";
		
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
						<li>제 목 : <span><c:out value="<%=v_research_title_kr %>" /></span></li>
					</ul>
				</div>
			<% } %>	
			
			<div id="sideB" class="research_tit">
				<h3><img src="../images/resch/tit2014_wstep09.gif" alt="9. 대상자선정기준 (Subject Eligibility)" /></h3>
			</div>
			<div class="research_tb">
			
			<iframe name="iframe" title="의미없는 아이프레임" style="display:none;" width="0" height="0"></iframe>
			<form name="form" id="form" method="post">
			<input type="hidden" name="seq" 	id="seq" 	value="<c:out value="<%=v_seq%>" />" />
			<input type="hidden" name="status" 	id="status" value="<c:out value="<%=v_status%>" />" />
			<input type="hidden" name="seq_group"	id="seq_group" 	value="<c:out value="<%=v_seq_group%>" />" />
			<input type="hidden" name="mode" 	id="mode" 	value="" />
			<input type="hidden" name="mod" id="mod" value="<c:out value="<%=v_mod%>" />" />
			<input type="hidden" name="step" id="step" />
				<table cellspacing="0" cellpadding="0" border="0" summary="연구대상자/질환, 희귀질환여부, 대상자 포함기준, 대상자제외기준으로 구성된 대상자선정기준 정보 입력테이블입니다.">
					<caption>대상자선정기준 정보 입력</caption>
					<colgroup>
						<col width="220px" /><col width="100px" /><col width="110px" /><col width="*" />
					</colgroup>
					<tbody>
					<% if( vo.getInputbox("research_kind").indexOf("관찰") > -1 ){ %>
						<tr>
							<th rowspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />연구모집단설명
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(9,1);"><img src="../images/resch/icon2014_help.png" alt="연구모집단 설명" class="img_set" /></a><br />
							(Study population description)</th>
							<th class="textc borderset" scope="row"><label for="study_population_desc_kr">국문<br />(KOR)</label></th>
							<td colspan="2" class="borderset">
								연구 모집단(관찰군 또는 코호트)에 대한 자세한 설명<br />
								예) ○○시 거주자 중 1차 의료기관을 이용하는 70세 이상 남자<br />
								<div class="resch_inset">
									<p>(<span id="byte_study_population_desc_kr">0</span>&#47;6000Byte)</p><br />
									<textarea name="study_population_desc_kr" id="study_population_desc_kr" title="연구모집단설명 국문" maxlength="6000" maxByte="6000" onKeyDown="byteCheck(this.id,6000);" onKeyUp="byteCheck(this.id,6000);" onChange="byteCheck(this.id,6000);" style="ime-mode:active;width:100%;height:50px;"><%out.print(v_study_population_desc_kr); %></textarea>
									<% if(!vo.getInputbox("study_population_desc_kr").equals("")){%><script type="text/javascript">byteCheck("study_population_desc_kr",6000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc" scope="row"><label for="study_population_desc_en">영문<br />(ENG)</label></th>
							<td colspan="2">
								<div class="resch_inset">
									<p>(<span id="byte_study_population_desc_en">0</span>&#47;6000Byte)</p><br />
									<textarea name="study_population_desc_en" id="study_population_desc_en" title="연구모집단설명 영문" maxlength="6000" maxByte="6000" onKeyDown="byteCheck(this.id,6000);" onKeyUp="byteCheck(this.id,6000);" onChange="byteCheck(this.id,6000);" style="ime-mode:disabled;width:100%;height:50px;"><%out.print(v_study_population_desc_en); %></textarea>
									<% if(!vo.getInputbox("study_population_desc_en").equals("")){%><script type="text/javascript">byteCheck("study_population_desc_en",6000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th rowspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />대상자추출방법
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(9,2);"><img src="../images/resch/icon2014_help.png" alt="대상자추출방법 설명" class="img_set" /></a><br />
							(Sampling Method)</th>
							<th class="textc borderset" scope="row"><label for="sampling_method_kr">국문<br />(KOR)</label></th>
							<td colspan="2" class="borderset">
								대상자 추출방법에 대한 자세한 설명<br />
								<div class="resch_inset">
									<p>(<span id="byte_sampling_method_kr">0</span>&#47;6000Byte)</p><br />
									<textarea name="sampling_method_kr" id="sampling_method_kr" title="대상자추출방법 국문" maxlength="6000" maxByte="6000" onKeyDown="byteCheck(this.id,6000);" onKeyUp="byteCheck(this.id,6000);" onChange="byteCheck(this.id,6000);" style="ime-mode:active;width:100%;height:50px;"><%out.print(v_sampling_method_kr); %></textarea>
									<% if(!vo.getInputbox("sampling_method_kr").equals("")){%><script type="text/javascript">byteCheck("sampling_method_kr",6000);</script><%}%>
									
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc" scope="row"><label for="sampling_method_en">영문<br />(ENG)</label></th>
							<td colspan="2">
								<div class="resch_inset">
									<p>(<span id="byte_sampling_method_en">0</span>&#47;6000Byte)</p><br />
									<textarea name="sampling_method_en" id="sampling_method_en" title="대상자추출방법 영문" maxlength="6000" maxByte="6000" onKeyDown="byteCheck(this.id,6000);" onKeyUp="byteCheck(this.id,6000);" onChange="byteCheck(this.id,6000);" style="ime-mode:disabled;width:100%;height:50px;"><%out.print(v_sampling_method_en); %></textarea>
									<% if(!vo.getInputbox("sampling_method_en").equals("")){%><script type="text/javascript">byteCheck("sampling_method_en",6000);</script><%}%>
								</div>
							</td>
						</tr>
					<% } %> <!-- 관찰연구만 입력 -->
						<tr>
							<th rowspan="3" class="borderset02" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" /><label for="my_code">연구대상 상태&#47;질환</label>
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(9,3);"><img src="../images/resch/icon2014_help.png" alt="연구대상(자)/질환 설명" class="img_set" /></a><br />
							(Condition(s)/Problem(s))</th>
							<th scope="row">&nbsp;</th>
							<td colspan="2" class="borderset">
								<label for="my_code">질환분류를 선택하십시오.</label><br />
									<select name="my_code" id="my_code" title="연구대상 상태&#47;질환 선택">
										<option value="" <c:out value="<%=v_icdselected%>" /> >선택</option>
									<%
									for ( int x = 0; x < list.size(); x++) {
										if( list.get(x).equals("parent_code", "0")){
											String l_my_code = list.get(x).getInputbox("my_code"); 
											String l_icd10_name_kr = list.get(x).getInputbox("icd10_name_kr");
											String l_selected = icdVal.getInputbox("my_code").equals(list.get(x).getInputbox("my_code"))?"selected":"";
									%>
										<option value="<c:out value="<%=l_my_code %>" />" <c:out value="<%=l_selected%>" /> ><c:out value="<%=l_icd10_name_kr %>" /></option>
									<%
										}
									}
									%>							
									</select>
							</td>
						</tr>
						<tr>
							<th class="textc borderset borderset01 borderset03" scope="row"><label for="cp_contents">국문<br />(KOR)</label></th>
							<td colspan="2">
							MeSH 용어를 사용하여 연구대상 상태/질환을 입력하십시오.<br /><a href="http://www.nlm.nih.gov/mesh/MBrowser.html" rel="noopener noreferrer" target="_blank">(MeSH 용어 참고 : http://www.nlm.nih.gov/mesh/)</a><br />							
								<div class="resch_inset">
									<p>(<span id="byte_cp_contents">0</span>&#47;4000Byte)</p><br />
									<textarea name="cp_contents" id="cp_contents" title="연구대상 상태/질환(국문)" maxlength="4000" maxByte="4000" onKeyDown="byteCheck(this.id,4000);" onKeyUp="byteCheck(this.id,4000);" style="width:100%;height:100px;"><%out.print(v_cp_contents); %></textarea>
									<% if(!vo.getInputbox("cp_contents").equals("")){%><script type="text/javascript">byteCheck("cp_contents",4000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc borderset borderset01 borderset03" scope="row"><label for="cp_contents_en">영문<br />(ENG)</label></th>
							<td colspan="2">
								<div class="resch_inset">
									<p>(<span id="byte_cp_contents_en">0</span>&#47;4000Byte)</p><br />
									<textarea name="cp_contents_en" id="cp_contents_en" title="연구대상 상태/질환(영문)" maxlength="4000" maxByte="4000" onKeyDown="byteCheck(this.id,4000);" onKeyUp="byteCheck(this.id,4000);" style="width:100%;height:100px;"><%out.print(v_cp_contents_en); %></textarea>
									<% if(!vo.getInputbox("cp_contents_en").equals("")){%><script type="text/javascript">byteCheck("cp_contents_en",4000);</script><%}%>
								</div>
							</td>
						</tr>						
						<tr>
							<th colspan="2" scope="row">희귀질환 여부 (Rare Disease)</th>
							<td colspan="2">
								<input type="radio" name="target_rare_yn" id="target_rare_y" value="Y" <c:out value="<%=v_target_rare_yn_y %>" /> /><label for="target_rare_y">예(Yes)</label>
								<input type="radio" name="target_rare_yn" id="target_rare_n" value="N" <c:out value="<%=v_target_rare_yn_n%>" /> /><label for="target_rare_n">아니오(No)</label>
							</td>
						</tr>
						<tr>
							<th rowspan="4" class="borderset02" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />대상자 포함기준
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(9,4);"><img src="../images/resch/icon2014_help.png" alt="대상자 포함기준 설명" class="img_set" /></a><br />
							(Inclusion Criteria)</th>
							<th rowspan="2" scope="row">&nbsp;</th>
							<td class="borderset"><span class="f_point"><label for="target_in_sex" class="magset2">성별(Gender)</label></span></td>
							<td class="borderset">
								<select name="target_in_sex" id="target_in_sex"  title="성별 선택">
									<option value="둘다(Both)" <c:out value="<%=v_target_in_sex_1%>" /> >둘다(Both)</option>
									<option value="남성(Male)" <c:out value="<%=v_target_in_sex_2%>" /> >남성(Male)</option>
									<option value="여성(Female)" <c:out value="<%=v_target_in_sex_3%>" /> >여성(Female)</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="borderset"><span class="f_point">만 연령(Age)</span></td>
							<td class="borderset">
								<label for="target_in_start_age" class="magset2">최소(Min)</label>
								<input type="tel" name="target_in_start_age" id="target_in_start_age" value="<c:out value="<%=v_target_in_start_age %>" />" onkeypress="javascript:onlyNumber()" maxlength="4" style="ime-mode:disabled;width:50px;" />
								<select name="target_in_start_age_unit" id="target_in_start_age_unit" style="width:110px;" onchange="fTargetAge(this,'start')" title="최소 나이 단위 선택">
									<option value="" <c:out value="<%=v_target_in_start_age_unit_1%>" /> >::선택::</option>
									<option value="No Limit" <c:out value="<%=v_target_in_start_age_unit_2%>" /> >No Limit</option>
									<option value="세(Year)" <c:out value="<%=v_target_in_start_age_unit_3%>" /> >세(Year)</option>
									<option value="개월(Month)" <c:out value="<%=v_target_in_start_age_unit_4%>" /> >개월(Month)</option>
									<option value="일(Day)" <c:out value="<%=v_target_in_start_age_unit_5%>" /> >일(Day)</option>
								</select>
								 ~ 
								<label for="target_in_end_age" class="magset2">최대(Max)</label>
								<input type="tel" name="target_in_end_age" id="target_in_end_age" value="<c:out value="<%=v_target_end_age %>" />" onkeypress="javascript:onlyNumber()" maxlength="4" style="ime-mode:disabled;width:50px;" />
								<select name="target_in_end_age_unit" id="target_in_end_age_unit" style="width:110px;" onchange="fTargetAge(this,'end')" title="최대 나이 단위 선택">
									<option value="" <c:out value="<%=v_target_in_end_age_unit_1%>" /> >::선택::</option>
									<option value="No Limit" <c:out value="<%=v_target_in_end_age_unit_2%>" /> >No Limit</option>
									<option value="세(Year)" <c:out value="<%=v_target_in_end_age_unit_3%>" /> >세(Year)</option>
									<option value="개월(Month)" <c:out value="<%=v_target_in_end_age_unit_4%>" /> >개월(Month)</option>
									<option value="일(Day)" <c:out value="<%=v_target_in_end_age_unit_5%>" /> >일(Day)</option>
								</select>
							</td>
						</tr>
						<tr>
							<th class="textc borderset borderset01 borderset03" scope="row"><label for="target_in_kr">국문<br />(KOR)</label></th>
							<td colspan="2" class="borderset">
								<div class="resch_inset">
									<p>(<span id="byte_target_in_kr">0</span>&#47;10000Byte)</p><br />
									<textarea name="target_in_kr" id="target_in_kr" title="대상자 포함기준 국문" maxlength="10000" maxByte="10000" onKeyDown="byteCheck(this.id,10000);" onKeyUp="byteCheck(this.id,10000);" onChange="byteCheck(this.id,10000);" style="ime-mode:active;width:100%;height:100px;"><%out.print(v_target_in_kr); %></textarea>
									<% if(!vo.getInputbox("target_in_kr").equals("")){%><script type="text/javascript">byteCheck("target_in_kr",10000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc borderset borderset01 borderset03" scope="row"><label for="target_in_en">영문<br />(ENG)</label></th>
							<td colspan="2" class="borderset">
								<div class="resch_inset">
									<p>(<span id="byte_target_in_en">0</span>&#47;10000Byte)</p><br />
									<textarea name="target_in_en" id="target_in_en" title="대상자 포함기준 영문" maxlength="10000" maxByte="10000" onKeyDown="byteCheck(this.id,10000);" onKeyUp="byteCheck(this.id,10000);" onChange="byteCheck(this.id,10000);" style="ime-mode:disabled;width:100%;height:100px;"><%out.print(v_target_in_en); %></textarea>
									<% if(!vo.getInputbox("target_in_en").equals("")){%><script type="text/javascript">byteCheck("target_in_en",10000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th rowspan="2" class="borderset02" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />대상자 제외기준
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(9,5);"><img src="../images/resch/icon2014_help.png" alt="대상자 제외기준 설명" class="img_set" /></a><br />
							(Exclusion Criteria)</th>
							<th class="textc borderset borderset01 borderset03" scope="row"><label for="target_out_kr">국문<br />(KOR)</label></th>
							<td colspan="2" class="borderset">
								<div class="resch_inset">
									<p>(<span id="byte_target_out_kr">0</span>&#47;10000Byte)</p><br />
									<textarea name="target_out_kr" id="target_out_kr" title="대상자 제외기준 국문" maxlength="10000" maxByte="10000" onKeyDown="byteCheck(this.id,10000);" onKeyUp="byteCheck(this.id,10000);" onChange="byteCheck(this.id,10000);" style="ime-mode:active;width:100%;height:100px;"><%out.print(v_target_out_kr); %></textarea>
									<% if(!vo.getInputbox("target_out_kr").equals("")){%><script type="text/javascript">byteCheck("target_out_kr",10000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc borderset borderset01 borderset03" scope="row"><label for="target_out_en">영문<br />(ENG)</label></th>
							<td colspan="2" class="borderset">
								<div class="resch_inset">
									<p>(<span id="byte_target_out_en">0</span>&#47;10000Byte)</p><br />
									<textarea name="target_out_en" id="target_out_en" title="대상자 제외기준 영문" maxlength="10000" maxByte="10000" onKeyDown="byteCheck(this.id,10000);" onKeyUp="byteCheck(this.id,10000);" onChange="byteCheck(this.id,10000);" style="ime-mode:disabled;width:100%;height:100px;"><%out.print(v_target_out_en); %></textarea>
									<% if(!vo.getInputbox("target_out_en").equals("")){%><script type="text/javascript">byteCheck("target_out_en",10000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th colspan="2" scope="row">건강인 참여 여부 (Healthy Volunteers)</th>
							<td colspan="2">
								<input type="radio" name="healthy_volunteers_yn" id="healthy_volunteers_yn_1" <c:out value="<%=v_healthy_volunteers_y%>" /> value="Y" /><label for="healthy_volunteers_yn_1">예 (Yes)</label>
								<input type="radio" name="healthy_volunteers_yn" id="healthy_volunteers_yn_2" <c:out value="<%=v_healthy_volunteers_n%>" /> value="N" /><label for="healthy_volunteers_yn_2">아니오 (No)</label>
							</td>
						</tr>
					</tbody>
				</table>
				<ul class="research_noice">
					<li class="font_red"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />WHO ICTRP (International Clinical Trial Registry Platform)에서 요구하는 필수등록항목입니다.</li>
					<li class="font_blue"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />CRIS 필수등록항목입니다.</li>
				</ul>
				</form>
			</div>
			
			<div class="res_btnbox">
				<ul class="research_btn">
					<li><a href="#preview" title="(새창으로 이동)" onclick="preView(9);" ><img src="../images/resch/btn_preview.gif" alt="미리보기" /></a></li>
					<% if(sVO.equals("mod", "")){ %>
						<li><a href="./step8.jsp?seq=<c:out value="<%=s_seq%>" />"><img src="../images/resch/btn_prevstep.gif" alt="이전 단계로" /></a></li>
					<% } %>					
					<li><a href="#removeAll" onclick="Remove(9);" ><img src="../images/resch/btn_allcancel.gif" alt="모두 지우기" /></a></li>
					<li><a href="#tempSave" onclick="TempSave(9);" ><img src="../images/resch/btn_storage.gif" alt="임시저장" /></a></li>
				<% if(sVO.equals("mod", "")){ %>
					<li><a href="#save" onclick="Save(9);" ><img src="../images/resch/btn_nextstep2.gif" alt="다음 단계로" /></a></li>
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
  		System.err.println("CRIS step9");
  	} catch(NumberFormatException e){
  		System.err.println("NF 오류 발생");
  		System.err.println("CRIS step9");
  	} catch(Exception e){
		System.err.println("EX 오류 발생");
	  	System.err.println("CRIS step9");
    } finally {

	}
%>
</body>
</html>