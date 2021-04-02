<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>my 연구 정보</title>
</head>
<body>
	<h2 style="margin-left: 5%;">my 연구 정보</h2>
	<div class="table_title">1. 연구개요
			<table id=theOutlineOfRsrch>
				<tbody id="theOutlineOfRsrch_tbody"></tbody>
			</table>
	</div>
<!-- 	<input type="button" id="theOutlineOfRsrch_btn" name="" value=""> -->

	<div class="table_title">2. 임상 연구 윤리 심의	
			<table id="theEthicalReview">
				<tbody id="theEthicalReview_tbody"></tbody>
			</table>
	</div>	
	
	<div class="table_title">3. 연구자
		<div class="researcherTbale">
			<table id="theResearcher">
				<thead>연구 책임자</thead>
				<tbody id="theResearcher_tbody"></tbody>
			</table>
			<table id="theWork">
				<thead>연구 실무 담당자</thead>
				<tbody id="theWork_tbody"></tbody>
			</table>
			<table id="theRegist">
				<thead>등록 관리자</thead>
				<tbody id="theRegist_tbody"></tbody>
			</table>
		</div>
	</div>	
	
	<div class="table_title">4. 연구 기관
			<table id="theRsrchInstitiute">
				<tbody id="theRsrchInstitiute_tbody"></tbody>
			</table>
	</div>
	
	<div class="table_title">5. 연구비 지원 기관
			<table id="theRsrchFunding">
				<tbody id="theRsrchFunding_tbody"></tbody>
			</table>
	</div>
	
	<div class="table_title">6. 연구 책임 기관
			<table id="theRsrchResponsibility">
				<tbody id="theRsrchResponsibility_tbody"></tbody>
			</table>
	</div>
	
	<div class="table_title">7. 연구 요약
			<table id="theRsrchSummary">
				<tbody id="theRsrchSummary_tbody"></tbody>
			</table>
	</div>
	
	<div class="table_title">8. 연구 설계
			<table id="theRsrchDesign">
				<tbody id="theRsrchDesign_tbody"></tbody>
			</table>
	</div>
	
	<div class="table_title">9. 대상자 선정 기준
			<table id="theTargetStandard">
				<tbody id="theTargetStandard_tbody"></tbody>
			</table>
	</div>
	
	<div class="table_title">10. 결과 변수
			<table id="theResultVariable">
				<tbody id="theResultVariable_tbody"></tbody>
			</table>
	</div>
	
	<div class="table_title">11. 연구 결과 및 발표
			<table id="theAnnouncement">
				<tbody id="theAnnouncement_tbody"></tbody>
			</table>
	</div>
	
	<div class="table_title">12. 연구 데이터 공유
			<table id="theDataSharing">
				<tbody id="theDataSharing_tbody"></tbody>
			</table>
	</div>
	
		<div id="shTest"></div>
</body>
<link href="${ctxt}/resources/css/myCR/my_cr.css" rel="stylesheet" type="text/css">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

$(function(){
//	var idx = '${seq}';
	var idx = 9341;    //  9330 ,  한양+관찰 9341 ,  8.연구설계- 중재연구 + 요약문 test 9018  // 8.연구설계 연구목적 중 기타  9121  //  8.연구설계 눈가림 예외 예 917
								//  의견 댓글ex : 8262 (등록번호  PRE20170618-001 )
	
	var separator = '${separator}';
	
	var params={};
	params.seq = idx;
	params.separator = separator;
	
	var url = $(location).attr('href');
	var baseUrl = url.substr(0,url.lastIndexOf("/"));
	
	$.ajax({
		url:  baseUrl+"/regSubData.do",
		data : params,
		type:'POST',
		success:function(res){
			
			var rsColArr = [];
			rsColArr = Object.keys(res[0]);
		
/* 			var str = "";
			for(var i in rsColArr){
				str += rsColArr[i]+'<br>';
				$('#shTest').html(str)
			} */

			var resIdx = res[0];	// 기본 테이블
			var resSystem = res[1];  //  타등록기관
			var resStep = res[2];  //  등록된 메모 step 별 조회
			var resRoleGubun = res[3];   // 3.연구자  
			var resInstituteGubun = res[4];  //	4. 연구 기관
			var resKindGubun = res[5];	//		8. 연구 설계
			var resIcd10 = res[6];	//		9. 대상자 선정 기준
			var resVarGubun = res[7];	//		10. 결과 변수
			var resThesis= res[8];	//		11. 연구 결과 및 발표
	
			var etcSystem = "";  //  타등록기관
			try{
				var stmNm = resSystem.SYSTEM_NAME;
				var stmNb = resSystem.SYSTEM_NUMBER;
				
				if(stmNm != "" && stmNb != null || stmNb != "" && stmNb != null){
					etcSystem = stmNm +'-'+stmNb;
				} else {
					etcSystem = "&nbsp;"
				}
			}catch (Exception){
				
			}
			
			var fir_html = "";		//	1. 연구개요
			var sec_html="";		//	2. 임상 연구 윤리 심의	
			var third_html = "";		//	3. 연구자 - 연구책임자
			var fourth_html = "";		//	3. 연구자 - 연구 실무 담당자
			var fifth_html = "";		//	3. 연구자 - 등록 관리자
			var sixth_html = "";		//	4. 연구 기관
			var seventh_html = "";		//	5. 연구비 지원 기관
			var eighth_html = "";		//	6. 연구 책임 기관
			var nineth_html = "";		//	7. 연구 요약
			var tenth_html = "";		//	8. 연구 설계
			var eleventh_html = "";		//	9. 대상자 선정 기준
			var twelveth_html = "";		//	10. 결과 변수
			var thirteenth_html = "";		//	11. 연구 결과 및 발표
			var firteenth_html = "";		//	12. 연구 데이터 공유
			
			fir_html += '<tr>';
				fir_html += '<th scope="row">CRIS 등록 번호</th><td>'+resIdx.SYSTEM_NUMBER+'</td>';
				fir_html += '</tr><tr><th  scope="row">연구 고유 번호</th><td>'+resIdx.RESEARCH_NUMBER+'</td>';
			fir_html += '</tr>';
			fir_html+= '<tr><th rowspan="3" scope="row">요약 제목</th>';
				fir_html += '<tr colspan="2"><td class="sec_td">국문</td><td>'+resIdx.SUMMARY_TITLE_KR+'</td></tr>';
				fir_html += '<tr colspan="2"><td class="sec_td">영문</td><td>'+resIdx.SUMMARY_TITLE_EN+'</td></tr>';
			fir_html += '</tr>';
			fir_html += fn_makeOfKrEng("연구 제목", fn_nullCheck(resIdx.RESEARCH_TITLE_KR), resIdx.RESEARCH_TITLE_EN); 	// 국문, 영문 method
			fir_html += '<tr>';
				fir_html += '<th>연구 약어명</th><td>'+resIdx.RESEARCH_ABB_EN+'</td>';
			fir_html += '</tr><tr>';
				fir_html += '<th>식약청 규제 연구</th><td>'+fn_yn(resIdx.FDA_REGULATED_INVESTIGATE_YN)+'</td>';
			fir_html += '</tr><tr>';
				fir_html += '<th>IDN/IDE Protocol 여부</th><td>'+fn_yn(resIdx.IND_IDE_PROTOCOL_YN)+'</td>';
			fir_html += '</tr><tr>';
				fir_html += '<th>타등록 시스템 등록 여부</th><td>'+fn_yn(resIdx.ETC_SYSTEM_REGIST_YN)+'</td></tr>';
			if(resIdx.ETC_SYSTEM_REGIST_YN =="Y") fir_html += '<tr><th>타등록 시스템/등록 번호</th><td>'+etcSystem+'</td></tr>';
				fir_html += '<tr><th>임상 연구 요양 급여</th><td>'+fn_approval_status(resIdx.HCB_APPROVAL_STATUS)+'</td></tr>';	
			
			$('#theOutlineOfRsrch_tbody').html(fir_html);
 			
			sec_html += '<tr><th>승인 상태</th><td>'+fn_nullCheck(resIdx.IRB_STATUS)+'</td></tr>';
			sec_html += '<tr><th>승인 번호</th><td>'+fn_nullCheck(resIdx.IRB_NUMBER)+'</td></tr>';
			sec_html += '<tr><th>승인 일</th><td>'+fn_nullCheck(fn_dateIcon(resIdx.IRB_DATE))+'</td></tr>';
			sec_html += '<tr><th>승인 파일</th><td>'+fn_fileRun(resIdx.IRB_FILE)+'</td></tr>';		// 	 	sunhwa not Yet
			sec_html += fn_makeOfKrEng("위원회",fn_nullCheck(resIdx.IRB_COMMITTEE_KR),  fn_nullCheck(resIdx.IRB_COMMITTEE_EN));
			sec_html += fn_makeOfKrEng("위원회 주소",fn_nullCheck(resIdx.IRB_AGENCY_ADDRESS_KR),  fn_nullCheck(resIdx.IRB_AGENCY_ADDRESS_EN));
			sec_html += '<tr><th>위원회 전화번호</th><td>'+fn_nullCheck(resIdx.IRB_PHONE)+'</td></tr>';
			sec_html += '<tr>';
				sec_html += '<th rowspan="4" scope="row">자료 모니터링 위원회</th>';      
				sec_html += '<tr><td>'+fn_yn(resIdx.DATA_MONITOR_COMMITTEE_YN, "monitoring")+'</td></tr>';
				sec_html += '<tr colspan="2"><td class="sec_td">국문</td><td>'+fn_nullCheck(resIdx.DATA_MONITOR_COMMITTEE_KR)+'</td></tr>';
				sec_html += '<tr colspan="2"><td class="sec_td">영문</td><td>'+fn_nullCheck(resIdx.DATA_MONITOR_COMMITTEE_EN)+'</td></tr>';
			sec_html += '</tr>';
			
			$('#theEthicalReview_tbody').html(sec_html);
			
			third_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun,"CHARGE","name"))+'</tr>';
			third_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun,"CHARGE","degree"))+'</tr>';
			third_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun,"CHARGE","email"))+'</tr>';
			third_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun,"CHARGE","phone"))+'</tr>';
			third_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun,"CHARGE","hand_phone"))+'</tr>';
			third_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun,"CHARGE","institution"))+'</tr>';
			third_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun,"CHARGE","institution_add"))+'</tr>';
			
			$('#theResearcher_tbody').html(third_html);
			
			fourth_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun,"WORK","name"))+'</tr>';
			fourth_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun,"WORK","degree"))+'</tr>';
			fourth_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun,"WORK","email"))+'</tr>';
			fourth_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun,"WORK","phone"))+'</tr>';
			fourth_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun,"WORK","hand_phone"))+'</tr>';
			fourth_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun,"WORK","institution"))+'</tr>';
			fourth_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun,"WORK","institution_add"))+'</tr>';
			
			$('#theWork_tbody').html(fourth_html);
			
			fifth_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun, "REGIST", "name"))+'</tr>';
			fifth_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun, "REGIST", "degree"))+'</tr>';
			fifth_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun, "REGIST", "email"))+'</tr>';
			fifth_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun, "REGIST", "phone"))+'</tr>';
			fifth_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun, "REGIST", "hand_phone"))+'</tr>';
			fifth_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun, "REGIST", "institution"))+'</tr>';
			fifth_html +=	'<tr>'+fn_nullCheck(fn_gubunName(resRoleGubun, "REGIST", "institution_add"))+'</tr>';
			$('#theRegist_tbody').html(fifth_html);

			var dataStr ="";
			(resIdx.RESEARCH_AGENCY_COUNT != "1") ? dataStr="다기관 "+fn_institution(resInstituteGubun,"RESEARCH" , "size") : dataStr="단일";
			if(resIdx.RESEARCH_NATION == "Y") dataStr +=" - 다국가 ";
			sixth_html += '<tr><th>연구 참여 기관</th><td>'+dataStr+'</td></tr>';
			sixth_html += '<tr><th>전체 연구 모집 현황</th><td>'+fn_rsrch_step(resIdx.RESEARCH_STEP, resIdx.RESEARCH_STOP_REASON)+'</td></tr>';
			sixth_html += '<tr><th>첫 연구 대상자 등록 일자</th><td>'+resIdx.STUDY_START_DATE +", "+ resIdx.STUDY_START_DATE_GUBUN+'</td></tr>';
			sixth_html += '<tr><th>목표 대상자 수</th><td>'+resIdx.ENROLLMENT+' 명</td></tr>';
			sixth_html += '<tr><th>자료 수집 종료일</th><td>'+resIdx.PRIMARY_COMPLETE_DATE+", "+resIdx.PRIMARY_COMPLETE_GUBUN+'</td></tr>';
			sixth_html += '<tr><th>연구 종료일</th><td>'+resIdx.STUDY_COMPLETE_DATE+", "+resIdx.STUDY_COMPLETE_GUBUN+'</td></tr>';
			sixth_html += fn_institution(resInstituteGubun,"RESEARCH","name");
			
			$('#theRsrchInstitiute_tbody').html(sixth_html);
			
			seventh_html += fn_institution(resInstituteGubun,"FUNDING","fund");
			$('#theRsrchFunding_tbody').html(seventh_html);
			
			eighth_html += fn_institution(resInstituteGubun,"SPONSOR","sponsor");
			
			$('#theRsrchResponsibility_tbody').html(eighth_html);
			
			// 연구요약 부분 기호 따른 줄바꿈 상황 추가 (ex. seq = 9018, -표시별 출바꿈)
			var smry_kr = resIdx.RESEARCH_SUMMARY_KR;
			var smry_eng = resIdx.RESEARCH_SUMMARY_EN;
//			var th_rwSpanKr = fn_arrInfoCheged(smry_kr);
//			var th_rwSpanEng = fn_arrInfoCheged(smry_eng);
//			nineth_html += '<tr><th rowspan="'+th_rwSpanKr+'">국문</th>'+fn_replaceStr(smry_kr)+'</tr>' ;
//			nineth_html += '<tr><th rowspan="'+th_rwSpanEng+'">영문</th><td>'+fn_replaceStr(smry_eng)+'</td></tr>' ;
			nineth_html += '<tr><th>국문</th><td>'+smry_kr+'</td></tr>' ;
			nineth_html += '<tr><th>영문</th><td>'+smry_eng+'</td></tr>' ;
			
			$('#theRsrchSummary_tbody').html(nineth_html);
			
			// 테이블 중재 != 관찰 .... 1STEP : 중재 테이블만
			//  8. 연구 설계 입력시 각 사항에 대해 추가 입력 항목이 있는 경우 fn_check_theOthers() 내용 사용
			var rsrch_kind = resIdx.RESEARCH_KIND;
			if(rsrch_kind.indexOf("중재") != -1){
				tenth_html += '<tr><th>연구 종류</th><td>'+rsrch_kind+'</td></tr>';
				tenth_html += fn_check_theOthers(resIdx.RESEARCH_PURPOSE, resIdx.RESEARCH_PURPOSE_ETC,resIdx.RESEARCH_PURPOSE_ETC_EN,"연구 목적" ,"기타");
				tenth_html += '<tr><th>임상 시험 단계</th><td>'+resIdx.CLINICAL_STEP+'</td></tr>';
				tenth_html += fn_check_theOthers(resIdx.INTERVENTION_MODEL, resIdx.INTERVENTION_MODEL_ETC,resIdx.INTERVENTION_MODEL_ETC_EN,"중재 모형" ,"기타");
				tenth_html += fn_check_theOthers(resIdx.BLINDING, resIdx.BLINDING_TARGET,"another","눈 가림" ,"Open");
				tenth_html += '<tr><th>배정</th><td>'+resIdx.ALLOCATION+'</td></tr>';
				tenth_html += fn_check_theOthers(resIdx.INTERVENTION_TYPE, resIdx.INTERVENTION_TYPE_ETC,resIdx.INTERVENTION_TYPE_ETC_EN,"중재 종류" ,"기타");
				tenth_html += fn_makeOfKrEng("중재 상세 설명", fn_nullCheck(resIdx.ARM_DESC_KR), fn_nullCheck(resIdx.ARM_DESC_EN));
				tenth_html += fn_rsrch_kind(resKindGubun, "ARM");
			} else {
				tenth_html += '<tr><th>연구 종류</th><td>'+rsrch_kind+'</td></tr>';
				tenth_html += '<tr><th>관찰 연구 모형</th><td>'+resIdx.OBSERVATIONAL_MODEL+'</td></tr>';
				tenth_html += fn_check_theOthers(resIdx.TIME_PERSPECTIVE, resIdx.TIME_PERSPECTIVE_ETC, resIdx.TIME_PERSPECTIVE_ETC_EN,"연구 관점","기타")+'</td></tr>';
				tenth_html += '<tr><th>목표 대상자 수</th><td>'+resIdx.BIOSPECIMEN_ENROLLMENT+' 명</td></tr>';
				tenth_html += fn_rsrch_kind(resKindGubun, "COHORT");
				tenth_html += '<tr><th>생물자원 저장</th><td>'+resIdx.BIOSPECIMEN_RETENTION+'</td></tr>';
				tenth_html += fn_makeOfKrEng("생물 자원 종류", fn_nullCheck(resIdx.BIOSPECIMEN_DESCRIPTION_KR), fn_nullCheck(resIdx.BIOSPECIMEN_DESCRIPTION_EN));
			}
			
			$('#theRsrchDesign_tbody').html(tenth_html);
			
			var end_age = "";
			( resIdx.TARGET_IN_END_AGE_UNIT.indexOf( "No Limit") > -1) ? end_age = resIdx.TARGET_IN_END_AGE_UNIT : end_age = resIdx.TARGET_IN_END_AGE + resIdx.TARGET_IN_END_AGE_UNIT;
			var std_age = resIdx.TARGET_IN_START_AGE + resIdx.TARGET_IN_START_AGE_UNIT + " ~ " + end_age ;
			if(rsrch_kind.indexOf("관찰") > -1){
				eleventh_html += fn_makeOfKrEng("연구 모집단 설명", resIdx.STUDY_POPULATION_DESC_KR, resIdx.STUDY_POPULATION_DESC_EN);
				eleventh_html += fn_makeOfKrEng("대상자 추출 방법", resIdx.SAMPLING_METHOD_KR, resIdx.SAMPLING_METHOD_EN);
			}
			//    resIcd10
			eleventh_html += '<tr><th rowspan="4" scope="row">연구대상 상태 / 질환</th>'
			eleventh_html += '<tr colspan="2"><td class="sec_td">질환 분류</td><td>' + fn_Icd(resIcd10) + '</td></tr>';		//  error : td가 자동으로 하나 더 삽입
			eleventh_html += '<tr colspan="2"><td class="sec_td">국문</td><td>'+fn_nullCheck(resIdx.CP_CONTENTS)+'</td></tr>';
			eleventh_html += '<tr colspan="2"><td class="sec_td">영문</td><td>'+fn_nullCheck(resIdx.CP_CONTENTS_EN)+'</td></tr>';
			eleventh_html += '</tr>';
			eleventh_html += '<tr><th>희귀 질환 여부</th><td>'+fn_yn(resIdx.TARGET_RARE_YN)+'</td></tr>';
			eleventh_html += '<tr><th rowspan="5">대상자 포함 기준</th>';
			eleventh_html += '<tr colspan="2"><td class="sec_td">성별</td><td>'+resIdx.TARGET_IN_SEX+'</td></tr>';
			eleventh_html += '<tr colspan="2"><td class="sec_td">연령</td><td>'+std_age+'</td></tr>'
			eleventh_html += '<tr colspan="2"><td class="sec_td">국문</td><td>'+resIdx.TARGET_IN_KR+'</td></tr>';
			eleventh_html += '<tr colspan="2"><td class="sec_td">영문</td><td>'+resIdx.TARGET_IN_EN+'</td></tr>';
			eleventh_html +=  '</tr>';
			eleventh_html +=  fn_makeOfKrEng("대상자 제외 기준", resIdx.TARGET_OUT_KR, resIdx.TARGET_OUT_EN);
			eleventh_html += '<tr><th>건강인 참여 여부</th><td>'+fn_yn(resIdx.HEALTHY_VOLUNTEERS_YN)+'</td></tr>';
		
			$('#theTargetStandard_tbody').html(eleventh_html);
			
			twelveth_html += '<tr><th>주요 결과 변수 유형</th><td>'+resIdx.TYPE_OF_ENDPOINT+'</td></tr>';
			twelveth_html += fn_variable(resVarGubun);
			
			$('#theResultVariable_tbody').html(twelveth_html);
			
			var annYn = resIdx.FINAL_RESULT_YN;
			var enrllmnt = resIdx.FINAL_ENROLLMENT;
			var annStr = "";
			var annStr2 = "";
			if(annYn == "Y" ) {
				(resIdx.FINAL_RESULT_TYPE == "P" ) ? annStr = "</br> 논문으로 출판 ( Published )" :  annStr = "&nbsp;";
				(resIdx.FINAL_RESULT_TYPE == "F" ) ? annStr = "</br> 연구결과 파일 업로드 ( Result Upload )" : annStr = "&nbsp;";
				thirteenth_html += '<tr><th>연구 결과 등록 여부</th><td>'+fn_yn(annYn)+annStr+'</td></tr>';
				(enrllmnt !="" && enrllmnt != null) ? annStr2 = enrllmnt +" 명" : annStr2 = "&nbsp;";
				thirteenth_html += '<tr><th>최종 연구 대상자 수</th><td>'+annStr2+'</td></tr>';
				thirteenth_html += fn_thesis(resThesis);   
				thirteenth_html += '<tr><th>결과 업로드</th><td>  sunhwa 나중에 </td></tr>';
				thirteenth_html += '<tr><th>연구 결과 등록일</th><td>'+resIdx.CHG_RESULT_UPDATE_DATE+'</td></tr>';
				thirteenth_html += '<tr><th>프로토콜 </br> / file 업로드</th><td>';
				thirteenth_html += '<a href="'+resIdx.PROTOCOL_URL+'" target="_blank" title="새창으로보기">'+resIdx.PROTOCOL_URL+'</a>';		//  sunhwa later for file
				thirteenth_html += '</td></tr>';
				thirteenth_html += fn_makeOfKrEng("결과 요약", resIdx.RESEARCH_RESULT, resIdx.RESEARCH_RESULT_EN);
				
				// 한쭐몌모
			} else {
				thirteenth_html += '<tr><th>연구 결과 등록 여부</th><td>'+fn_yn(annYn)+'</td></tr>';
			}
			
			$('#theAnnouncement_tbody').html(thirteenth_html);
			
			var share_yn = resIdx.SHARE_YN;
			var yn_check = "";
			(share_yn != "" && share_yn != null) ? yn_check = fn_yn(resIdx.SHARE_YN) : yn_check = "미입력된 정보 입니다.";
			firteenth_html += '<tr><th>결과 공유 계획</th><td>'+yn_check+'</td></tr>';
			
			if(share_yn == "Y"){
				firteenth_html += '<tr><th>공유 예상 시기</th><td>'+resIdx.SHARE_EXPECT_YEAR+"년"+resIdx.SHARE_EXPECT_MONTH+"월"+'</td></tr>';
			
				var share_etc = "";
				if(resIdx.SHARE_METHOD =='3' || resIdx.SHARE_METHOD=='4'){
					var protocol_url = resIdex.SHARE_METHOD_ETC;
					if(resIdex.SHARE_METHOD_ETC != null && resIdex.SHARE_METHOD_ETC != "" && resIdx.protocol_url.length > 10)	share_etc = "<a href='"+resIdx.SHARE_METHOD_ETC+"' target='_blank' title='새창으로 열기'>"+resIdx.SHARE_METHOD_ETC+"</a>";
				} else {
					share_etc = fn_existing(resIdx.SHARE_METHOD_ETC, resIdx.SHARE_METHOD_ETC_EN);
				}
				
				firteenth_html += '<tr><th>공유 방법</th><td>'+resIdx.SHARE_METHOD_AL+'</br>'+share_etc+'</td></tr>';
			}
			
			$('#theDataSharing_tbody').html(firteenth_html);
			
// 	1613lines =>  이전 의견 보기???
			
			fn_step(resStep);
		}
			
	});   //  the first end of the ajax
	$('#theOutlineOfRsrch_btn').attr('value','수정');
	
	
	
	
});   // the end of the function

$(function(){
	
	var upt_btn = '<input type="button" class="table_btn" id="" name="" value="수정">';

	var divTbId = $('.table_title').find('table');
	divTbId.each(function(i){
	//	alert($(this).attr('id'));
		($(this).append(upt_btn));
	});
	
//	$(' .table_title').append(upt_btn);
	$('.table_btn').click(function(){
		alert("클릭?");
		var findTableId = $(this).parent('table').attr('id');
		
		var tbltr = $('#'+findTableId).find('tr');
		tbltr.each(function(i){
		var last_td =$(this).find('td').last();   //  = eq(-1)
		
		var rw_txt = last_td.text();
		var input_tag = $('<input type="text" />');
		input_tag.val(rw_txt);
		last_td.html(input_tag); 
	});
	
		
	});
	
/* 	$('#theOutlineOfRsrch_btn').click(function(){
		
		$('#theOutlineOfRsrch_btn').attr('value','수정 완료');
		

		var btnVal = $('#theOutlineOfRsrch_btn').val();
		if(btnVal == '수정 완료'){
			//  update ( temporary, test 
		}
	}) */
})  //  end of btn's function

function fn_nullCheck (checkStr) {
	var resultStr = "";
	if(checkStr == "" || checkStr == null){
		resultStr = "필수 입력 항목 입니다. 입력 해주세요";
	} else {
		resultStr = checkStr;
	}
	return resultStr;
}

function fn_yn(ynStr, category){
	var resultStr = "";
		if(ynStr == "Y"){
			resultStr = "예 (Yes)";
		} else {
			resultStr = " 아니오 (No)";
		}
	return resultStr;
}

// 수정
function fn_makeOfKrEng(thTitle, td01, td02){
	var resultStr = "";
	resultStr += '<tr>';
	resultStr += '<th rowspan="3" scope="row">'+thTitle+'</th>'; 
	resultStr += '<tr colspan="2"><td class="sec_td">국문</td><td>'+td01+'</td></tr>';
	resultStr += '<tr colspan="2"><td class="sec_td">영문</td><td>'+td02+'</td></tr>';
	resultStr += '</tr>';
	return resultStr;
}

function fn_dateIcon(inputDate){
	var resultStr = "";
	 var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\#$%&\\\=\(\'\"]/gi;
	resultStr = inputDate.replace(regExp,"");
	return resultStr;
}

function fn_approval_status(inputStatus){
	var resultStr = "";
	
	if(inputStatus == "N"){
		resultStr = "해당 연구가 아님 ( the study is not applicable )";
	} else if (inputStatus == "P"){
		resultStr = "신청 중 ( Applying )";
	} else if (inputStatus == "A"){
		resultStr = " 신청 후 승인 ( Approval after application )";
	} else {
		resultStr = "&nbsp;";
	}
	
	return resultStr;
}

function fn_step(resArr){
	var resultStr = "";
	var keyArr = [];
	var valArr = resArr;
	
	keyArr = Object.keys(resArr);
	
	for(var i=0; i < keyArr.length ; i++){
		var idx = keyArr[i];
		var valueDt = valArr[idx];
		
		var checkData = Number(valueDt.STEP);
		resultStr = '<tr><td colspan="3">' + valueDt.COMMENT1 + '</td></tr>';
		
		if( checkData == 1 ){
			$('#theOutlineOfRsrch_tbody:last').append(resultStr);
		} else if(checkData == 2) {
			$('#theEthicalReview_tbody:last').append(resultStr);
		} else if(checkData == 3) {
			$('#theResearcher_tbody:last').append(resultStr);
		} else if(checkData == 4) {
			$('#theRsrchInstitiute_tbody:last').append(resultStr);
		} else if(checkData == 5) {
			$('#theRsrchFunding_tbody:last').append(resultStr);
		} else if(checkData == 6) {
			$('#theRsrchResponsibility_tbody:last').append(resultStr);
		} else if(checkData == 7) {
			$('#theRsrchSummary_tbody:last').append(resultStr);
		} else if(checkData == 8) {
			$('#theRsrchDesign_tbody:last').append(resultStr);
		} else if(checkData == 9) {
			$('#theTargetStandard_tbody:last').append(resultStr);
		} else if(checkData == 10) {
			$('#theResultVariable_tbody:last').append(resultStr);
		} else if(checkData == 11) {
			$('#theAnnouncement_tbody:last').append(resultStr);
		} else if(checkData == 12) {
			$('#theDataSharing_tbody:last').append(resultStr);
		}
		
	}
	return resultStr;	
}

function fn_fileRun(fileStr){

	
}

//	3. 연구자
function fn_gubunName(inputResArr, role, th){
	
	var resultStr = "";
	var role_gbArr = [];
	var valueOfArr = [];
	valueOfArr = inputResArr;
	role_gbArr = Object.keys(inputResArr);
	role_gbArr.splice(role_gbArr.indexOf("role_gbInfo"),1);
	role_gbArr.sort();
	
	for(var i=0 ; i<role_gbArr.length ; i++){
		var roleIdx = role_gbArr[i];
		var roleValue = valueOfArr[roleIdx];
		var role_gb = roleValue.GUBUN;
		
		if(role==role_gb && th=="name"){
			var nm_kr = roleValue.NAME_KR;
			var nm_eng = roleValue.NAME_EN_1ST+" "+ roleValue.NAME_EN_MID+" "+roleValue.NAME_EN_LAST;
			
			resultStr += '<th rowspan="3" scope="row">성명</th>'; 
			resultStr += '<tr colspan="2"><td class="sec_td">국문</td><td>'+nm_kr+'</td></tr>';
			resultStr += '<tr colspan="2"><td class="sec_td">영문</td><td>'+nm_eng+'</td></tr>';
		} else if (role==role_gb && th == "degree"){
			resultStr += '<th rowspan="3" scope="row">직위</th>'; 
			resultStr += '<tr colspan="2"><td class="sec_td">국문</td><td>'+roleValue.NAME_KR_DEGREE+'</td></tr>';
			resultStr += '<tr colspan="2"><td class="sec_td">영문</td><td>'+roleValue.NAME_EN_DEGREE+'</td></tr>';
		} else if (role==role_gb && th == "email"){
			var emailStr = roleValue.EMAIL_ID + "@" + roleValue.EMAIL_DOMAIN;
			resultStr += '<th>이메일</th><td>'+emailStr+'</td>';
		} else if (role==role_gb && th == "phone"){
			resultStr += '<th>전화번호</th><td>'+roleValue.PHONE_KR+'</td>';
		} else if (role==role_gb && th == "hand_phone"){
			resultStr += '<th>휴대폰</th><td>'+roleValue.CONF_HP;
			resultStr+= (roleValue.CONF_HP_YN=="Y") ? " , 수신 동의" : " , 수신 거절"
			resultStr += '</td>';
		}  else if (role==role_gb && th == "institution"){
			resultStr += '<th rowspan="3" scope="row">기관</th>'; 
			resultStr += '<tr colspan="2"><td class="sec_td">국문</td><td>'+roleValue.AGENCY_NAME_KR+'</td></tr>';
			resultStr += '<tr colspan="2"><td class="sec_td">영문</td><td>'+roleValue.AGENCY_NAME_EN+'</td></tr>';
		} else if (role==role_gb && th == "institution_add"){
			resultStr += '<th rowspan="3" scope="row">기관 주소</th>'; 
			resultStr += '<tr colspan="2"><td class="sec_td">국문</td><td>'+roleValue.AGENCY_ADDRESS_KR+'</td></tr>';
			resultStr += '<tr colspan="2"><td class="sec_td">영문</td><td>'+roleValue.AGENCY_ADDRESS_EN+'</td></tr>';
		}
	}  //  end of for
	
	return resultStr;
}

var cnt = 0;
var cntNm =0;
var cntFnd =0;
var cntSpnsr=0;
function fn_institution(resArr, ist_gubun, order){
	var resultStr = "";
	var ist_gbArr = [];
	var ist_valueArr = resArr;
	ist_gbArr = Object.keys(resArr);
	for(var i=0 ; i<ist_gbArr.length; i++){
		var istIdxData = ist_gbArr[i];
		var istValue = ist_valueArr[istIdxData];
		
		var istGb = istValue.GUBUN;
		
		if(ist_gubun == istGb && order == "size"){
			cnt++;
			resultStr = "(기관수 : "+cnt+")";
		} else if(ist_gubun == istGb && order == "name"){
			cntNm++;
			resultStr +=  '<tr><th> 참여 기관별 연구 진행 현황 '+cntNm+'</th></tr>';
			resultStr += '<th rowspan="3" scope="row">기관명</th>'; 
			resultStr += '<tr colspan="2"><td class="sec_td">국문</td><td>'+istValue.NAME_KR+'</td></tr>';
			resultStr += '<tr colspan="2"><td class="sec_td">영문</td><td>'+istValue.NAME_EN+'</td></tr>';
			resultStr +=  '<tr><th>연구 모집 현황</th><td>'+fn_rsrch_step(istValue.STEP, istValue.STOP_REASON)+'</td></tr>';
			resultStr +=  '<tr><th>첫 연구 대상자 등록 일자</th><td>'+istValue.STUDY_START_DATE+", "+istValue.STUDY_START_DATE_GUBUN+'</td></tr>';
		} else if(ist_gubun == istGb && order == "fund"){
			cntFnd++;
			resultStr +=  '<tr><th> 참여 기관별 연구 진행 현황 '+cntFnd+'</th></tr>';
			resultStr += '<th rowspan="3" scope="row">기관명</th>'; 
			resultStr += '<tr colspan="2"><td class="sec_td">국문</td><td>'+istValue.NAME_KR+'</td></tr>';
			resultStr += '<tr colspan="2"><td class="sec_td">영문</td><td>'+istValue.NAME_EN+'</td></tr>';
			resultStr +=  '<tr><th>기관 종류</th><td>'+fn_agencyGroup(istValue.AGENCY_GROUP)+'</td></tr>';
			resultStr +=  '<tr><th>연구 과제 번호</th><td>'+istValue.RESEARCH_SUBJECT_NUMBER+'</td></tr>';
		} else if(ist_gubun == istGb && order == "sponsor"){
			cntSpnsr++;
			resultStr +=  '<tr><th> 연구비 책임 기관 '+cntSpnsr+'</th></tr>';
			resultStr += '<th rowspan="3" scope="row">기관명</th>'; 
			resultStr += '<tr colspan="2"><td class="sec_td">국문</td><td>'+istValue.NAME_KR+'</td></tr>';
			resultStr += '<tr colspan="2"><td class="sec_td">영문</td><td>'+istValue.NAME_EN+'</td></tr>';
			resultStr +=  '<tr><th>기관 종류</th><td>'+fn_agencyGroup(istValue.AGENCY_GROUP)+'</td></tr>';
		} 
			
	}	// end of for
	return resultStr;
}

function fn_rsrch_step(iptData, stopRsn){
	var resultStr = "";
	
	if(iptData.indexOf("중지") != -1){
		resultStr = "사유 : "+ stopRsn
	} else if (iptData.indexOf("중단") != -1) {
		resultStr = "사유 : "+ stopRsn
	} else if (iptData.indexOf("철회") != -1) {
		resultStr = "사유 : "+ stopRsn
	} else {
		resultStr = iptData;
	}
	return resultStr;
}

function fn_agencyGroup(iptStr){
	var resultStr = "";
	
	if(iptStr == "제약회사") resultStr = "제약회사(Pharmaceutical Company)";
	if(iptStr == "의료기관") resultStr = "의료기관(Medical Institute)";
	if(iptStr == "연구소") resultStr = "연구소(Research Institute)";
	if(iptStr == "병원") resultStr = "병원(Hospital)";
	if(iptStr == "대학교") resultStr = "대학교(University)";
	if(iptStr == "정부") resultStr = "정부(Government)";
	if(iptStr == "보건산업진흥원") resultStr = "보건산업진흥원(Korea Health Industry Development Institute)";
	if(iptStr == "기타") resultStr = "기타(Others)";
	
	return resultStr;
}

function fn_arrInfoCheged(iptStr){
	var arrLength = 0;
	//  var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\#$%&\\\=\(\'\"]/gi;
	var pattern = /\s/g;
	var tmpArr = [];
	
	tmpArr = iptStr.split(pattern);
	arrLength = tmpArr.length+1;
	
	return arrLength;
}

//  NOT USE
function fn_replaceStr(iptStr){
	var resultStr = "";
	 var pattern = /\s/g;
	var tmpArr = []; 
	iptStr = String(iptStr);
	tmpArr = iptStr.split(pattern);
	
	for(var i in tmpArr){
		console.log(tmpArr[i])
		resultStr += '<tr><td>'+tmpArr[i]+'</td></tr>';
	}
	return resultStr;
}

function fn_check_theOthers(str1, str2, str3, th_title,exception){
	var resultStr = "";
 	
	if(str1.indexOf(exception) > -1){
		if(str3 != "another"){
			resultStr = '<tr><th>'+th_title+'</th><td>'+str1+", "+fn_existing(str2, str3)+'</td></tr>';
		} else {
			resultStr = '<tr><th>'+th_title+'</th><td>'+str1+'</td></tr>';
		}
	} else {
		if(str3 != "another"){
			resultStr = '<tr><th>'+th_title+'</th><td>'+str1+'</td></tr>';
		} else {
				resultStr = '<tr><th>'+th_title+'</th><td>'+str1+'</td></tr>';
				resultStr += '<tr><th>눈 가림 대상자</th><td>'+str2+'</td></tr>';
		}
	}
	
	return resultStr;
}

function fn_existing(ipt01, ipt02){
	var resultStr = "";
	if(ipt01 != "" && ipt01 != null && ipt02 != "" && ipt02 != null ){
		resultStr = ipt01 + "( "+ipt02+" )";
	} else if ( ipt01 != "" && ipt01 != null && ipt02 =="" && ipt02 == null ){
		resultStr = ipt01;
	} else if (ipt01 == "" || ipt01 == null && ipt02 != "" && ipt02 != null) {
		resultStr = ipt02;
	} else {
		resultStr = "&nbsp;";
	}
	return resultStr;
}

var kndCnt = 0;
function fn_rsrch_kind(resArr, gb){
	var resultStr = "";
	
	var knd_gbArr = [];
	var knd_valueArr = resArr;
	knd_gbArr = Object.keys(resArr);
	knd_gbArr.sort();  //  관찰군 순서 맞춰줌
	
	for(var i=0 ; i<knd_gbArr.length; i++){
		var kndIdxData = knd_gbArr[i];
		var kndValue = knd_valueArr[kndIdxData];
		
		var kndGb = kndValue.GUBUN;
		
		if (kndGb == "ARM"){
			kndCnt++;
			resultStr += '<tr><th rowspan="7">중재군 '+kndCnt+'</th>';
			resultStr += '<tr colspan="2"><td class="sec_td">중재군명 (국문)</td><td>'+kndValue.NAME_KR+'</td></tr>';
			resultStr += '<tr colspan="2"><td class="sec_td">중재군명 (영문)</td><td>'+kndValue.NAME_EN+'</td></tr>';
			resultStr += '<tr colspan="2"><td class="sec_td">목표 대상자 수</td><td>'+kndValue.ENROLLMENT+'</td></tr>';
			resultStr += '<tr colspan="2"><td class="sec_td">중재군 유형</td><td>'+kndValue.NAME_EN+'</td></tr>';
			resultStr += '<tr colspan="2"><td class="sec_td">상세 내용 (국문)</td><td>'+kndValue.CONTENT_KR+'</td></tr>';
			resultStr += '<tr colspan="2"><td class="sec_td">상세 내용 (영문)</td><td>'+kndValue.CONTENT_EN+'</td></tr>';
			resultStr += '</tr>';
		} else if (kndGb == "COHORT") {
			kndCnt++;
			resultStr += '<tr><th rowspan="5">관찰군 '+kndCnt+'</th>';
			resultStr += '<tr colspan="2"><td class="sec_td">관찰군명 (국문)</td><td>'+kndValue.NAME_KR+'</td></tr>';
			resultStr += '<tr colspan="2"><td class="sec_td">관찰군명 (영문)</td><td>'+kndValue.NAME_EN+'</td></tr>';
			resultStr += '<tr colspan="2"><td class="sec_td">상세 내용 (국문)</td><td>'+kndValue.CONTENT_KR+'</td></tr>';
			resultStr += '<tr colspan="2"><td class="sec_td">상세 내용 (영문)</td><td>'+kndValue.CONTENT_EN+'</td></tr>';
			resultStr += '</tr>';
		}
	}
	
	return resultStr;
}

function fn_Icd(resArr){
	var resultStr = "";
	var keyArr = [];
	var valueArr = resArr;
	
	keyArr = Object.keys(resArr);
	for(var i=0; i<keyArr.length;i++){
		var idx = keyArr[i];
		var values = valueArr[idx];
		var data_kr = values.ICD10_NAME_KR;
		var data_eng = values.ICD10_NAME_EN;
		
		if(data_kr != "" && data_kr != null && data_eng != "" && data_eng != null ){
			resultStr = "* "+data_eng + "</br> &nbsp;&nbsp;"+data_kr;
		} else if ( data_kr != "" && data_kr != null && data_eng =="" && data_eng == null ){
			resultStr = data_kr;
		} else if (data_kr == "" || data_kr == null && data_eng != "" && data_eng != null) {
			resultStr = data_eng;
		} else {
			resultStr = "&nbsp;";
		}
	}
	return resultStr;
}

var var_pCnt = 0;
var var_sCnt = 0;
function fn_variable(resArr){
	var resultStr = "";
	var rslt01 = "";
	var rslt02 = "";
	var keyArr = [];
	var valueArr = resArr;
	
	keyArr = Object.keys(resArr);
	keyArr.sort();   // order P->S
	
	for(var i=0; i<keyArr.length ; i++){
		var keyIdx = keyArr[i];
		var valueData = valueArr[keyIdx];
		
		var var_gb = valueData.GUBUN;
		if(var_gb=="P") {
			var_pCnt++;
			rslt01 += '<tr><th >주요 결과 변수 '+var_pCnt+'</th>';
			rslt01 += fn_makeOfKrEng("평가항목", valueData.OUTCOME_KR, valueData.OUTCOME_EN);
			rslt01 += fn_makeOfKrEng("평가시기", valueData.TIMEPOINT_KR, valueData.TIMEPOINT_EN);
			rslt01 += '</tr>';
		} else {
			var_sCnt++;
			rslt02 += '<tr><th >보조 결과 변수 '+var_sCnt+'</th>';
			rslt02 += fn_makeOfKrEng("평가항목", valueData.OUTCOME_KR, valueData.OUTCOME_EN);
			rslt02 += fn_makeOfKrEng("평가시기", valueData.TIMEPOINT_KR, valueData.TIMEPOINT_EN);
			rslt02 += '</tr>';
		}
	}
	
	resultStr = rslt01 + rslt02;
	return resultStr;
}

var tCnt = 0;
function fn_thesis(resArr){
	var resultStr = "";
	var keyArr = [];
	var valueArr = resArr;
	
	keyArr = Object.keys(resArr);
	keyArr.sort();
	
	for(var i=0 ; i<keyArr.length; i++){
		tCnt++;
		var idx = keyArr[i];
		var valDt = valueArr[idx];
		var str = "";
		resultStr += '<tr><th>논문 '+tCnt+'</th>';
		resultStr += '<td>'+valDt.PAPER_AUTHOR +', '+ valDt.PAPER_TITLE +', '+ valDt.JOURNAL_TITLE +', '+ fn_bool(valDt.JOUNAL_GUBUN_PAPER_YN) + ",&nbsp; VOL : "+ fn_bool(valDt.PAPER_VOL) + ",&nbsp; PAGE : " +fn_bool( valDt.PAPER_START_PAGE) +"~"+ fn_bool(valDt.PAPER_END_PAGE);
		(valDt.PAPER_URL != "" && valDt.PAPER_URL != null ) ? str= "</br>( " + valDt.PAPER_URL + " )" : str = "&nbsp;";
		resultStr += str+'</td></tr>';
	}
	return resultStr;
}

function fn_bool(data){
	var result = "";
	
	if( data != "" && data != null ){
		result = data;
	} else {
		result = "&nbsp;";
	}
	return result;
}

</script>
</html>