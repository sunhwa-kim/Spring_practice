<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.buildnine.util.VOSet"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>결과변수 | 임상연구등록</title>
	<%@include file="../include/title.jsp" %>
	<%@include file="../include/write_session.jsp" %>

	<script type="text/javascript" src="../js/common.js"></script>
	<script type="text/javascript" src="../js/write.js"></script>

	<script type="text/javascript" src="../js/byteCheck.js"></script>
	<script type="text/javascript">
	<!--
		function jsMulti10_1(str, idx)
		{
			cnt = document.form.primary_outcome_count.value;

			if(str == "add")
			{
				sum = eval(cnt) + 1;
				for( var i = eval(idx)+eval("1"); i <= 50; i++) {
					if(document.getElementById("primary_outcome_"+i).style.display == "none")
					{
						document.getElementById("primary_outcome_"+i).style.display = "";
						break;
					}
				}
			}
			else
			{
				sum = eval(cnt) - 1;
				document.getElementById("primary_outcome_kr_"+eval(idx)).value='';
				document.getElementById("primary_outcome_en_"+eval(idx)).value='';
				document.getElementById("primary_timepoint_kr_"+eval(idx)).value='';
				document.getElementById("primary_timepoint_en_"+eval(idx)).value='';

				document.getElementById("primary_outcome_"+eval(idx)).style.display = "none";	
			}

			document.form.primary_outcome_count.value = sum;
			//step10_primary_outcome_count();
		}

		function jsMulti10_2(str, idx)
		{
			cnt = document.form.secondary_outcome_count.value;

			if(str == "add")
			{
				sum = eval(cnt) + 1;
				for( var i = eval(idx)+eval("1"); i <= 50; i++) {
					if(document.getElementById("secondary_outcome_"+i).style.display == "none")
					{
						document.getElementById("secondary_outcome_"+i).style.display = "";
						break;
					}
				}
			}
			else
			{
				sum = eval(cnt) - 1;
				document.getElementById("secondary_outcome_kr_"+eval(idx)).value='';
				document.getElementById("secondary_outcome_en_"+eval(idx)).value='';
				document.getElementById("secondary_timepoint_kr_"+eval(idx)).value='';
				document.getElementById("secondary_timepoint_en_"+eval(idx)).value='';

				document.getElementById("secondary_outcome_"+eval(idx)).style.display = "none";	
			}

			document.form.secondary_outcome_count.value = sum;
			//step10_secondary_outcome_count();
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
<body onload="RemoveForm(10);">
<%

	ValueObject sVO = new ValueObject();
	ValueObject vo = new ValueObject();

	VOSet outcompList = new VOSet();
	ValueObject outcompVo = null;

	VOSet outcomsList = new VOSet();
	ValueObject outcomsVo = null;
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
			vo = QueryAction.getQueryView("CRIS_DATA.step10", sVO);

			sVO.put("gubun", "P");
			outcompList = QueryAction.getQueryList("CRIS_DATA.outcome_list", sVO);

			sVO.put("gubun", "S");
			outcomsList = QueryAction.getQueryList("CRIS_DATA.outcome_list", sVO);
		}

		int pCnt = outcompList.size();
		int sCnt = outcomsList.size();
		
		String s_seq = sVO.get("seq");
		String v_seq = vo.getInputbox("seq");
		String v_status = vo.getInputbox("status");
		String v_seq_group = vo.getInputbox("seq_group");
		String v_mod = sVO.getInputbox("mod");
		int v_pcnt = pCnt == 0 ? 1 : pCnt;
		int v_scnt = sCnt == 0 ? 1 : sCnt;
		String research_title_kr = StringUtil.getTitleLimit(vo.getInputbox("research_title_kr"),83);
		String v_type_of_endpoint_1 = vo.getInputbox("type_of_endpoint").equals("안전성(Safety)")?"selected":"";
		String v_type_of_endpoint_2 = vo.getInputbox("type_of_endpoint").equals("유효성(Efficacy)")?"selected":"";
		String v_type_of_endpoint_3 = vo.getInputbox("type_of_endpoint").equals("안전성/유효성(Safety/Efficacy)")?"selected":"";
		String v_type_of_endpoint_4 = vo.getInputbox("type_of_endpoint").equals("생물학적동등성(Bio-Equivalence)")?"selected":"";
		String v_type_of_endpoint_5 = vo.getInputbox("type_of_endpoint").equals("생물학적이용성(Bio-availability)")?"selected":"";
		String v_type_of_endpoint_6 = vo.getInputbox("type_of_endpoint").equals("약물동태성(Pharmacokinetics)")?"selected":"";
		String v_type_of_endpoint_7 = vo.getInputbox("type_of_endpoint").equals("약물역학(Pharmacodynamics)")?"selected":"";
		String v_type_of_endpoint_8 = vo.getInputbox("type_of_endpoint").equals("약물동태&역학(Pharmacokinetics/dynamics)")?"selected":"";
		String v_type_of_endpoint_9 = vo.getInputbox("type_of_endpoint").equals("임상적동등성(clinical-equivalence)")?"selected":"";
		String v_type_of_endpoint_10 = vo.getInputbox("type_of_endpoint").equals("해당사항 없음(Not applicable)")?"selected":"";		
		
		
		//ddddddddddddddddddddddddd
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
				<h3><img src="../images/resch/tit2014_wstep10.gif" alt="10. 결과변수 (Outcome Measure(s))" /></h3>
			</div>

			<div class="research_tb">
			
			<iframe name="iframe" title="의미없는 아이프레임" style="display:none;" width="0" height="0"></iframe>
			<form name="form" id="form" method="post">
			<input type="hidden" name="seq" 	id="seq" 	value="<c:out value="<%=v_seq%>" />" />
			<input type="hidden" name="status" 	id="status" value="<c:out value="<%=v_status%>" />" />
			<input type="hidden" name="seq_group"	id="seq_group" 	value="<c:out value="<%=v_seq_group%>" />" />
			<input type="hidden" name="mode" 	id="mode" 	value="" />
			<input type="hidden" name="mod" id="mod" value="<c:out value="<%=v_mod%>" />" />
			<input type="hidden" name="primary_outcome_count" id="primary_outcome_count"	value="<c:out value="<%= v_pcnt %>" />">
			<input type="hidden" name="secondary_outcome_count" id="secondary_outcome_count"	value="<c:out value="<%= v_scnt %>" />">
			<input type="hidden" name="step" id="step" />
			
				<table class="tobor" cellspacing="0" cellpadding="0" border="0" summary="주요결과변수 유형 입력테이블입니다.">
					<caption>주요결과변수 유형 입력</caption>
					<colgroup>
						<col width="185px" /><col width="100px" /><col width="60px" /><col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th colspan="3" scope="row"><label for="type_of_endpoint"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />주요결과변수 유형 (Type of Primary Outcome)</label></th>
							<td>
								<select name="type_of_endpoint" id="type_of_endpoint" style="width:350px;" title="주요결과변수 유형 선택">
									<option value="" >:::선택:::</option>
									<option value="안전성(Safety)" <c:out value="<%=v_type_of_endpoint_1%>" /> >안전성(Safety)</option>
									<option value="유효성(Efficacy)" <c:out value="<%=v_type_of_endpoint_2%>" /> >유효성(Efficacy)</option>
									<option value="안전성/유효성(Safety/Efficacy)" <c:out value="<%=v_type_of_endpoint_3%>" /> >안전성&#47;유효성(Safety/Efficacy)</option>
									<option value="생물학적동등성(Bio-Equivalence)" <c:out value="<%=v_type_of_endpoint_4%>" /> >생물학적동등성(Bio-Equivalence)</option>
									<option value="생물학적이용성(Bio-availability)" <c:out value="<%=v_type_of_endpoint_5%>" /> >생물학적이용성(Bio-availability)</option>
									<option value="약물동태성(Pharmacokinetics)" <c:out value="<%=v_type_of_endpoint_6%>" /> >약물동태성(Pharmacokinetics)</option>
									<option value="약물역학(Pharmacodynamics)" <c:out value="<%=v_type_of_endpoint_7%>" /> >약물역학(Pharmacodynamics)</option>
									<option value="약물동태&역학(Pharmacokinetics/dynamics)" <c:out value="<%=v_type_of_endpoint_8%>" /> >약물동태&역학(Pharmacokinetics&#47;dynamics)</option>
									<option value="임상적동등성(clinical-equivalence)" <c:out value="<%=v_type_of_endpoint_9%>" /> >임상적동등성(clinical-equivalence)</option>
									<option value="해당사항 없음(Not applicable)" <c:out value="<%=v_type_of_endpoint_10%>" /> >해당사항 없음(Not applicable)</option>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
				
			<%
			for( int i = 1; i <= 50; i++) {

				if( outcompList.size() >= i ){
					outcompVo = outcompList.get(i-1);
				} else {
					outcompVo = new ValueObject();
				}
				String o_style = i <=(pCnt == 0 ? 1 : pCnt) ? "display:;":"display:none;";
				String o_outcome_kr = outcompVo.getInputbox("outcome_kr");
				String o_outcome_en = outcompVo.getInputbox("outcome_en");
				String o_timepoint_kr = outcompVo.getInputbox("timepoint_kr");
				String o_timepoint_en = outcompVo.getInputbox("timepoint_en");
			%>												
				<table id="primary_outcome_<c:out value="<%=i%>" />" style="<c:out value="<%= o_style %>" />" class="bobor" cellspacing="0" cellpadding="0" border="0" summary="주요결과변수 유형, 주요결과변수 평가항목, 주요결과변수 평가시기로 구성된 결과변수 정보 입력테이블입니다.">
					<caption>주요결과변수 정보 입력</caption>
					<colgroup>
						<col width="185px" /><col width="100px" /><col width="60px" /><col width="*" />
					</colgroup>
					<tbody>			
						<tr>
							<th colspan="4" class="tbtit" scope="col"><%=i%>. 주요결과변수   
								<ul class="retb_list">
									<li><a href="#add" onclick="jsMulti10_1('add','<%=i%>')" ><img src="../images/resch/btn2014_add.png" alt="추가" /></a></li>
									<%if(i!=1){%><li><a href="#minus" onclick="jsMulti10_1('del','<c:out value="<%=i%>" />')" ><img src="../images/resch/btn2014_del.png" alt="삭제" /></a></li><%}%>						
								</ul>
							</th>
						</tr>
						<tr>
							<th rowspan="4" scope="row">주요결과 변수<c:out value="<%=i%>" /><br />(Primary Outcome)</th>
							<th rowspan="2" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />평가항목<br />(Outcome)</th>
							<th class="textc borderset" scope="row"><label for="primary_outcome_kr_<c:out value="<%=i %>" />" class="magset2">국문<br />(KOR)</label></th>
							<td class="borderset">
								<div class="resch_inset">  
									<p>(<span id="byte_primary_outcome_kr_<c:out value="<%=i %>" />">0</span>&#47;2000Byte)</p><br />
									<input type="text" name="primary_outcome_kr" id="primary_outcome_kr_<c:out value="<%=i %>" />" title="주요결과 변수 <c:out value="<%=i %>" /> 평가항목 국문" value="<%out.print(o_outcome_kr);%>" maxlength="2000" maxByte="2000" onKeyDown="byteCheck(this.id,2000);" onKeyUp="byteCheck(this.id,2000);" onChange="byteCheck(this.id,2000);" style="ime-mode:active;width:100%;" />
									<% if(!outcompVo.getInputbox("outcome_kr").equals("")){%><script type="text/javascript">byteCheck("primary_outcome_kr_<c:out value="<%=i %>" />",2000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc" scope="row"><label for="primary_outcome_en_<c:out value="<%=i %>" />" class="magset2">영문<br />(ENG)</label></th>
							<td>
								<div class="resch_inset">
									<p>(<span id="byte_primary_outcome_en_<c:out value="<%=i %>" />">0</span>&#47;2000Byte)</p><br />
									<input type="text" name="primary_outcome_en" id="primary_outcome_en_<c:out value="<%=i %>" />" title="주요결과 변수 <c:out value="<%=i %>" /> 평가항목 영문" value="<%out.print(o_outcome_en); %>" maxlength="2000" maxByte="2000" onKeyDown="byteCheck(this.id,2000);" onKeyUp="byteCheck(this.id,2000);" onChange="byteCheck(this.id,2000);" style="ime-mode:disabled;width:100%;" />
									<% if(!outcompVo.getInputbox("outcome_en").equals("")){%><script type="text/javascript">byteCheck("primary_outcome_en_<c:out value="<%=i %>" />",2000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th rowspan="2" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />평가시기<br />(Timepoint)</th>
							<th class="textc borderset" scope="row"><label for="primary_timepoint_kr_<c:out value="<%=i %>" />" class="magset2">국문<br />(KOR)</label></th>
							<td class="borderset">
								<div class="resch_inset">
									<p>(<span id="byte_primary_timepoint_kr_<c:out value="<%=i %>" />">0</span>&#47;2000Byte)</p>
									<input type="text" name="primary_timepoint_kr" id="primary_timepoint_kr_<c:out value="<%=i %>" />" title="주요결과 변수 <c:out value="<%=i %>" /> 평가시기 국문" value="<%out.print(o_timepoint_kr); %>" maxlength="2000" maxByte="2000" onKeyDown="byteCheck(this.id,2000);" onKeyUp="byteCheck(this.id,2000);" onChange="byteCheck(this.id,2000);" style="ime-mode:active;width:100%;" />
									<% if(!outcompVo.getInputbox("timepoint_kr").equals("")){%><script type="text/javascript">byteCheck("primary_timepoint_kr_<c:out value="<%=i %>" />",2000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc" scope="row"><label for="primary_timepoint_en_<c:out value="<%=i %>" />" class="magset2">영문<br />(ENG)</label></th>
							<td>
								<div class="resch_inset">
									<p>(<span id="byte_primary_timepoint_en_<c:out value="<%=i %>" />">0</span>&#47;2000Byte)</p>
									<input type="text" name="primary_timepoint_en" id="primary_timepoint_en_<c:out value="<%=i %>" />" title="주요결과 변수 <c:out value="<%=i %>" /> 평가시기 영문" value="<%out.print(o_timepoint_en); %>" maxlength="2000" maxByte="2000" onKeyDown="byteCheck(this.id,2000);" onKeyUp="byteCheck(this.id,2000);" onChange="byteCheck(this.id,2000);" style="ime-mode:disabled;width:100%;" />
									<% if(!outcompVo.getInputbox("timepoint_en").equals("")){%><script type="text/javascript">byteCheck("primary_timepoint_en_<c:out value="<%=i %>" />",2000);</script><%}%>
								</div>
							</td>
						</tr>
					</tbody>
				</table>						
			<% } %>			

			<%
			for( int i = 1; i <= 50; i++) {
				if( outcomsList.size() >= i ){
					outcomsVo = outcomsList.get(i-1);
				} else {
					outcomsVo = new ValueObject();
				}
				String o_style = i <=(sCnt == 0 ? 1 : sCnt) ? "display:;":"display:none;";
				String o_outcome_kr = outcomsVo.getInputbox("outcome_kr");
				String o_outcome_en = outcomsVo.getInputbox("outcome_en");
				String o_timepoint_kr = outcomsVo.getInputbox("timepoint_kr");
				String o_timepoint_en = outcomsVo.getInputbox("timepoint_en");
			%>								
				<table id="secondary_outcome_<c:out value="<%=i %>" />" style="<c:out value="<%= o_style %>" />" class="bobor" cellspacing="0" cellpadding="0" border="0" summary="보조결과변수 평가항목, 보조결과변수 평가시기로 구성된 결과변수 정보 입력테이블입니다.">
					<caption>보조결과변수 정보 입력</caption>
					<colgroup>
						<col width="185px" /><col width="95px" /><col width="60px" /><col width="*" />
					</colgroup>
					<tbody>				
						<tr>
							<th colspan="4" class="tbtit" scope="col"><c:out value="<%=i %>" />. 보조결과변수
								<ul class="retb_list">
									<li><a href="#add" onclick="jsMulti10_2('add','<c:out value="<%=i %>" />')"><img src="../images/resch/btn2014_add.png" alt="추가" /></a></li>
									<%if(i!=1){%><li><a href="#minus" onclick="jsMulti10_2('del','<c:out value="<%=i %>" />')" ><img src="../images/resch/btn2014_del.png" alt="삭제" /></a></li><%}%>
								</ul>
							</th>
						</tr>
						<tr>
							<th rowspan="4" scope="row">보조결과 변수<c:out value="<%=i %>" /><br />(Secondary Outcome)</th>
							<th rowspan="2" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />평가항목<br />(Outcome)</th>
							<th class="textc borderset" scope="row"><label for="secondary_outcome_kr_<c:out value="<%=i %>" />" class="magset2">국문<br />(KOR)</label></th>
							<td class="borderset">
								<div class="resch_inset">
									<p>(<span id="byte_secondary_outcome_kr_<c:out value="<%=i %>" />">0</span>&#47;2000Byte)</p><br />
									<input type="text" name="secondary_outcome_kr" id="secondary_outcome_kr_<c:out value="<%=i %>" />" title="보조결과 변수 <c:out value="<%=i %>" /> 평가항목 국문" value="<%out.print(o_outcome_kr); %>"  maxlength="2000" maxByte="2000" onKeyDown="byteCheck(this.id,2000);" onKeyUp="byteCheck(this.id,2000);" onChange="byteCheck(this.id,2000);" style="ime-mode:active;width:100%;" />
									<% if(!outcomsVo.getInputbox("outcome_kr").equals("")){%><script type="text/javascript">byteCheck("secondary_outcome_kr_<c:out value="<%=i %>" />",2000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc" scope="row"><label for="secondary_outcome_en_<c:out value="<%=i %>" />" class="magset2">영문<br />(ENG)</label></th>
							<td>
								<div class="resch_inset">
									<p>(<span id="byte_secondary_outcome_en_<c:out value="<%=i %>" />">0</span>&#47;2000Byte)</p><br />
									<input type="text" name="secondary_outcome_en" id="secondary_outcome_en_<c:out value="<%=i %>" />" title="보조결과 변수 <c:out value="<%=i %>" /> 평가항목 영문" value="<%out.print(o_outcome_en); %>" maxlength="2000" maxByte="2000" onKeyDown="byteCheck(this.id,2000);" onKeyUp="byteCheck(this.id,2000);" onChange="byteCheck(this.id,2000);" style="ime-mode:disabled;width:100%;" />
									<% if(!outcomsVo.getInputbox("outcome_en").equals("")){%><script type="text/javascript">byteCheck("secondary_outcome_en_<c:out value="<%=i %>" />",2000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th rowspan="2" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />평가시기<br />(Timepoint)</th>
							<th class="textc borderset" scope="row"><label for="secondary_timepoint_kr_<c:out value="<%=i %>" />" class="magset2">국문<br />(KOR)</label></th>
							<td class="borderset">
								<div class="resch_inset">
									<p>(<span id="byte_secondary_timepoint_kr_<c:out value="<%=i %>" />">0</span>&#47;2000Byte)</p>
									<input type="text" name="secondary_timepoint_kr" id="secondary_timepoint_kr_<c:out value="<%=i %>" />" title="보조결과 변수 <c:out value="<%=i %>" /> 평가시기 국문" value="<%out.print(o_timepoint_kr); %>" maxlength="2000" maxByte="2000" onKeyDown="byteCheck(this.id,2000);" onKeyUp="byteCheck(this.id,2000);" onChange="byteCheck(this.id,2000);" style="ime-mode:active;width:100%;" />
									<% if(!outcomsVo.getInputbox("timepoint_kr").equals("")){%><script type="text/javascript">byteCheck("secondary_timepoint_kr_<c:out value="<%=i %>" />",2000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc" scope="row"><label for="secondary_timepoint_en_<c:out value="<%=i %>" />" class="magset2">영문<br />(ENG)</label></th>
							<td>
								<div class="resch_inset">
									<p>(<span id="byte_secondary_timepoint_en_<c:out value="<%=i %>" />">0</span>&#47;2000Byte)</p>
									<input type="text" name="secondary_timepoint_en" id="secondary_timepoint_en_<c:out value="<%=i %>" />" title="보조결과 변수 <c:out value="<%=i %>" /> 평가시기 영문" value="<%out.print(o_timepoint_en); %>" maxlength="2000" maxByte="2000" onKeyDown="byteCheck(this.id,2000);" onKeyUp="byteCheck(this.id,2000);" onChange="byteCheck(this.id,2000);" style="ime-mode:disabled;width:100%;" />
									<% if(!outcomsVo.getInputbox("timepoint_en").equals("")){%><script type="text/javascript">byteCheck("secondary_timepoint_en_<c:out value="<%=i %>" />",2000);</script><%}%>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			<% } %>
				
				</form>
				<ul class="research_noice">
					<li class="font_red"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />WHO ICTRP (International Clinical Trial Registry Platform)에서 요구하는 필수등록항목입니다.</li>
					<li class="font_blue"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />CRIS 필수등록항목입니다.</li>
				</ul>
			</div>
			
			<div class="res_btnbox">
				<ul class="research_btn">
					<li><a href="#preview" title="(새창으로 이동)" onclick="preView(10);" ><img src="../images/resch/btn_preview.gif" alt="미리보기" /></a></li>
					<% if(sVO.equals("mod", "")){ %>
						<li><a href="./step9.jsp?seq=<c:out value="<%=s_seq%>" />"><img src="../images/resch/btn_prevstep.gif" alt="이전 단계로" /></a></li>
					<% } %>					
					<li><a href="#removeAll" onclick="Remove(10);" ><img src="../images/resch/btn_allcancel.gif" alt="모두 지우기" /></a></li>
					<li><a href="#tempSave" onclick="TempSave(10);" ><img src="../images/resch/btn_storage.gif" alt="임시저장" /></a></li>
				<% if(sVO.equals("mod", "")){ %>
					<li><a href="#save" onclick="Save(10);" ><img src="../images/resch/btn_nextstep2.gif" alt="다음 단계로" /></a></li>
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