<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

var xmlList;
var html="";
var cuurPage;
var pageTotalCnt = 0;
var dataTotalCnt = 0;

$(function(){
	  
	if($("#messege").val() != ''){
    	fn_alert( $("#messege").val());
    }
    $("#messege").val('');
	
    var page =$('#page').val();
	if(page == '' ){
		page=1;
	}
	
 var searchOption = $("#searchOption").val();
 
	if(searchOption != '' ){
		$('#searchCondition option[value='+searchOption+']').attr('selected',true);
	}
		
	// 화면 목록 조회
	fn_search(page);
	 
});

//상세화면 조회
function fn_page(edc_progrm_id){
	$('#edc_progrm_id').val(edc_progrm_id);
	var form=document.reqForm;
	form.action="${ctxt}/srv/eduResult/eduResultView.do?edc_progrm_id="+edc_progrm_id;
	form.submit();
	
}

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
        url: '${ctxt}/srv/eduResult/eduResultRead.do',
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
					var dataId = obj.find('edc_progrm_id').text();
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					html += '<tr>';
					html += ' <td style ="text-align:center;">'+obj.find('order_sn').text() +'</td>';
					if(obj.find('sj').text().length>50){
					html += ' <td class= "text-left"><a href="javascript:fn_page(\''+obj.find('edc_progrm_id').text()+'\')" >'+obj.find('sj').text().substr(0,50)+"..." +'</a></td>';
					}
					
					else{
						html += ' <td class= "text-left"><a href="javascript:fn_page(\''+obj.find('edc_progrm_id').text()+'\')" >'+obj.find('sj').text() +'</a></td>';
							
					}
					html += ' <td style ="text-align:center;">'+obj.find('begin_de').text() + '~' + obj.find('end_de').text() + '</td>';
					html += ' <td style ="text-align:center;">'+obj.find('partcpt_psncpa').text() + '</td>';
					html += ' <td style ="text-align:center;">'+obj.find('rdcnt').text() +'</td>';
					html += '</tr>';
					 
		        });
				//페이징처리
			    $('#paging').paging({
			    	
					 current:cuurPage
					,max:pageTotalCnt
					,length:pageLen
					,onclick:function(e,page){
						cuurPage=page;
						
						
						$("#searchKeyword").val("");
						$("#searchCondition").val("ALL");
						
						fn_search(cuurPage);
					}
				});
				$("#topInfo").html("<strong>["+ cuurPage +" / "+pageTotalCnt+" Pages] <span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.</strong>");
			    $("#bodyInfo").html(html);
			  
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/						 
				$("#searchKeyword").val("");
				$("#searchCondition").val("ALL");
				
				$('#paging').children().remove();
				
				$("#topInfo").html("<strong>[1 / 1 Pages] <span class = 'txt-red' > 0 </span> 건이 검색되었습니다.</strong>");
				
				$("#bodyInfo").html('<tr><td colspan="5" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}


</script>

	
		
		
	

<form name="reqForm">
		
		<div class="sub_center_text">
		      <div class="sub_center_nav"> 
			      <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			      <span> > </span> 
			      <span>교육/서비스</span>
			      <span> > </span>
			      <span>교육 결과</span>        
		      </div>
	          <div class="sub_center_wrap">
		        <a href="#" class="center_text_01">교육 결과</a>
			  </div>
		</div> 		
		
		<div class="under_bar"></div>				
		
	<div class="content_wrap">
		<div class="search_wrap">
	        <div id="search-group">
	        	<div class="search-input">
					<label for="searchComboBox"></label>
					<select id="searchCondition" name="searchCondition" title="분류">
						<option value="ALL">전체</option>
						<option value="TITLE">제목</option>
						<option value="INSTRCTR">강사</option>
						<option value="SUB">내용</option>
					</select>
					<label for="searchBox"></label>
					<input type="text" id="searchKeyword" name="searchKeyword"    placeholder="검색어를 입력하여 주십시오." value="${eduResultVo.searchKeyword}" onkeydown="fn_enter_search(this);"/>
	            	<input type="button" id="btnSearch" value="검색" onclick="javascript:fn_search(1)"/>
				</div>
			</div>
		</div>
			
			<p id="topInfo"></p>
				
				<table class = 'basic_table'>
					<caption>
						 	 교육결과  - 번호,제목,기간,신청인원,조회수
					</caption>
					<colgroup>
						<col style="width:10%">				
						<col style="width:47%">
						<col style="width:23%">
						<col style="width:10%">
						<col style="width:10%">
					</colgroup>
					<thead>
						<tr>
							<th scope='col'>번호</th>
							<th scope='col'>제목</th>
							<th scope='col'>기간</th>
							<th scope='col'>신청인원</th>		
							<th scope='col'>조회수</th>										
						</tr>
					</thead>
					<tbody id = 'bodyInfo'>
						
					</tbody>
				</table>
					
				<div id="paging" class="paginate"></div>
				
		</div>
	
		
	
	
		<!-- 추가 PARAM -->
	<input type="hidden" id="messege" name="messege" value="${messege}" alt="message">
	<input type="hidden" name="page" id="page" value="${eduResultVo.page}" alt="pageNum" /> 
	<input type="hidden" name="edc_progrm_id" id="edc_progrm_id" value="${eduResultVo.edc_progrm_id}" alt="edc_progrm_id" />
	<input type="hidden" name="searchOption" id="searchOption" value="${eduResultVo.searchCondition}" alt="콤보param" /> 
 	
 	<!-- 공통  필수 PARAM -->
 	<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/> --%>
	
	
	
</form>