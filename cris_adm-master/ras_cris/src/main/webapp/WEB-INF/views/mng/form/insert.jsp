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
 var brd_seq_last = '${brd_seq_last}';

 //json으로도 바꿔보기
$(function(){
	var columnIdArr = [];
	
	$.ajax({
		url : ctxt+'/mng/form/beforeInsertFrmBrd.do',
		data : {
			"frm_id" : frm_id
		},
		type :'POST',
		async : false,
		success : function(res){
			var html = "";
			for(var i in res){
				var dataType = res[i].dataType;
				var colNm = res[i].frmCol;
				columnIdArr.push(colNm);
				
				if(dataType=="T"){
					html += res[i].elmntNm;
					html += "<input type=\"text\" id=\""+colNm+"\" name=\""+res[i].frmCol+"\" value=\"\"><br>"
				} else if ("TA"==dataType){
					html += res[i].elmntNm;
					html += "<textarea id=\""+colNm+"\" name=\""+colNm+"\" ></textarea><br>"					
				} else {
					html += res[i].elmntNm;
					html += res[i].cdSelect;
				}
			}
			$('#boardInsert').html(html);
		}
	})  //ajax end  
	
	
$('#insertBoardBtn').click(function(){
	
	var paramObject = new Object();
	var paramArr = [];
	
	for(var i in columnIdArr){
		var tmpId = columnIdArr[i];
		var tmpVal = $('#'+tmpId).val();
		paramObject[tmpId] = tmpVal;
	}
	
	paramObject["frm_id"] = frm_id;
	paramObject["brd_seq"] = brd_seq_last;
	
	paramArr.push(paramObject);
	
	var params = {};
	params.jsonArr = paramArr;
	
 	$.ajax({
		url : ctxt+'/mng/form/executeInsertFrmBrd.do',
		data : JSON.stringify(params),
		type :'POST',
		async : false,
		success : function(res){
			 history.back();
		}
	})  //ajax end  
	
});  //btn end
}) // function end
</script>


<div id="container">

	<div id="divRefreshArea">
	<h2>Form 관리</h2>
		
		<div>
		<input type="text" id=" inptFrm_id"  name="inptFrm_id"  value=${frm_id }><br>
		<input type="text" id=" inptBrd_seq"  name="inptBrd_seq" value=${brd_seq_last }><br>
		<span id="boardInsert">
		</span>
		<input type="button" id="insertBoardBtn"  name="insertBoardBtn"  value="등록">
		</div>
<%-- 		<form action="" name="etl_form">
	    
	    	<c:forEach var="item" items="${list}" varStatus="idx">
	    		<c:choose >
	    			<c:when test="${item.DATA_TYPE eq 'T'}">
	    				<label>${item.LBL_KOR}</label><input type="text" name="${item.ELMNT_ID}">
	    			</c:when>
	    			<c:when test="${item.DATA_TYPE eq 'TA'}">
	    				<label>${item.LBL_KOR}</label><textarea name="${item.ELMNT_ID}"></textarea>
	    			</c:when>
	    			<c:when test="${item.DATA_TYPE eq 'S'}">
	    				<label>${item.LBL_KOR}</label>${item.CD}
	    			</c:when>
	    		</c:choose>
	    		<br />   
	    	</c:forEach>
	     	
     	</form>
     	    --%>
	</div>