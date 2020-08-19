<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">

function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;

            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('address').value = fullAddr;

            // 커서를 상세주소 필드로 이동한다.
            document.getElementById('address2').focus();
        }
    }).open();
}

$(function(){
	var fl = "${ptlInformVo.newDataYn}";
	morepage('agreeHtmlFre',fl);
});
function morepage(gubun, flag) {
	
	if (gubun == "agreeHtmlFre") {
		if ($(".agreeHtml").is(":hidden") && flag == "0") {
			$(".agreeHtml").slideDown("fast");
			$(".agreeHtmlFre").slideUp("fast");
		} 
		else if (flag == "1") {
			$(".agreeHtml").slideUp("fast");
			$(".agreeHtmlFre").slideDown("fast");
		}
	} 
	
}	

var IS_SUBMIT = false;

function Enter_Check(){
    // 엔터키의 코드는 13입니다.
if(event.keyCode == 13){
	fncMemberIn();  // 실행할 이벤트
}
}

function fncMemberIn() {
	
	if ($("#brthdy").val() == "") {
		alert("생년월일을 입력하여 주시기 바랍니다.");
		$("#brthdy").focus();
		return;
	}	
	
		
	if ($("#mbtlnum").val() == "") {
		alert("휴대폰 번호를 입력하여 주시기 바랍니다.");
		$("#mbtlnum").focus();
		return;
	}	
	if ($("#insttsn").val() == "") {
		alert("기관을 선택하여 주시기 바랍니다.");
		$("#insttsn").focus();
		return;
	}	

	if ($("#email1").val() == "") {
		alert("이메일 주소를 입력하여 주시기 바랍니다.");
		$("#email1").focus();
		return;
	}
	if ($("#email2").val() == "") {
		alert("이메일 주소를 입력하여 주시기 바랍니다.");
		$("#email2").focus();
		return;
	}	 
 
    if( confirm("수정내용을 적용하시겠습니까?") ){
   	    $.ajax({
 		    url: '${ctxt}/member/regi/infoMemberEdit.do',
 		    data: $("form[name=reqForm]").serialize(),  
 		    type: 'POST',
 		    async : false, //폼 등록은 동기화가 맞아야하므로 false
 		    dataType: 'text',
 		    cache: false,
 		    success: function(result) {
 				  if(result == "Y"){// 성공  					
 					  alert("수정 되었습니다.");
 				  }else if(result =="F"){ 					  
 					  alert("수정에 실패하였습니다."); 					  
 				  }
 		   },
 		   error : function(){ // Ajax 전송 에러 발생시 실행
 		     fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
 		   }
 		});
	 }		
}


var codeCheck = function(acCode) {//비밀번호 구성 조건(영문,숫자,특수문자 하나 이상 포함하여 9자리 이상으로 입력)
	var pattern1 = /[a-zA-Z]{1,}/g ;
	var pattern2 = /[^0-9a-zA-Zㄱ-ㅎㅏ-ㅣ가-힝]{1,}/g ;
	var pattern3 = /[0-9]{1,}/g ;
	var pattern4 = /[ㄱ-ㅎㅏ-ㅣ가-힝]{1,}/g ;
	var acCodeHanName ="비밀번호";
	var returnVal = false; 
	
	if (!pattern1.test(acCode)) {
		alert(acCodeHanName + "는 영문을 포함하여 입력 하셔야 합니다.");
	}
	else if (!pattern2.test(acCode)) {
		alert(acCodeHanName + "는 특수문자를 포함하여 입력 하셔야 합니다");
	}
	else if (!pattern3.test(acCode)) {
		alert(acCodeHanName + "는 숫자를 포함하여 입력 하셔야 합니다.");
	}
	else if (pattern4.test(acCode)) {
		alert(acCodeHanName + "는 한글을 쓸 수 없습니다.");
	}
	else if (acCode.length < 9) {
		alert(acCodeHanName + "는 9자리 이상으로 입력 하셔야 합니다.");
	}
	else {
		returnVal = true;
	}
	
	return returnVal;

};

$(function(){
	//이메일 박스
	$("select[name=selEmailOpt]").change(function() {
		if ($(this).val() == "direct") {
			$("#email2").attr("readonly", false);
			$("#email2").css("background-color", "#FFFFFF");
			$("#email2").val("");
			$("#email2").focus();
		} else {
			$("#email2").val($(this).val());
			$("#email2").attr("readonly", true);
			$("#email2").css("background-color", "#F1F1F1");
		}
	});
	
	$("input[name=mbtlnum]").on("blur", function(){
		var trans_num = $(this).val().replace(/-/gi,'');
			if(trans_num != null && trans_num != ''){
				if(trans_num.length==11 || trans_num.length==10) {
					var regExp_ctn = /^01([016789])([1-9]{1})([0-9]{2,3})([0-9]{4})$/;
					if(regExp_ctn.test(trans_num)){
						trans_num = $(this).val().replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3");
						$(this).val(trans_num);
					}else{
						alert("유효하지 않은 전화번호 입니다.");
						$(this).val("");
						$(this).focus();
					}
				}else{
					alert("유효하지 않은 전화번호 입니다.");
					$(this).val("");
					$(this).focus();
				}
			}
		});	

	$("input[name=telno]").on("blur", function(){
		var trans_num = $(this).val().replace(/-/gi,'');
			if(trans_num != null && trans_num != ''){
				if(trans_num.length==11 || trans_num.length==10) {
					var regExp_ctn = /^0([0-9])([1-9]{1})([0-9]{2,3})([0-9]{4})$/;
					if(regExp_ctn.test(trans_num)){
						trans_num = $(this).val().replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3");
						$(this).val(trans_num);
					}else{
						alert("유효하지 않은 전화번호 입니다.");
						$(this).val("");
						$(this).focus();
					}
				}else{
					alert("유효하지 않은 전화번호 입니다.");
					$(this).val("");
					$(this).focus();
				}
			}
		});	
	
	$("input[name=brthdy]").on("blur", function(){
			var num = $(this).val();
			if(/[^0123456789]/g.test(num)) {
				alert("유효하지 않은 생년월일 입니다.")
				$(this).val("");
				$(this).focus();
			  }
		});	
});

</script>

<form name="reqForm" method="post">
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>회원정보수정</span>
			<span> > </span>
			<span class="active">회원정보 변경</span>        			      
		</div>
		<span class="center_text_01">회원정보 변경</span>
	</div> 
	<div class="under_bar"></div>
			
			<div class="content_wrap">
				<div class="content_box">
					<div class="content_list">
			<div class="content_list table">	
				<div id="divRefreshArea">
					<span class="essential"><font style="color: red">*</font>필수 입력사항</span>		
					<table class="view_table">
						<caption>회원정보 수정</caption>
						<colgroup>
							<col width="136px">
							<col width="319px">
							<col width="136px">
							<col width="319px">
						</colgroup>
						<tbody class="report">
							<tr>
								<th colspan="1" style="width:136px">
									<label for="user_id">아이디</label> <font style="color:red">*</font>
								</th>
								<td colspan="1">
									<input name="user_id" type="text" id="user_id" value="${userVo.loginid}" disabled="disabled"/>
								</td>
								<th colspan="1">
									<label for="emplyrnm">이름</label><font style="color:red">*</font>
								</th>
								<td colspan="1" class="padding_l">
									<input name="emplyrnm" type="text" id="emplyrnm" value="${userVo.emplyrnm}" maxlength="50"  disabled="disabled" />
								</td>
							</tr>	
							<tr>
								<th>
									<label for="brthdy">생년월일</label> <font style="color:red">*</font>
								</th>
								<td colspan="3">
									<input name="brthdy" type="text" id="brthdy" value="<c:out value="${ptlInformVo.brthdy}"/>" onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"  maxlength="8" placeholder="(예:19800101)" style="width: 281.63px;"/> 
								</td>
<!-- 								<th> -->
<!-- 									<label for="sex">성 별</label> <font style="color:red">*</font> -->
<!-- 								</th> -->
<!-- 								<td class="padding_l"> -->
<%-- 									<input name="sex" id="sex1" type="radio" value="M"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"<c:if test="${ptlInformVo.sex == 'M'}">checked</c:if> /><label for="sex1">남자</label> --%>
<%-- 					  			    <input name="sex" id="sex2" type="radio" value="W"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"<c:if test="${ptlInformVo.sex == 'W'}">checked</c:if> /><label for="sex2">여자</label> --%>
<!-- 								</td> -->
							</tr>

							<tr>
								<th colspan="1">
									<label for="mbtlnum">휴대전화</label> <font style="color:red">*</font>
								</th>
								<td colspan="1">
									<input name="mbtlnum" type="text" id="mbtlnum" value="<c:out value="${ptlInformVo.mbtlnum}" />"   maxlength="11"  />
									<p style="margin-top:0;line-height:17px; ">
										<span class="">SMS수신여부</span>
										<input name="smsAgree" id="smsAgree1" type="radio" class="radio_style2 radio" value="1"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"<c:if test="${ptlInformVo.smsAgree == '1'}">checked</c:if> /><label for="smsAgree1">수신</label>
										<input name="smsAgree" id="smsAgree2" type="radio" class="radio_style2 radio" value="0"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"<c:if test="${ptlInformVo.smsAgree == '0'}">checked</c:if> /><label for="smsAgree2">수신 안함</label>
									</p>
								</td>

								<th colspan="1">
									<label for="telno">기관(부서) 전화번호</label>
								</th>
								<td colspan="1" class="padding_l">
									<input name="telno" type="text" id="telno" value="<c:out value="${ptlInformVo.telno}"/>"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }" maxlength="11" />
								</td>
							</tr>		
							<tr>
								<th colspan="1">
									<label for="mouOrg">기관선택</label>
								</th>
								<td colspan="3" class="padding_l">
									<input name="insttsn" type="hidden" id="insttsn" value="<c:out value="${ptlInformVo.insttsn}"/>"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"/>
									<input name="instttyid" type="hidden" id="instttyid" value="<c:out value="${ptlInformVo.instttyid}"/>"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"/>
									<table>
										<caption>
											기관선택
										</caption>
										<colgroup>
											<col width="">
											<col width="">
											<col width="">
											<col width="">
											<col width="">
										</colgroup>
											<tbody>
											<tr class="agency">
												<td style="width:62px;"><label for="mouOrg">소속기관</label> : </td>
												<td style="width:214px; margin-right:10px;"><input name="mouOrg" type="text" id="mouOrg" value="<c:out value="${ptlInformVo.mouOrg}" />" readonly /></td>
												<td style="margin:0 10px;"><label for="mouSub">과</label> : </td>
												<td style="width:228px; margin-right:10px;"><input name="mouSub" type="text" id="mouSub" value="<c:out value="${ptlInformVo.mouSub}" />" readonly /></td>
												<td style="float:right;"><input type="button" name="instchk" alt="기관선택 새창" value=" 기관선택 " class="red"  onclick="popup('${ctxt}/member/regi/InsttsnList.do',1000,700,1);" style="width:172px;"title="기관선택-새창"/></td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>	
							<tr>
								<th colspan="1">
									<label for="">이메일 </label><font style="color:red">*</font>
								</th>
								<td colspan="3" class="padding_l">
									<table>
										<caption>
											이메일 입렵
										</caption>
										<colgroup>
											<col width="">
											<col width="">
											<col width="">
											<col width="">
											<col width="">
											<col width="">
										</colgroup>
											<tbody>
											<tr class="e_mail">
												<td style="width:62px;"><label for="email1" class="blind">이메일ID</label></td>
												<td style=""><input id="email1" name="email1" title="이메일"  type="text" value="<c:out value="${ptlInformVo.email1}"/>"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }" maxlength="30" /></td>
												<td style="padding:0 9px;"><label for="email2" class="blind">@ 이메일주소</label></td>
												<td style="width:228px; margin-right:10px;"><input id="email2" name="email2" title="이메일"  type="text" value="<c:out value="${ptlInformVo.email2}"/>"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }" maxlength="30" /></td>
												<td style="float:right;">
													<select class="" id="email3" name="selEmailOpt" title="주 사용 전자우편(E-mail)" style="width:172px;height:25px;margin-right:0;vertical-align:middle;">
														<option value="">선택해주세요.</option>
														<option value="empal.com">empal.com</option>
														<option value="hotmail.com">hotmail.com</option>
														<option value="naver.com">naver.com</option>
														<option value="gmail.com">gmail.com</option>
														<option value="paran.com">paran.com</option>
														<option value="yahoo.co.kr">yahoo.co.kr</option>
														<option value="nate.com">nate.com</option>
														<option value="hanmail.net">hanmail.net</option>
														<option value="korea.com">korea.com</option>
														<option value="lycos.co.kr">lycos.co.kr</option>
														<option value="dreamwiz.com">dreamwiz.com</option>
														<option value="chollian.net">chollian.net</option>
														<option value="hanafos.com">hanafos.com</option>
														<option value="hanmir.net">hanmir.net</option>
														<option value="direct" selected="selected">직접입력</option>
													</select> 
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
							<tr>
								<th colspan="1">
								<label for="">주소</label><font style="color:red">*</font>
								</th>
								<td colspan="3" class="padding_l" >
									<input type="text" name="zipcode" id="zipcode" value="<c:out value="${ptlInformVo.zipcode}" />"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }" placeholder="우편번호"  style="width:438px;">
									<input type="button" onclick="execDaumPostcode()"  style="width:299.81px;display:inline-block;/*margin-left:14px; */ float:right;margin-top:9px;" value="우편번호 찾기"><br>
									<input type="text" name="address" id="address" value="<c:out value="${ptlInformVo.address}" />"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }" placeholder="주소">
									<input type="text" name="address2" id="address2" value="<c:out value="${ptlInformVo.address2}" />"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }" placeholder="상세주소">
									<span id="guide" style="color:#999"></span>
								</td>
							</tr>
							<tr>
								<th colspan="1">
								<label for="">전자자원 사용</label>
								</th>
								<td colspan="3" class="padding_l" >		
									<input name = "elibagree" id = "elibagree" type="checkbox" class="radio_style2 radio" disabled="disabled" value ="${ptlInformVo.elibagree == 'Y' ? 'Y' : 'N'}"  <c:if test="${ptlInformVo.elibagree == 'Y'}">checked</c:if>/>		
								</td>
							</tr>
							<tr>
								<th colspan="1">
									<label for="">추가 정보</label>
								</th>
								<td colspan="3" class="padding_l">
									<input name="addressAgree" id="addressAgree1" onclick="javascript:morepage('agreeHtmlFre','1');" type="radio" class="radio_style2 radio" value="1"   onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"<c:if test="${ptlInformVo.newDataYn == '1'}">checked</c:if>/><label for="addressAgree1">이용</label>
									<input name="addressAgree" id="addressAgree2"  onclick="javascript:morepage('agreeHtmlFre','0');" type="radio" class="radio_style2 radio" value="0"   onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"<c:if test="${ptlInformVo.newDataYn == '0'}">checked</c:if>/><label for="addressAgree2">이용 안함</label>						
				
								</td>
							</tr>
							<tr class="agreeHtmlFre"  style="display:none">
								<td colspan="4" style="padding:2% 2%;">
									<div>
										<div style="border-bottom: 1px solid #CCDDED; border-top: 1px solid #CCDDED;">
											<span class=" ">직업</span> &nbsp;&nbsp;
											<select class="sel01" id="job" name="job" title="직업" style="position: relative; background-color:yellow; width:110px;" >
												<option value="">-선택해주세요-</option>
												<option value="일반인" <c:if test="${ptlInformVo.job == '일반인'}">selected</c:if>>일반인</option>
												<option value="공무원" <c:if test="${ptlInformVo.job == '공무원'}">selected</c:if>>공무원</option>
												<option value="학생" <c:if test="${ptlInformVo.job == '학생'}">selected</c:if>>학생</option>
												<option value="교수" <c:if test="${ptlInformVo.job == '교수'}">selected</c:if>>교수</option>
												<option value="연구원" <c:if test="${ptlInformVo.job == '연구원'}">selected</c:if>>연구원</option>
												<option value="의사" <c:if test="${ptlInformVo.job == '의사'}">selected</c:if>>의사</option>
												<option value="외국인" <c:if test="${ptlInformVo.job == '외국인'}">selected</c:if>>외국인</option>
											</select>
										</div>									
									
										<div class="login_tab_1" style="border-bottom: 1px solid #CCDDED;">
											<span class="font_f12_bold inform_menuicon2">공지사항/새소식 수신여부</span> &nbsp;&nbsp;
											<input name="newDataYn" id="newDataYn1"  type="radio" class="radio_style2 radio" value="1"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"<c:if test="${ptlInformVo.newDataYn == '1'}">checked</c:if> /><label for="newDataYn1">이용</label>
											<input name="newDataYn" id="newDataYn2"  type="radio" class="radio_style2 radio" value="0"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"<c:if test="${ptlInformVo.newDataYn == '0'}">checked</c:if> /><label for="newDataYn2">이용 안함</label>
											<label for="isCheck01" class="blind"  style="display: none;" >센터 부가정보 이용 여부</label>
											<input name="isCheck01" id="isCheck01" type="hidden" value="1" />
					
											&nbsp;(홈페이지 최신 공지사항이나 새소식을 메일로 받을 수 있습니다.)
											
										</div>
										
<!-- 										<div style="border-bottom: 1px solid #CCDDED;"> -->
<!-- 											<span class="font_f12_bold inform_menuicon2">내외국인 구분</span> &nbsp;&nbsp; -->
<%-- 											<input name="foreign" id="fAgree1" type="radio" value="N"    onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"<c:if test="${ptlInformVo.foreign == 'N'}">checked</c:if> /><label for="fAgree1">내국인</label> --%>
<%-- 											<input name="foreign" id="fAgree2"  type="radio" value="Y"   onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"<c:if test="${ptlInformVo.foreign == 'Y'}">checked</c:if> /><label for="fAgree2">외국인</label> --%>
<!-- 										</div> -->
										
										
									</div>		 
									<div class="agreeHtml"> </div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			
			<div class="btn-group">
				<a id="memberIn" class="basic-btn" href="javascript:fncMemberIn();" >회원정보수정</a>
			</div> 
			
			</div>
			</div>
			</div>
	
	
	
	<!-- 추가 PARAM -->
	<input type="hidden" name="mbtlnumYn" id="mbtlnumYn"  value="${ptlInformVo.mbtlnumYn}"  />	
	<input type="hidden" name="ageAgree" id="ageAgree"  value="${ptlInformVo.ageAgree}"  />		
	<input type="hidden" name="newDataCnt" id="newDataCnt"  value="${ptlInformVo.newDataCnt}"  />
	<input type="hidden" name="pmcAgree" id="pmcAgree"  value="${ptlInformVo.pmcAgree}"  />
	<input type="hidden" name="orcid" id="orcid"  value="${ptlInformVo.orcid}"  />
	<input type="hidden" name="seNumber" id="seNumber"  value="${ptlInformVo.seNumber}"  />
	<input type="hidden" name="pmc" id="pmc"  value="${ptlInformVo.pmc}"  />
	
   
	<!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" />
	
</form>
