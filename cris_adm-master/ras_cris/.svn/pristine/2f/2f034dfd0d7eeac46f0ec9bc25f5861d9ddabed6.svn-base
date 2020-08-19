<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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


function fn_page(param){
	$('#hopeno').val(param);
	var form=document.reqForm;
	form.action="${ctxt}/mylib/hopeLib/hopeLibDetail.do";
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
		params.all_search_yn = all_search_yn;
		
    $.ajax({
        url: '${ctxt}/srv/hope/hopeRead.do',
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
					var dataId = obj.find('data_center_id').text();
					var order_sn = obj.find('order_sn').text();
					var hopeno = obj.find('hopeno').text();
					var jobgubun = obj.find('jobgubun').text();
					var title = obj.find('title').text();
					var author = obj.find('author').text();
					var publisher = obj.find('publisher').text();
					var hopedate = obj.find('hopedate').text();
					var processstate = obj.find('processstate').text();
					
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					html += '<tr>';
					html += ' <td style="text-align: center"> '+ order_sn +'</td>';
					if(jobgubun == 'm'){
						html += ' <td style="text-align: center"> '+ '단행본' +'</td>';
					}else if(jobgubun == 'k'){
						html += ' <td style="text-align: center"> '+ '비도서' +'</td>';
					}else if(jobgubun == 'e'){
						html += ' <td style="text-align: center"> '+ 'E-Book' +'</td>';
					}
					
					//html += ' <td> '+ '<a href="/mylib/hopeLib/hopeLibDetail.do?hopeno='+ hopeno +'">' + title + '</a>' +'</td>';
					html += '<td style="text-align:left">';
					if(obj.find('title').text().length>50){
						html += '<a href="javascript:fn_page(\''+hopeno+'\')" >'+obj.find('title').text().substr(0,50)+"..." +'</a></td>';
					}else{
						html += '<a href="javascript:fn_page(\''+hopeno+'\')" >'+obj.find('title').text() +'</a></td>';
					}
					
					html += ' <td style="text-align: center"> '+ author +'</td>';
					html += ' <td style="text-align: center"> '+ publisher +'</td>';
					html += ' <td style="text-align: center"> '+ hopedate + '</td>';
					html += ' <td style="text-align: center"> '+ processstate + '</td>';
					html += '</tr>';
					 
		        });
				//페이징처리
			    $('#paging').paging({
			    	
					 current:cuurPage
					,max:pageTotalCnt
					,length:pageLen
					,onclick:function(e,page){
						cuurPage=page;
						fn_search(cuurPage);
					}
				});
				$("#topInfo").html("<span class = 'gray'>["+ cuurPage +" / "+pageTotalCnt+" Pages]</span>  <span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.");
			    $("#bodyInfo").html(html);
			  
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/						 
				
				$('#paging').children().remove();
				$("#topInfo").html("<span class = 'gray'>[1 / 1 Pages]</span> <span class = 'txt-red' > 0 </span> 건이 검색되었습니다.");
				$("#bodyInfo").html('<tr><td colspan="7" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}
function checkInput(offer)
{
	var keyword = new Array("로그인 후 신청하세요!","자료형태를 선택해 주세요.","서명을 입력하여 주십시요!","저자를 입력하여 주십시요!","발행처를 입력하여 주십시요!","ISBN을 10자리 이상 정확히 입력하여 주십시요!","처리중 입니다!");
	var IS_SUBMIT = false;
/*   if("${loginVO.emplyrnm}"==""){
	  alert(keyword[0]);
	  return false;
  } */
  
  if( !IS_SUBMIT )	{
	if($(':radio[name="jobGubun"]:checked').length < 1){
		alert(keyword[1]);
		$('#jobGubun1').focus();
		return false;
	}

	if(offer.title.value.length == 0) {
		alert(keyword[2]);
		offer.title.focus();
		return false;
	}
	
	if(offer.author.value.length == 0) {
		alert(keyword[3]);
		offer.author.focus();
		return false;
	}

	if(offer.publisher.value.length == 0) {
		alert(keyword[4]);
		offer.publisher.focus();
		return false;
	}
	/*
	if(offer.publisherYear.value.length == 0) {
		alert("발행년도를 입력하여 주십시요!");
		offer.publisherYear.focus();
		return false;
	}
	
	if(offer.isbn.value.length == 0) {
		alert("ISBN은 필수입력 항목입니다.");
		offer.isbn.focus();
		return false;
	}
	*/
	if(offer.isbn.value.length > 0 &&  offer.isbn.value.length < 10) {
			alert(keyword[5]);
			offer.isbn.focus();
			return false;
	}
	
	IS_SUBMIT = true;	
	offer.submit();

  }	else {
	  alert(keyword[6]);

  }			
}
$(function(){
	//tab		
	$("ul.tabs li").eq(1).addClass("active").css("color", "#003964");
    $("ul.tabs li").eq(0).click(function(){
    	location.href="${ctxt}/mylib/applyView/applyOrgList.do";
    })
    $("ul.tabs li").eq(1).click(function(){
    	location.href="${ctxt}/mylib/hopeLib/hopeLibList.do";
    })
});
</script>
<style>	
	.tabContainer {
		display:none;
	}
	ul.tabs li{
		width:auto; 
		padding:0 15px;
	}
	@media all and (max-width:990px){
		.tabContainer{
			display:block;
			margin-bottom: 12px;
		}
		#topInfo{
			margin-top:28px;
		}
	}
	@media (max-width: 768px){
		#topInfo {
		    margin: 55px 0 9px 0;
		    transition: all 0.3s;
		    -webkit-transition: all 0.3s;
		}
	}
	@media all and (max-width:444px) {
		.tabContainer>.tabs>li{
			width:50%;
			padding:0;
			font-size:12px;
		}
	}
</style>
<form name="reqForm" method="post">
		<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>My Library</span>
			<span> > </span>
			<span class="active">희망도서 신청 조회</span>        
		</div>
		<span class="center_text_01">희망도서 신청 조회</span>
		</div> 
		<div class="under_bar"></div>
		
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div class="tabContainer"> 		
					<ul class="tabs">
						<li rel="tab1" style="box-sizing:border-box;" onclick="">원문복사 신청 조회</li>
						<li rel="tab2" style="box-sizing:border-box;" onclick="">희망도서 신청 조회</li>				    
					</ul>
					<div class="tab_container" style="width:100%; box-sizing:border-box;"></div>
				</div>
		        <div id="search-group">
		        	<div class="search-input">
						<select id="searchCondition" name="searchCondition" title="분류" style="min-width: 90px;">
							<option value="all">전체</option>
							<option value="jobgubun">도서구분</option>
							<option value="title">제목</option>
							<option value="author">저자</option>
							<option value="publisher">출판사</option>
						</select>
						<input type="text" id="searchKeyword" name="searchKeyword" value="${hopeVo.searchKeyword}" onkeydown="fn_enter_search(this);" placeholder="검색어를 입력하여 주십시오."/>
		            	<input type="button" id="btnSearch" value="검색" onclick="javascript:fn_search(1)"/>
					</div>
				</div>
			
			<p id="topInfo"></p>
					
			<table class="basic_table">
				<caption>
					도서 신청처리 결과 - 번호,도서구분,서명,저자,출판사,신청일,상태
				</caption>
				<colgroup>
					<col style="width:7%">				
					<col style="width:10%">
					<col style="width:30%">
					<col style="width:15%">
					<col style="width:15%">
					<col style="width:15%">
					<col style="width:10%">
				</colgroup>
				
				<thead>
					<tr>
						<th scope='col'>번호</th>
						<th scope='col'>도서구분</th>
						<th scope='col'>서명</th>
						<th scope='col'>저자</th>		
						<th scope='col'>출판사</th>										
						<th scope='col'>신청일</th>										
						<th scope='col'>상태</th>										
					</tr>
				</thead>
				<tbody id = 'bodyInfo'>
					
				</tbody>
			</table>
			<div id="paging" class="paginate" ></div>
				
	</div>
	</div>
	</div>
	
	<!-- 추가 PARAM -->
	<input type="hidden" id="messege" name="messege" value="${messege}" alt="message">
	<input type="hidden" name="edc_progrm_id" id="edc_progrm_id" value="${eduVo.edc_progrm_id}" alt="data_center_id" />
 	<input type="hidden" name="hopeno" id="hopeno" value="" alt="희망도서id" />
 	<input type="hidden" name="page" id="page" value="${hopeVo.page}" alt="pageNum" /> 
 	<input type="hidden" name="searchOption" id="searchOption" value="${hopeVo.searchCondition}" alt="콤보param" /> 
 	
 	<!-- 공통  필수 PARAM -->
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/>
	
	
	
</form>