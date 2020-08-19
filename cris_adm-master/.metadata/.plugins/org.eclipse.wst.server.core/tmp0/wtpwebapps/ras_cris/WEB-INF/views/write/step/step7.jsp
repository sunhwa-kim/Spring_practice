<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>연구요약 | 임상연구등록</title>
	<%@include file="../include/title.jsp" %>
	<%@include file="../include/write_session.jsp" %>

	<script type="text/javascript" src="../js/common.js"></script>
	<script type="text/javascript" src="../js/write.js"></script>
	<script type="text/javascript" src="../js/byteCheck.js"></script>
	
	<script type="text/javascript">
	function entCheck(evt)
	{
		if(evt.keyCode==13)
		{
			evt.returnValue=false;
		}
	}
	
	</script>
	
</head>
<body>
<%

	ValueObject sVO = new ValueObject();
	ValueObject vo = new ValueObject();
	String temp = "";
/* 	ValueObject fundingVo = null;
	ValueObject sponsorVo = null; */

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
			vo = QueryAction.getQueryView("CRIS_DATA.step7", sVO);
		}
		
		String s_seq = sVO.get("seq");
		String v_seq = vo.getInputbox("seq");
		String v_status = vo.getInputbox("status");
		String v_seq_group = vo.getInputbox("seq_group");
		String v_mod = sVO.getInputbox("mod");
		String research_title_kr = StringUtil.getTitleLimit(vo.getInputbox("research_title_kr"),83);
		String v_research_summary_kr = vo.getInputbox("research_summary_kr");
		String v_research_summary_en = vo.getInputbox("research_summary_en");
		
		//dddddddddddddd
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
				<h3><img src="../images/resch/tit2014_wstep07.gif" alt="7. 연구요약 (Study Summary)" /></h3>
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
				<table cellspacing="0" cellpadding="0" border="0" summary="연구요약으로 구성된 연구요약 정보 입력테이블입니다.">
					<caption>연구요약 정보 입력</caption>
					<colgroup>
						<col width="200px" /><col width="100px" /><col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th rowspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />연구요약
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(6,1);"><img src="../images/resch/icon2014_help.png" alt="연구요약 설명" class="img_set" /></a><br />
							(Lay Summary)</th>
							<th class="textc borderset" scope="row"><label for="research_summary_kr">국문<br />(KOR)</label></th>
							<td class="borderset">
								연구목적, 배경, 가설 및 임상연구계획에 대한 간략한 설명<br />
								<div class="resch_inset">
									<p>(<span id="byte_research_summary_kr">0</span>/4000Byte)</p><br />
									<textarea name="research_summary_kr" id="research_summary_kr" title="연구요약 국문" maxlength="4000" maxByte="4000" onKeyDown="byteCheck(this.id,4000);" onKeyUp="byteCheck(this.id,4000);" onChange="byteCheck(this.id,4000);" style="ime-mode:active;width:100%;height:100px;"><%out.print(v_research_summary_kr); %></textarea>
									<% if(!vo.getInputbox("research_summary_kr").equals("")){%><script type="text/javascript">byteCheck("research_summary_kr",4000);</script><%}%>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc" scope="row"><label for="research_summary_en">영문<br />(ENG)</label></th>
							<td>
								<div class="resch_inset">
									<p>(<span id="byte_research_summary_en">0</span>/4000Byte)</p><br />
									<textarea name="research_summary_en" id="research_summary_en" title="연구요약 영문" maxlength="4000" maxByte="4000" onKeyDown="byteCheck(this.id,4000);" onKeyUp="byteCheck(this.id,4000);" onChange="byteCheck(this.id,4000);" style="ime-mode:disabled;width:100%;height:100px;"><%out.print(v_research_summary_en); %></textarea>
									<% if(!vo.getInputbox("research_summary_en").equals("")){%><script type="text/javascript">byteCheck("research_summary_en",4000);</script><%}%>
								</div>
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
					<li><a href="#preview" title="(새창으로 이동)"  onclick="preView(7);" ><img src="../images/resch/btn_preview.gif" alt="미리보기" /></a></li>
					<% if(sVO.equals("mod", "")){ %>
						<li><a href="./step5.jsp?seq=<c:out value="<%=s_seq%>" />"><img src="../images/resch/btn_prevstep.gif" alt="이전 단계로" /></a></li>
					<% } %>					
					<li><a href="#removeAll" onclick="Remove(7);" ><img src="../images/resch/btn_allcancel.gif" alt="모두 지우기" /></a></li>
					<li><a href="#tempSave" onclick="TempSave(7);" ><img src="../images/resch/btn_storage.gif" alt="임시저장" /></a></li>
				<% if(sVO.equals("mod", "")){ %>
					<li><a href="#save" onclick="Save(7);" ><img src="../images/resch/btn_nextstep2.gif" alt="다음 단계로" /></a></li>
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