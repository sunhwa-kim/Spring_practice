<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>   
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
	
	var page =$('#page').val();
	if(page == '' ){
		page=1;
	}
	
	// 화면 목록 조회
	fn_search('', page,'');
	
	
});
var str = "";
function fn_search(searchCondition, page, searchKeyword){
	 
	//엔터키로 검색할때 현재 페이지 undifined 현상 해결 시작
	if(!page){
		page = '1';
	}
	//엔터키로 검색할때 현재 페이지 undifined 현상 해결 끝
	//현재 페이지 세팅
	cuurPage= page;
	$('#page').val(cuurPage);
	
	var params = {};
		params.page=cuurPage;
	
	if(searchKeyword != null && searchKeyword != ''){
		
		if(searchCondition == '35'){
			params.searchKeyword = '';	
			$('#searchKeyword').val('');
		}else{
			params.searchKeyword = searchKeyword;
			$('#searchKeyword').val(searchKeyword);
		}
		
	}  
	params.searchCondition = searchCondition; 
	params.searchKey = $('#searchKey').val();
	params.searchSort = $('select[name=searchSort]').val();
	params.itemsPerPage = $('select[name=itemsPerPage]').val();   
	params.searchOrderBy = $('select[name=searchOrderBy]').val();   	// 정렬조건
	params.elibagreeOpen = '${elibagreeOpen}';
	
	$.ajax({
	    url: '${ctxt}/elib/ebooks/readEBooks.do',
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
				
				//사용자 분기에 필요한 변수 선언
				var innerIp = '${INNER_IP}';
				var loginid = '${userVO.loginid}';
				var mouLoan = '${userVO.mouLoan}';
				var elibYn = '${userVO.elibagree}';
				var instttyid = '${userVO.instttyid}';
			
				//사용자 분기에 필요한 변수 선언 끝
				xmlList.each(function(cnt){
			
					var obj = $(this);
					// DB로부터 불러온 변수 선언
					var elib_link = obj.find('elib_link').text();
					var order_sn = obj.find('order_sn').text();
					var elib_sj = obj.find('elib_sj').text();
					var author = obj.find('author').text();
					var publisher = obj.find('publisher').text();
					var publishing_date = obj.find('publishing_date').text();
					var elibagree = obj.find('elibagree').text();
					var elib_id = obj.find('elib_id').text();
					// DB로부터 불러온 변수 선언 끝
					
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					var re_sj = elib_sj.replace(/\'/gi, "");
					re_sj = re_sj.replace(/\"/gi, "");			
					
					html += '<tr>';
 					html += '<td style="text-align:center"><input type="checkbox" class= "option" name="chk_mylib" value=\''+elib_id+'\'> '+order_sn + '</td>';
					/* html += ' <td>ejournals</td>'; */
					html += '<td>';
					//사용자별 분기 시작
					if(elib_link == ''){
						html += elib_sj + obj.find('issn').text();
					}else if( innerIp == 'Y'){
						html += '<a href="#" onclick="elibPopInternalIp(\'' +elib_link +'\', \'E\');addptlStatAccess(\'' +elib_id +'\',\'' +re_sj +'\');" title="새창">'+'<span style="color:#1A96D9" title="새창">'+elib_sj+'</span>' +'</a>';
					}else if( loginid == ''){ <%-- 로그인 안했을때 --%>
						html += '<a href="#" onclick="javascript:popLink();" title="새창">'+ elib_sj+'</a></td>';
					}else{
									
						<%-- 무제한 이용 --%>
						if( elibagree == '1' || elibagree == '5'){
							html += '<a href="#" onclick="elibPop(\''+ elib_link +'\', \'E\');addptlStatAccess(\''+ elib_id +'\',\''+ re_sj +'\');" title="새창">'+ elib_sj + '</a>';
						<%-- 건물내 이용 --%>
 						}else if(elibagree == '2' && innerIp == 'Y'){
							html += '<a href="#" onclick="elibPopInternalIp(\''+ elib_link +'\', \'E\');addptlStatAccess(\''+ elib_id +'\',\''+ re_sj +'\');" title="새창">'+ elib_sj + '</a>';
						<%-- 소속 직원 이용가능 --%>	
						}else if(elibagree == '3' && (instttyid == '1' || instttyid == '2')){
							html += '<a href="#" onclick="elibPopInternalIp(\''+ elib_link +'\', \'E\');addptlStatAccess(\''+ elib_id +'\',\''+ re_sj +'\');" title="새창">'+ elib_sj + '</a>';
						<%-- 승인회원 이용가능 --%>
						}else if((elibagree == '2' || elibagree == '3' || elibagree == '4') && elibYn == 'Y'){
						
							html += '<a href="#" onclick="elibPop(\''+ elib_link +'\', \'E\');addptlStatAccess(\''+ elib_id +'\',\''+ re_sj +'\');" title="새창">'+ elib_sj + '</a>';
						}else{
							html += elib_sj+ '</span>';
						}
					}
					if(obj.find('edition').text() != ''){
						html += ' (' + obj.find('edition').text() + ')';
					}
					//사용자별 분기 끝
					html += '</td>';
					html +=  '<td style="text-align:center">' + author + '</td>';
					
					html +=  '<td style="text-align:center">' +publisher + '</td>';		
					
					html +=  '<td style="text-align:center">' + publishing_date + '</td>';			

					html += '</tr>';
					
		        });  
				//페이징처리
			    $('#paging').paging({
			    	
					 current:cuurPage
					,max:pageTotalCnt
					,length:pageLen
					,onclick:function(e,page){
						cuurPage=page;
						fn_search(searchCondition, cuurPage ,  $('#searchKeyword').val());
					}
				});
				$("#topInfo").html("<span class='gray'>["+ cuurPage +" / "+pageTotalCnt+" Pages] </span><span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.");
				
			    $("#bodyInfo").html(html);
			  
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$('#paging').children().remove();
				$("#topInfo").html("["+ 1 +" / "+1+" Pages] <span class = 'txt-red' >"+0+"</span> 건이 검색되었습니다.");
				$("#bodyInfo").html('<tr><td colspan="5" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
	    },
	    error : function(){                              // Ajax 전송 에러 발생시 실행
	      fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
	    }
	});
}
/* 전자자원 팝업링크 */
function popLink(){  
	if (confirm('로그인 후 이용 가능한 서비스 입니다.\n로그인 하시겠습니까?')) 
		location.href="${ctxt}/login/user/login.do?returnURL=/elib/ebooks/listEBooks.do";
}

function fn_ejournals_enter_search(param){
	var id_val = $(param).attr('id');	
	
	if(event.keyCode == 13)
	{
		event.preventDefault();
		fn_search('1', '1' ,$('#searchKeyword').val());
	}	
}

var isChk= false;
//전체선택 / 취소
function fn_all(){
	$("input[name=chk_mylib]").each(function() {
		if(isChk){
			$('#all_chk').text("전체선택");
			$(this).prop("checked",false);
		}else{
			$('#all_chk').text("전체취소");
			$(this).prop("checked",true);
		}
	});
	isChk=!isChk;

}
/**
 * 내서재담기 multi
 */
function selMultiMyLib(subTarget) {
	var chk_mylib_cnt = 0;  
	var mylibChk = "";
 	if ("${userVo.emplyrnm}" == "") {
		if (confirm("내서재 담기 기능을 선택하실 경우 로그인 하셔야합니다.\n로그인 화면으로 이동하시겠습니까?")) {
			location.href = "${ctxt}/login/user/login.do?returnURL=/elib/ebooks/listEBooks.do";
			return;
		} else {
			return;
		}
	} 
 	
	$("input[name=chk_mylib]:checked").each(function() {
		mylibChk += $(this).val() + ",";
	
		if(mylibChk != "" ){
			chk_mylib_cnt++;	
		}
		
	});

	var params = {};
	params.key = mylibChk.substring(0 ,mylibChk.length-1);
	params.gbn = "ebooks";
	params.parameterName = "${_csrf.parameterName}";
	params.token = "${_csrf.token}";
	params.subTarget = subTarget;
	
	$.ajax({
		url : "<c:url value='/mylib/lib/multiMylibSave.do'/>",
		data : params,
		type : 'post',
		dataType : 'json',
		success : function(data) {	
	
			if(confirm("선택하신 총 "+chk_mylib_cnt+"건 중\n내 서재 담기에 성공한 건수: "+data.sucCnt+"건\n이미 내 서재에 등록된 건수(내 서재 담기에 실패한 건수): "+data.dupCnt+"건 \n입니다.\n\n※ 내 서재 화면으로 이동하시겠습니까?")){
				location.href="<c:url value='/mylib/lib/listMyLib.do'/>";
				return;
			}else{
			
				 $("input[name=chk_mylib]").prop("checked", false);
				
				return;
			}
		}
	}); 
}

</script>
 
<style> 
.center_text_02 {
    margin-left: 20px;
}
#library1 {
   margin-top: 5px;
}
#selectbox1, #selectbox4{
    width: 60px;
    background-position: 40px center;
}
#selectbox2{
	width:90px;
	background-position: 70px center;
}
#all_chk{
	width:90px;
}
.bibliography{
	margin-left:3px;
}
.selectbox_wrap a i {
    margin-right: 3px;
}
.move.surch_box1.center {
	width: 417px;
}
.move.surch_box1.center:after{
	display:block;
	cotent:"";
	clear:both;
}
.move.surch_box1.center #itemsPerPage{
	width:70px;
	height:36px;	
	border-color: #ccc;
    color: #7f7f7f;
    padding: 7.5px 10px;
    
}
.move.surch_box1.center #searchSort{
	width:70px;
	height:36px;	
	border-color: #ccc;
    color: #7f7f7f;
    padding: 7.5px 10px;
    
}
.move.surch_box1.center .surch_select_box {
	float:right;
	text-algin:right;
}
.surch_box2 #searchKey{
	width: 90px;
}
@media (max-width: 882px){
	.surch_box.center {
	    text-align: center;
	    transition: all 0.5s;
	    -webkit-transition: all 0.5s;
	}
}
@media (max-width: 882px){
	.move.surch_box1.center {
	    float: none;
	    position: relative;
	    text-align:center;
	    margin: 0 auto;
	    margin-top: 10px;
	    display: inline-block;
	    height: 82px;
	    transition: all 0.5s;
	    -webkit-transition: all 0.5s;
	}
}

	@media (max-width: 600px){
		#atozCont  {
		    margin:0 auto;
		}
		.move.surch_box1.center {
		    width: 357.19px;
		}
		.selectbox_wrap {	   
	    	width: 220px !important;
	 
		}
		#topInfo.top9{
			margin-top: 50px;
		}
	}
	@media all and (max-width:494px) {
		.surch_box2 #searchKey{
			width:70px;
		}
		.move.surch_box1.center{
			width:337.19px;
		}
	}
	@media (max-width: 430px){
		#searchKeyword{
				width: 130px;
				transition: all 0.2s;
		    	-webkit-transition: all 0.2s;
			}
		.move.surch_box1.center {
		    width: 290.19px;
		}
	}

</style>

<form name="webError" id="errorLink" action="" method="post" >	 
 	<div class="sub_center_text">
		<div class="sub_center_nav"> 
		 	<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
		 	<span> > </span> 
		 	<span>전자자원</span>
		 	<span> > </span>
		 	<span class="active">E-Books</span>        
		</div>
		<span href="#" class="center_text_01">E-Books</span>
	</div> 
	
	<div class="under_bar"></div>
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div class="tabMenu" >
				</div>

	           	<div class="surch_box center">
		           	<div id="atozCont" style="float:none;">
						<div class="atozSearch">
							<ul>
								<li>
									<a title="A" onclick="fn_search('20',1,'A')" href="#">A</a>
									<a title="B" onclick="fn_search('20',1,'B')" href="#">B</a> 
									<a title="C" onclick="fn_search('20',1,'C')" href="#">C</a> 
									<a title="D" onclick="fn_search('20',1,'D')" href="#">D</a> 
									<a title="E" onclick="fn_search('20',1,'E')" href="#">E</a> 
									<a title="F" onclick="fn_search('20',1,'F')" href="#">F</a> 
									<a title="G" onclick="fn_search('20',1,'G')" href="#">G</a> 
									<a title="H" onclick="fn_search('20',1,'H')" href="#">H</a> 
									<a title="I" onclick="fn_search('20',1,'I')" href="#">I</a> 
									<a title="J" onclick="fn_search('20',1,'J')" href="#">J</a> 
									<a title="K" onclick="fn_search('20',1,'K')" href="#">K</a> 
									<a title="L" onclick="fn_search('20',1,'L')" href="#">L</a> 
									<a title="M" onclick="fn_search('20',1,'M')" href="#">M</a>
								</li>
								<li>
									<a title="N" onclick="fn_search('20', 1,'N')" href="#">N</a>
									<a title="O" onclick="fn_search('20', 1,'O')" href="#">O</a> 
									<a title="P" onclick="fn_search('20', 1,'P')" href="#">P</a> 
									<a title="Q" onclick="fn_search('20', 1,'Q')" href="#">Q</a> 
									<a title="R" onclick="fn_search('20', 1,'R')" href="#">R</a> 
									<a title="S" onclick="fn_search('20', 1,'S')" href="#">S</a> 
									<a title="T" onclick="fn_search('20', 1,'T')" href="#">T</a> 
									<a title="U" onclick="fn_search('20', 1,'U')" href="#">U</a> 
									<a title="V" onclick="fn_search('20', 1,'V')" href="#">V</a> 
									<a title="W" onclick="fn_search('20', 1,'W')" href="#">W</a> 
									<a title="X" onclick="fn_search('20', 1,'X')" href="#">X</a> 
									<a title="Y" onclick="fn_search('20', 1,'Y')" href="#">Y</a> 
									<a title="Z" onclick="fn_search('20', 1,'Z')" href="#">Z</a> 
									<a title="숫자" onclick="fn_search('35',1,'숫자')" href="#"class="atozTwoLayer"> 
										<span>숫<br>자</span>
									</a>
								</li>
								<li>
									<a title="가" onclick="fn_search('21' ,1,'가')" href="#">가</a>
									<a title="나" onclick="fn_search('22' ,1,'나')" href="#">나</a>
									<a title="다" onclick="fn_search('23' ,1,'다')" href="#">다</a> 
									<a title="라" onclick="fn_search('24' ,1,'라')" href="#">라</a> 
									<a title="마" onclick="fn_search('25' ,1,'마')" href="#">마</a> 
									<a title="바" onclick="fn_search('26' ,1,'바')" href="#">바</a> 
									<a title="사" onclick="fn_search('27' ,1,'사')" href="#">사</a> 
									<a title="아" onclick="fn_search('28' ,1,'아')" href="#">아</a> 
									<a title="자" onclick="fn_search('29' ,1,'자')" href="#">자</a> 
									<a title="차" onclick="fn_search('30' ,1,'차')" href="#">차</a> 
									<a title="카" onclick="fn_search('31' ,1,'카')" href="#">카</a> 
									<a title="타" onclick="fn_search('32' ,1,'타')" href="#">타</a> 
									<a title="파" onclick="fn_search('33' ,1,'파')" href="#">파</a> 
									<a title="하" onclick="fn_search('34' ,1,'하')" href="#">하</a>
								</li>
							</ul>
							<!-- cont end -->
						</div><!-- AtoZ Search end --> 
					</div><!-- atozCont -->	
	           		<div class="surch_box1 move center" style="margin-bottom:0;">
	           		<!-- 	<div class="surch_select_box">
		           			<span style="font-size:13px;color:#7f7f7f; margin-right:7px;font-weight:normal;">페이지별 목록건수</span>
							<select id="itemsPerPage" name="itemsPerPage" title="페이지당 게시물 수">
								<option value="10">10건</option>
								<option value="20">20건</option>						
								<option value="50">50건</option>						
								<option value="100">100건</option>						
							</select>
							&nbsp;&nbsp;							
							<select id="searchSort" name="searchSort" title="페이지당 게시물 수">
								<option value="basic">정렬</option>
								<option value="desc">내림</option>						
								<option value="asc">오름</option>																			
							</select>
						</div> 
				 -->
						<div class="surch_box2">
							<select id="searchKey" name="searchKey" title="분류">
									<option value="allSe">전체</option>
									<option value="titleSe">Title</option>
									<option value="yearSe">Year</option> 
									<option value="publisherSe">Publisher</option>
							</select>
							<input type="text" id="searchKeyword" name="searchKeyword" placeholder="검색어를 입력하여 주십시오." value="${boardNotiVo.searchWord}" onkeydown="fn_ejournals_enter_search(this);"/>
			           		<input type="button" id="btnSearch" style="width:70px;" value="검색" onclick="fn_search(1, 1,$('#searchKeyword').val());"/>	    
			           	</div>  
			           	 <div class="selectbox_wrap" style="height:38px; position:relative; margin:0; padding-top:0;clear:both;top:50px;">
								<select id="selectbox1" name="itemsPerPage" class="sub_select" style="margin-left:0;" onchange="moveSize(this.value);">
								  <span class="sub_arr"></span>
								  <option value="10" <c:if test="${vo.pageSize == 10}">selected="selected"</c:if>>10</option>
								  <option value="20" <c:if test="${vo.pageSize == 20}">selected="selected"</c:if>>20</option>
								  <option value="30" <c:if test="${vo.pageSize == 30}">selected="selected"</c:if>>30</option>
								  <option value="50" <c:if test="${vo.pageSize == 50}">selected="selected"</c:if>>50</option>
								</select>
								<select id=selectbox2 name="searchOrderBy" class="sub_select" onchange="moveSort(this.value);">
								  <span class="sub_arr"></span>
								  <option value="allOb">정렬조건</option>
								  <option value="titleOb" >Title</option>
								  <option value="yearOb">Year</option>
								  <option value="publisherOb">Publisher</option>
								</select>
								<select id=selectbox4 name="searchSort" class="sub_select" onchange="moveSort(this.value);">
								  <span class="sub_arr"></span>
								  <option value="basic">정렬</option>
								  <option value="desc" >내림</option>
								  <option value="asc">오름</option>
								</select>
								<a href="javascript:fn_all()" id="all_chk" class="center_text_02" ><!-- <i class="far fa-check-square"></i> --><span class="icon icon_check"></span>전체선택</a>
								<a href="#" class="center_text_02 bibliography"  onclick="javascript:selMultiMyLib('ebooks')"><span class="icon icon_book"></span>내서재담기<div id="library1"></div></a>						
								<!-- <a href="#" class="center_text_02">서지사항내려받기<div id="library2"></div></a> -->
						</div>   
			    	</div>       		
				</div>
				
				<div id="divRefreshArea">
					<p id="topInfo" class="top9"></p>
					<table class = 'basic_table'>
						<colgroup>
							<col style="width:10%">				
							<col>
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:15%">
						</colgroup>
						<thead>
							<tr>
								<th scope='col'>No.</th>
								<th scope='col'>Title</th>
								<th scope='col'>Author</th>
								<th scope='col'>Publisher</th>
								<th scope='col'>Publication<br />year</th>
							</tr>
						</thead>
						<tbody id = 'bodyInfo'>	
						</tbody>
					</table>
				</div>
				<div id="paging" class="paginate"></div>
			</div>
		</div>
	</div>

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" name="elib_id" id="elib_id" value="" alt="elib_id" /> 
	<input type="hidden" id="messege" name="messege" value="${messege}" alt="message">
	<input type="hidden" name="page" id="page" value="" alt="pageNum" /> 
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