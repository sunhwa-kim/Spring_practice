<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>시스템 관리</title>
</head>
<body>
<script type="text/javascript">
	$(function(){

		//사용여부CSS적용	
		$('select[name=use_yn] option[value=Y]:selected').each(function(){
			$(this).parent().attr('style','width: 90%;color:red;');
		});
		
		//사용여부 변경 CSS이벤트		
		$('select[name=use_yn]').change(function(){

			if($(this).val() == 'Y'){
				$(this).attr('style','width: 90%;color:red;');
			}else{
				$(this).attr('style','width: 90%;');
			}
		});

		
		//테이블 선택 이벤트
		$('#tabList > tr').click(function(){
			
			$('#tabList > tr').removeClass();
			
			$(this).addClass('on');
	
			$.ajax({
			    url : '/mng/sys/selectColList.do',
			    data : {"table_name" : $(this).find('td:eq(1)').text()},   //전송파라미터
			    contentType: 'text/xml;charset=utf-8',   //서버로 데이터를 보낼 때 사용.
			    type : 'GET',
			    dataType : 'json',
			    success : function(result) {
				           	var html="";
				           	var isCntentChk="";
				           	var isPkChk="";
				           		$(result).each(function(cnt,entry){
				           			isCntentChk="";
				           			isPkChk="";
				           			if(entry.CONTENT_YN == 'Y'){
				           				isCntentChk = "checked";
				           			}
				           			if(entry.PK_YN == 'Y'){
				           				isPkChk = "checked";
				           			}
					           		html += '<tr>';
					           		html += ' <td><input type="checkbox" '+isPkChk+' /></td>';
					           		html += ' <td><input type="checkbox" '+isCntentChk+' /></td>';
					           		html += ' <td>'+entry.COLUMN_NAME +'</td>';
					           		html += ' <td>'+entry.COMMENTS +'</td>';
					           		
					           		if(entry.TITLE_YN == "Y"){
					           			html += ' <td><input type="checkbox" checked="checked" value="Y" /></td>';
					           		}else{
					           			html += ' <td><input type="checkbox"  value="N" /></td>';
					           		}
					           		html += '</tr>';
				           		});
				           	$('#colList').children().remove();
				           	$('#colList').html(html);
			    			},
			    error : function() { // Ajax 전송 에러 발생시 실행
			           	fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
			    		},
			});
		});
		
		//온로드시 첫번째 로우클릭
		$('#tabList > tr :first').click();
		
	});
	
function fn_save(){
	
	var strConfirm = confirm("저장하시겠습니까?");

	if(strConfirm){
		var list = [];
		var cnt=0;
		$('#colList > tr').each(function(){
			//하나라도 체크되있으면 값 저장\
 			if($(this).find('td').eq(0).find('input[type=checkbox]').is(':checked') 
 					|| $(this).find('td').eq(1).find('input[type=checkbox]').is(':checked')){
	
 				list[cnt] = {
 						"table_name" : $('.on').find('td:eq(1)').text(),
 						"column_name" : $(this).find('td').eq(2).text(),
 						"pk_yn" : $(this).find('td').eq(0).find('input[type=checkbox]').is(':checked')== true ?"Y":"N",
 						"content_yn" : $(this).find('td').eq(1).find('input[type=checkbox]').is(':checked')== true ?"Y":"N",
 						"table_gp" : $('.on').find('td:eq(3) :selected').val(),
 						"use_yn" : $('.on').find('td:eq(0) :selected').val(),
 						"table_url" : encodeURIComponent($('.on').find('td:eq(4) > input').val()),
 						"title_yn" : $(this).find('td').eq(4).find('input:checked').is(':checked')== true ?"Y":"N",
 						"table_where" : encodeURIComponent($('.on').find('td:eq(5) > input').val())
 					}
 				cnt++;
 			} 
		});	   

		var sendList = {"list" : list};
		  
        $.ajax({ 
          type: 'POST',
          url : '${ctxt}/mng/sys/insertTabInfo.do',
          data: JSON.stringify(sendList),
          success:function(data){
        	  	//$('.on').find('td:eq(0)').find('option[value=Y]').prop('selected','selected');
				fn_alert('저장이 완료되었습니다.');
          },
          error: function(xhr, status, error){
        	  fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
          }
        });
	}
}
	
	
function fn_search(){

	$.ajax({ 
        type: 'GET',
        url : '${ctxt}/mng/sys/searchKeyWord.do',
        data: {"keyword" : $('#search_txt').val()},
        contentType: 'text/xml;charset=utf-8',   //서버로 데이터를 보낼 때 사용.
       	dataType : 'json',
	    success : function(result) {
	    			var html = "";
	           		$(result).each(function(cnt,entry){
	           			html += '<a href="/ncmiklib'+entry.TABLE_URL+'" >['+ entry.TABLE_GP+'] ' + entry.TABLE_TITLE +'</a><br>';
	           		});
	           		$('#reslut').children().remove();
	           		$('#reslut').html(html);
	    },
        error: function(xhr, status, error){
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}

function fn_sc(){
	$.ajax({ 
        type: 'GET',
        url : '${ctxt}/mng/sys/scheduledJob.do',
        data: {},
	    success : function(result) {
	    },
        error: function(xhr, status, error){
        	fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}


</script>

<div id="container" >

	<div id="content" style="height: 700px;">

		<div style="width:65%; height: 700px;float: left;overflow: scroll;"  >
			<h2>조회기준정보</h2>  

		    <!-- 목록 -->
		    <div class="table-b-wrap">
			  	<table class="table-b">
		      	<colgroup>
			        <col width="13%">
			        <col width="20%">
			        <col width="20%">
			        <col width="17%">
			        <col width="15%">
			        <col width="15%">
		      	</colgroup>
		    	<thead>
			        <tr>
			          <th>사용여부</th>
			          <th>테이블</th>
			          <th>테이블명</th>
			          <th>테이블그룹</th>
			          <th>URL</th>
			          <th>조건</th>
			        </tr>
		      	</thead>
		      	<tbody id="tabList">
		      		<c:forEach var="tabList" items="${tabList}" >
		      			<tr>
		      				<td >
		      					<select style="width: 90%;" name="use_yn">
									<option value="Y" <c:if test="${tabList.USE_YN eq 'Y'}"> selected="selected"</c:if>>사용</option>		      					
									<option value="N" <c:if test="${tabList.USE_YN eq 'N'}"> selected="selected"</c:if>>미사용</option>		      					
		      					</select>
		      				</td>
		      				<td><c:out value="${tabList.TABLE_NAME}" /></td>
		      				<td><c:out value="${tabList.COMMENTS}" /></td>
		      				<td> <select style="width: 90%">
		      						<c:forEach var="tb_gp" items="${table_gp}">
		      							<option value="${tb_gp.cd}" <c:if test="${tabList.TABLE_GP eq tb_gp.cd}">selected="selected"</c:if> >${tb_gp.cd_nm}</option>
		      						</c:forEach>
		      					</select>
							</td>
							<td><input type="text" value="<c:out value="${tabList.TABLE_URL}" />"></input></td>
							<td><input type="text" value="<c:out value="${tabList.TABLE_WHERE}" />"></input></td>
		      			</tr>
		      		</c:forEach>
		      	</tbody>
		   		</table>
		   		
			</div>
		</div>
		
		<div style="margin-left:30px;width:30%; height: 400px;float: left" >
			<input type="hidden" id="save_type" value="" />
		    <!-- 목록 -->
		    <div style="float: right;padding-top: 35px;padding-bottom: 3px;" >
				<button id="addItemBtn" name="save_btn" onclick="fn_save()" >저장</button>
			</div>
		    <div class="table-b-wrap">
			  	<table class="table-b">
		      	<colgroup>
			        <col width="15%">
			        <col width="15%">
			        <col width="30%">
			        <col width="30%">
			        <col width="10%">
		      	</colgroup>
		    	<thead>
			        <tr>
			    	  	<th>PK</th>
			          	<th>컨텐츠</th>
			          	<th>테이블</th>
			          	<th>테이블명</th>
			          	<th>타이틀</th>
			        </tr>
		      	</thead>
		      	<tbody id="colList">
		      	</tbody>
		   		</table>
		   		
			</div>
		</div>
		<br />
	 </div><!-- content  -->
</div><!-- container -->
</body>
</html>