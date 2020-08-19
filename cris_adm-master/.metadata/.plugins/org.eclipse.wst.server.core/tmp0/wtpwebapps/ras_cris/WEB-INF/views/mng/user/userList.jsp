<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Cache-Control" content="no-cache"/> 
<meta http-equiv="Expires" content="0"/> 
<meta http-equiv="Pragma" content="no-cache"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
<link href="${ctxt}/resources/css/tree/jquery.treeview.css" rel="stylesheet" type="text/css">
<link href="${ctxt}/resources/css/tree/code.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
var cuurPage;
var org_list = "";		// 채용기관
var person_list = "";	// 인력구분
var work_list = "";		// 직종구분
var career_list = "";	// 경력구분
var sex_gb = "";		// 성별
$(function(){
	
	// 캘린더 - 등록일
 	$(function() {
		$( "#str_dt" ).datepicker({
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
		$( "#end_dt" ).datepicker({
		showOn: "button",
		buttonImage: "${ctxt}/resources/img/common/ico_dal.png",
		buttonImageOnly: true,
		changeYear: true,
		changeMonth: true,
		buttonText: "Select date",
		dateFormat: 'yy-mm-dd'
		});
	}); 
	
    var page =$('#page').val();
	if(page == '' ){
		page=1;
	}
	fn_search(page);
	
});
function fn_save(){
	
	 	var formData = $("#authForm").serialize();
		$.ajax({
			url : '${ctxt}/mng/user/insertAuth.do',
			data : formData,
			dataType : "json",
			processData : false,
			type : 'POST',
			traditional : true,
			cache: false,
			success : function(result) {
				alert("저장을 완료 하였습니다.");
				
			},
			error : function() { // Ajax 전송 에러 발생시 실행
				fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
			}
// 			,
// 			complete : function(result) { //  success, error 실행 후 최종적으로 실행
// 				alert(resultText);
// 			}
		});
}
function fn_keySearch(){
    
	if(event.keyCode == 13){
		fn_search(1);
	}
}
/*
* 페이징 처리 2 : 페이지 num를 조회조건으로 넘겨서 조회, 페이지 이동시 ajax 재호출
*/
function fn_search(page){
	$('#userList .on').attr('class','off');
	$('#sel_user').text("");
	$('input:checkbox[name="auth"]').prop("checked",false);
	//현재 페이지 세팅
	cuurPage= page;
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/
	$('#page').val(cuurPage);
  	
	var params = {};
	$('#searchStatus').val($('#status option:selected').val());
	$('#usrAuth').val($('#auth option:selected').val());
	$('#org_cd').val($('#org option:selected').val());
	
    params.org_list  = "";		// 채용기관
    params.user_nm   = "";		// 채용기관
    params.person_cd = "";	// 인력구분
    params.work_cd   = "";		// 직종구분
    params.career_cd = "";	// 경력구분
    params.sex_gb    = "";			// 성별
    
    params.str_dt = "";	// 등록일 - 시작일자
    params.end_dt = "";	// 등록일 - 종료일자
    params.user_sn = "";
    params.org_cd  = $('#org option:selected').val();
    
    if($('#status option:selected').val() == 'id' ){
        params.user_nm_kor  = "";
        params.loginid  = $('#search_input').val(); 	
        params.user_sn  = ""; 	
    }else if($('#status option:selected').val() == 'name'){
        params.user_nm_kor  = $('#search_input').val(); 	
        params.loginid  = "";	
        params.user_sn  = "";
    }else{
        params.user_nm_kor  = ""; 	
        params.loginid  = "";		
        params.user_sn  = $('#search_input').val(); 
    }
	params.searchStatus = $('#status option:selected').val();
	params.searchText = $('#search_input').val();
	params.usrAuth = $('#auth option:selected').val();
    params.page    = cuurPage;     
    $.ajax({
        url: '${ctxt}/mng/user/selectUserList.do',
        data: params,
        type: 'POST',
        dataType: 'text',
        success: function(rtnXml) {
        	xmlList = $(rtnXml).find('item');
        	pagetotalCnt=0;
        	html="";
			if(xmlList.length > 0){
			
				//총페이지수
				pagetotalCnt = Number($(rtnXml).find('totalCnt').text());
				
				xmlList.each(function(cnt){
			
					var obj = $(this);
					
			
					
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					html += '<tr onclick="fn_selectAuth(\''+obj.find('loginid').text()+'\',this);" class="off" style="cursor: pointer;">';
					html += ' <td>'+obj.find('emplyrkey').text() +'</td>';
					html += ' <td>'+obj.find('loginid').text() +'</td>';
					html += ' <td>'+obj.find('emplyrnm').text() +'</td>';
					html += ' <td>'+obj.find('insttnm').text() +'</td>';
					html += '</tr>';   
	
		        });
				//페이징처리
			    $('#paging').paging({
			    	   
					 current:cuurPage
					,max:pagetotalCnt
					,length:pageLen
					,onclick:function(e,page){
						cuurPage=page;
						fn_search(cuurPage);
					}
				});
				
			    $("#userList").html(html);
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$('#paging').children().remove();
				
				$("#userList").html('<tr><td colspan="7" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
        	fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}
function fn_selectAuth(param_sn,obj){
	
	$('#userList .on').attr('class','off');
	$('#sel_user').text("선택 사용자 : "+param_sn);
	$(obj).attr('class','on');	
	$('#user_id').val(param_sn);
	
	 $.ajax({
	        url: '${ctxt}/mng/user/selectUserAuth.do',
	        data: {"loginid":param_sn},
	        type: 'POST',
	        dataType: 'text',
	        success: function(rtnXml) {
				$('input:checkbox[name="auth"]').prop("checked",false);
	        	
	        	xmlList = $(rtnXml).find('item');
	        	
	        	if(xmlList.length > 0){
	        		xmlList.each(function(cnt){
	        			
						var obj = $(this);
						
						var user_auth_cd = obj.find('user_auth_cd').text();
						
						if(user_auth_cd == 'ROLE_GUEST'){
							$('input:checkbox[id="ROLE_GUEST"]').prop("checked", true);
						}else if(user_auth_cd == 'ROLE_USER'){
							$('input:checkbox[id="ROLE_USER"]').prop("checked", true);
						}else if(user_auth_cd == 'ROLE_ADMIN'){
							$('input:checkbox[id="ROLE_ADMIN"]').prop("checked", true);
						}else{
							$('input:checkbox[id="ROLE_ARCHIVE"]').prop("checked", true);
						}
						
	        		});
	        	}
	        	
	        	pagetotalCnt=0;
	        },
	        error : function(){                              // Ajax 전송 에러 발생시 실행
	        	fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
	        }
	    });
	
	 
	 
}
// 조회 조건 초기화
function fn_clear(){
	//변수들 초기화
	org_list = "";
  	person_list = "";
	work_list = "";
	career_list = "";
	sex_gb = "";
	$("form")[0].reset();
	$("form").find('input[type=text]').val(''); 
}
</script>
</head>

<body>

<div id="container">

	<div id="divRefreshArea">
	<form action="" name="form" id="form" method="post">
	
		<input type="hidden" name="user_sn" id="user_sn" value="" /> 
		<input type="hidden" id="page" name="page" value="${PTLLoginVo.page}" /> 
		<input type="hidden" id="save_type" name="save_type" value="" /> 

		<h2><spring:message code="menu.user.poolMgmt" /></h2>
		<br />
		<div class="search_area" style="margin-left: 1%;margin-bottom: 1%;">
			<span class="search_label">권한그룹</span>
			<select id="auth" name="auth">
				<option value="">전체</option>
				<c:forEach items="${auth_list}" var="auth" varStatus="state">
					<option value="${auth.cd}" <c:if test="${PTLLoginVo.usrAuth == auth.cd}" >selected</c:if> ><label for="${org.cd}">${auth.cd_nm}</label></option>	
				</c:forEach>
			</select>
			<span class="search_label">
				<select id="status" name="status" style="width: 100px;">
					<option value="name" <c:if test="${PTLLoginVo.searchStatus == 'name'}" >selected</c:if>  >사용자명</option>
					<option value="id" <c:if test="${PTLLoginVo.searchStatus == 'id'}" >selected</c:if> >사용자ID</option>
					<option value="sn" <c:if test="${PTLLoginVo.searchStatus == 'sn'}" >selected</c:if> >사용자번호</option>
				</select>
			</span>
			<label for="search_input" class="hide">검색창</label>
			<input type="text" name="search_input" id="search_input" value="" onkeypress="javascript:fn_search(1)" > 
				<a href="javascript:fn_search(1)" class="a_btn" name=""><span>조회</span></a>
		</div>
	</form>

		<div style="width: 100%">
			<div style="float: left;width: 63%;margin-left: 1%;">
				<table class="basic_table" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="25%">
						<col width="25%">
						<col width="20%">
						<col width="25%">
					</colgroup>
					<thead>
					<tr>
						<th>번호</th>  
						<th>ID</th> 
						<th>이름</th>
						<th>소속</th>
					</tr>   
					</thead>
				
					<!-- DATA 바인드 -->
					<tbody id="userList">
					</tbody>
				
				</table>
			
				<!-- 페이징 처리 -->
				<div id="paging" class="paginate"></div>

			</div>
			<div style="float:right; width: 33%;margin-right: 1%;" >
				<div style="float: right; width: 100%;" >
					<!-- save_btn -->
					<button class="addItemBtn" name="" onclick="fn_save()" >저장</button>
					<span id="sel_user"></span>
					
				</div>
				<form name="authForm" id="authForm" action="" method="post">
				<input type="hidden" name="user_id" id="user_id"  value="" />
		        <table class="basic_table" border="1" cellspacing="0" summary="권한 관리 테이블 입니다."> 
					<caption>권한관리</caption> 
					<colgroup>
						<col width="25%" />
						<col width="75%" />
					 </colgroup> 
					<thead>  
					</thead>  
					<tbody id="auth_list"> 
						<c:forEach items="${auth_list}" var="auth" varStatus="state">
						<tr name="${auth.ref_val1}" > 
							<th>${auth.cd_nm} 권한</th>
							<td style="cursor: pointer;"><!--<c:if test="${ptlInformVo.newDataYn == '0'}">checked</c:if>  -->
								<input type="checkbox" id="${auth.cd}" name="auth" value="${auth.cd}"/>${auth.cd_nm} <br />	
							</td>
						</tr>
						</c:forEach>
					</tbody> 
				</table>     
				</form>
			</div>
		</div>    
	</div>
</div>

</body>
</html>