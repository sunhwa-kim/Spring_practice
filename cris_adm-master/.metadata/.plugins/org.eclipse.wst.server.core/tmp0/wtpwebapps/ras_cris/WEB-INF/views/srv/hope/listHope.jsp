<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
$(document).ready(function(){
		fn_search('1');
})
function fn_search(page){
	
	//현재 페이지 세팅
	cuurPage= page;
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/

	$('#page').val(cuurPage);
		
	$('#searchCondition').val($('#searchCondition option:selected').val());
		
	var params = {};
  		params.page=cuurPage;
		params.searchKeyword = $('#searchKeyword').val();
		params.searchCondition = $('#searchCondition option:selected').val();
		
    $.ajax({
        url: '${ctxt}/srv/hope/hopeRead.do',
        data: params,
        type: 'POST',
        dataType: 'text',
        cache: false,
        success: function(rtnXml) {
        	xmlList = $(rtnXml).find('item');

        	pageTotalCnt=0;
        	dataTotalCnt=0;
        	
        	html="";
			if(xmlList.length > 0){
				//총페이지수
				pageTotalCnt = Number($(rtnXml).find('totalPageCnt').text());
				dataTotalCnt = Number($(rtnXml).find('totalDataCnt').text());
				
				xmlList.each(function(cnt){
			
					var obj = $(this);
					var dataId = obj.find('data_center_id').text(); //데이터 id
					var hopeno = obj.find('hopeno').text(); // hopeno
					var jobgubun = obj.find('jobgubun').text(); //구분  m:단행본 k:비도서 e:E-Book
					var title = obj.find('title').text();//도서명
					var author = obj.find('author').text();//저자
					var publisher = obj.find('publisher').text();//출판사
					var hopedate = obj.find('hopedate').text();//희망신청일자
					var processstate = obj.find('processstate').text();//상태
					
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					html += '<tr>';
					html += ' <td style="text-align: center"> '+ hopeno +'</td>';
					if(jobgubun == 'm'){
						html += ' <td style="text-align: center"> '+ '단행본' +'</td>';
					}else if(jobgubun == 'k'){
						html += ' <td style="text-align: center"> '+ '비도서' +'</td>';
					}else if(jobgubun == 'e'){
						html += ' <td style="text-align: center"> '+ 'E-Book' +'</td>';
					}
					
					html += ' <td> '+ '<a href="${ctxt}/mylib/hopeLib/hopeLibDetail.do?hopeno='+ hopeno +'">' + title + '</a>' +'</td>';
					html += ' <td style="text-align: center"> '+ author +'</td>';
					html += ' <td style="text-align: center"> '+ publisher +'</td>';
					html += ' <td style="text-align: center"> '+ hopedate + '</td>';
					html += ' <td style="text-align: center"> '+ processstate + '</td>';
					html += '</tr>';
					 
		        });
				//페이징처리
			    $('#paging').paging({
			    	
					 current:cuurPage
					,max:pageTotalCnt
					,length:pageLen
					,onclick:function(e,page){
						cuurPage=page;
						fn_search(cuurPage);
					}
				});
				$("#topInfo").html("<strong>["+ cuurPage +" / "+pageTotalCnt+" Pages] <span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.</strong>");
			    $("#bodyInfo").html(html);
			  
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/						 
				
				$('#paging').children().remove();
				
				$("#bodyInfo").html('<tr><td colspan="7" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}
function checkInput(offer)
{
	var keyword = new Array("로그인 후 신청하세요!","자료형태를 선택해 주세요.","서명을 입력하여 주십시요!","저자를 입력하여 주십시요!","발행처를 입력하여 주십시요!","ISBN을 10자리 이상 정확히 입력하여 주십시요!","처리중 입니다!");
	var IS_SUBMIT = false;
/*   if("${loginVO.emplyrnm}"==""){
	  alert(keyword[0]);
	  return false;
  } */
  
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
	/*
	if(offer.publisherYear.value.length == 0) {
		alert("발행년도를 입력하여 주십시요!");
		offer.publisherYear.focus();
		return false;
	}
	
	if(offer.isbn.value.length == 0) {
		alert("ISBN은 필수입력 항목입니다.");
		offer.isbn.focus();
		return false;
	}
	*/
	if(offer.isbn.value.length > 0 &&  offer.isbn.value.length < 10) {
			alert(keyword[5]);
			offer.isbn.focus();
			return false;
	}
	
	IS_SUBMIT = true;	
	offer.submit();

  }	else {
	  alert(keyword[6]);

  }			
}
</script>

	
	

	<div class="sub_center_text">
	      <div class="sub_center_nav"> 
		      <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
		      <span> > </span> 
		      <span>교육/서비스</span>
		      <span> > </span>
		      <span>도서 신청</span>        
	      </div>
	        <div class="sub_center_wrap">
		        <a href="#" class="center_text_01">도서 신청처리결과</a>
			</div>
	</div>
	
	<div class="under_bar"></div> 	
		
		<div class="content_wrap">
		
		<a href="${ctxt}/srv/hope/hopeReg.do">신청</a>
		<a href="${ctxt}/srv/hope/listHope.do">신청처리결과</a>	  
					<p id="topInfo"></p>
					
					<table class="basic_table">
						<caption>
							도서 신청처리 결과 - 번호,도서구분,서명,저자,출판사,신청일,상태
						</caption>
						<colgroup>
							<col style="width:7%">				
							<col style="width:10%">
							<col style="width:30%">
							<col style="width:15%">
							<col style="width:15%">
							<col style="width:15%">
							<col style="width:10%">
						</colgroup>
						<thead>
						<tr>
							<th scope='col'>번호</th>
							<th scope='col'>도서구분</th>
							<th scope='col'>서명</th>
							<th scope='col'>저자</th>		
							<th scope='col'>출판사</th>										
							<th scope='col'>신청일</th>										
							<th scope='col'>상태</th>										
						</tr>
						</thead>
						<tbody id = 'bodyInfo'>
							
						</tbody>
					</table>
					
					<div id="paging" class="paginate" ></div>
				
			</div>
	
	<!-- 추가 PARAM -->
	<input type="hidden" name="edc_progrm_id" id="edc_progrm_id" value="${eduVo.edc_progrm_id}" alt="data_center_id" />
 	<!-- 공통  필수 PARAM -->
 	<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/> --%>