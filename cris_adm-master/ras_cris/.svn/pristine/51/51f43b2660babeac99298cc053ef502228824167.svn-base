<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

function fn_page(param){

	$('#gl_id').val(param);
	var form=document.reqForm;
	form.action="${ctxt}/archive/grey/greyView.do?upd_yn=Y";
	form.submit();
	
}


function fn_search(page){
	//현재 페이지 세팅
	cuurPage= page;
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/

	$('#page').val(cuurPage);


	var params = {};
  		params.page=cuurPage;
		params.searchKeyword = $('#searchKeyword').val();
		params.searchCondition = $('#searchCondition option:selected').val(); 
		
		
    $.ajax({
        url: '${ctxt}/archive/grey/greyRead.do',
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
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					
					var gl_id = obj.find('gl_id').text();
					var order_sn = obj.find('order_sn').text();
					var gl_sj = obj.find('gl_sj').text();
					var frst_regist_pnttm = obj.find('frst_regist_pnttm').text();
					var deptid = obj.find('deptid').text();
				
					html += '<tr>';
					html += ' <td style = "text-align:center;">'+  (dataTotalCnt  - (order_sn -1)) +'</td>';
					
					html += ' <td class= "text-left">';			
				
					if(gl_sj.length>50){
						html += '<a href="javascript:fn_page(\''+gl_id+'\')" >'+ gl_sj.substr(0,50) +"..." +'</a></td>';
					}else{
						html += '<a href="javascript:fn_page(\''+gl_id+'\')" >'+ gl_sj +'</a></td>';
							
					}		
					
					html += ' <td style = "text-align:center;">'+deptid+'</td>';
					html += ' <td style = "text-align:center;">'+ frst_regist_pnttm + '</td>';
					html += '</tr>';
					 
		        });
				//페이징처리
			    $('#paging').paging({
			    	
					 current:cuurPage
					,max:pageTotalCnt
					,length:pageLen
					,onclick:function(e,page){
						cuurPage=page;
						
						// 페이지 이동시 PARAM 초기화
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
				$('#paging').children().remove();
				
				$("#bodyInfo").html('<tr><td colspan="4" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}


</script>



<form name="reqForm" method="post">
	
	
		
		<div class="sub_center_text">
		      <div class="sub_center_nav"> 
			      <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			      <span> > </span> 
			      <span>아카이브</span>
			      <span> > </span>
			      <span>회색문헌</span>        
		      </div>     
		       <div class="sub_center_wrap">
		            <a href="#" class="center_text_01">회색문헌</a>
		       </div> 
		</div> 
		<div class="under_bar"></div>
		 <div  class = "content_wrap">
			<div style="width:100%">  			
		       <div class="search_wrap">
					 <div id="search-group">
						<div class="search-input">
							<label for="searchCombo"></label>
							<select id="searchCondition" name ="searchCondition" title="분류">
								<option value="ALL">전체</option>
								<option value="TITL">제목</option>
							</select>
							<label for="searchBox"></label>
							<input type="text" id="searchKeyword" name= "searchKeyword" value="${archiveGreyVo.searchKeyword}" onkeydown="fn_enter_search(this);"/>
			            	<input type="button" id="btnSearch" value="검색" onclick="javascript:fn_search(1)"/>               		
						</div>
					</div>
				</div>
				<div id="divRefreshArea">
			  
					<p id="topInfo"></p>
					
					<table class="basic_table">
						<caption>
						 	 회색문헌 
						</caption>
						<colgroup>
							<col style="width:10%">				
							<col>
							<col style="width:15%">
							<col style="width:15%">
						</colgroup>
						<thead>
						<tr>
							<th scope='col'>번호</th>
							<th scope='col'>제목</th>
							<th scope='col'>부서</th>
							<th scope='col'>작성일</th>																		
						</tr>
						</thead>
						<tbody id = 'bodyInfo'>
							
						</tbody>
					</table>
					
					<div id="paging" class="paginate" ></div>
				</div>
			</div>
	
		
		
	</div>
		
	
	<!-- 추가 PARAM -->
	<input type="hidden" id="messege" name="messege" value="${messege}" alt="message">
	<input type="hidden" name="page" id="page" value="${archiveGreyVo.page}" alt="pageNum" /> 
	<input type="hidden" name="gl_id" id="gl_id" value="" alt="회색문헌id" /> 
	<input type="hidden" name="searchOption" id="searchOption" value="${archiveGreyVo.searchCondition}" alt="콤보param" /> 
 	
 	<!-- 공통  필수 PARAM -->
 	<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/> --%>
	
	
</form>