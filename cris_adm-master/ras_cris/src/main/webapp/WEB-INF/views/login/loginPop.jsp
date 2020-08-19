<%@page import="kr.go.cris.commons.constants.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<title>비밀번호 찾기 | 정부출연연구기관 채용정보서비스</title>
 <!-- jquery -->
<script src="${ctxt}/resources/js/jquery-1.11.3.min.js"></script>
<script src="${ctxt}/resources/js/jquery.easing.min.js"></script>
<script src="${ctxt}/resources/js/html5shiv.min.js"></script>
<script src="${ctxt}/resources/js/jquery.popupoverlay.js"></script>
<script src="${ctxt}/resources/js/shortcut.js"></script>
<!-- common js -->
<script src="${ctxt}/resources/js/common.js"></script>

<!-- css -->
<link rel="stylesheet" href="${ctxt}/resources/css/pop.css">
<link rel="stylesheet" href="${ctxt}/resources/css/main.css">

  <script type="text/javascript">
    $(function() {

    });
    
    function checkData(){
    	var loginid = $('#eml_id').val();
    	var user_nm = $('#user_nm').val();
    	if(loginid == ''){
    		alert("아이디를 입력하세요.");
    		return false;
    	}
    	if(user_nm == ''){
    		alert("이름을 입력하세요.");
    		return false;
    	}
    	
    	var space = /^\s+|\s+$/g;
    	if (!space.test(loginid) || !space.test(user_nm)){ 
            
    	}else{
        	alert("공백은 입력할 수 없습니다.");
            return false;
        }
    	var params ={};
   
    	params.loginid = $("#eml_id").val();
    	params.user_nm_kor = $("#user_nm").val();
    	
    	$.ajax({
    		url:"${ctxt}/login/selectPwdUser.do",
    		data:params,
    		type:"post",

    		success:function(data){

    			var html = "";
    			
    			if(data == 0){
    				html += '<p><strong>아이디와 이름을 다시 입력 해주세요.</strong></p>'; 
    			}else{
    				$('#loginid').val($("#eml_id").val());
    				$('#user_nm_kor').val($("#user_nm").val());
    				/*html += '<div style="padding-left:200px;">';
    				html += '<table> <tr>';
    				html += '<td><img src="/resources/img/common/icon_mail.gif" alt="메일발송" /></td>';
    				html += '<td style="padding-left:10px;">'+$("#loginid").val()+'</td>';
    				html += '<td style="padding-left:10px;"><a href="javascript:sendEml()" style="" ><img src="/resources/img/common/btn_24_send_2.gif" alt="메일발송" /></td>';
    				html += '</tr></table>'
    				html += '</div >';*/
					html += '<div>';
					html += '<span><img src="${ctxt}/resources/img/common/icon_mail.gif" alt="메일발송" /></span>';
    				html += '<span>'+$("#loginid").val()+'</span>';
    				html += '<span><a href="javascript:sendEml()" style="" ><img src="${ctxt}/resources/img/common/btn_24_send_2.gif" alt="메일발송" /></a></span>';
					html += '</div>';
    				$("#eml_id").val('');
    				$("#user_nm").val('');
    			}
    			
    			$('#result').html(html);
    			
    			
    		},
    		error:function(ex){
    			fn_alert('오류가 발생하였습니다. <br /> 관리자에게 문의 바랍니다',"e");
    		}
    	});
    	
    }
    function fn_keySearch(){
    
    	if(event.keyCode == 13){
    		checkData();
    	}
    }
  </script>
</head>

<body>
<form name="login" id="login" action="" method="post" >
	<input type="hidden" name="loginid" id="loginid" value="" size="27" />
	<input type="hidden" name="user_nm_kor" id="user_nm_kor" value="" size="27" />
</form>
<div id="pop_wrap">		
	<h2>비밀번호 찾기</h2>
	<p>※ 사용자 <span>ID(이메일)·이름</span>을 입력하세요.</p>

	<div id="pop_container">
		<div class="loginInput">
			<label for="eml_id" class="iLabel"><img src="${ctxt}/resources/img/sub/login_icon03.png" alt="e-mail" /></label>
			<input type="text" id="eml_id" name="eml_id" onkeydown="fn_keySearch()" placeholder=" E-MAIL을 입력해주세요.">
		</div>
		<div class="loginInput">
			<label for="user_nm" class="iLabel"><img src="${ctxt}/resources/img/sub/login_icon01.png" alt="이름" /></label>
			<input type="text" id="user_nm" name="user_nm" onkeydown="fn_keySearch()" placeholder="이름을 입력해주세요.">
		</div>


 		 <!--ul class="search_check_1">
			<li><label for="loginid" class="iLabel"> ID(이메일)</label><input type="text" name="eml_id" id="eml_id" value="" size="27" onkeydown="fn_keySearch()" /></li>
			<li><label for="user_nm" class="iLabel"> 이름</label><input type="text" name="user_nm" id="user_nm" value="" size="27" onkeydown="fn_keySearch()" /></li>
		</ul-->		
		<a href="#" class="loginBtn" onclick="checkData();">비밀번호 찾기</a>
		<!--div class="btn_box">			
			<a href="#" onclick="checkData();"><img src="/resources/img/bbs/btn_search.gif" alt="확인" /></a>
		</div-->
	</div>
	<div id="result" class="search_text">
	</div>
	
	
</div>
	<!-- 팝업창 세팅 -->
	<a class="initialism fadeandscale_open btn btn-success" name="fadeandscale" style="display: none;">Fade &amp; scale</a>
	<div id="fadeandscale" class="well">
		<div id="msg_content"></div>
		    <br />
		<button class="fadeandscale_close btn btn-default">닫기</button>
	 </div>
</body>
</html>

