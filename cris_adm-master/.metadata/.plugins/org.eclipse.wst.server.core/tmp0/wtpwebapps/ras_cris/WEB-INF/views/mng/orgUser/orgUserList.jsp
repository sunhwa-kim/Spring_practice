<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
<title>기관담당자관리 | 정부출연연구기관 채용정보서비스</title>

<link rel="stylesheet" href="${ctxt}/resources/css/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<script type="text/javascript">
var cuurPage;
var org_list = "";		// 기관

$(function() {
	
    var page =$('#page').val();
	if(page == '' ){
		page=1;
	}
	
	// 조회조건 - 채용기관
	if($('#org_list').val() != '' ){
		var p_list = $('#org_list').val().split(",");
		$(p_list).each(function(cnt){
			$('input[name=org][value='+p_list[cnt]+']').prop('checked',true);
		});
	}
	
	fn_search(page);
	
}); 

/*
* 페이징 처리 2 : 페이지 num를 조회조건으로 넘겨서 조회, 페이지 이동시 ajax 재호출
*/
function fn_search(page){
	//현재 페이지 세팅
	cuurPage= page;
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/
	$('#page').val(cuurPage);
  	
	org_list = "";		// 기관
	
	var params = {};
	
	// 기관
  	$('input[name=org]:checked').each(function(){
	  	org_list += $(this).val()+",";
  	});
	
    params.org_list    = org_list.substring(0, org_list.length-1);	// 채용기관
    params.user_sn     = "";						// 기관 담당자 순번								
    params.loginid     = $('#loginid').val();		// 사용자 ID								
    params.user_nm_kor = $('#user_nm_kor').val();	// 이름(국문)	
    params.user_sn = "";
    params.org_cd  = "";
    params.page    = cuurPage;

    $.ajax({
        url: '${ctxt}/hrdb/selectOrgUserList.do',
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
					html += '<tr>';
					html += ' <td>'+obj.find('data__sn').text() +'</td>';
					html += ' <td>'+obj.find('org__cd').text() +'</td>';
					html += ' <td>'+obj.find('user__id').text() +'</td>';
					html += ' <td>'+obj.find('user__nm__kor').text() +'</td>';
					html += ' <td><a href="javascript:fn_page('+obj.find('user__sn').text()+')" class="btn1"><span>조회</span></a></td>';
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
				
			    $("#orgUserList").html(html);
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$('#paging').children().remove();
				
				$("#orgUserList").html('<tr><td colspan="5" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
        	fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}


//인재DB 상세 정보
function fn_page(user_sn){
	
	$('#user_sn').val(user_sn);
	$('#org_list').val(org_list.substring(0,org_list.length-1));
	$('#save_type').val("I");
	
	var form = document.form;
	form.action = "${ctxt}/mng/orgUser/orgUserView.do";
	form.submit();
	
}


// 조회 조건 초기화
function fn_clear(){
	
	//변수들 초기화
	org_list = "";
	$("form")[0].reset();
	$("form").find('input[type=text]').val(''); 
	
}

	
</script>
</head>

<body>

<div id="container">

	<div id="content">

	<form action="" name="form" id="form" method="post">

		<input type="hidden" name="user_sn" id="user_sn" value="" /> 
		<input type="hidden" id="page" name="page" value="${PTLLoginVo.page}" /> 
		<input type="hidden" id="save_type" name="save_type" value="" /> 
		
		<input type="hidden" id="org_list" name="org_list" value="${PTLLoginVo.org_list}" />

		<h2><spring:message code="menu.mng.instituteManager" /></h2>
		<h5 class="title ticol">조회 조건</h5>
		<!-- <p class="ticor">사항은 필수 입력사항입니다.</p> -->
		
		<table class="table-a" cellspacing="0" cellpadding="0">
		
		<colgroup>
			<col width="20%">
			<col width="30%">
			<col width="20%">
			<col width="30%">
		</colgroup>
		
		<tbody>
		<tr>
			<th>채용기관</th>
			<td colspan="3 "class="left">
				<c:forEach items="${org_list}" var="org" varStatus="state">
					<span class="cbox2"><input type="checkbox" name="org" id="${org.cd}" value="${org.cd}"><label for="${org.cd}"><span class="chk_name"> ${org.cd_nm}</span></label></span>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th><label for="loginid">ID</label></th>
			<td class="left">
				<input type="text" id="loginid" name="loginid" value="${PTLLoginVo.s_loginid}"> 
			</td>
			<th><label for="user_nm_kor">이름</label></th>
			<td class="left">
				<input type="text" id="user_nm_kor" name="user_nm_kor" value="${PTLLoginVo.s_user_nm_kor}"> 
			</td>
		</tr>
		</tbody>
		</table>
	</form>

			<div class="buttons center">
				<a href="javascript:fn_search(1)" class="btn type-a"><span>선택한 조건으로 조회하기</span></a>
				<a href="javascript:fn_clear()" class="btn type-b"><span>조회조건 초기화</span></a>
			</div>


		<h5 class="title">기관담당자목록</h5>

		<div class="table-b-wrap">
		<table class="table-b" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="10%">
			<col width="20%">
			<col width="30%">
			<col width="20%">
			<col width="20%">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>기관</th>
				<th>ID</th>
				<th>이름</th>
				<th>상세정보</th>
			</tr>
		</thead>
		
		<!-- DATA 바인드 -->
		<tbody id="orgUserList">
		</tbody>
		
		</table>

		<!-- 페이징 처리 -->
		<div id="paging" class="paginate"></div>
		<!-- 페이징 처리 -->

		<div class="buttons right m-bottom0 m-right0">
			<a href="${ctxt}/mng/orgUser/orgUserWrite.do" class="btn type-a m-right0"><span>등록</span></a>
		</div>

		</div>


	</div>
</div>
	
</body>
</html>
