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

var IS_SUBMIT = false;


function idChk() {

	if ($("#user_id").val() == "") {
		alert("사용자 ID를 입력하여 주시기 바랍니다.");
		$("#user_id").focus();
		return;
	}
	if ($("#user_id").val().length < 4) {
		alert("사용자 ID는 4자리 이상 입력하여 주시기 바랍니다.");
		$("#user_id").focus();
		return;
	}		
	
	var params = {};
		params.loginid = $('#user_id').val();
	
		$.ajax({
		    url: '${ctxt}/member/regi/memChk.do',
		    data: params,
		    type: 'POST',
		    dataType: 'text',
		    cache: false,
		    success: function(result) {
		    	
				if(result == "Y"){// 중복 
					
					alert("사용 불가능한 ID입니다.\n다른 ID를 사용해 주세요.");
				    $("#user_id").val("");
				    $("#idChkVal").val("");
					
				}else if(result =="N"){ // 사용가능 		
					
					alert("사용 가능한 ID입니다.");
					$("#idChkVal").val("Y");
				}else{	
					
					alert("아이디를 입력해 주십시오.");
				    $("#user_id").val("");
				    $("#idChkVal").val("");
				}
		    },
		    error : function(){                              // Ajax 전송 에러 발생시 실행
		      fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
		    }
		});
	
	
}	

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


// 회원가입
function fncMemberIn() {

	
	var checkVal = new Array();
	checkVal[0] = "사용자 ID를 입력하여 주시기 바랍니다.";
	checkVal[1] = "사용자 ID 중복확인을 하여 주시기 바랍니다.";
	checkVal[2] = "사용자 ID는 4자리 이상 입력하여 주시기 바랍니다.";
	checkVal[3] = "이름을 입력하여 주시기 바랍니다.";
	checkVal[4] = "비밀번호를 입력하여 주시기 바랍니다.";
	checkVal[5] = "비밀번호 확인을 입력하여 주시기 바랍니다.";
	checkVal[6] = "비밀번호와 비밀번호 확인이 다릅니다.";
	checkVal[7] = "생년월일을 입력하여 주시기 바랍니다.";
// 	checkVal[8] = "성별을 입력하여 주시기 바랍니다.";
	checkVal[9] = "휴대폰 번호를 입력하여 주시기 바랍니다.";
	checkVal[10] = "기관을 선택하여 주시기 바랍니다.";
	checkVal[11] = "이메일 주소를 입력하여 주시기 바랍니다.";
	checkVal[12] = "개인정보 수집(이용)에 동의를 하셔야 회원 가입이 가능합니다.";
	checkVal[13] = "처리중 입니다!";
	checkVal[14] = "주소를 입력하여 주시기 바랍니다.";
	checkVal[15] = "상세주소를 입력하여 주시기 바랍니다.";
	
	if ($("#user_id").val() == "") {
		alert(checkVal[0]);
		$("#user_id").focus();
		return;
	}	
	
	if ($("#idChkVal").val() == "") {
		alert(checkVal[1]);
		$("#idchk").focus();
		return;
	}	
	
	
	if ($("#user_id").val().length < 4) {
		alert(checkVal[2]);
		$("#user_id").focus();
		return;
	}	
	if ($("#emplyrnm").val() == "") {
		alert(checkVal[3]);
		$("#emplyrnm").focus();
		return;
	}	
	if ($("#password").val() == "") {
		alert(checkVal[4]);
		$("#password").focus();
		return;
	}	
	
	var check = codeCheck($("#password").val());   //비밀번호 유효성체크
	if (!check) {
		$("#password").focus();
		return;
	}
	
	
	if ($("#password2").val() == "") {
		alert(checkVal[5]);
		$("#password2").focus();
		return;
	}	
	if ($("#password").val() != $("#password2").val()) {
		alert(checkVal[6]);
		$("#password2").focus();
		return;
	}	


	if ($("#brthdy").val() == "") {
		alert(checkVal[7]);
		$("#brthdy").focus();
		return;
	}	
	
// 	if ($('input:radio[name=sex]').is(':checked')) {

// 	} else {
// 		alert(checkVal[8]);
// 		$("#sex1").focus();
// 		return;
// 	}	
	
	if ($("#mbtlnum").val() == "") {
		alert(checkVal[9]);
		$("#mbtlnum").focus();
		return;
	}	
	if ($("#insttsn").val() == "") {
		alert(checkVal[10]);
		$("#insttsn").focus();
		return;
	}	

	if ($("#email1").val() == "") {
		alert(checkVal[11]);
		$("#email1").focus();
		return;
	}
	if ($("#email2").val() == "") {
		alert(checkVal[11]);
		$("#email2").focus();
		return;
	}	
	
	if($("#address").val() == ""){
		alert(checkVal[14]);
		$("#address").focus();
		return;
	}
	
	if($("#address2").val() == ""){
		alert(checkVal[15]);
		$("#address2").focus();
		return;
	}
	
	if ($("#isCheck01").val() == "1") {
		if (!$("#information").is(":checked")) {
			alert(checkVal[12]);
			$("#information").focus();
			return;
		}
	}	 
	IS_SUBMIT = true;
    
	if( IS_SUBMIT )	{
   	    $.ajax({
 		    url: '${ctxt}/member/regi/addPtlEmplyr.do',
 		    data: $("form[name=reqForm]").serialize(),  
 		    type: 'POST',
 		    dataType: 'text',
 		    cache: false,
 		    success: function(result) {
 		    	 		
 				  if(result == "Y"){// 성공  					
 					  alert("회원 가입이 완료 되었습니다. 로그인 페이지로 이동합니다.");
 					  location.href = "${ctxt}/login/user/login.do";
 				  }else if(result =="PHONE"){ // 사용가능 		 					
 					  alert("이미 가입하신 휴대전화번호 입니다."); 					   					  
 				  }else if(result =="ID"){	 					
 					  alert("회원ID가 중복 되었습니다. 다른 회원ID로 가입하시기 바랍니다."); 				    
 				  }else if(result =="F"){ 					  
 					  alert("회원가입이 실패하였습니다."); 					  
 				  }
 				  
 		   },
 		   error : function(){                              // Ajax 전송 에러 발생시 실행
 		     fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
 		   }
 	});
	 		
 		
	  }	else {
		  alert(checkVal[13]);
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
<style>
.e_mail:after,
.address_box:after{
	display:block;
	content:"";
	clear:both;
}
   
</style>
<form name="reqForm" method="post">
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>로그인</span>
			<span> > </span>
			<span class="active">회원가입</span>        			      
		</div>
		<span class="center_text_01">회원가입</span>
	</div> 
	<div class="under_bar"></div>
	
	<div class= "content_wrap">
		<div class="content_box">
			<div class="content_list">
			<div class="notice_box" style="margin-bottom: 0px">   
				 - 국립의과학 지식센터는 회원에 한해 홈페이지내 서비스 이용 및 전자자원서비스를 이용하실 수 있습니다.
			</div>
			<div class="content_list table">	
				<div id="divRefreshArea">       
					<span class="essential"><font style="color: red">*</font>필수 입력사항</span>		
					<table class="view_table">
						<caption>회원가입</caption>
						<colgroup>
							<col style="width:15%;">
							<col style="width:35%;">
							<col style="width:15%;">
							<col style="width:30%;">
						</colgroup>
						<tbody class="report">
							<tr>
								<th>
									<label for="user_id">아이디</label> <font style="color:red">*</font>
								</th>
								<td class="padding_l" colspan="3">
									<input name="user_id" type="text" id="user_id" value=""  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"/>
									<input name="idChkVal" type="hidden" id="idChkVal" value="" />
									<input type="button" name="idchk" id="idchk" value=" ID중복확인 "  onclick="idChk()" />
								</td>
							</tr>	
							<tr>
								<th >
									<label for="emplyrnm">이름</label><font style="color:red">*</font>
								</th>
								<td class="padding_l" colspan="3">
									<input name="emplyrnm" type="text" id="emplyrnm" value="" maxlength="50"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"/>
								</td>
							</tr>	
							<tr>
								<th>
									<label for="password">비밀번호</label> <font style="color:red">*</font>
								</th>
								<td class="padding_l" colspan="3">
									<div>
									<input name="password" type="password" id="password" autocomplete="off" value=""  maxlength="20"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"/> 
									<p style="font-size:12px; padding-left:0;line-height:17px; letter-spacing:-0.5px; margin-top:0;">* 영문, 숫자, 특수문자를 각 한문자 이상 포함하여 9자리 이상으로 입력 하세요.</p> 
									</div>
								</td>
							</tr>
							<tr>	
								<th>
									<label for="password2">비밀번호 확인</label> <font style="color:red">*</font>
								</th>
								<td class="padding_l" colspan="3">
									<input name="password2" type="password" id="password2" autocomplete="off" value=""  maxlength="20"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"/>
								</td>
							</tr>	
							<tr>
								<th>
									<label for="brthdy">생년월일</label> <font style="color:red">*</font>
								</th>
								<td class="padding_l" colspan="3">
									<input name="brthdy" type="text" id="brthdy" value=""  maxlength="8"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }" placeholder="(예:19800101)" > 
									<!-- <p style="font-size:12px; padding-left:0;line-height:17px; letter-spacing:-0.5px; margin-top:0;">(예:19800101)</p> --> 
								</td>
							</tr>

							<tr>
								<th >
									<label for="mbtlnum">휴대전화</label> <font style="color:red">*</font>
								</th>
								<td class="padding_l" colspan="3">
									<input name="mbtlnum" type="text" id="mbtlnum" value=""   maxlength="11"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }" />
									<p style="margin-top:0;line-height:17px; ">
										<span class="">SMS수신여부</span>
										<input name="smsAgree" id="smsAgree1" type="radio"  class="radio_style2 radio" value="1"   onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"/><label for="smsAgree1">수신</label>
										<input name="smsAgree" id="smsAgree2" type="radio" class="radio_style2 radio" value="0" checked  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"/><label for="smsAgree2">수신 안함</label>
									</p>
								</td>
							</tr>
							<tr>
								<th >
									<label for="telno">기관(부서) 전화번호</label>
								</th>
								<td  class="padding_l">
									<input name="telno" type="text" id="telno" value=""   maxlength="11"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"/>
								</td>
							</tr>		
							<tr>
								<th >
									<label for="mouOrg">기관선택</label>
								</th>
								<td class="padding_l" colspan="3">
									<input name="instttyid" type="hidden" id="instttyid" value="8"   />
									<input name="insttsn" type="hidden" id="insttsn" value="72259"  />
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
												<td style=""><label for="mouOrg">소속기관</label> : </td>
												<td style=" margin-right:10px;"><input name="mouOrg" type="text" id="mouOrg" value="기타기관" readonly  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }" /></td>
												<td style="margin:0 10px;"><label for="mouSub">과</label> : </td>
												<td style="margin-right:10px;"><input name="mouSub" type="text" id="mouSub" value="기타기관" readonly  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"/></td>
												<td style="margin-left:10px;"><input type="button" name="instchk" alt="기관선택 새창" value=" 기관선택 " class="red"  onclick="popup('${ctxt}/member/regi/InsttsnList.do?searchCondition=0',1000,700,1);" style="width:172px;"title="기관선택-새창"/></td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>	
							<tr>
								<th >
									<label for="">이메일 </label><font style="color:red">*</font>
								</th>
								<td class="padding_l" colspan="3">
									<table>
										<caption>
											이메일 입력
										</caption>
										<colgroup>
											<col width="">
										</colgroup>
											<tbody style="width:100%;">
											<tr class="e_mail" style="width:100%;">
												<td style="">
													<input id="email1" name="email1" title="이메일"  type="text" rows="15" value="" maxlength="30"   onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"/>
												</td>
												<td>   @</td>   
											</tr>     
											<tr class="e_mail" style="width:100%;">	     
												<td style="margin-right:10px;" colspan="2"><input id="email2" style="width: 80%;" name="email2" title="이메일"  type="text" rows="15" value="" maxlength="30"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"/>
													<select class="" id="email3" name="selEmailOpt" title="주 사용 전자우편(E-mail)" style="width:200px;height:25px;margin-right:0;vertical-align:middle;">
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
								<th >
								<label for="">주소</label><font style="color:red">*</font>
								</th>
								<td class="padding_l" colspan="3">
									<ul class="address_box">
										<li><input type="text" name="zipcode" id="zipcode"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }" placeholder="우편번호" >
										<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" style="display:inline-block;/*margin-left:14px; */ float:right;margin-top:9px;"></li>
										<li><input type="text" name="address" id="address"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }" placeholder="주소"></li>
										<li><input type="text" name="address2" id="address2"  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }" placeholder="상세주소"></li>
										<!-- <span id="guide" style="color:#999"></span> -->
									</ul>
								</td>
							</tr>		
							<tr>
								<th >
									<label for="">추가 정보</label>
								</th>
								<td class="padding_l" colspan="3">
									<input name="addressAgree" id="addressAgree1" onclick="javascript:morepage('agreeHtmlFre','1');" type="radio" class="radio_style2 radio" value="1" onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }" /><label for="addressAgree1">이용</label>
									<input name="addressAgree" id="addressAgree2"  onclick="javascript:morepage('agreeHtmlFre','0');" type="radio" class="radio_style2 radio" value="0" onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }" checked /><label for="addressAgree2">이용 안함</label>						
								</td>
							</tr>
							<tr class="agreeHtmlFre"  style="display:none">
								<td colspan="4" style="padding:2% 2%;">
									<div>
										<div style="border-bottom: 1px solid #CCDDED; border-top: 1px solid #CCDDED;">	
											<span class=" ">직업</span> &nbsp;&nbsp;
											<select class="sel01" id="job" name="job" title="직업" style="position: relative; background-color:yellow;" >
												<option value="">-선택해주세요-</option>
												<option value="일반인">일반인</option>
												<option value="공무원">공무원</option>
												<option value="학생">학생</option>
												<option value="교수">교수</option>
												<option value="연구원">연구원</option>
												<option value="의사">의사</option>
												<option value="외국인">외국인</option>
											</select>
										</div>
									
										<div class="login_tab_1" style="border-bottom: 1px solid #CCDDED;">
											<span class="font_f12_bold inform_menuicon2">공지사항/새소식 수신여부</span> &nbsp;&nbsp;
											<input name="newDataYn" id="newDataYn1"  type="radio" value="1" onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }" /><label for="newDataYn1">이용</label>
											<input name="newDataYn" id="newDataYn2"  type="radio" value="0" onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }" checked /><label for="newDataYn2">이용 안함</label>
											<label for="isCheck01" class="blind">센터 부가정보 이용 여부</label>
											<input name="isCheck01" id="isCheck01" type="hidden" value="1" />
											&nbsp;(홈페이지 최신 공지사항이나 새소식을 메일로 받을 수 있습니다.)
										</div>
										
<!-- 										<div style="border-bottom: 1px solid #CCDDED;"> -->
<!-- 											<span class="font_f12_bold inform_menuicon2">내외국인 구분</span> &nbsp;&nbsp; -->
<!-- 											<input name="foreign" id="fAgree1" type="radio" value="N" checked  onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"/><label for="fAgree1">내국인</label> -->
<!-- 											<input name="foreign" id="fAgree2"  type="radio" value="Y"   onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"/><label for="fAgree2">외국인</label> -->
<!-- 										</div> -->
										
									</div>		 
									<div class="agreeHtml"> </div>
								</td>
							</tr>
							<tr>
								<th >
									<span class=" ">이용약관</span>
								</th>
								<td class="padding_l" colspan="3">
									<table>
										<caption>
											이용약관동의
										</caption>
										<colgroup>
											<col width="100%">
										</colgroup>
											<tbody>
											<tr>
												<td><p class="" title="개인정보 수집(이용) 및 동의 안내" style="margin-bottom:0;line-height:17px;">개인정보 수집 및 이용에 관한 안내</p></td>
											</tr>
											<tr>	
												<td>
													<textarea id="infotxt" name="infotxt" style="width:100%; max-width:748px;height: 100px; font-size:13px; color:#666; letter-spacing:-0.5px;" readonly  title="개인정보 수집(이용) 및 동의 안내">
[개인정보의 수집•이용목적]
가. 홈페이지 회원에게 의과학 지식정보 서비스 제공
나. 개인식별,민원처리,고지사항 전달

[수집하는 개인정보의 항목]
가. 필수항목 : 아이디, 이름, 성별, 휴대폰번호, 생년월일, 주소, 전자우편
나. 선택항목 : 근무지 주소, 근무지 전화번호, 근무처, 부서명, 학교명

[개인정보의 보유 및 이용 기간]
회원 탈퇴 시 까지

개인정보의 수집을 거부할 수 있으며, 거부할 경우 서비스 이용이 제한됩니다.													

</textarea>
												</td>
											</tr>
											<tr>
												<td>
													<p style="margin-top:0;line-height:17px;">
														<label for="information" class="blind">개인정보 수집•이용에 동의하십니까?</label>
														<input type="checkbox" id="information" style="width:15px; heihgt:15px;margin:0 10px;" name="agree" value="1" onkeypress="if(event.keyCode == 13){ fncMemberIn(); return; }"/>동의함</p>
													</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="btn-group">
				<a href="javascript: fncMemberIn();" class="basic-btn">회원가입</a>
			</div>
			
		</div>
	
	</div>
</div>
	
</form>
