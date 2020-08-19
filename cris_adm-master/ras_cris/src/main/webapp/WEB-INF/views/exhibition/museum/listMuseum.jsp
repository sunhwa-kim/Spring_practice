<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

var xmlList;
var html="";
var cuurPage;
var pageTotalCnt = 0;
var dataTotalCnt = 0;

$(function(){
	  
	if($("#messege").val() != ''){
    	fn_alert( $("#messege").val());
    }
    $("#messege").val('');
	
    var page =$('#page').val();
	if(page == '' ){
		page=1;
	}
	
 var searchOption = $("#searchOption").val();
 
	if(searchOption != '' ){
		$('#searchCondition option[value='+searchOption+']').attr('selected',true);
	}
	
	// 화면 목록 조회
	fn_search(page);
	 
});

//상세화면 조회
function fn_page(museum_id){
	
	$('#museum_id').val(museum_id);
	var form=document.reqForm;
	form.action="${ctxt}/centerintro/museum/museumView.do?museum_id="+museum_id;
	form.submit();
	
}

function fn_search(page){
	
	//현재 페이지 세팅
	cuurPage= page;
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/

	$('#page').val(cuurPage);
		
	$('#searchCondition').val($('#searchCondition option:selected').val());
		
	var params = {};
  		params.page=cuurPage;
		params.searchKeyword = $('#searchKeyword').val();
		params.searchCondition = $('#searchCondition option:selected').val();
				
    $.ajax({
        url: '${ctxt}/exhibition/museum/museumRead.do',
        data: params,
        type: 'POST',
        dataType: 'text',
        cache: false,
        success: function(rtnXml) {
   
        	xmlList = $(rtnXml).find('item');

        	pageTotalCnt=0;
        	dataTotalCnt=0;
        	
        	html="";
			if(xmlList.length > 0){
				//총페이지수
				pageTotalCnt = Number($(rtnXml).find('totalPageCnt').text());
				dataTotalCnt = Number($(rtnXml).find('totalDataCnt').text());
				
				xmlList.each(function(cnt){
			
					var obj = $(this);
					var dataId = obj.find('museum_id').text();
					
					var atch_file_id = obj.find('atch_file_id').text();
					var file_sn= 0; // 파일 순번 
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					html += '<ul style="margin-bottom:20px; box-sizing:border-box; width:100%;">';
					html += '<li class="image_box"><img class="pic" src="${ctxt}/cmmn/mainPopup/getImage.do?atch_file_id='+atch_file_id+'&file_sn='+ file_sn + '" alt="pop" title="pop"><p><i class="fas fa-camera-retro" onclick="imgSizeUp(\''+ atch_file_id +'\')"></i></p></li>';
					if(obj.find('sj').text().length>50){
					html += '<li class="text_box"><div class="list_title" style="margin-bottom:10px;"><p>'+obj.find('museum_sj').text().substr(0,50)+"..." +'</p></div>';
					}else{
						html += '<li class="text_box"><div class="list_title" style="margin-bottom:10px;"><p>'+obj.find('museum_sj').text()+'</p></div>';
					}
					html += ' <ul style="border-top: 1px solid rgba(51,122,183,0.5);"> ';
					html += ' <li class="title"><span class="left" style="letter-spacing:22px;">국적</span><span> '+ obj.find('museum_country').text() + '</span></li>';
					html += ' <li class="title"><span class="left" style="letter-spacing:22px;">시대</span><span class="sp">'+ obj.find('museum_age').text() + '</span></li>';
					html += ' <li class="title"><span class="left" style="letter-spacing:-1px;">전시장소</span><span>'+ obj.find('museum_loc').text() + '</span></li>';
					html += ' <li class="title"><span class="left" style="letter-spacing:22px;">설명</span><span class="sp">'+ obj.find('museum_cn').text().substr(0, 50) + '  ...  ' +'</span></li>';
					//html += ' <li class="tx3"><img src="/resources/images/_ncmik/ptl/search/btn_view.gif" onclick="fn_page(\''+obj.find('museum_id').text()+'\')" style="cursor:pointer"></li>';
					html += ' <li class="view_btn"><a class="basic-btn" style="text-decoration:none;" onclick="fn_page(\''+obj.find('museum_id').text()+'\')"><i class="fas fa-search-plus"></i></a></li>';
					html += ' </ul> ';
					html += ' </li> ';
					html += ' </ul> ';
					 

					
		        });
				//페이징처리
			    $('#paging').paging({
			    	
					 current:cuurPage
					,max:pageTotalCnt
					,length:pageLen
					,onclick:function(e,page){
						cuurPage=page;
						
						
						$("#searchKeyword").val("");
						$("#searchCondition").val("ALL");
						
						fn_search(cuurPage);
					}
				});
				$("#topInfo").html("<span class= 'gray'>["+ cuurPage +" / "+pageTotalCnt+" Pages]</span><span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.");
			    $("#bodyInfo").html(html);
			  
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/						 
				$("#searchKeyword").val("");
				$("#searchCondition").val("ALL");
				
				$('#paging').children().remove();
				
				$("#topInfo").html("<strong>[1 / 1 Pages] <span class = 'txt-red' > 0 </span> 건이 검색되었습니다.</strong>");
				
				$("#bodyInfo").html('<tr><td colspan="5" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}


function imgSizeUp(atch_file_id){
	window.open('${ctxt}/cmmn/mainPopup/getImage.do?atch_file_id='+atch_file_id+'&file_sn='+ 0 ,'_pop','width='+1000+',height='+600+',left='+300+',top='+200+',resizable=0,scrollbars=1');
}

$(function(){
	//tab		
	$("ul.tabs li").eq(1).addClass("active").css("color", "#003964");
    $("ul.tabs li").eq(0).click(function(){
    	location.href="${ctxt}/centerintro/exhibitIntro/galleryIntro.do";
    })
    $("ul.tabs li").eq(1).click(function(){
    	location.href="${ctxt}/centerintro/museum/listMuseum.do";
    })
    $("ul.tabs li").eq(2).click(function(){
    	location.href="${ctxt}/centerintro/spexhbtn/listSpexhbtn.do";
    })
    $("ul.tabs li").eq(3).click(function(){
    	location.href="${ctxt}/centerintro/online/onlineExhibit.do";
    })
});	

</script>


<style>
.museum>ul>li>ul>li.view_btn>.basic-btn,
.spexhbtn>ul>li>ul>li.view_btn>.basic-btn{
	width:38px;
	min-width:38px;
	padding:0;
}
@media all and (max-width:790px) {
	.museum ul .image_box, .spexhbtn ul .image_box{
		margin:10px;
	}
	.museum ul li.text_box, .spexhbtn ul li.text_box{
		width:63%;
		margin:10px;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;sear
	}
}
@media all and (max-width:720px) {
	.museum ul li.text_box,
	.spexhbtn ul li.text_box{
		width:60%;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
}
@media all and (max-width:700px) {
	.museum ul .image_box, .spexhbtn ul .image_box {
	    width: 96%;
	    min-width: 96%;
	    position: relative;
	    float: none;
	    margin:10px 2%;
	    transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
	.museum ul li.text_box, .spexhbtn ul li.text_box{
		width: 96%;
		margin:10px 2%;
		float: none;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
	.content_box .content_list .list_title{
		text-align:center;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
}		
@media all and (max-width: 600px){
	.museum>ul>li>ul>li.view_btn>.basic-btn,
	.spexhbtn>ul>li>ul>li.view_btn>.basic-btn {
	    color: #003964;
	    width:30px;
		min-width:30px;
	    line-height: 30px;
	    padding: 0px;
	    font-size: 12px;
	    transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
	.museum>ul>li>ul>li.view_btn>.basic-btn:hover,
	.spexhbtn>ul>li>ul>li.view_btn>.basic-btn:hover{
		color:#fff;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
}
@media all and (max-width: 560px){
	.museum>ul>li>ul>li.view_btn, .spexhbtn>ul>li>ul>li.view_btn {
	    position: relative;
	    transition:all 0.3s;
		-webkit-transition:all 0.3s;
		text-align:center;
		border-top:1px solid rgba(51,122,183,0.5);
	}
	.museum ul li.text_box>ul, .spexhbtn ul li.text_box>ul{
		padding-top:0;
	}
}
@media (max-width: 502px){
	#topInfo {
   		margin:45px 0 9px 0;
   	}
   	#search-group{
   		top:15px;
   	}
}

.tabContainer{
		padding-top:40px;
		display:none;
}
ul.tabs>li:first-child{
	margin-left:40px;
}
ul.tabs li{
	width:auto; 
	padding:0 15px;
}
@media all and (max-width:990px){
	.tabContainer{
		display:block;
	    padding: 40px 40px 0 40px;
	}
	ul.tabs>li:first-child{
		margin-left:0px;
	}
}
@media all and (max-width:502px) {
	ul.tabs>li:first-child{
		margin-left:0px;
	}
}
@media all and (max-width:494px) {
	.box{
		
	}
	.tabContainer{
	    padding: 10px;
	}
}
@media all and (max-width:444px) {
	.tabContainer>.tabs>li{
		width:25%;
		padding:0;
		font-size:12px;
	}
}


</style>
<form name="reqForm">
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>전시관</span>
			<span> > </span>
			<span class="active">박물 자료</span>        
		</div>
		<span class="center_text_01">박물 자료</span>
	</div>
	<div class="under_bar"></div>
	<div class="box">	
	<div class="tabContainer"> 		
				<ul class="tabs">
					<li rel="tab1" style="box-sizing:border-box;">전시관소개</li>
					<li rel="tab2" style="box-sizing:border-box;">박물자료</li>
					<li rel="tab3" style="box-sizing:border-box;">기획전시</li>
					<li rel="tab3" style="box-sizing:border-box;">온라인전시관</li>					    
				</ul>
				<div class="tab_container" style="width:100%; box-sizing:border-box;"></div>
			</div>
	<div class= "content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div id="search-group">
	        		<div class="search-input">
						<label for="searchComboBox"></label>
						<select id="searchCondition" name="searchCondition" title="분류">
							<option value="ALL">전체</option>
							<option value="sj">제목</option>
							<option value="cn">설명</option>
						</select>
						<label for="searchBox"></label>
						<input type="text" id="searchKeyword" name="searchKeyword" placeholder="검색어를 입력하여 주십시오." value="${museumVo.searchKeyword}" onkeydown="fn_enter_search(this);"/>
		            	<input type="button" id="btnSearch" value="검색" onclick="javascript:fn_search(1)"/>
					</div>
				</div>
			
				<p id="topInfo"></p>
				
				<div id="bodyInfo" class="museum">
					

				</div>
				<div id="paging" class="paginate"></div>
			</div>
		</div>
	</div>
	</div>





		<%-- <div class="content_wrap">
			<div class="search_wrap">
		        <div id="search-group">
	        		<div class="search-input">
						<label for="searchComboBox"></label>
						<select id="searchCondition" name="searchCondition" title="분류">
							<option value="ALL">전체</option>
							<option value="sj">제목</option>
							<option value="cn">설명</option>
						</select>
						<label for="searchBox"></label>
						<input type="text" id="searchKeyword" name="searchKeyword" placeholder="검색어를 입력하여 주십시오." value="${museumVo.searchKeyword}" onkeydown="fn_enter_search(this);"/>
		            	<input type="button" id="btnSearch" value="검색" onclick="javascript:fn_search(1)"/>
					</div>
				</div>	
			</div>

			<div id="bodyInfo" class="museum"></div>
			<div id="paging" class="paginate"></div>
  		</div> --%>
	
	
	
	<!-- 추가 PARAM -->
	<input type="hidden" id="messege" name="messege" value="${messege}" alt="message">
	<input type="hidden" name="page" id="page" value="${museumVo.page}" alt="pageNum" /> 
	<input type="hidden" name="museum_id" id="museum_id" value="${museumVo.museum_id}" alt="museum_id" />
	<input type="hidden" name="searchOption" id="searchOption" value="${museumVo.searchCondition}" alt="콤보param" /> 
 	
 	<!-- 공통  필수 PARAM -->
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/>
	
	
	
</form>