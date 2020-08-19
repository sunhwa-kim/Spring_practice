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
var status ="";
var delaymessage="";
$(function(){
	  
	if($("#messege").val() != ''){
    	alert( $("#messege").val());
    }
    $("#messege").val('');
	
    var page =$('#page').val();
	if(page == '' ){
		page=1;
	}
	
	var selectMenu = $('#selectMenu').val();
	if(selectMenu == ''){
		selectMenu = '1';
	}
	
    var searchOption = $("#searchOption").val();
 
	if(searchOption != '' ){
		$('#searchCondition option[value='+searchOption+']').attr('selected',true);
	}	 
    
	// 화면 목록 조회
	fn_search(page,selectMenu);
	
	
});


function fn_LoanDelay(acsNo) {
   	
	var result = confirm("해당도서에 대해서 대출기간을 연장신청 하시겠습니까?");
	
	if(result){
		$.ajax({
			url: '${ctxt}/mylib/loan/loanDelay.do',
	        data: {"acsno":acsNo},
	        type: 'POST',
	        dataType: 'text',
	        cache: false,
			success  : function(loandata) {
				status =$(loandata).find('status').text();
				delaymessage = $(loandata).find('delaymessage').text();
				
				if( status == "success" ) {
					alert(delaymessage);
					//page refresh
					fn_search('1',$("#selectMenu").val());
				} else {
					alert(delaymessage);
					fn_search('1',$("#selectMenu").val());
				}
			},
			error: function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:" + "error" + error);
			}
		});
	}
}

function fn_search(page,selectMenu){
	//현재 페이지 세팅
	cuurPage= page;
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/

	$('#page').val(cuurPage);
	
	if(selectMenu != ""){
		$('#selectMenu').val(selectMenu);
	}

	var params = {};
  		params.page=cuurPage;
		params.searchKeyword = $('#searchKeyword').val();
		params.searchCondition = $('#searchCondition option:selected').val();
		params.selectMenu = $('#selectMenu').val();
		
		
    $.ajax({
        url: '${ctxt}/mylib/loan/loanStatRead.do',
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
					var acsNo = obj.find('acsno').text();
					var title =obj.find('title').text();
					if(title.length > 30){
						title = title.substring(0,30)+"...";
					}
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					
					html += '<tr>';
					
					html += ' <td style="text-align: center" >'+obj.find('order_sn').text() +'</td>';
					
					html += ' <td style="text-align: left" title="'+obj.find('title').text()+'">'+title + '</td>';
					
					html += ' <td style="text-align: center" >'+obj.find('author').text() + '</td>';
					
					html += ' <td style="text-align: center" >'+obj.find('loandatetime').text() + '</td>';
					
					html += ' <td style="text-align: center" >'+obj.find('plandatetime').text() + '</td>';
					
					html += ' <td style="text-align: center" >'+'<a href="javascript:fn_LoanDelay(\''+acsNo+'\')" >'+'대출연장'+'</a></td>';
					
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
						//$("#searchKeyword").val("");
						//$("#searchCondition").val("");
						
						fn_search(cuurPage,selectMenu);
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
    	location.href="${ctxt}/mylib/loan/loanStatList.do";
    })
    $("ul.tabs li").eq(1).click(function(){
    	location.href="${ctxt}/mylib/loan/loanReservList.do";
    })
    $("ul.tabs li").eq(2).click(function(){
    	location.href="${ctxt}/mylib/loan/loanRecordList.do";
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
		width:33.333333333333333333333333333333%;
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
			<span class="active">대출 현황</span>        
		</div>
		<span class="center_text_01">대출 현황</span>
	</div> 
	<div class="under_bar"></div>
	
	<div class="content_wrap">	
		<div class="content_box">
			<div class="content_list">	
				<div class="tabContainer"> 		
					<ul class="tabs">
						<li rel="tab1" style="box-sizing:border-box;">대출현황</li>
						<li rel="tab2" style="box-sizing:border-box;">예약현황</li>
						<li rel="tab3" style="box-sizing:border-box;">대출이력</li>					    
					</ul>
					<div class="tab_container" style="width:100%; box-sizing:border-box;"></div>
				</div>
		        <div id="search-group">
					<div class="search-input">
						<label for="searchCombo"></label>
						<select id="searchCondition" name ="searchCondition" title="분류">
							<option value="ALL">전체</option>
							<option value="TITL">서명</option>
							<option value="AUTH">저자</option>
						</select>
						<label for="searchBox"></label>
						<input type="text" id="searchKeyword" name= "searchKeyword" value="${loanVo.searchKeyword}" onkeydown="fn_enter_search(this);" placeholder="검색어를 입력해주세요."/>
		            	<input type="button" id="btnSearch" value="검색" onclick="javascript:fn_search(1,$('#selectMenu').val())"/>
					</div>
				</div>
				  
				<p id="topInfo"></p>
				
				<table class = 'basic_table'>
					<caption>
						대출현황 - 번호,서명,저자,대출일,반납예정일,대출연장
					</caption>
						<colgroup>
							<col style="width:7%">
						    <col>
						    <col style="width:13%">
						    <col style="width:15%">
						    <col style="width:15%">
						    <col style="width:10%">
						</colgroup>
						
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">서명</th>
								<th scope="col">저자</th>
								<th scope="col">대출일</th>
								<th scope="col">반납예정일</th>
								<th scope="col">대출연장</th>
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
	<input type="hidden" name="page" id="page" value="${loanVo.page}" alt="pageNum" /> 
	<input type="hidden" name="searchOption" id="searchOption" value="${loanVo.searchCondition}" alt="콤보param" /> 
	<input type="hidden" name="selectMenu" id="selectMenu" value="${loanVo.selectMenu}" alt="selectMenu" />
 	<!-- 공통  필수 PARAM -->
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/>
	
	
</form>