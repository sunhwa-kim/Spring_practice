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
<%-- <script src="${pageContext.request.contextPath}/resources/admin.js"></script> --%>
<%-- <script src="${pageContext.request.contextPath}/resources/common/nbTable.js"></script> --%>
<script type="text/javascript">
var totalPageCnt = 0;
var totalListCnt = 0;
var searchColumnArr = [];
var searchOptArr = [];

var brd_seq_last = 0;

function contentWndw(paramNm01, param01, paramNm02, param02){
	//alert($(location).attr('href')) //현재 url 받기
	var url = ""
	url = (ctxt+"/board/writeBoard.do"+"?"+paramNm01+"="+param01+"&"+paramNm02+"="+param02)
	var wdwObj  = window.open(url, "_self")
} // contentWndw end


$(function(){
	var frm_id = '${frm_id}';
	
	var colNumber = "";
	var hdColOrder = "";
	
	$.ajax({
		url : ctxt+'/mng/form/selectTheadBoard.do',
		data : {"frm_id":frm_id},
		type: 'GET',  
        contentType: "text/xml;charset=utf-8",   
        dataType: 'text',
        async: false,  //ajax 한 function에 여러개 호출시 추가!
        success: function(rtnXml) {
			var xmlObj = $(rtnXml).find('item');
			var tHeadArr = [];
        	var html= "";

        	var tmp = $(rtnXml).find('item').find('frm_col').text();
     		tmp= tmp.replace(/col/gi ,',')
     		colNumber=tmp.replace(',','')
        //	alert(colNumber)
        	var arr = [];
        	arr = colNumber.split(",");
        	
        	for(var i in arr){
        		hdColOrder += ","+"COL"+arr[i]	
        	}
        	hdColOrder = hdColOrder.replace(",","");
        	alert (hdColOrder)
       
				totalPageCnt = Number($(rtnXml).find('totalPageCnt').text());
				totalListCnt = Number($(rtnXml).find('totalListCnt').text());
			
				xmlObj.each(function(){  
		
					tHeadArr.push($(this).find('lbl_kor').text());
					
					var selectChck = $(this).find('srch_yn').text();
					if(selectChck =='Y'){
						searchOptArr.push($(this).find('lbl_kor').text());
						searchColumnArr.push($(this).find('frm_col').text());
					}
			})  //xmlObj end
//thead
				html += '<tr>'
				html += '<th>순번</th>'
				tHeadArr.forEach(function(thead){
					html += '<th>' +thead+ '</th>';
				})
				html += '</tr>'
				$('#headInfo').html(html);
			
// selectbox's list
			  var addOpt = "";	
				for(var i in searchOptArr){
					addOpt += "<option value="+searchColumnArr[i]+">"+searchOptArr[i]+"</option>";
				}
				$('#wbSelect').append(addOpt); 
				
		}
	})//ajax end
	
	var params = {}
	params.frm_id = frm_id;
	
 	$.ajax({
		url : ctxt+'/mng/form/selectTbodyBoard.do',
		data : params,
		type: 'POST',  
 //       contentType: "text/xml;charset=utf-8",   
        dataType: 'text',
        async: false, 
        success: function(rtnXml) { 
        	alert("subOK");
        	var xmlObj = $(rtnXml).find('item');
        	
        	var html = "";
			var hdColOrderArr = [];
			hdColOrderArr = hdColOrder.split(",");
        	
			xmlObj.each(function(){
				var brd_seq =  $(this).find("BRD_SEQ").text() 
				
				html += '<tr>';	
				html += '<td>'+ brd_seq+'</td>';
				for(var i in hdColOrderArr){
					if(i==0){
						html += '<td><a href="javascript:contentWndw(\'frm_id\',\''+frm_id+'\',\'detailBoard\',\''+brd_seq+'\' )">'+ $(this).find(hdColOrderArr[i]).text() +'</a></td>';
					} else {
						html += '<td>'+ $(this).find(hdColOrderArr[i]).text() +'</td>';
					}
				}
				html += '</tr>';	
			
			})  // xmlObj end
			
//			brd_seq 의 마지막 번호			
			brd_seq_last = xmlObj.length+1;
//			$('#pagination').val(totalPageCnt);
			$('#bodyInfo').html(html);
        }
	});  // second ajax end 
	
 	$('#searchWbBtn').click(function(){
 		var searchTxt = "";
 		var wbSelect = "";
 		alert("버튼 클릭")
 		
 		searchTxt = $('#searchTxt').val();
 		wbSelect = $('#wbSelect').val();
 		
 		alert(searchTxt);
 		
		var btnParams = {};
		btnParams.frm_id = frm_id;
		btnParams.srchTxt = searchTxt;
		btnParams.srchColumnStr =wbSelect;
 		
	$.ajax({
		url : ctxt+'/mng/form/selectTbodyBoard.do',
		data : btnParams,
		type: 'GET',  
        contentType: "text/xml;charset=utf-8",   
        dataType: 'text',
        async: false, 
        success: function(rtnXml) { 

           var xmlObj = $(rtnXml).find('item');
        	
        	var html = "";
			var hdColOrderArr = [];
			hdColOrderArr = hdColOrder.split(",");
        	
			xmlObj.each(function(){
				var brd_seq =  $(this).find("BRD_SEQ").text() 
				
				html += '<tr>';	
				html += '<td>'+ brd_seq+'</td>';
				for(var i in hdColOrderArr){
					if(i==0){
						html += '<td><a href="javascript:contentWndw(\'frm_id\',\''+frm_id+'\',\'detailBoard\',\''+brd_seq+'\' )">'+ $(this).find(hdColOrderArr[i]).text() +'</a></td>';
					} else {
						html += '<td>'+ $(this).find(hdColOrderArr[i]).text() +'</td>';
					}
				}
				html += '</tr>';	
			})  // xmlObj end
			location.remove;
			$('#bodyInfo').html(html);
		}
	})  //ajax end   
 		
 	});
	
	
	$('#insertWbBtn').click(function(){
			//새 화면 보낼때 frm_id는 보내야
			
			contentWndw("frm_id", frm_id, "registerBoard", brd_seq_last);
	});  // insertWbBtn end
	
	
	
})//function end

	
</script>
<%-- <script src="${ctxt}/resources/js/common/nbTable.js" ></script> --%>

<div id="container">

	<div id="divRefreshArea">
	<h2>게시판</h2>
	
			<select id="wbSelect" name="wbSelect" ></select>
			<input type="text" id="searchTxt" name="searchTxt" >
			<input type="button" id="searchWbBtn" name="searchWbBtn" value="검색">
			<table>

		      <colgroup>
		        <col style="width:5%" />
		        <col style="width:25%" />
		        <col style="width:10%">
		        <col style="width:10%">
		        <col style="width:10%">
		        <col style="width:10%">
		        <col style="width:10%">
		      </colgroup>
		      <thead id="headInfo">
		       
		      </thead>
				<tbody id ="bodyInfo">
									
				</tbody>
	      </table>
	     <div id="pagination" class="paginate"  style ="text-align: center;"></div>   
		<input type="button" id="insertWbBtn" name="insertWbBtn" value="등록">
	</div>
</div>	

