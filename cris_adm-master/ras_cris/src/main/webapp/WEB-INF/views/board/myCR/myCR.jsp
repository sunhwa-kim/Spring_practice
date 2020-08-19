<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@page import="kr.go.cris.ptl.mng.menu.vo.MngMenuVo"%>

<link href="${ctxt}/resources/css/myCR/my_cr.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	var longinInfo = 'devsuper';
	var firstOfHtml="";
	var lastOfHtml ="";
	var regCnt=2;
	
	param = {};
	param.userId = longinInfo;

$(function(){
	$.ajax({
		url: ctxt + '/board/myClinicalResearch/registration_mng.do',
		data : param,
		type:'POST',
		async:false,
		success:function(res){
			var resArr = [];
//			html += '<ul id="regList_div">';
			for(var i=0; i<res.length;i++){
				if(i<3){
					firstOfHtml+= fn_makeOfLi(i,res);
				} else {
					lastOfHtml += fn_makeOfLi(i,res);
				}
			}
//			html += '</ul>';
			$('#regList').html(firstOfHtml);
			$('#regList').append($('regBtnBundle').val())
		}
		
	})  //  end of the first ajax
	

	$('#lastOfRegstr').click(function(){
		regCnt--;
		if(regCnt != 0){
			$('#regList').append(lastOfHtml);
			$('#lastOfRegstr').attr('value','숨기기');
		}else{
			$('regList').empty();
			$('#regList').html(firstOfHtml);
			$('#lastOfRegstr').attr('value','더 보기');
			regCnt=2;
		}
	});
	
	
	$('#regBtn').click(function(){
		alert("regBtn click")
	})
	
});

function fn_makeOfLi(idx,res){
	var html ="";
	resArr = res[idx];
	var statusNb = resArr.STATUS;
	var statusStr = fn_status(statusNb);
	
	if(statusNb == 0 && resArr.WORKSTAT !="" && resArr.WORKSTAT != null && resArr.WORKCONFDATE !="" && resArr.WORKCONFDATE != null
			&& resArr.CHARGESTAT !="" && resArr.CHARGESTAT != null && resArr.CHARGECONFDATE !="" && resArr.CHARGECONFDATE != null
			|| statusNb == 1 || statusNb == 3){
		var work=" ( 실무 담당자 : ";
		var charge = "연구 책임자 : ";
		if(resArr.WORKSTAT=="Y") work += "확인 ["+ resArr.WORKCONFDATE+"]";
		else if(resArr.WORKSTAT=="N") work += "취소 [" + resArr.WORKCONFDATE+"]";
		else work += "미확인";
		
		if(resArr.CHARGESTAT=="Y") charge += "확인 ["+ resArr.CHARGECONFDATE+"]";
		else if(resArr.CHARGESTAT=="N") charge += "취소 [" + resArr.CHARGECONFDATE+"]";
		else charge += "미확인";
		
		statusStr += work+", "+charge +")";
	} else {
		statusStr;
	}
	
	html += '<li>';
		html += '<ul class="top">';
			html += '<li>등록 번호 :</li>';
			html += '<li>'+resArr.SYSTEM_NUMBER+'</li>';
			html += '<li>상태 :</li>';
			html += '<li>'+statusStr+'</li>';  //  resArr.WORKSTAT+','+resArr.WORKCONFDATE
		html += '</ul>'
		html += '<ul class="middle">';
			html += '<li>연구 제목 :</li>';
			html += '<li>'+resArr.RESEARCH_TITLE_KR+'</li>';
		html += '</ul>'
		html += '<ul class="bottom">';
			html += '<li>최초 제출일 :</li>';
			html += '<li>'+resArr.INS_DATE+'</li>';
			html += '<li>검토/승인일 :</li>';
			html += '<li>'+resArr.APP_DATE+'</li>';  //+'/'+resArr.LAST_DATE
			html += '<li>최종 갱신일 :</li>';
			html += '<li>'+resArr.UDT_DATE+'</li>';
		html += '</ul>';
		html += '<ul class="regBtnBundle">';
			html += '<li><input type="button" onclick="getRegBtnVal('+resArr.SEQ+',\''+resArr.RESEARCH_TITLE_KR+'\',\'regSubmission\')"  value="제출 이력"></li>';
			html += '<li><input type="button" onclick="getRegBtnVal('+resArr.SEQ+',\''+resArr.RESEARCH_TITLE_KR+'\',\'regRsInfo\')" value="연구 정보"></li>';
			html += '<li><input type="button" onclick="getRegBtnVal('+resArr.SEQ+',\'regRsResult\')" value="연구 결과"></li>';
			html += '<li><input type="button" onclick="getRegBtnVal('+resArr.SEQ+',\'regDelete\')" value="삭제"></li>';
			html += '<li><input type="button" onclick="getRegBtnVal('+resArr.SEQ+',\'regAdmChange\')" value="관리자 변경"></li>';
		html += '</ul>';
	html += '</li>';
	return html;
}

function fn_status(number){
	var statusStr = "";
	
	if(number==0){
		statusStr = "작성중";
	} else if(number==1){
		statusStr = "제출";
	} else if(number==2){
		statusStr = "검토중";
	} else if(number==3){
		statusStr = "보완";
	} else if(number==4){
		statusStr = "반려";
	} else {
		statusStr = "승인";
	}
	return statusStr;
}

function getRegBtnVal(seq, title, ipNm){
	alert("버튼!!     "+seq)
	alert("버튼!!     "+ipNm)
	$('#reg_seq').val(seq);
	$('#reg_title').val(title);
	$('#reg_btnVal').val(ipNm);
//	the record changed information of research status : 연구상태에 대한 기록 변경 정보
	
	var def_form = document.reg_Form; 
	
	def_form.action=ctxt+"/board/myClinicalResearch/regSubView.do";
	def_form.submit();
	
}


</script>

<div id="container" style="min-height: 600px;">

	<div id="divRefreshArea">
			<h3 style="margin-left: 10%;">my 임상 연구</h3>
	     	<div id='regList'></div>
	     	<div id ="listControl" style="text-align:center;">
	     		<input type="button" id="lastOfRegstr" name="lastOfRegstr" value="더 보기">
	     	</div>
		<form name="reg_Form" method="post" target="_blank">
	     		<input type="hidden" id ="reg_seq" name="reg_seq" value="">
	     		<input type="hidden" id ="reg_btnVal" name="reg_btnVal" value="">
	     		<input type="hidden" id ="reg_title" name="reg_title" value="">
     	</form>
	</div>