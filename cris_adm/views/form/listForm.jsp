<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@page import="kr.go.cris.ptl.mng.menu.vo.MngMenuVo"%>

<link href="${ctxt}/resources/css/tree/jquery.treeview.css" rel="stylesheet" type="text/css">
<link href="${ctxt}/resources/css/tree/code.css" rel="stylesheet" type="text/css">
<script type="text/javascript">

var elmnt_id_arr = [];
var check_frm_id="";

function fn_search(){
    $.ajax({
        url: '${ctxt}/mng/form/selectFormList.do',
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
					elmnt_id_arr.push($(this).find('elmnt_id').text());
					html += '<tr onclick="fn_setRow(this)">';  //?
					html += '  <td>'+($(this).index()+ 1)+'</td>';
					html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('elmnt_id').text()+'" onchange="fn_upd(this,7)" readonly="readonly" /></td>';            
			        html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('elmnt_nm').text()+'" onchange="fn_upd(this,7)" /></td>';   
			        html += '  <td><select>';
			        <c:forEach items="${data_type}" var="type" varStatus="">
			        html +='<option value="${type.cd}" '; if( '${type.cd}' == $(this).find('data_type').text()){ html +='selected' } html +='>${type.cd_nm}</option>';
					</c:forEach>      
					html += '  </select></td>';     
			        html += '  <td><select>';
			        <c:forEach items="${form_cd}" var="type" varStatus="">
			        html +='<option value="${type.cd}" '; if( '${type.cd}' == $(this).find('cd').text()){ html +='selected' } html +='>${type.cd_nm}</option>';
					</c:forEach>      
					html += '  </select></td>';     
					html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('lbl_kor').text()+'" onchange="fn_upd(this,7)" /></td>';            
			        html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('lbl_eng').text()+'" onchange="fn_upd(this,7)" /></td>';   
			       	html += '  <td style="display:none;">N</td>';  //?
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
 
 // sh_test
var frm_id ="";

function fn_search2(){
    $.ajax({
        url: '${ctxt}/mng/form/selectWrkFormList.do',
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
					frm_id = $(this).find('frm_id').text();
					
					html += '<tr onclick="">';
					html += '  <td onclick="fn_searchRow(this)">'+($(this).index()+ 1)+'</td>';
					html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('frm_id').text()+'" onchange="fn_upd(this,5)" readonly="readonly" /></td>';            
			        html += '  <td><select>';
			       			<c:forEach items="${form_type}" var="type" varStatus="">
			        html +='<option value="${type.cd}" '; if( '${type.cd}' == $(this).find('frm_gbn').text()){ html +='selected' } html +='>${type.cd_nm}</option>';
							</c:forEach>      
					html += '  </select></td>';     
					html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('frm_etc').text()+'" onchange="fn_upd(this,5)" /></td>';   
			        html += '  <td><select>';
			        		<c:forEach items="${use_yn}" var="type" varStatus="">
			        html +='<option value="${type.cd}" '; if( '${type.cd}' == $(this).find('cd').text()){ html +='selected' } html +='>${type.cd_nm}</option>';
							</c:forEach>      
					html += '  </select></td>';
			       	html += '  <td style="display:none;">N</td>'; 
					html += '</tr>';  
					 	
				});
				
				$('#dtlFrmList').html(html);
			}
        },
        error: function(x, o, e) {
	            var msg = "페이지 호출 중 에러 발생 \n" + x.status + " : " + o + " : " + e; 
	            fn_alert(msg); 
	    }            
    }); 
}

function fn_search3(){
    $.ajax({
        url: '${ctxt}/mng/form/selectWrkFormDtlList.do',
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
					html += '<tr onclick="">';
					html += '  <td>'+($(this).index()+ 1)+'</td>';
					html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('frm_id').text()+'" onchange="fn_upd(this,5)" readonly="readonly" /></td>';            
			        html += '  <td><select>';
			       			<c:forEach items="${form_type}" var="type" varStatus="">
			        html +='<option value="${type.cd}" '; if( '${type.cd}' == $(this).find('frm_gbn').text()){ html +='selected' } html +='>${type.cd_nm}</option>';
							</c:forEach>      
					html += '  </select></td>';     
					html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('frm_etc').text()+'" onchange="fn_upd(this,5)" /></td>';   
			        html += '  <td><select>';
			        		<c:forEach items="${use_yn}" var="type" varStatus="">
			        html +='<option value="${type.cd}" '; if( '${type.cd}' == $(this).find('cd').text()){ html +='selected' } html +='>${type.cd_nm}</option>';
							</c:forEach>      
					html += '  </select></td>';
			       	html += '  <td style="display:none;">N</td>'; 
					html += '</tr>';  
					 	
				});
				
				$('#dtlFrmList').html(html);
			}
			   

			
        },
        error: function(x, o, e) {
	            var msg = "페이지 호출 중 에러 발생 \n" + x.status + " : " + o + " : " + e; 
	            fn_alert(msg); 
	    }            
    }); 
}


//shsh2
function fn_searchRow(obj){

	var frm_id = $(obj).parent().find('td:eq(1) input[type=text]').val();
	check_frm_id = frm_id;
	
    $.ajax({
        url: '${ctxt}/mng/form/selectWrkFormDtlList.do',
        data : {"frm_id":frm_id},
        type: 'GET',  
        contentType: "text/xml;charset=utf-8",   
        dataType: 'text',
        success: function(rtnXml) {
        	var xmlObj = $(rtnXml).find('item');
        	var lst_yn = "";
        	var srch_yn = "";
			if(xmlObj.length > 0){
				var html="";
				var sel_opt="";
				xmlObj.each(function(){      
					
					lst_yn = $(this).find('lst_yn').text();
					srch_yn = $(this).find('srch_yn').text();
					
					html += '<tr onclick="">';
					html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('frm_id').text()+'" onchange="fn_upd(this,5)" readonly="readonly" /></td>';            
					html += '  <td>'+($(this).index()+ 1)+'</td>';
					 html += '  <td><select>';   
					var frm_elmnt_id =  $(this).find('frm_elmnt_id').text();
	        			$('#dtlCdList > tr').each(function(){  
			        html +='	<option value="'+$(this).find('td:eq(1) input[type=text]').val()+'" '; if( frm_elmnt_id == $(this).find('td:eq(1) input[type=text]').val()){ html +='selected' } html +='>'+$(this).find('td:eq(1) input[type=text]').val()+'</option>';
			        		});
					html += '  </select></td>';
					html += '  <td>'+$(this).find('frm_seq').text()+'</td>';            
					//html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('frm_ord').text()+'" onchange="fn_upd(this,5)" /></td>';   
					html += '  <td><input type="text" style="width:90%;" value="'+$(this).find('frm_col').text()+'" onchange="fn_upd(this,5)" /></td>';   
			        html += '  <td><select>';
	        				<c:forEach items="${use_yn}" var="type" varStatus="">
	        					html +='	<option value="${type.cd}" '; if( '${type.cd}' == $(this).find('cd').text()){ html +='selected' } html +='>${type.cd_nm}</option>';
							</c:forEach>
					html += '  </select></td>';
					html += '  <td><select name="test">';
						    <c:forEach items="${use_yn}" var="type" varStatus="">
						    html +='	<option value="${type.cd}" '; if( '${type.cd}' == lst_yn){ html +='selected' } html +='>${type.cd_nm}</option>';
							</c:forEach>
					html += '  </select></td>';
					html += '  <td><select name="selct_srch_yn">';
						    <c:forEach items="${use_yn}" var="type" varStatus="">
						    html +='	<option value="${type.cd}" '; if( '${type.cd}' == srch_yn){ html +='selected' } html +='>${type.cd_nm}</option>';
							</c:forEach>
					html += '  </select></td>';
			       	html += '  <td style="display:none;">N</td>'; 
					html += '</tr>';  
					
				});
				
				$('#dtlFrmDtlList').html(html);
				
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
		html += '  <td><input type="text" style="width:90%;" value="" onchange="fn_upd(this,7)" /></td>';            
        html += '  <td><input type="text" style="width:90%;" value="" onchange="fn_upd(this,7)" /></td>';   
        html += '  <td><select>';
        <c:forEach items="${data_type}" var="type" varStatus="">
       		html +='<option value="${type.cd}" >${type.cd_nm}</option>';
		</c:forEach>      
		html += '  </select></td>';     
        html += '  <td><select>';
        <c:forEach items="${form_cd}" var="type" varStatus="">
       		html +='<option value="${type.cd}" >${type.cd_nm}</option>';
		</c:forEach>      
		html += '  </select></td>';     
        html += '  <td><input type="text" style="width:90%;" value="" onchange="fn_upd(this,7)" /></td>';   
        html += '  <td><input type="text" style="width:90%;" value="" onchange="fn_upd(this,7)" /></td>';  
       	html += '  <td style="display:none;">I</td>'; 
		html += '</tr>';  
 	$('#dtlCdList:last').append(html);

 	$( '#sc' ).stop().animate( { scrollTop : $('#dtlCdList > tr').length * 30 } );
}

function fn_addFrm(){

	$('#dtlFrmList .on').attr('class','off');
	
	var html="";
   		html += '<tr class="on" onclick="fn_setRow(this)" >';     
   		html += '  <td>'+($('#dtlFrmList tr').length+ 1)+'</td>';
		html += '  <td><input type="text" style="width:90%;" value="" onchange="fn_upd(this,5)" /></td>';            
        html += '  <td><select>';
        <c:forEach items="${form_type}" var="type" varStatus="">
       		html +='<option value="${type.cd}" >${type.cd_nm}</option>';
		</c:forEach>      
		html += '  </select></td>';     
		html += '  <td><input type="text" style="width:90%;" value="" onchange="fn_upd(this,5)" /></td>';         
        html += '  <td><select>';
        <c:forEach items="${use_yn}" var="type" varStatus="">
	   		html +='<option value="${type.cd}" >${type.cd_nm}</option>';
		</c:forEach>   
		html += '  </select></td>';     
       	html += '  <td style="display:none;">I</td>'; 
		html += '</tr>';        
 	$('#dtlFrmList:last').append(html);

 	$( '#sc' ).stop().animate( { scrollTop : $('#dtlFrmList > tr').length * 30 } );
}


//shsh   
function fn_addFrmDtl(type){
	
	if(check_frm_id=="" || check_frm_id==null){
		alert(" 폼id의 순번을 눌러주세요. ")
	} else {

		$('#dtlFrmDtlList.on').attr('class','off');
	
		var html="";
		html +='<tr class="on" onclick="fn_setRow(this)" >';
		
		html +='<td>'+check_frm_id+'</td>';
		html +=' <td>' + ($('#dtlFrmDtlList tr').length+ 1)+'</td>';
		html += '<td><select>';
		elmnt_id_arr.forEach(function(element){
			html +='<option value='+element+'>'+element+'</option>';
		})
		html += '</select></td>';
		html += '<td><input type="text" style="width:70%;" onchange="fn_upd(this,8)" name="tt" required="required" /></td>';
		html += '<td><input type="text" style="width:70%;" onchange="fn_upd(this,8)" name="tt" required="required" /></td>';
		html += '  <td><select>';
	    <c:forEach items="${use_yn}" var="type" varStatus="">
	   		html +='<option value="${type.cd}" >${type.cd_nm}</option>';
		</c:forEach>
		html += '  </select></td>';
		html += '  <td><select>';
	    <c:forEach items="${use_yn}" var="type" varStatus="">
	   		html +='<option value="${type.cd}" >${type.cd_nm}</option>';
		</c:forEach>
		html += '  </select></td>';
		html += '  <td><select>';
	    <c:forEach items="${use_yn}" var="type" varStatus="">
	   		html +='<option value="${type.cd}" >${type.cd_nm}</option>';
		</c:forEach>
		html += '  </select></td>';
		html += '  <td style="display:none;">I</td>'; 
		html += '</tr>';
		
	//	dtlFrmDtlList	
		$('#dtlFrmDtlList:last').append(html);
	}//else end
}

/*
* shsh_del 상세코드 추가 취소
*/
function fn_delFrmDtl(type){
	var delRow = $('#dtlFrmDtlList .on');
	if(delRow.length == 0){
		fn_alert("선택로우가 없습니다.","c");
	}
	alert($(delRow).find('td:eq(8)').text())
 	if(type != "D"){
 		
		if($(delRow).find('td:eq(8)').text() != 'I'){
			fn_alert('취소 대상이 아닙니다.','c');
			return false;
		}
	} 
	//선택로우 삭제	
	$(delRow).remove();

 	if($('#dtlFrmDtlList tr').length > 0){
 		$('#dtlFrmDtlList .on').attr('class','off');
 		$('#dtlFrmDtlList tr:last').attr('class','on');	
 	}
}

/*
* 상세코드 삭제
*/
function fn_delFrm(type){
	var delRow = $('#dtlFrmList .on');
	if(delRow.length == 0){
		fn_alert("선택로우가 없습니다.","c");
	}
	
	if(type != "D"){
		
		if($(delRow).find('td:eq(5)').text() != 'I'){
			fn_alert('취소 대상이 아닙니다.','c');
			return false;
		}
	}
	//선택로우 삭제	
	$(delRow).remove();

 	if($('#dtlFrmList tr').length > 0){
 		$('#dtlFrmList .on').attr('class','off');
 		$('#dtlFrmList tr:last').attr('class','on');	
 	}
 	
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
		if($(delRow).find('td:eq(7)').text() != 'I'){
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
	fn_search2();
});

</script>


<div id="container" style="min-height: 600px;">

	<div id="divRefreshArea">
	<h2>Form 관리</h2>
		<button class="addItemBtn" name="add_btn" onclick="fn_addDtl()" >추가</button>   
		<button class="addItemBtn" name="cal_btn" onclick="fn_delDtl('T')" >취소</button>  
		<div style="float: right;" >
			<button class="addItemBtn" name="save_btn" onclick="fn_saveForm()" >저장</button>
		</div>
		<form action="" name="etl_form">
	     	<table id="example0" class="tbl_type" > 
	        	<colgroup>
		           	<col width="5%" />
		            <col width="10%" />
		           	<col width="15%" />   
		           	<col width="15%" />
		           	<col width="20%" />
		           	<col width="20%" />
		           </colgroup> 
		           <thead>    
		         	<tr>            
		         		<th>순번</th>    
		         		<th>엘리멘트id</th>    
			            <th>엘리멘트명</th>    
			            <th>data_type</th>            
			            <th>cd</th>                    
			            <th>lbl_kor</th>     
			            <th>lbl_eng</th>              
		        	 </tr>        
		       	</thead>
		       	<tbody id="dtlCdList">       
		        </tbody>
	     	</table>		
     	</form>
	</div>
	<br />
	<br />
	<div>
		<div style="float: left;width: 45%;">
			<button class="addItemBtn" name="add_btn" onclick="fn_addFrm()" >추가</button>   
		<button class="addItemBtn" name="cal_btn" onclick="fn_delFrm('T')" >취소</button>  
		<div style="float: right;" >
			<button class="addItemBtn" name="save_btn" onclick="fn_saveWrkForm()" >저장</button>
		</div>
			<form action="" name="etl_form">
		     	<table id="example0" class="tbl_type" > 
		        	<colgroup>
			           	<col width="5%" />
			            <col width="10%" />
			           	<col width="15%" />   
			           	<col width="15%" />
			           	<col width="15%" />
			           </colgroup> 
			           <thead>    
			         	<tr>            
			         		<th>순번</th>    
			         		<th>폼id</th>    
				            <th>폼구분</th>    
				            <th>폼설명</th>            
				            <th>사용여부</th>                           
			        	 </tr>        
			       	</thead>
			       	<tbody id="dtlFrmList">       
			        </tbody>
		     	</table>		
	     	</form>
		</div>
		
		<div style="float: left;width: 45%;margin-left: 3%;">
			<button class="addItemBtn" name="add_btn" onclick="fn_addFrmDtl()" >추가</button>   
		<button class="addItemBtn" name="cal_btn" onclick="fn_delFrmDtl('T')" >취소</button>  
		<div style="float: right;" >
			<button class="addItemBtn" name="save_btn" onclick="fn_saveSubWrkForm()" >저장</button>
		</div>
			<form action="" name="etl_form">
		     	<table id="example0" class="tbl_type" > 
		        	<colgroup>
			           	<col width="5%" />
			            <col width="10%" />
			           	<col width="15%" />   
			           	<col width="15%" />
			           	<col width="15%" />
			           </colgroup> 
			           <thead>    
			         	<tr>            
			         		<th>폼id</th>    
			         		<th>순번</th>    
				            <th>엘리멘트id</th>    
				            <th>순서</th>            
				            <th>col</th>            
				            <th>사용여부</th>
				            <th>리스트여부</th>
				            <th>조회조건</th>
			        	 </tr>        
			       	</thead>
			       	<tbody id="dtlFrmDtlList">       
			        </tbody>
		     	</table>		
	     	</form>
		</div>
	</div>
</div>	

