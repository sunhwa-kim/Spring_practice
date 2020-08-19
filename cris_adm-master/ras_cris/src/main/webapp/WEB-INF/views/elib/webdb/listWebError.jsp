<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<c:set var="registerFlag" value="${empty ptlErrorVO.reqstId ? '등록' : '수정'}"/>	
  
<script type="text/javascript">
//<![CDATA[
           
$(document).ready(function() {
	$(".placeholder").on("focus" , function(){
		var valId = $(this).attr("id");
		var chehckVal = cmmCheck.trim($("#"+ valId).val());
		$("label[for =" + valId + "] > span").addClass("screen_out");
	});
	
	$(".placeholder").on("blur" , function(){
		var valId = $(this).attr("id");
		var chehckVal = cmmCheck.trim($("#"+ valId).val());
		
		if(!cmmCheck.isValue(chehckVal)){
			$("label[for =" + valId + "] > span").removeClass("screen_out");
		}
	});
});
           
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("detailForm").action = "<c:url value='/elib/error/ptlErrorList.do'/>";
   	document.getElementById("detailForm").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("detailForm").action = "<c:url value='/elib/error/deletePtlError.do'/>";
   	document.getElementById("detailForm").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	

	<c:choose>	
	 <c:when test="${loginVO.loginid ne null}"> 
		//유효성검사 true시 진행
		var checkVali = nullCheck();
	 	if(checkVali){
	 		frm = document.getElementById("detailForm");

	 		var resisterFlag = '${registerFlag}';
	 		var actionUrl = "";

	 	 	var checkVali = nullCheck();
		 	if(resisterFlag == "등록"){
		 		actionUrl = "<c:url value='/elib/error/addPtlError.do'/>";
		 		alert("등록이 완료되었습니다.");
			}else if(resisterFlag == "수정"){
				actionUrl = "<c:url value='/elib/error/updatePtlError.do'/>";
			}else{
				alert("등록 중 오류가 발생했습니다. 다시 등록해 주세요.");
			}
		 	
		  	frm.action = "<c:url value='" + actionUrl + "'/>"; 	
		    frm.submit();
	 	}
	 </c:when>
		<c:otherwise>
		    if (confirm('로그인 후 이용 가능한 서비스 입니다.\n로그인 하시겠습니까?')) 
		    location.href="${ctxt}/cmm/login/PTLLogin.do?reqURI=${ctxt}/elib/error";
		</c:otherwise>
	 </c:choose>	
}

/* input 데이터 reset */
function fn_egov_reset(){
	document.getElementById("detailForm").reset();
}

//유효성검사
function nullCheck(){
	var reqstTitle = cmmCheck.trim($("#reqstTitle").val());
	var reqstUrl = cmmCheck.trim($("#reqstUrl").val());
	var reqstCn = cmmCheck.trim($("#reqstCn").val());

	if(!cmmCheck.isValue(reqstTitle)){
		alert("제목을 입력해 주세요");
		$("#reqstTitle").val("");
		$("#reqstTitle").focus();		
		return false;
	}else{
		$("#reqstTitle").val(reqstTitle);
	}

	if(!cmmCheck.isValue(reqstUrl)){
		alert("URL을 입력해 주세요");
		$("#reqstUrl").val("");
		$("#reqstUrl").focus();		
		return false;
		
	}else{
		$("#reqstUrl").val(reqstUrl);
	}

	if(!cmmCheck.isValue(reqstCn)){
		alert("내용을 입력해 주세요");
		$("#reqstCn").val("");
		$("#reqstCn").focus();
		return false;
	}else{
		$("#reqstCn").val(reqstCn);
	}
	
	return true;
};



//]]>
</script>

<div id="wrap">
		<div  id="containerS">
			<h1 class="blind">서브콘텐츠</h1>
			<div class="incont">
			   <%-- 	서브메뉴  --%>	 
<%-- 			    <c:import url="/jsp/ncmik/include/leftmenu_elib.jsp" /> --%>

				<div id="incont_Area" style="width:95%;">
				      <%-- 	검색창  --%>	
                      <c:import url="/jsp/ncmik/include/schBox.jsp" />
					

					<section>
						<div class="hgroupW">
							<h2>전자정보오류신고</h2>
							<div class="conInfo">
								<ul class="location">
									<li><a href="${ctx}">home</a></li>
									<li>전자자원</li>
									<li>전자정보오류신고</li>
								</ul>
								
								<div>
								  <c:import url="/jsp/ncmik/include/topIcon.jsp" /> 
								</div>
								
							</div>
						</div>
						<!-- hgroupW e -->
					</section>

					<ul class="mlocation">
						<li><a href="${ctx}">home</a></li>
						<li>전자자원</li>
						<li>전자정보오류신고</li>
					</ul>	
					<!-- mlocation e -->
						<div class="inSection" id="mainSection">  <!-- 내용 -->
                           <br/>
  					<div class="error_insert">
						<form:form commandName="ptlErrorVO" name="detailForm" id="detailForm">
							<div id="content_pop">
								<!-- 타이틀 -->
								<div id="table" class="cms_tab1">
					       	        <c:choose>
			                            <c:when test="${loginVO.loginid eq null}">
				                            <div class="error_conArea"><span class="fontColorRed"> 로그인 후 신청 가능합니다.</span></div>
										</c:when>
										<c:otherwise>
											<table width="100%" border="1" cellpadding="0" cellspacing="0" class="reqinfo-ta error_insert_tb" summary="제목 URL 내용을 작성합니다.">
												<caption>전자정보오류신고</caption>
												<colgroup>
													<col width="10%" />
													<col width="*" />
												</colgroup>
												<tr>	
													<th><label for="reqstTitle">제목
														<span class="reqstTitle">예) 링크가 올바르지 않습니다.</span></label>
													</th>
													<td><form:input path="reqstTitle" cssClass="txt borer_none placeholder" /> &nbsp;<form:errors path="reqstTitle" /></td>										
												</tr>
												<c:if test="${ptlElibWebDBVO.elibId eq null}">
													<tr>
														<th><label for="reqstUrl">URL
															<span class="reqstUrl">예) http://link.springer.com/book/</span></label>
														</th>
														<td><form:input path="reqstUrl" cssClass="txt borer_none placeholder" /> &nbsp;<form:errors path="reqstUrl" /></td>
													</tr>
												</c:if>
												<c:if test="${ptlElibWebDBVO.elibId ne null}">
													<tr>
														<th><label for="reqstUrl">URL</label>
														</th>
														<td><form:input path="reqstUrl" cssClass="txt borer_none placeholder" value="${ptlElibWebDBVO.elibLink}" /> &nbsp;<form:errors path="reqstUrl" /></td>
													</tr>
												</c:if>
												
												<tr>
													<th><label for="reqstCn">내용
														<span class="reqstCn">예) Asian Immigrants in North America with HIV/AIDS 링크 연결이 안됩니다.</span></label>
													</th>
													<td><form:textarea path="reqstCn" cssClass="txt borer_none placeholder" /> &nbsp;<form:errors path="reqstCn" /></td>
												</tr>
											</table>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="error_insert_btn btn_tb_bottom">
									<ul>
										<li><span class="btn_blue_l"><a href="javascript:fn_egov_save();"><c:out value='${registerFlag}' /></a></span></li>
									</ul>
								</div>
							</div>
							<!-- 검색조건 유지 -->
							<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>" />
							<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" />
							<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
						</form:form>
					</div>



						</div>
						<!-- inSection e -->
			</div>
			<!-- incont_Area e -->
		</div>
		<!-- incont e -->
	</div>
	<!-- container e -->
</div>
