<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	$(document).ready(function (){
		// 희망도서 신청처리결과 클릭시 리스트 조회	
		$(".org_tab_menu_area li").on("click", function(){
			$except = $(this);
			var indexCheck = $(".org_tab_menu_area li").index(this);
			
			// 탭메뉴 콘텐츠 off
			$(".org_tab_menu_area li").not($except).removeClass("on");
			$(".orgConArea > div").removeClass("on");
			
			// 탭메뉴 콘텐츠 on
			$(this).addClass("on");
			$(".orgConArea > div:eq(" + indexCheck + ")").addClass("on");
			
		});

		
	}); 
 

	/* 필수항목체크 */	
	var IS_SUBMIT = false;
	function checkInput() {
		
		if ("${userVo.emplyrnm}" == "") {
		    if (confirm('로그인 후 이용 가능한 서비스 입니다.\n로그인 하시겠습니까?')) 
			    location.href="${ctxt}/login/user/login.do?returnURL=/centerintro/orgCopy/listOrgCopy.do";
			
			    return;
		}
		
		var artTitle = cmmCheck.trim($("#artTitle").val());
		var author = cmmCheck.trim($("#author").val());
		var startPage = cmmCheck.trim($("#startPage").val());
		var lastPage = cmmCheck.trim($("#lastPage").val());
		var title = cmmCheck.trim($("#title").val());
		var pubYear = cmmCheck.trim($("#pubYear").val());
		var volumeName = cmmCheck.trim($("#volumeName").val());
	
		if(!cmmCheck.isValue(artTitle)){
			alert("논문명은 필수입력 항목입니다.");
			$("#artTitle").val("");
			$("#artTitle").focus();		
			return;
		}else{
			$("#artTitle").val(artTitle);
		}

		if(!cmmCheck.isValue(startPage)){
			alert("시작 페이지를 입력하여 주십시요!");
			$("#startPage").val("");
			$("#startPage").focus();		
			return;
		}else{
			$("#startPage").val(startPage);
		}

		if(!cmmCheck.isValue(lastPage)){
			alert("마지막 페이지를 입력하여 주십시요!");
			$("#lastPage").val("");
			$("#lastPage").focus();		
			return;
		}else{
			$("#lastPage").val(lastPage);
		}

		
		if(!cmmCheck.isValue(title)){
			alert("학술지명을 입력하여 주십시요!");
			$("#title").val("");
			$("#title").focus();		
			return;
		}else{
			$("#title").val(title);
		}
		

		if(!cmmCheck.isValue(pubYear)){
			alert("연도를 입력하여 주십시요!");
			$("#pubYear").val("");
			$("#pubYear").focus();		
			return;
		}else{
			$("#pubYear").val(pubYear);
		}

		if(!cmmCheck.isValue(volumeName)){
			alert("Vol(No)를 입력하여 주십시요!");
			$("#volumeName").val("");
			$("#volumeName").focus();		
			return;
		}else{
			$("#volumeName").val(volumeName);
		}	
		

		if (!IS_SUBMIT) {
			IS_SUBMIT = true;
			  $.ajax({
		 		    url: '${ctxt}/srv/orgCopy/saveOrgCopy.do',
		 		    data: $("form[name=reqForm]").serialize(),  
		 		    type: 'POST',
		 		    dataType: 'text',
		 		    cache: false,
		 		    success: function(result) {
		 				  if(result == "Y"){// 성공  					
		 					  alert("신청이 완료 되었습니다. 신청내역은 My Library>원문복사 신청 조회에서 확인 할 수 있습니다.");
		 					  location.href = "${ctxt}/mylib/applyView/applyOrgList.do";
		 					
		 				  }else if(result =="F"){ 					  
		 					  alert("원문복사 신청에 실패하였습니다.");
		 				  }
		 				  
		 		   },
		 		   error : function(){ // Ajax 전송 에러 발생시 실행
		 		     fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
		 		   }
		 	});

		} else {
			alert("처리중 입니다!");

		}
	}


$(function(){
		$("input[name=startPage],input[name=lastPage],input[name=pubYear]").on("blur", function(){
			var num = $(this).val();
			if(/[^0123456789]/g.test(num)) {
				$(this).val("");
				$(this).focus();
			  }
		});	
	});
$(function(){
	//tab		
	$("ul.tabs li").eq(1).addClass("active").css("color", "#003964");
    $("ul.tabs li").eq(0).click(function(){
    	location.href="${ctxt}/centerintro/hope/hopeReg.do";
    })
    $("ul.tabs li").eq(1).click(function(){
    	location.href="${ctxt}/centerintro/orgCopy/listOrgCopy.do";
    })
    $("ul.tabs li").eq(2).click(function(){
    	location.href="${ctxt}/centerintro/mobile/mobileService.do";
    })
});	

</script>	
<style>
 	.tabContainer{
		display:none;
	}
	
	ul.tabs li{
		width:auto; 
		padding:0 15px;
	}
	@media all and (max-width:990px) {
		.tabContainer{
			display:block;
			margin-bottom:10px;
		}
	}
	@media all and (max-width:444px) {
		.tabContainer>.tabs>li{
			width:33.333333333333333333333333333333%;
			padding:0;
			font-size:12px;
		}
	}
</style>
<form name="reqForm" method="post">
		
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>서비스</span>
			<span> > </span>
			<span class="active">원문복사서비스</span>        
		</div>
		<span class="center_text_01">원문복사서비스</span>
	</div> 
    <div class="under_bar"></div>
		
		<div class="content_wrap">
			<div class="content_box">
				<div class="content_list">	
				<div class="tabContainer"> 		
					<ul class="tabs">
						<li rel="tab1" style="box-sizing:border-box;" onclick="">도서신청</li>
						<li rel="tab2" style="box-sizing:border-box;" onclick="" class="active" >원문복사</li>
						<li rel="tab3" style="box-sizing:border-box;" onclick="">모바일서비스</li>					    
					</ul>
					<div class="tab_container" style="width:100%; box-sizing:border-box;"></div>
				</div>
					<!-- <div class="list_title"><p>신청안내</p></div> -->
					<ul class="list_full">
						<li>
							<ul>	
								<li>원문복사서비스(Document Delivery Services)는 <br>국립의과학지식센터에 소장되지 않은 자료를 다른 협력기관에 복사 의뢰하여 자료를 제공받는 서비스입니다.</li>			
							</ul>
						</li>
					</ul>
					<div class="list_title"><p>대상</p></div>
					<ul class="list_full limit">	
						<li>질병관리본부 직원</li>		
						<li>기타 의과학지식관리과장이 필요하다고 인정하는 경우</li>	
					</ul>
					<div class="list_title"><p>신청방법</p></div>
					<ul class="list_full limit">	
						<li>국립의과학지식센터 홈페이지 로그인 후 원문복사서비스 메뉴에서 신청</li>		
						<li>국립의과학지식센터 2층 종합자료실에 방문하여 신청</li>	
					</ul>
					<div class="list_title"><p>유의사항</p></div>
					<ul class="list_full limit">	
						<li>자료 신청 전에 도서관 홈페이지에서 검색 후, 반드시 비소장 자료만 신청하여 주시기 바랍니다.</li>		
						<li>배송방법 중 전자전송은 저작권법 위반으로 불가합니다.</li>	
						<li>자료는 국립의과학지식센터 종합자료실로 입수되며 자료 도착 시 방문 수령하시기 바랍니다.</li>
						<li>신청하신 내용의 처리결과는 “My Library”에서 확인하실 수 있습니다.</li>
						<li>입력하신 정보가 부정확할 경우 신청이 취소됩니다.</li>
					</ul>
				
					<div class="content_list table">	
						<div id="divRefreshArea">
							<span class="essential"><font style="color: red">*</font>필수 입력사항</span>		
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
											<label for="artTitle" class="necessary">논문명</label><font style="color: red">*</font>
										</th>
										<td colspan="3" class="padding_l">
											<input id="artTitle" name="artTitle" title="논문명" type="text"  value="<c:out value='${docCpyManageVo.artTitle}'/>" maxlength="400" <c:if test="${empty userVo}">readonly placeholder="로그인 후 입력해주세요" </c:if> />
										</td>
									</tr>
									<tr>
										<th colspan="1" scope="row">
											<label for="author" class="necessary">저자</label>
										</th>
										<td colspan="3" class="padding_l">
											<input id="author" name="author" title="저자" type="text" value="<c:out value='${docCpyManageVo.author}'/>" maxlength="80" <c:if test="${empty userVo}">readonly</c:if> />
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="startPage" class="necessary">페이지</label><font style="color: red">*</font>
										</th>
										<td>
											<input id="startPage" name="startPage" title="첫페이지" style="width:111px;" type="text" value="<c:out value='${docCpyManageVo.startPage}'/>" size="5" maxlength="5"  <c:if test="${empty userVo}">readonly</c:if> />
											~ <input id="lastPage" name="lastPage" title="마지막페이지" style="width:111px;" type="text" value="<c:out value='${docCpyManageVo.lastPage}'/>" size="5" maxlength="5"  <c:if test="${empty userVo}">readonly</c:if> />
										</td>
										<th scope="row">
											<label for="issn">ISSN</label>
										</th>
										<td class="padding_l">
											<input id="issn" name="issn" title="ISSN" type="text" value="<c:out value='${docCpyManageVo.issn}'/>" maxlength="40" <c:if test="${empty userVo}">readonly</c:if> />
										</td>
									</tr>
									<tr>
										<th colspan="1" scope="row">
											<label for="title">학술지명</label><font style="color: red">*</font>
										</th>
										<td colspan="3"  class="padding_l">
											<input id="title" name="title" title="학술지명" type="text" value="<c:out value='${docCpyManageVo.title}'/>" maxlength="100" <c:if test="${empty userVo}">readonly</c:if> />
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="publisher" class="necessary">출판사</label>
										</th>
										<td>
											<input id="publisher" name="publisher" title="출판사" type="text" value="<c:out value='${docCpyManageVo.publisher}'/>" maxlength="25" <c:if test="${empty userVo}">readonly</c:if> />
										</td>
										<th scope="row">
											<label for="pubYear" class="necessary">연도</label><font style="color: red">*</font>
										</th>
										<td class="padding_l">
											<input id="pubYear" name="pubYear" title="연도" type="text" value="<c:out value='${docCpyManageVo.pubYear}'/>" maxlength="4"  <c:if test="${empty userVo}">readonly</c:if> />
										</td>
									</tr>
									<tr>
										<th colspan="1" scope="row">
											<label for="volumeName" class="necessary">Vol(No)</label><font style="color: red">*</font>
										</th>
										<td colspan="3" class="padding_l">
											<input id="volumeName" name="volumeName" title="권호명" type="text" value="<c:out value='${docCpyManageVo.volumeName}'/>" maxlength="80" <c:if test="${empty userVo}">readonly</c:if> />
										</td>
									</tr>
									<tr>
										<th colspan="1" scope="row">
											<label for="remark">비고</label>
										</th>
										<td colspan="3" class="padding_l">
											<input id="remark" name="remark" title="비고" type="text" value="<c:out value='${docCpyManageVo.remark}'/>" maxlength="200" <c:if test="${empty userVo}">readonly</c:if> />
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="btn-group">
						<a href="javascript:checkInput()" class="basic-btn">신청</a>
			     	</div>		
			     	<p class="application">문의 : 043)249-3036, ncmik@korea.kr</p>		
				</div>
			</div>
		</div>
		
                                    
     <!-- <p style="font-size:15px">원문복사서비스(Document Delivery Services)는 국립의과학지식센터에 소장되지 않은 자료를 다른 협력기관에 복사 의뢰하여 자료를 제공받는 서비스입니다.</p>
				
				<h3>대상</h3>
				<p> - 질병관리본부 직원</p>
				<p> - 기타 의과학지식관리과장이 필요하다고 인정하는 경우</p>
				
				<h3>신청방법</h3>
				<p> - 국립의과학지식센터 홈페이지 로그인 후 원문복사서비스 메뉴에서 신청</p>
				<p> - 국립의과학지식센터 2층 종합자료실에 방문하여 신청</p>
				
				<h3>유의사항</h3>
				<p> - 자료 신청 전에 도서관 홈페이지에서 검색 후, 반드시 비소장 자료만 신청하여 주시기 바랍니다.</p>
				<p> - 배송방법 중 전자전송은 저작권법 위반으로 불가합니다.</p>
				<p> - 자료는 국립의과학지식센터 종합자료실로 입수되며 자료 도착 시 방문 수령하시기 바랍니다.</p>
				<p> - 신청하신 내용의 처리결과는 “My Library”에서 확인하실 수 있습니다.</p>
				<p> - 입력하신 정보가 부정확할 경우 신청이 취소됩니다.</p> -->               
                    
    <!-- 첨부파일  -->
	<input type="hidden" name="posblAtchFileNumber" id="posblAtchFileNumber" value="3">
	
    <!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" />
	
</form>


