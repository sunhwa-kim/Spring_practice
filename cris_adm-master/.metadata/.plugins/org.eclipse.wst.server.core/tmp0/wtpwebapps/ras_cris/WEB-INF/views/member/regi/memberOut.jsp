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

function fncMemberOut() {
	if ($("#password").val() == "") {
		alert("비밀번호를 입력하여 주시기 바랍니다.");
		$("#password").focus();
		return;
	}	
	
	if(!IS_SUBMIT){
        $.ajax({
        	 url: '${ctxt}/member/regi/deleteAccount.do',
  		     data: $("form[name=reqForm]").serialize(),  
  		     type: 'POST',
  		   	 dataType: 'text',
		     cache: false,
		     success: function(result) {
				  if(result=='Y'){ //성공
					  alert("탈퇴 처리 되었습니다.");
					  var form = $('<form action="${ctxt}/login/logout.do" method="post"></form>');
					  form.append('<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/></form>');
					  form.appendTo('body');
					  form.submit();
				  }else if(result=='N'){
					  alert("비밀번호가 동일하지 않아 탈퇴 처리 할 수 없습니다.");
				  }else if(result=='F'){
					  alert("탈퇴 처리가 실패하였습니다.");
				  }
		   },
		   error : function(){                              // Ajax 전송 에러 발생시 실행
	 		     fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
	 		   }
        });
        
	}
	
}
</script>
<style>
input{
 	min-height: 25px;
    vertical-align: middle;
    border: 1px solid #ccc;
    margin: 0 auto;
    box-sizing: border-box;
}
.dashed{
	font-size: 14px;
   	font-weight: normal;
   	color: #666;
}
.content_box>.content_list ul{
	width: auto;
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
			<span class="active">회원탈퇴</span>        			      
			</div>
			<span class="center_text_01">회원탈퇴</span>
		</div> 
		<div class="under_bar"></div>

	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div>
					<ul class="list_full limit">
						 <li class="dashed">회원탈퇴를 신청하면 서비스 이용시 보관 되었던 정보가 삭제됩니다. </li>
						 <li class="dashed">회원탈퇴 후 사이트를 더 이상 이용 할 수 없으며 모든 개인정보는 삭제 됩니다. 
						 <span style="border-bottom:0px solid red;  color:#C60000; font-size:12px;">다만, 대출내역등을 보존하기 위하여 ID는 삭제되지 않습니다.</span></li>
						 <li class="dashed"><span style="border-bottom:0px dotted red; color:red;">회원탈퇴 후 출입카드의 정보가 삭제 되므로 더이상 센터에 출입을 하실 수 없습니다.</span></li>
					</ul>
				</div>
	    		
			<table class="basic_table" style="border-top: 1px solid #CCDDED; margin-top:30px;">
						<!-- <table class="view_table"> -->
						<caption>회원정보 수정</caption>
						<colgroup>
							<col width="100%">
						</colgroup>
							<tbody class="report">
							<tr>
								<td style="text-align:center; color:#003964;">
									타인에 의한 회원탈퇴를 방지하기 위하여 비밀번호를 넣어 주시기 바랍니다.
								</td>
							</tr>
							<tr style="border-bottom:0; height:100px; line-height:100px;">
								<td style="text-align:center;"> 기존 비밀번호
									<input name="password" type="password" style="margin-left:10px;" id="rpassword"  value=""  onkeypress="if(event.keyCode == 13){ fncMemberPW(); return; }"/>
								</td>
							</tr>
							</tbody>
						</table>
			
			
			<div class="btn-group">
				<a href="javascript:fncMemberOut();" class='basic-btn'><span>회원탈퇴</span></a>
			</div>
	    </div>
		</div>
	</div>
 	
 	
 	<!-- 공통  필수 PARAM -->
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/>
</form>
</body>
</html>