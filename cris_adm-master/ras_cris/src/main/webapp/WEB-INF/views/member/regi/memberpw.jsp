<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>


<script type="text/javascript">
var IS_SUBMIT = false;

function fncMemberPW() {
	if ($("#rpassword").val() == "") {
		alert("기존 비밀번호를 입력하여 주시기 바랍니다.");
		$("#rpassword").focus();
		return;
	}	
	
	if ($("#password").val() == "") {
		alert("비밀번호를 입력하여 주시기 바랍니다.");
		$("#password").focus();
		return;
	}	
	
	var check = codeCheck($("#password").val());   //비밀번호 유효성체크
	if (!check) {
		$("#password").focus();
		return;
	}
	if ($("#password2").val() == "") {
		alert("비밀번호 확인을 입력하여 주시기 바랍니다.");
		$("#password2").focus();
		return;
	}	
	if ($("#password").val() != $("#password2").val()) {
		alert("비밀번호와 비밀번호 확인이 다릅니다.");
		$("#password2").focus();
		return;
	}	

	if(!IS_SUBMIT){
				  
        $.ajax({
        	 url: '${ctxt}/member/regi/pwModiPtlEmplyr.do',
  		     data: $("form[name=reqForm]").serialize(),  
  		     type: 'POST',
  		   	 dataType: 'text',
		     cache: false,
		     success: function(result) {
				  if(result=='Y'){ //성공
					  alert("비밀번호가 변경 되었습니다.");
					  var form = $('<form action="${ctxt}/login/logout.do" method="post"></form>');
					  form.append('<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/></form>');
					  form.appendTo('body');
					  form.submit();
				  }else if(result=='N'){
					  alert("기존 비밀번호가 동일하지 않아 변경 할 수 없습니다.");
				  }else if(result=='F'){
					  alert("비밀번호 찾기에 실패하였습니다.");
				  }
		   },
		   error : function(){                              // Ajax 전송 에러 발생시 실행
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
		//alert(acCodeHanName + "는 영문을 포함하여 입력 하셔야 합니다.");
		alert(acCodeHanName + "는 영문,숫자,특수문자 하나 이상 포함하여 9자리 이상으로 입력 하셔야 합니다.");
	}
	else if (!pattern2.test(acCode)) {
		//alert(acCodeHanName + "는 특수문자를 포함하여 입력 하셔야 합니다");
		alert(acCodeHanName + "는 영문,숫자,특수문자 하나 이상 포함하여 9자리 이상으로 입력 하셔야 합니다.");
	}
	else if (!pattern3.test(acCode)) {
		//alert(acCodeHanName + "는 숫자를 포함하여 입력 하셔야 합니다.");
		alert(acCodeHanName + "는 영문,숫자,특수문자 하나 이상 포함하여 9자리 이상으로 입력 하셔야 합니다.");
	}
	else if (pattern4.test(acCode)) {
		//alert(acCodeHanName + "는 한글을 쓸 수 없습니다.");
		alert(acCodeHanName + "는 영문,숫자,특수문자 하나 이상 포함하여 9자리 이상으로 입력 하셔야 합니다.");
	}
	else if (acCode.length < 9) {
		//alert(acCodeHanName + "는 9자리 이상으로 입력 하셔야 합니다.");
		alert(acCodeHanName + "는 영문,숫자,특수문자 하나 이상 포함하여 9자리 이상으로 입력 하셔야 합니다.");
	}
	else {
		returnVal = true;
	}
	
	return returnVal;
};
</script>
<style>
table tr{
	height:40px;
}
table th{
	font-size:13px;
}
table td input{
 	min-height: 25px;
    vertical-align: middle;
    border: 1px solid #ccc;
    margin: 0 auto;
    box-sizing: border-box;
    width:200px;
}
.dashed{
	font-size: 14px;
   	font-weight: normal;
   	color: #666;
}
.content_box>.content_list ul{
	width:auto;
	margin: 1% 0;
}
</style>
</head>
<body>
<form name="reqForm" method="post">
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>회원정보수정</span>
			<span> > </span>
			<span class="active">비밀번호 변경</span>        			      
		</div>
		<span class="center_text_01">비밀번호 변경</span>
	</div> 
	<div class="under_bar"></div>
		   
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div>
					<ul class="list_full limit">
						<li class="dashed">정보보호를 위하여 3개월에 한번씩 비밀번호를 변경 하시기 바랍니다.</li>
					 	<li class="dashed"><span style="border-bottom:0px dotted red; color:red;">ID/PW 찾기를 하신 분은 반드시 비밀번호를 변경 하셔야 합니다.</span></li>
					</ul>
				</div>
				<div class="content_list table">	
					<div id="divRefreshArea">
						<table class="basic_table" style="border-top: 1px solid #CCDDED;">
						<!-- <table class="view_table"> -->
						<caption>회원정보 수정</caption>
						<colgroup>
							<col width="136px">
							<col width="319px">
							<col width="136px">
							<col width="319px">
						</colgroup>
								<tbody class="report">
								<tr>
									<th colspan="1">
										<label for="">기존 비밀번호</label><font style="color:red">*</font>
									</th>
									<td colspan="1" class="padding_l">
										<input name="rpassword" type="password" id="rpassword"  value=""  onkeypress="if(event.keyCode == 13){ fncMemberPW(); return; }"/>
									</td>
								</tr>
								<tr>
									<th colspan="1">
										<label for="">변경 비밀번호</label><font style="color:red">*</font>
									</th>
									<td colspan="1" class="padding_l">
										<input name="password" type="password" id="password"   value=""  onkeypress="if(event.keyCode == 13){ fncMemberPW(); return; }"/> 
										<span class="table_caution" ><span style="color:red; padding-left:10px;">*</span> 영문, 숫자, 특수문자 포함 9자리 이상.</span>
									</td>
								</tr>
								<tr>
									<th colspan="1">
										<label for="">변경 비밀번호 확인</label><font style="color:red">*</font>
									</th>
									<td colspan="1" class="padding_l">
										<input name="password2" type="password" id="password2"  value=""  onkeypress="if(event.keyCode == 13){ fncMemberPW(); return; }"/>
									</td>
								</tr>
								</tbody>
						</table>
					</div>
				</div>
				<div class="btn-group">
					<a href="javascript:fncMemberPW();" class='basic-btn'><span>비밀번호변경</span></a>
				</div> 
			</div>
		</div>
	</div>
			
	
	
	
 	
 	<!-- 공통  필수 PARAM -->
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/>
</form>
</body>
</html>