<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
<title>사용자로그 | 정부출연연구기관 채용정보서비스</title>

<link rel="stylesheet" href="${ctxt}/resources/css/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<script type="text/javascript">

$(function(){
	

	$('#rcuit_stdt').val(fn_getDate("",-7,"-"));

	$('#rcuit_eddt').val(fn_getDate("",0,"-"));
	
	fn_search();
	
});


function fn_keySearch(){
	if(event.keyCode == 13){
		fn_search();
	}
}


/*
* 페이징 처리 2 : 페이지 num를 조회조건으로 넘겨서 조회, 페이지 이동시 ajax 재호출
*/
function fn_search(){
	if(fn_dateChk("rcuit_stdt", "rcuit_eddt") == false){
		return;
	}
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/

	var params = {};
	
	params.st_dt = $('#rcuit_stdt').val();
	params.ed_dt = $('#rcuit_eddt').val();
	params.user_nm = $('#search_text').val();

    $.ajax({
        url: '${ctxt}/mng/user/selectUserLogList.do',
        data: params,
        type: 'POST',
        dataType: 'text',
        success: function(rtnXml) {
        	xmlList = $(rtnXml).find('item');
        	pagetotalCnt=0;
        	html="";
			if(xmlList.length > 0){
				
				xmlList.each(function(cnt){
			
					var obj = $(this);
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					html += '<tr>';
					html += ' <td>'+obj.find('seq').text() +'</td>';
					html += ' <td>'+obj.find('user__id').text() +'</td>';
					html += ' <td>'+obj.find('log__dttm').text() +'</td>';
					html += ' <td>'+obj.find('log__ip').text() +'</td>';
					html += ' <td>'+obj.find('view__user__id').text() +'</td>';
					html += ' <td>'+obj.find('mdfy__dttm').text() +'</td>';
					html += ' <td style="text-align:left;" >'+obj.find('user__log__cont').text() +'</td>';

					html += '</tr>';
	
		        });
				
			    $("#hrDbList").html(html);
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$('#paging').children().remove();
				
				$("#hrDbList").html('<tr><td colspan="7" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
        	fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}

function fn_excel(){
	
	var strConfirm = confirm("엑셀다운로드 받으시겠습니까?");
	
	if(strConfirm){
		var params = {};
	    $('input[name=st_dt]').val($('#rcuit_stdt').val());
	    $('input[name=ed_dt]').val($('#rcuit_eddt').val());
	    $('input[name=user_nm]').val($('#search_text').val());

	     var form = document.logForm;
	     form.action = '${ctxt}/mng/user/excelDown.do';
	     form.submit();
	}
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

	<form action="" name="logForm" id="logForm" method="post">

		<input type="hidden" id="st_dt" name="st_dt" value="" /> 
		<input type="hidden" id="ed_dt" name="ed_dt" value="" /> 
		<input type="hidden" id="user_nm" name="user_nm" value="" /> 
		
		<input type="hidden" id="save_type" name="save_type" value="" /> 

		<%-- <h2><spring:message code="menu.user.poolMgmt" /></h2> --%>
		<h2><spring:message code="menu.mng.userLog" /></h2>
		<link rel="stylesheet" href="${ctxt}/resources/css/jquery-ui.css">
		<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
		 <script>
		  $(function() {
			$( "#rcuit_stdt" ).datepicker({
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

			$( "#rcuit_eddt" ).datepicker({
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
		  });
		  </script>

		<br />
		<div class="search_area" >
			<span class="search_label"><font style="font-weight: bold;"> 조회일자</font></span>
			<label for="rcuit_stdt" class="hide">시작일</label>
			<input type="text" style="text-align: center;" id="rcuit_stdt" name="rcuit_stdt" value="${jobInfoVo.rcuit_stdt}" maxlength="8" readonly="readonly"  onkeydown="javascript:fn_backSpaceOff();"/>&nbsp;&nbsp;-&nbsp;   
			<label for="rcuit_eddt" class="hide">종료일</label>
			<input type="text" style="text-align: center;" id="rcuit_eddt" name="rcuit_eddt" value="${jobInfoVo.rcuit_eddt}" maxlength="8" readonly="readonly" onkeydown="javascript:fn_backSpaceOff();"/>
			<span class="search_label"><font style="font-weight: bold;">접속ID</font></span>
			<input type="text" name="search_text" id="search_text" value="" maxlength="30" onkeyup="fn_keySearch()"> 
			<span class="right">
				<a href="javascript:fn_search()" name="search_btn" ><span>조회</span></a>
			</span>
		</div>
		
	</form>

		<h5 class="title">사용자 로그</h5>

		<div class="table-b-wrap" style="overflow-y: scroll; overflow-x: hidden;height: 500px;">
			<table class="table-b" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="5%">
				<col width="10%">
				<col width="15%">
				<col width="10%">
				<col width="10%">
				<col width="15%">
				<col width="20%">
			</colgroup>
			<thead>
				<tr>
					<th>순번</th>
					<th>접속ID</th>
					<th>접속일시</th>
					<th>접속IP</th>
					<th>열람대상ID</th>
					<th>열람일시</th>
					<th>내용</th>
				</tr>
			</thead>
			<!-- DATA 바인드 -->
			<tbody id="hrDbList">
			</tbody>
			</table>
		
		</div>
		<br />
		<!-- <span class="align_r"> -->
		<div style="text-align:right;">
			<input type="button"  value="다운로드" name="exceldown_btn" onclick="fn_excel()" />
		</div>
		<!-- </span> -->

	</div>
</div>

</body>
</html>