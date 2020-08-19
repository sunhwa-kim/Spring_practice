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

function fncMemberSch() {
	if ($("#mbtlnum").val() == "") {
		alert("휴대폰 번호를 입력하여 주시기 바랍니다.");
		$("#mbtlnum").focus();
		return;
	}
	
	if(!IS_SUBMIT){
				  
        var params = {};
        $.ajax({
        	 url: '${ctxt}/member/regi/searchEmplyr.do',
  		     data: $("form[name=reqForm]").serialize(),  
  		     type: 'POST',
  		   	 dataType: 'text',
		     cache: false,
		     success: function(result) {
				  if(result=='Y'){ //성공
					  alert("회원님의 휴대폰 번호로 ID/PW 가 발송 되었습니다.");
				  }else if(result=='N'){
					  alert("가입된 휴대폰 번호가 없습니다.");
				  }else if(result=='F'){
					  alert("ID/PW 찾기에 실패하였습니다.");
				  }
		   },
		   error : function(){                              // Ajax 전송 에러 발생시 실행
	 		     fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
	 		   }
        });
        
	}
	
} 


$(function() {
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
	
});
</script>
<style>
input#mbtlnum{
	width: 225px;
    height: 38px;
    padding-left: 25px;
    border: 1px solid #ccc;
    box-sizing: border-box;
    vertical-align: top;
    font-size: 12px;
}
</style>
</head>
<body>
	<!-- 컨텐츠 영역 -->
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>로그인</span>
			<span> > </span>
			<span class="active">ID/PW 찾기</span>        			      
		</div>
		<span class="center_text_01">ID/PW 찾기</span>
	</div> 
	<div class="under_bar"></div>
	
	<div  class= "content_wrap">
		<div class="content_box">
			<div class="content_list" style="font-size:14px;color:#7f7f7f;">
				<div style="border:1px solid #dfdfdf; padding-left:30px; margin-bottom:20px;">
					<p>- 아이디 찾기, 비밀번호 변경을 위해 다음단계를 진행해 주시기 바랍니다. </p>
					<p>- 휴대폰 번호 입력 후 해당번호로 <span style="color:red"><strong>문자메세지 수신여부와 상관없이</strong></span>
				   ID와 초기화된 비밀번호가 SMS로 발송 됩니다.  </p>
					<p>- 초기화된 비밀번호로 로그인 하신 후 My Library 에서  <span style="color:red"><strong>반드시 비밀번호를 수정</strong></span>하여 주시기 바랍니다.</p>  
				</div>



				<form name="reqForm" method="post">
					<div style="text-align: center;">
						<span class="" style="line-height:38px; margin-right:10px;"><label for="mbtlnum">휴대폰 번호 입력</label></span>
						<input name="mbtlnum" type="text" id="mbtlnum" value="" size="30"/> 
				    </div>
				    
				    <div class="btn-group">
						<a href="javascript:fncMemberSch();" class='basic-btn'><span>찾기</span></a>
					</div>
					<!-- 추가 PARAM -->
					<input type="hidden" name="page" id="page" value="" alt="pageNum" /> 
				 	
				 	<!-- 공통  필수 PARAM -->
				 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/>
				</form>
			</div>
		</div>
	</div>
</body>
</html>