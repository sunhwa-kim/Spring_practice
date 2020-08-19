<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<!-- <meta name="decorator" content="index" http-equiv="Content-Type" content="text/html; charset=EUC-KR"> -->
<title>메뉴관리 | 정부출연연구기관 채용정보서비스</title>
<script type="text/javascript">

//dtree, 현재 선택 메뉴, 현재 선택 레벨

$(function(){
	//메뉴트리시작
	
	
});

/**
 * 	메뉴 저장
 */
function fn_save(obj){
	
	var trObj =$(obj).parent().parent();

	var strConfirm = confirm("변경하시겠습니까?");
	
	if(strConfirm){
		var param = {};
			param.sch_gb = $(trObj).find('#sch_gb').val();
			param.sch_time = $(trObj).find('td').eq(1).find('select:eq(0) option:selected').val()
			                    + $(trObj).find('td').eq(1).find('select:eq(1) option:selected').val();
		
		$.ajax({
		    url : '/mng/sys/saveSch.do',
		    data : param,   //전송파라미터
		    type : 'POST',
		    dataType : 'text',
		    success : function(result) {
		    		fn_alert('변경이 완료되었습니다.');
		    		setTimeout(location.href="${ctxt}/mng/sys/listSch.do", 2000);
		    		},
		    error : function() { // Ajax 전송 에러 발생시 실행
		           	fn_alert("에러처리 진행에 실패하였습니다.");
		    		},
		});
	}
}

</script>

</head>
<body>

<div id="container">

<div id="content" >

    	<h2><spring:message code="menu.mng.schInfo" /></h2>

		<div  class="admin_right" style="width: 60%;height:400px; margin: 5px 0 20px 15px;">
			<form name="menu_form"  action="mng_" method="post">
				<input type="hidden" name="save_type" id="save_type" value="" />
				<input type="hidden" name="rol_save_yn" id="rol_save_yn" value="" />
				<input type="hidden" id="menu_rol_list" name="menu_rol_list" value="" />
	
			<h5 class="title"> 스케줄러 정보 </h5>
			<div class="table-c-wrap" >
			<table class="table-c" style="border-top: solid 5px #2ab3ed; border-right:solid 2px #d6dadf !important;" cellspacing="0" cellpadding="0" summary="스켸쥴러정보를 설정 합니다."> 
				<caption>스케줄러 관리</caption> 
				<colgroup>
		            <col width="30%" />
		            <col width="20%" />
		            <col width="40%" />
		            <col width="10%" />
		         </colgroup> 
				<thead>  
					<tr >
						<th style="text-align: center;" >스케줄 구분</th>
						<th style="text-align: center;">최종반영일자</th>
						<th style="text-align: center;">스케줄 시간</th>
						<th style="text-align: center;">변경</th>
					</tr>
				</thead>  
				<tbody> 
					<c:forEach items="${schList}" var="sch" varStatus="stat">
						<tr>
							<th>${sch.sch_gb_nm}</th>
							<input name="sch_gb" id="sch_gb" class="keyword" style="text-align: center;"  accesskey="s" type="hidden" value="${sch.sch_gb}"  title="스켸쥴구분"  />
							<td style="text-align: center;">
								${sch.sch_dt}
							</td>
							<td style="text-align: center;">
								<select style="width: 60px;">
									<c:forEach begin="0" end="24" varStatus="stat">
										<option  value='<c:if test="${stat.index < 10}">0</c:if>${stat.index}' <c:if test="${sch.sch_h_time eq stat.index}">selected="selected"</c:if> > <c:if test="${stat.index < 10}">0</c:if>${stat.index}</option>
									</c:forEach>
								</select>
								시
								<select style="width: 60px;">
									<c:forEach begin="0" end="59" varStatus="stat">
											<option  value='<c:if test="${stat.index < 10}">0</c:if>${stat.index}' <c:if test="${sch.sch_m_time eq stat.index}">selected="selected"</c:if>><c:if test="${stat.index < 10}">0</c:if>${stat.index}</option>
									</c:forEach>
								</select>
								분
							</td>
							<td style="text-align: center;">
								<input type="button" onclick="fn_save(this);" name="save_btn"  value="저장"  />
							</td>
						</tr>
					</c:forEach>
				</tbody> 
			</table>
			<br />
			<span>※ 해당일 스케줄 작업이 실행된 경우 익일부터 반영이 됩니다.</span><br />
			<span>※ 채용공고 이메일/SMS 스케줄의 경우 시간이 00:00  부터 12:00 전으로 설정되면 전날의 공고정보를 전달합니다.</span>
			</div>
			</form>
		</div>
							
	
	</div>
	<div class="clear"></div>
	
</div>
</body>
</html>
