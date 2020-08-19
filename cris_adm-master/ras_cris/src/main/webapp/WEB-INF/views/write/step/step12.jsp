<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.buildnine.util.VOSet"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>연구공유 | 임상연구등록</title>
	<%@include file="../include/title.jsp" %>
	<%@include file="../include/write_session.jsp" %>

	<script type="text/javascript" src="../js/common.js"></script>
	<script type="text/javascript" src="../js/write.js"></script>
	<script type="text/javascript" src="../js/byteCheck.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function (){	
		
		lf_share_yn();
		lf_share_method();

		$('[name=share_yn]').click(function(){
			lf_share_yn();
		});		
		
		$('#share_method').change(function(){
			lf_share_method();
		}); 	
	});
	
	function lf_share_yn()
	{
		if($('#share_yn_y').prop('checked')==true)
		{
			$('#share_expect_year').prop('disabled', false);
			$('#share_expect_year').css('background', '');	
			$('#share_expect_month').prop('disabled', false);
			$('#share_expect_month').css('background', '');	
			$('#share_method').prop('disabled', false);
			$('#share_method').css('background', '');	
		}
		else
		{
			$('#share_expect_year').val('');	
			$('#share_expect_year').prop('disabled', true);	
			$('#share_expect_year').css('background', '#dddddd');	
			$('#share_expect_month').val('');	
			$('#share_expect_month').prop('disabled', true);		
			$('#share_expect_month').css('backgroundColor', '#dddddd');	
			
			$('#share_method').val('');	
			$('#share_method').prop('disabled', true);
			$('#share_method').css('background', '#dddddd');
			$('#share_method_etc').val('');
			$('#share_method_etc').prop("placeholder","");
			$('#share_method_etc').prop('disabled', true);
			$('#share_method_etc_en').val('');
			$('#share_method_etc_en').prop("placeholder","");
			$('#share_method_etc_en').prop('disabled', true);
		}
	}
	
	function lf_share_method()
	{
		$('#share_method_etc').val("");
		$('#share_method_etc_en').val("");
		if($('#share_method').val()!="")
		{
			if($('#share_method').val()==3 || $('#share_method').val()==4)
			{
					$('#share_method_etc').attr("placeholder","URL 입력");
					$('#share_method_etc_en').attr("placeholder","URL 입력");
					$('#share_method_etc').prop('disabled', false);
					$('#share_method_etc_en').prop('disabled', false);		
			}
			else
			{
				if($('#share_method').val()==1)
				{
					$('#share_method_etc').attr("placeholder","담당자 이메일 주소");
					$('#share_method_etc_en').attr("placeholder","담당자 이메일 주소");					
				}
				else if($('#share_method').val()==2)
				{
					$('#share_method_etc').attr("placeholder","불가능 사유");
					$('#share_method_etc_en').attr("placeholder","불가능 사유");					
				}
				else if($('#share_method').val()==5)
				{   
					$('#share_method_etc').attr("placeholder","관련 질문에 답변이 가능한 담당자 연락처(이메일)");
					$('#share_method_etc_en').attr("placeholder","관련 질문에 답변이 가능한 담당자 연락처(이메일)");					
				}else if($('#share_method').val()==7)
				{   
					$('#share_method_etc').attr("placeholder","");
					$('#share_method_etc_en').attr("placeholder","");					
				}					
				$('#share_method_etc').prop('disabled', false);
				$('#share_method_etc_en').prop('disabled', false);  
			}
 		}
		else
		{
			$('#share_method_etc').prop("placeholder","");
			$('#share_method_etc').prop('disabled', true);	
			$('#share_method_etc_en').prop("placeholder","");
			$('#share_method_etc_en').prop('disabled', true);				
		}
	}
	</script>
</head>
<body onload="RemoveForm(12);">
<%
	ValueObject sVO = new ValueObject();
	ValueObject vo = new ValueObject();

	String msgChk = "Y";
	String temp = "";
	try {

		sVO.set(request);
		
		//GST_kdh_20181112 자신이 작성한 연구인지 확인 절차 추가
		String myin = "";
		sVO.put("rid",(String)session.getAttribute("session_userid"));
		myin = QueryAction.getQueryColumn("CRIS_DATA.myinter", sVO);

		if(myin.equals("") || myin==null) {
			out.println(StringUtil.alert("삭제되었거나 존재하지 않는 게시물입니다.","/cris"));
			return;
		}
		
		if( !sVO.equals("seq", "")){
			vo = QueryAction.getQueryView("CRIS_DATA.step12", sVO);
			if( vo.getInt("status") > 3 )
			{
				msgChk = "N";
			}
		}

		//공유예상시기 년도
		String syearField = "";
		syearField += "<select name='share_expect_year' id='share_expect_year' style='width:70px;' title='공유예상시기 연도 선택'>";
		syearField += "<option value=''>년도</option>";
		int startyear = StringUtil.toInt(StringUtil.getYear());
		if(vo.getInt("share_expect_year")>0) {
			startyear = vo.getInt("share_expect_year");
		}
		for(int y=startyear-1; y<(startyear+30); y++)
		{
			syearField += "<option value='"+y+"' "+(vo.getInt("share_expect_year")==y?"selected":"")+">"+y+"년</option>";
		}
		syearField += "</select>";		
		
		//공유예상시기 월
		String smonthField = "";
		smonthField += "<select name='share_expect_month' id='share_expect_month' style='width:70px;' title='공유예상시기 월 선택'>";
		smonthField += "<option value=''>월</option>";
		for(int m=1; m<13; m++)
		{
			smonthField += "<option value='"+m+"' "+(vo.getInt("share_expect_month")==m?"selected":"")+">"+m+"월</option>";
		}
		smonthField += "</select>";
				
		//공유방법
		String shareField = "";

		sVO.put("code_grp", "SHAREMETH");
		VOSet shareList = QueryAction.getQueryList("CODE.cmcd_list", sVO);
		
		ValueObject so;
		shareField += "<select name='share_method' id='share_method' style='width:150px;' title='공유방법 선택'>";
		shareField += "<option value=''>선택</option>";
		if(shareList!=null && shareList.size()>0)
		{
			for(int i=0; i<shareList.size(); i++)
			{
				so = shareList.get( i ) ;
				if(!"2".equals(so.getInputbox("code_id"))){
					shareField += "<option value='"+so.getInputbox("code_id")+"' "+(vo.getInputbox("share_method").equals(so.getInputbox("code_id"))?"selected":"")+">"+so.getInputbox("code_name")+"</option>";
				}
			}
		}
		shareField += "</select>";
		
		String s_research_title_kr = StringUtil.getTitleLimit(vo.getInputbox("research_title_kr"),83);
		String s_seq = vo.getInputbox("seq");
		String s_status = vo.getInputbox("status");
		String s_seq_group = vo.getInputbox("seq_group");
		String s_version = vo.getInputbox("version");
		String s_version_temp = vo.getInputbox("version_temp");
		String str_mod = sVO.getInputbox("mod");
		String s_share_y = vo.equals("share_yn", "Y")?"checked":"";
		String s_share_n = vo.equals("share_yn", "N")?"checked":"";
		String s_share_method_etc = vo.getInputbox("share_method_etc");
		String s_share_method_etc_en = vo.getInputbox("share_method_etc_en");
		String str_seq = sVO.get("seq");
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
				<h3><img src="../images/resch/tit2014_wstep12.gif" alt="12. 연구데이터 공유(익명화된 연구대상자 데이터)(Sharing of Study Data(Deidentified Individual-Patient Data, IPD))" /></h3>
			</div>
			<div class="research_tb">
			
			<iframe name="iframe" title="의미없는 아이프레임" style="display:none;" width="0" height="0"></iframe>
			<form name="form" id="form" method="post"  onsubmit="return false;">
			<input type="hidden" name="seq" 			id="seq" 			value="<c:out value="<%=s_seq%>" />" />
			<input type="hidden" name="status" 			id="status" 		value="<c:out value="<%=s_status%>" />" />
			<input type="hidden" name="seq_group"		id="seq_group" 		value="<c:out value="<%=s_seq_group%>" />" />
			<input type="hidden" name="version"			id="version" 		value="<c:out value="<%=s_version%>" />" />
			<input type="hidden" name="version_temp"	id="version_temp" 	value="<c:out value="<%=s_version_temp%>" />" />
			<input type="hidden" name="mode" 			id="mode" 			value="" />
			<input type="hidden" name="mod" id="mod" value="<c:out value="<%=str_mod%>" />" />   
			<input type="hidden" name="step" id="step" />  
			<input type="hidden" name="title" 			id="title" 			value="<c:out value="<%=s_research_title_kr %>" />" />			
			
				<table cellspacing="0" cellpadding="0" border="0" summary="연구데이터공유계획 입력테이블입니다.">
					<caption>연구데이터공유계획 입력</caption>
					<colgroup>
						<col width="140px" /><col width="170px" /><col width="60px" /><col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th colspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />연구데이터 공유 계획
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(12,1);"><img src="../images/resch/icon2014_help.png" alt="결과 공유 계획(Sharing Statement) 설명" class="img_set" /></a>
							<br />
							(Study Data Sharing Plan)
							</th>
							<td colspan="2">
								<input type="radio" name="share_yn" id="share_yn_y" <c:out value="<%=s_share_y %>" /> value="Y"><label for="share_yn_y">예(Yes)</label>
								<input type="radio" name="share_yn" id="share_yn_n" <c:out value="<%=s_share_n %>" /> value="N"><label for="share_yn_n">아니오(No)</label>
								<%-- <input type="radio" name="share_yn" id="share_yn_u" <%=vo.equals("share_yn", "U")?"checked":"" %> value="U"><label for="share_yn_u">미정(Undecided)</label> --%>
							</td>
						</tr>
						<tr>
							<th colspan="2" scope="row"><label for="share_expect_year">공유예상 시기</label>
							<br />
							(Time of Sharing)						
							</th>						
							<td colspan="2">
								<c:out value="<%=syearField %>" escapeXml="false" />
								<c:out value="<%=smonthField %>"  escapeXml="false" />
							</td>
						</tr>
						<tr>
							<th rowspan="2" scope="row"><label for="share_method">공유방법</label>
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(12,3);"><img src="../images/resch/icon2014_help.png" alt="공유방법(Way of Sharing) 설명" class="img_set" /></a>
							<br />
							(Way of Sharing)
							</th>								
							<td rowspan="2" class="textc borderset01">
								<c:out value="<%=shareField %>" escapeXml="false" />
							</td>
							<td class="textc borderset borderset01">
								<label for="share_method_etc" class="magset2">국문<br />(KOR)</label>	
							</td>
							<td>
								<input type="text" name="share_method_etc" placeholder="" id="share_method_etc" title="공유방법을 상세내용 국문을 입력하세요" value="<%out.print(s_share_method_etc); %>" maxlength="250" style="width:550px;" />
							</td>
						</tr>
						<tr>
							<td class="textc borderset borderset01">
								<label for="share_method_etc_en" class="magset2">영문<br />(ENG)</label>	
							</td>
							<td>
								<input type="text" name="share_method_etc_en" placeholder="" id="share_method_etc_en" title="공유방법을 상세내용 영문을 입력하세요" value="<%out.print(s_share_method_etc_en); %>" maxlength="250" style="ime-mode:disabled;width:550px;" />
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

			<% if (msgChk == "Y"){ %>
			<span class="sptxt">모든 내용을 작성·저장 후 나의임상연구에서 '제출' 버튼을 클릭하셔야 관리자에게 최종 제출되어집니다.</span><br /><br />
			<% } %>	
			
			<div class="res_btnbox">		
				<ul class="research_btn">
					<li><a href="#preview" title="(새창으로 이동)" onclick="preView(12);" ><img src="../images/resch/btn_preview.gif" alt="미리보기" /></a></li>
					<% if(sVO.equals("mod", "")){ %>
						<li><a href="./step11.jsp?seq=<c:out value="<%=str_seq%>" />" ><img src="../images/resch/btn_prevstep.gif" alt="이전 단계로" /></a></li>
					<% } %>					
					<li><a href="#removeAll" onclick="Remove(12);" ><img src="../images/resch/btn_allcancel.gif" alt="모두 지우기" /></a></li>
					<li><a href="#tempSave" onclick="TempSave(12);" ><img src="../images/resch/btn_storage.gif" alt="임시저장" /></a></li>
					<li><a href="#cancel" onclick="javascript:fn_cancel('<c:out value="<%=str_seq%>" />')" ><img src="../images/resch/btn_cancel2.gif" alt="취소" /></a></li>				
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