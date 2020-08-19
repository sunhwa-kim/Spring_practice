<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.buildnine.util.VOSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>연구현황 | 임상연구등록</title>
	<%@include file="../include/title.jsp" %>
	<%@include file="../include/write_session.jsp" %>

	<script type="text/javascript" src="../js/common.js"></script>
	<script type="text/javascript" src="../js/write.js"></script>
	<script type="text/javascript" src="../js/byteCheck.js"></script>
		
	<script type="text/javascript">
	$(document).ready(function (){	
		lf_enrol_check();	
		
		if($("input:radio[name=research_agency_count]:checked").val()=="1") {
			lf_cal_add($(".datepicker"));	
		} else {
			lf_cal_add($(".datepicker"));	
			lf_cal_add($(".rdatepicker"));
		}

		$(".datepicker, .rdatepicker").on('keyup', function(){
			fn_calInput();
		});
	});
	
	function fn_firstset(){
		if($("input:radio[name=research_agency_count]:checked").val()=="1")
		{
			$(".xdatepicker").datepicker("destroy");
			$(".xdatepicker").attr('readonly',true);
			$(".rdatepicker").datepicker("destroy");
			$(".rdatepicker").attr('readonly',true);
		}
		else if($("input:radio[name=research_agency_count]:checked").val()=="-1")
		{
			lf_cal_add($(".xdatepicker"));
			$(".xdatepicker").attr('readonly',false);
			lf_cal_add($(".rdatepicker"));
			$(".rdatepicker").attr('readonly',false);
		}
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
		$(".cal").click(function(){
			$(this).parent().find(".rdatepicker").focus();
		});
	}
	
	function lf_enrol_check()
	{
		if(($("#status").val()=='5' || $("#status").val()=='6'))
		{
			//전체연구모집현황
			if($("input:radio[name=study_start_date_gubun]:checked").val()=="실제등록(Actual)")
			{
				//GST_kdh_20160830 첫 연구대상자 등록일자 실제등록 후에도 날짜 수정 가능하도록 요청
				//$("#study_start_date").attr("class","xdatepicker");
				//$("#study_start_date").attr('readonly',true);
				$("#study_start_date_gubun1_la").parent().find(':radio').first().hide();
				$("#study_start_date_gubun1_la").hide();
				//$("#cal_study_start_date").hide();
			}
			//참여기관 모집현황
			var ag_cnt = $("#research_agency_cnt").val();
			for(var i=1; i<=ag_cnt; i++)
			{
				if($("input:radio[name=research_"+i+"_study_start_date_gubun]:checked").val()=="실제등록(Actual)")
				{
					//GST_kdh_20160830 첫 연구대상자 등록일자 실제등록 후에도 날짜 수정 가능하도록 요청
					//$("#research_"+i+"_study_start_date").attr("class","xdatepicker");
					//$("#research_"+i+"_study_start_date").attr('readonly',true);
					$("#research_"+i+"_study_start_date_gubun1_la").parent().find(':radio').first().hide();
					$("#research_"+i+"_study_start_date_gubun1_la").hide();
					//$("#study_"+i+"_start_cal_btn").hide();					
				}
			}
		}
	}	
	
		function jsMulti(str,idx)
		{
			cnt = document.form.research_agency_cnt.value;

			if(str == "add")
			{
				sum = eval(cnt) + eval("1");
				for( var i = eval(idx)+eval("1"); i <= 100; i++) {
					if(document.getElementById("research_agency_div_"+i).style.display == "none")
					{
						document.getElementById("research_agency_div_"+i).style.display = "";
						document.getElementById("research_"+eval(i)+"_stop_reason").readOnly = true;
						document.getElementById("research_"+eval(i)+"_stop_reason").style.background = "#EFEFEF";
						document.getElementById("research_"+eval(i)+"_stop_reason").style.border = "1px solid #9999cc";	
						
						document.getElementById("research_"+eval(i)+"_stop_reason_en").readOnly = true;
						document.getElementById("research_"+eval(i)+"_stop_reason_en").style.background = "#EFEFEF";
						document.getElementById("research_"+eval(i)+"_stop_reason_en").style.border = "1px solid #9999cc";

						$("#research_"+eval(i)+"_study_start_date").attr("class","datepicker");
						$("#research_"+eval(i)+"_study_start_date_gubun1_la").parent().find(':radio').first().show();
						$("#research_"+eval(i)+"_study_start_date_gubun1_la").show();
						$("#study_"+eval(i)+"_start_cal_btn").show();		
						
						lf_cal_add($(".datepicker"));

						break;
					}
				}				
			}
			else
			{
				if(cnt==1)
				{
					alert("하나이상의 연구진행현황이 필요합니다.");
					return;
					//sum = eval(cnt);
				}
				else
				{
					
					sum = eval(cnt) - eval("1");
					document.getElementById("research_"+eval(idx)+"_agency_name_kr").value='';
					document.getElementById("research_"+eval(idx)+"_agency_name_en").value='';
					document.getElementById("research_"+eval(idx)+"_study_start_date").value='';
					document.getElementById("research_"+eval(idx)+"_stop_reason").value='';
					document.getElementById("research_"+eval(idx)+"_stop_reason_en").value='';
	
					fRadioInit("research_"+eval(idx)+"_step");
					fRadioInit("research_"+eval(idx)+"_study_start_date_gubun");

					$("#research_agency_div_"+eval(idx)).hide();
				}
			}
			document.form.research_agency_cnt.value = sum;
			
			step4_research_agency_count();
		}
	
		function fRadioInit(tname)
		{
			var targetList = document.getElementsByName(tname);
			
			if(targetList!=null){
				for(i=0; i<targetList.length; i++ )
				{
					targetList[i].checked = false;
				}
			}
		}
		
		function fn_agSearch( pre ){
			var AgSearch = window.open("../pop/ag_search.jsp?apre="+pre, "AgSearch", "width=550px, height=535px, left=200px, top=100px");
			AgSearch.focus();
		}
		
		function singleRec()
		{
			if(document.getElementById("research_agency_count_1").checked==true)
			{
				document.getElementById("research_1_stop_reason").value = document.getElementById("research_stop_reason").value;
				document.getElementById("research_1_stop_reason_en").value = document.getElementById("research_stop_reason_en").value;
				document.getElementById("research_1_study_start_date").value = document.getElementById("study_start_date").value;
			}
		}
		
		function fn_enregway()
		{
			var enRegistWay = window.open("../pop/ag_enregway.jsp", "enRegistWay", "width=570px, height=300px, left=250px, top=150px");
			enRegistWay.focus();
		}
	</script>
</head>
<body onload="RemoveForm(4);">
<%

	ValueObject sVO = new ValueObject();
	ValueObject vo = new ValueObject();
	String temp = "";
	VOSet agencyList = new VOSet();
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
			vo = QueryAction.getQueryView("CRIS_DATA.step4", sVO);

			sVO.put("gubun", "RESEARCH");
			agencyList = QueryAction.getQueryList("CRIS_DATA.agency_list", sVO);
		}

		//VOSet nationList = QueryAction.getQueryList("CODE.nation_list2", sVO);
		
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
		String todate = fm.format(new java.util.Date());

		String s_seq = sVO.get("seq");
		String v_seq = vo.getInputbox("seq");
		String v_status = vo.getInputbox("status");
		String v_seq_group = vo.getInputbox("seq_group");
		String v_mod = sVO.get("mod");
		int agency_size = agencyList.size()==0?1:agencyList.size();
		String v_irb_date = vo.getInputbox("irb_date");
		String research_title_kr = StringUtil.getTitleLimit(vo.getInputbox("research_title_kr"),83);
		String v_research_agency_count_1 = vo.getInputbox("research_agency_count").equals("1")?"checked":"";
		String v_research_agency_count_2 = ( StringUtil.toInt(StringUtil.nvl(vo.get("research_agency_count"), "1"), 1) < 1)?"checked":"";
		String v_research_nation_y = vo.getInputbox("research_nation").equals("Y")?"checked":"";
		String v_research_nation_n = vo.getInputbox("research_nation").equals("N")?"checked":"";
		String v_research_step_1 = vo.getInputbox("research_step").equals("대상자 모집 전(Not yet recruiting)")?"checked":""; 
		String v_research_step_2 = vo.getInputbox("research_step").equals("모집 중(Recruiting)")?"checked":"";
		String v_research_step_3 = vo.getInputbox("research_step").equals("모집추가없이 진행중(Active, not recruiting)")?"checked":"";
		String v_research_step_4 = vo.getInputbox("research_step").equals("일시중지(Suspended)")?"checked":"";
		String v_research_step_5 = vo.getInputbox("research_step").equals("모집중단(Terminated)")?"checked":"";
		String v_research_step_6 = vo.getInputbox("research_step").equals("연구종결(Completed)")?"checked":"";
		String v_research_step_7 = vo.getInputbox("research_step").equals("연구철회(Withdrawn)")?"checked":"";
		String v_research_stop_reason = vo.getInputbox("research_stop_reason");
		String v_research_stop_reason_en = vo.getInputbox("research_stop_reason_en");
		String v_study_start_date = vo.getInputbox("study_start_date");
		String v_study_start_date_gubun_1 = vo.get("study_start_date_gubun").indexOf("예정")>-1?"checked":"";
		String v_study_start_date_gubun_2 = vo.get("study_start_date_gubun").indexOf("실제등록")>-1?"checked":"";
		String v_enrollment = vo.getInputbox("enrollment");
		String v_primary_complete_date = vo.getInputbox("primary_complete_date");
		String v_primary_complete_gubun_1 = vo.get("primary_complete_gubun").indexOf("예정")>-1?"checked":"";
		String v_primary_complete_gubun_2 = vo.get("primary_complete_gubun").indexOf("실제등록")>-1?"checked":"";
		String v_study_complete_date = vo.getInputbox("study_complete_date");
		String v_study_complete_gubun_1 = vo.get("study_complete_gubun").indexOf("예정")>-1?"checked":"";
		String v_study_complete_gubun_2 = vo.get("study_complete_gubun").indexOf("실제등록")>-1?"checked":"";
		
		
		
		//dddddddddddddddddddddddd
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
				<h3><img src="../images/resch/tit2014_wstep04.gif" alt="4. 연구현황 (Study Status)" /></h3>
			</div>
			
			<div class="research_tb">
				<div class="reshtb_tit">
				<br />
					<h4>전체연구모집현황(Overall Recruitment Status)</h4>
				</div>

				<iframe name="iframe" title="의미없는 아이프레임" style="display:none;" width="0" height="0"></iframe>
				<form name="form" id="form" method="post" >
				<input type="hidden" name="seq" 	id="seq" 	value="<c:out value="<%=v_seq%>" />" />
				<input type="hidden" name="status" 	id="status" value="<c:out value="<%=v_status%>" />" />
				<input type="hidden" name="seq_group"	id="seq_group" 	value="<c:out value="<%=v_seq_group%>" />" />
				<input type="hidden" name="mode" 	id="mode" 	value="" />
				<input type="hidden" name="mod" id="mod" value="<c:out value="<%=v_mod%>" />" />
				<input type="hidden" name="research_agency_cnt" id="research_agency_cnt" value="<c:out value="<%=agency_size%>" />" />
				<input type="hidden" name="step" id="step" />
				<input type="hidden" name="irb_date" id="irb_date" value="<c:out value="<%=v_irb_date%>" />" />
				<input type="hidden" name="to_date" id="to_date" value="<c:out value="<%=todate%>" />" />
				<table cellspacing="0" cellpadding="0" border="0" summary="연구참여기관, 전체연구모집현황, 첫 연구대상자 등록일자, 목표대상자수, 자료수집종료일, 연구종료일로 구성된 전체연구모집현황 입력테이블입니다.">
					<caption>전체연구모집현황 정보 입력</caption>
					<colgroup>
						<col width="250px" /><col width="130px" /><col width="60px" /><col width="*" />
					</colgroup>
					<tbody>

						<tr>
							<th rowspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />연구참여기관
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(4,1);"><img src="../images/resch/icon2014_help.png" alt="연구참여기관 설명" class="img_set" /></a><br />
							(Study Site)</th>
							<td colspan="3" class="borderset">
								<input type="radio" name="research_agency_count" id="research_agency_count_1" value="1" <c:out value="<%=v_research_agency_count_1%>" />  onclick="step4_research_agency_count();fn_firstset();" /><label for="research_agency_count_1">단일(Single)</label>
								<input type="radio" name="research_agency_count" id="research_agency_count_2" value="-1" <c:out value="<%=v_research_agency_count_2%>" /> onclick="step4_research_agency_count();fn_firstset();" /><label for="research_agency_count_2">다기관(Multi-center)</label>	
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<span id="id_research_nation">다국가(Multinational) - 
									<input type="radio" name="research_nation" id="research_nation_1" value="Y" <c:out value="<%=v_research_nation_y%>" />  /><label for="research_nation_1">예(Yes)</label>
									<input type="radio" name="research_nation" id="research_nation_2" value="N" <c:out value="<%=v_research_nation_n%>" />  /><label for="research_nation_2">아니오(No)</label>
								</span>
							</td>
						</tr>
						
						<tr>
							<th rowspan="3" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />전체연구모집현황
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(4,2);"><img src="../images/resch/icon2014_help.png" alt="전체연구모집현황 설명" class="img_set" /></a><br />
							(Overall Recruitment Status)</th>
							<td colspan="3">
								<input type="radio" name="research_step" id="research_step_1" onclick="step4_research_step();" <c:out value="<%=v_research_step_1%>" /> value="대상자 모집 전(Not yet recruiting)" /><label for="research_step_1">대상자 모집 전(Not yet recruiting)</label>
								<input type="radio" name="research_step" id="research_step_2" onclick="step4_research_step();" <c:out value="<%=v_research_step_2%>" /> value="모집 중(Recruiting)" /><label for="research_step_2">모집 중(Recruiting)</label>
								<input type="radio" name="research_step" id="research_step_7" onclick="step4_research_step();" <c:out value="<%=v_research_step_3%>" /> value="모집추가없이 진행중(Active, not recruiting)" /><label for="research_step_7">모집추가없이 진행중(Active, not recruiting)</label><br />
								<input type="radio" name="research_step" id="research_step_3" onclick="step4_research_step();" <c:out value="<%=v_research_step_4%>" /> value="일시중지(Suspended)" /><label for="research_step_3">일시중지(Suspended)</label>
								<input type="radio" name="research_step" id="research_step_6" onclick="step4_research_step();" <c:out value="<%=v_research_step_5%>" /> value="모집중단(Terminated)" /><label for="research_step_6">모집중단(Terminated)</label>
								<input type="radio" name="research_step" id="research_step_4" onclick="step4_research_step();" <c:out value="<%=v_research_step_6%>" /> value="연구종결(Completed)" /><label for="research_step_4">연구종결(Completed)</label>
								<input type="radio" name="research_step" id="research_step_5" onclick="step4_research_step();" <c:out value="<%=v_research_step_7%>" /> value="연구철회(Withdrawn)" /><label for="research_step_5">연구철회(Withdrawn)</label>
							</td>
						</tr>
						<tr>
							<td rowspan="2" class="textc borderset01">일시중지 모집중단<br />연구철회 사유<br />(Stop Reason)</td>
							<td class="textc borderset borderset01"><label for="research_stop_reason" class="magset2">국문<br />(KOR)</label></td>
							<td class="borderset">
								<div class="resch_inset">
									<p>(<span id="byte_research_stop_reason">0</span>/2000Byte)</p>
									<div class="spset01">
										<input type="text" name="research_stop_reason" id="research_stop_reason" title="전체연구모집현황 일시중지 모집중단 연구철회 사유 국문" value="<%out.print(v_research_stop_reason);%>"maxlength="2000" maxByte="2000" onKeyDown="byteCheck(this.id,2000);" onKeyUp="byteCheck(this.id,2000);" onChange="byteCheck(this.id,2000);" style="ime-mode:active;width:100%;" />
										<% if(!vo.getInputbox("research_stop_reason").equals("")){%><script type="text/javascript">byteCheck("research_stop_reason",2000);</script><%}%>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td class="textc borderset01"><label for="research_stop_reason_en" class="magset2">영문<br />(ENG)</label></td>
							<td>
								<div class="resch_inset">
									<p>(<span id="byte_research_stop_reason_en">0</span>/2000Byte)</p>
									<div class="spset01">
										<input type="text" name="research_stop_reason_en" id="research_stop_reason_en" title="전체연구모집현황 일시중지 모집중단 연구철회 사유 영문" value="<%out.print(v_research_stop_reason_en); %>" maxlength="2000" maxByte="2000" onKeyDown="byteCheck(this.id,2000);" onKeyUp="byteCheck(this.id,2000);" onChange="byteCheck(this.id,2000);" style="ime-mode:disabled;width:100%;" />
										<% if(!vo.getInputbox("research_stop_reason_en").equals("")){%><script type="text/javascript">byteCheck("research_stop_reason_en",2000);</script><%}%>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><img id="ssd_req" src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" /><label for="study_start_date">첫 연구대상자 등록일/등록여부</label>
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(4,3);"><img src="../images/resch/icon2014_help.png" alt="첫 연구대상자 등록일자 설명" class="img_set" /></a><br />
							(Date&Status of First Enrollment)</th>
							<td colspan="3">'예정(Anticipated)' 선택 시 첫 연구대상자 등록 후 반드시 수정해 주십시오.<br />
							<%if(!vo.getInputbox("irb_date").trim().equals("")) {%>
							승인날짜 : <c:out value="<%=v_irb_date%>" escapeXml="false" /> (첫 연구대상자 등록일자는 임상연구윤리심의의 승인날짜 보다 빠를 수 없음)<br />
							<%} %>
							<input type="text" class="datepicker" name="study_start_date" id="study_start_date" value="<%out.print(v_study_start_date); %>" maxlength="10" style="width:75px;" />
							<img id="cal_study_start_date" src="../images/resch/btn2014_calendar.png" alt="첫 연구대상자 등록일자 달력버튼" class="cal" />
							<input type="radio" name="study_start_date_gubun" id="study_start_date_gubun1" onclick="step4_study_start();" value="예정(Anticipated)" <c:out value="<%=v_study_start_date_gubun_1 %>" /> class="magset" /><label for="study_start_date_gubun1" id="study_start_date_gubun1_la">예정(Anticipated)</label>
							<input type="radio" name="study_start_date_gubun" id="study_start_date_gubun2" onclick="step4_study_start();" value="실제등록(Actual)" <c:out value="<%=v_study_start_date_gubun_2 %>" /> /><label for="study_start_date_gubun2">실제등록(Actual)</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" /><label for="enrollment">목표대상자수</label>
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(4,4);"><img src="../images/resch/icon2014_help.png" alt="목표대상자수 설명" class="img_set" /></a><br />
							(Target Number of Participant)</th>
							<td colspan="3"><input type="number" name="enrollment" id="enrollment" onkeypress="javascript:onlyNumber()" value="<%out.print(v_enrollment); %>" maxlength="6" oninput="fn_maxlchk(this)" style="ime-mode:disabled;width:60px;" /> 명</td>
						</tr>
						<tr>
							<th scope="row"><label for="primary_complete_date">자료수집종료일</label>
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(4,5);"><img src="../images/resch/icon2014_help.png" alt="자료수집종료일 설명" class="img_set" /></a><br />
							(Primary Completion Date)</th>
							<td colspan="3">주요결과변수(primary outcome) 측정을 위해 마지막 연구대상자의 중재 및 검사가 시행된 일자<br />
							<input type="text" class="datepicker" name="primary_complete_date" id="primary_complete_date" value="<%out.print(v_primary_complete_date); %>" maxlength="10" style="width:75px;" />
							<img src="../images/resch/btn2014_calendar.png" alt="자료수집종료일 달력버튼" class="cal"  />
							<input type="radio" name="primary_complete_gubun" id="primary_complete_gubun1" value="예정(Anticipated)" <c:out value="<%=v_primary_complete_gubun_1 %>" /> class="magset" /><label for="primary_complete_gubun1">예정(Anticipated)</label>
							<input type="radio" name="primary_complete_gubun" id="primary_complete_gubun2" value="실제등록(Actual)" <c:out value="<%=v_primary_complete_gubun_2 %>" /> /><label for="primary_complete_gubun2">실제등록(Actual)</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="study_complete_date">연구종료일</label>
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(4,6);"><img src="../images/resch/icon2014_help.png" alt="연구종료일 설명" class="img_set" /></a><br />
							(Study Completion Date)</th>
							<td colspan="3">해당연구의 최종적인 자료수집이 완료된 일자<br />
							<input type="text" class="datepicker"name="study_complete_date" id="study_complete_date" value="<%out.print(v_study_complete_date); %>" maxlength="10" style="width:75px;" />
							<img src="../images/resch/btn2014_calendar.png" alt="연구종료일 달력버튼" class="cal" />
							<input type="radio" name="study_complete_gubun" id="study_complete_gubun1" value="예정(Anticipated)" <c:out value="<%=v_study_complete_gubun_1 %>" /> class="magset" /><label for="study_complete_gubun1">예정(Anticipated)</label>
							<input type="radio" name="study_complete_gubun" id="study_complete_gubun2" value="실제등록(Actual)" <c:out value="<%=v_study_complete_gubun_2 %>" /> /><label for="study_complete_gubun2">실제등록(Actual)</label>
							</td>
						</tr>
					</tbody>
				</table>
				
			<%
			ValueObject agencyVo = null;
			for( int i = 1; i <= 100; i++){

				if( agencyList.size() >= i ){
					agencyVo = agencyList.get(i-1);
				} else {
					agencyVo = new ValueObject();
				}

				if( !agencyVo.equals("email_domain", "") && strEmail.indexOf(agencyVo.get("email_domain")) == -1 ){
					agencyVo.put("emailDomain", "-");
				}
				String ageny_style_1 = i<=agencyList.size()?"display:;":"display:none;";
				String a_name_kr = agencyVo.getInputbox("name_kr");
				String a_name_en = agencyVo.getInputbox("name_en");
				String ageny_style_2 = !agencyVo.getInputbox("name_kr").trim().equals("")&&agencyVo.getInputbox("name_en").trim().equals("")?"style=\"display:;\"":"style=\"display:none;\"";
				String a_stop_reason = agencyVo.getInputbox("stop_reason");
				String a_stop_reason_en = agencyVo.getInputbox("stop_reason_en");
				String a_study_start_date = agencyVo.getInputbox("study_start_date");
				String a_study_start_date_gubun_1 = agencyVo.get("study_start_date_gubun").indexOf("예정")>-1?"checked":"";
				String a_study_start_date_gubun_2 = agencyVo.get("study_start_date_gubun").indexOf("실제등록")>-1?"checked":"";
				String a_step_1 = agencyVo.getInputbox("step").equals("대상자 모집 전(Not yet recruiting)")?"checked":"";
				String a_step_2 = agencyVo.getInputbox("step").equals("모집 중(Recruiting)")?"checked":"";
				String a_step_3 = agencyVo.getInputbox("step").equals("모집추가없이 진행중(Active, not recruiting)")?"checked":"";
				String a_step_4 = agencyVo.getInputbox("step").equals("일시중지(Suspended)")?"checked":"";
				String a_step_5 = agencyVo.getInputbox("step").equals("모집중단(Terminated)")?"checked":"";
				String a_step_6 = agencyVo.getInputbox("step").equals("연구종결(Completed)")?"checked":"";
				String a_step_7 = agencyVo.getInputbox("step").equals("연구철회(Withdrawn)")?"checked":"";
			%>		
				<div id="research_agency_div_<c:out value="<%=i%>" />" style="<c:out value="<%=ageny_style_1 %>" />">		
					<div class="reshtb_tit margintop15">
						<h4>참여기관별 연구모집현황 (Recruitment Status by Participating Study Site) <c:out value="<%=i%>" /></h4>
						<ul id="btnView_<c:out value="<%=i%>" />" class="btnbox marginbtm15">
							<li><a href="#add" onclick="jsMulti('add','<c:out value="<%=i%>" />')" ><img src="../images/resch/btn2014_add.png" alt="추가" /></a></li>
							<%if(i!=1){%><li><a href="#minus" onclick="jsMulti('del','<c:out value="<%=i%>" />')" ><img src="../images/resch/btn2014_del.png" alt="삭제" /></a></li><%}%>
						</ul>
					</div>
					<table cellspacing="0" cellpadding="0" border="0" summary="기관명, 연구모집현황, 첫 연구대상자 등록일자로 구성된 참여기관별 연구진행현황 정보 입력테이블입니다.">
						<caption>참여기관별 연구진행현황 정보 입력</caption>
						<colgroup>
							<col width="180px" /><col width="70px" /><col width="130px" /><col width="60px" /><col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th rowspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />기관명
								<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(4,7);"><img src="../images/resch/icon2014_help.png" alt="참여기관명 설명" class="img_set" /></a><br />
								(Name of Study Site)</th>
								<th class="textc borderset" scope="row"><label for="research_<c:out value="<%=i%>" />_agency_name_kr">국문<br />(KOR)</label></th>
								<td colspan="3" class="borderset">
									<div class="resch_inset">
										<input type="text" name="research_agency_name_kr" id="research_<c:out value="<%=i%>" />_agency_name_kr" title="참여기관 <c:out value="<%=i%>" /> 기관명 국문" value="<%out.print(a_name_kr); %>" readonly style="background:#EFEFEF;ime-mode:active;width:580px;" />
										<a href="#agsearch" onclick="fn_agSearch('research_<c:out value="<%=i%>" />_');" ><img src="../images/resch/btn2014_organsearch.png" alt="기관명검색" class="inpimg" /></a>
									</div>
								</td>
							</tr>
							<tr>
								<th class="textc" scope="row"><label for="research_<c:out value="<%=i%>" />_agency_name_en">영문<br />(ENG)</label></th>
								<td colspan="3">
									<div class="resch_inset">
										<input type="text" name="research_agency_name_en" id="research_<c:out value="<%=i%>" />_agency_name_en" title="참여기관 <c:out value="<%=i%>" /> 기관명 영문" value="<%out.print(a_name_en); %>" readonly style="background:#EFEFEF;ime-mode:disabled;width:580px;" />
										<a href="#agenregway" onclick="fn_enregway();" ><img id="research_<c:out value="<%=i%>" />_way" src="../images/resch/btn2014_orgen.png" alt="영문명 등록안내" class="inpimg" <c:out value="<%=ageny_style_2 %>" /> /></a>
									</div>
								</td>
							</tr>
							<tr>
								<th colspan="2" rowspan="3" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />연구모집현황
								<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(4,8);"><img src="../images/resch/icon2014_help.png" alt="연구모집현황 설명" class="img_set" /></a><br />
								(Recruitment Status)</th>
								<td colspan="3">
									<input type="radio" name="research_<c:out value="<%=i%>" />_step" id="research_<c:out value="<%=i%>" />_step_1" onclick="step4_research_x_step(<c:out value="<%=i%>" />);<%=i==1?"step4_single_research();":""%>" <c:out value="<%=a_step_1%>" /> value="대상자 모집 전(Not yet recruiting)" /><label for="research_<c:out value="<%=i%>" />_step_1">대상자 모집 전(Not yet recruiting)</label>
									<input type="radio" name="research_<c:out value="<%=i%>" />_step" id="research_<c:out value="<%=i%>" />_step_2" onclick="step4_research_x_step(<c:out value="<%=i%>" />);<%=i==1?"step4_single_research();":""%>" <c:out value="<%=a_step_2%>" /> value="모집 중(Recruiting)" /><label for="research_<c:out value="<%=i%>" />_step_2">모집 중(Recruiting)</label>
									<input type="radio" name="research_<c:out value="<%=i%>" />_step" id="research_<c:out value="<%=i%>" />_step_7" onclick="step4_research_x_step(<c:out value="<%=i%>" />);<%=i==1?"step4_single_research();":""%>" <c:out value="<%=a_step_3%>" /> value="모집추가없이 진행중(Active, not recruiting)" /><label for="research_<c:out value="<%=i%>" />_step_7">모집추가없이 진행중(Active, not recruiting)</label><br />
									<input type="radio" name="research_<c:out value="<%=i%>" />_step" id="research_<c:out value="<%=i%>" />_step_3" onclick="step4_research_x_step(<c:out value="<%=i%>" />);<%=i==1?"step4_single_research();":""%>" <c:out value="<%=a_step_4%>" /> value="일시중지(Suspended)" /><label for="research_<c:out value="<%=i%>" />_step_3">일시중지(Suspended)</label>
									<input type="radio" name="research_<c:out value="<%=i%>" />_step" id="research_<c:out value="<%=i%>" />_step_6" onclick="step4_research_x_step(<c:out value="<%=i%>" />);<%=i==1?"step4_single_research();":""%>" <c:out value="<%=a_step_5%>" /> value="모집중단(Terminated)" /><label for="research_<c:out value="<%=i%>" />_step_6">모집중단(Terminated)</label>
									<input type="radio" name="research_<c:out value="<%=i%>" />_step" id="research_<c:out value="<%=i%>" />_step_4" onclick="step4_research_x_step(<c:out value="<%=i%>" />);<%=i==1?"step4_single_research();":""%>" <c:out value="<%=a_step_6%>" /> value="연구종결(Completed)" /><label for="research_<c:out value="<%=i%>" />_step_4">연구종결(Completed)</label>
									<input type="radio" name="research_<c:out value="<%=i%>" />_step" id="research_<c:out value="<%=i%>" />_step_5" onclick="step4_research_x_step(<c:out value="<%=i%>" />);<%=i==1?"step4_single_research();":""%>" <c:out value="<%=a_step_7%>" /> value="연구철회(Withdrawn)" /><label for="research_<c:out value="<%=i%>" />_step_5">연구철회(Withdrawn)</label>		
								</td>
							</tr>
							<tr>
								<td rowspan="2" class="textc borderset01">일시중지 모집중단<br />연구철회 사유<br />(Stop Reason)</td>
								<td class="textc borderset borderset01"><label for="research_<c:out value="<%=i%>" />_stop_reason" class="magset2">국문<br />(KOR)</label></td>
								<td class="borderset">
									<div class="resch_inset">
										<p>(<span id="byte_research_<c:out value="<%=i%>" />_stop_reason">0</span>/2000Byte)</p>
										<div class="spset01">
											<input type="text" name="research_<c:out value="<%=i%>" />_stop_reason" id="research_<c:out value="<%=i%>" />_stop_reason" title="참여기관 <c:out value="<%=i%>" /> 연구모집현황 일시중지 모집중단 연구철회 사유 국문" value="<%out.print(a_stop_reason); %>" maxlength="2000" maxByte="2000" onKeyDown="byteCheck(this.id,2000);" onKeyUp="byteCheck(this.id,2000);" onChange="byteCheck(this.id,2000);" style="ime-mode:active;width:100%;" />
											<% if(!agencyVo.getInputbox("stop_reason").equals("")){%><script type="text/javascript">byteCheck("research_stop_reason",2000);</script><%}%>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td class="textc borderset01"><label for="research_<c:out value="<%=i%>" />_stop_reason_en" class="magset2">영문<br />(ENG)</label></td>
								<td>
									<div class="resch_inset">
										<p>(<span id="byte_research_<c:out value="<%=i%>" />_stop_reason_en">0</span>/2000Byte)</p>
										<div class="spset01">
											<input type="text" name="research_<c:out value="<%=i%>" />_stop_reason_en" id="research_<c:out value="<%=i%>" />_stop_reason_en" title="참여기관 <c:out value="<%=i%>" /> 연구모집현황 일시중지 모집중단 연구철회 사유 영문" value="<%out.print(a_stop_reason_en); %>" maxlength="2000" maxByte="2000" onKeyDown="byteCheck(this.id,2000);" onKeyUp="byteCheck(this.id,2000);" onChange="byteCheck(this.id,2000);" style="ime-mode:disabled;width:100%;" />
											<% if(!agencyVo.getInputbox("stop_reason_en").equals("")){%><script type="text/javascript">byteCheck("research_stop_reason_en",2000);</script><%}%>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<th colspan="2" scope="row"><img id="ssd_req_<c:out value="<%=i%>" />" src="../images/resch/icon2014_cris.png" alt="cris 필수항목" /><label for="research_<c:out value="<%=i%>" />_study_start_date">첫 연구대상자 등록일/등록여부</label>
								<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(4,9);"><img src="../images/resch/icon2014_help.png" alt="첫 연구대상자 등록일자 설명" class="img_set" /></a><br />
								(Date&Status of First Enrollment)</th>
								<td colspan="3">
									<input type="text" class="rdatepicker" name="research_<c:out value="<%=i%>" />_study_start_date" id="research_<c:out value="<%=i%>" />_study_start_date" value="<%out.print(a_study_start_date); %>" maxlength="10" style="width:75px;" />
									<img id="study_<c:out value="<%=i%>" />_start_cal_btn" src="../images/resch/btn2014_calendar.png" alt="첫 연구대상자 등록일자 달력버튼" class="cal" />
									<input type="radio" name="research_<c:out value="<%=i%>" />_study_start_date_gubun" id="research_<c:out value="<%=i%>" />_study_start_date_gubun1" onclick="javascript:step4_single_study_start();" value="예정(Anticipated)" <c:out value="<%=a_study_start_date_gubun_1 %>" /> class="magset" /><label for="research_<c:out value="<%=i%>" />_study_start_date_gubun1" id="research_<c:out value="<%=i%>" />_study_start_date_gubun1_la">예정(Anticipated)</label>
									<input type="radio" name="research_<c:out value="<%=i%>" />_study_start_date_gubun" id="research_<c:out value="<%=i%>" />_study_start_date_gubun2" onclick="javascript:step4_single_study_start();" value="실제등록(Actual)" <c:out value="<%=a_study_start_date_gubun_2 %>" /> /><label for="research_<c:out value="<%=i%>" />_study_start_date_gubun2">실제등록(Actual)</label>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<% } %>
				
				</form>
				<ul class="research_noice">
					<li class="font_red"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />WHO ICTRP (International Clinical Trial Registry Platform)에서 요구하는 필수등록항목입니다.</li>
					<li class="font_blue"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />CRIS 필수등록항목입니다.</li>
				</ul>
			</div>
			
			<div class="res_btnbox">
				<ul class="research_btn">
					<li><a href="#preview" title="(새창으로 이동)" onclick="preView(4);" ><img src="../images/resch/btn_preview.gif" alt="미리보기" /></a></li>
					<% if(sVO.equals("mod", "")){ %>
						<li><a href="./step3.jsp?seq=<c:out value="<%=s_seq%>" />"><img src="../images/resch/btn_prevstep.gif" alt="이전 단계로" /></a></li>
					<% } %>					
					<li><a href="#removeAll" onclick="Remove(4);" ><img src="../images/resch/btn_allcancel.gif" alt="모두 지우기" /></a></li>
					<li><a href="#tempSave" onclick="TempSave(4);"><img src="../images/resch/btn_storage.gif" alt="임시저장" /></a></li>
				<% if(sVO.equals("mod", "")){ %>
					<li><a href="#save" onclick="Save(4);" ><img src="../images/resch/btn_nextstep2.gif" alt="다음 단계로" /></a></li>
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