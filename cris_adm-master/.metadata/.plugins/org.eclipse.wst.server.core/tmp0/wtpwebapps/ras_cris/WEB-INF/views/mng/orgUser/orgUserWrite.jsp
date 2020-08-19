<%@page import="kr.go.cris.commons.constants.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>기관담당자신규등록 | 정부출연연구기관 채용정보서비스</title>

<link rel="stylesheet" href="${ctxt}/resources/css/jquery-ui.css">
<script type="text/javascript" src="${ctxt}/resources/js/rsa/jsbn.js"></script>
<script type="text/javascript" src="${ctxt}/resources/js/rsa/rsa.js"></script>
<script type="text/javascript" src="${ctxt}/resources/js/rsa/prng4.js"></script>
<script type="text/javascript" src="${ctxt}/resources/js/rsa/rng.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<script type="text/javascript">

$(function() {
	$('input').keyup(fn_checkBtn);
	$('input').click(fn_checkBtn);
	
/* 	// 캘린더 - 생년월일
 	$(function() {
		$( "#brth_dt" ).datepicker({
		showOn: "button",
		buttonImage: "${ctxt}/resources/img/common/ico_dal.png",
		buttonImageOnly: true,
		changeYear: true,
		changeMonth: true,
		buttonText: "Select date",
		dateFormat: 'yy-mm-dd'
		});
	}); 

	// 캘린더 - 졸업 예정일자
	$(function() {
		$( "#gradu_dt" ).datepicker({
		showOn: "button",
		buttonImage: "${ctxt}/resources/img/common/ico_dal.png",
		buttonImageOnly: true,
		changeYear: true,
		changeMonth: true,
		buttonText: "Select date",
		dateFormat: 'yy-mm-dd'
		});
	});  */
	
}); 

// 아이디(e-mail) 중복확인 버튼 체크
function fn_idInput(){
    $("#checkedYN").val("");
    $("#idchekInput").children("span").remove();
    $("#idchekInput").append('<span class="checkMsg none">E-mail 중복 확인이 필요합니다.</span>');
  }

// E-mail 도메인 자동 셋팅
function fn_mailDomainChange(){
	if($('#mail_domain_sel').val() != ''){
		$('#mail_domain').val($('#mail_domain_sel').val());
		$('#mail_domain').prop('disabled',true);	
		return;
	}else{
		$('#mail_domain').val('');
		$('#mail_domain').prop('disabled',false);	
	}
}


// 비밀번호 체크 1
function fn_pwCheck(){

    var regPw = /([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/;
    $("#pWCheck_new").html('<span class="checkMsg ok" id="pWCheck_new"></span>');
    $("#checkedPwYN").val("N");
    var SamePass_0 = 0; //동일문자 카운트
    var SamePass_1 = 0; //연속성(+) 카운드
    var SamePass_2 = 0; //연속성(-) 카운드
    var chr_pass_0;
    var chr_pass_1;
    var chr_pass_2;

    if($('#user_pwd').val().length <  10 || $('#user_pwd').val().length > 20){
      $("#pWCheck").html('<span class="checkMsg error" id="pWCheck">비밀번호는 영문/숫자/특수문자를 섞어 9~20자를 입력하세요.</span>');
      return false;
    }

    if(!$('#user_pwd').val().match(regPw)){
      $("#pWCheck").html('<span class="checkMsg error" id="pWCheck">비밀번호는 영문/숫자/특수문자를 섞어 9~20자를 입력하세요.</span>');
      return false;
    }

    for(var i=0; i < $('#user_pwd').val().length; i++){
      chr_pass_0 = $('#user_pwd').val().charAt(i);
      chr_pass_1 = $('#user_pwd').val().charAt(i+1);

      //동일문자 카운트
      if(chr_pass_0 == chr_pass_1){
        SamePass_0 = SamePass_0 + 1;
      }

      chr_pass_2 = $('#user_pwd').val().charAt(i+2);

      //연속성(+) 카운드
      if(chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == 1 && chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == 1){
        SamePass_1 = SamePass_1 + 1;
      }

      //연속성(-) 카운드
      if(chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == -1 && chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == -1){
        SamePass_2 = SamePass_2 + 1;
      }
    }

    if(SamePass_0 > 1){
      $("#pWCheck").html('<span class="checkMsg error" id="pWCheck">비밀번호는 동일문자를 3번 이상 사용할 수 없습니다.</span>');
      return false;
    }
    $("#checkedPwYN").val("Y");
    $("#pWCheck").html('<span class="checkMsg ok" id="pWCheck">사용하실수 있습니다.</span>');
    return true;
  }

// 비밀번호 체크 2
function fn_pwCheck_new(){
	if($('#user_pwdCheck').val() == ''){
		return;
	}  
	  
    if($('#user_pwd').val() != $('#user_pwdCheck').val()){
       $("#pWCheck_new").html('<span class="checkMsg error" id="pWCheck_new">비밀번호가 서로 맞지 않습니다. 다시 입력하세요.</span>');
       return false;
    }
    $("#pWCheck_new").html('<span class="checkMsg ok" id="pWCheck_new">비밀번호가 일치합니다.</span>');
    return true;
  }

// 전체 체크
function fn_checkBtn(){
    if( $("#user_nm").val() !="" && $("#checkedYN").val() =="Y" && $("#checkedPwYN").val() =="Y" && $("#user_pwd").val() !=""  && $("#user_pwd").val() == $("#user_pwdCheck").val()  && $("#mail_id").val() !="" && $("#mail_domain").val() !=""){
      $("#nextType").removeClass("preStep");
      $("#nextType").addClass("nextStep");
    }else{
      $("#nextType").removeClass("nextStep");
      $("#nextType").addClass("preStep");
    }
  }

//아이디(e-mail) 중복 체크
function fn_check(){
	
	// e-mail NULL 체크
	if($("#mail_id").val() == ""){
		fn_alert("E-mail을 입력 하세요.",'c');
		$("#mail_id").focus();
		return;
	}
	
	// e-mail NULL 체크
	if($("#mail_domain").val() == ""){
		fn_alert("E-mail 도메인을 입력 하세요.",'c');
		$("#mail_domain").focus();
		return;
	}
	
	// e-mail 공백 체크
	if ($("#mail_id").val().replace(/ /gi, "") == "") {
		fn_alert("E-mail은 공백으로만 이루어 질수 없습니다.",'c');
		$("#mail_id").val("");
		$("#mail_id").focus();
		return;
	}
	
	// e-mail 특수문자 체크
	if($('#mail_id').val() != $('#mail_id').val().replace(/[^a-z0-9]/gi,'')){
		fn_alert("E-mail은 영문, 숫자로만 가능합니다.",'c');
		$("#mail_id").focus();
		return;
	}
	
	$("#eml").val($('#mail_id').val() + '@' + $('#mail_domain').val());
	
	//alert($("#eml").val());
	
	// e-mail 중복 체크 액션
	$.ajax({
		url:"${ctxt}/login/selectIdCheck.do",
		data:{"loginid":$("#eml").val()},
		type:"post",
		success:function(data){
			$("#orgloginid").val($("#eml").val());
			//alert(data);
			if(data == 0){
				fn_alert('사용하실수 있습니다.');
				$("#idchekInput").children("span").remove();
				$("#idchekInput").append('<span class="checkMsg ok">입력하신 E-mail는 사용하실 수 있습니다.</span>');
				$("#checkedYN").val("Y");
			}else{
				fn_alert('이미 등록된 E-mail 입니다.');
				$("#idchekInput").children("span").remove();
				$("#idchekInput").append('<span class="checkMsg error">입력하신 E-mail은 이미 사용 중입니다.</span>');
				$("#checkedYN").val("N");
			}
		},
		error:function(ex){
		fn_checkBtn();
		fn_alert('E-mail 중복 체크 실패 \n 관리자에게 문의 바랍니다','e');
		}
	});
	return;
}

// 인재DB등록 저장 버튼
function fn_save(){
	var form = document.form;
	var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	var nonchar = /[^가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z]/gi;
	
	// null체크 - e-mail 
	if ($("#mail_id").val() == '') {
		fn_alert('E-mail을 입력하세요','c');
		$("#mail_id").focus();
		return;
	}
	
	// null체크 - e-mail 
	if ($("#mail_domain").val() == '') {
		fn_alert('E-mail 도메인을 입력하세요','c');
		$("#mail_domain").focus();
		return;
	}
	
	// null체크 - 비밀번호 
	if($('#user_pwd').val() == ''){
		fn_alert('비밀번호를 입력하세요.','c');
		$('#user_pwd').focus();
		return;
	}
	
	// null체크 - 비밀번호 확인
	if($('#user_pwdCheck').val() == ''){
		fn_alert('비밀번호를 다시한번 입력하세요.','c');
		$('#user_pwdCheck').focus();
		return;
	}
	
	// null체크 - 비밀번호 확인
/* 	if(!fn_pwCheck()){
		fn_alert('비밀번호는 영문/숫자/특수문자를 섞어 9~20자를 입력하세요.','c');
		$('#user_pwd').focus();
		return;
	} */

	// null체크 - 비밀번호 확인
	if(!fn_pwCheck_new()){
		fn_alert('비밀번호가 서로 맞지 않습니다. 다시 입력하세요.','c');
		return;
	}
	
	// null체크 - 이름
	if($("#user_nm_kor").val() == '') {
		fn_alert('이름를 입력하세요','c');
		$("#user_nm_kor").focus();
		return;
	}

	// null체크 - 이름 => 특수문자 체크
	if (nonchar.test($("#user_nm_kor").val())) {
		fn_alert('이름에는 한글, 영문 대소문자를 이용해 주세요.','c');
		$("#user_nm_kor").focus();
		return ;
	}

	// e-mail - 중복확인 버튼 체크
	if($("#checkedYN").val() == ""){
 		fn_alert("E-mail 중복 확인을 하십시요.",'c');
		return;
	}

	// e-mail - 중복확인 버튼 체크
	if($("#checkedYN").val() == "N"){
		fn_alert("이미 등록된 E-mail 입니다.",'c');
		$("#mail_id").focus();
		return;
	}

    if($("input[name=sms_send_yn]:checked").val() == "Y"){
    	if($("#clpn2").val().length == 0 || $("#clpn3").val().length == 0){
    		fn_alert("SMS문자 서비스를 받을<br /> 휴대폰번호를 입력해주세요",'c');
    		return;
    	}
    }
	// 체크 - 연락처
	if($("#tel2").val().length > 0 || $("#tel3").val().length > 0){
       /*핸드폰 번호 길이 체크*/
         if($("#tel2").val().length<=2 || $("#tel3").val().length!=4){
           fn_alert("전화번호를 제대로 입력해주세요",'c');
           $("#tel2").focus();
           return;
         }
           /*핸드폰이 숫자만 들어가는지 체크*/
         if(isNaN($("#tel2").val()) || isNaN($("#tel3").val())){
           fn_alert("전화번호는 숫자만 들어갈 수 있습니다.",'c');
           $("#tel2").focus();
           return;
         }
           /**/
         if($("#tel2").val().length > 2 || $("#tel3").val().length==4){

           var phone = $("#tel1").val() +"-"+ $("#tel2").val() +"-"+ $("#tel3").val();

            $("#usrPhone").val(phone);
         }
     }

     if($("#clpn2").val().length > 0 || $("#clpn3").val().length > 0){
       /*핸드폰 번호 길이 체크*/
         if($("#clpn2").val().length<=2 || $("#clpn3").val().length!=4){
           fn_alert("휴대폰번호를 제대로 입력해주세요",'c');
           $("#clpn2").focus();
           return;
         }
           /*핸드폰이 숫자만 들어가는지 체크*/
         if(isNaN($("#clpn2").val()) || isNaN($("#clpn3").val())){
           fn_alert("휴대폰번호는 숫자만 들어갈 수 있습니다.",'c');
           $("#clpn2").focus();
           return;
         }
           /**/
         if ($("#clpn2").val().length > 2 || $("#clpn3").val().length==4){

           var Hp = $("#clpn1").val() +"-"+ $("#clpn2").val() +"-"+ $("#clpn3").val();

             $("#usrHp").val(Hp);
         }
     }


     if(!regEmail.test($('#mail_id').val() + '@' + $('#mail_domain').val())) {
       fn_alert('올바른 전자우편를 입력하세요.','c');
       $('#mail_id').focus();
       return;
     }

     $("#eml").val($('#mail_id').val() + '@' + $('#mail_domain').val());

     $.ajax({ // RSA 공개키 요청
       type: 'GET',
       url : '${ctxt}/cmmn/util/getRSAKey.xml',
       data: {sessionKey: '<%=Constants.RSA_KEY_REGI%>'},
       dateType: 'xml',
       cache: false,
       success: function(data) {
         var xml = $(data);
         if (xml.find('msg').text() == 'success') {
         	var publicKeyModulus = xml.find('publicKeyModulus').text();
         	var publicKeyExponent = xml.find('publicKeyExponent').text();

           var rsa = new RSAKey();
           rsa.setPublic(publicKeyModulus, publicKeyExponent);

           var params = {};
 	          params.org_cd = $('#org_cd').val();								// 기관코드
 	          params.loginid = rsa.encrypt($('#eml').val());					// 이메일(ID)
 	          params.user_pwd = rsa.encrypt($('#user_pwd').val());				// 비밀번호
 	          params.user_nm_kor = rsa.encrypt($('#user_nm_kor').val());		// 이름(국문)
 	          /* params.user_nm_eng = rsa.encrypt($('#user_nm_eng').val()); */
 	          
 	          params.tel1 = rsa.encrypt($('#tel1').val());
 	          params.tel2 = rsa.encrypt($('#tel2').val());
 	          params.tel3 = rsa.encrypt($('#tel3').val());
 	          
 	          params.clpn1 = rsa.encrypt($('#clpn1').val());
 	          params.clpn2 = rsa.encrypt($('#clpn2').val());
 	          params.clpn3 = rsa.encrypt($('#clpn3').val());
 	          
  	         if($("input[name=eml_send_yn]:checked").length != 0){
  	          	params.eml_send_yn = rsa.encrypt($("input[name=eml_send_yn]:checked").val());
  	         }
  	         
  	         if($("input[name=sms_send_yn]:checked").length != 0){
  	          params.sms_send_yn = rsa.encrypt($("input[name=sms_send_yn]:checked").val());
  	         }
 	          
 	          params.eml = rsa.encrypt($('#eml').val()); 

 	          params.cls_gbn_list = $('#org_cd').val();	// 기관 코드
 	          
           $.ajax({ // RSA로 암호화된 개인 정보 전송
             type: 'POST',
             url : '${ctxt}/mng/orgUser/register.do',
             data: params,
             cache: false,    //cache가 있으면 새로운 내용이 업데이트 되지 않는다.
             success:function(data){
               if (data.indexOf('실패') < 0){
            	   
           	   		fn_alert("저장을 완료 하였습니다.");

					setTimeout(fn_load(), 1000);
                	 
               } else {
                 fn_alert(data);
               }
             },
             error: function(xhr, status, error){
            	 fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
             }
           });
         } else {
        	 fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
         }
       },
       error: function(xhr, status, error){
    	   fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
       }
     });
   }
	
	
function fn_load(){
	location.href='${ctxt}/mng/user/userList.do';
}

</script>
</head>

<body>

<div id="container">

	<div id="content">

		<h2>기관담당자등록</h2>

		<h5 class="title">기관담당자정보입력</h5>
		
		<p class="ticor2 m-top0">사항은 필수 입력사항입니다.</p>
			<form id="form" name="form" action="" method="post">
				<input type="hidden" id="cls_gbn_list" name="cls_gbn_list" value="" >
			
				<table class="table-ap" cellspacing="0" cellpadding="0">
				
				<colgroup>
					<col width="20%">
					<col width="30%">
					<col width="20%">
					<col width="30%">
				</colgroup>
				<tbody>
				<tr>
					<th><span>기관</span></th>
					<%-- <c:if test="${org.cd == contsMngDetailView.CONTS_CLSF_CD}">selected</c:if> --%>
					<td colspan="3 "class="left">
						<select name="org_cd" id="org_cd" title="기관" style="width: 140px;" >
							<c:forEach items="${org_list}" var="org" varStatus="state">
								<option value="${org.cd}">${org.cd_nm}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th><span><label for="mail_id">E-mail</label></span></th>
					<td class="left" id="idchekInput" colspan="3">
						<input type="hidden" id="eml" name="eml" value=""> 
						<input type="hidden"id="orgloginid" name="orgloginid" value=""> 
						<input type="hidden" id="checkedYN" name="checkedYN" value="">
						<input type="text" id="mail_id" name="mail_id" value="" onkeydown="fn_idInput();" maxlength="20"> 
						@ 
						<input type="text" id="mail_domain" name="mail_domain" value="" maxlength="20">
						<select name="mail_domain_sel" id="mail_domain_sel" title="전자우편 도메인 선택" onchange="fn_mailDomainChange();" style="width: 140px;" >
							<option value=""><label for="mail_domain">직접입력</label></option>
							<option value="gmail.com">gmail.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="hotmail.com">hotmail.com</option>
							<option value="nate.com">nate.com</option>
							<option value="naver.com">naver.com</option>
						</select>
						<a class="btn_sch" href="javascript:fn_check()">중복확인</a>
						<span class="checkMsg">E-mail 중복 확인 필요합니다.</span> 
						<span class="checkMsg ok" id="checkYes" style="display: none">입력하신 E-mail은 사용하실 수 있습니다.</span> 
						<span class="checkMsg error" id="checkNo" style="display: none">입력하신 E-mail은 이미 사용 중입니다.</span>
					</td>
				</tr>
				<tr>
					<th><span><label for="user_nm_kor">이름</label></span></th>
					<td class="left" colspan="3">
						<input type="text" id="user_nm_kor" name="user_nm_kor" value="">
					</td>
				</tr>
				<tr>
					<th><span><label for="user_pwd">비밀번호</label></span></th>
					<td class="left" colspan="3"><input type="hidden" class="checkedPwYN" name="checkedPwYN" value="N"> 
						<input type="password" id="user_pwd" name="user_pwd" value="" maxlength="20" onblur="fn_pwCheck()"> 
					</td>
				</tr>
				<tr>	
					<th><span><label for="user_pwdCheck">비밀번호 확인</label></span></th>
					<td class="left" colspan="3"><input type="hidden" class="checkedPwYN" name="checkedPwYN" value="N">
						<input type="password" id="user_pwdCheck" name="user_pwdCheck" value="" maxlength="20" onblur="fn_pwCheck_new()"> 
						<span class="checkMsg ok" id="pWCheck_new"></span>
					</td>
				</tr>
				<tr class="tel">
					<th><span class="no_req">연락처</span></th>
					<td class="left">
						<select id="tel1" name="tel1" title="전화번호 국번 선택">
							<option value="02">02</option>
							<option value="031">031</option>
							<option value="032">032</option>
							<option value="033">033</option>
							<option value="041">041</option>
							<option value="042">042</option>
							<option value="043">043</option>
							<option value="044">044</option>
							<option value="0502">0502</option>
							<option value="0505">0505</option>
							<option value="0506">0506</option>
							<option value="051">051</option>
							<option value="052">052</option>
							<option value="053">053</option>
							<option value="054">054</option>
							<option value="055">055</option>
							<option value="061">061</option>
							<option value="062">062</option>
							<option value="063">063</option>
							<option value="064">064</option>
							<option value="070">070</option>
						</select>-
						<span><label for="tel2" class="hide">tel2</label><input type="text" id="tel2" name="tel2" size="4"	maxlength="4"></span> 
					  - <span><label for="tel3" class="hide">tel3</label><input type="text" id="tel3" name="tel3" size="4" maxlength="4"></span> 
							  <input type="hidden" id="usrPhone" name="usrPhone" value="">	
					</td>
					<th><span class="no_req">휴대폰</span></th>
					<td class="left">
						<select id="clpn1" name="clpn1" title="핸드폰번호 국번 선택">
							<option value="010" selected>010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
						</select> 
						- <span><label for="clpn2" class="hide">clpn2</label><input type="text" id="clpn2" name="clpn2" maxlength="4"></span> 
						- <span><label for="clpn3" class="hide">clpn3</label><input type="text" id="clpn3" name="clpn3" maxlength="4" ></span>
						<span><input type="hidden" id="usrHp" name="usrHp" value=""></span>
					</td>
				</tr>
				<tr>
					<th><span class="no_req">E-mail 수신여부</span></th>		
					<td class="left">
						<span class="cbox"><input type="radio" id="eml_send_y" name="eml_send_yn" value="Y" checked="checked"> <label for="eml_send_y">수신</label></span>
						<span class="cbox"><input type="radio" id="eml_send_n" name="eml_send_yn" value="N"> <label for="eml_send_n">미수신</label></span>
					</td>
					<th><span class="no_req">SMS 수신여부</span></th>		
					<td class="left">
						<span class="cbox"><input type="radio" id="sms_send_y" name="sms_send_yn" value="Y"> <label for="sms_send_y">수신</label></span>
						<span class="cbox"><input type="radio" id="sms_send_n" name="sms_send_yn" value="N" checked="checked"> <label for="sms_send_n">미수신</label></span>
					</td>
				</tr>
				</tbody>
				</table>
			</form>
		
		<div class="buttons center m-bottom0">
			<a href="javascript:fn_save()" class="btn type-a"><span>저장</span></a>
			<a href="${ctxt}/mng/user/userList.do" class="btn type-b"><span>취소</span></a>
		</div>

	</div>
</div>


<div class="clear"></div>

</body>
</html>