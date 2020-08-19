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
	
    var searchType =$('#searchType').val();
	if(searchType != '' ){
		$('#srchChoice option[value='+searchType+']').attr('selected',true);
	}
	
	// 화면 목록 조회
	fn_search(page);
	 
});



function fn_search(page){
	//현재 페이지 세팅
	cuurPage= page;
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/

	$('#page').val(cuurPage);

	$('#searchType').val($('#srchChoice option:selected').val());
	
	var params = {};
  		params.page=cuurPage;
		params.elib_type = 'webDB';
		params.searchKeyword = $('#searchWord').val();
		params.searchType = $('#srchChoice option:selected').val(); 

    $.ajax({
        url: '${ctxt}/elib/webdb/readWebdb.do',
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
				
				var innerIp = '${INNER_IP}';
				
				xmlList.each(function(cnt){
			
					var obj = $(this);
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					
					if(cnt < 3){
						return true;
					}
						
					
					html += '<tr>';
					html += ' <td>'+obj.find('order_sn').text() +'</td>';
					html += ' <td><img src="${ctxt}/resources/images/Koala.jpg" style="width:200px;"></img></td>';
					if(obj.find('elib_link').text() != ''){
						html += ' <td>'+obj.find('elib_sj').text() + '</td>';
					}
					
					if( innerIp != 'Y'){
						html += '<td class="listtd"><a href="#" onclick="elibPopInternalIp(\'' +obj.find('elib_link').text() +'\', \'E\');addptlStatAccess(\'' +obj.find('elib_link').text() +'\',\'' +obj.find('elib_link').text() +'\');" title="새창">'+obj.find('elib_sj').text() +'</a></td>';
					}else{
						
					}
					html += ' <td class="listtd hiddenTbl" style="text-overflow:ellipsis" >'+obj.find('elib_cn').text() + '</td>';
					
					html += ' <td>'+obj.find('theme_field').text() + '</td>';
					html += ' <td class="ce"><input type="button" value="신고"  class="cur_pointer btnRaius10" onclick="elibErrorLink(\''+obj.find('elib_id').text() +'\');" /></td>';
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
				
				$("#bodyInfo").html('<tr><td colspan="5" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}

// 전자정보 오류신고
function elibErrorLink(elibId){
	var loginCheck = "<c:out value='${userVo}' />";
	
	if(loginCheck != ""){
		var url = '${ctxt}/elib/webdb/listWebError.do';
		$("#elib_id").val(elibId);
		
		var form = document.webError;
		form.action=url
		form.submit();
			
	}else{
		if (confirm('로그인 후 이용 가능한 서비스 입니다.\n로그인 하시겠습니까?')) 
		location.href="${ctxt}/login/user/login.do?returnURL=/elib/webdb/listWebdb.do";
	}
	
}
</script>



<form name="webError" id="errorLink" action="" method="post" >
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/></form>
	<input type="hidden" name="elib_id" id="elib_id" value="" alt="elib_id" /> 
	<input type="hidden" id="messege" name="messege" value="${messege}" alt="message">
	<input type="hidden" name="page" id="page" value="" alt="pageNum" /> 
		 
	<div id="container" class="container">
		<div id="divUcont_cont">
 						

	        <div id="search-group">
	        	<div class="search-select">
					<label for="srchFromDT">연설일</label>
					<span><font style="font-weight: bold;">연설일 :</font></span>
	         	    <input name="srchFromDT" title="From" onclick="fn_input_clear(this);" onkeydown="fn_enter_search(this);"/>
	                &nbsp; ~ &nbsp;
	                <input name="srchToDT" title="To" onclick="fn_input_clear(this);" onkeydown="fn_enter_search(this);"/>
				</div>   
				<div class="search-input">
					<label for="searchComboBox">검색콤보박스</label>
					<select id="searchCombo" title="분류">
						<option value="">전체</option>
						<option value="TLT">제목</option>
						<option value="SPNM">연설자</option>
						<option value="SPNM_GB">연설자구분</option>			
						<option value="INST_NM">기관명</option>
					</select>
					<label for="searchBox">검색창</label>
					<input type="text" id="searchKeyword" name="searchKeyword" placeholder="검색어를 입력하여 주십시오." value="${boardNotiVo.searchWord}" onkeydown="fn_enter_search(this);"/>
	            	<input type="button" id="btnSearch" value="검색" onclick="return false;"/>
					                		
				</div>
			</div>
			
			<div id="divRefreshArea">
			  
					<p id="topInfo"></p>
					
					<table class="basic-table center">
						<caption>
						 	 공지사항 -  번호, 구분, DB 명, 내용, 주제분야, 오류신고, 설명서 
						</caption>
						<colgroup>
							<col style="width:5%">				
							<col style="width:10%">
							<col style="width:15%">
							<col style="width:15%">
							<col style="width:30%">
							<col style="width:5%">
							<col style="width:5%">
						</colgroup>
						<thead>
						<tr>
							<th scope='col'>번호</th>d
							<th scope='col'>구분</th>
							<th scope='col'>DB 명</th>
							<th scope='col'>내용</th>		
							<th scope='col'>주제분야</th>										
							<th scope='col'>오류신고</th>										
							<th scope='col'>설명서</th>										
						</tr>
						</thead>
						<tbody id = 'bodyInfo'>
							
						</tbody>
					</table>
					
					<div id="paging" class="paginate"></div>
				
			</div>
	
		</div>
		
	</div>
		
	
	
	
</form>