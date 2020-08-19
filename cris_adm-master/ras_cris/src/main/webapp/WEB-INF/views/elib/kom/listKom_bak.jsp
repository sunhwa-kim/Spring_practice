<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>

	function fn_search(){
		location.href="${ctxt}/elib/kom/listArticle.do?keyword="+$('#keyword').val();
		
	}
	function fn_adSearch(){
		location.href="${ctxt}/elib/kom/adSearch.do";
	}
	
	$(function() {	
		
		$("#div_sch").dialog({ 
			//이벤트 발생했을때 보여주려면 autoOpen : false로 지정해줘야 한다.
			autoOpen: false, 
			//레이어팝업 넓이 
			width: 900, 
			height : 900,
			//뒷배경을 disable 시키고싶다면 true 
			modal: true, 
			//버튼종류
			buttons: [ { 
				//버튼텍스트 
				text: "Ok",
				//클릭이벤트발생시 동작
				click: function() { 
					$( this ).dialog( "close" );
					} 
			}, 
			{ 
				//버튼텍스트
				text: "Cancel", 
				//클릭이벤트발생시 동작 
				click: function() {
					$( this ).dialog( "close" ); 
					} 
			} 
			]
		});
	});
	
</script>

<style>
#divUcont_cont{
    font-family: sans-serif !important;
    font: 80.5%/1.3846 arial,helvetica,clean,sans-serif;
    overflow:hidden;
}

/* .green_window { */
/* 	display: inline-block; */
/* 	width: 366px; height: 34px; */
/* 	border: 3px solid #554246; */
/* 	background: white; */
/* } */
.input_text {
	width: 348px; height: 21px;
	margin: 6px 0 0 9px;
	border: 0;
	line-height: 21px;
	font-weight: bold;
	font-size: 16px;
	outline: none;
}
.sch_smit {
	width: 54px; height: 40px;
	margin: 0; border: 0;
	vertical-align: top;
	background: #554246;
	color: white;
	font-weight: bold;
	border-radius: 1px;
	cursor: pointer;
}
.sch_smit2 {
	width: 70px; height: 40px;   
	margin: 0; border: 0;
	vertical-align: top;
	background: #554246;
	color: white;
	font-weight: bold;
	border-radius: 1px;
	cursor: pointer;
}
.sch_smit:hover {
	background: #554246;
}
#container-wrap{height: 100% !important;}

</style>

<div class="sub_center_text">
     <div class="sub_center_nav"> 
      <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
      <span> > </span> 
      <span>전자자원</span>
      <span> > </span>
      <span class="active">KoreaOpenMed</span>        
     </div>
       <div class="sub_center_wrap">
        <a href="#" class="center_text_01">KoreaOpenMed</a>
	</div>
</div> 
<div class="under_bar"></div>

<div class="openmed_content_wrap">
			
			<div class="openmed_search_wrap">
				<span class='openmed_search'>
					<input type='text' class='input_text' id="keyword" name="keyword" onkeypress="javascript:if(event.keyCode==13){fn_search();}" />
				</span>
				<button type='submit' class='sch_smit' onclick="fn_search()">search</button>
				
				<div class="openmed_list2">
					<a class="openmed_a advanced_search" href="javascript:fn_adSearch()">Advanced Search</a>
					<a class="openmed_a limits" href="${ctxt}/elib/kom/listJunal.do">Journal list</a>
				</div>		
			</div>
				
		<div class="openmed_content">
			<div class="openmed_total_cnt">
				<div>${total_cnt} Articles are in the KoreaOpenMed</div>
			</div>


			<div class="openmed_field_wrap">
				<div class="openmed_field">journals in the fields by :</div>
					<c:forEach var="item" items="${sub_cls}">
							<div class="openmed_item">
								<a class="openmed_a" href="${ctxt}/elib/kom/listJunal.do?vocatermid=${item.VOCATERMID}">${item.VOCATERMNAMEENG} (${item.CNT})</a>
							</div>
					</c:forEach>
			</div>
		</div>
		
</div>