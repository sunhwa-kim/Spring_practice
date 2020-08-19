<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.buildnine.util.VOSet"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>연구설계 | 임상연구등록</title>
	<%@include file="../include/title.jsp" %>
	<%@include file="../include/write_session.jsp" %>

	<script type="text/javascript" src="../js/common.js"></script>
	<script type="text/javascript" src="../js/write.js"></script>

	<script type="text/javascript" src="../js/byteCheck.js"></script>
	<script type="text/javascript">
	<!--
		function jsMulti8_1(str)
		{
			cnt = document.form.arm_count.value;
			if(str == "add")
				sum = eval(cnt) + eval("1");
			else
				sum = eval(cnt) - eval("1");
			document.form.arm_count.value = sum;
			step8_arm_count();
		}
		function jsMulti8_2(str)
		{
			cnt = document.form.cohort_count.value;
			if(str == "add")
				sum = eval(cnt) + eval("1");
			else
				sum = eval(cnt) - eval("1");
			document.form.cohort_count.value = sum;
			step8_cohort_count();
		}
		
		//GST_kdh_20121029 중재종류 생물학적제제 처리
		function cellFc(target)
		{
			var bioObj = document.getElementById("intervention_type_3");
			var stemObj = document.getElementById("intervention_type_4");
			var nstemObj = document.getElementById("intervention_type_5");
			if(target.id == "intervention_type_3")
			{
				if(target.checked==false)
				{
					nstemObj.checked = false;
					stemObj.checked = false;
				}
				else
				{
					stemObj.checked = true;
				}
			}
			else if(target.id == "intervention_type_4")
			{
				if(target.checked==false)
				{
					nstemObj.checked = true;
				}
				else{
					bioObj.checked = true;
					nstemObj.checked = false;
				}
			}
			else if(target.id == "intervention_type_5")
			{
				if(target.checked==false)
				{
					stemObj.checked = true;
				}
				else{				
					bioObj.checked = true;
					stemObj.checked = false;
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
<body onLoad="RemoveForm(8);">
<%
	ValueObject sVO = new ValueObject();
	ValueObject vo = new ValueObject();
	String temp = "";
	VOSet armList = new VOSet();
	ValueObject armVo = null;
	VOSet cohortList = new VOSet();
	ValueObject cohortVo = null;
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
			vo = QueryAction.getQueryView("CRIS_DATA.step8", sVO);
			if( vo.get("research_kind").indexOf("중재") > -1 ){
				sVO.put("gubun", "ARM");
				armList = QueryAction.getQueryList("CRIS_DATA.med_list", sVO);
			} else if( vo.get("research_kind").indexOf("관찰") > -1 ){
				sVO.put("gubun", "COHORT");
				cohortList = QueryAction.getQueryList("CRIS_DATA.med_list", sVO);
			}
		}
		
		int aCnt = armList.size();
		int cCnt = cohortList.size();
		
		//GST_kdh_20170213 select box 공통코드 사용하도록 변경 
		sVO.put("code_grp", "PHASE");
		VOSet phaseList = QueryAction.getQueryList("CODE.cmcd_list", sVO);
		
		sVO.put("code_grp", "ARMTYPE");
		VOSet armtypeList = QueryAction.getQueryList("CODE.cmcd_list", sVO);
		
		String phaseField = "";
		ValueObject po;
		
		phaseField += "<select name='clinical_step' id='clinical_step' title='임상시험단계 선택'>";
		phaseField += "<option value='해당사항없음(Not applicable)'>해당사항없음(Not applicable)</option>";
		if(phaseList!=null && phaseList.size()>0)
		{
			for(int i=0; i<phaseList.size(); i++)
			{
				po = phaseList.get( i ) ;
				//phaseField += "<option value='"+po.get("code_name")+"'"+(vo.getInputbox("clinical_step").equals(po.get("code_name"))?"selected":"")+">"+po.get("code_name")+"</option>";
				phaseField += "<option value='"+po.get("code_name")+"'"+(vo.getInputbox("clinical_step").equals(po.getInputbox("code_name"))?"selected":"")+">"+po.getInputbox("code_name")+"</option>";
			}
		}
		phaseField += "</select>";

		String s_seq = sVO.get("seq");
		String v_seq = vo.getInputbox("seq");
		String v_status = vo.getInputbox("status");
		String v_seq_group = vo.getInputbox("seq_group");
		String v_mod = sVO.getInputbox("mod");
		String v_enrollment = vo.getInputbox("enrollment");
		int acnt = aCnt == 0 ? 1 : aCnt;
		int ccnt = cCnt == 0 ? 1 : cCnt;
		String research_title_kr = StringUtil.getTitleLimit(vo.getInputbox("research_title_kr"),83);
		String v_research_kind_1 = vo.getInputbox("research_kind").equals("중재연구(Interventional Study)")?"checked":"";
		String v_research_kind_2 = vo.getInputbox("research_kind").equals("관찰연구(Observational Study)")?"checked":"";
		String v_research_purpose_1 = vo.getInputbox("research_purpose").equals("치료(Treatment)")?"checked":"";
		String v_research_purpose_2 = vo.getInputbox("research_purpose").equals("예방(Prevention)")?"checked":"";
		String v_research_purpose_3 = vo.getInputbox("research_purpose").equals("진단(Diagnosis)")?"checked":"";
		String v_research_purpose_4 = vo.getInputbox("research_purpose").equals("보조적 치료(Supportive Care)")?"checked":"";
		String v_research_purpose_5 = vo.getInputbox("research_purpose").equals("검진(Screening)")?"checked":"";
		String v_research_purpose_6 = vo.getInputbox("research_purpose").equals("보건의료서비스 연구(Health Services Research)")?"checked":"";
		String v_research_purpose_7 = vo.getInputbox("research_purpose").equals("기초과학(Basic Science)")?"checked":"";
		String v_research_purpose_8 = vo.getInputbox("research_purpose").equals("기타(Others)")?"checked":"";
		String v_research_purpose_etc = vo.getInputbox("research_purpose_etc");		
		String v_research_purpose_etc_en = vo.getInputbox("research_purpose_etc_en");		
		String v_intervention_model_1 = vo.getInputbox("intervention_model").equals("단일군(Single Group)")?"checked":"";
		String v_intervention_model_2 = vo.getInputbox("intervention_model").equals("평행설계(Parallel)")?"checked":"";                                                                                  
		String v_intervention_model_3 = vo.getInputbox("intervention_model").equals("교차설계(Cross-over)")?"checked":"";                                                                                   
		String v_intervention_model_4 = vo.getInputbox("intervention_model").equals("요인설계(Factorial)")?"checked":"";
		String v_intervention_model_5 = vo.getInputbox("intervention_model").equals("기타(Others)")?"checked":"";
		String v_intervention_model_etc = vo.getInputbox("intervention_model_etc");
		String v_intervention_model_etc_en = vo.getInputbox("intervention_model_etc_en");
		String v_blinding_1 = vo.getInputbox("blinding").equals("사용안함(Open)")?"selected":"";
		String v_blinding_2 = vo.getInputbox("blinding").equals("단측(Single)")?"selected":"";
		String v_blinding_3 = vo.getInputbox("blinding").equals("양측(Double)")?"selected":"";
		String v_blinding_target_1 = vo.getInputbox("blinding_target").indexOf("연구대상자")>-1?"checked":"";
		String v_blinding_target_2 = vo.getInputbox("blinding_target").indexOf("의사 또는 연구자")>-1?"checked":"";
		String v_blinding_target_3 = vo.getInputbox("blinding_target").indexOf("보호자 및 간병인")>-1?"checked":"";
		String v_blinding_target_4 = vo.getInputbox("blinding_target").indexOf("결과분석자")>-1?"checked":"";
		String v_allocation_1 = vo.getInputbox("allocation").equals("무작위배정(RCT)")?"checked":"";
		String v_allocation_2 = vo.getInputbox("allocation").equals("비무작위배정(Non-RCT)")?"checked":"";
		String v_allocation_3 = vo.getInputbox("allocation").equals("해당사항없음(Not Applicable)")?"checked":"";
		String v_intervention_type_1 = vo.getInputbox("intervention_type").indexOf("(Drug)")>-1?"checked":"";
		String v_intervention_type_2 = vo.getInputbox("intervention_type").indexOf("(Medical Device)")>-1?"checked":"";
		String v_intervention_type_3 = vo.getInputbox("intervention_type").indexOf("(Biological/Vaccine)")>-1?"checked":"";
		String v_intervention_type_3_sel = vo.getInputbox("intervention_type").indexOf("(Biological/Vaccine)")<-1?"disabled":"";
		String v_intervention_type_4 = vo.getInputbox("intervention_type").indexOf("(Stem Cell)")>-1?"checked":"";
		String v_intervention_type_5 = vo.getInputbox("intervention_type").indexOf("(Non-Stem Cell)")>-1?"checked":"";
		String v_intervention_type_6 = vo.getInputbox("intervention_type").indexOf("(Procedure/Surgery)")>-1?"checked":"";
		String v_intervention_type_7 = vo.getInputbox("intervention_type").indexOf("(Radiation)")>-1?"checked":"";
		String v_intervention_type_8 = vo.getInputbox("intervention_type").indexOf("(Behavioral)")>-1?"checked":"";
		String v_intervention_type_9 = vo.getInputbox("intervention_type").indexOf("(Genetic)")>-1?"checked":"";
		String v_intervention_type_10 = vo.getInputbox("intervention_type").indexOf("(Dietary Supplement)")>-1?"checked":""; 
		String v_intervention_type_11 = vo.getInputbox("intervention_type").indexOf("(Others)")>-1?"checked":""; 
		String v_intervention_type_etc = vo.getInputbox("intervention_type_etc"); 
		String v_intervention_type_etc_en = vo.getInputbox("intervention_type_etc_en"); 
		String v_arm_desc_kr = vo.getInputbox("arm_desc_kr"); 
		String v_arm_desc_en = vo.getInputbox("arm_desc_en"); 
		String v_enrollment_text = vo.getInputbox("enrollment").equals("")?"(전체연구모집현황의 목표대상자 수 보다 클 수 없습니다.)":"(전체연구모집현황의 목표대상자 수 "+vo.getInputbox("enrollment")+" 명 보다 클 수 없습니다.)"; 
		String v_observational_model_1 = vo.getInputbox("observational_model").equals("Cohort")?"selected":"";
		String v_observational_model_2 = vo.getInputbox("observational_model").equals("Case-control")?"selected":"";
		String v_observational_model_3 = vo.getInputbox("observational_model").equals("Case-only")?"selected":"";
		String v_observational_model_4 = vo.getInputbox("observational_model").equals("Case-crossover")?"selected":"";
		String v_observational_model_5 = vo.getInputbox("observational_model").equals("Ecologic or community studies")?"selected":"";
		String v_observational_model_6 = vo.getInputbox("observational_model").equals("Family-based")?"selected":"";
		String v_observational_model_7 = vo.getInputbox("observational_model").equals("Others")?"selected":"";
		String v_time_perspective_1 = vo.getInputbox("time_perspective").equals("전향적(Prospective)")?"checked":"";
		String v_time_perspective_2 = vo.getInputbox("time_perspective").equals("후향적(Retrospective)")?"checked":"";
		String v_time_perspective_3 = vo.getInputbox("time_perspective").equals("단면연구(Cross-sectional)")?"checked":"";
		String v_time_perspective_4 = vo.getInputbox("time_perspective").equals("기타(Others)")?"checked":"";
		String v_time_perspective_etc = vo.getInputbox("time_perspective_etc");
		String v_time_perspective_etc_en = vo.getInputbox("time_perspective_etc_en");
		String v_biospecimen_enrollment = vo.getInputbox("biospecimen_enrollment");
		String v_biospecimen_retention_1 = vo.getInputbox("biospecimen_retention").equals("저장안함(Not collect nor Archive)")?"checked":"";
		String v_biospecimen_retention_2 = vo.getInputbox("biospecimen_retention").equals("저장: DNA 포함(Collect & Archive: Sample with DNA)")?"checked":"";
		String v_biospecimen_retention_3 = vo.getInputbox("biospecimen_retention").equals("저장: DNA 비포함(Collect & Archive: Sample without DNA)")?"checked":"";
		String v_biospecimen_description_kr = vo.getInputbox("biospecimen_description_kr");
		String v_biospecimen_description_en = vo.getInputbox("biospecimen_description_en");
		
		//dddddddddddddddddddddddddddddddddddddd
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
				<h3><img src="../images/resch/tit2014_wstep08.gif" alt="8. 연구설계 (Study Design)" /></h3>
			</div>
			<div class="research_tb">
			
			<iframe name="iframe" title="의미없는 아이프레임" style="display:none;" width="0" height="0"></iframe>
			<form name="form" id="form" method="post">
			<input type="hidden" name="seq" 	id="seq" 	value="<c:out value="<%=v_seq%>" />" />
			<input type="hidden" name="status" 	id="status" value="<c:out value="<%=v_status%>" />" />
			<input type="hidden" name="seq_group"	id="seq_group" 	value="<c:out value="<%=v_seq_group%>" />" />
			<input type="hidden" name="mode" 	id="mode" 	value="" />
			<input type="hidden" name="mod" id="mod" value="<%=v_mod%>" />
			<input type="hidden" name="arm_count" id="arm_count" value="<c:out value="<%= acnt %>" />">
			<input type="hidden" name="cohort_count" 	value="<c:out value="<%= ccnt %>" />">
			<input type="hidden" name="step" id="step" />
			<input type="hidden" name="enrollment" id="enrollment" value="<c:out value="<%=v_enrollment%>" />">
			
			<table cellspacing="0" cellpadding="0" border="0" summary="연구종류 선택테이블입니다.">
					<caption>연구종류 선택</caption>
					<colgroup>
						<col width="90px" /><col width="130px" /><col width="60px" /><col width="110px" /><col width="60px" /><col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th colspan="3" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />연구종류 (Study Type)</th>
							<td colspan="3">
								<input type="radio" name="research_kind" id="research_kind_1" <c:out value="<%=v_research_kind_1%>" /> value="중재연구(Interventional Study)" onclick="step8_research_kind();" /><label for="research_kind_1">중재연구(Intervention Study)</label>
								<input type="radio" name="research_kind" id="research_kind_2" <c:out value="<%=v_research_kind_2%>" /> value="관찰연구(Observational Study)" onclick="step8_research_kind();" /><label for="research_kind_2">관찰연구(Observational Study)</label>
							</td>
						</tr>
					</tbody>
				</table>
			
				<div  id="div_research_kind_1"><!-- 중재연구 -->
				<table class="bobor" cellspacing="0" cellpadding="0" border="0" summary="중재연구의 연구목적, 임상시험단계, 중재모형, 눈가림, 배정, 중재종류, 중재상세설명으로 구성된 중재연구 정보 입력테이블입니다.">
					<caption>중재연구 정보 입력</caption>
					<colgroup>
						<col width="90px" /><col width="130px" /><col width="60px" /><col width="110px" /><col width="60px" /><col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th colspan="3" rowspan="3" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />연구목적
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(7,1);"><img src="../images/resch/icon2014_help.png" alt="연구목적 설명" class="img_set" /></a><br />
							(Study Purpose)</th>
							<td colspan="3">
								<input type="radio" name="research_purpose" id="research_purpose_1" onclick="step8_research_purpose();" <c:out value="<%=v_research_purpose_1%>" /> value="치료(Treatment)" />
								<label for="research_purpose_1">치료(Treatment)</label><a style="margin-left:3px;"></a>
								<input type="radio" name="research_purpose" id="research_purpose_2" onclick="step8_research_purpose();" <c:out value="<%=v_research_purpose_2%>" /> value="예방(Prevention)" />
								<label for="research_purpose_2">예방(Prevention)</label>
								<input type="radio" name="research_purpose" id="research_purpose_3" onclick="step8_research_purpose();" <c:out value="<%=v_research_purpose_3%>" /> value="진단(Diagnosis)" />
								<label for="research_purpose_3">진단(Diagnosis)</label><a style="margin-left:44px;"></a>
								<input type="radio" name="research_purpose" id="research_purpose_4" onclick="step8_research_purpose();" <c:out value="<%=v_research_purpose_4%>" /> value="보조적 치료(Supportive Care)" />
								<label for="research_purpose_4">보조적 치료(Supportive Care)</label><br/>
								<input type="radio" name="research_purpose" id="research_purpose_5" onclick="step8_research_purpose();" <c:out value="<%=v_research_purpose_5%>" /> value="검진(Screening)" />
								<label for="research_purpose_5">검진(Screening)</label>
								<input type="radio" name="research_purpose" id="research_purpose_6" onclick="step8_research_purpose();" <c:out value="<%=v_research_purpose_6%>" /> value="보건의료서비스 연구(Health Services Research)" />
								<label for="research_purpose_6">보건의료서비스 연구(Health Services Research)</label>
								<input type="radio" name="research_purpose" id="research_purpose_7" onclick="step8_research_purpose();" <c:out value="<%=v_research_purpose_7%>" /> value="기초과학(Basic Science)" />
								<label for="research_purpose_7">기초과학(Basic Science)</label>
							</td>
						</tr>
						<tr>
							<td rowspan="2" class="textc borderset01">
								<input type="radio" name="research_purpose" id="research_purpose_8" onclick="step8_research_purpose();" <c:out value="<%=v_research_purpose_8%>" /> value="기타(Others)" /><label for="research_purpose_8" class="magset2">기타 (Others)</label>
							</td>
							<td class="textc borderset borderset01"><label for="research_purpose_etc" class="magset2">국문<br />(KOR)</label></td>
							<td class="borderset">
								<div class="resch_inset">
									<p>(<span id="byte_research_purpose_etc">0</span>&#47;200Byte)</p><br />
									<input type="text" name="research_purpose_etc" id="research_purpose_etc" title="연구목적 국문" value="<% out.print(v_research_purpose_etc); %>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:active;width:100%;" />
									<% if(!vo.getInputbox("research_purpose_etc").equals("")){%><script type="text/javascript">byteCheck("research_purpose_etc",200);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<td class="textc borderset01"><label for="research_purpose_etc_en" class="magset2">영문<br />(ENG)</label></td>  
							<td>
								<div class="resch_inset">
									<p>(<span id="byte_research_purpose_etc_en">0</span>&#47;200Byte)</p><br />
									<input type="text" name="research_purpose_etc_en" id="research_purpose_etc_en" title="연구목적 영문" value="<%out.print(v_research_purpose_etc_en); %>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:disabled;width:100%;" />
									<% if(!vo.getInputbox("research_purpose_etc_en").equals("")){%><script type="text/javascript">byteCheck("research_purpose_etc_en",200);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th colspan="3" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" /><label for="clinical_step">임상시험단계</label>
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(7,2);"><img src="../images/resch/icon2014_help.png" alt="임상시험단계 설명" class="img_set" /></a><br />
							(Phase)</th>
							<td colspan="3">
								<c:out value="<%=phaseField %>" escapeXml="false" />
							</td>
						</tr>
						<tr>
							<th colspan="3" rowspan="3" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />중재모형
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(7,3);"><img src="../images/resch/icon2014_help.png" alt="중재모형 설명" class="img_set" /></a><br />
							(Intervention Model)</th>
							<td colspan="3">
								<input type="radio" name="intervention_model" id="intervention_model_1" onclick="step8_intervention_model();" <c:out value="<%=v_intervention_model_1%>" /> value="단일군(Single Group)" />
								<label for="intervention_model_1">단일군(Single Group)</label>
								<input type="radio" name="intervention_model" id="intervention_model_2" onclick="step8_intervention_model();" <c:out value="<%=v_intervention_model_2%>" /> value="평행설계(Parallel)" />
								<label for="intervention_model_2">평행설계(Parallel)</label>
								<input type="radio" name="intervention_model" id="intervention_model_3" onclick="step8_intervention_model();" <c:out value="<%=v_intervention_model_3%>" /> value="교차설계(Cross-over)" />
								<label for="intervention_model_3">교차설계(Cross-over)</label>
								<input type="radio" name="intervention_model" id="intervention_model_4" onclick="step8_intervention_model();" <c:out value="<%=v_intervention_model_4%>" /> value="요인설계(Factorial)" />
								<label for="intervention_model_4">요인설계(Factorial)</label>
							</td>
						</tr>
						<tr>
							<td rowspan="2" class="textc borderset01">
								<input type="radio" name="intervention_model" id="intervention_model_5" onclick="step8_intervention_model();" <c:out value="<%=v_intervention_model_5%>" /> value="기타(Others)" /><label for="intervention_model_5" class="magset2">기타 (Others)</label>
							</td>
							<td class="textc borderset borderset01"><label for="intervention_model_etc" class="magset2">국문<br />(KOR)</label></td>
							<td class="borderset">
								<div class="resch_inset">
									<p>(<span id="byte_intervention_model_etc">0</span>&#47;200Byte)</p><br />
									<input type="text" name="intervention_model_etc" id="intervention_model_etc" title="중재모형 국문" value="<%out.print(v_intervention_model_etc); %>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:active;width:100%;" />
									<% if(!vo.getInputbox("intervention_model_etc").equals("")){%><script type="text/javascript">byteCheck("intervention_model_etc",200);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<td class="textc borderset01"><label for="intervention_model_etc_en" class="magset2">영문<br />(ENG)</label></td>
							<td>
								<div class="resch_inset">
									<p>(<span id="byte_intervention_model_etc_en">0</span>&#47;200Byte)</p><br />
									<input type="text" name="intervention_model_etc_en" id="intervention_model_etc_en" title="중재모형 영문" value="<%out.print(v_intervention_model_etc_en); %>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:disabled;width:100%;" />
									<% if(!vo.getInputbox("intervention_model_etc_en").equals("")){%><script type="text/javascript">byteCheck("intervention_model_etc_en",200);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th colspan="3" rowspan="2" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" /><label for="blinding">눈가림</label>
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(7,4);"><img src="../images/resch/icon2014_help.png" alt="눈가림 설명" class="img_set" /></a><br />
							(Blinding&#47;Masking)</th>
							<td colspan="3" class="borderset">중재 배정에 대한 인식 상태</td>
						</tr>
						<tr>
							<td colspan="2" class="textc borderset01">
								<select name="blinding" id="blinding" onChange="step8_blinding();" title="중재 배정에 대한 인식 상태 선택">
									<option value="사용안함(Open)" <c:out value="<%=v_blinding_1%>" /> >사용안함(Open)</option>
									<option value="단측(Single)" <c:out value="<%=v_blinding_2%>" /> >단측(Single)</option>
									<option value="양측(Double)" <c:out value="<%=v_blinding_3%>" /> >양측(Double)</option>
								</select>
							</td>
							<td>
								<p class="tbstit">대상자</p>
								<ul class="tbplist">
									<li><input type="checkbox" name="blinding_target" id="blinding_target_1" <c:out value="<%=v_blinding_target_1 %>" /> value="연구대상자(Subject)" onclick="javascript:step8_blind_target(this);" />
									<label for="blinding_target_1">연구대상자(Subject)</label></li>
									<li class="wset"><input type="checkbox" name="blinding_target" id="blinding_target_2" <c:out value="<%=v_blinding_target_2 %>" /> value="의사 또는 연구자(Investigator)" onclick="javascript:step8_blind_target(this);" />
									<label for="blinding_target_2">의사 또는 연구자(Investigator)</label></li>
									<li><input type="checkbox" name="blinding_target" id="blinding_target_3" <c:out value="<%=v_blinding_target_3 %>" /> value="보호자 및 간병인(Caregiver)" onclick="javascript:step8_blind_target(this);" />
									<label for="blinding_target_3">보호자 및 간병인(Caregiver)</label></li>
									<li class="wset"><input type="checkbox" name="blinding_target" id="blinding_target_4" <c:out value="<%=v_blinding_target_4 %>" /> value="결과분석자(Outcome Accessor)" onclick="javascript:step8_blind_target(this);" />
									<label for="blinding_target_4">결과분석자(Outcome Accessor)</label></li>
								</ul>
							</td>
						</tr>
						<tr>
							<th colspan="3" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />배정
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(7,5);"><img src="../images/resch/icon2014_help.png" alt="배정 설명" class="img_set" /></a><br />
							(Allocation)</th>
							<td colspan="3" class="borderset">연구대상자의 중재 그룹에 대한 배정 결과<br />
								<input type="radio" name="allocation" id="allocation_1" <c:out value="<%=v_allocation_1%>" /> value="무작위배정(RCT)" />
								<label for="allocation_1">무작위배정(RCT)</label>
								<input type="radio" name="allocation" id="allocation_2" <c:out value="<%=v_allocation_2%>" /> value="비무작위배정(Non-RCT)" />
								<label for="allocation_2">비무작위배정(Non-RCT)</label>
								<input type="radio" name="allocation" id="allocation_3" <c:out value="<%=v_allocation_3%>" /> value="해당사항없음(Not Applicable)" />
								<label for="allocation_3">해당사항없음(Not Applicable)</label>
							</td>
						</tr>
						<tr>
							<th colspan="3" rowspan="3" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />중재종류
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(7,6);"><img src="../images/resch/icon2014_help.png" alt="중재종류 설명" class="img_set" /></a><br />
							(Intervention Type)</th>
							<td colspan="3">
								<ul>
									<li><input type="checkbox" name="intervention_type" id="intervention_type_1" <c:out value="<%=v_intervention_type_1 %>" /> value="의약품(Drug)" />
									<label for="intervention_type_1">의약품(Drug)</label></li>
									<li><input type="checkbox" name="intervention_type" id="intervention_type_2" <c:out  value="<%=v_intervention_type_2 %>" /> value="의료기구(Medical Device)" />
									<label for="intervention_type_2">의료기구(Medical Device)</label></li>
									<li><input type="checkbox" name="intervention_type" id="intervention_type_3" onclick="cellFc(this);" <c:out value="<%=v_intervention_type_3 %>" /> value="생물학적제제/백신(Biological/Vaccine)" />
									<label for="intervention_type_3">생물학적제제&#47;백신(Biological/Vaccine)</label>
										<ul>
											 <li><input type="checkbox" name="intervention_type" id="intervention_type_4" onclick="cellFc(this);" <c:out value="<%=v_intervention_type_3_sel %>" /> <c:out value="<%=v_intervention_type_4 %>" /> value="줄기세포(Stem Cell)" />
											<label for="intervention_type_4">줄기세포(Stem Cell)</label></li>
											<li><input type="checkbox" name="intervention_type" id="intervention_type_5" onclick="cellFc(this);" <c:out value="<%=v_intervention_type_3_sel %>" /> <c:out value="<%=v_intervention_type_5 %>" /> value="줄기세포를 제외한 생물학적제제/백신(Non-Stem Cell)" />
											<label for="intervention_type_5">줄기세포를 제외한 생물학적제제&#47;백신(Non-Stem Cell)</label></li>
										</ul>
									</li>
									<li><input type="checkbox" name="intervention_type" id="intervention_type_6" <c:out value="<%=v_intervention_type_6 %>" /> value="시술&#47;수술(Procedure/Surgery)" />
									<label for="intervention_type_6">시술&#47;수술(Procedure/Surgery)</label></li>
									<li><input type="checkbox" name="intervention_type" id="intervention_type_7" <c:out value="<%=v_intervention_type_7 %>" /> value="방사선(Radiation)" />
									<label for="intervention_type_7">방사선(Radiation)</label></li>
									<li><input type="checkbox" name="intervention_type" id="intervention_type_8" <c:out value="<%=v_intervention_type_8 %>" /> value="행동요인(Behavioral)" />
									<label for="intervention_type_8">행동요인(Behavioral)</label></li>
									<li><input type="checkbox" name="intervention_type" id="intervention_type_9" <c:out value="<%=v_intervention_type_9 %>" /> value="유전적요인/유전자치료(Genetic)" />
									<label for="intervention_type_9">유전적요인&#47;유전자치료(Genetic)</label></li>
									<li><input type="checkbox" name="intervention_type" id="intervention_type_10" <c:out value="<%=v_intervention_type_10 %>" /> value="식이보충제(Dietary Supplement)" />
									<label for="intervention_type_10">식이보충제(Dietary Supplement)</label></li>
								</ul>
							</td>
						</tr>  
						<tr>
							<td rowspan="2" class="textc borderset01">
								<input type="checkbox" name="intervention_type" id="intervention_type_11" <c:out value="<%=v_intervention_type_11 %>" /> value="기타(Others)" onclick="step8_intervention_type_9();" /><label for="intervention_type_11" class="magset2">기타 (Others)</label>
							</td>
							<td class="textc borderset borderset01"><label for="intervention_type_etc" class="magset2">국문<br />(KOR)</label></td>
							<td class="borderset">
								<div class="resch_inset">
									<p>(<span id="byte_intervention_type_etc">0</span>&#47;200Byte)</p><br />
									<input type="text" name="intervention_type_etc" id="intervention_type_etc" title="중재종류 기타 국문" value="<%out.print(v_intervention_type_etc); %>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:active;width:100%;" />
									<% if(!vo.getInputbox("intervention_type_etc").equals("")){%><script type="text/javascript">byteCheck("intervention_type_etc",200);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<td class="textc borderset01"><label for="intervention_type_etc_en" class="magset2">영문<br />(ENG)</label></td>
							<td>
								<div class="resch_inset">
									<p>(<span id="byte_intervention_type_etc_en">0</span>&#47;200Byte)</p><br />
									<input type="text" name="intervention_type_etc_en" id="intervention_type_etc_en" title="중재종류 기타 영문" value="<%out.print(v_intervention_type_etc_en); %>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:disabled;width:100%;" />
									<% if(!vo.getInputbox("intervention_type_etc_en").equals("")){%><script type="text/javascript">byteCheck("intervention_type_etc_en",200);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th colspan="2" rowspan="2" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />중재상세설명
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(7,7);"><img src="../images/resch/icon2014_help.png" alt="중재상세설명 설명" class="img_set" /></a><br />
							(Intervention Description)</th>
							<th class="textc borderset borderset01" scope="row"><label for="arm_desc_kr" class="magset2">국문<br />(KOR)</label></th>
							<td colspan="3" class="borderset">
								중재 내용에 대한 주요사항(예. 약물인 경우 약물이름, 용량, 횟수, 기간, 주입 경로 등)이 포함되어야 하고, 중재 군간의 차이점을 상세히설명<br />
								<div class="resch_inset">
									<p>(<span id="byte_arm_desc_kr">0</span>&#47;4000Byte)</p><br />
									<textarea name="arm_desc_kr" id="arm_desc_kr" title="중재 상세설명 국문" maxlength="4000" maxbyte="4000" onKeyDown="byteCheck(this.id,4000);" onKeyUp="byteCheck(this.id,4000);" onChange="byteCheck(this.id,4000);" style="ime-mode:active;width:100%;height:50px;"><%out.print(v_arm_desc_kr); %></textarea>
									<% if(!vo.getInputbox("arm_desc_kr").equals("")){%><script type="text/javascript">byteCheck("arm_desc_kr",4000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc borderset01" scope="row"><label for="arm_desc_en" class="magset2">영문<br />(ENG)</label></th>
							<td colspan="3">
								<div class="resch_inset">
									<p>(<span id="byte_arm_desc_en">0</span>&#47;4000Byte)</p><br />
									<textarea name="arm_desc_en" id="arm_desc_en" title="중재 상세설명 영문" maxlength="4000" maxbyte="4000" onKeyDown="byteCheck(this.id,4000);" onKeyUp="byteCheck(this.id,4000);" onChange="byteCheck(this.id,4000);" style="ime-mode:disabled;width:100%;height:50px;"><%out.print(v_arm_desc_en); %></textarea>
									<% if(!vo.getInputbox("arm_desc_en").equals("")){%><script type="text/javascript">byteCheck("arm_desc_en",4000);</script><%}%>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				
				
				<%
					for( int i = 1; i <= 50; i++) 
					{
						if( armList.size() >= i ){
							armVo = armList.get(i-1);
						} else {
							armVo = new ValueObject();
						}
						String a_name_kr = armVo.getInputbox("name_kr");
						String a_name_en = armVo.getInputbox("name_en");
						String a_enrollment = armVo.getInputbox("enrollment") ;
						String a_content_kr = armVo.getInputbox("content_kr");
						String a_content_en = armVo.getInputbox("content_en");
						String a_style = i==1?"display:;":"display:none;";
				%>				
				<table class="bobor" id="arm_<c:out value="<%=i %>" />" cellspacing="0" cellpadding="0" border="0" summary="중재군명, 목표대상자 수, 중재군유형, 상세내용으로 구성된 중재군 정보 입력테이블입니다." style="<c:out value="<%=a_style%>" />">
					<caption>중재군 정보 입력</caption>
					<colgroup>
						<col width="80px" /><col width="140px" /><col width="60px" /><col width="110px" /><col width="60px" /><col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th colspan="6" class="tbtit" scope="col"><c:out value="<%=i%>" />. 중재군(Arm)
								<ul id="btnView_<c:out value="<%=i%>" />" class="retb_list">
									<li><a href="#add" onclick="jsMulti8_1('add','<c:out value="<%=i%>" />')" ><img src="../images/resch/btn2014_add.png" alt="추가" /></a></li>
									<%if(i!=1){%><li><a href="#minus" onclick="jsMulti8_1('del','<c:out value="<%=i%>" />')" ><img src="../images/resch/btn2014_del.png" alt="삭제" /></a></li><%}%>									
								</ul>
							</th>
						</tr>						
						<tr>
							<th rowspan="6" scope="row">중재군<%=i %><br />(Arm1)</th>
							<th rowspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />중재군명
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(7,8);"><img src="../images/resch/icon2014_help.png" alt="중재군명 설명" class="img_set" /></a><br />
							(Arm Label)</th>
							<th class="textc borderset borderset01" scope="row"><label for="arm_name_<%=i %>_kr" class="magset2">국문<br />(KOR)</label></th>
							<td colspan="3" class="borderset">
								<div class="resch_inset">
									<p>(<span id="byte_arm_name_<%=i %>_kr">0</span>&#47;200Byte)</p><br />
									<input type="text" name="arm_name_kr" id="arm_name_<%=i %>_kr" title="중재군 <%=i %> 중재군명 국문" value="<%out.print(a_name_kr); %>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:active;width:100%;" />
									<% if(!armVo.getInputbox("name_kr").equals("")){%><script type="text/javascript">byteCheck("arm_name_<%=i %>_kr",200);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc borderset01" scope="row"><label for="arm_name_<%=i %>_en" class="magset2">영문<br />(ENG)</label></th>
							<td colspan="3">
								<div class="resch_inset">
									<p>(<span id="byte_arm_name_<%=i %>_en">0</span>&#47;200Byte)</p><br />
									<input type="text" name="arm_name_en" id="arm_name_<%=i %>_en" title="중재군 <%=i %> 중재군명 영문" value="<%out.print(a_name_en); %>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:disabled;width:100%;" />
									<% if(!armVo.getInputbox("name_en").equals("")){%><script type="text/javascript">byteCheck("arm_name_<%=i %>_en",200);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th colspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" /><label for="arm_enrollment_<%=i %>">목표대상자 수</label>
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(7,9);"><img src="../images/resch/icon2014_help.png" alt="목표대상자 수 설명" class="img_set" /></a><br />
							(Target Number of Participant)</th>
							<td colspan="3"><input type="tel" name="arm_enrollment" id="arm_enrollment_<%=i %>" value="<%out.print(a_enrollment); %>"  onkeypress="javascript:onlyNumber()" maxlength="6" num style="ime-mode:disabled;width:100px;" /> 명 <c:out value="<%=v_enrollment_text%>" /></td>
						</tr>
						<tr>
							<th colspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" /><label for="arm_type_<%=i %>">중재군유형</label>
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(7,10);"><img src="../images/resch/icon2014_help.png" alt="중재군유형 설명" class="img_set" /></a><br />
							(Arm Type)</th>
							<td colspan="3">
							
							
								<select name="arm_type" id="arm_type_<%=i %>" title="중재군 유형 선택">
									<option value="">:::Arm type:::</option>
									<% for( int x = 0; x < armtypeList.size(); x++){ 
										String l_code_id = armtypeList.get(x).getInputbox("code_id");
										String l_code_id_selected = armtypeList.get(x).getInputbox("code_id").equals(armVo.getInputbox("type"))?"selected":"";
										String l_code_name = armtypeList.get(x).getInputbox("code_name")+"("+armtypeList.get(x).getInputbox("code_name_en")+")";
									%>
									<option value="<c:out value="<%=l_code_id %>" />" <c:out value="<%=l_code_id_selected%>" /> ><c:out value="<%=l_code_name %>" escapeXml="false" /></option>
									<% } %>									
								</select>							
							</td>
						</tr>
						<tr>
							<th rowspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />상세내용
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(7,11);"><img src="../images/resch/icon2014_help.png" alt="상세내용 설명" class="img_set" /></a><br />
							(Arm Description)</th>
							<th class="textc borderset borderset01" scope="row"><label for="arm_content_<%=i %>_kr" class="magset2">국문<br />(KOR)</label></th>
							<td colspan="3" class="borderset">중재 내용에 대한 주요 사항(예. 약물인 경우 용량, 횟수 및 기간 등)이 포함<br />
								<div class="resch_inset">
									<p>(<span id="byte_arm_content_<%=i %>_kr">0</span>&#47;4000Byte)</p><br />
									<textarea name="arm_content_kr" id="arm_content_<%=i %>_kr" title="중재군 <%=i %> 상세내용 국문" maxlength="40000" maxByte="40000" onKeyDown="byteCheck(this.id,4000);" onKeyUp="byteCheck(this.id,4000);" onChange="byteCheck(this.id,4000);" style="ime-mode:active;width:100%;height:50px;"><%out.print(a_content_kr); %></textarea>
									<% if(!armVo.getInputbox("content_kr").equals("")){%><script type="text/javascript">byteCheck("arm_content_<%=i %>_kr",4000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc borderset01" scope="row"><label for="arm_content_<%=i %>_en" class="magset2">영문<br />(ENG)</label></th>
							<td colspan="3">
								<div class="resch_inset">
									<p>(<span id="byte_arm_content_<%=i %>_en">0</span>&#47;4000Byte)</p><br />
									<textarea name="arm_content_en" id="arm_content_<%=i %>_en" title="중재군 <%=i %> 상세내용 영문" maxlength="4000" maxByte="4000" onKeyDown="byteCheck(this.id,4000);" onKeyUp="byteCheck(this.id,4000);" onChange="byteCheck(this.id,4000);" style="ime-mode:disabled;width:100%;height:50px;"><%out.print(a_content_en); %></textarea>
									<% if(!armVo.getInputbox("content_en").equals("")){%><script type="text/javascript">byteCheck("arm_content_<%=i %>_en",4000);</script><%}%>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				<% } %>
			</div>
			
			<div  id="div_research_kind_2"><!-- 관찰연구 -->
				<table class="bobor" cellspacing="0" cellpadding="0" border="0" summary="관찰연구의 관찰연구모형, 연구관점, 목표대상자 수로 구성된 관찰연구 정보 입력테이블입니다.">
					<caption>관찰연구 정보 입력</caption>
					<colgroup>
						<col width="90px" /><col width="130px" /><col width="60px" /><col width="110px" /><col width="60px" /><col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th colspan="3" scope="row">
								<img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" /><label for="observational_model">관찰연구모형</label>
								<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(8,1);"><img src="../images/resch/icon2014_help.png" alt="관찰연구모형 설명" class="img_set" /></a><br />
								(Observational Study Model)
							</th>
							<td colspan="3">
								<select name="observational_model" id="observational_model" title="관찰연구모형 선택">
									<option value="Cohort" <c:out value="<%=v_observational_model_1%>" /> >Cohort</option>
									<option value="Case-control" <c:out value="<%=v_observational_model_2%>" /> >Case-control</option>
									<option value="Case-only" <c:out value="<%=v_observational_model_3%>" /> >Case-only</option>
									<option value="Case-crossover" <c:out value="<%=v_observational_model_4%>" /> >Case-crossover</option>
									<option value="Ecologic or community studies" <c:out value="<%=v_observational_model_5%>" /> >Ecologic or community studies</option>
									<option value="Family-based" <c:out value="<%=v_observational_model_6%>" /> >Family-based</option>
									<option value="Others" <c:out value="<%=v_observational_model_7%>" /> >Others</option>
								</select>
							</td>
						</tr>
						<tr>
							<th colspan="3" rowspan="3" scope="row">
								<img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />연구관점
								<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(8,2);"><img src="../images/resch/icon2014_help.png" alt="연구관점 설명" class="img_set" /></a><br />
								(Time Perspective)
							</th>
							<td colspan="3">연구대상자 등록 시기와 관찰기간의 시간적 관련성<br />
								<input type="radio" name="time_perspective" id="time_perspective_1" onclick="step8_time_perspective();" <c:out value="<%=v_time_perspective_1%>" /> value="전향적(Prospective)" />
								<label for="time_perspective_1">전향적(Prospective)</label>
								<input type="radio" name="time_perspective" id="time_perspective_2" onclick="step8_time_perspective();" <c:out value="<%=v_time_perspective_2%>" /> value="후향적(Retrospective)" />
								<label for="time_perspective_2">후향적(Retrospective)</label>
								<input type="radio" name="time_perspective" id="time_perspective_3" onclick="step8_time_perspective();" <c:out value="<%=v_time_perspective_3%>" /> value="단면연구(Cross-sectional)" />
								<label for="time_perspective_3">단면연구(Cross-sectional)</label>
							</td>
						</tr>
						<tr>
							<td rowspan="2" class="textc borderset01">
								<input type="radio" name="time_perspective" id="time_perspective_4" onclick="step8_time_perspective();" <c:out value="<%=v_time_perspective_4%>" /> value="기타(Others)" /><label for="time_perspective_4" class="magset2">기타 (Others)</label>
							</td>
							<td class="textc borderset borderset01"><label for="time_perspective_etc" class="magset2">국문<br />(KOR)</label></td>
							<td class="borderset">
								<div class="resch_inset">
									<p>(<span id="byte_time_perspective_etc">0</span>&#47;200Byte)</p><br />
									<input type="text" name="time_perspective_etc" id="time_perspective_etc" title="연구관점 기타 국문" value="<%out.print(v_time_perspective_etc); %>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:active;width:100%;" />
									<% if(!vo.getInputbox("time_perspective_etc").equals("")){%><script type="text/javascript">byteCheck("time_perspective_etc",200);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<td class="textc borderset01"><label for="time_perspective_etc_en" class="magset2">영문<br />(ENG)</label></td>
							<td>
								<div class="resch_inset">
									<p>(<span id="byte_time_perspective_etc_en">0</span>&#47;200Byte)</p><br />
									<input type="text" name="time_perspective_etc_en" id="time_perspective_etc_en" title="연구관점 기타 영문" value="<%out.print(v_time_perspective_etc_en); %>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:disabled;width:100%;" />
									<% if(!vo.getInputbox("time_perspective_etc_en").equals("")){%><script type="text/javascript">byteCheck("time_perspective_etc_en",200);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th colspan="3" scope="row">
								<img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" /><label for="biospecimen_enrollment">목표대상자 수</label>
								<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(8,3);"><img src="../images/resch/icon2014_help.png" alt="목표대상자 수 설명" class="img_set" /></a><br />
								(Target Number of Participant)
							</th>
							<td colspan="3"><input type="tel" name="biospecimen_enrollment" id="biospecimen_enrollment" value="<%out.print(v_biospecimen_enrollment); %>"  onkeypress="javascript:onlyNumber()" maxlength="6" num style="ime-mode:disabled;width:100px;" /> 명 <c:out value="<%=v_enrollment_text%>" /></td>
						</tr>
					</tbody>
				</table>						
						
			<%
			for( int i = 1; i <= 50; i++) {
				if( cohortList.size() >= i ){
					cohortVo = cohortList.get(i-1);
				} else {
					cohortVo = new ValueObject();
				}
				String c_name_kr = cohortVo.getInputbox("name_kr");
				String c_name_en = cohortVo.getInputbox("name_en");
				String c_content_kr = cohortVo.getInputbox("content_kr");
				String c_content_en = cohortVo.getInputbox("content_en");
			%>						
				<table id="cohort_<%=i %>" style="<%=i==1?"display:;":"display:none;"%>" class="bobor" cellspacing="0" cellpadding="0" border="0" summary="관찰군명, 관찰군상세내용으로 구성된 관찰군 정보 입력테이블입니다.">
					<caption>관찰군 정보 입력</caption>
					<colgroup>
						<col width="90px" /><col width="130px" /><col width="60px" /><col width="110px" /><col width="60px" /><col width="*" />
					</colgroup>
					<tbody>		
						<tr>
							<th colspan="6" class="tbtit" scope="col"><c:out value="<%=i%>" />. 관찰군 (Cohort/Group)
								<ul class="retb_list">
									<li><a href="#add" onclick="jsMulti8_2('add','<c:out value="<%=i%>" />')" ><img src="../images/resch/btn2014_add.png" alt="추가" /></a></li>
									<%if(i!=1){%><li><a href="#minus" onclick="jsMulti8_2('del','<c:out value="<%=i%>" />')" ><img src="../images/resch/btn2014_del.png" alt="삭제" /></a></li><%}%>		
								</ul>
							</th> 
						</tr>										
						<tr>
							<th rowspan="4" scope="row">관찰군<c:out value="<%=i%>" /><br />(Cohort&#47;<br />&nbsp;&nbsp;Group)</th>
							<th rowspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />관찰군명
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(8,4);"><img src="../images/resch/icon2014_help.png" alt="관찰군명 설명" class="img_set" /></a><br />
							(Cohort&#47;Group<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Label)</th>
							<th class="textc borderset borderset01" scope="row"><label for="cohort_name_<%=i %>_kr" class="magset2">국문<br />(KOR)</label></th>
							<td colspan="3" class="borderset">
								<div class="resch_inset">
									<p>(<span id="byte_cohort_name_<%=i %>_kr">0</span>&#47;200Byte)</p><br />
									<input type="text" name="cohort_name_kr" id="cohort_name_<%=i %>_kr" title="관찰군 <c:out value="<%=i%>" /> 관찰군명 국문" value="<%out.print(c_name_kr); %>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:active;width:100%;" />
									<% if(!cohortVo.getInputbox("name_kr").equals("")){%><script type="text/javascript">byteCheck("cohort_name_<%=i %>_kr",200);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc borderset01" scope="row"><label for="cohort_name_<%=i %>_en" class="magset2">영문<br />(ENG)</label></th>
							<td colspan="3">
								<div class="resch_inset">
									<p>(<span id="byte_cohort_name_<%=i %>_en">0</span>&#47;200Byte)</p><br />
									<input type="text" name="cohort_name_en" id="cohort_name_<%=i %>_en" title="관찰군 <c:out value="<%=i%>" /> 관찰군명 영문" value="<%out.print(c_name_en); %>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:disabled;width:100%;" />
									<% if(!cohortVo.getInputbox("name_en").equals("")){%><script type="text/javascript">byteCheck("cohort_name_<%=i %>_en",200);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th rowspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />상세내용
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(8,5);"><img src="../images/resch/icon2014_help.png" alt="상세내용 설명" class="img_set" /></a><br />
							(Cohort&#47;Group <br />&nbsp;&nbsp;&nbsp;&nbsp;Description)</th>
							<th class="textc borderset borderset01" scope="row"><label for="cohort_content_<%=i %>_kr" class="magset2">국문<br />(KOR)</label></th>
							<td colspan="3" class="borderset">
								<div class="resch_inset">
									<p>(<span id="byte_cohort_content_<%=i %>_kr">0</span>&#47;4000Byte)</p><br />
									<textarea name="cohort_content_kr" id="cohort_content_<%=i %>_kr" title="관찰군 <c:out value="<%=i%>" /> 상세내용 국문" maxlength="4000" maxByte="4000" onKeyDown="byteCheck(this.id,4000);" onKeyUp="byteCheck(this.id,4000);" onChange="byteCheck(this.id,4000);" style="ime-mode:active;width:100%;height:50px;"><%out.print(c_content_kr); %></textarea>
									<% if(!cohortVo.getInputbox("content_kr").equals("")){%><script type="text/javascript">byteCheck("cohort_content_<%=i %>_kr",4000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc borderset01" scope="row"><label for="cohort_content_<%=i %>_en" class="magset2">영문<br />(ENG)</label></th>
							<td colspan="3">
								<div class="resch_inset">
									<p>(<span id="byte_cohort_content_<%=i %>_en">0</span>&#47;4000Byte)</p><br />
									<textarea name="cohort_content_en" id="cohort_content_<%=i %>_en" title="관찰군 <c:out value="<%=i%>" /> 상세내용 영문" maxlength="4000" maxByte="4000" onKeyUp="byteCheck(this.id,4000);" onChange="byteCheck(this.id,4000);" style="ime-mode:disabled;width:100%;height:50px;"><%out.print(c_content_en); %></textarea>
									<% if(!cohortVo.getInputbox("content_en").equals("")){%><script type="text/javascript">byteCheck("cohort_content_<%=i %>_en",4000);</script><%}%>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			<% } %>				
					
				<table class="bobor" cellspacing="0" cellpadding="0" border="0" summary="생물자원저장, 생물자원 종류로 구성된 연구 정보 입력테이블입니다.">
					<caption>생물자원저장, 생물자원 종류 입력</caption>
					<colgroup>
						<col width="90px" /><col width="130px" /><col width="60px" /><col width="110px" /><col width="60px" /><col width="*" />
					</colgroup>
					<tbody>	
						<tr>
							<th colspan="3" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />생물자원 저장
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(8,6);"><img src="../images/resch/icon2014_help.png" alt="생물자원 저장 설명" class="img_set" /></a><br />
							(Biospecimen Collection & Archiving)</th>
							<td colspan="3">
								<ul>
									<li><input type="radio" name="biospecimen_retention" id="biospecimen_retention_1" onclick="step8_biospecimen_retention();" <c:out value="<%=v_biospecimen_retention_1%>" /> value="저장안함(Not collect nor Archive)" />
									<label for="biospecimen_retention_1">저장안함(Not collect nor Archive)</label></li>
									<li><input type="radio" name="biospecimen_retention" id="biospecimen_retention_2" onclick="step8_biospecimen_retention();" <c:out value="<%=v_biospecimen_retention_2%>" /> value="저장: DNA 포함(Collect & Archive: Sample with DNA)" />
									<label for="biospecimen_retention_2">저장: DNA 포함(Collect & Archive: Sample with DNA)</label></li>
									<li><input type="radio" name="biospecimen_retention" id="biospecimen_retention_3" onclick="step8_biospecimen_retention();" <c:out value="<%=v_biospecimen_retention_3%>" /> value="저장: DNA 비포함(Collect & Archive: Sample without DNA)" />
									<label for="biospecimen_retention_3">저장: DNA 비포함(Collect & Archive: Sample without DNA)</label></li>
								</ul>
							</td>
						</tr>										
						<tr>
							<th colspan="2" rowspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />생물자원 종류
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(8,7);"><img src="../images/resch/icon2014_help.png" alt="생물자원 종류 설명" class="img_set" /></a><br /> 
							(Biospecimen Description)</th>
							<th class="textc borderset borderset01" scope="row"><label for="biospecimen_description_kr" class="magset2">국문<br />(KOR)</label></th>
							<td colspan="3" class="borderset">저장하는 생물자원의 종류를 모두 입력하십시오.<br />예) 전혈, 혈청, 백혈구, 소변, 조직<br />
								<div class="resch_inset">
									<p>(<span id="byte_biospecimen_description_kr">0</span>&#47;200Byte)</p><br />
									<input type="text" name="biospecimen_description_kr" id="biospecimen_description_kr" title="생물자원 저장 국문" value="<%out.print(v_biospecimen_description_kr); %>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:active;width:100%;" />
									<% if(!vo.getInputbox("biospecimen_description_kr").equals("")){%><script type="text/javascript">byteCheck("biospecimen_description_kr",200);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc borderset01" scope="row"><label for="biospecimen_description_en" class="magset2">영문<br />(ENG)</label></th>
							<td colspan="3">
								<div class="resch_inset">
									<p>(<span id="byte_biospecimen_description_en">0</span>&#47;200Byte)</p><br />
									<input type="text" name="biospecimen_description_en" id="biospecimen_description_en" title="생물자원 저장 영문" value="<%out.print(v_biospecimen_description_en); %>" maxlength="200" maxByte="200" onKeyDown="byteCheck(this.id,200);" onKeyUp="byteCheck(this.id,200);" onChange="byteCheck(this.id,200);" style="ime-mode:disabled;width:100%;" />
									<% if(!vo.getInputbox("biospecimen_description_en").equals("")){%><script type="text/javascript">byteCheck("biospecimen_description_en",200);</script><%}%>
								</div>
							</td>
						</tr>
					</tbody>
				</table>			
			</div>
				
			</form>
				<ul class="research_noice">
					<li class="font_red"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />WHO ICTRP (International Clinical Trial Registry Platform)에서 요구하는 필수등록항목입니다.</li>
					<li class="font_blue"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />CRIS 필수등록항목입니다.</li>
				</ul>
			</div>
			
			<div class="res_btnbox">
				<ul class="research_btn">
					<li><a href="#preview" title="(새창으로 이동)" onclick="preView(8);" ><img src="../images/resch/btn_preview.gif" alt="미리보기" /></a></li>
					<% if(sVO.equals("mod", "")){ %>
						<li><a href="./step7.jsp?seq=<c:out value="<%=s_seq%>" />"><img src="../images/resch/btn_prevstep.gif" alt="이전 단계로" /></a></li>
					<% } %>					
					<li><a href="#removeAll" onclick="Remove(8);" ><img src="../images/resch/btn_allcancel.gif" alt="모두 지우기" /></a></li>
					<li><a href="#tempSave" onclick="TempSave(8);" ><img src="../images/resch/btn_storage.gif" alt="임시저장" /></a></li>
				<% if(sVO.equals("mod", "")){ %>
					<li><a href="#save" onclick="Save(8);" ><img src="../images/resch/btn_nextstep2.gif" alt="다음 단계로" /></a></li>
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
