<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<%-- 메뉴 코드 부분 --%>
<title><spring:message code="title.main"/></title>
  	<meta name="decorator" content="">
  	<link rel="stylesheet" href="${ctxt}/resources/backup/css/jqgrid/ui.jqgrid-bootstrap-ui.css" type="text/css" />
  	<link rel="stylesheet" href="${ctxt}/resources/backup/css/jqgrid/ui.jqgrid-bootstrap.css" type="text/css" />
  	<link rel="stylesheet" href="${ctxt}/resources/backup/css/jqgrid/ui.jqgrid.css" type="text/css" / >
  	<link rel="stylesheet" href="${ctxt}/resources/backup/js/jquery/jquery-ui-1.10.4.custom.min.css" type="text/css" />
</head>

<body>
<script src="${ctxt}/resources/backup/js/jqgrid/i18n/grid.locale-kr.js" type="text/javascript"></script>
<script src="${ctxt}/resources/backup/js/jqgrid/jquery.jqGrid.min.js" type="text/javascript"></script>
<script type="text/javascript">
var sel_row = -1;
	$(function() {
/*	
 * 
 	****************** comModel 옵션 ********************************************************************	
    align        : "center" ,    // 컬럼 글 정렬
    title        : "false"  ,    // 마우스 오버 시 타이틀 글씨 숨김
    width        : 120     ,    // 컬럼 넓이 (픽셀 속성 , 퍼센트 속성은 사용 불가)
    search       : true    ,    // searchToolbar , searchButton 사용 시 컬럼 찾기 기능 사용가능
    resizable    : true    ,    // 컬럼 사이즈를 자유자재로 조절할 수 있음
    sorttype     : "date" / "integer" / "text" / function
    sortable     : true    ,    // 컬럼 간의 위치를 바꿀 수 있다. (editable , multiselect 기능과 중복 사용 불가!)
    hidden       : true    ,    // 컬럼에 값을 가지고 있지만 그리드에서 숨김
    editable     : true    ,    // 셀 값을 변경 할 수 있음
    edittype     : "text" / "select" / "checkbox" / "textarea"
    editoptions  : {optionName:optionValue} , // 위의 edittype 값에 따라 적용 옵션이 다름 (각 값의 input 옵션과 동일)
    frozen       : true    ,    // 컬럼 틀고정 기능 사용가능 (editable , multiselect 기능과 중복 사용 불가!)
    **********************************************************************************************
**/     
		
		
		var $Grid = {};
		    $Grid = $('#grid');
		    var title ='채용정보목록';
		    var url = '${ctxt}/mng/recruit/readRssInfo.do'; 
		    var param={org_list:$('#org_list').val()};
		    var colnm = ['순번',"pk",'기관약어','타이틀','등록일자'];
		    var comModel = [
			                    { name : 'data_seq', index:'data_seq',   width:40,  align:'center'},
			                    { name : 'job_seq',      width:0,     align:'center' , hidden: true  },
			                    { name : 'org_cd',   width:80,   align:'left'  },
			                    { name : 'job_title',    width:400,   align:'left'  },
			                    { name : 'job_pubdate',  width:85,    align:'right' }
		            		];
		    //fn_event[0] : 그리드의 행을 선택하였을 때 발생하는 이벤트
    		//fn_event[1] :	그리드 셀을 선택하였을 때 발생하는 이벤트
		   	var fn_event = ["sample","sample2"];
    		var row_num = 20; //화면에 뿌려지는 행의 개수 기본 20 수정시( controller 수정필요 )
		    var grid = setGrid(title,url,param,colnm,comModel,fn_event,row_num);
		    $Grid.jqGrid(grid);

		    setTimeout(fn_selRow, 300);
		});
	
	//조회후 첫번째 행선택 이벤트
	function fn_selRow(){
		jQuery("#grid").setSelection(1,true)
	}
	
	/* 클릭함수
	*/
	function sample(rowid, status, e) {  	
        //같은 로우 선택시 이벤트 처리 안함
        if(sel_row ==  rowid){
        	 return;
        }else{
        	sel_row=rowid;
        }
        
        var list = jQuery("#grid").getRowData(rowid);
        $("form")[0].reset(); 
        fn_searchDtl(list.job_seq,list.org_cd);
        //fn_alert("sample :" +list.job_title + " , " + rowid +" , "+ status);
	}	
	
	/* 셀클릭 이벤트
	*/
	function sample2(rowid, iCol, e){ // 행넘버, 컬럼넘버
        var list = jQuery("#grid").getRowData(rowid);
	}
	
	/*
	* 채용정보 상세내역 조회
	*/
	function fn_searchDtl(job_seq, org_cd){
		var formData = new FormData();
  	  		formData.append("job_seq", job_seq);
    		formData.append("org_cd", org_cd);

		$.ajax({
	        url: '${ctxt}/mng/recruit/readRssDtlInfo.do',
	        data: formData,
	        type: 'POST',
	        contentType: false,
	        //dataType: 'text',
		    processData: false,
	        success: function(rtnXml) {
	        	
 	        	var xmlObj = $(rtnXml[0]).find('item');
 	        	var personObj = $(rtnXml[1]);
 	        	var careerObj = $(rtnXml[2]);
 	        	var workObj = $(rtnXml[3]);
 	        	var positionObj = $(rtnXml[4]);
 	        	var degreeObj = $(rtnXml[5]);
 	        	//PERSON_CD","CAREER_CD","WORK_CD","DEGREE_CD"
	        	html=xmlObj.find('job__description').text();
	        	$('#job_dtl').children().remove();
	        	$('#job_dtl').html(html);
	        	$('#job_seq').val(xmlObj.find('job__seq').text());
	        	$('#org_cd').val(xmlObj.find('org__cd').text()); 
	        	
	      		//상세내역 체크
	        	$(rtnXml[1]).find('item').each(function(){
	        		var chk_id = $(this).find('job__cls__cd').text();
	        		$('input[name=person][value='+chk_id+']').prop('checked','checked');
	        	});
	        	$(rtnXml[2]).find('item').each(function(){
	        		var chk_id = $(this).find('job__cls__cd').text();
	        		$('input[name=career][value='+chk_id+']').prop('checked','checked');
	        	});
	        	$(rtnXml[3]).find('item').each(function(){
	        		var chk_id = $(this).find('job__cls__cd').text();
	        		$('input[name=work][value='+chk_id+']').prop('checked','checked');
	        	});
	        	$(rtnXml[5]).find('item').each(function(){
	        		var chk_id = $(this).find('job__cls__cd').text();
	        		$('input[name=degree][value='+chk_id+']').prop('checked','checked');
	        	});
	        	
	        	
	        },
	        error : function(){                              // Ajax 전송 에러 발생시 실행
	        	fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
	        }
	    });
	}
	/*
	* 그리드 재조회
	*/
	function fn_search(){
		rowid = -1;
		$("#grid").jqGrid('setGridParam', {'postData' : {org_list:$('#org_list').val()}}).trigger('reloadGrid');
	}
	
	function fn_save(){
		var formData = new FormData();
  		var person_list= new Array();
  		var career_list= new Array();
  		var work_list= new Array();
  		var degree_list= new Array();
  		
		$('input[name=person]:checked').each(function(){
			person_list.push($(this).val());
		});
		$('input[name=career]:checked').each(function(){
			career_list.push($(this).val());
		});
		$('input[name=work]:checked').each(function(){
			work_list.push($(this).val());
		});
		$('input[name=degree]:checked').each(function(){
			degree_list.push($(this).val());
		});
		//채용분류정보
		formData.append("person_cd", person_list);
		formData.append("career_cd", career_list);
		formData.append("work_cd", work_list);
		formData.append("degree_cd", degree_list);
		//채용일자 수정정보
		formData.append("job_str_dt", $('#job_str_dt').val());
		formData.append("job_end_dt", $('#job_end_dt').val());
		formData.append("job_seq", $('#job_seq').val());
		formData.append("org_cd", $('#org_cd').val());
	
		$.ajax({
	        url: '${ctxt}/mng/recruit/insertMngCls.do',
	        data: formData,
	        type: 'POST',
	        contentType: false,
	        dataType: 'text',
		    processData: false,
	        success: function() {
	        	fn_alert("저장이 완료되었습니다.");
	        },
	        error : function(){                              // Ajax 전송 에러 발생시 실행
	        	fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
	        }
	    });
	}
	
</script>

	<div style="float: left;height:700px;">
		<input type="text" id="org_list" name="org_list" value="'NST'" />
		<button onclick="fn_search()">조회</button>
		<table id="grid"></table>
		<div id="pager"></div>
	</div>

	<div style="float:center;border: 1px solid #6699CC;height:700px;">
	    <form id="form" >
			<input type="hidden" id="job_seq" name="job_seq" value="" />
			<input type="hidden" id="org_cd" name="org_cd" value="" />
		
		<div  id="job_dtl" style="overflow: auto;height: 400px;">
		</div>
		<br />
		<table style="border:1px solid blue;">
			<colgroup>
				<col width="15%">
				<col width="85%">
			</colgroup>
			<tr style="border:1px solid blue;">
				<td  style="border:1px solid blue;">인력구분 :</td> 
				<td>
					<c:forEach var="person" items="${person_list}">
						<input type="checkbox" name="person"  value="${person.cd}" /> ${person.cd_nm}
					</c:forEach>
				</td>
			</tr>
			<tr  style="border:1px solid blue;">
				<td  style="border:1px solid blue;">경력구분 :</td> 
				<td>
					<c:forEach var="career" items="${career_list}">
						<input type="checkbox" name="career"  value="${career.cd}" /> ${career.cd_nm}
					</c:forEach>
				</td>
			</tr>
			<tr  style="border:1px solid blue;">
				<td  style="border:1px solid blue;">직종 :</td>
				<td>
					<c:forEach var="work" items="${work_list}">
						<input type="checkbox" name="work"  value="${work.cd}" /> ${work.cd_nm}
					</c:forEach>
				</td>
			</tr>
			<tr  style="border:1px solid blue;">
				<td  style="border:1px solid blue;">최종학위 :</td>
				<td>
					<c:forEach var="degree" items="${degree_list}">
						<input type="checkbox" name="degree"  value="${degree.cd}" /> ${degree.cd_nm}
					</c:forEach>
				</td>
			</tr>
			<tr>
				<td  style="border:1px solid blue;">채용일자 :</td>
				<td>
					<input type="text" name="job_str_dt" id="job_str_dt" /> ~
					<input type="text" name="job_end_dt" id="job_end_dt" />
				</td>
			</tr>
		</table>
		</form>
		<br />
		<button style="margin-left:560px;" name="save_btn" padding:1px;" onclick="fn_save()" >저장</button>
	</div>
</body>
</html>
