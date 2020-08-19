<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@page import="kr.go.cris.ptl.mng.menu.vo.MngMenuVo"%>
<%@page import="kr.go.cris.ptl.mng.code.vo.MngCodeVo"%>
<%@page import="kr.go.cris.base.controller.BaseController"%>
<%@page import="java.util.List"%>

<link href="${ctxt}/resources/css/tree/jquery.treeview.css" rel="stylesheet" type="text/css">
<link href="${ctxt}/resources/css/tree/code.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	var frm_id = '${frm_id}';
	var brd_seq = '${brd_seq}';
	var currPg = '${currPg}';
	var colNmArr = [];
	$(function(){
		var req = '${req}';
		
		if(req=="update"){
			$('#executeBtn').attr({'name':'uptBtn', 'value':'수정'});
			
			var html = '&nbsp;<input type="button" id="backToPg" name="backToPg" value="목록으로">';
			$('#divRefreshArea').append(html);
			
		} else {
			$('#executeBtn').attr({'name':'insertBtn', 'value':'등록'});
		}
		
		params = {};
		params.frm_id = frm_id;
		params.brd_seq = brd_seq;
		params.req = req;
		
		
		$.ajax({
			url : ctxt +'/mng/form/preUptInsert_form.do',
			data : params,
			type : 'POST',
			async : false,
			success : function(res){
				// column 순서 확인 
				//  alert(res.colOrder)
				if(res.error == "error"){
					alert("실행 되지 않았습니다.")
				} else {
					var html = "";
					
					html += res.col1;
					html += res.col2;
					html += res.col10;
					html += res.col3;
					html += res.col4;
					html += res.col5;
					
					$('#dataShow').html(html);
					
					colNmArr = res.colOrder.split(",");
				}
			}
		});
		
		$('#executeBtn').click(function(){
			
			var paramObject = new Object();
			var paramArr = [];
			
			for(var i in colNmArr) {
				var tmpCol = colNmArr[i];
				var tmpValue = $('#'+tmpCol).val();
				paramObject[tmpCol] = tmpValue;
			}
			
			paramObject["frm_id"] = frm_id;
			paramObject["brd_seq"] = brd_seq;
			paramObject["req"] = req;
			
			paramArr.push(paramObject);
			
			params = {};
			params.data = paramArr;
			$('#req').attr('value',"");
			$.ajax({
				url : ctxt+'/mng/form/executeUptInsert_form.do',
				data : JSON.stringify(params),
				type :'POST',
				async : false,
				success : function(res2){
					if(res2=="insert"){
						var result = confirm(' 등록 완료 됐습니다. ');
						if(result){
							url = (ctxt+"/board/listBoard.do?frm_id="+frm_id+"&pg="+currPg);
							var wdwObj  = window.open(url, "_self");
						}
						
					} else if (res2=="update"){
					    location.reload();
						alert(' 수정 완료 됐습니다. ');
							
					}	else {
						alert("에러");
						location.reload();
					} 
				}
			})  //ajax end 
		});
		$('#backToPg').click(function(){
			url = (ctxt+"/board/listBoard.do?frm_id="+frm_id+"&pg="+currPg);
			var wdwObj  = window.open(url, "_self");
		});	
	});  // start function end

</script>
<div id="container">

	<div id="divRefreshArea">
		<input type="text"  id="frm_id" name="frm_id" value=${frm_id}><br>
		<input type="text"  id="brd_seq" name="brd_seq" value=${brd_seq}><br>
		<input type="hidden"  id="req" name="req"  value=${req}>
		<div id="dataShow"></div>
		<input type="button" id="executeBtn" name="" value="">
	</div>
</div>