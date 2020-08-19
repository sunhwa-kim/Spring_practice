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
	
		//tab

	    
	    $("ul.tabs li").eq(2).addClass("active").css("color", "#003964");
		
	    $("ul.tabs li").eq(0).click(function(){
	    	location.href="${ctxt}/data/infoData.do";
	    })
	    $("ul.tabs li").eq(1).click(function(){
	    	location.href="${ctxt}/data/gurideData.do";
	    })
	    $("ul.tabs li").eq(2).click(function(){
	    	location.href="${ctxt}/data/listData.do";
	    })
	  
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
	
	// 탭 영역 컨트롤
	var data_center_gbn =  $('#data_center_gbn').val();
	if(data_center_gbn == ''){
		data_center_gbn = "DATA_01"
	}
		 
	if(data_center_gbn == 'DATA_01'){		
	    $(".tab-btn").eq(0).addClass("active");	   
	}else if(data_center_gbn == 'DATA_02'){
		  $(".tab-btn").eq(1).addClass("active");
	}else if(data_center_gbn == 'DATA_03'){
		  $(".tab-btn").eq(2).addClass("active");
	}else{
		  $(".tab-btn").eq(0).addClass("active");
	}
	
	$(".tab-btn").click(function () {
	
        $(".tab-btn").removeClass("active");       
        $(this).addClass("active");
    });
	//
	
	// 화면 목록 조회
	fn_search(page, data_center_gbn);
	 
});

//상세화면 조회
function fn_page(data_center_id){
	
	$('#data_center_id').val(data_center_id);
	var form=document.reqForm;
	form.action="${ctxt}/data/dataView.do";
	form.submit();
	
}



function fn_data_enter_search(param, data_center_gbn){
	var id_val = $(param).attr('id');	
	
	if(event.keyCode == 13)
	{	
		event.preventDefault();
		fn_search(1, data_center_gbn);
	}
}
	
$(function(){      
	
	
});
function fn_search(page, data_center_gbn){
	
	//현재 페이지 세팅
	cuurPage= page;
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/

	$('#page').val(cuurPage);
	
	/* if(data_center_gbn != ""){
		$('#data_center_gbn').val(data_center_gbn);
	} */
	
	$('#searchCondition').val($('#searchCondition option:selected').val());
	$('#data_center_gbn').val(data_center_gbn);

	
	var params = {};
  		params.page=cuurPage;
		params.searchKeyword = $('#searchKeyword').val();
		params.searchCondition = $('#searchCondition option:selected').val();
// 		params.data_center_gbn = $('#data_center_gbn').val();
		params.data_center_gbn = data_center_gbn;
	
		
    $.ajax({
        url: '${ctxt}/data/dataRead.do',
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
					var dataId = obj.find('data__center__id').text();
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					html += '<tr>';
					html += ' <td style ="text-align:center;">'+obj.find('order_sn').text() +'</td>';
					if(obj.find('data_center_sj').text().length>50){
					html += ' <td class= "text-left"><a href="javascript:fn_page(\''+obj.find('data_center_id').text()+'\')" >'+obj.find('data_center_sj').text().substr(0,50)+"..." +'</a></td>';
					}
					
					else{
						html += ' <td class= "text-left"><a href="javascript:fn_page(\''+obj.find('data_center_id').text()+'\')" >'+obj.find('data_center_sj').text() +'</a></td>';
							
					}
					html += ' <td style ="text-align:center;">'+obj.find('data_info').text() + '</td>';
					html += ' <td style ="text-align:center;">'+obj.find('frst_regist_pnttm').text() + '</td>';
					html += ' <td style ="text-align:center;">'+obj.find('rdcnt').text() +'</td>';
					html += '</tr>';
					 
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
						
						
						fn_search(cuurPage, data_center_gbn);
					}
				});
				$("#topInfo").html("<span class = 'gray'>["+ cuurPage +" / "+pageTotalCnt+" Pages] </span><span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.");
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


</script>

<style>

.tab-btn.list_data{
	padding:0 10px;
}
.tabContainer{
		display:none;
	}
	.content_box>.content_list ul:after{
		   display: inline;
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
@media all and (max-width:1190px) {
	.tab-btn.list_data{
		font-size:12px;	
		transition:all 0.3s;
		-webkit-transition:all 0.3s;	
	}
}
@media all and (max-width:500px) {
	.tab-btn.list_data {
	    padding: 0 7px;
		letter-spacing:-0.5px;
		font-size:11px;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
	.tab-btn {
	    min-width: 50px;
	}
}
@media all and (max-width:500px) {
	.tab-btn.list_data {
		 padding: 0 4px;
	}
	ul.tabs li{
		padding:0;
	}
}
</style>	
		

<form name="reqForm" method="post">
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>데이터센터</span>
			<span> > </span>
			<span class="active">데이터 목록</span>        
		</div>
		<span class="center_text_01">데이터 목록</span>
	</div> 
	<div class="under_bar"></div>		
 				
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
			
			<div class="tabContainer"> 
					<ul class="tabs">
				        <li rel="tab1" style="box-sizing:border-box;">소개</li>
				        <li rel="tab2" style="box-sizing:border-box;" onclick="">이용안내</li>
				        <li rel="tab3" style="box-sizing:border-box;" onclick="">데이터목록</li>				    
					</ul>
				    <div class="tab_container" style="width:100%; box-sizing:border-box; padding-top:10px;">
				        <div id="tab1" class="tab_content">
				        	<ul id ="">
				        	</ul>							            
				        </div>
				        <!-- #tab1 -->
				        <div id="tab2" class="tab_content">							        
			            	<div id ="" class="right"> 
							</div>
				        </div>
				         <!-- #tab2 -->
				        
				        <div id="tab3" class="tab_content">
			            	<div id ="" class="right"> 
							</div>
				        </div>
				        <!-- #tab3 -->
				        
				        <div id="tab4" class="tab_content">
			            	<div id ="" class="right"> 
							</div>
				        </div>
				        <!-- #tab4 -->
					</div>
				</div>
			
			
	        <div id="search-group">
	        	<div class="search-input">
					<label for="searchComboBox"></label>
					<select id="searchCondition" name="searchCondition" title="분류">
						<option value="ALL">전체</option>
						<option value="TITLE">제목</option>
						<option value="dataInfo">정보제공처</option>
					</select>
					<label for="searchBox"></label>
					<input type="text" id="searchKeyword" name="searchKeyword" placeholder="검색어를 입력하여 주십시오." value="${dataCenterVo.searchKeyword}" onkeydown="fn_data_enter_search(this, $('#data_center_gbn').val());"/>
	            	<input type="button" id="btnSearch" value="검색" onclick="javascript:fn_search(1,$('#data_center_gbn').val())"/>
	            	             		
				</div>
			</div>
		
		
		<div class="tab-group list_data">
			<a href="#" class="tab-btn list_data" onclick="fn_search('1', 'DATA_01');">건강보험공단통계연보</a>
			<a href="#" class="tab-btn list_data" onclick="fn_search('1', 'DATA_02');">통계청 사망원인 데이터</a>
			<a href="#" class="tab-btn list_data" onclick="fn_search('1', 'DATA_03');">기후자료</a>
		</div>  
			
			<p id="topInfo" class="top9"></p>
			
			<table class = 'basic_table'>
				<colgroup>
					<col style="width:10%">				
					<col style="width:40%">
					<col style="width:20%">
					<col style="width:20%">
					<col style="width:10%">
				</colgroup>
				<thead>
				<tr>
					<th scope='col'>번호</th>
					<th scope='col'>제목</th>
					<th scope='col'>정보제공처</th>
					<th scope='col'>등록일</th>		
					<th scope='col'>조회수</th>										
				</tr>
				</thead>
				<tbody id = 'bodyInfo'>
					
				</tbody>
			</table>
					
			<div id="paging" class="paginate"></div>
	</div>
	
		
		<!-- 추가 PARAM -->
	<input type="hidden" id="messege" name="messege" value="${messege}" alt="message">
	<input type="hidden" name="page" id="page" value="${dataCenterVo.page}" alt="pageNum" /> 
	<input type="hidden" name="data_center_gbn" id="data_center_gbn" value="${dataCenterVo.data_center_gbn}" alt="data_center_gbn" />
	<input type="hidden" name="data_center_id" id="data_center_id" value="${dataCenterVo.data_center_id}" alt="data_center_id" />
	<input type="hidden" name="searchOption" id="searchOption" value="${dataCenterVo.searchCondition}" alt="콤보param" /> 
 	
 	<!-- 공통  필수 PARAM -->
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/>
	</div>
	</div>
	
	
</form>