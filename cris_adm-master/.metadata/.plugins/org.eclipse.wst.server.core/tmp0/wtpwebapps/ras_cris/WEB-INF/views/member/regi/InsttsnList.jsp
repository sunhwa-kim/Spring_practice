<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
<c:import url="/WEB-INF/views/layout/includes/subMeta.jsp" /> 


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

	$('#alit_id').val(param);
	var form=document.reqForm;
	form.action="${ctxt}/member/regi/InsttsnRead.do";
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
        url: '${ctxt}/member/regi/InsttsnRead.do',
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
				
// 					html += '<tr onMouseOver="this.style.backgroundColor = \'#F4F4F4\'" onMouseOut="this.style.backgroundColor=\'#ffffff\'" style="cursor:pointer;background-color: rgb(255, 255, 255);">';
					
					html += '<tr style="cursor:pointer; text-align:center">';
					
					html += '<td style="text-align: center;">'+'<input type="checkbox" id="moveBtn" name="chkInst" title="'+obj.find('instttyid').text()+' '+obj.find('insttsn').text()+' '+obj.find('initgroup').text()+'" value="'+obj.find('initgroup').text()+'" onclick="insInfo(\''+obj.find('instttyid').text()+'\',\''+obj.find('insttsn').text()+'\',\''+obj.find('initgroup').text()+'\',\''+obj.find('insttnm').text()+'\')"/>'+'</td>';
					
					html += '<td onclick="instChk(\''+obj.find('instttyid').text()+'\',\''+obj.find('insttsn').text()+'\',\''+obj.find('initgroup').text()+'\',\''+obj.find('insttnm').text()+'\')">'+obj.find('order_sn').text()+'</td>';
					
					html += '<td onclick="instChk(\''+obj.find('instttyid').text()+'\',\''+obj.find('insttsn').text()+'\',\''+obj.find('initgroup').text()+'\',\''+obj.find('insttnm').text()+'\')">'+obj.find('initgroup').text()+'</td>';
					
					html += '<td onclick="instChk(\''+obj.find('instttyid').text()+'\',\''+obj.find('insttsn').text()+'\',\''+obj.find('initgroup').text()+'\',\''+obj.find('insttnm').text()+'\')">'+obj.find('insttnm').text()+'</td>';
					
					html += '<td onclick="instChk(\''+obj.find('instttyid').text()+'\',\''+obj.find('insttsn').text()+'\',\''+obj.find('initgroup').text()+'\',\''+obj.find('insttnm').text()+'\')">'+obj.find('new_adres').text()+" "+obj.find('new_adres2').text()+'</td>';
					
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
						//$("#searchKeyword").val("");
						//$("#searchCondition").val("");
						
						fn_search(cuurPage);
					}
				});
				$("#topInfo").html("<span class = 'gray'>["+ cuurPage +" / "+pageTotalCnt+" Pages]</span> <span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.");
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

function instChk(instttyid,insttsn,initgroup,insttnm){
   //기관그룹번호 ,기관일련번호,기관그룹명,기관명
   $("#instttyid",opener.document).val(instttyid);
   $("#insttsn",opener.document).val(insttsn);
   $("#mouOrg",opener.document).val(initgroup);
   $("#mouSub",opener.document).val(insttnm);
   self.close();	  
}

$(function() { 
 	$(document).on("click","input[type='checkbox']",function(event){
           $('input[type="checkbox"]').not(this).prop("checked",false);
    });
});

function insInfo(insttyid, insttsn, initgroup, insttnm){
	$("#insttyid").val(insttyid);
	$("#insttsn").val(insttsn);
	$("#initgroup").val(initgroup);
	$("#insttnm").val(insttnm);
}

function selectInst(){
	var id = $("#insttyid").val();
	var sn = $("#insttsn").val();
	var group = $("#initgroup").val();
	var nm = $("#insttnm").val();
	instChk(id,sn,group,nm);
}

</script>
<style>
	.content_box>.content_list ul{
		width: auto;
    	margin: 0 0 3.5% 0;
	}
	#searchCondition{
		min-width:120px;
	}
	#search-group{
		top: 100px;
	}
</style>
</head>
<body>

<form name="reqForm" method="post">
	
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
			<div>
				 <ul class="list_full limit">
					<li class="dashed">먼저 질병관리본부의 기관이 보여집니다. 해당하지 않으시면 셀렉트박스를 선택하시어 검색 하시기 바랍니다.</li>
				 	<li class="dashed"><span style="border-bottom:0px dotted red; color:red;">모든 기관에 해당하지 않으시면 기타기관에 기타기관으로 검색하여 선택 하시기 바랍니다.</span></li>
				</ul>
			</div>
		        <div id="search-group">
					<div class="search-input">
						<label for="searchCombo"></label>
							<select id="searchCondition" name ="searchCondition" title="분류">
								<option value="">전체</option>
								<c:forEach var="item" items="${org_gbn}" varStatus="stat">
									<option value="${item.ref_val1}">${item.cd_nm}</option>
								</c:forEach>
							</select>
						<label for="searchBox"></label>
						<input type="text" id="searchKeyword" name= "searchKeyword" onkeydown="fn_enter_search(this);"/>
		            	<input type="button" id="btnSearch" value="검색" onclick="javascript:fn_search(1)"/>
					</div>
				</div>
			
			  
					<p id="topInfo"></p>
					
					<table class="basic_table">
						<caption>
						 	기관목록 -  번호,기관일련번호,기관그룹명,기관명,주소
						</caption>
						<colgroup>
							<col style="width:10%">				
							<col style="width:10%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:40%">
			
						</colgroup>
						<thead>
						<tr>
							 <th scope="col">기관선택</th>
							 <th scope="col">No.</th>
						     <th scope="col">기관그룹명</th>
						     <th scope="col">기관명</th>
						     <th scope="col">주소</th>								
						</tr>
						</thead>
						<tbody id = 'bodyInfo'>
							
						</tbody>
					</table>
					
					<div class="btn-group">				
						<a href='javascript:selectInst();' class='basic-btn' ><span>선택기관적용</span></a>
						<a href='javascript:self.close();' class='basic-btn' ><span>닫기</span></a>
					</div> 
					
					<div id="paging" class="paginate"></div>
			</div>
		</div>
	</div>
	
	
	<input type="hidden" id="insttyid" value="">
	<input type="hidden" id="insttsn" value="">
	<input type="hidden" id="initgroup" value="">
	<input type="hidden" id="insttnm" value="">
	
	<!-- 추가 PARAM -->
	<input type="hidden" name="page" id="page" value="" alt="pageNum" /> 
 	
 	<!-- 공통  필수 PARAM -->
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/>
</form>
</body>
</html>