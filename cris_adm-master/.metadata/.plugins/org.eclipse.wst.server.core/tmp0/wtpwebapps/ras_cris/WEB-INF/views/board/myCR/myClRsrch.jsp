<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@page import="kr.go.cris.ptl.mng.menu.vo.MngMenuVo"%>

<link href="${ctxt}/resources/css/tree/jquery.treeview.css" rel="stylesheet" type="text/css">
<link href="${ctxt}/resources/css/tree/code.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	var longinInfo = 'devsuper';

	param = {};
	param.userId = longinInfo;

$(function(){
	$.ajax({
		url: ctxt + '/board/myClinicalResearch/registration_mng.do',
		data : param,
		type:'POST',
		async:false,
		success:function(res){
			
			var resArr = [];
			var html ="";
			for(var i=0; i<res.length;i++){
				
				var hideRows = res.length -3
				resArr=res[i];
				html+='<tr class="thtr" style="display:\'\'">';
					html+='<th>등록번호</th>';
					html+='<td colspan="3">'+resArr.SYSTEM_NUMBER+'</td>';
					html+='<th>상태</th>';
					html+='<td>'+resArr.STATUS+'</td>';
				html+='</tr>';
				html+='<tr class="thtr">';
					html+='<th>연구제목<th>';
					html+='<td colspan="5">'+resArr.RESEARCH_TITLE_KR+'</td>';
				html+='</tr>';
				html+='<tr class="thtr">';
					html+='<th>최초제출일</th>';
					html+='<td>'+resArr.INS_DATE+'</td>';
					html+='<th>검토/승인일</th>';
					html+='<td>'+resArr.APP_DATE+'/'+resArr.LAST_DATE+'</td>';
					html+='<th>최종갱신일</th>';
					html+='<td>'+resArr.UPT_DATE+'</td>';
				html+='</tr>';
				html+='<tr colspan="6">';
					html +='<td></td>';
					html += '<td><input type="button" name="" value="제출 이력"></td>';
					html += '<td><input type="button" name="" value="연구 정보"></td>';
					html += '<td><input type="button" name="" value="연구 결과"></td>';
					html += '<td><input type="button" name="" value="삭제"></td>';
					html += '<td><input type="button" name="" value="관리자 변경"></td>';
				html+='</tr>';
				/* html+='<tr>';
					html += '<td> 등록관리자 지정 연구 '+hideRows+'개 더 보기</td>';
				html+='</tr>'; */
			
			}
			$('#tbodyData').html(html);
		}
	})  //  end of the first ajax
	
	console.log($('#tbodyData').parents('tr').eq(0))
	
});
</script>

<div id="container" style="min-height: 600px;">

	<div id="divRefreshArea">
			<h3 style="margin-left: 10%;">my 임상 연구</h3>
		
		<form action="" name="etl_form">
	     	<table id="example0" class="tbl_type"  style="width:55%;margin-left: 10%;"> 
	        	<colgroup>
	        		<col style="width:10%;"/>
	        		<col style="width:10%;"/>
	        		<col style="width:10%;"/>
	        		<col style="width:8%;"/>
	        		<col style="width:10%;"/>
	        		<col style="width:10%;"/>
	           </colgroup> 
		           <thead>    
		         	<tr>
		         		<th colspan="6" style="text-align: left;;">등록 관리자</th>
		        	 </tr>        
		       	</thead>
		       	<tbody id="tbodyData" >       
		        </tbody>		        
	     	</table>		
     	</form>
	</div>