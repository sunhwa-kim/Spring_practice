<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@page import="kr.go.cris.ptl.mng.menu.vo.MngMenuVo"%>

<link href="${ctxt}/resources/css/tree/jquery.treeview.css" rel="stylesheet" type="text/css">
<link href="${ctxt}/resources/css/tree/code.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
var theNBofRows = 0;
var theNBofPartRows = 20;
var selectedPg = 0;
var pileofFigures = 0;

$(function(){
	
	$.ajax({
		url : ctxt+'/board/columnAbbreviation/colAbbrevtView.do',
		type :'POST',
		async : false,
		success : function(res){
			theNBofRows =  res.idx;
			
			var currentUrl  = $(location).attr('href');
			var startFor = 0;
			if(currentUrl.includes("pg")){
				
				var currentPg = 0;
				currentPg = fn_getUrlParam(currentUrl,0,1);
				
				startFor = (currentPg-1)*theNBofPartRows+1;
				forIdx =  (currentPg)*theNBofPartRows+1;
				
				pileofFigures += (currentPg)*theNBofPartRows;
				
				if(pileofFigures>theNBofRows){
					forIdx =  ((currentPg-1)*theNBofPartRows)+theNBofRows-((currentPg-1)*theNBofPartRows);
				}
				
				$('#selectedPgInfo').attr('value',currentPg);
				selectedPg = $('#selectedPgInfo').val();
			} else {
				$('#divPgList').css('display','none');
				$('#changePgBtn').attr({'value':'분할 하기','style':'margin-left:50%;'});
				startFor = 1;
				forIdx = theNBofRows;
			}
			
			var html = "";
			for(var i=startFor ; i<forIdx ;i++){
				html += "<tr>";
				html += "<td>"+i+"</td>";
				html += "<td>"+res.colOrgnArr[i]+"</td>";
				html += "<td>"+res.colAbbrvt[i]+"</td>";
				html += '<td><div class="showText"><input type="text" class="ipModify"></div></td>';
				html += "</tr>";
			}
			$('#colList').html(html); 
		}
	});  //  the end of a ajax
	
	$('.showText').css('display','none');
	var pgCnt =0 ;
	if(selectedPg !=0){
		$('#divPgList').css('display','inline');
		fn_makePgList(Number(theNBofRows), Number(selectedPg));
		$('#changePgBtn').attr({'value':'한 화면에 보기','style':'margin-left:auto;' });
		pgCnt++;
	}	
	
	$('#changePgBtn').click(function(){
		if(pgCnt==0){
			$('#selectedPgInfo').attr('value',1);
			$('#divPgList').css('display','inline');
			fn_makePgList(Number(theNBofRows),1);
			changeUrl(1)
		} else {
			$('#divPgList').css('display','none');
			changeUrl("Y")
		}
	}) // the end of a button
	
	var modifyCtn = 0;
	$('#modifyBtn').click(function(){
		$('.showText').css('display','');
		$('#modifyBtn').attr('value','입력');
//alert($(this).parents('tr').find(":input").val())
	});
	
});   //  the end of a function

function fn_makePgList(theNumberOfRows, currentPg){
	var pgList = Math.ceil(theNumberOfRows/theNBofPartRows);
	var html = "";
	for(i=0 ; i<pgList ; i++){
		var pgNb = i+1;
		html += "<input type=\"radio\" id=\"pg"+pgNb+"\" name=\"pgBtn\" value=\"pg"+pgNb+"\" onclick=\"changeUrl("+pgNb+")\"";
			if(currentPg == pgNb) html+="checked";
		html +=">";		
	}
	$('#divPgList').html(html);
};

function changeUrl(pgNmbr){
	var beforeUrl = $(location).attr('href');
	
	var urlIdx = beforeUrl.indexOf("?",1);
	beforeUrl = beforeUrl.replace(beforeUrl.substring(urlIdx),"");
	if(pgNmbr != "Y"){
		var url = beforeUrl+"?pg="+pgNmbr;
		location.replace(url);
	} else {
		location.replace(beforeUrl);
	}
};

function fn_getUrlParam(url, arrIdx, strIdx){
	arrIdx = Number(arrIdx);
	strIdx = Number(strIdx);
	
	var ipArr = [];
	var resultStr = "";
	ipArr = url.split("&");
	
	var tmpStr = ipArr[arrIdx].toString();
	ipArr = tmpStr.split("=");
	
	resultStr = ipArr[strIdx].toString();
	return resultStr;
}
</script>


<div id="container" style="min-height: 600px;">

	<div id="divRefreshArea">
			<h2 style="margin-left: 10%;">약어 목록</h2>
     	<div id="divPgList" style="margin-left: 45%;"></div>
		<input type="button" id="changePgBtn" name="changePgBtn" value="" >
		<input type="button" id="modifyBtn" name="modifyBtn" value="수정요청" >
		<input type="hidden" id="selectedPgInfo" name="selectedPgInfo" value="">
		
		<form action="" name="etl_form">
	     	<table id="example0" class="tbl_type"  style="width:50%;margin-left: 10%;"> 
	        	<colgroup>
		           	<col width="8%" />
		           	<col width="21%" />
		            <col width="21%" />
	           </colgroup> 
		           <thead>    
		         	<tr>            
		         		<th>번호</th>    
		         		<th>원래 컬럼명</th>    
			            <th>약어</th>    
		        	 </tr>        
		       	</thead>
		       	<tbody id="colList" >       
		        </tbody>		        
	     	</table>		
     	</form>
	</div>