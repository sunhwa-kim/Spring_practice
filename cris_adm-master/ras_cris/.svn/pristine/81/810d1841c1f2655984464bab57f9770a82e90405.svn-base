<%@page import="kr.go.cris.commons.constants.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>기관담당자상세 | 정부출연연구기관 채용정보서비스</title>

<link rel="stylesheet" href="${ctxt}/resources/css/jquery-ui.css">
<script type="text/javascript" src="${ctxt}/resources/js/rsa/jsbn.js"></script>
<script type="text/javascript" src="${ctxt}/resources/js/rsa/rsa.js"></script>
<script type="text/javascript" src="${ctxt}/resources/js/rsa/prng4.js"></script>
<script type="text/javascript" src="${ctxt}/resources/js/rsa/rng.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<script type="text/javascript">

$(function() {
	
	var cls_gbn = $('#cls_gbn').val().split(',');
	
	$(cls_gbn).each(function(cnt){
		var p_list = $('#cls_gbn').val().split(",");
		$(p_list).each(function(cnt){
			$('input[value='+p_list[cnt]+']').prop('checked',true);
		});
	});
	
	
}); 


//비밀번호 체크 1
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

//비밀번호 체크 2
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
  
  
// 기관 담당자정보 수정 버튼
function fn_save(){
	
	var form = document.form;
	var nonchar = /[^가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z]/gi;
	
 	// null체크 - 비밀번호 
	if($('#user_pwd').val() != ''){
		// null체크 - 비밀번호 확인
		if($('#user_pwdCheck').val() == ''){
			fn_alert('비밀번호를 다시한번 입력하세요.','c');
			$('#user_pwdCheck').focus();
			return;
		}
		
		// null체크 - 비밀번호 확인
/* 		if(!fn_pwCheck()){
			fn_alert('비밀번호는 영문/숫자/특수문자를 섞어 9~20자를 입력하세요.');
			$('#user_pwd').focus();
			return;
		} */

		// null체크 - 비밀번호 확인
		if(!fn_pwCheck_new()){
			fn_alert('비밀번호가 서로 맞지 않습니다. 다시 입력하세요.','c');
			return;
		} 
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

    if($("input[name=sms_send_yn]:checked").val() == "Y"){
    	if($("#clpn2").val().length == 0 || $("#clpn3").val().length == 0){
    		fn_alert("SMS문자 서비스를 받을<br /> 휴대폰번호를 입력해주세요",'c');
    		return;
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
     
     $.ajax({ // RSA 공개키 요청
       type: 'GET',
       url : '${ctxt}/cmmn/util/getRSAKey.xml',
       data: {sessionKey: '<%=Constants.RSA_KEY_MODI%>'}, 
       <%-- data: {sessionKey: '<%=Constants.RSA_KEY_REGI%>'}, --%>
       dateType: 'xml',
       cache: false,
       success: function(data) {
         var xml = $(data);
         if (xml.find('msg').text() == 'success') {
         	var publicKeyModulus = xml.find('publicKeyModulus').text();
         	var publicKeyExponent = xml.find('publicKeyExponent').text();

           var rsa = new RSAKey();
           rsa.setPublic(publicKeyModulus, publicKeyExponent);

	          //Cls_val
	          var cls_gbn_list = "";

	          // 관심기관
	          $("input[name=org_list]:checked").each(function(){
	        	 cls_gbn_list += $(this).val()+",";
	          });
	          
	          //alert(cls_gbn_list.substring(0,cls_gbn_list.length - 1));

	          var params = {};
 	          
	          params.user_sn = $('#user_sn').val();
	          params.org_cd = $('#org_cd').val();								// 기관코드
 	          params.loginid = rsa.encrypt($('#eml').val());
 	          params.user_pwd = rsa.encrypt($('#user_pwd').val());
 	          params.user_nm_kor = rsa.encrypt($('#user_nm_kor').val());
 	          
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
             url : '${ctxt}/mng/orgUser/updateOrgUser.do',
             data: params,
             cache: false,    //cache가 있으면 새로운 내용이 업데이트 되지 않는다.
             success:function(data){
               if (data.indexOf('ERR') < 0){
            	   
            	   	fn_alert("저장을 완료 하였습니다.");

   					//setTimeout(fn_load(), 1500);
               } else {
            	    var msg = "";
           			switch(data){
           			case "ERR-01":
           				msg = "잘못된 접근을 하셨습니다.";
           				break;
           			case "ERR-02":
           				msg = "사용자정보가 일치하지 않습니다";
           				break;
           			}
                 fn_alert(msg);
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
	$('#save_type').val("N");
	
	var form = document.form;
	
	form.action = "${ctxt}/mng/orgUser/orgUserView.do"
    
	form.submit();
}

//목록으로 돌아가기
function fn_goList(){
	var form = document.form;
	form.action = "${ctxt}/mng/orgUser/orgUserList.do"
    form.submit();
}

</script>
</head>

<body>

<div id="container">

	<div id="content">

		<h2>기관담당자상세</h2>
		
		<div class="clear"></div>

		<h5 class="title">기관담당자정보</h5>
	<form id="form" name="form" action="" method="post">
		<input type="hidden" id="page" name="page" value="${PTLLoginVo.page}" /> 
		<input type="hidden" id="org_list" name="org_list" value="${PTLLoginVo.org_list}" />
		<input type="hidden" id="user_sn" name="user_sn " value="${mngUserInfo.user_sn}"  />
		<input type="hidden" id="eml" value="${mngUserInfo.loginid}"  />
		<input type="hidden" id="s_loginid" name="s_loginid" value="${PTLLoginVo.loginid}" /> 
		<input type="hidden" id="s_user_nm_kor" name="s_user_nm_kor" value="${PTLLoginVo.user_nm_kor}" />
		<input type="hidden" id="save_type" name="save_type" value="" />
	
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
			<td colspan="3 "class="left">
				<select name="org_cd" id="org_cd" title="기관" style="width: 140px;" >
					<c:forEach items="${org_list}" var="org" varStatus="state">
						<option value="${org.cd}" <c:if test="${org.cd == mngUserInfo.org_cd}">selected</c:if>>${org.cd_nm}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<th><span class="no_req">E-mail</span></th>
			<td class="left" id="idchekInput" colspan="3">${mngUserInfo.loginid}</td>
		</tr>
		<tr>
			<th><span>비밀번호</span></th>
			<td class="left" colspan="3"><input type="hidden" id="checkedPwYN" name="checkedPwYN" value="N"> 
				<input type="password" id="user_pwd" name="user_pwd" value="" maxlength="20" onblur="fn_pwCheck()"> 
				<!-- <span class="checkMsg" id="pWCheck">&nbsp;&nbsp;&nbsp;비밀번호는 영문/숫자/특수문자를 섞어 9~20자를 입력하세요</span> -->
			</td>
		</tr>
		<tr>	
			<th><span>비밀번호 확인</span></th>
			<td class="left" colspan="3"><input type="hidden" id="checkedPwYN" name="checkedPwYN" value="N">
				<input type="password" id="user_pwdCheck" name="user_pwdCheck" value="" maxlength="20" onblur="fn_pwCheck_new()"> 
				<span class="checkMsg ok" id="pWCheck_new"></span>
			</td>
		</tr>
		<tr>
			<th><span>이름</span></th>
			<td class="left">
				<input type="text" id="user_nm_kor" name="user_nm_kor" value="${mngUserInfo.user_nm_kor}">
			</td>
<%-- 			<th><span class="no_req">이름(영문)</span></th>
			<td class="left">
				<input type="text" id="user_nm_eng" name="user_nm_eng" value="${mngUserInfo.user_nm_eng}">
			</td> --%>
		</tr>
		<tr class="tel">
			<th><span class="no_req">연락처</span></th>
			<td class="left">
				<select id="tel1" name="tel1" title="전화번호 국번 선택">
					<option value="02"  <c:if test="${mngUserInfo.tel1 eq '02'}"> selected="selected"</c:if> >02</option>
					<option value="031" <c:if test="${mngUserInfo.tel1 eq '031'}"> selected="selected"</c:if>>031</option>
					<option value="032" <c:if test="${mngUserInfo.tel1 eq '032'}"> selected="selected"</c:if>>032</option>
					<option value="033" <c:if test="${mngUserInfo.tel1 eq '033'}"> selected="selected"</c:if>>033</option>
					<option value="041" <c:if test="${mngUserInfo.tel1 eq '041'}"> selected="selected"</c:if>>041</option>
					<option value="042" <c:if test="${mngUserInfo.tel1 eq '042'}"> selected="selected"</c:if>>042</option>
					<option value="043" <c:if test="${mngUserInfo.tel1 eq '043'}"> selected="selected"</c:if>>043</option>
					<option value="044" <c:if test="${mngUserInfo.tel1 eq '044'}"> selected="selected"</c:if>>044</option>
					<option value="0502"<c:if test="${mngUserInfo.tel1 eq '0502'}"> selected="selected"</c:if>>0502</option>
					<option value="0505"<c:if test="${mngUserInfo.tel1 eq '0505'}"> selected="selected"</c:if>>0505</option>
					<option value="0506"<c:if test="${mngUserInfo.tel1 eq '0506'}"> selected="selected"</c:if>>0506</option>
					<option value="051" <c:if test="${mngUserInfo.tel1 eq '051'}"> selected="selected"</c:if>>051</option>
					<option value="052" <c:if test="${mngUserInfo.tel1 eq '052'}"> selected="selected"</c:if>>052</option>
					<option value="053" <c:if test="${mngUserInfo.tel1 eq '053'}"> selected="selected"</c:if>>053</option>
					<option value="054" <c:if test="${mngUserInfo.tel1 eq '054'}"> selected="selected"</c:if>>054</option>
					<option value="055" <c:if test="${mngUserInfo.tel1 eq '055'}"> selected="selected"</c:if>>055</option>
					<option value="061" <c:if test="${mngUserInfo.tel1 eq '061'}"> selected="selected"</c:if>>061</option>
					<option value="062" <c:if test="${mngUserInfo.tel1 eq '062'}"> selected="selected"</c:if>>062</option>
					<option value="063" <c:if test="${mngUserInfo.tel1 eq '063'}"> selected="selected"</c:if>>063</option>
					<option value="064" <c:if test="${mngUserInfo.tel1 eq '064'}"> selected="selected"</c:if>>064</option>
					<option value="070" <c:if test="${mngUserInfo.tel1 eq '070'}"> selected="selected"</c:if>>070</option>
				</select>-
				<span><input type="text" id="tel2" name="tel2" value="${mngUserInfo.tel2}" maxlength="4"></span> 
			  - <span><input type="text" id="tel3" name="tel3" value="${mngUserInfo.tel3}" maxlength="4"></span> 
					  <input type="hidden" id="usrPhone" name="usrPhone" value="">	
			</td>
			<th><span class="no_req">휴대폰</span></th>
			<td class="left">
				<select id="clpn1" name="clpn1" title="핸드폰번호 국번 선택">
					<option value="010" <c:if test="${mngUserInfo.clpn1 eq '070'}"> selected="selected"</c:if>>010</option>
					<option value="011" <c:if test="${mngUserInfo.clpn1 eq '011'}"> selected="selected"</c:if>>011</option>
					<option value="016" <c:if test="${mngUserInfo.clpn1 eq '016'}"> selected="selected"</c:if>>016</option>
					<option value="017" <c:if test="${mngUserInfo.clpn1 eq '017'}"> selected="selected"</c:if>>017</option>
					<option value="018" <c:if test="${mngUserInfo.clpn1 eq '018'}"> selected="selected"</c:if>>018</option>
					<option value="019" <c:if test="${mngUserInfo.clpn1 eq '019'}"> selected="selected"</c:if>>019</option>
				</select> 
				- <span><input type="text" id="clpn2" name="clpn2" value="${mngUserInfo.clpn2}" maxlength="4"></span> 
				- <span><input type="text" id="clpn3" name="clpn3" value="${mngUserInfo.clpn3}" maxlength="4" ></span>
				<span><input type="hidden" id="usrHp" name="usrHp" value=""></span>
			</td>
		</tr>
		<tr>
			<th><span class="no_req">E-mail 수신여부</span></th>		
			<td class="left">
				<c:if test="${mngUserInfo.eml_send_yn eq 'Y'}">
					<span class="cbox"><input type="radio" id="eml_send_yn" name="eml_send_yn" value="Y" checked="checked"> 수신</span>
					<span class="cbox"><input type="radio" id="eml_send_yn" name="eml_send_yn" value="N"> 미수신</span>
				</c:if>
				<c:if test="${mngUserInfo.eml_send_yn eq 'N'}">
					<span class="cbox"><input type="radio" id="eml_send_yn" name="eml_send_yn" value="Y"> 수신</span>
					<span class="cbox"><input type="radio" id="eml_send_yn" name="eml_send_yn" value="N" checked="checked"> 미수신</span>
				</c:if>
			</td>
			<th><span class="no_req">SMS 수신여부</span></th>		
			<td class="left">
				<c:if test="${mngUserInfo.sms_send_yn eq 'Y'}">
					<span class="cbox"><input type="radio"  name="sms_send_yn" value="Y" checked="checked"> 수신</span>
					<span class="cbox"><input type="radio"  name="sms_send_yn" value="N" > 미수신</span>
				</c:if>
				<c:if test="${mngUserInfo.sms_send_yn eq 'N'}">
					<span class="cbox"><input type="radio"  name="sms_send_yn" value="Y"> 수신</span>
					<span class="cbox"><input type="radio"  name="sms_send_yn" value="N" checked="checked"> 미수신</span>
				</c:if>
			</td>
		</tr>
		</tbody>
		</table>
	</form>
		
		<div class="buttons center m-bottom0">
			<a href="javascript:fn_goList()" class="btn type-b"><span>목록</span></a>
			<a href="javascript:fn_save()" class="btn type-b"><span>저장</span></a>
		</div>

	</div>
</div>

</body>
</html>