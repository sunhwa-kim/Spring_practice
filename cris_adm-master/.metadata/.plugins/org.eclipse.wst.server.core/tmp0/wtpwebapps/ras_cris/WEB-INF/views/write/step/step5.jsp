<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.buildnine.util.VOSet"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>연구비지원기관ㆍ연구책임기관 | 임상연구등록</title>
<%@include file="../include/title.jsp" %>
<%@include file="../include/write_session.jsp" %>

<script type="text/javascript" src="../js/common.js"></script>
<script type="text/javascript" src="../js/write.js"></script>

<script type="text/javascript">
<!--
	function jsMulti5(str,idx)
	{  
		cnt = document.form.funding_count.value;
		if(str == "add")
		{
			sum = eval(cnt) + eval("1");
			for( var i = eval(idx)+eval("1"); i <= 50; i++) {
				if(document.getElementById("funding_"+i).style.display == "none")
				{
					document.getElementById("funding_"+i).style.display = "block";
					break;
				}
			}
		}
		else
		{
			if(cnt==1)
			{
				alert("하나이상의 연구비지원기관이 필요합니다.");
				return;
				//sum = eval(cnt);
			}
			else
			{
				sum = eval(cnt) - eval("1");
				document.getElementById("funding_"+eval(idx)+"_agency_name_kr").value='';
				document.getElementById("funding_"+eval(idx)+"_agency_name_en").value='';
				document.getElementById("funding_"+eval(idx)+"_agency_group").value='';
				document.getElementById("funding_"+eval(idx)+"_research_subject_number").value='';
				
				document.getElementById("funding_"+idx).style.display = "none";
			}
		}
		document.form.funding_count.value = sum;

		//step5_funding_count();
	}
		
	function jsMulti6(str,idx)
	{
		cnt = document.form.sponsor_count.value;
		if(str == "add")
		{
			sum = eval(cnt) + eval("1");
			for( var i = eval(idx)+eval("1"); i <= 50; i++) {
				if(document.getElementById("sponsor_"+i).style.display == "none")
				{
					document.getElementById("sponsor_"+i).style.display = "block";
					break;
				}
			}
		}
		else
		{
			if(cnt==1)
			{
				alert("하나이상의 연구책임기관이 필요합니다.");
				return;
				//sum = eval(cnt);
			}
			else
			{
				sum = eval(cnt) - eval("1");
				document.getElementById("sponsor_"+eval(idx)+"_agency_name_kr").value='';
				document.getElementById("sponsor_"+eval(idx)+"_agency_name_en").value='';
				document.getElementById("sponsor_"+eval(idx)+"_agency_group").value='';
	
				document.getElementById("sponsor_"+idx).style.display = "none";
			}
		}
		document.form.sponsor_count.value = sum;
		//step5_sponsor_count();
	}
	
	function fn_agSearch( pre ){
		var AgSearch = window.open("../pop/ag_search.jsp?apre="+pre, "AgSearch", "width=550px, height=535px, left=200px, top=100px");
		AgSearch.focus();
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
//-->
</script>
</head>
<body onLoad="RemoveForm(5);">
<%	
	ValueObject sVO = new ValueObject();	
	ValueObject vo = new ValueObject();	
	String temp = "";
	VOSet fundingList = new VOSet();	
	ValueObject fundingVo = null;	
	VOSet sponsorList = new VOSet();	
	ValueObject sponsorVo = null;
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
			vo = QueryAction.getQueryView("CRIS_DATA.step5", sVO);			
			sVO.put("gubun", "FUNDING");			
			fundingList = QueryAction.getQueryList("CRIS_DATA.agency_list", sVO);			
			sVO.put("gubun", "SPONSOR");			
			sponsorList = QueryAction.getQueryList("CRIS_DATA.agency_list", sVO);		
		}
		//GST_kdh_20121012 미사용 항목 삭제
		//VOSet nationList = QueryAction.getQueryList("CODE.nation_list2", sVO);
		sVO.put("code_grp", "AGENCYGR");		
		VOSet agencyGrList = QueryAction.getQueryList("CODE.cmcd_list", sVO);
		//VOSet agency = QueryAction.getQueryList("CODE.agency", sVO);
		
		int fCnt = fundingList.size();
		int sCnt = sponsorList.size();

		String s_seq = sVO.get("seq");
		String v_seq = vo.getInputbox("seq");
		String v_status = vo.getInputbox("status");
		String v_seq_group = vo.getInputbox("seq_group");
		String v_mod = sVO.getInputbox("mod");
        int str_fcnt =  fCnt == 0 ? 1 : fCnt;
        int str_sCnt =  sCnt == 0 ? 1 : sCnt;
		String research_title_kr = StringUtil.getTitleLimit(vo.getInputbox("research_title_kr"),83);
		
		
		
		///ddddddddddddddd
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

			<iframe name="iframe" title="의미없는 아이프레임" style="display:none;" width="0" height="0"></iframe>
			<form name="form" id="form" method="post">
	        <input type="hidden" name="seq" 	id="seq" 	value="<c:out value="<%=v_seq%>" />" />
	        <input type="hidden" name="status" 	id="status" value="<c:out value="<%=v_status%>" />" />
	        <input type="hidden" name="seq_group"	id="seq_group" 	value="<c:out value="<%=v_seq_group%>" />" />
	        <input type="hidden" name="mode" id="mode" 	value="" />
			<input type="hidden" name="mod" id="mod" value="<c:out value="<%=v_mod%>" />" />
	        <input type="hidden" name="funding_count" id="funding_count" value="<c:out value="<%=str_fcnt %>" />">
	        <input type="hidden" name="sponsor_count" id="sponsor_count" value="<c:out value="<%=str_sCnt %>" />">
			<input type="hidden" name="step" id="step" />	
			<div id="sideB" class="research_tit">
				<h3><img src="../images/resch/tit2014_wstep05.gif" alt="5. 연구비지원기관 (Source of Monetary/Material Support)" /></h3>
			</div>

			<div class="research_tb">
			
			<%
				for( int i = 1; i <= 50; i++) 
				{
					if( fundingList.size() >= i )
					{
						fundingVo = fundingList.get(i-1);
					} else {
						fundingVo = new ValueObject();	
					}
					
					if( !fundingVo.equals("email_domain", "") && strEmail.indexOf(fundingVo.get("email_domain")) == -1 )
					{
						fundingVo.put("emailDomain", "-");
					}
					String f_class = i==1?"":"class='bobor'";
					String f_name_kr = fundingVo.getInputbox("name_kr");
					String f_name_en = fundingVo.getInputbox("name_en");
					String f_style_1 = !fundingVo.getInputbox("name_kr").trim().equals("")&&fundingVo.getInputbox("name_en").trim().equals("")?"style=\"display:;\"":"style=\"display:none;\"";
					String f_research_subject_number = fundingVo.getInputbox("research_subject_number");
			%>	
				<table <c:out value="<%=f_class%>" /> id="funding_<c:out value="<%=i %>" />" cellspacing="0" cellpadding="0" border="0" summary="기관명, 기관종류, 연구과제번호, 질환별 임상연구센터 과제여부로 구성된 연구비지원기관 입력테이블입니다.">
					<caption>연구비지원기관 정보 입력</caption>
					<colgroup>
						<col width="200px" /><col width="100px" /><col width="*" />
					</colgroup>
					<tbody>		
						<tr>
							<th colspan="3" class="tbtit" scope="col"><c:out value="<%=i%>" />. 연구비지원기관 (Source of Monetary/Material Support)
								<ul class="retb_list">
									<li><a href="#add" onclick="jsMulti5('add','<c:out value="<%=i%>" />')" ><img src="../images/resch/btn2014_add.png" alt="추가" /></a></li>
									<%if(i!=1){%><li><a href="#minus" onclick="jsMulti5('del','<c:out value="<%=i%>" />')" ><img src="../images/resch/btn2014_del.png" alt="삭제" /></a></li><%} %>
								</ul>
							</th>
						</tr>
						<tr>
							<th rowspan="2" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />기관명
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(5,1);"><img src="../images/resch/icon2014_help.png" alt="연구비지원기관명 설명" class="img_set" /></a><br />
							(Organization Name)</th>
							<th class="textc borderset" scope="row"><label for="funding_<c:out value="<%=i%>" />_agency_name_kr">국문<br />(KOR)</label></th>
							<td class="borderset">
								해당연구에 연구비지원 또는 기타 물질적인 지원을 제공하는 기관(기구)의 명칭 (제약회사 혹은 학회등의 연구비지원기관이 없는 경우 책임연구자 소속기관명을 입력바랍니다)<br />
								<div class="resch_inset">
									<input type="text" name="funding_agency_name_kr" id="funding_<c:out value="<%=i%>" />_agency_name_kr" title="연구비지원기관 <c:out value="<%=i%>" /> 기관명 국문" value="<%out.print(f_name_kr); %>" maxlength="200" maxByte="200" readonly style="background:#EFEFEF;width:580px;" />
									<a href="#agsearch" onclick="fn_agSearch('funding_<c:out value="<%=i%>" />_');" ><img src="../images/resch/btn2014_organsearch.png" alt="기관명검색" class="inpimg" /></a>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc" scope="row"><label for="funding_<c:out value="<%=i%>" />_agency_name_en">영문<br />(ENG)</label></th>
							<td>
								<div class="resch_inset">
									<input type="text" name="funding_agency_name_en" id="funding_<c:out value="<%=i%>" />_agency_name_en" title="연구비지원기관 <c:out value="<%=i%>" /> 기관명 영문" value="<%out.print(f_name_en); %>" maxlength="200" maxByte="200" readonly style="background:#EFEFEF;width:580px;" />
									<a href="#agenregway" onclick="fn_enregway();" ><img id="funding_<c:out value="<%=i%>" />_way" src="../images/resch/btn2014_orgen.png" alt="영문명 등록안내" class="inpimg" <c:out value="<%=f_style_1 %>" /> /></a>
								</div>
							</td>
						</tr>
						<tr>
							<th colspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" /><label for="funding_<c:out value="<%=i%>" />_agency_group">기관종류</label>
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(5,2);"><img src="../images/resch/icon2014_help.png" alt="연구비지원기관종류 설명" class="img_set" /></a><br />
							(Organization Type)</th>
							<td>
								<select name="funding_agency_group" id="funding_<c:out value="<%=i%>" />_agency_group" title="연구비지원기관 선택">
									<option value="">:::선택:::</option>
									<% for( int x = 0; x < agencyGrList.size(); x++){ 
										String a_code_name = agencyGrList.get(x).getInputbox("code_name");
										String a_selected = agencyGrList.get(x).getInputbox("code_name").equals(fundingVo.getInputbox("agency_group"))?"selected":"";
									%>
									<option value="<c:out value="<%=a_code_name %>" />" <c:out value="<%=a_selected%>" /> ><c:out value="<%=a_code_name %>" /></option>
									<% } %>									
								</select>
							</td>
						</tr>
						<tr>
							<th colspan="2" scope="row"><label for="funding_<c:out value="<%=i%>" />_research_subject_number">연구과제번호</label>
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(5,3);"><img src="../images/resch/icon2014_help.png" alt="연구과제번호 설명" class="img_set" /></a><br />
							(Project ID)</th>
							<td>연구비 지원기관에서 부여받은 연구과제번호<br />
								<input type="text" name="funding_research_subject_number" id="funding_<c:out value="<%=i%>" />_research_subject_number" value="<%out.print(f_research_subject_number); %>" maxlength="20" maxByte="20" style="width:300px;" />
							</td>
						</tr>
					</tbody>
				</table>
				<% } %>
				<ul class="research_noice">
					<li class="font_red"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />WHO ICTRP (International Clinical Trial Registry Platform)에서 요구하는 필수등록항목입니다.</li>
					<li class="font_blue"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />CRIS 필수등록항목입니다.</li>
				</ul>
			</div>
			
			<div class="research_tit" style="margin:50px 0 5px 0;">
				<h3><img src="../images/resch/tit2014_wstep06.gif" alt="6. 연구책임기관 (Sponsor Organization)" /></h3>
			</div>
			<div class="research_tb">
			
		<%			
			  for( int i = 1; i <= 50; i++) {				
			  if( sponsorList.size() >= i ){					
				  sponsorVo = sponsorList.get(i-1);				
			  } else {					
				  sponsorVo = new ValueObject();				
			  }				
			  if( !sponsorVo.equals("email_domain", "") && strEmail.indexOf(sponsorVo.get("email_domain")) == -1 ){					
				  sponsorVo.put("emailDomain", "-");				
			  }			
				String s_class = i==1?"":"class='bobor'";
				String s_name_kr = sponsorVo.getInputbox("name_kr");
				String s_name_en = sponsorVo.getInputbox("name_en");
				String s_style_1 = !sponsorVo.getInputbox("name_kr").trim().equals("")&&sponsorVo.getInputbox("name_en").trim().equals("")?"style=\"display:;\"":"style=\"display:none;\"";
				String s_research_subject_number = sponsorVo.getInputbox("research_subject_number");
		%>
			
				<table <c:out value="<%=s_class%>" /> id="sponsor_<c:out value="<%=i %>" />" cellspacing="0" cellpadding="0" border="0" summary="기관명, 기관종류로 구성된 연구책임기관 입력테이블입니다.">
					<caption>연구책임기관 정보 입력</caption>
					<colgroup>
						<col width="200px" /><col width="100px" /><col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th colspan="3" class="tbtit" scope="col"><c:out value="<%=i%>" />. 연구책임기관 (Sponsor Organization)
								<ul class="retb_list">
									<li><a href="#add" onclick="jsMulti6('add','<c:out value="<%=i%>" />')" ><img src="../images/resch/btn2014_add.png" alt="추가" /></a></li>
									<%if(i!=1){%><li><a href="#minus" onclick="jsMulti6('del','<c:out value="<%=i%>" />')" ><img src="../images/resch/btn2014_del.png" alt="삭제" /></a></li><%}%>
								</ul>
							</th>
						</tr>
						<tr>
							<th rowspan="2" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />기관명
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(5,5);"><img src="../images/resch/icon2014_help.png" alt="연구책임기관기관명 설명" class="img_set" /></a><br />
							(Organization Name)</th>
							<th class="textc borderset" scope="row"><label for="sponsor_<c:out value="<%=i%>" />_agency_name_kr">국문<br />(KOR)</label></th>
							<td class="borderset">
								임상시험의 계획, 관리, 재정 등에 관련한 책임을 갖고 있는 개인, 회사, 실시기관, 단체(의뢰자주도임상연구(SIT)시는 의뢰기관명을, 연구자주도임상연구(IIT)시는 책임연구자 소속기관명을 입력바랍니다)<br />
								<div class="resch_inset">
									<input type="text" name="sponsor_agency_name_kr" id="sponsor_<c:out value="<%=i%>" />_agency_name_kr" title="연구책임기관 <c:out value="<%=i%>" /> 기관명 국문" value="<%out.print(s_name_kr); %>" maxlength="200" maxByte="200" readonly style="background:#EFEFEF;width:580px;" />
									<a href="#agsearch" title="(새창으로 이동)" onclick="fn_agSearch('sponsor_<c:out value="<%=i%>" />_');" ><img src="../images/resch/btn2014_organsearch.png" alt="기관명검색" class="inpimg" /></a>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc" scope="row"><label for="sponsor_<c:out value="<%=i%>" />_agency_name_en">영문<br />(ENG)</label></th>
							<td>
								<div class="resch_inset">
									<input type="text" name="sponsor_agency_name_en" id="sponsor_<c:out value="<%=i%>" />_agency_name_en" title="연구책임기관 <c:out value="<%=i%>" /> 기관명 영문" value="<%out.print(s_name_en); %>" maxlength="200" maxByte="200" readonly style="background:#EFEFEF;width:580px;" />
									<a href="#agenregway" onclick="fn_enregway();" ><img id="sponsor_<c:out value="<%=i%>" />_way" src="../images/resch/btn2014_orgen.png" alt="영문명 등록안내" class="inpimg" <c:out value="<%=s_style_1 %>" /> /></a>
								</div>
							</td>
						</tr>
						<tr>
							<th colspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" /><label for="sponsor_<c:out value="<%=i%>" />_agency_group">기관종류</label>
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(5,6);"><img src="../images/resch/icon2014_help.png" alt="연구책임기관종류 설명" class="img_set" /></a><br />
							(Organization Type)</th>
							<td>
								<select name="sponsor_agency_group" id="sponsor_<c:out value="<%=i%>" />_agency_group" title="연구책임기관 선택">
									<option value="">:::선택:::</option>
									<% for( int x = 0; x < agencyGrList.size(); x++){ 
										String a_code_name = agencyGrList.get(x).getInputbox("code_name");
										String a_selected = agencyGrList.get(x).getInputbox("code_name").equals(sponsorVo.getInputbox("agency_group"))?"selected":"";
									%>
									<option value="<c:out value="<%=a_code_name %>" />" <c:out value="<%=a_selected%>" /> ><c:out value="<%=a_code_name %>" /></option>
									<% } %>										
								</select>
							</td>
						</tr>
					</tbody>
				</table>
				<% } %>				
				<ul class="research_noice">
					<li class="font_red"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />WHO ICTRP (International Clinical Trial Registry Platform)에서 요구하는 필수등록항목입니다.</li>
					<li class="font_blue"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />CRIS 필수등록항목입니다.</li>
				</ul>
			</div>
			</form>


			<div class="res_btnbox">
				<ul class="research_btn">
					<li><a href="#preview" title="(새창으로 이동)" onclick="preView(5);" ><img src="../images/resch/btn_preview.gif" alt="미리보기" /></a></li>
					<% if(sVO.equals("mod", "")){ %>
						<li><a href="./step4.jsp?seq=<c:out value="<%=s_seq%>" />"><img src="../images/resch/btn_prevstep.gif" alt="이전 단계로" /></a></li>
					<% } %>					
					<li><a href="#removeAll" onclick="Remove(5);" ><img src="../images/resch/btn_allcancel.gif" alt="모두 지우기" /></a></li>
					<li><a href="#tempSave" onclick="TempSave(5);" ><img src="../images/resch/btn_storage.gif" alt="임시저장" /></a></li>
				<% if(sVO.equals("mod", "")){ %>
					<li><a href="#save" onclick="Save(5);" ><img src="../images/resch/btn_nextstep2.gif" alt="다음 단계로" /></a></li>
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

