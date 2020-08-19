<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$(function(){
	//tab
    $("ul.tabs li").eq(1).addClass("active").css("color", "#003964");
	
    $("ul.tabs li").eq(0).click(function(){
    	location.href="${ctxt}/elib/listOpenAPI.do";
    })
    $("ul.tabs li").eq(1).click(function(){
    	location.href="${ctxt}/elib/summaryOpenAPI.do";
    })
    $("ul.tabs li").eq(2).click(function(){
    	location.href="${ctxt}/elib/detailOpenAPI.do";
    })
});


function fn_openApiPop(){
	var form = document.apiForm;
	var url = "${ctxt}/srv/openapi/kSummary.do";
	var w = "1200";
	var h = "800";
	var l, t;
	l = (screen.width-w)/2;
	t = (screen.height-h)/2;
	
	window.open('','apiForm','width='+w+',height='+h+',left='+l+',top='+t+',resizable=0,scrollbars=1');
	
	form.action =url; 
	form.method="post";
	form.target="apiForm";

	form.submit();	
	
}
</script>
<style>
#bodyInfo > tr > td:nth-child(1){
text-align:center; 
}
th.long{
	position:relative;
}
/* th.long>span{
	position:absolute;
	transform:translate(-50%,-50%);
	-o-transform:translate(-50%,-50%);
	-ms-transform:translate(-50%,-50%);
	-moz-transform:translate(-50%,-50%);
	-webkit-transform:translate(-50%,-50%);
	font-size:11px;
} */
th.long>span.span2,th.long>span.span3{
	display:none;
}
.tabContainer{
		display:none;
	}
ul.tabs li{
		width:auto; 
		padding:0 15px;
	}
@media all and (max-width:990px){
	.tabContainer{
		display:block;
	}
}

@media (max-width: 780px){
	th.long>span.span2{
		display:block;
	}
	th.long>span.span1{
		display:none;
	}
}
@media (max-width: 450px){
	.basic_table.font{
		font-size:11px;
	}
	.basic_table.border-right>thead>tr>th {
    	padding: 7px 2px;
    	font-size:10px;
    }
    .basic_table td {
	    padding: 7px 2px;
	}
	ul.tabs li{
		font-size:12px;
		padding:0 5px;
	}
}
@media (max-width: 447px){
	th.long>span.span2{
		display:none;
	}
	th.long>span.span3{
		display:block;
		font-size:11px;
	}
}
</style>
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>전자자원</span>
			<span> > </span>
			<span class="active">검색결과요약</span>        
		</div>
		<span href="#" class="center_text_01">검색결과요약</span>
    </div> 
    <div class="under_bar"></div>
									
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div class="tabContainer"> 
					<ul class="tabs">
				        <li rel="tab1" style="box-sizing:border-box; color:#003964;">검색목록</li>
				        <li class="active" rel="tab2" style="box-sizing:border-box;" onclick="">검색결과요약</li>
				        <li rel="tab3" style="box-sizing:border-box;" onclick="">상세정보</li>				    
					</ul>
				    <div class="tab_container" style="width:100%; box-sizing:border-box; padding-top:10px;"></div>
				</div>	
				<!-- kSummary -->
				<div class="list_title">
					<p>kSummary</p>
				</div>
				
				<ul class="list_full_2">
					<li class="list_number2">kSummary Input</li>
				</ul>
				<table class="basic_table zero_margin font border-right">
					<caption></caption>
					<thead>
						<tr>
							<th colspan="2">인터페이스명</th>
							<th>검색리스트</th>
							<th>호출url</th>
							<th colspan="3" class="long"><span class="span1">http://library.nih.go.kr${ctxt}/srv/openapi/kSummary.do</span><span class="span2">http://library.nih.go.kr${ctxt}/ srv/openapi/kSummary.do</span><span class="span3">http://library.nih.go.kr/ ncmiklib/srv/ openapi/kSummary.do</span></th>
						</tr>
						<tr>
							<th>No</th>
							<th>요청송신 필드명</th>
							<th>데이터Type</th>
							<th>Null허용</th>
							<th>Key</th>
							<th>내용</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody id="bodyInfo">
						<tr>
							<td>1</td>
							<td>artctrlNo</td>
							<td>int</td>
							<td>N</td>
							<td> </td>
							<td>논문제어번호</td>
							<td> </td>
						</tr>
					</tbody>
				</table>
		
				<ul class="list_full_2">
					<li class="list_number2">kSummary Output</li>
				</ul>
				<table class="basic_table zero_margin font border-right" style="margin-bottom:0;">
					<thead>
						<tr>
							<th colspan="2">인터페이스명</th>
							<th>검색리스트</th>
							<th>리턴타입</th>
							<th colspan="2">XML</th>
						</tr>
						<tr>
							<th>No</th>
							<th>수신필드명</th>
							<th>데이터Type</th>
							<th>Null허용</th>
							<th>내용</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody id="bodyInfo">
						<tr>
							<td>1</td>
							<td>TITLE</td>
							<td>string</td>
							<td>N</td>
							<td>논문명</td>
							<td> </td>
						</tr>
						<tr>
							<td>2</td>
							<td>AUTHOR</td>
							<td>string</td>
							<td>N</td>
							<td>저자</td>
							<td></td>
						</tr>
						<tr>
							<td>3</td>
							<td>JOURNALNAME</td>
							<td>string</td>
							<td>N</td>
							<td>학술지명</td>
							<td></td>
						</tr>
						<tr>
							<td>4</td>
							<td>ARTPUBDATE</td>
							<td>string</td>
							<td>N</td>
							<td>발행일 또는 발행년</td>
							<td></td>
						</tr>
						<tr>
							<td>5</td>
							<td>VOLUMENAME</td>
							<td>string</td>
							<td>N</td>
							<td>학술지명</td>
							<td></td>
						</tr>
						<tr>
							<td>6</td>
							<td>STARTPAGE</td>
							<td>string</td>
							<td>N</td>
							<td>시작페이지</td>
							<td></td>
						</tr>
						<tr>
							<td>7</td>
							<td>LASTPAGE</td>
							<td>string</td>
							<td>N</td>
							<td>마지막페이지</td>
							<td></td>
						</tr>
					</tbody>
				</table>

				<div class="btn-group">
					<span class="application">예시 : http://library.nih.go.kr${ctxt}/srv/openapi/kSummary.do?artctrlNo=5357534</span>
						<a href="javascript:fn_openApiPop();" class="basic-btn">XML결과 보기</a>
				</div>
				
				<!-- kSummary End -->
			</div>
		</div>
	</div>
	
	
	<form name ="apiForm">
		<input type="hidden" id="artctrlNo" name="artctrlNo" value="5357534" alt="artctrlNo">
	</form>