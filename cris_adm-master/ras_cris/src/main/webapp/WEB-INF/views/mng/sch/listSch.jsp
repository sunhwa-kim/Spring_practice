<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@page import="kr.go.cris.ptl.mng.menu.vo.MngMenuVo"%>

<link href="${ctxt}/resources/css/tree/jquery.treeview.css" rel="stylesheet" type="text/css">
<link href="${ctxt}/resources/css/tree/code.css" rel="stylesheet" type="text/css">
<script type="text/javascript">

	
function fn_search(){
    $.ajax({
        url: '${ctxt}/mng/sch/selectEtlList.do',
        data : "",
        type: 'GET',
        contentType: "text/xml;charset=utf-8",
        dataType: 'text',
        success: function(rtnXml) {
        	var xmlObj = $(rtnXml).find('item');
			if(xmlObj.length > 0){
				var html="";
				var sel_opt="";
				xmlObj.each(function(){   
					html += '<tr onclick="fn_setRow(this)">';
					html += '  <td>'+$(this).find('etl_sn').text()+'</td>';
					html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('etl_id').text()+'" onchange="fn_upd(this,11)" readonly="readonly" /></td>';            
			        html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('etl_nm').text()+'" onchange="fn_upd(this,11)" /></td>';   
			        html += '  <td><select>';
			        <c:forEach items="${etl_type}" var="type" varStatus="">
			       		html +='<option value="${type.cd}" '; if(${type.cd} == $(this).find('etl_type').text()){ html +='selected' } html +='>${type.cd_nm}</option>';
					</c:forEach>      
					html += '  </select></td>';     
			       
			        html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('etl_tb').text()+'" onchange="fn_upd(this,11)" /></td>';   
			        html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('etl_gbn').text()+'" onchange="fn_upd(this,11)" /></td>';  
			        html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('etl_time').text()+'" onchange="fn_upd(this,11)" /></td>';
			        html += '  <td><select>';
			       	for(var i=1; i <= 24; i++){
		       		html +='<option value="'+i+'" '; if(i == $(this).find('etl_hh').text()){ html +='selected' } html +='>'+i+'</option>';
			       	}      
			       	html += '  </select></td>'; 
			        html += '  <td><select>';
			       	for(var i=0; i <= 59; i++){
		       		html +='<option value="'+i+'" '; if(i == $(this).find('etl_ss').text()){ html +='selected' } html +='>'+i+'</option>';
			       	}      
			       	html += '  </select></td>'; 
			        html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('next_dt').text()+'" readonly /></td>';  
			        html += '  <td><select>';  
		       		html +='<option value="Y" '; if('Y' == $(this).find('use_yn').text()){ html +='selected' } html +='>Y</option>';
		       		html +='<option value="N" '; if('N' == $(this).find('use_yn').text()){ html +='selected' } html +='>N</option>';
			       	html += '  </select></td>';    
			       	html += '  <td style="display:none;">N</td>'; 
					html += '</tr>';  
				});
				
				$('#dtlCdList').html(html);
			}
			   

        },
        error: function(x, o, e) {
	            var msg = "페이지 호출 중 에러 발생 \n" + x.status + " : " + o + " : " + e; 
	            fn_alert(msg); 
	    }            
    }); 
}

function fn_addDtl(){

	$('#dtlCdList .on').attr('class','off');
	
	var html="";
   		html += '<tr class="on" onclick="fn_setRow(this)" >';         
		html += '  <td>'+($('#dtlCdList tr').length+ 1)+'</td>';
		html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('etl_id').text()+'" onchange="fn_upd(this,11)" /></td>';            
        html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('etl_nm').text()+'" onchange="fn_upd(this,11)" /></td>';   
        html += '  <td><select>';
        <c:forEach items="${etl_type}" var="type" varStatus="">
       		html +='<option value="${type.cd}" >${type.cd_nm}</option>';
		</c:forEach>      
		html += '  </select></td>';     
        html += '  <td><input type="text" style="width:90%;" value="" onchange="fn_upd(this,11)" /></td>';   
        html += '  <td><input type="text" style="width:90%;" value="" onchange="fn_upd(this,11)" /></td>';  
        html += '  <td><input type="text" style="width:90%;" value="" onchange="fn_upd(this,11)" /></td>';
        html += '  <td><select>';
       	for(var i=1; i <= 24; i++){
   		html +='<option value="'+i+'" >'+i+'</option>';
       	}      
       	html += '  </select></td>'; 
        html += '  <td><select>';
       	for(var i=0; i <= 59; i++){
   		html +='<option value="'+i+'" >'+i+'</option>';
       	}      
       	html += '  </select></td>'; 
        html += '  <td><input type="text" style="width:90%;" value="" readonly /></td>';  
        html += '  <td><select>';  
   		html +='<option value="Y" >Y</option>';
   		html +='<option value="N" >N</option>';
       	html += '  </select></td>';    
       	html += '  <td style="display:none;">I</td>'; 
		html += '</tr>';  
 	$('#dtlCdList:last').append(html);

 	$( '#sc' ).stop().animate( { scrollTop : $('#dtlCdList > tr').length * 30 } );
}

/*
* 상세코드 삭제
*/
function fn_delDtl(type){
	var delRow = $('#dtlCdList .on');
	if(delRow.length == 0){
		fn_alert("선택로우가 없습니다.","c");
	}
	
	if(type != "D"){
		if($(delRow).find('td:eq(11)').text() != 'I'){
			fn_alert('취소 대상이 아닙니다.','c');
			return false;
		}
	}
	//선택로우 삭제	
	$(delRow).remove();
	

 	if($('#dtlCdList tr').length > 0){
 		$('#dtlCdList .on').attr('class','off');
 		$('#dtlCdList tr:last').attr('class','on');	
 	}
 	
}

$(function(){
	fn_search();
});

</script>
<script src="${ctxt}/resources/js/common/write.js" ></script>

<div id="container">

	<div id="divRefreshArea">
	<h2>스켸줄러 관리</h2>
		<button class="addItemBtn" name="add_btn" onclick="fn_addDtl()" >추가</button>   
		<button class="addItemBtn" name="cal_btn" onclick="fn_delDtl('T')" >취소</button>  
		<div style="float: right;" >
			<button class="addItemBtn" name="save_btn" onclick="fn_saveSch()" >저장</button>
		</div>
		<form action="" name="etl_form">
	     	<table id="example0" class="tbl_type" > 
	        	<colgroup>
		           	<col width="9%" />
		            <col width="9%" />
		           	<col width="9%" />   
		           	<col width="9%" />
		           	<col width="9%" />
		           	<col width="9%" />
		           	<col width="9%" />
		           	<col width="9%" />
		           	<col width="9%" />
		           	<col width="9%" />
		           	<col width="9%" />
		           </colgroup> 
		           <thead>    
		         	<tr>            
		         		<th>순번</th>    
			            <th>ID</th>    
			            <th>ETL명</th>            
			            <th>타입</th>                    
			            <th>타겟테이블</th>    
			            <th>구분</th>     
			            <th>시간</th>           
			            <th>시간</th>        
			            <th>분</th>        
			            <th>다음실행</th>        
			            <th>사용여부</th>        
		        	 </tr>        
		       	</thead>
		       	<tbody id="dtlCdList">       
		        </tbody>
	     	</table>		
     	</form>
	</div>
</div>	

