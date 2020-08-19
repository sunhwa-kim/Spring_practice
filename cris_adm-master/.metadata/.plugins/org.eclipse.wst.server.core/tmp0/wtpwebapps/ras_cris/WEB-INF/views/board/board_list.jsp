<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

 <script type="text/javascript">
  
  var xmlList;
  var html="";
  var curPage;
  var pageTotalCnt = 0;
  var dataTotalCnt = 0;

$(function(){

    var page =$('#page').val();
	if(page == '' ){
		page=1;
	}
	
	
	  var searchClassification = $('#searchClassification').val();
	  var searchCustomHeader = $('#searchCustomHeader').val();
	  var searchSituation = $('#searchSituation').val();
	
// reset?
 	if(searchClassification != " " && searchCustomHeader != " " && searchSituation != " "){
 		//select -> params
 		alert("공백아니면")
 		$("#view_control").css("display","");
 		
		$('#selectClassification option[value='+searchClassification+']').attr('selected',true);
		$('#selectCustomHeader option[value='+searchCustomHeader+']').attr('selected',true);
		$('#selectSituation option[value='+searchSituation+']').attr('selected',true);
	}

	  
$('#boardQnA_returnFirstPage').click(function(){
	
	$('#searchKeyword').val("");
	$('#selectClassification option[value="" ]').attr('selected',true);
	$('#selectCustomHeader option[value=""]').attr('selected',true);
	$('#selectSituation option[value=""]').attr('selected',true);
	
	fn_search(1);
});
// boardQnA_returnFirstPage end
	  
	  
	// 화면 목록 조회
	fn_search(page);
	
	 $("#searchKeyword").keydown(function(e){
		if(e.ctrlKey && ( e.which === 77 )) {
			$(".excelDown").show();
		}
    });  
});  // first function end
  
  
function detailed_information(param){
	
	 var selectClassification = $('#selectClassification option:selected').val();
	 var selectCustomHeader = $('#selectCustomHeader option:selected').val();
	 var selectSituation = $('#selectSituation option:selected').val();

	$('#idx_board').val(param);
	$('#searchClassification').val(selectClassification);
	$('#searchCustomHeader').val(selectCustomHeader) ;
	$('#searchSituation').val(selectCustomHeader);
	
	var form=document.reqForm;
	form.action="${ctxt}/board/qna/boardQnaListDetailed.do";
	form.submit();
}
  

// 검색 후 페이지 1 누르면 그냥 초기화 (검색 결과나온 1 페이지 유지 안됨)
function fn_search(page){
	
	curPage= page;
	
	$('#page').val(curPage);
	var params = {};
  		params.page=curPage;
  		params.searchKeyword = $('#searchKeyword').val();
		params.searchClassification  = $('#selectClassification option:selected').val();
		params.searchCustomHeader = $('#selectCustomHeader option:selected').val(); 
		params.searchSituation = $('#selectSituation option:selected').val(); 
		
$.ajax({
        url: '${ctxt}/board/qna/boardQnaList.do',
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
					
					var idx_board = obj.find('idx_board').text();

					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					html += '<tr>';
					html += ' <td >'+obj.find('rn').text() + '</td>';
					html += ' <td style="text-align: center">'+obj.find('classification').text() + '</td>';
					html += ' <td ><a href="javascript:detailed_information(\''+idx_board+'\')" >'+obj.find('title').text() + '</td>';
					html += ' <td style="text-align: center">'+obj.find('writer').text() + '</td>';
					html += ' <td style="text-align: center">'+obj.find('insertdate_board').text() + '</td>';
					html += ' <td style="text-align: center">'+obj.find('situation').text() +'</td>';
					html += '</tr>';
					 
		        });
				//페이징처리
			    $('#paging').paging({
			    	
					 current:curPage
					,max:pageTotalCnt
					,length:pageLen
					,onclick:function(e,page){
						curPage = page;
						
						// 페이지 이동시 PARAM 초기화
						$("#searchKeyword").val("");
						$("#selectClassification").val("");
						$("#selectCustomHeader").val("");
						$("#selectSituation").val("");
						
						fn_search(curPage);
					}
				}); 
				$("#topPageInfo").html("<span class = 'gray'>["+ curPage +" / "+pageTotalCnt+" Pages]</span> <span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.");

				$("#bodyInfo").html(html);
			  
			}else{
				/***************************************************************
				*          화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$('#paging').children().remove();
				
				$("#bodyInfo").html('<tr><td colspan="5" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              
        	// Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
        	
}); 
  //ajax end
  }; 
  //function end
$(function(){
$("#testBtn").click(function(){
	alert("sh c foreact")
	alert($('#QnA_CLASSIFICATION option:selected').val())
	
});
});
</script>

<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title></title>
  </head>
  <body>
  <form name="reqForm" method="post">
    <div class="search_section">
      <select id="selectClassification" name="selectClassification">
      <option value="">분류</option>
      <option value="member">회원관련</option>
      <option value="clinical-research">임상연구관련</option>
      <option value="registration">등록관련</option>
      <option value="theOthers">기타</option>
    </select>

    <select id="selectCustomHeader" name="selectCustomHeader">
    	<option value="">제목/작성자</option>
      <option value="cstmhdr-title">제목</option>
      <option value="cstmhdr-writer">작성자</option>
    </select>

    <select id="selectSituation" name="selectSituation">
      <option value="">상태</option>
      <option value="req-cmplt">신청완료</option>
      <option value="ans-ing">답변중</option>
      <option value="ans-cmplt">답변완료</option>
    </select>
    
      <input type="text" id="searchKeyword" name="searchKeyword" value="${boardQnAVo.searchKeyword}"   placeholder="제목 또는 작성자를 입력 하세요.">
      <input type="button" id="searchBtn" name="" value="검색" onclick="javascript:fn_search(1)">
    </div>
    <p id="topPageInfo"></p>
    <div class="table_section">
      <table>
   
	

<%-- <select>
<c:forEach items="${list }" var="item">
	<option value="${item.cd }">${item.cd_nm }</option>
</c:forEach>
</select> --%>

<select>
<c:forEach items="${QnA_CLASSIFICATION }" var="QnA_CLASSIFICATION">
	<option value="${QnA_CLASSIFICATION.cd }">${QnA_CLASSIFICATION.cd_nm }</option>
</c:forEach>
</select>  

<select>
<c:forEach items="${QnA_CustomHeader }" var="QnA_CustomHeader">
	<option value="${QnA_CustomHeader.cd }">${QnA_CustomHeader.cd_nm }</option>
</c:forEach>
</select>  

<select>
<c:forEach items="${QnA_SITUATION }" var="QnA_SITUATION">
	<option value="${QnA_SITUATION.cd }">${QnA_SITUATION.cd_nm }</option>
</c:forEach>
</select>  
<input type="button" id="testBtn" name="testBtn" value="test" >


      <colgroup>
        <col style="width:5%" />
        <col style="width:10%" />
        <col style="width:35%">
        <col style="width:25%">
        <col style="width:15%">
        <col style="width:10%">
      </colgroup>
      <thead>
        <tr>
          <th>번호</th><th>분류</th><th>제목</th><th>작성자</th><th>등록일</th><th>상태</th>
        </tr>
      </thead>
		<tbody id = "bodyInfo">
							
		</tbody>
      </table>
    
     <input type="text" id="message" name="message" value="${message}" alt="message">
	<input type="text" name="page" id="page" value="${boardQnAVo.page}" alt="pageNum" /> 
 	<input type="text" name="searchClassification" id="searchClassification" value="${boardQnAVo.searchClassification}" /> 
	<input type="text" name="searchCustomHeader" id="searchCustomHeader" value="${boardQnAVo.searchCustomHeader}"  /> <!-- writer 추가 -->
	<input type="text" name="searchSituation" id="searchSituation" value="${boardQnAVo.searchSituation}" /> 
	
	<input type="hidden" name="idx_board" id="idx_board" /> 
</form>
	<div id="paging" class="paginate"  style ="text-align: center;">
              <input type="button" value="등록"  id="boardQnA_register">
    </div>
 	<div id="view_control" style="display:none">
              	<input type="button" value="첫 화면으로 이동"  id="boardQnA_returnFirstPage" >
     </div>
  </body>
 
 
</html>
