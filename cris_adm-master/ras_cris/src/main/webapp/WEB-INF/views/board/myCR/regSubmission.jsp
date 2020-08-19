<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2 style="margin-left: 5%;">연구상태에 대한 기록 변경 정보</h2>
	<div id="clinicalRsTitle" style="margin-left: 5%;"></div></br>
	<div id="tableNone"></div>
	<table style="width:55%;margin-left: 5%;">
	<colgroup>
        <col style="width:5%" />
        <col style="width:5%" />
        <col style="width:5%">
        <col style="width:20%">
        <col style="width:20%">
      </colgroup>
		<thead id="theadData">
		</thead>
		<tbody id="tbodyData">
		</tbody>
	</table>
	<input type="button" id="popCloseBtn" name="popCloseBtn" value="닫기">
</body>
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	var idx = '${seq}';
	var separator = '${separator}';
	var title = '${title}';
	
	var url = $(location).attr('href');
	var baseUrl = url.substr(0,url.lastIndexOf("/"));
	
	var params = {};
	params.seq = idx;
	params.separator = separator;
	
$(function(){
	$('#clinicalRsTitle').html(title);
	
	$.ajax({
		url:  baseUrl+"/regSubData.do",
		data : params,
		type:'POST',
		success:function(res){
			var html = "";
			var idx = res.length;
			
			alert(idx)
			if(idx!=0){
				var theadHtml = "";
				theadHtml = '<tr><th>최신순</th><th style="text-aligh:center;">변경 전</th><th style="text-aligh:center;">변경 후</th><th style="text-aligh:center;">변경 일시</th><th style="text-aligh:center;">변경 사유</th></tr>';
				$('#theadData').html(theadHtml);
				
				for(var i=0 ; i < res.length ; i++) {
					var tdRwSpn = '<td style="word-break:break-all;text-align:center;">';
					
					html += '<tr>';
					html +=  tdRwSpn
						html += idx--;
					html += '</td>';
					html +=  tdRwSpn
						html += res[i].LAST_STAT_AL;
					html += '</td>';
					html += tdRwSpn;
						html += res[i].CHANGE_STAT_AL;
					html += '</td>';
					html +=  '<td style="word-break:break-all;padding-left:20px">';
						html += fn_changeDate(res[i]);
					html += '</td>';
					if("반려"==res[i].CHANGE_STAT_AL){
						html += '<td style="word-break:break-all;padding-left:20px">';
						html += res[i].CODE_NAME +" : "+res[i].STAT_REASON_ETC;
						html += '</td>';
					} else {  html +=tdRwSpn;   }
					html += '</tr>';
				}
			$('#tbodyData').html(html);
			} else {
				html += "변경 이력이 없습니다. ";
				$('#tableNone').html(html);
			}
			
		}
	})  //  end of ajax
	
	$('#popCloseBtn').click(function(){
		window.close();
	});  //  end of popCloseBtn
})

function fn_changeDate(resForIdx, tdRwSpn){
	var html = "";
	if("제출" == resForIdx.CHANGE_STAT_AL){
		if(resForIdx.CHARGE_DATE  != "" && resForIdx.CHARGE_DATE  != null){
			html += "등록자 : " + resForIdx.CHANGE_DATE_AL +"<br>";
			html += "* 책임자 : " + resForIdx.CHARGE_DATE;
				if(resForIdx.CHARGE_CANCEL =="Y") html += ", 취소";
				else html += ", 확인";
			html += "<br>";
			html += "* 실무자 : " + resForIdx.WORK_DATE;
				if(resForIdx.WORK_CANCEL =="Y") html += ", 취소";
				else html += ", 확인";
			html += "<br>";
		} 
	} else {
		html += "등록자 : " + resForIdx.CHANGE_DATE_AL;
	}
	return html;
}
</script>
</html>