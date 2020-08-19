<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$(function(){
	//tab
    $("ul.tabs li").eq(0).addClass("active").css("color", "#003964");
	
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
	var url = "${ctxt}/srv/openapi/kSearch.do";
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
<style type="text/css">
#bodyInfo > tr > td:nth-child(1){
	text-align:center; 
	}
.tg  {width: 100%; border-top: 2px solid #6176c3; border-collapse: collapse; width: 100%; padding-left: 10px; position: relative; text-align: center;}
.tg td{padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#e6e6e6;}
.tg th{padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#e6e6e6;}
.tg .tg-l711{border-color:inherit}
.tg .tg-us36{border-color:inherit;vertical-align:top}
.tabContainer{
		display:none;
	}

	.none.link2{
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
@media (max-width: 690px){
	.basic_table.border-right>thead>tr>th{
		padding:7px 5px;
		font-size:12px;
	}
}
@media (max-width: 640px){
	.none.link{
		display:none;
	}
	.none.link2{
		display:block;
		position:absolute;
		left:-20%;
		top:-5%;
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
</style>

<div class="sub_center_text">
	<div class="sub_center_nav"> 
		<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
		<span> > </span> 
		<span>전자자원</span>
		<span> > </span>
		<span class="active">검색목록</span>        
	</div>    
	<span class="center_text_01">검색목록</span>
    </div> 
    <div class="under_bar"></div>
		
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">	
				<div class="tabContainer"> 
					<ul class="tabs">
				        <li class="active" rel="tab1" style="box-sizing:border-box; color:#003964;">검색목록</li>
				        <li rel="tab2" style="box-sizing:border-box;" onclick="">검색결과요약</li>
				        <li rel="tab3" style="box-sizing:border-box;" onclick="">상세정보</li>				    
					</ul>
				    <div class="tab_container" style="width:100%; box-sizing:border-box; padding-top:10px;"></div>
				</div>						
				<div class="list_title">
					<p>OpenAPI안내</p>
				</div>
				<ul class="list_full">
					<li>국립의과학 지식센터에서 구축한 국내발행 의과학 학술논문 국가서지를 공유하는 플랫폼입니다.</li>
				</ul>		
				<div class="list_title">
					<p>제공대상</p>
				</div>
				<ul class="list_full">
					<li>국립의과학 지식센터 소장 학술논문/학술지목록</li>
				</ul>
	
			<!-- kSearch -->
				
				<ul class="list_full_2">
					<li class="list_number2">kSearch Input</li>
				</ul>
				<table class="basic_table zero_margin font border-right">
					<caption></caption>
					<colgroup>
						<col style="width: 5%">
						<col style="width: 15%">
						<col style="width: 15%"> 
						<col style="width: 10%">
						<col style="width: 5%">
						<col style="width: 20%">
						<col style="width: 25%">
					</colgroup>
					<thead>
						<tr>
							<th colspan="2">인터페이스명</th>
							<th>검색리스트</th>
							<th class="none"><span class="none link">호출url</span></th>
							<th colspan="3" style="position:relative;"><span class="none link">http://library.nih.go.kr${ctxt}/srv/openapi/kSearch.do</span><span class="none link2">http://library.nih.go.kr / ncmiklib/srv/openapi/kSearch.do</span></th>
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
					    <td>kwd</td>
					    <td>string</td>
					    <td>Y</td>
					    <td> </td>
					    <td>키워드</td>
					    <td> </td>
					  </tr>
					  <tr>
					    <td>2</td>
					    <td>retstart</td>
					    <td>int</td>
					    <td>Y</td>
					    <td> </td>
					    <td>현재페이지</td>
					    <td> </td>
					  </tr>
					  <tr>
					    <td>3</td>
					    <td>retmax</td>
					    <td>int</td>
					    <td>Y</td>
					    <td> </td>
					    <td>페이지당레코드 수</td>
					    <td> 최대 50개를 넘지 않습니다.</td>
					  </tr>
					  <tr>
					    <td>4</td>
					    <td>author</td>
					    <td>string</td>
					    <td>Y</td>
					    <td> </td>
					    <td>저자명</td>
					    <td></td>
					  </tr>
					  <tr>
					    <td>5</td>
					    <td>subject</td>
					    <td>string</td>
					    <td>Y</td>
					    <td> </td>
					    <td>주제명</td>
					    <td></td>
					  </tr>
					  <tr>
					    <td>6</td>
					    <td>pubYearStart</td>
					    <td>string</td>
					    <td>Y</td>
					    <td> </td>
					    <td>출판연도 시작</td>
					    <td></td>
					  </tr>
					  <tr>
					    <td>7</td>
					    <td>pubYearEnd</td>
					    <td>string</td>
					    <td>Y</td>
					    <td> </td>
					    <td>출판연도 끝</td>
					    <td></td>
					  </tr>
					</tbody>
				</table>


				<ul class="list_full_2">
					<li class="list_number2">kSearch Output</li>
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
					<thead>
					<tbody id="bodyInfo">
						<tr>
						  <td>1</td>
						  <td>totalCnt</td>
						  <td>int</td>
						  <td>N</td>
						  <td>pageSize</td>
						  <td>전체 레코드 수</td>
						</tr>
						<tr>
						  <td>2</td>
						  <td>ARTCTRLNO</td>
						  <td>int</td>
						  <td>N</td>
						  <td>논문제어번호</td>
						  <td> </td>
						</tr>
					</tbody>
				</table>
				
				
				
				<div class="btn-group">
					<span class="application">예시 : http://library.nih.go.kr${ctxt}/srv/openapi/kSearch.do?kwd=cell&retstart=1&retmax=10</span>
					<a href="javascript:fn_openApiPop();" class="basic-btn">XML결과 보기</a>
				</div>
			<!-- kSearch End -->
		</div>
	</div>
	</div>
	
	<form name ="apiForm">
		<input type="hidden" id="kwd" name="kwd" value="cell" alt="키워드">
		<input type="hidden" id="retstart" name="retstart" value="1" alt="시작p">
		<input type="hidden" id="retmax" name="retmax" value="10" alt="종료p">
	</form>
	