<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	
	
	var IS_SUBMIT = false;
	function checkInput() {
		var offer = "#reqForm";

		if (!IS_SUBMIT) {
 			var artTitle = cmmCheck.trim($("#artTitle").val());
			var author = cmmCheck.trim($("#author").val());
			var startPage = cmmCheck.trim($("#startPage").val());
			var lastPage = cmmCheck.trim($("#lastPage").val());
			var publisher = cmmCheck.trim($("#publisher").val()); 
			var pubYear = cmmCheck.trim($("#pubYear").val());
			var volumeName = cmmCheck.trim($("#volumeName").val());
			
			if(offer != "reqForm"){
				if(!cmmCheck.isValue(artTitle)){
					alert("논문명은 필수입력 항목입니다.");
					$("#artTitle").val("");
					$("#artTitle").focus();		
					return false;
				}else{
					$("#artTitle").val(artTitle);
				}
			}else{
				if(!cmmCheck.isValue(artTitle)){
					alert("논문명은 필수입력 항목입니다.");
					$("#" + offer + " #artTitle").val("");
					$("#" + offer + " #artTitle").focus();		
					return false;
				}else{
					$("#" + offer + " #artTitle").val(artTitle);
				}
			}	

			if(!cmmCheck.isValue(startPage)){
				alert("시작 페이지를 입력하여 주십시요!");
				$("#startPage").val("");
				$("#startPage").focus();		
				return false;
			}else{
				$("#startPage").val(startPage);
			}

			if(!cmmCheck.isValue(lastPage)){
				alert("마지막 페이지를 입력하여 주십시요!");
				$("#lastPage").val("");
				$("#lastPage").focus();		
				return false;
			}else{
				$("#lastPage").val(lastPage);
			}

			if(offer == "reqForm"){
				var title = cmmCheck.trim($("#" + offer + " #title").val());
				if(!cmmCheck.isValue(title)){
					alert("학술지명을 입력하여 주십시요!");
					$("#title").val("");
					$("#title").focus();		
					return false;
				}else{
					$("#title").val(title);
				}
			}

			if(!cmmCheck.isValue(pubYear)){
				alert("연도를 입력하여 주십시요!");
				$("#pubYear").val("");
				$("#pubYear").focus();		
				return false;
			}else{
				$("#pubYear").val(pubYear);
			}

// 			if(offer != "reqForm"){
// 				if(!cmmCheck.isValue(volumeName)){
// 					alert("등록번호를 입력하여 주십시요!");
// 					$("#olumeName").val("");
// 					$("#volumeName").focus();		
// 					return false;
// 				}else{
// 					$("#volumeName").val(volumeName);
// 				}
// 			}else{
// 				if(!cmmCheck.isValue(volumeName)){
// 					alert("Vol(No)를 입력하여 주십시요!");
// 					$("#volumeName").val("");
// 					$("#volumeName").focus();		
// 					return false;
// 				}else{
// 					$("#volumeName").val(volumeName);
// 				}				
// 			}
			
			if(!cmmCheck.isValue(volumeName)){
				alert("Vol(No)를 입력하여 주십시요!");
				$("#volumeName").val("");
				$("#volumeName").focus();		
				return false;
			}else{
				$("#volumeName").val(volumeName);
			}
			
			if( !IS_SUBMIT ){
		   	    $.ajax({
		 		    url: '${ctxt}/mylib/applyView/updateOrgCopyInfo.do',
		 		    data: $("form[name=reqForm]").serialize(),  
		 		    type: 'POST',
		 		    dataType: 'text',
		 		    cache: false,
		 		    success: function(result) {
		 				  if(result == "Y"){// 성공  					
		 					  alert("수정 되었습니다.");
		 					  fn_returnListUrl();
		 				  }else if(result == "F"){ 					  
		 					  alert("수정에 실패하였습니다."); 					  
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
	

</script>	
 
<form name="reqForm" id="reqForm" method="post">

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
					<div class="list_title"><p>원문제공 정보입력</p></div>
						<ul class="list_full limit">	
							<li>대상자료 : 일반도서 및 연속간행물자료	<br>
							<span style="font-size:12px; margin-left:25px;">※ 비도서자료 - 미디어자료, 신문 등 제외</span></li>	
							<li>신청책수 : 1인 3책 이하 (1일 1건 신청가능)<br>
							<span style="font-size:12px; margin-left:25px;">※ 접수완료 및 발송 : 평일(주말 및 휴관일 제외)</span></li>
						</ul>
						<!-- <div class="list_title">
								<p id="search_cn">원문제공 정보입력</p>
						</div>
						<ul>
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
						<td colspan="3" class="padding_l">
							<input id="artTitle" name="artTitle" title="논문명" type="text" style="" value="<c:out value='${resultVo.artTitle}'/>" maxlength="400" <c:if test="${empty userVo}">readonly placeholder="로그인 후 입력해주세요" </c:if> />
						</td>
					</tr>
					<tr>
						<th colspan="1">
							<label for="author">저자</label>
						</th>
						<td colspan="3" class="padding_l">
							<input id="author" name="author" title="저자" type="text" style="" value="<c:out value='${resultVo.author}'/>" maxlength="80" <c:if test="${empty userVo}">readonly</c:if> />
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="startPage">페이지</label><font style="color: red">*</font>
						</th>
						<td>
							<input id="startPage" name="startPage" title="첫페이지" style="width:111px;" type="text" value="<c:out value='${resultVo.startPage}'/>" size="5" maxlength="5"  <c:if test="${empty userVo}">readonly</c:if>/>
					     	  ~ <input id="lastPage" name="lastPage" title="마지막페이지" style="width:111px;" type="text" value="<c:out value='${resultVo.lastPage}'/>" size="5" maxlength="5"  <c:if test="${empty userVo}">readonly</c:if>/>
						</td>
						<th scope="row">
							<label for="issn">ISSN</label>
						</th>
						<td class="padding_l">
							<input id="issn" name="issn" title="ISSN" type="text" value="<c:out value='${resultVo.issn}'/>" maxlength="40" <c:if test="${empty userVo}">readonly</c:if>/>
						</td>
					</tr>
					<tr>
						<th colspan="1" scope="row">
							<label for="title">학술지명</label><font style="color: red">*</font>
						</th>
						<td colspan="3"  class="padding_l">
							<input id="title" name="title" title="저널명" type="text" style="" value="<c:out value='${resultVo.title}'/>" maxlength="100" <c:if test="${empty userVo}">readonly</c:if>/>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="publisher">출판사</label>
						</th>
						<td>
							<input id="publisher" name="publisher" title="출판사" type="text" value="<c:out value='${resultVo.publisher}'/>" maxlength="25" <c:if test="${empty userVo}">readonly</c:if>/>
						</td>
						<th scope="row">
							<label for="pubYear" class="necessary">연도</label><font style="color: red">*</font>
						</th>
						<td class="padding_l">
							<input id="pubYear" name="pubYear" title="연도"  type="text" value="<c:out value='${resultVo.pubYear}'/>" maxlength="4" <c:if test="${empty userVo}">readonly</c:if> />
						</td>
					</tr>
					<tr>
						<th colspan="1" scope="row">
							<label for="volumeName">Vol(No)</label><font style="color: red">*</font>
						</th>
						<td colspan="3" class="padding_l">
							<input id="volumeName" name="volumeName" title="권호명" class="w90" type="text" value="<c:out value='${resultVo.volumeName}'/>" maxlength="80" <c:if test="${empty userVo}">readonly</c:if>/>
						</td>
					</tr>
					<tr>
						<th colspan="1" scope="row">
							<label for="remark">비고</label>
						</th>
						<td colspan="3" class="padding_l">
							<input id="remark" name="remark" title="비고"  type="text" value="<c:out value='${resultVo.remark}'/>" maxlength="200" <c:if test="${empty userVo}">readonly</c:if>/>
						</td>
					</tr>
				</tbody>
			</table>

							
			<div class="btn-group">
				<a href="javascript:checkInput()" class="basic-btn">저장</a>
				<a href="javascript:fn_returnListUrl()" class="basic-btn">목록으로</a>
			</div>  
		
		</div>			
    	</div>
    	</div>
    
    
    <!-- 검색 PARAM -->
	<input type="hidden" id="page" name="page" value="${resultVo.page}" alt="pageNum" />
	<input type="hidden" id="searchCondition" name="searchCondition" value="${resultVo.searchCondition}"  alt="검색콤보" />
	<input type="hidden" id="searchKeyword" name="searchKeyword" value="${resultVo.searchKeyword}" alt="검색어" />
	
	<!-- 추가 PARAM -->
	<input type="hidden" id="prono" name="prono" value="${resultVo.prono}" alt="원문복사id" />
	
	<!-- 목록 화면 주소  -->
	<input type="hidden" id="returnListPage" name="returnListPage" value="${ctxt}/mylib/applyView/applyOrgList.do"  alt= "returnPage" />
	
	<!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" />
	
</form>
