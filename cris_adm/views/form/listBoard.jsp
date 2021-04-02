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
	var frm_id = '${frm_id}';
	var pgList = '${pgList}'
	var linesPerPg = '${linesPerPg}';
	var last_brd = '${last_brd}';
	var columnList = [];
	var keyOfArr = [];
	var valueOfArr = [];
	var type_s_col = [];
	var currPg= '${currPg}';
	
$(function(){
	
	var param = {};
	param.frm_id = frm_id;
	
	$.ajax({
		url : ctxt + '/mng/form/selectTheadBoard.do',
		data : param,
		type : 'POST',
		async: false,  //ajax 한 function에 여러개 호출시 추가!
		success:function(res){
			
			var optList = "";
			var html = "";			
			// 마지막은 data_typ =S인 컬럼목록(그 앞은 컬럼정보!), 뒤에서 두번째는 data_type
			var resSecFromBack= res.length -2;  
			var resTheBackmost = res.length -1;
/* 		
			var str = JSON.stringify(res[resSecFromBack]);
			console.log(str)
*/
			valueOfArr = res[resSecFromBack];
			keyOfArr = Object.keys(res[resSecFromBack]);
		
			var str = res[resTheBackmost].type_s_col;
			type_s_col = str.split(",");		
			
			for(var i=0 ; i<resSecFromBack ; i++){
				var checkYn = res[i].srch_yn;
				if(checkYn=="Y"){
					optList += '<option value="'+res[i].frm_col+'">'+res[i].lbl_kor+'</option>'
				}
				
				var columnName = res[i].frm_col;
				colUpper = columnName.toUpperCase();
				columnList.push(colUpper)
			}
			
			$('#wbSelect').append(optList)
				
				html += "<tr>";
				html += "<th>번호</th>"
			for(var i=0 ; i<resSecFromBack ; i++){
				html += "<th>"+res[i].lbl_kor+"</th>"
			}
				html += "</tr>";
			$('#headInfo').html(html);	
		}
	});  //  end of ajax  .1st

	fn_makePg(pgList,currPg);
	
	
	$('#searchWbBtn').click(function(){
		var paramObject = new Object();
		paramObject['col'] = $('#wbSelect option:selected').val();
		paramObject['input'] = $('#searchTxt').val();
		
		fn_makePg(pgList, currPg,paramObject);
	});
	
	$('#insertWbBtn').click(function(){
		var lastBrd_Seq = Number(last_brd)+1;
		currPg = $('#clickedPg').val();
		contentWndw('frm_id',frm_id,'lastBrd_Seq',lastBrd_Seq,'pg',currPg);
	});
//	alert($('#bodyInfo').find('tr:last').find('td').eq(0).text())
	
})


function fn_makePg(pgList, currPg, searchBtn){
	if(currPg==0){
		currPg=1
	}
	var params = {};
	params.frm_id = frm_id;
	params.currPg = currPg;
	params.linesPerPg = linesPerPg;
	
	if(jQuery.isEmptyObject(searchBtn)==false){
		for(var key in searchBtn){
			if(key=='col') params.srchColumnStr = searchBtn[key];
			if(key=='input') params.srchTxt = searchBtn[key];
		}
		
		$('#pagination').css('display','none');
	};
	
	$.ajax({
		url : ctxt + '/mng/form/selectTbodyBoard.do',
		dataType: 'text',
		data : params,
		type : 'POST',
		async : false,
		success : function(resXml){
			
		var xmlObj = $(resXml).find('item');
		var html = "";
		var idx = 0;
		xmlObj.each(function(){
			var brd_seq = $(this).find('BRD_SEQ').text();
			html += '<tr>';
			html += '<td>'+brd_seq+'</td>';
			for(var i in columnList){
				
				var data = $(this).find(columnList[i]).text();
				
				for(var k in type_s_col){
					if("COL1"==columnList[i]){
						html += '<td><a href="javascript:contentWndw(\'frm_id\',\''+frm_id+'\',\'no\',\''+brd_seq+'\',\'pg\',\''+currPg+'\')">'+data+'</a></td>';
					} else {
						if(type_s_col[k]==columnList[i]){
							for(var j=0 ; j<keyOfArr.length; j++){
								var test = keyOfArr[j];
								if(data == test){
									html += '<td>'+valueOfArr[keyOfArr[j]]+'</td>';
								} 
							}
						} else {
								html += '<td>'+data+'</td>';
						}
					}  // end of the "COL1" else sentence
				}
			}
			html += '</tr>';
		})
			$('#bodyInfo').html(html);
		}
	})  // end of ajax .2nd
	
	var pg_html = "";
		pg_html += '<a class="pgList" id=\"'+clickPg+'\"       href="javascript:void(0);" onclick="location.reload();return false" target="_self"><<</a>';
	for(var i=0; i<pgList; i++){
		var clickPg = i+1;
		pg_html += '<a class="pgList" id=\"'+clickPg+'\"       href=\"javascript:fn_makePg('+pgList+','+clickPg+')\" target="_self">'+clickPg+'</a>';
//		pg_html += '<a class="pgList" href="javascript:void(0);" onclick=\"fn_makePg('+pgList+','+clickPg+'); return false;\" target="_self">'+clickPg+'</a>';
	}
	pg_html += '<a class="pgList" id=\"'+clickPg+'\"       href=\"javascript:fn_makePg('+pgList+','+pgList+')\" target="_self">>></a>';
	$('#pagination').html(pg_html);
	
	$('.pgList').click(function(){
		var clickedPg = $(this).attr('id');
		$('#clickedPg').attr('value',clickedPg);
	})
};	//  end of fn  


function contentWndw(paramNm01, param01, paramNm02, param02, paramNm03, param03){
	//alert($(location).attr('href')) //현재 url 받기
	var url = ""
	url = (ctxt+"/board/writeBoard.do"+"?"+paramNm01+"="+param01+"&"+paramNm02+"="+param02+"&"+paramNm03+"="+param03)
	var wdwObj  = window.open(url, "_self")
	
} // contentWndw end



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
	     <div id="pagination" class=""  style ="text-align: center; letter-spacing: 15px;"></div>   
		<input type="button" id="insertWbBtn" name="insertWbBtn" value="등록">&nbsp;
		
		<input type="hidden" id="clickedPg" name="clickedPg" value="">
		
	</div>
</div>	