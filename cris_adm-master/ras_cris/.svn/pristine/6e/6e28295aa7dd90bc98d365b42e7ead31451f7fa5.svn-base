<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<link href="${ctxt}/resources/css/tree/jquery.treeview.css" rel="stylesheet" type="text/css">
<link href="${ctxt}/resources/css/tree/code.css" rel="stylesheet" type="text/css">
<script type="text/javascript">

//dtree, 현재 선택 메뉴, 현재 선택 레벨
var m = new dTree('m'),
	curr_menu = "",
	curr_menu_lv = "";

$(function(){

	//메뉴트리시작
	m.add(0,-1,'메뉴 목록',"javascript:fn_setMenu('','','','','','','N','N','N','sm0')","top","top");

	//메뉴트리생성
	createMenu();

	//메뉴추가
	$('#add_btn').click(function(){
		fn_addMenu();
	});
	//메뉴추가
	$('#del_btn').click(function(){
		fn_delMenu();
	});
	
	//메뉴정보 변경
	$('.table-c').change(function(){
		if($('#save_type').val() != 'I' ){
			$('#save_type').val('U');
		}
	});
	//메뉴정보 변경
	$('input[type=checkbox]').change(function(){
		$('#rol_save_yn').val('U');
	});
	
});

//권한 체크 이벤트 
function fn_chk(name,val){

	$('input[name='+ name +'][value='+ val +']').click();
}

/**
 * 	메뉴 트리 생성
 */
function createMenu(){
	
	var procFn ="";

	$.ajax({
		    url : '${ctxt}/mng/menu/readMenuList.do',
		    data : {},   //전송파라미터
		    contentType: 'text/xml;charset=utf-8',   //서버로 데이터를 보낼 때 사용.
		    type : 'POST',
		    dataType : 'text',   //xml, html, script, json, jsonp, text
		    success : function(result) {
		           	var xmlObj = $(result);
		           	var sel_menu_id="";
		           	xmlObj.find('item').each(function(cnt){
		           			           		
		           		var obj = new Array();
		           		var menu_id = $(this).find('menu_id').text();
		           		var menu_nm = $(this).find('menu_nm').text();
		           		var menu_levl = $(this).find('menu_levl').text();
		           		var menu_prts_id = $(this).find('menu_prts_id').text();
		           		var menu_ord = $(this).find('menu_ord').text();
		           		var menu_eng_nm = $(this).find('menu_eng_nm').text();
		           		var top_menu_yn = $(this).find('top_menu_yn').text();
		           		var left_menu_yn = $(this).find('left_menu_yn').text();
		           		var menu_use_yn = $(this).find('menu_use_yn').text();
		         
		           		var strFn = "fn_setMenu(";
		           			strFn += "'"+menu_id+"',";
		           			strFn += "'"+menu_nm+"',";
		           			strFn += "'"+menu_levl+"',";
		           			strFn += "'"+menu_prts_id+"',";
		           			strFn += "'"+menu_ord+"',";
		           			strFn += "'"+menu_eng_nm+"',";
		           			strFn += "'"+top_menu_yn+"',";
		           			strFn += "'"+left_menu_yn+"',";
		           			strFn += "'"+menu_use_yn+"',";
		           			strFn += "'sm"+Number(cnt+1) +"')";
		         		m.add(cnt+1, menu_levl , menu_nm,  "javascript:"+strFn, menu_id, menu_prts_id);	
		         		
		         		if(cnt == 0){
			           		if($('#sel_menu_id').val() != ""){
			           			sel_menu_id = $('#sel_menu_id').val();
			           		}else{
			           			sel_menu_id = menu_id;
			           		}	
		         		}
		         		if(procFn == ""){
			         		if(sel_menu_id == menu_id){
			         			curr_menu = menu_id;
			         			curr_menu_lv = menu_levl;
			         			procFn = strFn;
			         		}
		         		}
		           	});
		           	var df = $('#dtreeDiv1').html(m.toString());

		    },
		    error : function() { // Ajax 전송 에러 발생시 실행
		           fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
		    },
		    complete : function(result) { // success, error 실행 후 최종적으로 실행
		    	if(procFn != ""){
		    		eval(procFn);
		    	}
		    }
	});
	
}
/**
 * 	메뉴 클릭 이벤트
 */
function fn_setMenu(){
	//저장하지 않고 이동하는 경우 확인창 
	if($('#save_type').val() == 'I' || $('#save_type').val() == 'U'
			|| $('#rol_save_yn').val() == 'I' || $('#rol_save_yn').val() == 'U' ){
		var strConfirm = confirm("저장하지 않은 정보가 있습니다.이동하시겠습니까?");
		if(!strConfirm){
			return;
		}
	}

	var sel_id =arguments[9];
	//선택트리 색변경
	$('.dTreeNode > a').attr('style','');
	$('#'+sel_id+'').attr('style','color:red');
	//전체 체크박스 해제
	$('input[type=checkbox]').prop('checked',false);
	
	$('#save_type').val('N');
	$('#menu_id').val(arguments[0]);
	$('#menu_id').prop('readonly','readonly');
	$('#menu_nm').val(arguments[1]);
	$('#menu_levl').val(arguments[2]);
	if(arguments[3] == '0'){
		$('#menu_prts_id').val('');
	}else{
		$('#menu_prts_id').val(arguments[3]);
	}
	$('#menu_ord').val(arguments[4]);
	$('#menu_eng_nm').val(arguments[5]);
	$('input[name=top_menu_yn][value='+arguments[6]+']').prop('checked',true);
	$('input[name=left_menu_yn][value='+arguments[7]+']').prop('checked',true);
	$('input[name=menu_use_yn][value='+arguments[8]+']').prop('checked',true);
	curr_menu = arguments[0];
	curr_menu_lv = arguments[2];
	
	//코드 참조값1에서 보여주고 싶은 화면만 보이기 처리
	//$('#auth_list > tr[name!=""]').attr('style','display:none;');
	if(arguments[0] != ''){
		$('#auth_list > tr').attr('style','');
		
		$('#auth_list > tr').each(function(cnt){
			
			if($(this).attr('name') != ''){
				
				   
				var apply_menu = $(this).attr('name').split("|");
				
				for(var i = 0 ; i < apply_menu.length;i++){
					if(apply_menu[i] == curr_menu){	
						$(this).attr('style','');
						break;
					}else{
						$(this).attr('style','display:none;');
					}	
				} 
				
				
			}else{
				$(this).attr('style','');
			}
		});
		
	}
	//메뉴권한 불러오기
	if(arguments[0] != ''){
		fn_readMenuRol(arguments[0]);
	}
}

function fn_readMenuRol(str_menu_id){
	
	$.ajax({
	    url : '${ctxt}/mng/menu/readMenuRolList.do',
	    data : {"menu_id":str_menu_id},   //전송파라미터
	    contentType: 'text/xml;charset=utf-8',   //서버로 데이터를 보낼 때 사용.
	    type : 'GET',
	    dataType : 'text',
	    success : function(result) {
	           	var xmlObj = $(result);
	           	var sel_menu_id="";
	           	xmlObj.find('item').each(function(cnt){
	           			           		
	           		var obj = new Array();
	           		var auth_gbn = $(this).find('AUTH_GBN').text();
	           		var rol_id = $(this).find('ROL_ID').text();
					//선택 체크박스 체크
	           		$('input[name='+auth_gbn+'][value='+rol_id+']').prop('checked',true);
	           	});
	           	//$('input[type=checkbox][value=ROLE_ADMIN]').prop('checked',true);
	    },
	    error : function() { // Ajax 전송 에러 발생시 실행
	           fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
	    },
	    complete : function(result) { // success, error 실행 후 최종적으로 실행
	    }
	});
}

// 메뉴 id 중복체크 
function fn_MenuDupl_chk(param_id){
	var menu_id = $(param_id).val();
	
	if( menu_id == '' || menu_id == undefined){
		
		return;
	}
	
	if($("#save_type").val() != "I"){
		
		return;
	}
	
	$.ajax({
	    url : '${ctxt}/mng/menu/duplChkMenuList.do',
	    data : {"menu_id": menu_id},   //전송파라미터
	    contentType: 'text/xml;charset=utf-8',   //서버로 데이터를 보낼 때 사용.
	    type : 'GET',
	    dataType : 'text',
	    success : function(result) {
	    	var rltObj = $(result);

           if(rltObj.find("item").length > 0 ){  // 중복된 id가 존재하면 '1' 일테니 .. 
        	    var kor_levl = ''; 
        	    var menu_levl =  rltObj.find("item").find("menu_levl").text();    
           		
        	    if (menu_levl == 1 ){
					kor_levl = '하위메뉴 ID';          			           			
           		}else if(menu_levl == 0){
           			kor_levl = '상위메뉴 ID';
           		}
        	    
        		fn_alert(kor_levl+ "값 중에 중복된 ID가 존재합니다.");
        		$(param_id).val('');
        		$(param_id).focus();
           }
  
	    },
	    error : function() { // Ajax 전송 에러 발생시 실행
	           fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
	    },
	    complete : function(result) { // success, error 실행 후 최종적으로 실행
	    	
	    }
	});
	
}

/**
 * 	메뉴 저장
 */
function fn_save(){
	var colList = ["menu_id","menu_nm","menu_ord"];
	var nmList = ["메뉴ID","메뉴명","메뉴순서"];
	if(checkVal(colList,nmList)){
		return;	
	}

	var rol_list= new Array();
	
	$('#auth_list tr td > input[type=checkbox]').each(function(){
		var trObj = $(this);
		//데이터 조작이 없는 경우 처리안함
		if(trObj.is(':checked')){
			rol_list.push(trObj.attr('name')+"|"+trObj.val());
		}		
	});
	
	$('#menu_rol_list').val(rol_list);
	
	var strConfirm = confirm("저장하시겠습니까?");
	

	if(strConfirm){
		var form = document.menu_form;
		form.action="${ctxt}/mng/menu/saveMenu.do";
		form.submit();	
	}	
}

/**
 * 	메뉴 추가
 */
function fn_addMenu(){
	
	$("#menu_form")[0].reset();  

	$('#save_type').val('I');
	$('#menu_id').prop('readonly','');
	$('input[name=top_menu_yn][value=Y]').prop('checked',true);
	$('input[name=left_menu_yn][value=Y]').prop('checked',true);
	$('input[name=menu_use_yn][value=Y]').prop('checked',true);
	$('#menu_prts_id').val(curr_menu);
	
	if(curr_menu_lv == ""){
		$('#menu_levl').val('0');
	}else{
		$('#menu_levl').val(Number(curr_menu_lv)+1);
	}
}

/**
 * 메뉴 삭제
 */
function fn_delMenu(){
	if( $('#menu_id').val() == '' && $('#menu_prts_id').val() == '' ){
		fn_alert("메뉴정보가 없습니다.",'c');
		return;
	}
	var strConfirm = confirm($('#menu_nm').val() +"를 삭제하시겠습니까?\n(하위메뉴도 같이 삭제됩니다.)");

	if(strConfirm){
		var form = document.menu_form;
		form.action="${ctxt}/mng/menu/delMenu.do";
		form.submit();	
	}
}

</script>


<div id="container">

			<div id="divRefreshArea">
			<h2>메뉴관리</h2>
			
			<input type="hidden" id="sel_menu_id" value="${sel_menu_id}" />

    			<h2><!-- <spring:message code="menu.mng.menuMgmt" /> --></h2>

		    	<div class="admin_left" style="width: 35%; height: 600px;">
		    		<div style="text-align: right;">
			    		<input type="button" name="save_btn" id="add_btn" value="메뉴추가"  />
			    		<input type="button" name="del_btn" id="del_btn" value="메뉴삭제" />
		    		</div>
		    		 <br />
		    		 <br />
		            <div id="dtreeDiv1"> </div>
				</div>
				<div  class="admin_right" style="width: 60%; margin: 5px 0 20px 15px;">
					<form id ="menu_form" name="menu_form"  action="mng_" method="post">
						<input type="hidden" name="save_type" id="save_type" value="" />
						<input type="hidden" name="rol_save_yn" id="rol_save_yn" value="" />
						<input type="hidden" id="menu_rol_list" name="menu_rol_list" value="" />
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<h5 class="title"> 메뉴 정보 <span>(메뉴는 최대 4단계 이내로 생성해주세요)</span></h5>
					 
					<div class="table-c-wrap">
					<table class="table-c" cellspacing="0" cellpadding="0" summary="메뉴정보 테이블, 상위메뉴ID, 메뉴ID, 메뉴이름, 메뉴레벨, 출력순서등 설정 합니다."> 
						<caption>메뉴관리</caption> 
						<colgroup>
				            <col width="25%" />
				            <col width="75%" />
				         </colgroup> 
						<thead>  
						</thead>  
						<tbody> 
							<tr> 
								<th>상위메뉴 ID</th>
								<td><input name="menu_prts_id" id="menu_prts_id" class="keyword" accesskey="s" type="text"  title="상위메뉴ID" readonly="readonly"  /></td>
							</tr> 
							<tr> 
								<th scope="col">메뉴레벨</th>
								<td><input name="menu_levl" id="menu_levl" accesskey="s" type="text" title="메뉴레벨" value=""  readonly="readonly" />
								</td> 
							</tr> 
			                <tr> 
								<th><font color="red">*</font> 메뉴 ID</th>
								<td><input name="menu_id" id="menu_id" class="keyword" accesskey="s" type="text" onblur="fn_MenuDupl_chk(this)" title="메뉴ID"/></td>
							</tr>
							<tr> 
								<th><font color="red">*</font> 메뉴명</th>
								<td><input name="menu_nm" id="menu_nm" class="keyword" accesskey="s" type="text" title="메뉴명" /></td>
							</tr> 
							<tr> 
								<th>메뉴영문명</th>
								<td><input name="menu_eng_nm" id="menu_eng_nm" class="keyword" accesskey="s" type="text" title="메뉴영문명" /></td>
							</tr> 
			                 <tr> 
								<th><font color="red">*</font> 메뉴순서</th>
								<td><input name="menu_ord" id="menu_ord" class="keyword" accesskey="s" type="text" title="출력순서" /></td> 
							</tr>
							<tr>
				            	<th scope="row">상단메뉴여부</th>
				             	<td><div class="item">
									<input type="radio" class="i_radio"  name="top_menu_yn" value="Y" title="사용여부,사용함"  />
									<label for="menu_use_y" title="사용함">사용 함</label>
									<input type="radio" class="i_radio"  name="top_menu_yn" value="N" title="사용여부,사용 안함"  />
									<label for="menu_use_n" title="사용 안함">사용 안함</label>
				            	</div></td>
				            </tr>
							<tr>
				            	<th scope="row">왼쪽메뉴여부</th>
				             	<td><div class="item">
									<input type="radio" class="i_radio"  name="left_menu_yn" value="Y" title="사용여부,사용함" />
									<label for="menu_use_y" title="사용함">사용 함</label>
									<input type="radio" class="i_radio"  name="left_menu_yn" value="N" title="사용여부,사용 안함"  />
									<label for="menu_use_n" title="사용 안함">사용 안함</label>
				            	</div></td>
				            </tr>
							<tr>
				            	<th scope="row">사용여부</th>
				             	<td><div class="item">
									<input type="radio" class="i_radio"  name="menu_use_yn" value="Y" title="사용여부,사용함"  />
									<label for="menu_use_y" title="사용함">사용 함</label>
									<input type="radio" class="i_radio"  name="menu_use_yn" value="N" title="사용여부,사용 안함"  />
									<label for="menu_use_n" title="사용 안함">사용 안함</label>
				            	</div></td>
				            </tr>
						</tbody> 
					</table>
					<h5 class="title">메뉴 권한</h5>
						<div class="table-c-wrap">
					        <table class="table-c" border="1" cellspacing="0" summary="메뉴권한 관리 테이블 입니다."> 
								<caption>메뉴관리</caption> 
								<colgroup>
									<col width="25%" />
									<col width="75%" />
								 </colgroup> 
								<thead>  
								</thead>  
								<tbody id="auth_list"> 
									<c:forEach items="${auth_cd}" var="varMenu" varStatus="menuState">
									<tr name="${varMenu.ref_val1}"> 
										<th>${varMenu.cd_nm} 권한</th>
										<td>
										<c:forEach items="${auth_gp}" var="varRole" varStatus="rolState">
											<input type="checkbox" name="${varMenu.cd}"  value="${varRole.cd}" title="${varMenu.cd_nm} 권한" ><span style="cursor: pointer;" onclick="fn_chk('${varMenu.cd}','${varRole.cd}')">${varRole.cd_nm}</span></input>
										</c:forEach>
										</td>
									</tr>
									</c:forEach>
								</tbody> 
							</table>
						</div>
					</div>
					</form>
					<!-- <span style=""> -->
					<div align="right">
						<input type="button" onclick="fn_save();" name="save_btn"  value="저장"  />
					</div>
					<!-- </span> -->
				</div>
				
			</div>
		
	</div>
		
