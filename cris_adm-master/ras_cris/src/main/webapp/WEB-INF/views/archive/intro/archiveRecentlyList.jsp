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

function fn_page(archiveId , paramGbn , returnPage){

	var form=document.reqForm;
	$('#returnPageGbn').val(returnPage);
	
	if(paramGbn == 'report'){
		$('#rep_id').val(archiveId);	
		form.action="${ctxt}/archive/report/reportView.do?upd_yn=Y";
	}else if(paramGbn == 'rnd'){
		$('#rnd_id').val(archiveId);
		form.action="${ctxt}/archive/rnd/rndView.do?upd_yn=Y";
	}
	
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
        url: '${ctxt}/archive/intro/archiveRecentlyListRead.do',
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
					var dataGbn = '';
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					
					var archive_id = obj.find('archive_id').text();
					var archive_sj = obj.find('archive_sj').text();
					var archive_gbn =  obj.find('archive_gbn').text();  // 1: 보고서 , 2: 성과논문 , 3: 회색문헌
					var frst_regist_pnttm = obj.find('frst_regist_pnttm').text();  
					var order_sn = obj.find('order_sn').text();
				
					html += '<tr>';
					html += ' <td style ="text-align:center;">'+order_sn +'</td>';
					
					
					if(archive_gbn == '1'){
						dataGbn = "report";
	        	 		html += '<td class = "a0 margin_r_20 block" title = "">보고서</td>'; 										        	 		
	        	 	}else if(archive_gbn == '2'){
	        	 		dataGbn = "rnd";
	        	 		html += '<td class = "a0 margin_r_20 block" title = "">논문</td>'; 	
	        	 	}
					
					html += '<td class= "text-left">';
					if(archive_sj.length>80){
						html += '<a href="javascript:fn_page(\''+archive_id+'\',\''+dataGbn+'\',\'recently\')" >'+archive_sj.substr(0,80)+"..." +'</a></td>';
					}else{
						html += '<a href="javascript:fn_page(\''+archive_id+'\',\''+dataGbn+'\',\'recently\')" >'+archive_sj +'</a></td>';
							
					}
					html += ' <td style ="text-align:center;">'+ frst_regist_pnttm + '</td>';
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
	#bodyInfo.tr_one_line td.text-left > a {
	    white-space: nowrap;
	    display: inline-block;
	    width: auto;
	    text-overflow: ellipsis;
	}
	tr>td:nth-child(1){width:6%;}
	tr>td:nth-child(2){width:6%;}
	tr>td:nth-child(3){width:73%;}
	tr>td:nth-child(4){width:15%;}
	@media all and (max-width:1130px) {
		#bodyInfo.tr_one_line td.text-left > a {}
		tr>td:nth-child(1){width:6%;}
		tr>td:nth-child(2){width:10%;}
		tr>td:nth-child(3){width:69%;}
		tr>td:nth-child(4){width:15%;font-size:12px;}
	}
	@media all and (max-width:1075px) {
		#bodyInfo.tr_one_line td.text-left > a {max-width:600px;}

	}
	@media all and (max-width:1007px) {
		#bodyInfo.tr_one_line td.text-left > a {max-width:500px;}
	}
	@media all and (max-width:800px) {
		#bodyInfo.tr_one_line td.text-left > a {max-width:400px;}
	}
	@media all and (max-width:720px) {
		#bodyInfo.tr_one_line td.text-left > a  {max-width:350px;}
		tr>td:nth-child(1){width:10%;}
		tr>td:nth-child(2){width:13%;}
		tr>td:nth-child(3){width:60%;}
		tr>td:nth-child(4){width:17%;}
	}
	@media all and (max-width:660px) {
		#bodyInfo.tr_one_line td.text-left > a  {max-width:270px;}
	}
	@media all and (max-width:603px) {
		#bodyInfo.tr_one_line td.text-left > a  {max-width:200px;}
		tr>td:nth-child(1){width:10%;}
		tr>td:nth-child(2){width:15%;}
		tr>td:nth-child(3){width:55%;}
		tr>td:nth-child(4){width:20%;}
	}
	@media (max-width: 502px){
		#search-group {
		   top:50px;
		}
		#divRefreshArea{
			padding-top:40px;
		}
}
	@media all and (max-width:435px) {
		#bodyInfo.tr_one_line td.text-left > a  {max-width:150px;}
		tr>td:nth-child(1){width:10%;}
		tr>td:nth-child(2){width:25%;font-size:12px;}
		tr>td:nth-child(3){width:35%;}
		tr>td:nth-child(4){width:30%;}
	}
	@media all and (max-width:375px) {
		#bodyInfo.tr_one_line td.text-left > a  {max-width:100px;}
		tr>td:nth-child(1){width:15%;}
		tr>td:nth-child(2){width:20%;}
		tr>td:nth-child(3){width:30%;}
		tr>td:nth-child(4){width:35%;}

	}
	

</style>
<form name="reqForm" method="post">
 	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>아카이브</span>
			<span> > </span>
			<span class="active">최신자료</span>        
		</div>
	    <span class="center_text_01" >최신자료</span>
	</div> 	
	<div class="under_bar"></div>
			
	<div  class = "content_wrap">
		<div class="content_box">
			<div class="content_list">  	 
		        <div id="search-group">	        	 
					<div class="search-input">
						<label for="searchCombo" style="display:none;">검색콤보박스</label>
						<select id="searchCondition" name ="searchCondition" title="분류">
							<option value="ALL">전체</option>
							<option value="TITL">제목</option>
						</select>
						<label for="searchBox" style="display:none;">검색창</label>
						<input type="text" id="searchKeyword" name= "searchKeyword" value="${archiveIntroVo.searchKeyword}" onkeydown="fn_enter_search(this);"/>
		            	<input type="button" id="btnSearch" value="검색" onclick="javascript:fn_search(1)"/>               		
					</div>
				</div>
				<div id="divRefreshArea">
					<p id="topInfo"></p>
					<table  class = "basic_table">
						<caption>
						 	 Recently Add Items - 번호 , 제목, 등록일자
						</caption>
						
						<thead>
							<tr>
								<th scope='col'>번호</th>
								<th scope='col'>구분</th>
								<th scope='col'>제목</th>							
								<th scope='col'>등록일자</th>																		
							</tr>
						</thead>
						<tbody id = 'bodyInfo' class="tr_one_line">
							
						</tbody>
					</table>
					<div id="paging" class="paginate" ></div>	
				</div>		
				<div class="btn-group">
					<a href="javascript:fn_returnListUrl()" style="float: right;margin-bottom:10px;" class="basic-btn">아카이브 시작페이지</a>
				</div> 			
			</div>
		</div>
	</div>
		
	
	<!-- 추가 PARAM -->
	<input type="hidden" id="messege" name="messege" value="${messege}" alt="message">
	<input type="hidden" name="page" id="page" value="${archiveIntroVo.page}" alt="pageNum" /> 
	<input type="hidden" name="searchOption" id="searchOption" value="${archiveIntroVo.searchCondition}" alt="콤보param" /> 
 	
 	<!-- 목록에서 상세 정보로 이동하기 위한 PARAM -->
	<input type="hidden" name="rep_id" id="rep_id" value="" alt="보고서 id" /> 	
	<input type="hidden" name="rnd_id" id="rnd_id" value="" alt="성과논문 id" />
	
 	
 	<!-- 공통  필수 PARAM -->
 	<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/> --%>
	
	<!-- 리턴 페이지  -->
	<input type="hidden" id="returnPageGbn" name="returnPageGbn"  alt="returnPageGbn">
	
	<input type="hidden" id="returnListPage" name="returnListPage" value="${ctxt}/archive/intro/archiveIntro.do"  alt= "아카이브 소개로 이동" />
	
	

</form>