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

	$('#prono').val(param);
	var form=document.reqForm;
	form.action="${ctxt}/mylib/applyView/applyOrgView.do";
	form.submit();
	
}


function fn_search(page){
	//현재 페이지 세팅
	cuurPage= page;
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/

	$('#page').val(cuurPage);


	var params = {};
  		params.page=cuurPage;
		params.searchKeyword = $('#searchKeyword').val();
		params.searchCondition = $('#searchCondition option:selected').val(); 
		params.all_search_yn = all_search_yn; 
		
    $.ajax({
        url: '${ctxt}/mylib/applyView/applyOrgRead.do',
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
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					var prono = obj.find('prono').text();					
					
					html += '<tr>';
					html += ' <td style ="text-align:center;">'+obj.find('order_sn').text() +'</td>';
					
					html += '<td style="text-align:left">';
					
					if(obj.find('arttitle').text().length>50){
						html += '<a href="javascript:fn_page(\''+prono+'\')" >'+obj.find('arttitle').text().substr(0,50)+"..." +'</a></td>';
					}else{
						html += '<a href="javascript:fn_page(\''+prono+'\')" >'+obj.find('arttitle').text() +'</a></td>';
					}
					
					html += ' <td style ="text-align:center;">'+obj.find('author').text() +'</td>';
					html += ' <td style ="text-align:center;">'+obj.find('publisher').text() +'</td>';
					html += ' <td style ="text-align:center;">'+obj.find('proDate').text() +'</td>';
					html += ' <td style ="text-align:center;">'+obj.find('codeName').text() +'</td>';
					 
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
				$("#topInfo").html("<span class = 'gray'>["+ cuurPage +" / "+pageTotalCnt+" Pages]</span> <span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.");
			    $("#bodyInfo").html(html);
			  
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$('#paging').children().remove();
				$("#topInfo").html("<span class = 'gray'>[1 / 1 Pages]</span> <span class = 'txt-red' > 0 </span> 건이 검색되었습니다.");
				$("#bodyInfo").html('<tr><td colspan="6" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}

$(function(){
	//tab		
	$("ul.tabs li").eq(0).addClass("active").css("color", "#003964");
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
			<span class="active">원문복사 신청 조회</span>        
		</div>
		<span class="center_text_01">원문복사 신청 조회</span>
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
					<label for="searchCombo"></label>
					<select id="searchCondition" name ="searchCondition" title="분류">
						<option value="all">전체</option>
						<option value="artTitle">논문명</option>
						<option value="author">저자</option>
						<option value="publisher">출판사</option>
					</select>
					<label for="searchBox"></label>
					<input type="text" id="searchKeyword" name= "searchKeyword" value="${orgCopyVo.searchKeyword}" onkeydown="fn_enter_search(this);" placeholder="검색어를 입력해주세요."/>
	            	<input type="button" id="btnSearch" value="검색" onclick="javascript:fn_search(1)"/>
					                		
				</div>
			</div>
			  
					<p id="topInfo"></p>
					
					<table class="basic_table">
						<caption>
						 	 원문복사서비스  - 번호,논문명,저자,출판사,신청일,상태
						</caption>
						<colgroup>
							<col style="width:7%">				
							<col style="width:45%">
							<col style="width:10%">
							<col style="width:20%">
							<col style="width:10%">
							<col style="width:7%">
						</colgroup>
						<thead>
						<tr>
							<th scope='col'>번호</th>
							<th scope='col'>논문명</th>
							<th scope='col'>저자</th>
							<th scope='col'>출판사</th>
							<th scope='col'>신청일</th>		
							<th scope='col'>상태</th>										
						</tr>
						</thead>
						<tbody id = 'bodyInfo'>
							
						</tbody>
					</table>
					
					<div id="paging" class="paginate"></div>
	
		</div>
		</div>
		</div>
		
	
	<!-- 추가 PARAM -->
	<input type="hidden" id="messege" name="messege" value="${messege}" alt="message">
	<input type="hidden" name="page" id="page" value="${orgCopyVo.page}" alt="pageNum" /> 
	<input type="hidden" name="prono" id="prono" value="" alt="원문복사id" /> 
	<input type="hidden" name="searchOption" id="searchOption" value="${orgCopyVo.searchCondition}" alt="콤보param" /> 
 	
 	
 	<!-- 공통  필수 PARAM -->
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/>
	
	
</form>