<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<script type="text/javascript">


$(function() {

	$("#dialog").dialog({ 
		//이벤트 발생했을때 보여주려면 autoOpen : false로 지정해줘야 한다.
		autoOpen: false, 
		//레이어팝업 넓이 
		width: 400, 
		height : 300,
		//뒷배경을 disable 시키고싶다면 true 
		modal: true, 
		//버튼종류
		buttons: [ { 
			//버튼텍스트 
			text: "실행",
			//클릭이벤트발생시 동작
			click: function() { 
				$("#cancelReason").val($("#cancelReasonText").val());
				var form=document.reqForm;
				form.action="${ctxt}/mylib/applyView/applyOrgDel.do";
				form.submit();
				$( this ).dialog( "close" );
				} 
		}, 
		{ 
			//버튼텍스트
			text: "닫기", 
			//클릭이벤트발생시 동작 
			click: function() {
				$( this ).dialog( "close" ); 
				} 
		} 
		]
	});

});

function updateOrgCopy(param){
	$('#prono').val(param);
	var form=document.reqForm;
	form.action="${ctxt}/mylib/applyView/applyOrgMod.do";
	form.submit();
}

function cancelOrgCopy(param){
	if(confirm("취소하시겠습니까?")){
		$('#prono').val(param);
		$("#dialog").dialog("open");
		
// 		var form=document.reqForm;
// 		form.action="${ctxt}/mylib/applyView/applyOrgDel.do";
// 		form.submit();
	}
}




</script>
<form name="reqForm" method="post">
	
<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>My Library</span>
			<span> > </span>
			<span class="active">원문복사 신청 조회</span>        
		</div>
		<span class="center_text_01">원문복사 신청 조회</span>
		</div> 
		<div class="under_bar"></div>

	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
			<div class="list_title"><p id="search_cn">원문제공 정보입력</p></div>
			<ul class="list_full limit">	
				<li>대상자료 : 일반도서 및 연속간행물자료	<br>
				<span style="font-size:12px; margin-left:25px;">※ 비도서자료 - 미디어자료, 신문 등 제외</span></li>	
				<li>신청책수 : 1인 3책 이하 (1일 1건 신청가능)<br>
				<span style="font-size:12px; margin-left:25px;">※ 접수완료 및 발송 : 평일(주말 및 휴관일 제외)</span></li>
			</ul>
			<!-- <ul>
				<li class="hyphen">① 대상자료 : 일반도서 및 연속간행물자료</li>
				<li class="hyphen">※ 비도서자료 - 미디어자료, 신문 등 제외</li>
				<li class="hyphen">② 신청책수 : 1인 3책 이하 (1일 1건 신청가능)</li>
				<li class="hyphen">※ 접수완료 및 발송 : 평일(주말 및 휴관일 제외)</li>
			</ul> -->
			
						
			<table class="view_table">
			    <caption>
					원문복사 - 논문명,저자,페이지,ISSN,학술지명,출판사,연도,Vol(No),비고
				</caption>
				<colgroup>
					<col width="20%">
					<col width="30%">
					<col width="10%">
					<col width="40%">
				</colgroup>
				<tbody class="report">
					<tr>
						<th colspan="1">
							<label for="artTitle">논문명</label><font style="color: red">*</font>
						</th>
						<td colspan="3">
							<c:out value='${resultVo.artTitle}'/>
						</td>
					</tr>
					<tr>
						<th colspan="1" scope="row">
							<label for="author">저자</label>
						</th>
						<td colspan="3" >
							<c:out value='${resultVo.author}'/>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="startPage">페이지</label><font style="color: red">*</font>
						</th>
						<td>
							<c:out value='${resultVo.startPage}'/> ~ <c:out value='${resultVo.lastPage}'/>
						</td>
						<th scope="row">
							<label for="issn">ISSN</label>
						</th>
						<td>
							<c:out value='${resultVo.issn}'/>
						</td>
					</tr>
					<tr>
						<th colspan="1">
							<label for="title">학술지명</label><font style="color: red">*</font>
						</th>
						<td colspan="3">
							<c:out value='${resultVo.title}'/>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="publisher">출판사</label>
						</th>
						<td>
							<c:out value='${resultVo.publisher}'/>
						</td>
						<th scope="row" >
							<label for="pubYear">연도</label><font style="color: red">*</font>
						</th>
						<td>
							<c:out value='${resultVo.pubYear}'/>
						</td>
					</tr>
					<tr>
						<th colspan="1" scope="row">
							<label for="volumeName">Vol(No)</label><font style="color: red">*</font>
						</th>
						<td colspan="3">
							<c:out value='${resultVo.volumeName}'/>
						</td>
					</tr>
					<tr>
						<th colspan="1" scope="row">
							<label for="remark">비고</label>
						</th>
						<td colspan="3">
							<c:out value='${resultVo.remark}'/>
						</td>
					</tr>
				</tbody>
			</table>
							
			<div class="btn-group">
				<c:if test="${resultVo.prostat == '1' && resultVo.supstat == '0'}">
						<a href="javascript:cancelOrgCopy('<c:out value="${resultVo.prono}"/>')" class="basic-btn">신청취소</a>
						<a href="javascript:updateOrgCopy('<c:out value="${resultVo.prono}" />')" class="basic-btn">수정</a>
				</c:if>
					<a href="javascript:fn_returnListUrl()" class="basic-btn">목록으로</a>
			</div>
		
		</div>
		</div></div>
	
	
	
	<div id = "dialog" title="원문제공취소사유"> <!-- dialog 생성 -->
			<textarea id="cancelReasonText" name="cancelReasonText" cols="38" rows="5" ></textarea>
	</div>
	
	
	
		
	
    <!-- 검색 PARAM -->
	<input type="hidden" id="page" name="page" value="${resultVo.page}" alt="pageNum" />
	<input type="hidden" id="searchCondition" name="searchCondition" value="${resultVo.searchCondition}"  alt="검색콤보" />
	<input type="hidden" id="searchKeyword" name="searchKeyword" value="${resultVo.searchKeyword}" alt="검색어" />
	
	<!-- 추가 PARAM -->
	<input type="hidden" id="prono" name="prono" value="" alt="원문복사id" />
	<input type="hidden" id="cancelReason" name="cancelReason" value="" alt="취소사유"/>
	
	<!-- 목록 화면 주소  -->
	<input type="hidden" id="returnListPage" name="returnListPage" value="${ctxt}/mylib/applyView/applyOrgList.do"  alt= "returnPage" />
	
	<!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" />
	
</form>
