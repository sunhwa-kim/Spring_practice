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

	$('#alit_id').val(param);
	var form=document.reqForm;
	form.action="${ctxt}/centerintro/noti/notiView.do?upd_yn=Y";
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
		
		
    $.ajax({
        url: '${ctxt}/centerintro/noti/notiRead.do',
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
					
					var alitId = obj.find('alit_id').text();
					var alit_type = obj.find('alit_type').text();  // 1 : 공지 , 2 : 홍보, 3 : 보도 , 4 : 과학(의생명과학소식1,2,3,4)
					var top_status = obj.find('top_status').text();
					
					html += '<tr>';
					
					if(top_status == '0'){
						html += ' <td style = "text-align:center;">'+obj.find('order_sn').text() +'</td>';
					}else if(top_status == '1'){
						html += ' <td style = "text-align:center;">'+'<img src="${ctxt}/resources/images/ncmik/ptl/cmmu/important_notice1.jpg" width="15" height="13" alt="중요공지" >'+'</td>';
					}
					
				
					
					html += ' <td class= "text-left">';
					
					if(alit_type == '1'){
	        	 		if(top_status == '0'){
		        	 		html += '<p class = "t0" title = "">공지</p>';							
						}else if(top_status == '1'){
		        	 		html += '<p class = "t0" title = ""><strong>공지</strong></p>';		        	 		
						}
	        	 	}else if(alit_type == '2'){	        	 	
	        	 		if(top_status == '0'){
	        	 			html += '<p class = "t0" title = "">홍보</p>';			
						}else if(top_status == '1'){
							html += '<p class = "t0" title = ""><strong>홍보</strong></p>';        	 		
						}
	        	 	}else if(alit_type == '3'){        	 		
	        	 		if(top_status == '0'){
	        	 			html += '<p class = "t0" title = "">교육</p>';					
						}else if(top_status == '1'){
							html += '<p class = "t0" title = ""><strong>교육</strong></p>';	        	 		
						}
	        	 	}else if(alit_type == '4'){	
	        	 		if(top_status == '0'){
	        	 			html += '<p class = "t0" title = "">과학</p>'; 						
						}else if(top_status == '1'){
							html += '<p class = "t0" title = ""><strong>과학</strong></p>'; 	        	 		
						}
	        	 	}		

					if(obj.find('alit_sj').text().length>50){  
						html += '<p class="notice_list"><a href="javascript:fn_page(\''+alitId+'\')" >'+obj.find('alit_sj').text().substr(0,50)+"..." +'</a><p></td>';
					}else{
						html += '<p class="notice_list"><a href="javascript:fn_page(\''+alitId+'\')" >'+obj.find('alit_sj').text() +'</a></p></td>';
							
					}
			
					if(obj.find('atch_link_id').text() != ""){
						html += ' <td style = "text-align:center;">'+'<img src ="${ctxt}/resources/images/common/file.png"  width="13" height="13" alt="첨부파일 있음" >' + '</td>';
					}else{
						html += ' <td></td>';
					}
					html += ' <td style = "text-align:center;">'+obj.find('frst_regist_pnttm').text() + '</td>';
					html += ' <td style = "text-align:center;">'+obj.find('rdcnt').text() +'</td>';
					html += '</tr>';
					 
		        });
				//페이징처리
			    $('#paging').paging({
			    	
					 current:cuurPage
					,max:pageTotalCnt
					,length:pageLen
					,onclick:function(e,page){
						cuurPage=page;
						
						// 페이지 이동시 PARAM 초기화
						$("#searchKeyword").val("");
						$("#searchCondition").val("ALL");
						
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
	td.text-left{
		position:relative;
	}
	p.t0{
		margin:0;
		padding:0;
		display:inline-block; 
		position:absolute;
	}
	p.notice_list{
		margin:0;
		padding:0 0 0 10%;
		width:auto;
		display:inline-block; 
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
	@media all and (max-width:750px) {
		p.notice_list{
			padding:0 0 0 15%;
			transition:all 0.3s;
			-webkit-transition:all 0.3s;
		}
	}
	@media (max-width: 502px){
		#topInfo {
    		margin:85px 0 9px 0;
    	}
    	#search-group{
    		top:55px;
    	}
	}
    
	@media all and (max-width:470px) {
		p.notice_list{
			padding:0 0 0 20%;
			transition:all 0.3s;
			-webkit-transition:all 0.3s;
		}
	}
</style>

<form name="reqForm" method="post">
		
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>센터안내</span>
			<span> > </span>
			<span class="active">공지사항</span>        
		</div>
		<span class="center_text_01" >공지사항</span>
	</div> 
	<div class="under_bar"></div>
		
	<div class = "content_wrap">
		<div class="content_box">
			<div class="content_list">
		        <div id="search-group">	 
					<div class="search-input">
						<label for="searchCombo"></label>
						<select id="searchCondition" name ="searchCondition" title="분류">
							<option value="ALL">전체</option>
							<option value="TITL">제목</option>
						</select>
						<label for="searchBox"></label>
						<input type="text" id="searchKeyword" name= "searchKeyword" value="${introNotiVo.searchKeyword}" onkeydown="fn_enter_search(this);" placeholder="검색어를 입력해주세요."/>
		            	<input type="button" id="btnSearch" value="검색" onclick="javascript:fn_search(1)"/>               		
					</div>
				</div>
			
		
					<p id="topInfo"></p>
					
					<table class= "basic_table">
						<caption>
						 	 공지사항 -  번호, 제목, 첨부파일, 등록일, 조회수 
						</caption>
						<colgroup>
							<col style="width:10%">				
							<col style="width:50%">
							<col style="width:15%">
							<col style="width:15%">
							<col style="width:10%">
						</colgroup>
						<thead>
						<tr>
							<th scope='col'>번호</th>
							<th scope='col'>제목</th>
							<th scope='col'>첨부파일</th>
							<th scope='col'>등록일</th>		
							<th scope='col'>조회수</th>										
						</tr>
						</thead>
						<tbody id = 'bodyInfo'>
							
						</tbody>
					</table>
				
					<div id="paging" class="paginate"  style ="text-align: center;"></div>
			</div>
		</div>
	</div>
		
	 <%-- <div  class = "content_wrap">	
	 	<div style="width:100%">  	 
		   <div class="search_wrap">	
		        <div id="search-group">	 
				<div class="search-input">
					<label for="searchCombo"></label>
					<select id="searchCondition" name ="searchCondition" title="분류">
						<option value="ALL">전체</option>
						<option value="TITL">제목</option>
					</select>
					<label for="searchBox"></label>
					<input type="text" id="searchKeyword" name= "searchKeyword" value="${introNotiVo.searchKeyword}" onkeydown="fn_enter_search(this);" placeholder="검색어를 입력해주세요."/>
	            	<input type="button" id="btnSearch" value="검색" onclick="javascript:fn_search(1)"/>
					                		
				</div>
			</div>
			</div>
			<div id="divRefreshArea">
			  
					<p id="topInfo"></p>
					
					<table class= "basic_table">
						<caption>
						 	 공지사항 -  번호, 제목, 첨부파일, 등록일, 조회수 
						</caption>
						<colgroup>
							<col style="width:10%">				
							<col>
							<col style="width:15%">
							<col style="width:15%">
							<col style="width:10%">
						</colgroup>
						<thead>
						<tr>
							<th scope='col'>번호</th>
							<th scope='col'>제목</th>
							<th scope='col'>첨부파일</th>
							<th scope='col'>등록일</th>		
							<th scope='col'>조회수</th>										
						</tr>
						</thead>
						<tbody id = 'bodyInfo'>
							
						</tbody>
					</table>
				
					<div id="paging" class="paginate"  style ="text-align: center;"></div>
				
			</div>
	
		</div>
		
	</div> --%>
	
		
	
	<!-- 추가 PARAM -->
	<input type="hidden" id="messege" name="messege" value="${messege}" alt="message">
	<input type="hidden" name="page" id="page" value="${introNotiVo.page}" alt="pageNum" /> 
	<input type="hidden" name="alit_id" id="alit_id" value="" alt="공지사항id" /> 
	<input type="hidden" name="searchOption" id="searchOption" value="${introNotiVo.searchCondition}" alt="콤보param" /> 
 	
 	<!-- 공통  필수 PARAM -->
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/>
	
	
</form>