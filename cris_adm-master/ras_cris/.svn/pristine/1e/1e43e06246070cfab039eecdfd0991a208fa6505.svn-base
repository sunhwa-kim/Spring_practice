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
	
    var searchType =$('#searchType').val();
	if(searchType != '' ){
		$('#searchType option[value='+searchType+']').attr('selected',true);
	}
	
	// 화면 목록 조회
	fn_search('1',page);
	 
});


function fn_down(elib_id){
	location.href="${ctxt}/resources/elib/"+elib_id+".hwp"
}



// 이용안내 다운로드
function fileView(key , title) {		 
	  var contextName = "ncmik";
	  var fileKey = key;
      var pageTitle = title;

      popAttfileViewIn(fileKey, contextName, pageTitle);
}



/* 전자자원 팝업링크 */
function popLink(){
	if (confirm('로그인 후 이용 가능한 서비스 입니다.\n로그인 하시겠습니까?')) 
		location.href="${ctxt}/login/user/login.do?returnURL=/elib/webdb/listWebdb.do";
}

function fn_search(searchCondition, page){
	//현재 페이지 세팅
	cuurPage= page;
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/

	$('#page').val(cuurPage);

	/* $('#searchType').val($('#searchCondition option:selected').val()); */
	
	var params = {};
  		params.page=cuurPage;
		params.elib_type = 'webDB';
		params.searchKeyword = $('#searchKeyword').val();
 		params.searchCondition = searchCondition;
		params.searchKey = $('#searchKey').val();
		
    $.ajax({
        url: '${ctxt}/elib/webdb/readWebdb.do',
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
				
				var innerIp = '${INNER_IP}';
				var loginid = '${userVO.loginid}';
				var mouLoan = '${userVO.mouLoan}';
				var instttyid = '${userVO.instttyid}';
				var elibYn = '${userVO.elibagree}';
				
				xmlList.each(function(cnt){
			
					var obj = $(this);
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					html += '<tr>';
					
					var atch_file_id = obj.find('atch_file_id').text();
					var atch_link_id = obj.find('atch_link_id').text();
					var elibagree = obj.find('elibagree').text();
					var elib_link = obj.find('elib_link').text();
					var elib_sj = obj.find('elib_sj').text();
					var elib_id = obj.find('elib_id').text();
					
					var file_sn= 0; // 파일 순번   
					var img_html = "";
					if(atch_file_id == ''){
						img_html += elib_sj;
					}else{
						img_html += "<img src='${ctxt}/cmmn/mainPopup/getImage.do?atch_file_id="+atch_file_id+"&file_sn="+ file_sn + "' alt='pop' title='pop' style='width:100px; height:auto; border:1px solid #ddd; vertical-align:middle;'>";	
					}
					
					html += '<td style="text-align:center;">';
					//사용자별 분기 시작
					if(elib_link == ''){
						html += elib_sj + obj.find('issn').text();
					}else if( innerIp == 'Y'){
						html += '<a href="#" onclick="elibPopInternalIp(\'' +elib_link +'\', \'E\');addptlStatAccess(\'' +elib_id +'\',\'' +elib_sj +'\');" title="새창">'+'<span style="color:#1A96D9" title="새창">'+img_html+'</span>' +'</a>';
					}else if( loginid == ''){ <%-- 로그인 안했을때 --%>
						html += '<a href="#" onclick="javascript:popLink();" title="새창">'+ img_html+'</a></td>';
					}else{
						<%-- 무제한 이용 --%>
						if( elibagree == '1' || elibagree == '5'){
							html += '<a href="#" onclick="elibPop(\''+ elib_link +'\', \'E\');addptlStatAccess(\''+ elib_id +'\',\''+ elib_sj +'\');" title="새창">'+ img_html + '</a>';
						<%-- 건물내 이용 --%>
 						}else if(elibagree == '2' && innerIp == 'Y'){
							html += '<a href="#" onclick="elibPopInternalIp(\''+ elib_link +'\', \'E\');addptlStatAccess(\''+ elib_id +'\',\''+ elib_sj +'\');" title="새창">'+ img_html + '</a>';
						<%-- 소속 직원 이용가능 --%>	
						}else if(elibagree == '3' && (instttyid == '1' || instttyid == '2')){
							html += '<a href="#" onclick="elibPop(\''+ elib_link +'\', \'E\');addptlStatAccess(\''+ elib_id +'\',\''+ elib_sj +'\');" title="새창">'+ img_html + '</a>';
						<%-- 승인회원 이용가능 --%>
						}else if((elibagree == '2' || elibagree == '3' || elibagree == '4') && elibYn == 'Y'){
							html += '<a href="#" onclick="elibPop(\''+ elib_link +'\', \'E\');addptlStatAccess(\''+ elib_id +'\',\''+ elib_sj +'\');" title="새창">'+ img_html + '</a>';
						}else{ 
							html += img_html+ '</span>';
						}
					}
					if(obj.find('edition').text() != ''){
						html += ' (' + obj.find('edition').text() + ')';
					}
					//사용자별 분기 끝
					html += '</td>';
					
					html += '<td class="listtd hiddenTbl" style="text-overflow:ellipsis" >'+obj.find('elib_cn').text() + '</td>';
					html += '<td><a class="a_btn right relative" href="javascript:fileView(\''+ atch_link_id +'\',\''+elib_sj+'\')" target="">이용안내</a></td>';
					//var atch_link_id = obj.find('atch_link_id').text();
					//fileView(atch_link_id,obj.find('elib_sj').text());
					html += '</tr>';
						
		        });
				//페이징처리
			    $('#paging').paging({
			    	
					 current:cuurPage
					,max:pageTotalCnt
					,length:pageLen
					,onclick:function(e,page){
						cuurPage=page;
						fn_search('1', cuurPage);
					}
				});
				$("#topInfo").html("<span class = 'gray'>["+ cuurPage +" / "+pageTotalCnt+" Pages]</span> <span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.");
			    $("#bodyInfo").html(html);
			  
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$('#paging').children().remove();
				$("#topInfo").html("["+ 1 +" / "+ 1 +" Pages] <span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.");
				$("#bodyInfo").html('<tr><td colspan="7" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}

// 전자정보 오류신고
function elibErrorLink(elibId){
	var loginCheck = "<c:out value='${userVo}' />";
	
	if(loginCheck != ""){
		var url = '${ctxt}/elib/webdb/listWebError.do';
		$("#elib_id").val(elibId);
		
		var form = document.webError;
		form.action=url
		form.submit();
			
	}else{
		if (confirm('로그인 후 이용 가능한 서비스 입니다.\n로그인 하시겠습니까?')){ 
			location.href="${ctxt}/login/user/login.do?returnURL=/elib/webdb/listWebdb.do";
		}
	}
	
}
</script>
<style>
.basic_table td{
	font-size:13px;
}
.basic_table>#bodyInfo>tr>td:nth-child(1){
	width:15%;
}
.basic_table>#bodyInfo>tr>td:nth-child(2){
	width:auto;
}
.basic_table>#bodyInfo>tr>td:nth-child(3){
	width:65px;
	box-sizing:border-box;
	text-indent: 0px;
	text-align:center;
}
.basic_table>#bodyInfo>tr>td:nth-child(3) .a_btn.right{
	right: 50%;
	font-size: 11px;
	position: absolute !important;
	width: 50px;
	margin-top: 0px;
	transform: translate(50%, -50%);
	-o-transform: translate(50%, -50%);
	-ms-transform: translate(50%, -50%);
	-moz-transform: translate(50%, -50%);
	-webkit-transform: translate(50%, -50%);
}
.elib_sj_shadow{
	font-size: 20px;
	text-shadow:-1px -1px 1px #494949;
}
	
@media all and (max-width:700px) {    
	.basic_table>#bodyInfo>tr>td:nth-child(1){
		width:10%;
	}
	.basic_table>#bodyInfo>tr>td>a>img:nth-child(1){
		width:70px;
		height:40px;
	}
} 
@media all and (max-width:600px){
	.basic_table>#bodyInfo>tr>td:nth-child(4){
		min-width:74px;
	}
}
@media all and (max-width:502px){
	.content_wrap{
		margin-top: 50px;
	}
}
</style>
<form name="webError" id="errorLink" action="" method="post" >
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" name="elib_id" id="elib_id" value="" alt="elib_id" /> 
	<input type="hidden" id="messege" name="messege" value="${messege}" alt="message">
	<input type="hidden" name="page" id="page" value="" alt="pageNum" /> 
		 
	<div id="" class="">
		<div class="sub_center_text">
			<div class="sub_center_nav"> 
				<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
				<span> > </span> 
				<span>전자자원</span>
				<span> > </span>
				<span class="active">WebDB</span>        
			</div>
			<span href="#" class="center_text_01">WebDB</span>
		</div> 
		<div class="under_bar"></div>
		
		<div class="content_wrap">
			<div class="content_box">
				<div class="content_list">
					<div id="search-group">
						<div class="search-input">
							<select id="searchKey" name="searchKey" title="분류">
								<option value="allSe">전체</option>
								<option value="titleSe">DB명</option>
								<option value="contentSe">내용</option>
							</select>
							<input type="text" id="searchKeyword" name="searchKeyword" placeholder="검색어를 입력하여 주십시오." value="${boardNotiVo.searchWord}" onkeydown="fn_enter_search(this);"/>
			            	<input type="button" id="btnSearch" value="검색" onclick="fn_search('1', '1');"/>
						 </div>
				 	</div>
					<p id="topInfo"></p>
					<table class = 'basic_table'>
						<%-- <colgroup style="width:100%">			
							<col style="width:15%">
							<col style="width:10%">
							<col style="width:55%">
							<col style="width:20%">
						</colgroup> --%>
						
						<tbody id = 'bodyInfo'>
						</tbody>
					</table>
					<div id="paging" class="paginate"></div>
				</div>
			</div>
		</div>
	</div>
</form>

<script>
function addptlStatAccess(mbid,title){
		
		document.addptlStatForm.mbid.value=mbid;
		document.addptlStatForm.title.value=title;  
		document.addptlStatForm.submit();
		
}
</script>
					
<form id="addptlStatForm" name="addptlStatForm" target="actIframe" method="post" action="${ctxt}/srv/addptlStatsAccess.do"  >
	<input name="wkid" value="WebDB" type="hidden">   
	<input name="mbid" value="" type="hidden"/>
	<input name="title" id="addptlStatFormTitle" value="" type="hidden">      
</form>   