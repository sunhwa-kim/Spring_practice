<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
function updateHopeLib(offer)
{
	var keyword = new Array("로그인 후 신청하세요!","자료형태를 선택해 주세요.","서명을 입력하여 주십시요!","저자를 입력하여 주십시요!","발행처를 입력하여 주십시요!","ISBN을 10자리 이상 정확히 입력하여 주십시요!","처리중 입니다!");
	var IS_SUBMIT = false;
  
  if( !IS_SUBMIT )	{
	if($(':radio[name="jobGubun"]:checked').length < 1){
		alert(keyword[1]);
		$('#jobGubun1').focus();
		return false;
	}

	if(offer.title.value.length == 0) {
		alert(keyword[2]);
		offer.title.focus();
		return false;
	}
	
	if(offer.author.value.length == 0) {
		alert(keyword[3]);
		offer.author.focus();
		return false;
	}

	if(offer.publisher.value.length == 0) {
		alert(keyword[4]);
		offer.publisher.focus();
		return false;
	}
	
	if(offer.isbn.value.length > 0 &&  offer.isbn.value.length < 10) {
			alert(keyword[5]);
			offer.isbn.focus();
			return false;
	}
	
	if( !IS_SUBMIT ){
   	    $.ajax({
 		    url: '${ctxt}/mylib/hopeLib/updatehopeLib.do',
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
	

  }	else {
	  alert(keyword[6]);

  }	
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
			<span class="active">희망도서 상세정보</span>        
		</div>
		<span class="center_text_01">희망도서 상세정보</span>
	</div> 
	<div class="under_bar"></div>
	
<div class="content_wrap">
	<div class="content_box">
			<div class="content_list table">
				<table class="view_table" style="border-top:1px solid #CCDDED;">
				<caption>
					희망도서 - 도서구분,서명,저자,출판사,수량,출판연도,ISBN,비고
				</caption>
				<colgroup>
					<col width="15%">
					<col width="35%">
					<col width="15%">
					<col width="30%">
				</colgroup>
				<tbody class="report">
						<tr>
						  	<th>지료형태<font style="color:red">*</font></th>
						    <td class="padding_l"  colspan="3">
						    	<input type="radio" class="radio" value="m" name="jobGubun" <c:if test="${result.jobGubun eq 'm'}"> checked="checked" </c:if>>
						    	<label for="jobGubun1">단행본</label>
						    	<input type="radio"  class="radio" value="k" name="jobGubun" <c:if test="${result.jobGubun eq 'k'}"> checked="checked" </c:if>>
						    	<label for="jobGubun2"> 비도서</label>
						    	<input type="radio" class="radio" value="e" name="jobGubun" <c:if test="${result.jobGubun eq 'e'}"> checked="checked" </c:if>>
						  		<label for="jobGubun3">E-Book</label>
						  	</td>
						</tr>		  
						<tr>
						  	<th><label for="hopeTitle">서명</label><font style="color:red">*</font></th>
						    <td class="padding_l" colspan="3"><input type="text" name="title" id="hopeTitle" style="" value="${result.title}"></td>
						</tr>
					  
						<tr>
						  	<th><label for="hopeauthor">저자</label><font style="color:red">*</font></th>
						    <td class="padding_l"  colspan="3"><input type="text" name="author" id="hopeauthor" style="" value="${result.author}"></td>
						</tr>
					  
						<tr>
						  	<th scope="row" ><label for="hopepublisher">발행처</label><font style="color:red">*</font></th>
						    <td class="padding_l" colspan="3"><input type="text" name="publisher" id="hopepublisher" value="${result.publisher}" /></td>
						</tr>
						<tr>
							<th><label for="hopepublisherYear">발행년도</label></th>
							<td><input type="text" id="hopepublisherYear" value="${result.publisherYear}"  name="publisherYear"  maxlength="4" title="발행년도" alt="발행년도" <c:if test="${empty userVo}">readonly </c:if>/></td>
							<th><label for="bookCnt">희망권수</label></th>
							<td>
								<select id="bookCnt" name="bookCnt" style="width:100px; height:29px;">
								<option value="1" selected="selected">선택</option>
								<option value="1" <c:if test="${result.bookCnt == 1}">selected="selected"</c:if> >1</option>
								<option value="2" <c:if test="${result.bookCnt == 2}">selected="selected"</c:if> >2</option>
								<option value="3" <c:if test="${result.bookCnt == 3}">selected="selected"</c:if> >3</option>
								</select>
							</td>
						</tr>
						<tr>
					    <th><label for="hopeISBN">ISBN</label></th>
					    <td class="padding_l" colspan="3" style="padding-bottom:20px; position:relative;"><input type="text" name="isbn" id="hopeISBN" value="${result.isbn}">
					  		<br>
					  		<span style="position:absolute; bottom:-3px;">*하이픈(-)은 빼고 입력하십시오.</span>
					 	 </td>
					  </tr>
						
					  <%-- <tr> 
					    <th scope="row" ><label for="bookCnt">희망권수</label></th>
					    	<td>
						    	<select id="bookCnt" name="bookCnt" style="width:100px; height:29px;">
								    <option value="1" selected="selected">선택</option>
								    <option value="1" <c:if test="${result.bookCnt == 1}">selected="selected"</c:if> >1</option>
								    <option value="2" <c:if test="${result.bookCnt == 2}">selected="selected"</c:if> >2</option>
								    <option value="3" <c:if test="${result.bookCnt == 3}">selected="selected"</c:if> >3</option>
							   	</select>
					    	</td>
					    <td width="30%"><input type="text" name="bookCnt" id="bookCnt" value="${result.bookCnt}"/></td>
					  </tr> 
					  <tr>
					  	<th scope="row"><label for="hopepublisherYear">발행년도</label></th>
					    <td width="30%" ><input type="text" name="publisherYear" id="hopepublisherYear" value="${result.publisherYear}"></td>
					    <th scope="row" ><label for="hopeISBN">ISBN</label></th>
					    <td width="30%" ><input type="text" name="isbn" id="hopeISBN" value="${result.isbn}"></td>
					  </tr>--%>
					  
					  <tr>
					  	<th><label for="etccont">비고</label></th>
					    <td colspan="3" class="padding_l" ><input type="text" name="remark" id="etccont" value="${result.remark}" ></td>
					  </tr>  
					  		  
				  </tbody>
				</table>

				         
		          <div class="btn-group">
				    <a href="javascript:updateHopeLib(reqForm)" class="basic-btn">저장</a>
				    <a href="javascript:fn_returnListUrl()" class="basic-btn">목록으로</a>
				 </div>  
</div>
</div>
</div>	
	
	<!-- 검색 PARAM -->
	<input type="hidden" id="page" name="page" value="${result.page}" alt="pageNum" />
	<input type="hidden" id="searchCondition" name="searchCondition" value="${result.searchCondition}"  alt="검색콤보" />
	<input type="hidden" id="searchKeyword" name="searchKeyword" value="${result.searchKeyword}" alt="검색어" />
	
	<!-- 목록 화면 주소  -->
	<input type="hidden" id="returnListPage" name="returnListPage" value="${ctxt}/mylib/hopeLib/hopeLibList.do"  alt= "returnPage" />

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" name="hopeno" value="${param.hopeno}"/>
	
	
</form>