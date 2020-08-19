<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="${ctxt}/resources/js/jqcloud/jqcloud-1.0.4.js"></script>
<link rel="stylesheet" href="${ctxt}/resources/css/jqcloud.css" type="text/css" media="screen">

<script>
function cutByLen(str, maxByte) {

	for(b=i=0;c=str.charCodeAt(i);) {

	b+=c>>7?2:1;

	if (b > maxByte)

	break;

	i++;

	}

	return str.substring(0,i);

}
	
	
	function fn_search(){
		// 2018.12.04 appscan 조치
		
		var form = document.komForm;   
		$('#komQuery').val($('#keyword').val());  
		form.action="${ctxt}/elib/kom/listArticle.do";
		form.submit(); 
	}
	   
	function fn_adSearch(){
		location.href="${ctxt}/elib/kom/adSearch.do";
	}
	
	function fn_recentlyPage(){
		location.href="${ctxt}/elib/kom/listArticle.do?searchSort=recent&top10=Y";
	}
	
	function fn_link(obj){
		var form = document.komForm;   
		$('#komQuery').val(obj);  
		form.action="${ctxt}/elib/kom/listArticle.do";
		form.submit(); 
	}     
	
	$(function() {	
		var some_words = new Array();
			
		$('.tc_list').each(function(cnt){
			var strLink = "javascript:fn_link('"+$(this).attr('value')+"')";
			var strWeight = 0.7 - (cnt * 0.15);
			some_words.push({text: $(this).attr('value'), weight: strWeight, link: {href: strLink} })
		});

		  $("#container").jQCloud(some_words);
		
		   
		
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

	.sideArea.left_box3 {
		width:100%;
		height:360px;
		padding-bottom:30px;
		background: /* url(../../../resources/images/sub/komBook.png) no-repeat; */none;
		background-size: 398px 251px;	
		background-position:center bottom;
	}
	.ci{
		float:left;
	}
	.ci>img{
		width:125px;
	}
	.openmed_search_wrap{
		width:100%;
		max-width:550px;
		height:77px;
		position:relative;
		text-align:center;
		margin:0 auto;
	}
	.content_box>.content_list>.left_box2>.left_box3.height_139{
		width:100%;
		padding:0;
	}
	.content_box>.content_list>.left_box2>.left_box3 {
    
    border: 0px solid #E7E7E7;
    margin: 0 auto;
    box-shadow: none;
    padding: 10px;
}
	.openmed_search{
		float:left;
		width:83%;
	}
	.openmed_list2{
		width:83%;
		margin:0;
	}
	.openmed_a.limits{
		position:absolute;
		right:17%;
	}
	.sch_smit{
		float:right;
		width:13%;
	}
	.top10_article{
		padding:7px 15px;
		border:1px solid #ccc;
		background:#003964;
		color:#fff;
		font-size:14px;
		transition:all 0.5s;
		-webkit-transition:all 0.5s; 
		font-weight:300;
	}
	.top10_article:hover{
		background:#fff;
		transition:all 0.3s;
		-webkit-transition:all 0.3s; 
		
	}
	.left_box3.height_139{
		height:100px;
	}
	.content_box>.content_list>.left_box2{
		width: 100%;
		max-width:640px;
		margin:0 auto;
    	float: none;
	}
	.openmed_total_cnt{
		margin-bottom:3px;
	}
	.sub_archive_wrap{
		border: 1px solid #E7E7E7;
	}
	
	@media all and (max-width:833px) {
		.sch_smit{
			width:11%;
		}
	}
	@media all and (max-width:682px) {
		.sub_archive_wrap{
			border: 0px solid #E7E7E7;
		}
	}
	@media all and (max-width:503px) {
		.sch_smit {
		    width: 48px;
		    font-size: 12px;
		    transition: all 0.2s;
		    -webkit-transition: all 0.2s;
		}
	}
	@media all and (max-width:380px) {
		.openmed_search {
		    width: 80%;
			transition: all 0.2s;
		    -webkit-transition: all 0.2s;
		}
		.openmed_list2{
			width: 80%;
			transition: all 0.2s;
		    -webkit-transition: all 0.2s;
		}
		.sch_smit{
			width:15%;
		}
	}
	@media all and (max-width:437px) {
		.openmed_a.advanced_search{
			margin-left:15px;
		}
		.openmed_a.limits{
			
		}
		
	}
	
	
</style>


<div class="sub_center_text">
     <div class="sub_center_nav"> 
      <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
      <span> > </span> 
      <span>전자자원</span>
      <span> > </span>
      <span class="active">Korea OpenMed</span>        
     </div>

    <!--  <span href="#" class="center_text_01">Korea Open Med</span> -->

</div> 
<div class="under_bar"></div>
<!-- 아카이브 소개 목록 -->
<div class="content_wrap">
	<div class="content_box">
		<div class="content_list">
			<div class="left_box2">
				<div class="left_box3 height_139" style="margin-bottom:0;box-shadow:none;border:0;">
					<div class="sub_archive_wrap" style=""> 		
						<div class="openmed_total_cnt">
							<div class="sidebar-right-text2" style="text-align:center; font-size:25px;padding-top:10px;"><span>Korea<span><img src="${ctxt}/resources/images/sub/o.png" style="width:30px; margin-left:10px;margin-bottom:-3px;"></span>penMed</span></div>
						</div>
						<%-- <div class="ci"><img src="${ctxt}/resources/images/sub/ci3.png"></div> --%>
						<!-- <div class="under_bar3"></div>	 -->
						<div class="openmed_search_wrap" >
							<span class='openmed_search'>
								<input type='text' class='input_text' id="keyword" name="keyword" onkeypress="javascript:if(event.keyCode==13){fn_search();}" />
							</span>
							<button type='submit' class='sch_smit' onclick="fn_search()"><i class="fas fa-search"></i></button>
							
							<div class="openmed_list2" style="">
								<a class="openmed_a advanced_search" href="javascript:fn_adSearch()">Advanced Search</a>
								<a class="openmed_a limits" href="${ctxt}/elib/kom/listJunal.do">Journal list</a>
							</div>		
						</div>		
					</div>
				</div>
				<div class = "sideArea left_box3 "style="margin:0; margin-top:30px;">
			<%-- 		<div class="sidebar-right-text2">
						<span  style="vertical-align: middle">Popular searches<a href="javascript:fn_topDownloadPage()"><img src="${ctxt}/resources/images/sub/more_ico.gif" style="vertical-align: middle;float: right;margin-right: 10px;margin-top: 7px;"/></a> </span>
					</div>
						<div class="under_bar3"></div> --%>
					<div style="width : 98%;  height: auto;">
						<ul id="topDown_list" class="flist">
							<c:forEach var="hotSearchList" items="${hotData}" varStatus="status">
								<li id="hotKeyword${status.index}" class="tc_list" style="display: none;" value="${hotSearchList.keyword}">${hotSearchList.ranking }. ${hotSearchList.keyword}</li>
							</c:forEach>		
						</ul>
					</div>
					<div id="container" style="width:97%;height: 97%;margin:1% auto;"></div>
				</div>
				<%-- <div class="left_box3" style="height:259px;">
					<div class= "sub_arch
					ive_wrap">				
						<div class="openmed_total_journals">
							<div class="sidebar-right-text2">Journals in the fields by :</div>
						</div>
						<div class="under_bar3"></div>	
						<c:forEach var="item" items="${sub_cls}">
								<ul class="flist">
									<li style="line-height:21.7px; height:21.7px;"><a href="${ctxt}/elib/kom/listJunal.do?vocatermid=${item.VOCATERMID}">${item.VOCATERMNAMEENG} (${item.CNT})</a></li>
								</ul>
						</c:forEach>
				    </div><!-- 데이터 구성 END -->	
				</div> <!-- 아카이브 소개 목록 끝 --> --%>  
			</div>
			<!--<div id="sidebar-right2">
				<!-- <div class = "sideArea height_139" style="padding:20px 10px 0 10px;"> -->
					<%-- <div class="sidebar-right-text2">
						<span  style="vertical-align: middle">Recently Articles<a class="more" href="javascript:fn_recentlyPage()"><!-- <img src="${ctxt}/resources/images/sub/more_ico.gif" style="vertical-align: middle;float: right;margin-right: 10px;margin-top: 7px;"/> -->more +</a> </span>	
					</div>
					<div class="under_bar3"></div>
					<div style="width : 98%;  height: auto;">
						<ul id="recently_list" class="flist">
						
							<c:forEach var="list" items="${recently_list}" varStatus="status">
								<li><a href="${ctxt}/elib/kom/articleDtl.do?artctrlno=${list.ARTCTRLNO}"> ${list.DATA_SEQ }. ${list.TITLE}</a></li>
							</c:forEach>	
						</ul>
					</div> --%>
					 <!-- <div class="sidebar-right-text2" style="text-align:center;margin:20px 0 20px 0;font-size:18px;">
						<span>What's Hot on Korea OpenMed? </span>	
					</div>
					
					<div style="text-align:center">
						<a href="javascript:fn_recentlyPage()" class="top10_article">Click for TOP10 articles of the week</a>
					</div>
				</div> -->
				<%-- <div class = "sideArea"style="margin:0; height:259px;">
					<div class="sidebar-right-text2">
						<span  style="vertical-align: middle">Popular searches<a href="javascript:fn_topDownloadPage()"><img src="${ctxt}/resources/images/sub/more_ico.gif" style="vertical-align: middle;float: right;margin-right: 10px;margin-top: 7px;"/></a> </span>
					</div>
						<div class="under_bar3"></div>
					<div style="width : 98%;  height: auto;">
						<ul id="topDown_list" class="flist">
							<c:forEach var="hotSearchList" items="${hotData}" varStatus="status">
								<li id="hotKeyword${status.index}" class="tc_list" style="display: none;" value="${hotSearchList.keyword}">${hotSearchList.ranking }. ${hotSearchList.keyword}</li>
							</c:forEach>		
						</ul>
					</div>
					<div id="container" style="width:97%;height: 97%; border: 1px solid #ccc; margin:1% auto;"></div>
				</div> 
			</div>--%>
		</div>
	</div>
</div>
<!-- rightMenu -->
<!--검색제한-->

<!--검색제한 끝-->
	<!-- 추가 PARAM -->
	<input type="hidden" id="messege" name="messege" value="${messege}" alt="message">
 	    
 	<!-- 공통  필수 PARAM -->  
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/>
	
	<form id="komForm" name="komForm" action="" method="post">
   		<input type="hidden" id="komQuery" name="searchQuery" value=""/>  	
	</form>