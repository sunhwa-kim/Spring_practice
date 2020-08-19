<%@page import="kr.go.cris.commons.constants.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<title><spring:message code="title.stat.login.register" /> | <spring:message code="title.main" /></title>
<meta name="decorator" content="index">
<script type="text/javascript" src="${ctxt}/resources/backup/js/rsa/jsbn.js"></script>
<script type="text/javascript" src="${ctxt}/resources/backup/js/rsa/rsa.js"></script>
<script type="text/javascript" src="${ctxt}/resources/backup/js/rsa/prng4.js"></script>
<script type="text/javascript" src="${ctxt}/resources/backup/js/rsa/rng.js"></script>
<script type="text/javascript">
  $(function() {
	  $('input').keyup(fn_checkBtn);
	  $('input').click(fn_checkBtn);
  });

  function fn_save(){

    var form = document.form;
    var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    var nonchar = /[^가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z]/gi;
 
    if ($("#user_nm").val() == '') {
       fn_alert('이름를 입력하세요');
       $("#user_nm").focus();
       return;
    }

    if (nonchar.test($("#user_nm").val())) {
      fn_alert('이름에는 한글, 영문 대소문자를 이용해 주세요.');
      $("#user_nm").focus();
      return ;
    }

    if ($("#loginid").val() == '') {
      fn_alert('아이디를 입력하세요');
      $("#loginid").focus();
      return;
    }

    if($("#checkedYN").val() == ""){
       fn_alert("아이디 중복 확인을 하십시요.");
       return;
    }

    if($("#checkedYN").val() == "N"){
        fn_alert("이미 등록된 아이디입니다.");
        $("#loginid").focus();
        return;
    }

    if($('#user_pwd').val() == ''){
      fn_alert('비밀번호를 입력하세요.');
      $('#user_pwd').focus();
      return;
    }

    if($('#user_pwdCheck').val() == ''){
      fn_alert('비밀번호를 다시한번 입력하세요.');
      $('#user_pwdCheck').focus();
      return;
    }

    if(!fn_pwCheck()){
      fn_alert('비밀번호는 영문/숫자/특수문자를 섞어 9~20자를 입력하세요.');
      $('#user_pwd').focus();
      return;
    }

    if(!fn_pwCheck_new()){
      fn_alert('비밀번호가 서로 맞지 않습니다. 다시 입력하세요.');
      return;
    }

    if($("#tel2").val().length > 0 || $("#tel3").val().length > 0){
      /*핸드폰 번호 길이 체크*/
        if($("#tel2").val().length<=2 || $("#tel3").val().length!=4){
          fn_alert("전화번호를 제대로 입력해주세요");
          $("#tel2").focus();
          return;
        }
          /*핸드폰이 숫자만 들어가는지 체크*/
        if(isNaN($("#tel2").val()) || isNaN($("#tel3").val())){
          fn_alert("전화번호는 숫자만 들어갈 수 있습니다.");
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
          fn_alert("휴대폰번호를 제대로 입력해주세요");
          $("#clpn2").focus();
          return;
        }
          /*핸드폰이 숫자만 들어가는지 체크*/
        if(isNaN($("#clpn2").val()) || isNaN($("#clpn3").val())){
          fn_alert("휴대폰번호는 숫자만 들어갈 수 있습니다.");
          $("#clpn2").focus();
          return;
        }
          /**/
        if ($("#clpn2").val().length > 2 || $("#clpn3").val().length==4){

          var Hp = $("#clpn1").val() +"-"+ $("#clpn2").val() +"-"+ $("#clpn3").val();

            $("#usrHp").val(Hp);
        }
    }


    if($('#mail_id').val() == ''){
      fn_alert('전자우편을 입력하세요.');
      $('#mail_id').focus();
      return;
    }

    if($('#mail_domain').val() == ''){
      fn_alert('E-mail 도메인을 입력하세요.');
      $('#mail_domain').focus();
      return;
    }

    if(!regEmail.test($('#mail_id').val() + '@' + $('#mail_domain').val())) {
      fn_alert('올바른 전자우편를 입력하세요.');
      $('#mail_id').focus();
      return;
    }

    $("#eml").val($('#mail_id').val() + '@' + $('#mail_domain').val());

    $.ajax({ // RSA 공개키 요청
      type: 'GET',
      url : '${ctxt}/cmmn/util/getRSAKey.xml',
      data: {sessionKey: '<%=Constants.RSA_KEY_REGI%>'},
      dateType: 'xml',
      success: function(data) {
        var xml = $(data);
        if (xml.find('msg').text() == 'success') {
        	var publicKeyModulus = xml.find('publicKeyModulus').text();
        	var publicKeyExponent = xml.find('publicKeyExponent').text();

          var rsa = new RSAKey();
          rsa.setPublic(publicKeyModulus, publicKeyExponent);

          var params = {};
	          params.loginid = rsa.encrypt($('#loginid').val());
	          params.user_pwd = rsa.encrypt($('#user_pwd').val());
	          params.user_nm = rsa.encrypt($('#user_nm').val());
	          params.clpn1 = rsa.encrypt($('#clpn1').val());
	          params.clpn2 = rsa.encrypt($('#clpn2').val());
	          params.clpn3 = rsa.encrypt($('#clpn3').val());
	          params.etc_clpn = rsa.encrypt($('#etc_clpn').val());
	          params.tel1 = rsa.encrypt($('#tel1').val());
	          params.tel2 = rsa.encrypt($('#tel2').val());
	          params.tel3 = rsa.encrypt($('#tel3').val());
	          params.eml = rsa.encrypt($('#eml').val());

          $.ajax({ // RSA로 암호화된 개인 정보 전송
            type: 'POST',
            url : '${ctxt}/login/register.do',
            data: params,
            success:function(data){
              if (data.indexOf('실패') < 0){
                location.href='${ctxt}/login/completion.do';
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

  function fn_check(){

    if($("#loginid").val() == ""){
      fn_alert("아이디가 입력되지 않았습니다.");
      $("#loginid").focus();
      return;
    }
    if ($("#loginid").val().replace(/ /gi, "") == "") {
      fn_alert("아이디는 공백으로만 이루어 질수 없습니다.");
      $("#loginid").val("");
      $("#loginid").focus();
      return;
    }

    if($('#loginid').val() != $('#loginid').val().replace(/[^a-z0-9]/gi,'')){
      fn_alert("아이디는 영문,숫자로만 가능합니다.");
      $("#loginid").focus();
        return;
    }

    $.ajax({
       url:"${ctxt}/login/selectIdCheck.do",
       data:{"loginid":$("#loginid").val()},
       type:"post",
       success:function(data){
         $("#orgloginid").val($("#loginid").val());
         if(data == 0){
           fn_alert('사용하실수 있습니다.');
           $("#idchekInput").children("span").remove();
           $("#idchekInput").append('<span class="checkMsg ok">입력하신 아이디는 사용하실 수 있습니다.</span>');
           $("#checkedYN").val("Y");
         }else{
           fn_alert('이미 등록된 아이디 입니다.');
           $("#idchekInput").children("span").remove();
           $("#idchekInput").append('<span class="checkMsg error">입력하신 아이디는 이미 사용 중입니다.</span>');
           $("#checkedYN").val("N");
         }
       },
       error:function(ex){
         fn_checkBtn();
         fn_alert('아이디 중복 체크 실패 \n 관리자에게 문의 바랍니다');
       }
    });
    return;
  }

  function fn_idInput(){
    $("#checkedYN").val("");
    $("#idchekInput").children("span").remove();
    $("#idchekInput").append('<span class="checkMsg none">아이디 중복 확인이 필요합니다.</span>');
  }

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

  function fn_checkBtn(){
    if( $("#user_nm").val() !="" && $("#checkedYN").val() =="Y" && $("#checkedPwYN").val() =="Y" && $("#user_pwd").val() !=""  && $("#user_pwd").val() == $("#user_pwdCheck").val()  && $("#mail_id").val() !="" && $("#mail_domain").val() !=""){
      $("#nextType").removeClass("preStep");
      $("#nextType").addClass("nextStep");
    }else{
      $("#nextType").removeClass("nextStep");
      $("#nextType").addClass("preStep");
    }
  }

  function fn_chkBox(obj){
		var chkBox = $(obj).find('input[type=checkbox]');
		
		if($(chkBox).is(':checked')){
			$(chkBox).prop('checked','');
		}else{
			$(chkBox).prop('checked','checked');
		}
  }
  

</script>

</head>
<body>
	<div id="mainContents">
		<!-- 등록 등록 절차 -->
		<section class="registerStep">
		<h1>
			인재 등록 절차
		</h1>
		<p class="guide">국가과학기술연구회 출연연채용정보서비스의 등록 등록 절차는 이용약관 동의, 등록 정보
			입력, 이메일 인증의 3단계로 이루어져 있습니다.</p>
		<p class="guide">현재 단계는 등록 정보 입력 단계입니다. 필수 항목과 선택 항목을 입력하고 다음 단계로
			진행하시면 등록 등록이 완료됩니다.</p>
		<!-- 네비게이터 -->
		<div class="arrowBox">
			<p class="step1">이용약관 동의</p>
			<p class="step2 current">등록 정보 입력</p>
			<p class="step3">등록 등록 완료</p>
		</div>
		</section>

		<!-- 등록정보 입력 -->
		<section class="policy">
		<h1 style="margin-bottom: 0;">
			인재 정보 입력
		</h1>

		<p class="registerGuide">* 표시된 항목들은 필수 입력 항목입니다. 반드시 기입해 주십시오.</p>
		<form id="form" name="form" action="" method="post">
			<table>
				<colgroup>
					<col width="12%">
					<col width="38%">
					<col width="12%">
					<col width="38%">
				</colgroup>
				<tbody>
					<tr>
						<th><span class="must">*</span>이름</th>
						<td colspan="3"><input type="text" id="user_nm" name="user_nm" value="" maxlength="20" style="width: 50%;"
							onclick="fn_checkBtn()"></td>
					</tr>
					<tr>
						<th><span class="must">*</span>아이디</th>
						<td id="idchekInput" colspan="3">
							<input type="hidden"id="orgloginid" name="orgloginid" value=""> 
							<input type="hidden" id="checkedYN" name="checkedYN" value="">
							<input type="text" id="loginid" name="loginid" value="" onkeydown="fn_idInput();" maxlength="20" style="width: 50%;">
							<button type="button" onclick="fn_check()" class="duplicationBtn">중복확인</button> 
							<span class="checkMsg">아이디 중복 확인 필요합니다.</span> 
							<span class="checkMsg ok" id="checkYes" style="display: none">입력하신 아이디는 사용하실 수 있습니다.</span> 
							<span class="checkMsg error" id="checkNo" style="display: none">입력하신 아이디는 이미 사용 중입니다.</span>
						</td>
					</tr>
					<tr>
						<th><span class="must">*</span>비밀번호</th>
						<td colspan="3"><input type="hidden" id="checkedPwYN" name="checkedPwYN" value="N"> 
							<input type="password" id="user_pwd" name="user_pwd" value="" maxlength="20" onblur="fn_pwCheck()" style="width: 50%;"> 
							<span class="checkMsg" id="pWCheck">&nbsp;&nbsp;&nbsp;비밀번호는 영문/숫자/특수문자를 섞어 9~20자를 입력하세요</span></td>
					</tr>
					<tr>
						<th><span class="must">*</span>비밀번호 확인</th>
						<td colspan="3"><input type="password" id="user_pwdCheck" name="user_pwdCheck" value="" maxlength="20" onblur="fn_pwCheck_new()" style="width: 50%;"> 
						<span class="checkMsg ok" id="pWCheck_new"></span></td>
					</tr>
					<tr>
						<th><span class="must">*</span>E-mail</th>
						<td colspan="3">
							<input type="hidden" id="eml" name="eml" value=""> 
							<input type="text" id="mail_id" name="mail_id" value="" style="width: 130px;" maxlength="20" onclick="fn_checkBtn()"> 
							@ 
							<input type="text" id="mail_domain" name="mail_domain" value="" style="width: 140px;" maxlength="20" > 
							<select name="mail_domain_sel" id="mail_domain_sel" title="전자우편 도메인 선택" onchange="fn_mailDomainChange();" style="width: 140px;" >
								<option value="">직접입력</option>
								<option value="gmail.com">gmail.com</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="hotmail.com">hotmail.com</option>
								<option value="nate.com">nate.com</option>
								<option value="naver.com">naver.com</option>
							</select>
						</td>
					</tr>
										<tr>
						<th>전화번호</th>
						<td><select id="tel1" name="tel1" style="width: 120px;"
							title="전화번호 국번 선택">
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
						</select> - <input type="text" id="tel2" name="tel2" size="4"
							maxlength="4" style="width: 120px;"> - <input type="text"
							id="tel3" name="tel3" size="4" maxlength="4"
							style="width: 120px;"> 
							<input type="hidden" id="usrPhone" name="usrPhone" value=""></td>
						<th>휴대폰번호</th>
						<td>
							<select id="clpn1" name="clpn1" style="width: 120px;" title="핸드폰번호 국번 선택">
								<option value="010" selected>010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select> 
							- 
							<input type="text" id="clpn2" name="clpn2" size="4" maxlength="4"style="width: 120px;"> 
							- 
							<input type="text" id="clpn3" name="clpn3" size="4" maxlength="4" style="width: 120px;">
							<input type="hidden" id="usrHp" name="usrHp" value="">
						</td>
					</tr>
					<tr style="border:solid 2px red;">
						<td colspan="4" style="text-align: center;border-bottom:solid 2px #80E12A;"></td>
					</tr>
					<tr>
						<th>관심기관</th>
						<td colspan="3">
							<table>
							<c:forEach var="org" items="${org_list}" varStatus="stats">
								<c:if test="${(stats.index+1) % 7 == 1 }">
									<tr>
								</c:if>	
									<td onclick="fn_chkBox(this)" style="cursor:pointer"><input type="checkbox" name="org" value="${org.cd}" style="height: 15px;" readonly="readonly" > <font size="1"> ${org.cd_nm}</font></input> </td>
								<c:if test="${(stats.index+1) % 7 == 0 }">
									</tr>
								</c:if>
							</c:forEach>
							</table>
						</td>
					</tr>
					<tr>
						<th>경력구분 </th>
						<td colspan="3">
							<table >
								<tr>
								<c:forEach var="career" items="${career_list}">
									<td style="cursor:pointer" onclick="fn_chkBox(this)">
										<input type="checkbox" name="career" value="${career.cd}" style="height: 15px;" readonly="readonly"  /> ${career.cd_nm}
									</td>
								</c:forEach>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<th>인력구분 </th>
						<td colspan="3">
							<table >
								<tr>
								<c:forEach var="person" items="${person_list}">
									<td style="cursor:pointer" onclick="fn_chkBox(this)">
										<input type="checkbox" name="person" value="${person.cd}" style="height: 15px;" readonly="readonly"  /> ${person.cd_nm}
									</td>
								</c:forEach>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<th>직종</th>
						<td colspan="3">
							<table>
								<tr>
								<c:forEach var="work" items="${work_list}">
									<td style="cursor:pointer" onclick="fn_chkBox(this)">
										<input type="checkbox" name="work" value="${work.cd}" readonly="readonly"/> ${work.cd_nm}
									</td>
								</c:forEach>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<th>학위</th>
						<td colspan="3">
							<table>
								<tr>
								<c:forEach var="degree" items="${degree_list}">
									<td style="cursor:pointer" onclick="fn_chkBox(this)">
										<input type="checkbox" name="degree" value="${degree.cd}" readonly="readonly" /> ${degree.cd_nm}
									</td>
								</c:forEach>
								</tr>
							</table>
						</td>
					</tr>

				</tbody>
			</table>
		</form>
		<!-- 버튼 영역 -->
		<div class="prevNextBtn">
			<a href="${ctxt}/login/agreement.do" class="prevStep">이전 단계</a> 
			<a href="javascript:fn_save()" class="prevStep" id="nextType">다음 단계</a>
		</div>
		</section>
	</div>
</body>
</html>
