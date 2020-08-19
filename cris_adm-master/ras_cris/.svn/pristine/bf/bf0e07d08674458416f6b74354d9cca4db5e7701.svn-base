<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
function checkInput(offer){	
	
	if ("${userVo.emplyrnm}" == "") {
    if (confirm('로그인 후 이용 가능한 서비스 입니다.\n로그인 하시겠습니까?')) 
	    location.href="${ctxt}/login/user/login.do?returnURL=/centerintro/hope/hopeReg.do";
	
	    return;
}
	var keyword = new Array("로그인 후 신청하세요!","자료형태를 선택해 주세요.","서명을 입력하여 주십시요!","저자를 입력하여 주십시요!","발행처를 입력하여 주십시요!","ISBN을 10자리 이상 정확히 입력하여 주십시요!","처리중 입니다!");
	var IS_SUBMIT = false;
  
  if( !IS_SUBMIT )	{
	if($(':radio[name="jobGubun"]:checked').length < 1){
		alert(keyword[1]);
		$('#jobGubun1').focus();
		return;
	}

	if(offer.title.value.length == 0) {
		alert(keyword[2]);
		offer.title.focus();
		return;
	}
	
	if(offer.author.value.length == 0) {
		alert(keyword[3]);
		offer.author.focus();
		return;
	}

	if(offer.publisher.value.length == 0) {
		alert(keyword[4]);
		offer.publisher.focus();
		return;
	}
	
	if(offer.isbn.value.length > 0 &&  offer.isbn.value.length < 10) {
			alert(keyword[5]);
			offer.isbn.focus();
			return;
	}
	
	if( !IS_SUBMIT ){
   	    $.ajax({
 		    url: '${ctxt}/srv/hope/insertHope.do',
 		    data: $("form[name=reqForm]").serialize(),  
 		    type: 'POST',
 		    dataType: 'text',
 		    cache: false,
 		    success: function(result) {
 				  if(result == "Y"){// 성공  					
 					 alert("신청이 완료 되었습니다. 신청내역은 My Library>희망도서 신청 조회에서 확인 할 수 있습니다.");
 					location.href = "${ctxt}/mylib/hopeLib/hopeLibList.do"
 				  }else if(result == "F"){ 					  
 					  alert("희망도서 신청에 실패하였습니다."); 					  
 				  }
 		   },
 		   error : function(){ // Ajax 전송 에러 발생시 실행
 		     fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
 		   }
 		});
	

  }	else {
	  alert(keyword[6]);

  }	
  }
}

$(function(){
	$("input[name=publisherYear]").on("blur", function(){
		var num = $(this).val();
		if(/[^0123456789]/g.test(num)) {
			$(this).val("");
			$(this).focus();
		  }
	});	
});

$(function(){
	//tab		
	$("ul.tabs li").eq(0).addClass("active").css("color", "#003964");
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
	      <span class="active">도서신청</span>        
    	</div>
		<span class="center_text_01">도서신청</span>
	</div>
	<div class="under_bar"></div> 	
	<!-- 	<a href="/srv/hope/viewinsertHope.do">신청</a> -->
	<!-- 	<a href="/srv/hope/listHope.do">신청처리결과</a> -->
	
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div class="tabContainer"> 		
					<ul class="tabs">
						<li rel="tab1" style="box-sizing:border-box;" onclick="" class="active">도서신청</li>
						<li rel="tab2" style="box-sizing:border-box;" onclick="">원문복사</li>
						<li rel="tab3" style="box-sizing:border-box;" onclick="">모바일서비스</li>					    
					</ul>
					<div class="tab_container" style="width:100%; box-sizing:border-box;"></div>
				</div>
				<div class="list_title"><p>신청안내</p></div>
				<ul class="list_full">	
					<li class="dashed">국립의과학지식센터에서 소장하고 있지 않은 자료에 대해 비치를 희망하는 경우, 아래 신청양식에 따라 정확히 기재하여 신청해주시기바랍니다.
						<ul class="list_full">
							<li class="dashed">참고사이트 : 
							<a href="//www.kyobobook.co.kr" target="_blank" rel="noopener noreferrer" title="교보문고 - 새창">교보문고</a>,
							<a href="//www.aladin.co.kr" target="_blank" rel="noopener noreferrer" title="알라딘 - 새창">알라딘</a>,
							<a href="//www.amazon.com" target="_blank" rel="noopener noreferrer" title="아마존 - 새창">amazon</a>,
							<a href="//www.barnesandnoble.com" target="_blank" rel="noopener noreferrer" title="반스앤노블 - 새창">barnes & noble</a>
							</li>						
						</ul>
					</li>		
					<li class="dashed">일반 이용자는 자료 열람만 가능합니다.</li>	
				</ul>
				<div class="list_title"><p>신청 제한자료</p></div>
				<ul class="list_full limit">	
					<li class="dashed">의과학 관련 분야가 아닌 자료</li>		
					<li class="dashed">50페이지 미만 도서</li>	
					<li class="dashed">낱장제본도서(형태부적합도서/낱말카드 및 교구자료 등 포함)</li>	
					<li class="dashed">무협, 판타지, 애정ㆍ로맨스 등 장르 소설</li>
					<li class="dashed">초/중/고등학교 학습 참고자료</li>
					<li class="dashed">각종 문제집, 강의자료 및 수험서</li>
					<li class="dashed">품절 및 절판된 도서</li>
					<li class="dashed">각종 오락용 출판물(게임안내, 만화, 퍼즐 등)</li>
					<li class="dashed">고가의 자료(전집류 등)</li>
					<li class="dashed">국립의과학지식센터 자료 선정기준에 적합하지 않은 자료</li>
				</ul>
		
				<div class="content_list table">
					<span class="essential"><font style="color: red">*</font>필수 입력사항</span>		
					<table class="view_table" style="border-top: 1px solid #CCDDED;">
						<caption>희망도서 양식</caption>
						<colgroup>
							<col style="width:15%;">
							<col style="width:35%;">
							<col style="width:15%;">
							<col style="width:30%;">						
						</colgroup>
						<tbody class="report">
							<tr>
					        	 <th>자료형태<font style="color:red">*</font></th>
						         <td class="padding_l" colspan="3">
						           	<input type="radio" class="radio" id="jobGubun1" name="jobGubun" value="m" <c:if test="${resultInfo.jobgubun == 'm'}">checked="checked"</c:if> />
						        	<label for="jobGubun1">단행본</label>
						           	<input type="radio" class="radio" id="jobGubun2" name="jobGubun" value="k" <c:if test="${resultInfo.jobgubun == 'k'}">checked="checked"</c:if> />
						            <label for="jobGubun2"> 비도서</label>
						           	<input type="radio" class="radio" id="jobGubun3" name="jobGubun" value="e" <c:if test="${resultInfo.jobgubun == 'e'}">checked="checked"</c:if> />
						         	<label for="jobGubun3">E-Book</label>
						         </td>
					       	</tr>
					       	<tr>
					        	<th><label for="hopeTitle">서명</label><font style="color:red">*</font></th>
					         	<td class="padding_l" colspan="3">
					         		<input type="text" class="hopeTitle" id="hopeTitle" name="title" value="" style="width:100%" maxlength="100" title="서명" alt="서명" <c:if test="${empty userVo}">readonly placeholder="로그인 후 입력해주세요"</c:if>/>
					         	</td>
					        </tr>
						    <tr>
						         <th><label for="hopeauthor">저자</label><font style="color:red">*</font></th>
						         <td class="padding_l" colspan="3"><input type="text" id="hopeauthor" value="" name="author"  style="width:100%" maxlength="100" title="저자" alt="저자" <c:if test="${empty userVo}">readonly </c:if>/></td>
						    </tr>
						    <tr>
						         <th><label for="hopepublisher">발행처</label><font style="color:red">*</font></th>
						         <td class="padding_l" colspan="3"><input type="text" id="hopepublisher" value=""  name="publisher" maxlength="17" title="발행처" style="width:100%;" alt="출판사" <c:if test="${empty userVo}">readonly </c:if>/></td>
						    </tr>
						    <tr>
								<th><label for="hopepublisherYear">발행년도</label></th>
								<td><input type="text" id="hopepublisherYear" value=""  name="publisherYear"  style="width:100%"  maxlength="4" title="발행년도" alt="발행년도" <c:if test="${empty userVo}">readonly </c:if>/></td>
								<th><label for="bookCnt">희망권수</label></th>
								<td>
								   	<select id="bookCnt" name="bookCnt" style="width:100px; height:29px;">
								    <option value="" selected="selected">선택</option>
								    <option value="1">1</option>
								    <option value="2">2</option>
								    <option value="3">3</option>
								   	</select>
								</td>
						    </tr>
							<%-- <tr>
						         <th><label for="hopepublisherYear">발행년도</label></th>
						         <td><input type="text" id="hopepublisherYear" value=""  name="publisherYear"  style="width:10%"  maxlength="4" title="발행년도" alt="발행년도" <c:if test="${empty userVo}">readonly </c:if>/></td>
						    </tr>
						    <tr>
						         <th><label for="bookCnt">희망권수</label></th>
						         <td>
						           	<select id="bookCnt" name="bookCnt" >
							           <option value="" selected="selected">선택</option>
							           <option value="1">1</option>
							           <option value="2">2</option>
							           <option value="3">3</option>
							           <option value="4">4</option>
							           <option value="5">5</option>
							           <option value="6">6</option>
							           <option value="7">7</option>
							           <option value="8">8</option>
							           <option value="9">9</option>
							           <option value="10">10</option>
						           	</select>
					       		</td>
							</tr> --%>
						    <tr>
						        <th><label for="hopeISBN">ISBN</label></th>
						        <td class="padding_l" colspan="3" style="padding-bottom:20px; position:relative;"><input type="text" value="" name="isbn" id="hopeISBN" onkeydown="return onlyNumber(event)" style="width:100%"  maxlength="17" title="ISBN" alt="ISBN" <c:if test="${empty userVo}">readonly </c:if>/> <br>
						        <span style="position:absolute; bottom:-3px;">*하이픈(-)은 빼고 입력하십시오.</span></td>
						    </tr>
						    <tr>
						        <th><label for="etccont">비고</label></th>
						        <td colspan="3" class="padding_l"><input type="text" value="" name="remark" id="etccont" style="width:100%" maxlength="100" title="비고" alt="비고" <c:if test="${empty userVo}">readonly </c:if>/></td>
						    </tr>
						</tbody>
			        </table>          
				</div>
				<div class="btn-group">
					<a href="javascript:checkInput(reqForm)" class="basic-btn">신청</a>
				</div> 
				<p class="application">이용신청 문의 043)249-3024, 3026 ncmik@korea.kr</p>
			</div>
		</div>
	</div>
	
	<!-- 추가 PARAM -->
	<input type="hidden" name="edc_progrm_id" id="edc_progrm_id" value="${eduVo.edc_progrm_id}" alt="data_center_id" />
 	<!-- 공통  필수 PARAM -->
 	<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/> --%>
	
	
	
</form>