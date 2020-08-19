<%@page import="kr.go.cris.commons.constants.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-cache"/> 
<meta http-equiv="Expires" content="0"/> 
<meta http-equiv="Pragma" content="no-cache"/>
<title>사용자관리 | 정부출연연구기관 채용정보서비스</title>

<link rel="stylesheet" href="${ctxt}/resources/css/jquery-ui.css">
<script type="text/javascript" src="${ctxt}/resources/js/rsa/jsbn.js"></script>
<script type="text/javascript" src="${ctxt}/resources/js/rsa/rsa.js"></script>
<script type="text/javascript" src="${ctxt}/resources/js/rsa/prng4.js"></script>
<script type="text/javascript" src="${ctxt}/resources/js/rsa/rng.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<script type="text/javascript">
var cuurPage;
var person_list = "";
var career_list = "";
var work_list = "";
var org_list = "";


$(function() {
	
	$('input[name=auth_list]').click(function(){
		if($('input[value=ROLE_ORG]').is(":checked") == true && $(this).val() == "ROLE_ORG"){
			$('#org_mng').attr('style','');
			$('html, body').animate({ scrollTop: 0},500);
			$('#org_mng').focus();
			
		}else{
			$('#org_mng').attr('style','display: none;');
		}
	});
	$('#auth_td').find('.chk_name').click(function(){
		if($('input[value=ROLE_ORG]').is(":checked") == true && $(this).parent().find('input[type=checkbox]').val() == "ROLE_ORG"){
			$('#org_mng').attr('style','');
			$('html, body').animate({ scrollTop: 0},500);
			$('#org_mng').focus();
		}else{
			$('#org_mng').attr('style','display: none;');
		}
	});
	
	// 캘린더 - 생년월일
	$( "#brth_dt" ).datepicker({
		showOn: "both",	// 버튼과 텍스트 필드 모두 캘린더를 보여준다. both, button
		buttonImage: "${ctxt}/resources/img/common/ico_dal.png",	// 버튼 이미지
		buttonImageOnly: true,	// 버튼에 있는 이미지만 표시한다.
		changeYear: true,	// 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
		changeMonth: true,	// 월을 바꿀수 있는 셀렉트 박스를 표시한다.
		buttonText: "Select date",	// 캘린더 이미지 마우스 오버시
		dateFormat: 'yy-mm-dd',	// 데이터 포멧
		yearRange: "c-100:c",	// 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가. ex) c-100:c+10, c-100:c
		dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],	// 요일의 한글 형식.
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'], // 월의 한글 형식.
	});
	

	// 캘린더 - 졸업 예정일자
	$( "#gradu_dt" ).datepicker({
		showOn: "both",	// 버튼과 텍스트 필드 모두 캘린더를 보여준다. both, button
		buttonImage: "${ctxt}/resources/img/common/ico_dal.png",	// 버튼 이미지
		buttonImageOnly: true,	// 버튼에 있는 이미지만 표시한다.
		changeYear: true,	// 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
		changeMonth: true,	// 월을 바꿀수 있는 셀렉트 박스를 표시한다.
		buttonText: "Select date",	// 캘린더 이미지 마우스 오버시
		dateFormat: 'yy-mm-dd',	// 데이터 포멧
		yearRange: "c-100:c",	// 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가. ex) c-100:c+10, c-100:c
		dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],	// 요일의 한글 형식.
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
	});

	
	var cls_gbn = $('#cls_gbn').val().split(',');
	
	$(cls_gbn).each(function(cnt){
		var p_list = $('#cls_gbn').val().split(",");
		$(p_list).each(function(cnt){
			$('input[value='+p_list[cnt]+']').prop('checked',true);
		});
	});

	if($('input[value=ROLE_ORG]').is(":checked") == false){
		$('#org_mng').attr('style','display: none;');
	}
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


// 마이페이지 수정 버튼
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
			fn_alert('비밀번호는 영문/숫자/특수문자를 섞어 9~20자를 입력하세요.','c');
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
     
     if($("input[name=auth_list][value=ROLE_ADMIN]:checked").length == 0 && $("input[name=auth_list][value=ROLE_ORG]:checked").length == 0 ){
     
		// 관심기관
		if($("input[name=org_list]:checked").length == 0){
			fn_alert("관심기관을 1개이상 선택해주세요.","c");
			return;
		}
		
		// 인력구분
		if($("input[name=person_list]:checked").length == 0){
			fn_alert("인력구분을 1개이상 선택해주세요.","c");
			return;
		}
	
		// 직종구분
		if($("input[name=work_list]:checked").length == 0){
			fn_alert("직종구분을 1개이상 선택해주세요.","c");
			return;
		}
		
		// 경력구분
		if($("input[name=career_list]:checked").length == 0){
			fn_alert("경력구분을 1개이상 선택해주세요.","c");
			return;
		}
	
    }
	
	// 경력구분
	if($("input[name=auth_list]:checked").length == 0){
		fn_alert("권한구분을 1개이상 선택해주세요.","c");
		return;
	}
	
	
	
     $.ajax({ // RSA 공개키 요청
       type: 'GET',
       url : '${ctxt}/cmmn/util/getRSAKey.xml',
       data: {sessionKey: '<%=Constants.RSA_KEY_MODI%>'}, 
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
	          var auth_list = "";
	          // 관심기관
	          $("input[name=org_list]:checked").each(function(){
	        	 cls_gbn_list += $(this).val()+",";
	          });
	          
	          //인력구분
	          $("input[name=person_list]:checked").each(function(){
	        	 cls_gbn_list += $(this).val()+",";
	          });
	          
	          // 직종구분
	          $("input[name=work_list]:checked").each(function(){
	        	 cls_gbn_list += $(this).val()+",";
	          });
	          
	          // 경력구분
	          $("input[name=career_list]:checked").each(function(){
	        	 cls_gbn_list += $(this).val()+",";
	          }); 
	          
	          // 권한구분
	          $("input[name=auth_list]:checked").each(function(){
	        	  auth_list += $(this).val()+",";
	          }); 

	          var params = {};
 	          
	          params.user_sn = $('#user_sn').val();
 	          params.loginid = rsa.encrypt($('#eml').val());
 	          params.user_pwd = rsa.encrypt($('#user_pwd').val());
 	          params.user_nm_kor = rsa.encrypt($('#user_nm_kor').val());
 	          params.user_nm_eng = rsa.encrypt($('#user_nm_eng').val());
 	          
 	          params.brth_dt = rsa.encrypt($('#brth_dt').val());
 	          
 	          if($("input[name=sex_gb]:checked").length != 0){
 	          	params.sex_gb = rsa.encrypt($("input[name=sex_gb]:checked").val());
 	          }
 	          	
 	          params.tel1 = rsa.encrypt($('#tel1').val());
 	          params.tel2 = rsa.encrypt($('#tel2').val());
 	          params.tel3 = rsa.encrypt($('#tel3').val());
 	          
 	          params.clpn1 = rsa.encrypt($('#clpn1').val());
 	          params.clpn2 = rsa.encrypt($('#clpn2').val());
 	          params.clpn3 = rsa.encrypt($('#clpn3').val());
 	          params.etc_clpn = rsa.encrypt($('#etc_clpn').val());
 	          params.unv_bss_nm = rsa.encrypt($('#unv_bss_nm').val());
 	          params.prcss_code = rsa.encrypt($('#prcss_code').val());
 	          params.major_nm = rsa.encrypt($('#major_nm').val());
 	          params.par_major_nm = rsa.encrypt($('#par_major_nm').val());
 	          params.gradu_dt = rsa.encrypt($('#gradu_dt').val());
 	          params.rep_paper = $('#rep_paper').val();
 	          params.ppr_out_rslt = $('#ppr_out_rslt').val();

 	          params.eml_send_yn = rsa.encrypt($("input[name=eml_send_yn]:checked").val());
 	          params.sms_send_yn = rsa.encrypt($("input[name=sms_send_yn]:checked").val());
 	          params.use_yn = $("input[name=use_yn]:checked").val();
 	          
 	          params.eml = rsa.encrypt($('#eml').val()); 

 	          
 	          if(auth_list.indexOf("ROLE_ORG") != -1){
 	        	 params.org_cd = $('#org_mng option:selected').val(); 
 	          }else{
 	        	 params.org_cd = ""; 
 	          }
 	          
 	          params.cls_gbn_list = cls_gbn_list; 
 	          params.usrAuth = auth_list; 
 	     
           $.ajax({ // RSA로 암호화된 개인 정보 전송
             type: 'POST',
             url : '${ctxt}/mng/user/updateUser.do',
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
                 fn_alert(msg,'e');
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
	
	form.action = "${ctxt}/mng/user/userView.do"
    
	form.submit();

}

// 목록으로 돌아가기
function fn_goList(){
	
	var form = document.form;
	
	form.action = "${ctxt}/mng/user/userList.do"
    
	form.submit();

}

// 서비스 연장 갱신
function fn_lea(){
	
	var params = {};
	
	params.loginid = $('#eml').val();
	//params.exp_dt = $('#str_exp_dt').val().replace(/[.]/gi,'');
	
    $.ajax({ // 서비스 만료 갱신
        type: 'POST',
        url : '${ctxt}/hrdb/updateUserLea.do',
        data: params,
        //cache: true,    //cache가 있으면 새로운 내용이 업데이트 되지 않는다.
        success:function(data){
        	fn_alert('만료일이 갱신 되었습니다.','n');
        	setTimeout("fn_load()",1000);
        },
        error: function(xhr, status, error){
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
      });
	
}
//backspace 막기 생년월일 , 졸업예정일
function fn_backSpaceOff(){
	var kcode = event.keyCode;	
	if(kcode == 8 ){ // backspace		
		if(window.event.srcElement.readOnly == true){
			event.preventDefault();			
		}	  
  	}	
	
}
</script>
</head>

<body>

<div id="container">

	<div id="content">

		<h2>사용자관리</h2>
		
		<div class="clear"></div>

		<h5 class="title">인재정보</h5>
	<form id="form" name="form" action="" method="post">
			<input type="hidden" id="page" name="page" value="${PTLLoginVo.page}" /> 
			<input type="hidden" id="s_org_list" name="s_org_list" value="${PTLLoginVo.org_list}" /> 
			<input type="hidden" id="s_person_cd" name="s_person_cd" value="${PTLLoginVo.person_cd}" /> 
			<input type="hidden" id="s_work_cd" name="s_work_cd" value="${PTLLoginVo.work_cd}" /> 
			<input type="hidden" id="s_career_cd" name="s_career_cd" value="${PTLLoginVo.career_cd}" /> 
			<input type="hidden" id="s_sex_gb" name="s_sex_gb" value="${PTLLoginVo.sex_gb}" /> 
			<input type="hidden" id="str_dt" name="str_dt" value="${PTLLoginVo.str_dt}" /> 
			<input type="hidden" id="end_dt" name="end_dt" value="${PTLLoginVo.end_dt}" /> 
			<input type="hidden" id="user_sn" name="user_sn"  value="${mngUserInfo.user_sn}"  />
			<input type="hidden" id="eml" name="eml"  value="${mngUserInfo.loginid}"  />
			<input type="hidden" id="cls_gbn" name="cls_gbn"  value="${cls_gbn_list}"  />
			<input type="hidden" id="org_cd" name="org_cd" value="${PTLLoginVo.org_cd}"  />
			<input type="hidden" id="search_text" name="search_text"  value="${PTLLoginVo.search_text}"  />
			<input type="hidden" id="searchStatus" name="searchStatus"  value="${PTLLoginVo.searchStatus}"  />
			<input type="hidden" id="save_type" name="save_type"  value=""  />
		
		<table class="table-ap" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="20%">
			<col width="30%">
			<col width="20%">
			<col width="30%">
		</colgroup>
		<tbody>
		<tr>
			<th><span class="no_req">E-mail</span></th>
			<td class="left" id="idchekInput">${mngUserInfo.loginid}</td>
			<th><span class="no_req">소속</span></th>
			<td class="left">
				<select id="org_mng">
				<c:forEach items="${org_list}" var="org" varStatus="stats">
					<option value="${org.cd}" <c:if test="${org.cd eq mngUserInfo.org_cd}"> selected="selected"</c:if>   >${org.cd_nm}</option>
				</c:forEach>
				</select>
			</td>	
		</tr>
		<tr>
			<th><span class="no_req">비밀번호</span></th>
			<td class="left" colspan="3"><input type="hidden" id="checkedPwYN" name="checkedPwYN" value="N"> 
				<input type="password" id="user_pwd" name="user_pwd" value="" maxlength="20" onblur="fn_pwCheck()"> 
				<!-- <span class="checkMsg" id="pWCheck">&nbsp;&nbsp;&nbsp;비밀번호는 영문/숫자/특수문자를 섞어 9~20자를 입력하세요</span> -->
			</td>
		</tr>
		<tr>	
			<th><span class="no_req">비밀번호 확인</span></th>
			<td class="left"><input type="hidden" id="checkedPwYN" name="checkedPwYN" value="N">
				<input type="password" id="user_pwdCheck" name="user_pwdCheck" value="" maxlength="20" onblur="fn_pwCheck_new()"> 
				<span class="checkMsg ok" id="pWCheck_new"></span>
			</td>
			<th><span class="no_req">서비스 만료</span></th>
			<td class="left">${mngUserInfo.exp_dt}
				&nbsp;&nbsp;
				<%-- <c:if test="${mngUserInfo.view_yn eq 'Y'}"> --%>
					<a href="javascript:fn_lea();" class="btn_sch" >서비스 연장</a>
				<%-- </c:if> --%>
			</td>
		</tr>
		<tr>
			<th><span class="no_req">이름</span></th>
			<td class="left">	<input type="text" id="user_nm_kor" name="user_nm_kor" value="${mngUserInfo.user_nm_kor}"></td>

			<th><span class="no_req">이름(영문)</span></th>
			<td class="left">
				<input type="text" id="user_nm_eng" name="user_nm_eng" value="${mngUserInfo.user_nm_eng}" maxlength="20">
			</td>
		</tr>
		<tr>
			<th><span class="no_req">생년월일</span></th>
			<td class="left">
				<input type="text" id="brth_dt" name="brth_dt" value="${mngUserInfo.brth_dt}" maxlength="8" readonly="readonly" onkeydown="javascript:fn_backSpaceOff();">
			</td>
			<th><span class="no_req">성별${mngUserInfo.sex_gb}</span></th>
			<td class="left">
 				<c:if test="${mngUserInfo.sex_gb eq '1'}">
					<span class="cbox"><input type="radio" id="sex_b" name="sex_gb" value="1" checked="checked"><label for="sex_b"> 남</label></span>
					<span class="cbox"><input type="radio" id="sex_g" name="sex_gb" value="2"><label for="sex_g"> 여</label></span>
				</c:if>	
				<c:if test="${mngUserInfo.sex_gb eq '2'}">
					<span class="cbox"><input type="radio" id="sex_b" name="sex_gb" value="1"><label for="sex_b"> 남</label></span>
					<span class="cbox"><input type="radio" id="sex_g" name="sex_gb" value="2" checked="checked"><label for="sex_g"> 여</label></span>
				</c:if>	 
				<c:if test="${mngUserInfo.sex_gb eq null}">
					<span class="cbox"><input type="radio" id="sex_b" name="sex_gb" value="1"><label for="sex_b"> 남</label></span>
					<span class="cbox"><input type="radio" id="sex_g" name="sex_gb" value="2"><label for="sex_g"> 여</label></span>
				</c:if>
			</td>
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
				<span><input type="text" id="tel2" name="tel2" value="${mngUserInfo.tel2}" maxlength="4"onkeyUp="this.value=this.value.replace(/[^0-9]/g,'')"></span> 
			  - <span><input type="text" id="tel3" name="tel3" value="${mngUserInfo.tel3}" maxlength="4"onkeyUp="this.value=this.value.replace(/[^0-9]/g,'')"></span> 
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
				- <span><input type="text" id="clpn2" name="clpn2" value="${mngUserInfo.clpn2}" maxlength="4"onkeyUp="this.value=this.value.replace(/[^0-9]/g,'')"></span> 
				- <span><input type="text" id="clpn3" name="clpn3" value="${mngUserInfo.clpn3}" maxlength="4" onkeyUp="this.value=this.value.replace(/[^0-9]/g,'')"></span>
				<span><input type="hidden" id="usrHp" name="usrHp" value=""></span>
			</td>
		</tr>
		<tr>
			<th><span class="no_req">대학(직장)명</span></th>		
			<td class="left"><span><input type="text" id="unv_bss_nm" name="unv_bss_nm" value="${mngUserInfo.unv_bss_nm}" maxlength="100"></span></td>
			<th><span class="no_req">국외번호</span></th>		
			<td class="left"><span><input type="text" id="etc_clpn" name="etc_clpn" value="${mngUserInfo.etc_clpn}" maxlength="100"onkeyUp="this.value=this.value.replace(/[^0-9|-]/g,'')"></span></td>
		</tr>
		<tr>
			<th><span class="no_req">전공</span></th>		
			<td class="left"><span><input type="text" id="major_nm" name="major_nm" value="${mngUserInfo.major_nm}" maxlength="150"></span></td>
			<th><span class="no_req">과정명</span></th>		
			<td class="left">
				<select id="prcss_code" name="prcss_code">
					<option value="">선택</option>					
					<c:forEach items="${prcss_list}" var="prcss" varStatus="stats">
					<option value="${prcss.cd}" <c:if test="${mngUserInfo.prcss_code eq prcss.cd}"> selected="selected"</c:if>>${prcss.cd_nm}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<th><span class="no_req">졸업예정일</span></th>
			<td class="left" >
				<input type="text" id="gradu_dt" name="gradu_dt" value="${mngUserInfo.gradu_dt}" maxlength="8" readonly="readonly" onkeydown="javascript:fn_backSpaceOff();">
			</td>
			<th><span class="no_req">세부전공분야</span></th>		
			<td class="left"><span><input type="text" id="par_major_nm" name="par_major_nm" value="${mngUserInfo.par_major_nm}" maxlength="200"></span></td>
		</tr>
		<tr>
			<th><span class="no_req">대표논문</span></th>
			<td class="left" colspan="3"><span><textarea id="rep_paper" name="rep_paper" rows="5" style= "width:98%; border-right: 1px solid #ccc;" maxlength="1800" title="대표논문 내용" >${mngUserInfo.rep_paper}</textarea></span></td>
		</tr>
		<tr>
			<th><span class="no_req">논문 외 실적</span></th>
			<td class="left" colspan="3"><span><textarea id="ppr_out_rslt" name="ppr_out_rslt" rows="5" style= "width:98%; border-right: 1px solid #ccc;" maxlength="1800" title="논문외 실적"  >${mngUserInfo.ppr_out_rslt}</textarea></span></td>
		</tr>
		<tr>
			<th><span class="no_req">E-mail 수신여부</span></th>		
			<td class="left">
				<c:if test="${mngUserInfo.eml_send_yn eq 'Y'}">
					<span class="cbox"><input type="radio" id="eml_send_y" name="eml_send_yn" value="Y" checked="checked"><label for="eml_send_y"> 수신</label></span>
					<span class="cbox"><input type="radio" id="eml_send_n" name="eml_send_yn" value="N"><label for="eml_send_n"> 미수신</label></span>
				</c:if>
				<c:if test="${mngUserInfo.eml_send_yn eq 'N'}">
					<span class="cbox"><input type="radio" id="eml_send_y" name="eml_send_yn" value="Y"><label for="eml_send_y"> 수신</label></span>
					<span class="cbox"><input type="radio" id="eml_send_n" name="eml_send_yn" value="N" checked="checked"><label for="eml_send_n"> 미수신</label></span>
				</c:if>
			</td>
			<th><span class="no_req">SMS 수신여부</span></th>		
			<td class="left">
				<c:if test="${mngUserInfo.sms_send_yn eq 'Y'}">
					<span class="cbox"><input type="radio" id="sms_send_y" name="sms_send_yn" value="Y" checked="checked"><label for="sms_send_y"> 수신</label></span>
					<span class="cbox"><input type="radio" id="sms_send_n" name="sms_send_yn" value="N" ><label for="sms_send_n"> 미수신</label></span>
				</c:if>
				<c:if test="${mngUserInfo.sms_send_yn eq 'N'}">
					<span class="cbox"><input type="radio" id="sms_send_y" name="sms_send_yn" value="Y"><label for="sms_send_y"> 수신</label></span>
					<span class="cbox"><input type="radio" id="sms_send_n" name="sms_send_yn" value="N" checked="checked"><label for="sms_send_n"> 미수신</label></span>
				</c:if>
			</td>
		</tr>
		</tbody>
		</table>
	

		<h5 class="title">관심분야설정</h5>
		<table class="table-ap" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="20%">
			<col width="80%">
		</colgroup>
		<tbody>
		<tr>
			<th><span class="no_req">관심기관</span></th>
			<td colspan="3 "class="left">
				<c:forEach items="${org_list}" var="org" varStatus="stats">
					<span class="cbox2"><input type="checkbox" name="org_list" value="${org.cd}"><span class="chk_name" > ${org.cd_nm}</span></span>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th><span class="no_req">인력구분</span></th>
			<td class="left" colspan="3">
				<c:forEach items="${person_list}" var="person" varStatus="stats">
					<span class="cbox2"><input type="checkbox" name="person_list" value="${person.cd}"><span class="chk_name" > ${person.cd_nm}</span></span>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th><span class="no_req">직종</span></th>
			<td class="left" colspan="3">
				<c:forEach items="${work_list}" var="work" varStatus="stats">
					<span class="cbox2"><input type="checkbox" name="work_list" value="${work.cd}"><span class="chk_name" > ${work.cd_nm}</span></span>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th><span class="no_req">경력구분</span></th>
			<td class="left" colspan="3">
				<c:forEach items="${career_list}" var="career" varStatus="stats">
					<span class="cbox2"><input type="checkbox" name="career_list" value="${career.cd}"><span class="chk_name" > ${career.cd_nm}</span></span>
				</c:forEach>
			</td>
		</tr>
		</tbody>
		</table>
		
		<h5 class="title">사용자권한</h5>
		<table class="table-ap" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="20%">
			<col width="80%">
		</colgroup>
			<tr>
			<th><span class="no_req">권한구분</span></th>
			<td class="left" colspan="3" id="auth_td" >
				<c:forEach items="${auth_list}" var="auth" varStatus="stats">
					<span class="cbox2"><input type="checkbox" name="auth_list" value="${auth.cd}"><span class="chk_name" > ${auth.cd_nm}</span></span>
				</c:forEach>
			</td>
		</tr>
		</table>
		<h5 class="title">사용여부</h5>
		<table class="table-ap" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="20%">
			<col width="80%">
		</colgroup>
			<tr>
			<th><span class="no_req">사용여부</span></th>		
			<td class="left">
				<c:if test="${mngUserInfo.use_yn eq 'Y'}">
					<span class="cbox"><input type="radio" id="use_y" name="use_yn" value="Y" checked="checked"><label for="use_y"> 사용</label></span>
					<span class="cbox"><input type="radio" id="use_n" name="use_yn" value="N" ><label for="use_n"> 미사용</label></span>
				</c:if>
				<c:if test="${mngUserInfo.use_yn eq 'N'}">
					<span class="cbox"><input type="radio" id="use_y" name="use_yn" value="Y"><label for="use_y"> 사용</label></span>
					<span class="cbox"><input type="radio" id="use_n" name="use_yn" value="N" checked="checked"><label for="use_n"> 미사용</label></span>
				</c:if>
			</td>
		</tr>
		</table>
		
	</form>
		
		<div class="buttons center m-bottom0">
			<a href="javascript:fn_save()" name="save_btn" class="btn type-a"><span>저장</span></a>
			<a href="javascript:fn_goList()" class="btn type-b"><span>목록</span></a>
		</div>
		
	</div>
</div>

</body>
</html>