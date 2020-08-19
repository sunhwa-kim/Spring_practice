var ctxt = "/cris"
var msg="";

/**
 * 테이블 리 필수값 체크 
 * param[0] : 체크colum list
 * param[1] : 체크colum list
 * return 
 */
function fn_valchk(tbody_id, param_idx, param_nm){
	
	var isVal = true;
	
	$('#'+tbody_id+' tr').each(function(cnt){
		var trObj = $(this);
		for(var i=0; i <param_idx.length;i++){
			if(trObj.find('td:eq('+param_idx[i]+') input[type=text]').val() == ''){
				isVal= false;
				msg= cnt+1+"번째 줄 "+param_nm[i]+"는 필수 입력입니다.";
				paramObj=trObj;
				trObj.find('td:eq('+param_idx[i]+') input[type=text]').focus();
				return false;
			}
		}
	});
	return isVal;
}

/**
* 로우 선택
*/
function fn_setRow(obj){
	$('#dtlCdList .on').attr('class','off');
	$(obj).attr('class','on');	
}

/**
*	상세코드 저장
*/
function fn_saveSch(type){
	var sel_cd ="";
	var paramObj;
	
	var param_idx = [1,2,6];
	var param_nm = ["ID","스켸줄명","시간"]
	
	var isVal = fn_valchk('dtlCdList',param_idx,param_nm);

	if(!isVal){
		alert(msg);
		fn_setRow(paramObj);
		return;
	}
	var strConfirm;
	
	if(type == 'D'){
		strConfirm=true;
	}else{
		strConfirm = confirm("저장하시겠습니까?");
	}

	if(strConfirm){
		
		var list = [];
		var cnt=0;
		$('#dtlCdList tr').each(function(){
			
			var trObj = $(this);
			//데이터 조작이 없는 경우 처리안함
			if(trObj.find('td:eq(11)').text() == 'N'){
				return true;
			}
			
			if(cnt == 0){   
				sel_cd=trObj.find('td:eq(8)').text();
			}
			   
			list[cnt] = {
					"etl_sn" : trObj.find('td:eq(0)').text(),
					"etl_id" : trObj.find('td:eq(1) input[type=text]').val(),
					"etl_nm" : encodeURIComponent(trObj.find('td:eq(2) input[type=text]').val()),
					"etl_type" : trObj.find('td:eq(3) :selected').val(),
					"etl_tb" : trObj.find('td:eq(4) input[type=text]').val(),
					"etl_gbn" : trObj.find('td:eq(5) input[type=text]').val(),
					"etl_time" : trObj.find('td:eq(6) input[type=text]').val(),
					"etl_hh" : trObj.find('td:eq(7) :selected').val(),
					"etl_ss" : trObj.find('td:eq(8) :selected').val(),
					"use_yn" : trObj.find('td:eq(10) :selected').val(),
					"save_type" : trObj.find('td:eq(11)').text()
				}
			cnt++;
			
		});

		var sendList = {"list" : list};

		$.ajax({
			url : ctxt+'/mng/sch/saveEtlList.do',
			data : JSON.stringify(sendList),
			processData : false,
			//contentType: false,
			type : 'POST',
			traditional : true,
			cache: false,
			success : function(result) {

				$('#dtlCdList tr').each(function(){	
					var trObj = $(this);
					trObj.find('td:eq(11)').text('N');
				});
				
				alert("저장을 완료 하였습니다.");
				
				$('#sel_cd').val(sel_cd);
					
			},
			error : function() { // Ajax 전송 에러 발생시 실행
				fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
			},
			complete : function(result) { //  success, error 실행 후 최종적으로 실행
				
			}
		});
	
	}
	
}

/**
 *	상세코드 저장
 */
function fn_saveForm(type){
	var sel_cd ="";
	var paramObj;
	
	var param_idx = [1,2];
	var param_nm = ["elmnt_id","elmnt_명"]
	
	var isVal = fn_valchk('dtlCdList',param_idx,param_nm);
	
	if(!isVal){
		alert(msg);
		fn_setRow(paramObj);
		return;
	}
	var strConfirm;
	
	if(type == 'D'){
		strConfirm=true;
	}else{
		strConfirm = confirm("저장하시겠습니까?");
//		sh
		if(strConfirm){
			alert(trObj.find('td:eq(7)').text());
		}
	}
	
	if(strConfirm){
		
		var list = [];
		var cnt=0;
		$('#dtlCdList tr').each(function(){
			
			var trObj = $(this);
			//데이터 조작이 없는 경우 처리안함
			if(trObj.find('td:eq(7)').text() == 'N'){
				return true;
			}
			
/*			if(cnt == 0){   
				sel_cd=trObj.find('td:eq(8)').text();
			}*/
			
			list[cnt] = {
					"elmnt_id" : trObj.find('td:eq(1) input[type=text]').val(),
					"elmnt_nm" : encodeURIComponent(trObj.find('td:eq(2) input[type=text]').val()),
					"data_type" : trObj.find('td:eq(3) :selected').val(),
					"cd" : trObj.find('td:eq(4) :selected').val(),
					"lbl_kor" : encodeURIComponent(trObj.find('td:eq(5) input[type=text]').val()),
					"lbl_eng" : trObj.find('td:eq(6) input[type=text]').val(),
					"save_type" : trObj.find('td:eq(7)').text()
			}
			cnt++;
			
		});  
		
		var sendList = {"list" : list};
		
		$.ajax({
			url : ctxt+'/mng/form/saveFormList.do',
			data : JSON.stringify(sendList),  
			processData : false,    
			//contentType: false,
			type : 'POST',
			traditional : true,
			cache: false,
			success : function(result) {
				
				$('#dtlCdList tr').each(function(){	
					var trObj = $(this);
					trObj.find('td:eq(7)').text('N');
				});
				
				alert("저장을 완료 하였습니다.");
				
				$('#sel_cd').val(sel_cd);
				
			},
			error : function() { // Ajax 전송 에러 발생시 실행
				fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
			},
			complete : function(result) { //  success, error 실행 후 최종적으로 실행
				
			}
		});
		
	}
	
}

/**
 *	상세코드 저장
 */
function fn_saveWrkForm(type){
	var sel_cd ="";
	var paramObj;
	
	var param_idx = [1];
	var param_nm = ["frm_id"]
	
	var isVal = fn_valchk('dtlFrmList',param_idx,param_nm);
	
	if(!isVal){
		alert(msg);
		fn_setRow(paramObj);
		return;
	}
	var strConfirm;
	
	if(type == 'D'){
		strConfirm=true;
	}else{
		strConfirm = confirm("저장하시겠습니까?");
	}
	
	if(strConfirm){
		
		var list = [];
		var cnt=0;
		$('#dtlFrmList tr').each(function(){
			
			var trObj = $(this);
			//데이터 조작이 없는 경우 처리안함
			if(trObj.find('td:eq(5)').text() == 'N'){
				return true;
			}
			
			list[cnt] = {
					"frm_id" : trObj.find('td:eq(1) input[type=text]').val(),
					"frm_gbn" : trObj.find('td:eq(2) :selected').val(),
					"frm_etc" : encodeURIComponent(trObj.find('td:eq(3) input[type=text]').val()),
					"use_yn" : trObj.find('td:eq(4) :selected').val(),
					"save_type" : trObj.find('td:eq(5)').text()
			}
			cnt++;
			
		});  
		
		var sendList = {"list" : list};
		
		$.ajax({
			url : ctxt+'/mng/form/saveWrkFormList.do',
			data : JSON.stringify(sendList),  
			processData : false,    
			//contentType: false,
			type : 'POST',
			traditional : true,
			cache: false,
			success : function(result) {
				
				$('#dtlFrmList tr').each(function(){	
					var trObj = $(this);
					trObj.find('td:eq(5)').text('N');
				});
				
				alert("저장을 완료 하였습니다.");
				
				$('#sel_cd').val(sel_cd);
				
			},
			error : function() { // Ajax 전송 에러 발생시 실행
				fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
			},
			complete : function(result) { //  success, error 실행 후 최종적으로 실행
				
			}
		});
		
	}
	
}



// shshsh
/**
 *	 formId의 하위구성요소 설정(저장)
 */
function fn_saveSubWrkForm(type){ //애는 type?
	alert("oo")
//	var sel_cd ="";
//	var paramObj;
//	
//	var param_idx = [1];
//	var param_nm = ["frm_id"]
//	
//	var isVal = fn_valchk('dtlFrmDtlList',param_idx,param_nm); //필수 입력값 확인(사용자 요청 먼저하기 위해, 아래 row거르기 전에 확인)
//	
//	if(!isVal){
//		type = 'D';
//		alert(msg);
//		fn_setRow(paramObj);
//		return;
//	}
//	var strConfirm;
	
	if(type == 'D'){
		strConfirm=true;
	}else{
		strConfirm = confirm("저장하시겠습니까?");
	}
	
	if(strConfirm){
		
		var list = [];
		var cnt=0;
		$('#dtlFrmDtlList tr').each(function(){
			
			var trObj = $(this);
			//데이터 조작이 없는 경우 처리안함
			if(trObj.find('td:eq(8)').text() == 'N'){ //조회 상태에서 N  표시
				return true; //true 결과?
			}
			
			list[cnt] = {// false만? no......  => 그냥 저장 눌렀을 때 추가 처럼 하면?
					"frm_id" : trObj.find('td:eq(0)').text(),
					"frm_seq" : encodeURIComponent(trObj.find('td:eq(3) input[type=text]').val()),
					"frm_elmnt_id" : trObj.find('td:eq(2) :selected').val(),
					"frm_ord" : encodeURIComponent(trObj.find('td:eq(3) input[type=text]').val()),
					"frm_col" : encodeURIComponent(trObj.find('td:eq(4) input[type=text]').val()),
					"use_yn" : trObj.find('td:eq(5) :selected').val(),
					"lst_yn" : trObj.find('td:eq(6) :selected').val(),
					"srch_yn" : trObj.find('td:eq(7) :selected').val(),
					"save_type" : trObj.find('td:eq(8)').text()
			}
			cnt++;
		});  
		
//		list.forEach(function(test){
//			console.log(test)
//		})
		
		var sendList = {"list" : list};
		
		$.ajax({
			url : ctxt+'/mng/form/saveSubWrkFormList.do',
			data : JSON.stringify(sendList),  
			processData : false,    
			//contentType: false,
			type : 'POST',
			traditional : true,
			cache: false,
			success : function(result) {
				alert("ajax arrive")
				$('#dtlFrmDtlList tr').each(function(){	
					var trObj = $(this);
					trObj.find('td:eq(8)').text('N');
				});
				
				alert("저장을 완료 하였습니다.");
				
//				$('#sel_cd').val(sel_cd);
				
			},
			error : function() { // Ajax 전송 에러 발생시 실행
				fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
			},
			complete : function(result) { //  success, error 실행 후 최종적으로 실행
				
			}
		});
		
	}
	
}


/**
* 상세코드 데이터 수정시   
*/
function fn_upd(obj, idx){
	if($(obj).parent().parent().find('td:eq('+idx+')').text() != 'I'){
		$(obj).parent().parent().find('td:eq('+idx+')').text('U');
	}
}




