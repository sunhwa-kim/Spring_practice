<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>연구개요 | 임상연구등록</title>
	<script type="text/javascript" src="../js/common.js"></script>
	<script type="text/javascript" src="../js/write.js"></script>
	<script type="text/javascript" src="../js/byteCheck.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function (){	
		lf_etc_system_check();	 
	});
	
	function lf_etc_system_check()
	{
		if(($("#status").val()=='5' || $("#status").val()=='6'))
		{
			if($("input:radio[name=etc_system_regist_yn]:checked").val()=="Y")
			{
				$("input:radio[name=etc_system_regist_yn]:not(:checked)").attr("disabled",true);
				//$("#etc_system_regist_yn_N").hide();
				//$("#etc_system_regist_yn_N_la").hide();
				
				lf_etc_num();
			}
		}
	}
	  
	function lf_etc_num()
	{
		$("input:checkbox[name=etc_system_regist]:checked").attr("onclick","");		
		$("input:checkbox[name=etc_system_regist]:checked").hide();
		$("input:checkbox[name=etc_system_regist]:checked").parent().parent().children("input:text").css("background-color","#EFEFEF");
		$("input:checkbox[name=etc_system_regist]:checked").parent().parent().children("input:text").attr("readonly", true);
		//$("input:checkbox[name=etc_system_regist]:checked").parent().parent().children().children("input:text").attr("readonly", true);
		
		//alert($("#etc_system_regist").attr("checked",true));
		if($("#etc_system_regist_6").attr("checked")=="checked")
		{
			$("#etc_system_etc").attr("readonly",true);
			$("#etc_system_number_6").attr("readonly",true);
			$("#etc_system_etc").css("background-color","#EFEFEF");
			$("#etc_system_number_6").css("background-color","#EFEFEF");
			
		}
	}
	
		function entCheck(evt)
		{
			if(evt.keyCode==13)
			{
				evt.returnValue=false;
			}
		}

	</script>
</head>
<div id="wrapper" style="height: 1000px;">
		<div class="cris_inpset">
			<div class="cris_inpbox">
		
			<div id="sideB" class="research_tit">
				<h3><img src="../images/resch/tit2014_wstep01.gif" alt="1. 연구개요 (Background)" /></h3>
			</div>
			<div class="research_tb">
				<table cellspacing="0" cellpadding="0" border="0" summary="연구고유번호, 요약제목, 연구제목, 연구약어명, 식약처규제연구, IND/IDE Protocol 여부, 타등록시스템 등록여부, 등록시스템선택으로 구성된 연구개요 입력테이블입니다.">
					<caption>연구개요입력</caption>
					<colgroup>
						<col width="170px" /><col width="100px" /><col width="*" />
					</colgroup>
					<tbody>
						<tr>                                              
							<th colspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" /><label for="research_number">연구고유번호</label>
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(1,1);" ><img src="../images/resch/icon2014_help.png" alt="연구고유번호 설명" class="img_set" /></a><br />
							(Unique Protocol ID)</th>
							<td>연구기관에서 부여한 임상연구의 고유번호 (예) NCS-09-266<br />※ 별도의 고유번호가 없는 경우 제출한 IRB 심의결과통보서에 나와 있는 과제번호 또는 승인번호 입력<br /> 
							<input type="text" id="research_number" name="research_number" maxByte="20" maxlength="35" value="" style="width:300px;" />
							</td>
						</tr>				
						<tr>
							<th rowspan="2" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />요약제목
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(1,2);"><img src="../images/resch/icon2014_help.png" alt="요약제목 설명" class="img_set" /></a><br />
							(Public/Brief Title)</th>
							<th class="textc borderset" scope="row"><label for="summary_title_kr">국문<br />(KOR)</label></th>
							<td class="borderset">일반인이 이해할 수 있는 수준의 연구 요약제목
								<div class="resch_inset">
									<p>(<span id="byte_summary_title_kr">0</span>/2000Byte)</p><br />
									<input type="text" name="summary_title_kr" id="summary_title_kr" title="요약제목 국문" value="" onKeyDown="byteCheck(this.id,2000);" onKeyUp="byteCheck(this.id,2000);" onChange="byteCheck(this.id,2000);"  style="ime-mode:active;width:100%;" />
									<script type="text/javascript">byteCheck("summary_title_kr",2000);</script>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc" scope="row"><label for="summary_title_en">영문<br />(ENG)</label></th>
							<td>
								<div class="resch_inset">
									<p>(<span id="byte_summary_title_en">0</span>/2000Byte)</p><br />
									<input type="text" name="summary_title_en" id="summary_title_en" title="요약제목 영문" value="" onKeyDown="byteCheck(this.id,2000);" onKeyUp="byteCheck(this.id,2000);" onChange="byteCheck(this.id,2000);" style="ime-mode:disabled;width:100%;" />
								</div>
							</td>
						</tr>
						<tr>
							<th rowspan="2" scope="row"><img src="../images/resch/icon2014_whoictrp.png" alt="WHO ICTRP 필수항목" />연구제목
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(1,3);"><img src="../images/resch/icon2014_help.png" alt="연구제목 설명" class="img_set" /></a><br />
							(Scientific Title)</th>
							<th class="textc borderset" scope="row"><label for="research_title_kr">국문<br />(KOR)</label></th>
							<td class="borderset">연구계획서의 공식적인 제목 (임상연구윤리심의위원회(IRB) 승인서의 제목과 동일해야 함.)<br />
								<div class="resch_inset">
									<p>(<span id="byte_research_title_kr">0</span>/10000Byte)</p><br />
									<textarea name="research_title_kr" id="research_title_kr"  title="연구제목 국문" onKeyDown="entCheck(event);byteCheck(this.id,10000);"  onKeyUp="byteCheck(this.id,10000);" onChange="byteCheck(this.id,10000);" style="ime-mode:active;width:100%;height:50px;" ></textarea>
								</div>
							</td>
						</tr>
						<tr>
							<th class="textc" scope="row"><label for="research_title_en">영문<br />(ENG)</label></th>
							<td>
								<div class="resch_inset">
									<p>(<span id="byte_research_title_en">0</span>/10000Byte)</p><br />
									<textarea name="research_title_en" id="research_title_en"  title="연구제목 영문" onKeyDown="entCheck(event);byteCheck(this.id,10000);" onKeyUp="byteCheck(this.id,10000);" onChange="byteCheck(this.id,10000);" style="ime-mode:disabled;width:100%;height:50px;"></textarea>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">연구약어명
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(1,4);"><img src="../images/resch/icon2014_help.png" alt="연구약어명 설명" class="img_set" /></a><br />
							(Acronym)</th>
							<th class="textc" scope="row"><label for="research_abb_en">영문<br />(ENG)</label></th>
							<td>해당 임상연구명칭에 대한 약어 또는 약칭<br />
								<div class="resch_inset">
									<p>(<span id="byte_research_abb_en">0</span>/2000Byte)</p><br />
									<input type="text" name="research_abb_en" id="research_abb_en" title="연구약어명 영문" value="" maxByte="200" maxlength="200" class="reinput4" onKeyDown="byteCheck(this.id,2000);" onKeyUp="byteCheck(this.id,2000);" onChange="byteCheck(this.id,2000);"  style="ime-mode:disabled;width:100%;" />
								</div>
							</td>
						</tr>
						<tr>
							<th colspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />식약처규제연구
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(1,5);"><img src="../images/resch/icon2014_help.png" alt="식약처규제연구 설명" class="img_set" /></a><br />
							(MFDS Regulated Study)</th>
							<td>식약처(MFDS)장으로부터 연구계획에 대한 승인을 받아야 하는 연구(임상시험)인지 여부<br />
								<input type="radio" name="fda_regulated_investigate_yn" id="fda_regulated_investigate_yn_Y"  value="Y" /><label for="fda_regulated_investigate_yn_Y">예(Yes)</label>
								<input type="radio" name="fda_regulated_investigate_yn" id="fda_regulated_investigate_yn_N"  value="N" /><label for="fda_regulated_investigate_yn_N">아니오(No)</label>
							</td>
						</tr>
						<tr>
							<th colspan="2" scope="row">IND/IDE Protocol 여부
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(1,6);"><img src="../images/resch/icon2014_help.png" alt="IND/IDE Protocol 여부 설명" class="img_set" /></a><br />
							</th>
							<td>
								<input type="radio" name="ind_ide_protocol_yn" id="ind_ide_protocol_yn_Y"  value="Y" /><label for="ind_ide_protocol_yn_Y">예(Yes)</label>
								<input type="radio" name="ind_ide_protocol_yn" id="ind_ide_protocol_yn_N"  value="N" /><label for="ind_ide_protocol_yn_N">아니오(No)</label>
							</td>
						</tr>
						<tr>
							<th colspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />타등록시스템 등록여부
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(1,7);"><img src="../images/resch/icon2014_help.png" alt="타등록시스템 등록여부 설명" class="img_set" /></a><br />
							(Registered at Other Registry)
							</th>
							<td>
								<input type="radio" name="etc_system_regist_yn" id="etc_system_regist_yn_Y"  value="Y" onclick="step1_etc_system_regist_yn();"  /><label for="etc_system_regist_yn_Y">예(Yes)</label>
								<input type="radio" name="etc_system_regist_yn" id="etc_system_regist_yn_N"  value="N" onclick="step1_etc_system_regist_yn();" /><label for="etc_system_regist_yn_N">아니오(No)</label>
							</td>
						</tr>
						<tr>
							<th colspan="2" rowspan="6" scope="row">등록시스템 선택
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(1,8);"><img src="../images/resch/icon2014_help.png" alt="등록시스템 선택 설명" class="img_set" /></a><br />
							(Name of Registry & Registration Number)
							</th>
							<td><span class="tbwidth_set"><input type="checkbox" name="etc_system_regist" id="etc_system_regist_1" value="1" onclick="step1_etc_system_c(1)" /><label for="etc_system_regist_1">ClinicalTrials.gov</label></span>
							<label for="etc_system_number_1" class="dp_no">ClinicalTrials.gov 등록번호</label>
							<input type="text" name="etc_system_number" id="etc_system_number_1" value="" maxlength="11" style="ime-mode:disabled;width:200px;" /> ex) NCT00000000</td>
						</tr>
						<tr>
							<td><span class="tbwidth_set"><input type="checkbox" name="etc_system_regist" id="etc_system_regist_2" value="2" onclick="step1_etc_system_c(2)" /><label for="etc_system_regist_2">ANZCTR</label></span>
							<label for="etc_system_number_2" class="dp_no">ANZCTR 등록번호</label>
							<input type="text" name="etc_system_number" id="etc_system_number_2" value="" maxlength="19" style="ime-mode:disabled;width:200px;"  /> ex) ACTRN12614000000000</td>
						</tr>
						<tr>
							<td><span class="tbwidth_set"><input type="checkbox" name="etc_system_regist" id="etc_system_regist_3" value="3" onclick="step1_etc_system_c(3)" /><label for="etc_system_regist_3">UMIN</label></span>
							<label for="etc_system_number_3" class="dp_no">UMIN 등록번호</label>
							<input type="text" name="etc_system_number" id="etc_system_number_3" value="" maxlength="13" style="ime-mode:disabled;width:200px;"  /> ex) UMIN000000000</td>
						</tr>
						<tr>
							<td><span class="tbwidth_set"><input type="checkbox" name="etc_system_regist" id="etc_system_regist_4" value="4" onclick="step1_etc_system_c(4)" /><label for="etc_system_regist_4">ISRCTN</label></span>
							<label for="etc_system_number_4" class="dp_no">ISRCTN 등록번호</label>
							<input type="text" name="etc_system_number" id="etc_system_number_4" value="" maxlength="14" style="ime-mode:disabled;width:200px;"  /> ex) ISRCTN00000000</td>
						</tr>
						<tr>
							<td><span class="tbwidth_set"><input type="checkbox" name="etc_system_regist" id="etc_system_regist_5" value="5" onclick="step1_etc_system_c(5)" /><label for="etc_system_regist_5">UTN</label></span>
							<label for="etc_system_number_5" class="dp_no">UTN 등록번호</label>
							<input type="text" name="etc_system_number" id="etc_system_number_5" value="" maxlength="14" style="ime-mode:disabled;width:200px;"  /> ex) U111-0000-0000</td>
						</tr>
						<tr>
							<td><span class="tbwidth_set"><input type="checkbox" name="etc_system_regist" id="etc_system_regist_6" value="6" onclick="step1_etc_system_etc()" /><label for="etc_system_regist_6">Other</label></span>
							<span id="etc_system_div" style="display:none" >
								<label for="etc_system_etc" class="magset1">등록시스템</label><input type="text" name="etc_system_etc" id="etc_system_etc" value="" maxByte="200" maxlength="200" style="width:150px;" />
								<label for="etc_system_number_6" class="magset">등록번호</label><input type="text" name="etc_system_number" id="etc_system_number_6" value="" maxlength="20" style="ime-mode:disabled;width:150px;" />
							</span></td>
						</tr>
						<tr>
							<th colspan="2" scope="row"><img src="../images/resch/icon2014_cris.png" alt="CRIS 필수항목" />임상연구 요양급여 적용 신청 여부
							<a href="#helppop" title="(새창으로 이동)" onclick="javascript:helpPop(1,9);"><img src="../images/resch/icon2014_help.png" alt="임상연구 요양급여 적용 신청 여부 설명" class="img_set" /></a><br />
							(Healthcare Benefit Approval Status)</th>
							<td>
								<input type="radio" name="hcb_approval_status" id="hcb_approval_status_n"  value="N" /><label for="hcb_approval_status_n">해당연구 아님(Not applicable)</label>
								<input type="radio" name="hcb_approval_status" id="hcb_approval_status_p"  value="P" /><label for="hcb_approval_status_p">신청 중(Submitted pending)</label>
								<input type="radio" name="hcb_approval_status" id="hcb_approval_status_a"  value="A" /><label for="hcb_approval_status_a">신청 후 승인(Submitted approval)</label>
								<br /><span style="padding:0px 0px 0px 5px;line-height:230%;color:#FF1111">* 요양급여 적용 결정 신청을 준비 중이거나, 신청 후 아직 승인 결정되지 않은 경우 ‘신청 중’ 선택해주십시오.</span>
								<br /><span style="padding:0px 0px 0px 5px;line-height:200%;">※ 신청 후 적용 결정되면 반드시 정보 변경해주십시오.</span>
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
					<li><a href="#preview" title="(새창으로 이동)" onclick="preView(1);" ><img src="../images/resch/btn_preview.gif" alt="미리보기" /></a></li>
					<li><a href="#removeAll" onclick="Remove(1);" ><img src="../images/resch/btn_allcancel.gif" alt="모두 지우기" /></a></li>
					<li><a href="#tempSave" onclick="TempSave(1);" ><img src="../images/resch/btn_storage.gif" alt="임시저장" /></a></li>			
				</ul>
			</div>

		</div><!-- cris_inpbox -->
		</div><!-- container -->

</div>