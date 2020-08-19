<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.buildnine.util.VOSet"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>연구자 | 임상연구등록</title>
	<%@include file="../include/title.jsp" %>
	<%@include file="../include/write_session.jsp" %>

	<script type="text/javascript" src="../js/common.js"></script>
	<script type="text/javascript" src="../js/write.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function (){	
		lf_progress_check();
		
		fn_enagency_chk();

		//국내, 국외 처리
		$('.person_nation').on('change', function() {
			$(this).parent().find('span.nation'+this.value).show();
			if(this.value==0)
			{
				$(this).parent().find('span.nation1').hide();
				$(this).parent().find('input.nation1input').val("");
			}
			else
			{
				$(this).parent().find('span.nation0').hide();
				$(this).parent().find('select.nation0input').val("02");
				$(this).parent().find('input.nation0input').val("");
			}
		});
	});	
	
	function lf_tel_check(target)
	{
		if($('#'+target+'nation').val()==0)
		{
			$('#'+target+'nation').parent().find('span.nation0').show();
			$('#'+target+'nation').parent().find('span.nation1').hide();
			$('#'+target+'nation').parent().find('input.nation1input').val("");			
		}
		else
		{
			$('#'+target+'nation').parent().find('span.nation1').show();
			$('#'+target+'nation').parent().find('span.nation0').hide();
			$('#'+target+'nation').parent().find('select.nation0input').val("");
			$('#'+target+'nation').parent().find('input.nation0input').val("");
		}
	}
	
	function lf_progress_check()
	{
		if($("#progress_yn").val()!='Y')
		{
			$("#charge_name_kr").css({"background-color":"#EFEFEF"});
			$("#charge_name_kr").attr("readonly",true);
			$("#work_name_kr").css({"background-color":"#EFEFEF"});
			$("#work_name_kr").attr("readonly",true);
			$("#regist_name_kr").css({"background-color":"#EFEFEF"});
			$("#regist_name_kr").attr("readonly",true);		
		}
		else
		{
			$("#work_conf_hp").css({"background-color":"#EFEFEF"});
			$("#work_conf_hp").attr("readonly",true);
			$("#charge_conf_hp").css({"background-color":"#EFEFEF"});
			$("#charge_conf_hp").attr("readonly",true);
			$("#regist_conf_hp").css({"background-color":"#EFEFEF"});
			$("#regist_conf_hp").attr("readonly",true);
			
			$("#charge_tab").attr("rowspan",4);
			$("#charge_tab_hp").hide();
			
			$("#work_tab").attr("rowspan",4);
			$("#work_tab_hp").hide();
			
			$("#regist_tab").attr("rowspan",4);
			$("#regist_tab_hp").hide();
		}
	}
	
	
	<!--
	function sameContent(obj, target1, target2 ){

		if( obj.name == "same2") {
			$('#same3').attr('checked', false);
		} else if( obj.name == "same3") {
			$('#same2').attr('checked', false);
		}

		if( obj.checked ){
			//GST_kdh_20141226 id도 복사 되도록 처리추가
			if(target1 == 'work_'){
				$("#"+target1+"ui_idno").val($("#"+target2+"ui_idno").val());
				$("#"+target1+"name_kr").val($("#"+target2+"name_kr").val());
				$("#"+target1+"agency_name_kr").val($("#"+target2+"agency_name_kr").val());
				$("#"+target1+"agency_name_en").val($("#"+target2+"agency_name_en").val());
				$("#"+target1+"email").val($("#"+target2+"email").val());
				$("#"+target1+"email_domain").val($("#"+target2+"email_domain").val());
				$("#"+target1+"conf_hp").val($("#"+target2+"conf_hp").val());
				$("#"+target1+"conf_hp_yn").val($("#"+target2+"conf_hp_yn").val());
				$("#"+target1+"agency_address_kr").val($("#"+target2+"agency_address_kr").val());
			}
			
			$("#"+target1+"name_kr_degree").val($("#"+target2+"name_kr_degree").val());
			$("#"+target1+"name_en_1st").val($("#"+target2+"name_en_1st").val());
			$("#"+target1+"name_en_mid").val($("#"+target2+"name_en_mid").val());
			$("#"+target1+"name_en_last").val($("#"+target2+"name_en_last").val());
			$("#"+target1+"name_en_degree").val($("#"+target2+"name_en_degree").val());
			
			
			//$("#"+target1+"phone").val($("#"+target2+"phone").val());
			
			$("#"+target1+"nation").val($("#"+target2+"nation").val());
			lf_tel_check(target1);
			
			if($("#"+target2+"nation").val()==1)
			{
				$("#"+target1+"fcphone").val($("#"+target2+"fcphone").val());
			}	
			else
			{
				$("#"+target1+"city").val($("#"+target2+"city").val());
				$("#"+target1+"fnum").val($("#"+target2+"fnum").val());
				$("#"+target1+"snum").val($("#"+target2+"snum").val());
			}
			$("#"+target1+"agency_address_en").val($("#"+target2+"agency_address_en").val());
		}
		fn_enagency_chk();
	}
	
	//GST_kdh_20140610 연구책임자 실무자 등록방식 변경
	function fn_cwSearch(pre)
	{
		var CwSearch = window.open("../pop/cw_search.jsp?pre="+pre, "CwSearch", "width=550px, height=535px, left=200px, top=100px");
		CwSearch.focus();
	}
	
	function entCheck(evt)
	{
		if(evt.keyCode==13)
		{
			evt.returnValue=false;
		}
	}
	
	function fn_enregway()
	{
		var enRegistWay = window.open("../pop/ag_enregway.jsp", "enRegistWay", "width=570px, height=300px, left=250px, top=150px");
		enRegistWay.focus();
	}
	
	function fn_enagency_chk()
	{
		if($("#charge_agency_name_kr").val().trim()!="" && $("#charge_agency_name_en").val().trim()=="")
		{	$("#charge_en_regway").show();	}
		else
		{	$("#charge_en_regway").hide();	}
		if($("#work_agency_name_kr").val().trim()!="" && $("#work_agency_name_en").val().trim()=="")
		{	$("#work_en_regway").show();		}
		else
		{	$("#work_en_regway").hide();		}		
		if($("#regist_agency_name_kr").val().trim()!="" && $("#regist_agency_name_en").val().trim()=="")
		{	$("#regist_en_regway").show();	}	
		else
		{	$("#regist_en_regway").hide();		}		
	}
	//-->
	</script>
</head>
<body onload="RemoveForm(3);">
<%

	ValueObject sVO = new ValueObject();
	ValueObject vo = new ValueObject();

	ValueObject chargeVo = new ValueObject();
	ValueObject workVo = new ValueObject();
	ValueObject registVo = new ValueObject();
	//String regist_name_kr = session_unm;
	String temp = "";	
	//GST_kdh_110818 등록 신청서에 등록된 정보를 불러올수 있도록 처리
	ValueObject uVo = new ValueObject();  //멤버정보를 받아오기위한 조건
	ValueObject memberG = new ValueObject();  //받아온 멤버정보를 저장할 객체
	
	String userid = (String)session.getAttribute("session_userid");
	
	uVo.put("userid", userid);
	
	memberG = QueryAction.getQueryView("MEMBER.authCheck", uVo);

	//GST_kdh_110819 등록 신청서에 등록된 정보를 불러올수 있도록 처리
	String name1 = "";
	String uiid1 = "";
	String pos1 = "";
	String email_id1 = "";
	String email_domain1 = "";
	String nation1 = "";
	String city1 = "";
	String fnum1 = "";
	String snum1 = "";
	String fcphone1 = "";
	String agency_name1 = "";
	String agency_name_en1 = "";
	String agency_addr1 = "";
	String agency_addr_en1 = "";
	
	String name2 = "";
	String uiid2 = "";
	String pos2 = "";
	String email_id2 = "";
	String email_domain2 = "";
	String nation2 = "";
	String city2 = "";
	String fnum2 = "";
	String snum2 = "";
	String fcphone2 = "";	
	String agency_name2 = "";
	String agency_name_en2 = "";
	String agency_addr2 = "";
	String agency_addr_en2 = "";
	
	String name3 = "";
	String uiid3 = "";
	String pos3 = "";
	String email_id3 = "";
	String email_domain3 = "";
	String nation3 = "";
	String city3 = "";
	String fnum3 = "";
	String snum3 = "";
	String fcphone3 = "";	
	String agency_name3 = "";
	String agency_name_en3 = "";
	String agency_addr3 = "";
	String agency_addr_en3 = "";
	
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


		if( !sVO.equals("seq", "")) {
			vo = QueryAction.getQueryView("CRIS_DATA.step3", sVO);

			//연구 책임자
			sVO.put("gubun", "CHARGE");
			chargeVo = QueryAction.getQueryView("CRIS_DATA.person_view", sVO);

			//if( !chargeVo.equals("email_domain", "") &&  strEmail.indexOf(chargeVo.get("email_domain")) == -1 ){
			//	chargeVo.put("emailDomain", "-");
			//}
			
			//실무담당자
			sVO.put("gubun", "WORK");
			workVo = QueryAction.getQueryView("CRIS_DATA.person_view", sVO);
			
			//if( !workVo.equals("email_domain", "") &&  strEmail.indexOf(workVo.get("email_domain")) == -1 ){
			//	workVo.put("emailDomain", "-");
			//}
			
			//등록관리자
			sVO.put("gubun", "REGIST");
			registVo = QueryAction.getQueryView("CRIS_DATA.person_view", sVO);
			//if( !registVo.equals("email_domain", "") &&  strEmail.indexOf(registVo.get("email_domain")) == -1 ){
			//	registVo.put("emailDomain", "-");
			//}
			
			//GST_kdh_110819 등록 신청서에 등록된 정보를 불러올수 있도록 처리
			String strMail = "";

			name1 = chargeVo.get("name_kr");
			uiid1 = chargeVo.get("ui_idno");
			pos1 = chargeVo.get("name_kr_degree");
			email_id1 = chargeVo.get("email_id");
			email_domain1 = chargeVo.get("email_domain");
			//tel1 = chargeVo.get("phone");
			nation1 = chargeVo.get("nation");
			city1 = chargeVo.get("city");
			fnum1 = chargeVo.get("fnum");
			snum1 = chargeVo.get("snum");
			fcphone1 = chargeVo.get("fcphone");			
			agency_name1 = chargeVo.get("agency_name_kr");
			agency_name_en1 = chargeVo.get("agency_name_en");
			agency_addr1 = chargeVo.get("agency_address_kr");
			agency_addr_en1 = chargeVo.get("agency_address_en");

			name2 = workVo.get("name_kr");
			uiid2 = workVo.get("ui_idno");
			pos2 = workVo.get("name_kr_degree");
			email_id2 = workVo.get("email_id");
			email_domain2 = workVo.get("email_domain");
			//tel2 = workVo.get("phone");
			nation2 = workVo.get("nation");
			city2 = workVo.get("city");
			fnum2 = workVo.get("fnum");
			snum2 = workVo.get("snum");
			fcphone2 = workVo.get("fcphone");			
			agency_name2 = workVo.get("agency_name_kr");
			agency_name_en2 = workVo.get("agency_name_en");
			agency_addr2 = workVo.get("agency_address_kr");
			agency_addr_en2 = workVo.get("agency_address_en");

			name3 = registVo.get("name_kr");
			uiid3 = registVo.get("ui_idno");
			pos3 = registVo.get("name_kr_degree");
			email_id3 = registVo.get("email_id");
			email_domain3 = registVo.get("email_domain");
			//tel3 = registVo.get("phone");
			nation3 = registVo.get("nation");
			city3 = registVo.get("city");
			fnum3 = registVo.get("fnum");
			snum3 = registVo.get("snum");
			fcphone3 = registVo.get("fcphone");				
			agency_name3 = registVo.get("agency_name_kr");
			agency_name_en3 = registVo.get("agency_name_en");
			agency_addr3 = registVo.get("agency_address_kr");
			agency_addr_en3 = registVo.get("agency_address_en");
			
			/*
			if(memberG!=null)
			{
				if(chargeVo.get("name_kr").equals(""))
				{
					name1 = memberG.get("rppsn_name");
					pos1 = memberG.get("rppsn_pos");

					strMail = memberG.get("rppsn_email");
					if(strMail.indexOf("@")>-1)
					{
						email_id1 = strMail.substring(0,strMail.indexOf("@"));
						email_domain1 = strMail.substring(strMail.indexOf("@")+1);
					}
					
					tel1 = memberG.get("rppsn_tel");
					tel1 = tel1.replaceAll("-","");

					agency_name1 = memberG.get("rppsn_org"); 
					agency_addr1 = memberG.get("rppsn_org_addr"); 					
				}

				if(workVo.get("name_kr").equals(""))
				{
					name2 = memberG.get("chrpsn_name");
					pos2 = memberG.get("chrpsn_pos");

					strMail = memberG.get("chrpsn_email");
					if(strMail.indexOf("@")>-1)
					{
						email_id2 = strMail.substring(0,strMail.indexOf("@"));
						email_domain2 = strMail.substring(strMail.indexOf("@")+1);
					}
					
					tel2 = memberG.get("chrpsn_tel");
					tel2 = tel2.replaceAll("-","");

					agency_name2 = memberG.get("chrpsn_org"); 
					agency_addr2 = memberG.get("chrpsn_org_addr"); 							
				}
				
				if(registVo.get("name_kr").equals(""))
				{
					name3 = memberG.get("appli_name");
					pos3 = memberG.get("appli_pos");

					strMail = memberG.get("appli_email");
					if(strMail.indexOf("@")>-1)
					{
						email_id3 = strMail.substring(0,strMail.indexOf("@"));
						email_domain3 = strMail.substring(strMail.indexOf("@")+1);
					}
					
					tel3 = memberG.get("appli_tel");
					tel3 = tel3.replaceAll("-","");

					agency_name3 = memberG.get("appli_org"); 
					agency_addr3 = memberG.get("appli_org_addr"); 					
				}
			}*/
			
			//regist_name_kr = registVo.get("name_kr");
		}

		//GST_kdh_20121012 미사용 항목 삭제
		//VOSet nationList = QueryAction.getQueryList("CODE.nation_list2", sVO);
		
		//GST_kdh_20161013 전화번호 입력 방식 변경
		sVO.put("code_grp", "AREACODE");
		VOSet areaList = QueryAction.getQueryList("CODE.cmcd_list", sVO);
		
		
		
		String caField = "";
		String waField = "";
		String raField = "";		
		
		ValueObject ao;
		caField += "<select name='charge_city' class='nation0input' id='charge_city' title='연구책임자 지역번호선택' style='width:90px;'>";
		waField += "<select name='work_city' class='nation0input' id='work_city' title='연구실무자담당자 지역번호선택' style='width:90px;'>";
		raField += "<select name='regist_city' class='nation0input' id='regist_city' title='등록관리자 지역번호선택' style='width:90px;'>";
		//caField += "<option value=''>지역번호선택</option>";
		if(areaList!=null && areaList.size()>0)
		{
			for(int i=0; i<areaList.size(); i++)
			{
				ao = areaList.get( i ) ;
				if(ao.get("code_id")!="")
				{
					caField += "<option value='"+ao.get("code_id")+"' "+(city1.equals((String)ao.get("code_id"))?"selected":"")+">"+ao.get("code_name")+"("+ao.get("code_id")+")"+"</option>";
					waField += "<option value='"+ao.get("code_id")+"' "+(city2.equals((String)ao.get("code_id"))?"selected":"")+">"+ao.get("code_name")+"("+ao.get("code_id")+")"+"</option>";
					raField += "<option value='"+ao.get("code_id")+"' "+(city3.equals((String)ao.get("code_id"))?"selected":"")+">"+ao.get("code_name")+"("+ao.get("code_id")+")"+"</option>";
				}
				else
				{
					caField += "<option value='"+ao.get("code_id")+"' "+(!nation1.equals("")&&city1.equals((String)ao.get("code_id"))?"selected":"")+">"+ao.get("code_name")+"</option>";
					waField += "<option value='"+ao.get("code_id")+"' "+(!nation2.equals("")&&city2.equals((String)ao.get("code_id"))?"selected":"")+">"+ao.get("code_name")+"</option>";
					raField += "<option value='"+ao.get("code_id")+"' "+(!nation3.equals("")&&city3.equals((String)ao.get("code_id"))?"selected":"")+">"+ao.get("code_name")+"</option>";					
				}
			}
		}
		caField += "</select>";
		waField += "</select>";
		raField += "</select>";
		
		String s_seq = sVO.get("seq");
		String v_seq = vo.getInputbox("seq");
		String v_status = vo.getInputbox("status");
		String v_seq_group = vo.getInputbox("seq_group");
		String v_mod = sVO.get("mod");
		String v_progress_yn = vo.getInputbox("progress_yn");
		String research_title_kr = StringUtil.getTitleLimit(vo.getInputbox("research_title_kr"),83);
		String c_name_en_1st = chargeVo.getInputbox("name_en_1st");
		String c_name_en_mid = chargeVo.getInputbox("name_en_mid");
		String c_name_en_last = chargeVo.getInputbox("name_en_last");
		String c_name_en_degree = chargeVo.getInputbox("name_en_degree");
		String nation1_0 = nation1.equals("0")?"selected":"";
		String nation1_1 = nation1.equals("1")?"selected":""; 
		String nation1_style = nation1.equals("1")?"display:none":""; 
		String nation1_style1 = nation1.equals("1")?"":"display:none"; 
		String c_conf_hp = chargeVo.getInputbox("conf_hp");
		String c_conf_hp_yn = chargeVo.getInputbox("conf_hp_yn").equals("Y")?"checked":"";
		
		String w_name_en_1st = workVo.getInputbox("name_en_1st");
		String w_name_en_mid = workVo.getInputbox("name_en_mid");
		String w_name_en_last = workVo.getInputbox("name_en_last");
		String w_name_en_degree = workVo.getInputbox("name_en_degree");
		String nation2_0 = nation2.equals("0")?"selected":"";
		String nation2_1 = nation2.equals("1")?"selected":""; 
		String nation2_style = nation2.equals("1")?"display:none":""; 
		String nation2_style1 = nation2.equals("1")?"":"display:none"; 
		String w_conf_hp = workVo.getInputbox("conf_hp");
		String w_conf_hp_yn = workVo.getInputbox("conf_hp_yn").equals("Y")?"checked":"";
		
		String r_name_en_1st = registVo.getInputbox("name_en_1st");
		String r_name_en_mid = registVo.getInputbox("name_en_mid");
		String r_name_en_last = registVo.getInputbox("name_en_last");
		String r_name_en_degree = registVo.getInputbox("name_en_degree");
		String nation3_0 = nation3.equals("0")?"selected":"";
		String nation3_1 = nation3.equals("1")?"selected":""; 
		String nation3_style = nation3.equals("1")?"display:none":""; 
		String nation3_style1 = nation3.equals("1")?"":"display:none"; 
		String r_conf_hp = registVo.getInputbox("conf_hp");
		String r_conf_hp_yn = registVo.getInputbox("conf_hp_yn").equals("Y")?"checked":"";
		
		//dddddddd
		if(StringUtils.isBlank(name3)){
			sVO.put("cw_id",(String)session.getAttribute("session_userid"));
			VOSet voset = QueryAction.getQueryList("CRIS_DATA.cwSearch", sVO);
			vo = voset.get(0);
			String ui_email = vo.getInputbox("ui_email");		
			name3 = vo.getInputbox("ui_name");
			uiid3 = vo.getInputbox("userid");
			email_id3 = ui_email.substring(0,ui_email.indexOf("@"));
			email_domain3 = ui_email.substring(ui_email.indexOf("@")+1,ui_email.length());
			r_conf_hp = vo.getInputbox("ui_hp1").replace("-","");
			agency_name3 = vo.getInputbox("agency_name");
			agency_name_en3 = vo.getInputbox("agency_name_en");
			agency_addr3 = vo.getInputbox("agency_area_road1");
		}
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
							<%if(vo.equals("status", "0")) {temp = "";	 %>작성중<%} %>
							<%if(vo.equals("status", "1")) {temp = "";	 %>제출<%} %>
							<%if(vo.equals("status", "2")) {temp = "";	 %>보류<%} %>
							<%if(vo.equals("status", "3")) {temp = "";	 %>보완<%} %>
							<%if(vo.equals("status", "4")) {temp = "";	 %>반려<%} %>
							<%if(vo.equals("status", "5")) {temp = "";	 %>승인<%} %>
							<%if(vo.equals("status", "6")) {temp = "";	 %>임시저장<%} %>
						</span></li>
						<li>제 목 : <span><c:out value="<%=research_title_kr %>" escapeXml="false" /></span></li>
					</ul>
				</div>
			<% } %>
			<div id="sideB" class="research_tit">
				<h3><img src="../images/resch/tit2014_wstep03.gif" alt="3. 연구자 (Contact Details)" /></h3><br />
			</div>
			<div class="research_tb">
				<div class="reshtb_tit">
					<h4>연구책임자 (Contact Person for Principal Investigator&#47;Scientific Queries)</h4>
				</div>

				<iframe name="iframe" title="의미없는 아이프레임" style="display:none;" width="0" height="0"></iframe>
				<form name="form" id="form" method="post">
				<input type="hidden" name="seq" 	id="seq" 	value="<c:out value="<%=v_seq%>" />" />
				<input type="hidden" name="status" 	id="status" value="<c:out value="<%=v_status%>" />" />
				<input type="hidden" name="seq_group"	id="seq_group" 	value="<c:out value="<%=v_seq_group%>" />" />
				<input type="hidden" name="mode" 	id="mode" 	value="" />
				<input type="hidden" name="mod" id="mod" value="<c:out value="<%=v_mod%>" />" />
				<input type="hidden" name="step" id="step" />
				
				<input type="hidden" name="charge_ui_idno" id="charge_ui_idno" value="<c:out value="<%=uiid1%>" />" />
				<input type="hidden" name="work_ui_idno" id="work_ui_idno" value="<c:out value="<%=uiid2%>" />"  />
				<input type="hidden" name="regist_ui_idno" id="regist_ui_idno" value="<c:out value="<%=uiid3%>" />" />	
				
				<input type="hidden" name="progress_yn" id="progress_yn" value="<c:out value="<%=v_progress_yn%>" />" />
				<table cellspacing="0" cellpadding="0" border="0" summary="연구책임자, 기관으로 구성된 연구책임자정보 입력테이블입니다.">
					<caption>연구책임자 정보 입력</caption>
					<colgroup>
						<col width="130px" /><col width="110px" /><col width="80px" /><col width="*" />
					</colgroup>				
					<tbody>
						<tr>
							<th id="charge_tab" rowspan="5" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />연구책임자
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(3,1);"><img src="../images/resch/icon2014_help.png" alt="연구책임자 설명" class="img_set" /></a><br />
							(Principal<br />&nbsp;&nbsp;Investigator)</th>
							<th class="textc borderset" rowspan="2" scope="row"><label for="charge_name_kr">성명 및 직위<br />(Name & Title)</label></th>
							<th class="textc borderset" scope="row"><label for="charge_name_kr">국문<br />(KOR)</label></th>
							<td class="borderset">연구에 대한 과학적이고 구체적인 질의에 답변을 할 수 있는 사람으로서 해당 연구에 대하여 전반적인 책임을 지닌 연구자<br />
								<input type="text" name="charge_name_kr" id="charge_name_kr" title="연구책임자 국문" value="<%out.print(name1);%>" maxlength="20" maxbyte="20" style="ime-mode:active;width:300px;" />
								<label for="charge_name_kr_degree" class="magset">직위</label>
								<input type="text" name="charge_name_kr_degree" id="charge_name_kr_degree" value="<%out.print(pos1);%>" maxlength="20" maxbyte="20" style="ime-mode:active;width:100px;" />
								<a href="#cwsearch" onclick="fn_cwSearch('charge_');" ><img src="../images/resch/btn2014_ad1search.png" alt="연구책임자검색" class="inpimg" /></a>
							</td>
						</tr>
						<tr>
							<th class="textc borderset" scope="row"><label for="charge_name_en_1st">영문<br />(ENG)</label></th>
							<td class="borderset">
								<label for="charge_name_en_1st" class="magset1">First</label><input type="text" name="charge_name_en_1st" id="charge_name_en_1st" title="연구책임자 영문 1st" value="<%out.print(c_name_en_1st); %>" maxlength="20" maxbyte="20" style="ime-mode:disabled;width:100px;" />
								<label for="charge_name_en_mid" class="magset">Middle</label><input type="text" name="charge_name_en_mid" id="charge_name_en_mid" title="연구책임자 영문 mid" value="<%out.print(c_name_en_mid); %>" maxlength="20" maxbyte="20" style="ime-mode:disabled;width:100px;" />
								<label for="charge_name_en_last" class="magset">Last</label><input type="text" name="charge_name_en_last" id="charge_name_en_last" title="연구책임자 영문 last" value="<%out.print(c_name_en_last); %>" maxlength="20" maxbyte="20" style="ime-mode:disabled;width:100px;"  />
								<label for="charge_name_en_degree" class="magset">Title</label><input type="text" name="charge_name_en_degree" id="charge_name_en_degree" title="연구책임자 영문 Title" value="<%out.print(c_name_en_degree); %>" maxlength="20" maxbyte="20" style="ime-mode:disabled;width:100px;" />
							</td>
						</tr>
						<tr>
							<th class="textc borderset" colspan="2" scope="row"><label for="charge_email">이메일 (Email)</label></th>
							<td class="borderset">
								<label for="charge_email" class="dp_no">Email 아이디</label><input type="text" name="charge_email" id="charge_email" title="연구책임자 Email 아이디" value="<%out.print(email_id1);%>" maxlength="25" maxbyte="25" style="ime-mode:disabled;width:100px;" /> @ 
								<label for="charge_email_domain" class="dp_no">Email 도메인</label><input type="text" name="charge_email_domain" id="charge_email_domain" title="연구책임자 Email 도메인" value="<%out.print(email_domain1);%>" maxlength="20" maxbyte="20" style="ime-mode:disabled;width:100px;" />
							</td>
						</tr>
						<tr>
							<th class="textc borderset" colspan="2" scope="row"><label for="charge_nation">전화번호 (Telephone)</label></th>
							<td class="borderset">
								<select name="charge_nation" id="charge_nation" class="person_nation" title="연구책임자 국내국외선택" style="width:80px;">
									<option value="0" <c:out value="<%=nation1_0 %>" /> >국내(82)</option>
									<option value="1" <c:out value="<%=nation1_1 %>" /> >국외</option>
								</select> -
								<span style="<c:out value="<%=nation1_style %>" />" class="nation0">
									<c:out value="<%=caField %>" escapeXml="false" />
									 -
									<input type="tel" name="charge_fnum" id="charge_fnum" class="nation0input" title="연구책임자 국내 전화번호 앞자리" onkeypress="javascript:onlyNumber()" value="<%out.print(fnum1);%>" maxlength="4" maxbyte="4" style="ime-mode:disabled;width:60px;" /> -
									<input type="tel" name="charge_snum" id="charge_snum" class="nation0input" title="연구책임자 국내 전화번호 뒷자리" onkeypress="javascript:onlyNumber()" value="<%out.print(snum1);%>" maxlength="4" maxbyte="4" style="ime-mode:disabled;width:60px;" />
								</span>
								<span style="<c:out value="<%=nation1_style1 %>" />" class="nation1">
									<input type="tel" name="charge_fcphone" id="charge_fcphone" class="nation1input" title="연구책임자 국외 전화번호 입력" onkeypress="javascript:onlyFCPhone()" value="<%out.print(fcphone1);%>" maxlength="25" maxbyte="25" style="ime-mode:disabled;width:150px;" />							
									<span>(+(국가번호)-(지역번호)-(국번)-(번호) 예시) +82-43-1234-1234)</span>
								</span>
							</td>
						</tr>
						<tr id="charge_tab_hp">
							<th class="textc" colspan="2" scope="row"><label for="charge_conf_hp">휴대폰번호 (Cellular Phone)</label></th>
							<td>
								<input type="tel" id="charge_conf_hp" name="charge_conf_hp" onkeypress="javascript:onlyNumber()" maxlength="11" class="hpset" value="<%out.print(c_conf_hp); %>" style="ime-mode:disabled;width:100px;" />
								<input type="checkbox" name="charge_conf_hp_yn" id="charge_conf_hp_yn" title="연구책임자 휴대폰" <c:out value="<%=c_conf_hp_yn %>" /> value="Y" /><label for="charge_conf_hp_yn">문자수신동의 : 해당번호로 연구진행 정보가 전송됩니다. 문자 수신이 가능한 전화번호를 입력 하십시오.</label>
							</td>
						</tr>
						<tr>
							<th rowspan="4" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />기관명 및 주소<br />
							(Affiliation<br/ >&nbsp;&nbsp;&nbsp;&nbsp;& Address)</th>
							<th class="textc borderset" rowspan="2" scope="row"><label for="charge_agency_name_kr">기관명<br />(Affiliation)</label></th>
							<th class="textc borderset" scope="row"><label for="charge_agency_name_kr">국문<br />(KOR)</label></th>
							<td class="borderset">
								<input type="text" name="charge_agency_name_kr" id="charge_agency_name_kr" title="연구책임자 기관 국문"  value="<%out.print(agency_name1);%>" maxlength="200" maxbyte="200" readonly style="background:#EFEFEF;width:580px;" />
							</td>
						</tr>
						<tr>
							<th class="textc borderset" scope="row"><label for="charge_agency_name_en">영문<br />(ENG)</label></th>
							<td class="borderset">
								<input type="text" name="charge_agency_name_en" id="charge_agency_name_en" title="연구책임자 기관 영문" value="<%out.print(agency_name_en1); %>" maxlength="200" maxbyte="200" readonly style="background:#EFEFEF;width:580px;"  />
								<a href="#cregway" onclick="fn_enregway();" ><img id="charge_en_regway" src="../images/resch/btn2014_orgen.png" alt="영문명 등록안내" class="inpimg" /></a>
							</td>
						</tr>
						<tr>
							<th class="textc borderset" rowspan="2" scope="row"><label for="charge_agency_address_kr">주소<br />(Address)</label></th>
							<th class="textc" scope="row"><label for="charge_agency_address_kr">국문<br />(KOR)</label></th>
							<td>
								<input type="text" name="charge_agency_address_kr" id="charge_agency_address_kr" title="연구책임자 기관 주소 국문" value="<%out.print(agency_addr1);%>" maxlength="200" maxbyte="200" style="ime-mode:active;width:100%;" />
							</td>
						</tr>						
						<tr>
							<th class="textc" scope="row"><label for="charge_agency_address_en">영문<br />(ENG)</label></th>
							<td>
								<input type="text" name="charge_agency_address_en" id="charge_agency_address_en" title="연구책임자 기관 주소 영문" value="<%out.print(agency_addr_en1);%>" maxlength="200" maxbyte="200" style="ime-mode:disabled;width:100%;" />
							</td>
						</tr>
					</tbody>
				</table>
				<div class="reshtb_tit margintop15">
					<h4>연구실무담당자 (Contact Person for Public Queries)</h4>
					<ul>
						<li><input type="checkbox" name="same1" id="same1" onclick="sameContent(this, 'work_','charge_');" /><label for="same1">연구책임자와 동일</label></li>
					</ul>
				</div>
				<table cellspacing="0" cellpadding="0" border="0" summary="실무담당자, 기관으로 구성된 연구실무담당자 정보 입력테이블입니다.">
					<caption>연구실무담당자 정보 입력</caption>
					<colgroup>
						<col width="130px" /><col width="110px" /><col width="80px" /><col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th id="work_tab" rowspan="5" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />실무담당자
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(3,2);"><img src="../images/resch/icon2014_help.png" alt="실무담당자 설명" class="img_set" /></a><br />
							(Investigator<br />&nbsp;/Study Nurse)</th>
							<th class="textc borderset" rowspan="2" scope="row"><label for="work_name_kr">성명 및 직위<br />(Name & Title)</label></th>
							<th class="textc borderset" scope="row"><label for="work_name_kr">국문<br />(KOR)</label></th>
							<td class="borderset">연구에 대한 일반적인 문의에 답변할 수 있는 연구실무 담당자<br />
								<input type="text" name="work_name_kr" id="work_name_kr" title="실무담당자 국문" value="<%out.print(name2);%>" maxlength="20" maxbyte="20" style="ime-mode:active;width:300px;" />
								<label for="work_name_kr_degree" class="magset">직위</label>
								<input type="text" name="work_name_kr_degree" id="work_name_kr_degree" value="<%out.print(pos2);%>" maxlength="20" maxbyte="20" style="ime-mode:active;width:100px;" />
								<a href="#cwsearch" onclick="fn_cwSearch('work_');" ><img src="../images/resch/btn2014_ad2search.png" alt="실무담당자검색" class="inpimg" /></a>
							</td>
						</tr>
						<tr>
							<th class="textc borderset" scope="row"><label for="work_name_en_1st">영문<br />(ENG)</label></th>
							<td class="borderset">
								<label for="work_name_en_1st" class="magset1">First</label><input type="text" name="work_name_en_1st" id="work_name_en_1st" title="실무담당자 영문 1st" value="<%out.print(w_name_en_1st); %>" maxlength="20" maxbyte="20" style="ime-mode:disabled;width:100px;" />
								<label for="work_name_en_mid" class="magset">Middle</label><input type="text" name="work_name_en_mid" id="work_name_en_mid" title="실무담당자 영문 mid" value="<%out.print(w_name_en_mid); %>"maxlength="20" maxbyte="20" style="ime-mode:disabled;width:100px;" />
								<label for="work_name_en_last" class="magset">Last</label><input type="text" name="work_name_en_last" id="work_name_en_last" title="실무담당자 영문 last" value="<%out.print(w_name_en_last); %>" maxlength="20" maxbyte="20" style="ime-mode:disabled;width:100px;" />
								<label for="work_name_en_degree" class="magset">Title</label><input type="text" name="work_name_en_degree" id="work_name_en_degree" title="실무담당자 영문 Title" value="<%out.print(w_name_en_degree); %>" maxlength="20" maxbyte="20" style="ime-mode:disabled;width:100px;" />
							</td>
						</tr>
						<tr>
							<th class="textc borderset" colspan="2" scope="row"><label for="work_email">이메일 (Email)</label></th>
							<td class="borderset">
								<label for="work_email" class="dp_no">Email 아이디</label><input type="text" name="work_email" id="work_email" title="실무담당자 Email 아이디" value="<%out.print(email_id2);%>" maxlength="25" maxbyte="25" style="ime-mode:disabled;width:100px;" /> @ 
								<label for="work_email_domain" class="dp_no">Email 도메인</label><input type="text" name="work_email_domain" id="work_email_domain" title="실무담당자 Email 도메인" value="<%out.print(email_domain2);%>" maxlength="20" maxbyte="20" style="ime-mode:disabled;width:100px;" />
							</td>
						</tr>
						<tr>
							<th class="textc borderset" colspan="2" scope="row"><label for="work_nation">전화번호 (Telephone)</label></th>
							<td class="borderset">
								<select name="work_nation" id="work_nation" class="person_nation" title="연구실무담당자 국내국외선택" style="width:80px;">
									<option value="0" <c:out value="<%=nation2_0 %>" /> >국내(82)</option>
									<option value="1" <c:out value="<%=nation2_1 %>" /> >국외</option>
								</select> -
								<span style="<c:out value="<%=nation2_style %>" />" class="nation0">
									<c:out value="<%=waField %>" escapeXml="false" />
									 -
									<input type="tel" name="work_fnum" id="work_fnum" class="nation0input" title="연구실무담당자 국내 전화번호 앞자리" onkeypress="javascript:onlyNumber()" value="<%out.print(fnum2);%>" maxlength="4" maxbyte="4" style="ime-mode:disabled;width:60px;" /> -
									<input type="tel" name="work_snum" id="work_snum" class="nation0input" title="연구실무담당자 국내 전화번호 뒷자리" onkeypress="javascript:onlyNumber()" value="<%out.print(snum2);%>" maxlength="4" maxbyte="4" style="ime-mode:disabled;width:60px;" />
								</span>
								<span style="<c:out value="<%=nation2_style1 %>" />" class="nation1">
									<input type="tel" name="work_fcphone" id="work_fcphone" class="nation1input" title="연구실무담당자 국외 전화번호 입력" onkeypress="javascript:onlyFCPhone()" value="<%out.print(fcphone2);%>" maxlength="25" maxbyte="25" style="ime-mode:disabled;width:150px;" />							
									<span>(+(국가번호)-(지역번호)-(국번)-(번호) 예시) +82-43-1234-1234)</span>
								</span>
							</td>
						</tr>
						<tr id="work_tab_hp">
							<th class="textc" colspan="2" scope="row"><label for="work_conf_hp">휴대폰번호 (Cellular Phone)</label></th>
							<td>
								<input type="tel" id="work_conf_hp" name="work_conf_hp" title="실무담당자 휴대폰" onkeypress="javascript:onlyNumber()" maxlength="11" class="hpset" value="<%out.print(w_conf_hp); %>" style="ime-mode:disabled;width:100px;" />
								<input type="checkbox" name="work_conf_hp_yn" id="work_conf_hp_yn" <c:out value="<%=w_conf_hp_yn %>" /> value="Y" /><label for="work_conf_hp_yn">문자수신동의 : 해당번호로 연구진행 정보가 전송됩니다. 문자 수신이 가능한 전화번호를 입력 하십시오.</label>
							</td>
						</tr>
						<tr>
							<th rowspan="4" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />기관명 및 주소<br />
							(Affiliation<br/ >&nbsp;&nbsp;&nbsp;&nbsp;& Address)</th>
							<th class="textc borderset" rowspan="2" scope="row"><label for="work_agency_name_kr">기관명<br />(Affiliation)</label></th>
							<th class="textc borderset" scope="row"><label for="work_agency_name_kr">국문<br />(KOR)</label></th>
							<td class="borderset">
								<input type="text" name="work_agency_name_kr" id="work_agency_name_kr" title="실무담당자 기관 국문" value="<%out.print(agency_name2);%>" maxlength="200" maxbyte="200" readonly style="background:#EFEFEF;width:580px;" />
							</td>
						</tr>
						<tr>
							<th class="textc borderset" scope="row"><label for="work_agency_name_en">영문<br />(ENG)</label></th>
							<td class="borderset">
								<input type="text" name="work_agency_name_en" id="work_agency_name_en" title="실무담당자 기관 영문" value="<%out.print(agency_name_en2);%>" maxlength="200" maxbyte="200" readonly style="background:#EFEFEF;width:580px;" />
								<a href="#wregway" onclick="fn_enregway();" ><img id="work_en_regway" src="../images/resch/btn2014_orgen.png" alt="영문명 등록안내" class="inpimg" /></a>
							</td>
						</tr>
						<tr>
							<th class="textc borderset" rowspan="2" scope="row"><label for="work_agency_address_kr">주소<br />(Address)</label></th>
							<th class="textc" scope="row"><label for="work_agency_address_kr">국문<br />(KOR)</label></th>
							<td>
								<input type="text" name="work_agency_address_kr" id="work_agency_address_kr" title="실무담당자 기관 주소 국문" value="<%out.print(agency_addr2);%>" maxlength="200" maxbyte="200" style="ime-mode:active;width:100%;" />
							</td>
						</tr>
						<tr>
							<th class="textc" scope="row"><label for="work_agency_address_en">영문<br />(ENG)</label></th>
							<td>
								<input type="text" name="work_agency_address_en" id="work_agency_address_en" title="실무담당자 기관 주소 영문" value="<%out.print(agency_addr_en2);%>" maxlength="200" maxbyte="200" style="ime-mode:disabled;width:100%;" />
							</td>
						</tr>						
					</tbody>
				</table>
				<div class="reshtb_tit margintop15">
					<h4>등록관리자 (Contact Person for Updating Information)</h4>
					<ul>
						<li><input type="checkbox" name="same2" id="same2" onclick="sameContent(this, 'regist_','charge_');" /><label for="same2">연구책임자와 동일</label></li>
						<li><input type="checkbox" name="same3" id="same3" onclick="sameContent(this, 'regist_','work_');" /><label for="same3">연구실무담당자와 동일</label></li>
					</ul>
				</div>
				<table cellspacing="0" cellpadding="0" border="0" summary="등록관리자, 기관으로 구성된 등록관리자 정보 입력테이블입니다.">
					<caption>등록관리자 정보 입력</caption>
					<colgroup>
						<col width="130px" /><col width="110px" /><col width="80px" /><col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th id="regist_tab" rowspan="5" scope="row"><img src="../images/resch/icon2014_cris.png" alt="cris 필수항목" />등록관리자
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(3,3);"><img src="../images/resch/icon2014_help.png" alt="등록관리자 설명" class="img_set" /></a><br />
							(Registrant)</th>
							<th class="textc borderset" rowspan="2" scope="row"><label for="charge_name_kr">성명 및 직위<br />(Name & Title)</label></th>
							<th class="textc borderset" scope="row"><label for="regist_name_kr">국문<br />(KOR)</label></th>
							<td class="borderset">임상연구정보 서비스(CRIS)의 해당연구 정보 등록 담당자<br />
								<input type="text" name="regist_name_kr" id="regist_name_kr" title="등록관리자 국문" value="<%out.print(name3);%>" maxlength="20" maxbyte="20" style="ime-mode:active;width:300px;" />
								<label for="regist_name_kr_degree" class="magset">직위</label>
								<input type="text" name="regist_name_kr_degree" id="regist_name_kr_degree" title="등록관리자 직위" value="<%out.print(pos3);%>" maxlength="20" maxbyte="20" style="ime-mode:active;width:100px;" />
								<a href="#cwsearch" onclick="fn_cwSearch('regist_');" style="pointer-events: none;" ><img src="../images/resch/btn2014_ad3search.png" alt="등록관리자검색" class="inpimg" /></a>
							</td>
						</tr>
						<tr>
							<th class="textc borderset" scope="row"><label for="regist_name_en_1st">영문<br />(ENG)</label></th>
							<td class="borderset">
								<label for="regist_name_en_1st" class="magset1">First</label><input type="text" name="regist_name_en_1st" id="regist_name_en_1st" title="등록관리자 영문 1st" value="<%out.print(r_name_en_1st); %>" maxlength="20" maxbyte="20" style="ime-mode:disabled;width:100px;" />
								<label for="regist_name_en_mid" class="magset">Middle</label><input type="text" name="regist_name_en_mid" id="regist_name_en_mid" title="등록관리자 영문 mid" value="<%out.print(r_name_en_mid); %>" maxlength="20" maxbyte="20" style="ime-mode:disabled;width:100px;" />
								<label for="regist_name_en_last" class="magset">Last</label><input type="text" name="regist_name_en_last" id="regist_name_en_last" title="등록관리자 영문 last" value="<%out.print(r_name_en_last); %>" maxlength="20" maxbyte="20" style="ime-mode:disabled;width:100px;" />
								<label for="regist_name_en_degree" class="magset">Title</label><input type="text" name="regist_name_en_degree" id="regist_name_en_degree" title="등록관리자 영문 Title" value="<%out.print(r_name_en_degree); %>" maxlength="20" maxbyte="20" style="ime-mode:disabled;width:100px;" />
							</td>
						</tr>
						<tr>
							<th class="textc borderset" colspan="2" scope="row"><label for="regist_email">이메일 (Email)</label></th>
							<td class="borderset">
								<label for="regist_email" class="dp_no">Email 아이디</label><input type="text" name="regist_email" id="regist_email" title="등록관리자 Email 아이디" value="<%out.print(email_id3);%>" maxlength="25" maxbyte="25" style="ime-mode:disabled;width:100px;background-color:#EFEFEF;" readonly="readonly" /> @ 
								<label for="regist_email_domain" class="dp_no">Email 도메인</label><input type="text" name="regist_email_domain" id="regist_email_domain" title="등록관리자 Email 도메인" value="<%out.print(email_domain3);%>" maxlength="20" maxbyte="20" style="ime-mode:disabled;width:100px;background-color:#EFEFEF;"  readonly="readonly" />
							</td>
						</tr>
						<tr>
							<th class="textc borderset" colspan="2" scope="row"><label for="regist_nation">전화번호 (Telephone)</label></th>
							<td class="borderset">
								<select name="regist_nation" id="regist_nation" class="person_nation" title="등록관리자 국내국외선택" style="width:80px;">
									<option value="0" <c:out value="<%=nation3_0 %>" /> >국내(82)</option>
									<option value="1" <c:out value="<%=nation3_1 %>" /> >국외</option>
								</select> -
								<span style="<c:out value="<%=nation3_style %>" />" class="nation0">
									<c:out value="<%=raField %>" escapeXml="false" />
									 -
									<input type="tel" name="regist_fnum" id="regist_fnum" class="nation0input" title="등록관리자 국내 전화번호 앞자리" onkeypress="javascript:onlyNumber()" value="<c:out value="<%=fnum3%>" />" maxlength="4" maxbyte="4" style="ime-mode:disabled;width:60px;" /> -
									<input type="tel" name="regist_snum" id="regist_snum" class="nation0input" title="등록관리자 국내 전화번호 뒷자리" onkeypress="javascript:onlyNumber()" value="<c:out value="<%=snum3%>" />" maxlength="4" maxbyte="4" style="ime-mode:disabled;width:60px;" />
								</span>
								<span style="<c:out value="<%=nation3_style1 %>" />" class="nation1">
									<input type="tel" name="regist_fcphone" id="regist_fcphone" class="nation1input" title="등록관리자 국외 전화번호 입력" onkeypress="javascript:onlyFCPhone()" value="<%out.print(fcphone3);%>" maxlength="25" maxbyte="25" style="ime-mode:disabled;width:150px;" />							
									<span>(+(국가번호)-(지역번호)-(국번)-(번호) 예시) +82-43-1234-1234)</span>
								</span>
							</td>
						</tr>
						<tr id="regist_tab_hp">
							<th class="textc" colspan="2" scope="row"><label for="regist_conf_hp">휴대폰번호 (Cellular Phone)</label></th>
							<td>
								<input type="tel" id="regist_conf_hp" name="regist_conf_hp" title="등록관리자 휴대폰" onkeypress="javascript:onlyNumber()" maxlength="11" class="hpset" value="<%out.print(r_conf_hp); %>" style="ime-mode:disabled;width:100px;background-color:#EFEFEF;" readonly="readonly" />
								<input type="checkbox" name="regist_conf_hp_yn" id="regist_conf_hp_yn" <c:out value="<%=r_conf_hp_yn %>" /> value="Y" /><label for="regist_conf_hp_yn">문자수신동의 : 해당번호로 연구진행 정보가 전송됩니다. 문자 수신이 가능한 전화번호를 입력 하십시오.</label>
							</td>
						</tr>
						<tr>
							<th rowspan="4" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />기관명 및 주소<br />
							(Affiliation<br/ >&nbsp;&nbsp;&nbsp;&nbsp;& Address)</th>
							<th class="textc borderset" rowspan="2" scope="row"><label for="regist_agency_name_kr">기관명<br />(Affiliation)</label></th>
							<th class="textc borderset" scope="row"><label for="regist_agency_name_kr">국문<br />(KOR)</label></th>
							<td class="borderset">
								<input type="text" name="regist_agency_name_kr" id="regist_agency_name_kr" title="등록관리자 기관 국문" value="<%out.print(agency_name3);%>" maxlength="200" maxbyte="200" readonly style="background:#EFEFEF;width:580px;" />
							</td>
						</tr>
						<tr>
							<th class="textc borderset" scope="row"><label for="regist_agency_name_en">영문<br />(ENG)</label></th>
							<td class="borderset">
								<input type="text" name="regist_agency_name_en" id="regist_agency_name_en" title="등록관리자 기관 영문" value="<%out.print(agency_name_en3);%>" maxlength="200" maxbyte="200" readonly style="background:#EFEFEF;width:580px;" />
								<a href="#rregway" onclick="fn_enregway();" ><img id="regist_en_regway" src="../images/resch/btn2014_orgen.png" alt="영문명 등록안내" class="inpimg" /></a>
							</td>
						</tr>
						<tr>
							<th class="textc borderset" rowspan="2" scope="row"><label for="regist_agency_address_kr">주소<br />(Address)</label></th>
							<th class="textc" scope="row"><label for="regist_agency_address_kr">국문<br />(KOR)</label></th>
							<td>
								<input type="text" name="regist_agency_address_kr" id="regist_agency_address_kr" title="등록관리자 기관 주소 국문" value="<%out.print(agency_addr3);%>" maxlength="200" maxbyte="200" style="ime-mode:active;width:100%;background-color:#EFEFEF;" readonly="readonly" />
							</td>
						</tr>						
						<tr>
							<th class="textc" scope="row"><label for="regist_agency_address_en">영문<br />(ENG)</label></th>
							<td>
								<input type="text" name="regist_agency_address_en" id="regist_agency_address_en" title="등록관리자 기관 주소 영문" value="<%out.print(agency_addr_en3);%>" maxlength="200" maxbyte="200" style="ime-mode:disabled;width:100%;" />
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
					<li><a href="#preview" title="(새창으로 이동)" onclick="preView(3);" ><img src="../images/resch/btn_preview.gif" alt="미리보기" /></a></li>
					<% if(sVO.equals("mod", "")){ %>
						<li><a href="./step2.jsp?seq=<c:out value="<%=s_seq%>" />"><img src="../images/resch/btn_prevstep.gif" alt="이전 단계로" /></a></li>
					<% } %>					
					<li><a href="#removeAll" onclick="Remove(3);" ><img src="../images/resch/btn_allcancel.gif" alt="모두 지우기" /></a></li>
					<li><a href="#tempSave" onclick="TempSave(3);" ><img src="../images/resch/btn_storage.gif" alt="임시저장" /></a></li>
				<% if(sVO.equals("mod", "")){ %>
					<li><a href="#save" onclick="Save(3);" ><img src="../images/resch/btn_nextstep2.gif" alt="다음 단계로" /></a></li>
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