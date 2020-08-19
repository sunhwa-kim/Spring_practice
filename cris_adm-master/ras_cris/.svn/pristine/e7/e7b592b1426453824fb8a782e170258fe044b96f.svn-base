<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>시스템 관리</title>
</head>
<body>	
<script type="text/javascript">

$(function(){
	
	//조회버튼 클릭 이벤트
	$('#search_btn').on('click',function(){fn_search()});
	$('#search_cd').on('keyup',function(e){if(e.which  == 13){ fn_search()} });
	
	if($('#search_cd').val() != "" ){
		fn_search();
	}
});

function fn_search(){
	
	var reg = /^[가-힣a-zA-Z0-9]*$/;

	
	if($('#search_cd').val() == ''){
		fn_alert('조회어를 입력하세요');
		return;
	}
	
	var result  = reg.test($('#search_cd').val());
	
	if(!result){
		fn_alert("잘못된 조회어입니다.","c");
		return;
	}

	$.ajax({ 
        type: 'GET',
        url : '${ctxt}/mng/sys/searchKeyWord.do',
        data: {"keyword" : $('#search_cd').val()},
        contentType: 'text/xml;charset=utf-8',   //서버로 데이터를 보낼 때 사용.
       	dataType : 'json',
	    success : function(result) {
	    			var ncmik_html = "";
	    			var promotion_html = "";
	    			var community_html = "";
	    			var file_html = "";
	           		$(result).each(function(cnt,entry){
	           			var idx = Number(cnt)+1;
	           			switch(entry.TABLE_GP){
	           				case "TB_01":
	           					ncmik_html += '<a href="/ncmiklib'+entry.TABLE_URL+'" >'+idx+'. ['+ entry.TABLE_GP_NM+'] ' + entry.TABLE_TITLE +'</a><br>';
	           				break;
	           				case "TB_02":
	           					promotion_html += '<a href="/ncmiklib'+entry.TABLE_URL+'" >'+idx+'. ['+ entry.TABLE_GP_NM+'] ' + entry.TABLE_TITLE +'</a><br>';
	           				break;
	           				case "TB_03":
	           					community_html += '<a href="/ncmiklib'+entry.TABLE_URL+'" >'+idx+'. ['+ entry.TABLE_GP_NM+'] ' + entry.TABLE_TITLE +'</a><br>';
	           				break;
	           				case "TB_04":
	           					file_html += '<a href="/ncmiklib'+entry.TABLE_URL+'" >'+idx+'. ['+ entry.TABLE_GP_NM+'] ' + entry.TABLE_TITLE +'</a><br>';
	           				break;
	           			}
	           			
	           		});
	           		
	           		$('#ncmik').children().remove();
	           		$('#promotion').children().remove();
	           		$('#community').children().remove();
	           		$('#ncmik').html(ncmik_html);
	           		$('#promotion').html(promotion_html);
	           		$('#community').html(community_html);
	           		$('#file').html(file_html);
	    },
        error: function(xhr, status, error){
        	fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}

</script>

<div id="container">
	<div id="content">
		<div style="width:100%; height: 700px;" >
			<h2>조회</h2>  
			<input type="text" id="search_cd" value="" />
			<input type="button" id="search_btn" value="조회"  />
			<br />
			<br />
			<h2>채용</h2>  
			<div id="ncmik" style="height:120px;overflow: auto;"></div>
			<h2>홍보</h2>
			<div id="promotion" style="height:120px;overflow: auto;"></div>
			<h2>커뮤니티</h2>
			<div id="community" style="height:120px;overflow: auto;"></div>
			<h2>파일</h2>
			<div id="file" style="height:120px;overflow: auto;"></div>
		</div>
 	</div>
 </div>
</body>
</html>