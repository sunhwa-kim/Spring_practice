<%@page import="kr.go.cris.commons.constants.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%-- <%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%> --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%-- Spring Security Filter 순위 문제로 로그인 화면을 정확히 표현해주기 위해 사용 --%>
 
<style>
/*로그인*/
#content{
	height:750px;
}
.loginContents { 
	width: 100%; 
	max-width: 340px; 
	height: auto;  
	margin:0 auto; 
	margin-top:10%; 
	background: #fff; 
	border:1px solid #cdd3d9; 
	padding: 50px;
} 
/* .login_ad { float: left;  width: 620px; height: 365px; margin: 40px 0; background: #fff; border:1px solid #cdd3d9; padding: 30px; }
 */
.loginContainer{
	width:100%;
}
.loginContainer #form { 
	margin: 40px 0 0; 
}

.loginContainer .loginInput { 
	padding: 10px; 
	width:100%;
	max-width: 320px; 
	height: 30px; 
	background: #efefef; 
	margin: 0 0 10px; 
	position:relative; 
}
.loginContainer .loginInput label { 
	position:absolute; 
	width: 40px; 
	height: 30px; 
	line-height: 30px; 
	text-align: center; 
	vertical-align: middle; 
}
.loginContainer .loginInput label img { width: 20px; vertical-align: middle; }
.loginContainer .loginInput input {
	 height: 30px; 
	 border: 0 !important; 
	 width: 85%; 
	 background: none; 
	 font-size: 14px; 
	 line-height: 30px; 
	 /*font-weight: 600;*/ 
	 letter-spacing: 0.03em; 
	 color: #333; 
	 margin-left:40px;
}

  
.loginContainer label.idCheck { display: inline-block; width: 120px; height: 18px; line-height: 18px; font-size: 13px;  letter-spacing: -0.03em;  }
.loginContainer label input[type=checkbox] { display: inline-block; width:13px; height: 13px; background: none; border:1px solid #dcdcdc; margin: 0 7px 0 0; vertical-align: center; }
.loginContainer .register { display: inline-block;  width: 215px; text-align: right; line-height: 18px; font-size: 13px; margin: 4px 0 0; }
.loginContainer .register a { font-weight: 600; color: #333; font-size: 15px; padding-left: 5px; }
.loginContainer .register a:hover { color: #2ab3ed; transition: 0.3s; }

.loginContainer .loginBtn { 
	display: block; 
	margin: 25px 0 15px; 
	width: 100%;
	max-width:340px; 
	height: 50px; 
	border: 0; 
	cursor: pointer;  
	letter-spacing: 0.5em;
	font-size: 18px; 
	font-weight: 600; 
	color: #fff; 
	background: #2ab3ed url('../img/common/tab_ptn.gif'); 
}
.loginContainer .loginBtn:hover { background: #393939; transition: 1s; }
.loginContainer .findPW { display: block; text-align: center; font-size: 13px; line-height: 20px; text-decoration: underline; font-style: italic;  color: #aaa; }
.loginContainer .findPW:hover { color: #393939; }
.loginFail {text-align: center; margin-top: 35px; color: red}
@media all and (max-width:620px) {
	.loginContents{
		margin-top:80px;
	}
}
@media all and (max-width:515px) {
	.loginContents{
		margin-top:50px;
		padding:20px;
	}
	.loginContainer #form {
	    margin: 30px 0 0;
	}
}
@media (max-width: 502px){
	 .loginContainer .findPW{
		display:none;
	}
}
@media all and (max-width:460px) {
	.loginContents{
		max-width: 300px;
	}
	.loginContainer .loginInput{
		max-width: 280px;
	}
	.loginContainer label.idCheck {
	    display: block;
	    width: 100%;
	    height: 18px;
	    text-align: center;
	}

	.loginContainer #form {
	    margin: 20px 0 0;
	}
}
@media all and (max-width:400px) {
	.loginContents{
		max-width: 260px;
	}
	.loginContainer .loginInput{
		max-width: 240px;
	}
}
@media all and (max-width:340px) {
	.loginContents{
		max-width: 220px;
	}
	.loginContainer .loginInput{
		max-width: 200px;
	}
}
</style>

<title>로그인 | 국립의과학지식센터</title>
  <script type="text/javascript" src="${ctxt}/resources/js/rsa/jsbn.js"></script>
  <script type="text/javascript" src="${ctxt}/resources/js/rsa/rsa.js"></script>
  <script type="text/javascript" src="${ctxt}/resources/js/rsa/prng4.js"></script>
  <script type="text/javascript" src="${ctxt}/resources/js/rsa/rng.js"></script>
  <script type="text/javascript">


    $(function() {
     $(".loginInput input").focus(function() {
      }).blur(function() {
        if($(this).val()=="") $(this).prev(".tag").show();
      });
      if('${result}' == 'false'){
        $("#loginid").focus();
        $("#loginid").val('${loginid}');
        
        $(".loginFail").html('${message}');
        
      }else if('${result}' == 'true'){
        location.href='${ctxt}/';
      }else{    	  
        var form = document.form;
        
        $("#loginid").focus();
      }
    });

    function fncLogin(){
      var form = document.form;

      if ($("#loginid").val() == '') {
        fn_alert('아이디를 입력하세요','c');
        $("#loginid").focus();
        return;
      }

      if($("#password").val() == ""){
         fn_alert("비밀번호를 입력 하세요",'c');
         $("#password").focus();
         return;
      }
 
              var frmObj = $('<form action="${ctxt}/login/loginProcess.do" method="post"></form>');
          
	           frmObj.append('<input type="hidden" name="loginid" value="' + $('#loginid').val() + '"/>');
	           frmObj.append('<input type="hidden" name="password" value="' + $('#password').val() + '"/>');
			
              frmObj.append('<input type="hidden" name="returnURL" value="${param.returnURL}"/>');
              frmObj.append('<input type="hidden" name="returnUrl" value="${returnURL}"/></form>');
              frmObj.appendTo('body');
              frmObj.submit();
   
    }

  
    function searchPopup(){ // ID/PW 찾기
    	location.href="${ctxt}/login/user/idpass.do";
    }
  </script>

	<div id="mainContents" class="loginContents" >
		<div class="loginContainer">
			<form id="form" name="form" action="${ctxt}/login/loginProcess.do"
				method="post">
				<p class="loginInput">
					<label for="loginid" class="tag"><img
						src="${ctxt}/resources/images/_login/login_icon01.png" alt="e-mail" /></label>
					<input type="text" id="loginid" name="loginid"
						onkeydown="javascript:if(event.keyCode==13){fncLogin();}"
						placeholder=" 아이디를 입력해주세요.">
				</p>
				<p class="loginInput">
					<label for="password" class="tag"><img
						src="${ctxt}/resources/images/_login/login_icon02.png" alt="비밀번호" /></label> <input
						type="password" id="password" name="password" autocomplete="off"
						onkeydown="javascript:if(event.keyCode==13){fncLogin();}"
						placeholder=" 패스워드를 입력해주세요.">
				</p>
				<label for="idCheck" class="idCheck">
				<!-- <input type="checkbox"	id="idCheck" name="idCheck">아이디 기억하기-->
				</label> 
				<p class="register">
					아이디가 없으십니까? <a href="${ctxt}/login/user/writeMember.do">회원가입</a>
				</p>
				<button type="button" class="loginBtn" onclick="fncLogin()">로그인</button>
				<a href="javascript:searchPopup();" class="findPW">비밀번호를 잊으셨나요?</a>
				<div class="loginFail"></div>
			</form>
		</div>
		<div class="clear"></div>
	</div>
	<!-- mainContents -->