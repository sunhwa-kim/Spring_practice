<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
var closePop=""; // 팝업창 제어를 위해..
var atozVal="";


$(function(){
	var page =$('#page').val();
	if(page == '' || page == null){
		page=1;
	}
	 
	// 화면 목록 조회
	fn_search(page , '' , '' );
/* 	// A TO Z 검색시 해당 메뉴 색상 변경
	if(atozVal != ""){
		alert(atozVal);
		$('.atozSearch > ul > li > a').each(function() {
			if( $(this).text() == atozVal){
				$(this).css({"color":"#eb6f15","font-weight":"bold"});
			}
		});
		if( $('.atozSearch > ul > li > a > span').text() == atozVal){
			$('.atozSearch > ul > li > a > span').css({"color":"#eb6f15","font-weight":"bold"});
		}
		
	} */
});  

function fn_search( page, searchCondition, searchKeyword){
	//alert(page + " ,"+ searchCondition + ","+ searchKeyword);
	//텍스트상자에서 엔터키로 검색할때 현재 페이지 번호가 undifined인 현상 해결 시작
	if(!page){
		page = '1';
	}
	//텍스트상자에서 엔터키로 검색할때 현재 페이지 번호가 undifined인 현상 해결 끝
	
	//현재 페이지 세팅
	cuurPage= page;
	
	$('#page').val(cuurPage);
	
	
	
	var params = {};
	params.page=cuurPage;
	params.elib_type = 'ejournals';
	
	if(searchKeyword != null && searchKeyword != ''){
	
		if(searchCondition == '35'){
			params.searchKeyword = '';	
			$('#searchKeyword').val('');
		}else{
			params.searchKeyword = searchKeyword;
			$('#searchKeyword').val(searchKeyword);
		}
		
	}
	params.elibagreeOpen = '${elibagreeOpen}';
	params.searchCondition = searchCondition;
	params.searchKey = $('#searchKey').val();
	/* alert($('#searchKey').val()); */
	params.theme_field = "all";//$("#subject option:selected").val();
	
	$.ajax({
	    url: '${ctxt}/elib/ejournals/readEJournalVO.do',
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
				
				//사용자 분기 및 조회 조건 변수 선언
				var innerIp = '${INNER_IP}';
				var loginid = '${userVO.loginid}';
				var instttyid = '${userVO.instttyid}';
				var mouLoan = '${userVO.mouLoan}';
				var elibYn = '${userVO.elibagree}';
				//사용자 분기 및 조회 조건 변수 선언 끝
				
				xmlList.each(function(i){
					var obj = $(this);
					
					// DB로부터 불러온 변수 선언
					var elib_link = obj.find('elib_link').text();
					var arrelib_link = elib_link.split(',');
					var package_nm = obj.find('package_nm').text();
					var arrPackage = package_nm.split(',');
					var elib_sj = obj.find('elib_sj').text();
					var issn = obj.find('issn').text();
					var arrissn = issn.split(',');
					issn = arrissn[0];
					var elib_id = obj.find('elib_id').text();
					var arrelibId = elib_id.split(',');
					elib_id = "";
					var elibagree = obj.find('elibagree').text();
					var arrelibagree = elibagree.split(',');
					var lang_type = obj.find('lang_type').text();
					var arrlang_type = lang_type.split(',');
					var class_type = obj.find('class_type').text();
					var arrclass_type = class_type.split(',');
					var publisher = obj.find('publisher').text();
					var arrpublisher = publisher.split(',');
					var isbn = obj.find('isbn').text();
					var arrisbn = isbn.split(',');
					var theme_field = obj.find('theme_field').text();
					var arrtheme_field = theme_field.split(',');
					var spcies_co = obj.find('spcies_co').text();
					var arrspcies_co = spcies_co.split(',');
					var coverage = obj.find('coverage').text();
					var arrcoverage = coverage.split(',');
					coverage = "";
					for(var j = 0 ; j < arrcoverage.length;j++){
						coverage += arrcoverage[j]+"<br>";
					}
					var embargo = obj.find('embargo').text();
					var arrembargo = embargo.split(',');
					embargo = "";
					for(var j = 0 ; j < arrembargo.length;j++){
						embargo += arrembargo[j]+"<br>";
					}
					
					var re_sj = elib_sj.replace(/\'/gi, "");
					re_sj = re_sj.replace(/\"/gi, "");			
					
					
					
					// DB로부터 불러온 변수 선언 끝
					
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
/* 					//테이블 파란 배경색 삽입
					if(obj.find('order_sn').text() %2 != 0){
						html += '<tr style="background-color: #EEE">';
					}else{
						
					}
					//테이블 파란 배경색 삽입 끝 */
// 					if(searchElibSj != elib_sj){
					html += '<tr>';
					/* 					html += ' <td>'+obj.find('order_sn').text() +'</td>'; */
					/* html += ' <td>ejournals</td>'; */
					html += '<td class="listtd" style="text-align: left;padding-left:10px;">'+ elib_sj;	
					//사용자별 분기 시작
					//사용자별 분기 끝
					html += '<td class="listtd" style="text-align: center;">' + issn + '<br>';
										
					html +='<td colspan="4" style="padding:0;">';
						html +='<table style="width:100%;">';
							html +='<tr style="">';
							html += '<td class="listtd" style="text-align: center; width:28%;">';
							
								for(var j = 0 ; j < arrelibId.length;j++){
									
									if(j > 0){     
										html += '<div class="under_bar"  style="width:80%;margin-left:10%;margin-top:5px;margin-bottom:5px;" ></div>';								
									}   
									
									if(arrelib_link[j] == ''){
										html += ''+elib_sj + issn + '';
										
									}else if( innerIp == 'Y'){ <%-- 건물내 이용 --%>
										html += '<a href="#" onclick="elibPopInternalIp(\'' +arrelib_link[j] +'\', \'E\');addptlStatAccess(\'' +arrelibId[j] +'\',\'' +re_sj +'\');" title="새창">'+'<span style="color:#1A96D9" title="새창">'+arrPackage[j]+'</span>' +'</a>';
									}else if( loginid == ''){
										html += '<a style="cursor:pointer;" href="#"  onclick="javascript:popLink();" title="새창">'+ arrPackage[j]+'</a>';
									}else{
										<%-- 무제한 이용 --%>
										if( arrelibagree[j] == '1' || arrelibagree[j] == '5'){
											html += '<a href="#" onclick="elibPop(\''+ arrelib_link[j] +'\', \'E\');addptlStatAccess(\''+ arrelibId[j] +'\',\''+ re_sj +'\');" title="새창">'+ arrPackage[j] + '</a>';
										<%-- 건물내 이용 --%>
				 						}else if(arrelibagree[j] == '2' && innerIp == 'Y'){
											html += '<a href="#" onclick="elibPopInternalIp(\''+ arrelib_link[j] +'\', \'E\');addptlStatAccess(\''+ arrelibId[j] +'\',\''+ re_sj +'\');" title="새창">'+ arrPackage[j] + '</a>';
										<%-- 소속 직원 이용가능 --%>	
										}else if(arrelibagree[j] == '3' && (instttyid == '1' || instttyid == '2')){
											html += '<a href="#" onclick="elibPopInternalIp(\''+ arrelib_link[j] +'\', \'E\');addptlStatAccess(\''+ arrelibId[j] +'\',\''+ re_sj +'\');" title="새창">'+ arrPackage[j] + '</a>';
										<%-- 승인회원 이용가능 --%>
										}else if((arrelibagree[j] == '2' || arrelibagree[j] == '3' || arrelibagree[j] == '4') && elibYn == 'Y'){
											html += '<a href="#" onclick="elibPop(\''+ arrelib_link[j] +'\', \'E\');addptlStatAccess(\''+ arrelibId[j] +'\',\''+ re_sj +'\');" title="새창">'+ arrPackage[j] + '</a>';
										}else{
											html += arrPackage[j]+ '</span>';											
										}
									}
									html+='<br>';
								}
								html +='</td>';
								html += '<td class="listtd" style="text-align: center; width:24%;">' + coverage;				
								html += '<td class="listtd" style="text-align: center; width:20%;">' + embargo;				
								html += '<td class="listtd" style="text-align: center; width:10%;">';
						
					var tot_len = arrelibId.length;			
					for(var j = 0 ; j < arrelibId.length;j++){    
	
						if(j > 0){     
							html += '<div class="under_bar" style="width:80%;margin-left:10%;margin-top:5px;margin-bottom:5px;"></div>';								
						}  
						html += '<a href="javascript:popOpen(\'ehournals'+arrelibId[j]+'\');" style="padding-right:20px;text-align:right;"><i class="far fa-file-alt" style="display:inline;"></i></a>';
						/* html += '<a href="javascript:popOpen(\'ehournals'+arrelibId[j]+'\'); "><i class="far fa-comment-alt" style="display:inline;"></i></a>'; */
						/* html += '<a href="javascript:popOpen(\'ehournals'+arrelibId[j]+'\');"><img src="${ctxt}/resources/images/sub/information_icon.png" style="width:3px;"></a><br>'; */
						
						html +='<div class="schedule" id=\'ehournals'+arrelibId[j]+'\' >';  
						html +='<strong>저널 상세정보</strong>';
						
						if(arrlang_type[j] == 'undefined'){
							html +='<div><p class="schedule_l">국/내외    :</p>  		'+'<p class="schedule_r">'+''+'</p>'+'</div>';
						}else {
							html +='<div><p class="schedule_l">국/내외    :</p>  		'+'<p class="schedule_r">'+arrlang_type[j] +'</p>'+'</div>';
						}	
						
						if(elib_sj == 'undefined'){
							html +='<div><p class="schedule_l">TITLE   :</p>	'+'<p class="schedule_r">'+'' +'</p>' +'</div>';
						}else{
							html +='<div><p class="schedule_l">TITLE   :</p>	'+'<p class="schedule_r">'+elib_sj +'</p>' +'</div>';
						}
						
						if(arrelib_link[j] == 'undefined'){
							html +='<div><p class="schedule_l">링크 URL   :</p> 	'+'<p class="schedule_r">'+'' +'</p>'+'</div>';
						}else{
							html +='<div><p class="schedule_l">링크 URL   :</p> 	'+'<p class="schedule_r">'+arrelib_link[j] +'</p>'+'</div>';
						}						
						/* html +='<div><p class="schedule_l">출판사   :</p> 		'+'<p class="schedule_r">'+arrpublisher[j]+'</p>' +'</div>'; */
						if(issn == 'undefined'){
							html +='<div><p class="schedule_l">ISSN   :</p> 		'+'<p class="schedule_r">'+''+'</p>'+'</div>';
						}else{
							html +='<div><p class="schedule_l">ISSN   :</p> 		'+'<p class="schedule_r">'+issn+'</p>'+'</div>';
						}
		
			        	html +='<span class="arrw"></span>';
			        	html +='<p class="close" ><a href="javascript:popClose(\'ehournals'+arrelibId[j]+'\');">[닫기]</a></p>';
			        	html +='</div>';
					}
								html +='</td>';
							html +='</tr>';
						html +='</table>';
					html +='</td>';

					html +='</tr>';
	
	
		        });
				//페이징처리
			    $('#paging').paging({
			    	
					 current:cuurPage
					,max:pageTotalCnt
					,length:pageLen
					,onclick:function(e,page){
						cuurPage=page;
						fn_search(cuurPage, searchCondition, $('#searchKeyword').val());
					}
				});
				if(cuurPage == ''){
					cuuurPage == '1';
				}
				$("#topInfo").html("<span class='gray'>["+ cuurPage +" / "+pageTotalCnt+" Pages]</span><span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.");
			    $("#bodyInfo").html(html);
			  
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$('#paging').children().remove();
				$("#topInfo").html("["+ 1 +" / "+1+" Pages] <span class = 'txt-red' >"+ pageTotalCnt +"</span> 건이 검색되었습니다.");
				$("#bodyInfo").html('<tr><td colspan="6" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
	    },
	    error : function(){                              // Ajax 전송 에러 발생시 실행
	      fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
	    }
	});
}
//전자정보 오류신고
function elibErrorLink(elibId){
	var loginCheck = "<c:out value='${userVo}' />";
	
	if(loginCheck != ""){
		var url = '${ctxt}/elib/webdb/listWebError.do';
		$("#elib_id").val(elibId);
		
		var form = document.webError;
		form.action=url
		form.submit();
			
	}else{
		if (confirm('로그인 후 이용 가능한 서비스 입니다.\n로그인 하시겠습니까?')) 
		location.href="${ctxt}/login/user/login.do?returnURL=/elib/ejournals/listEjournals.do";
	}
	
}


//  팝업 - 상세 페이지를 보여준다 STR
function popClose(a) { 
// 	document.getElementById(a).style.display  ='none';
	$("#"+a).css("display","none");
}

function popOpen(a) { 
	// 새창을 클릭시 다른창은 닫도록 제어..
	if(closePop!= ""){
		if(a !=closePop){
			popClose(closePop);
		}
	}

	closePop = a;
	a = "";
	
	document.getElementById(closePop).style.display  ='block';
}
//팝업 - 상세 페이지를 보여준다 END
/* 전자자원 팝업링크 */
function popLink(){
	if (confirm('로그인 후 이용 가능한 서비스 입니다.\n로그인 하시겠습니까?')) 
	 location.href="${ctxt}/login/user/login.do?returnURL=/elib/ejournals/listEjournals.do";
}

	
function fn_ejournals_enter_search(param){
	var id_val = $(param).attr('id');	
	
	if(event.keyCode == 13)
	{
		event.preventDefault();
		fn_search('1', '1' ,$('#searchKeyword').val());
	}	
}
</script>

<style>

#searchKey{
	margin-right:4px;
}
#btnSearch{
	margin-left:5px;
}
#subject{
		width:375px;
		transition:all 0.2s;
		-webkit-transition:all 0.2s;
	}
	.basic_table th:first-child{width:30%;}
	.basic_table>#bodyInfo>tr>td:nth-child(1){
		width:35%;
	}
	.basic_table th:nth-child(2){width:10%;}
	.basic_table>#bodyInfo>tr>td:nth-child(2){
		width:5%;
	}
	.basic_table th:nth-child(3){width:25%;}
	.basic_table>#bodyInfo>tr>td:nth-child(3){
		width:60%;
	}
	.basic_table th:nth-child(4){width:15%;}
	.basic_table>#bodyInfo>tr>td:nth-child(4){
		width:0%;
	}
	.basic_table th:nth-child(5){width:15%;}
	.basic_table>#bodyInfo>tr>td:nth-child(5){
		width:0%;
	}
	.basic_table th:nth-child(6){width:5%;}
	.basic_table>#bodyInfo>tr>td:nth-child(6){
		width:0%;
	}
.surch_box1.center{
		float:right;
	}
tr td.listtd:last-child > a {
	display:block;
}
tr td.listtd:last-child > a:after{
	clear:both;
	display:block;
	content:"";
}
tr td.listtd:last-child > a > img {
	width:20px;
	float:left;
	margin-bottom:-25px;
	margin-left:5px;
}





	
	
	@media all and (max-width:882px) {
		.move.surch_box1.center {
		    float: none;
		    position: relative;
		    margin: 0 auto;
		    margin-top: 10px;
		    display:block;
		    height:82px;
		    transition:all 0.2s;
			-webkit-transition:all 0.2s;
		}
		.surch_box.center {
		    text-align: center;
		    transition:all 0.2s;
			-webkit-transition:all 0.2s;
		}
		#atozCont {
		    width: 100%;
		    float: none;
		    display: inline-block;
		    max-width:406px;
		    transition:all 0.2s;
			-webkit-transition:all 0.2s;
		}
		.basic_table{
			font-size:12px;
		}
		.surch_box1 > #subject{
			position:relative;
			top:0;
		}
	}
	@media all and (max-width:602px) {
		#subject{
			width:311.19px;
		}
		.basic_table>#bodyInfo>tr>td:nth-child(1){
			width:50%;
		}
		.basic_table>#bodyInfo>tr>td:nth-child(2){
			width:45%;
		}
		.basic_table>#bodyInfo>tr>td:nth-child(3){
			width:5%;
		}
		.basic_table>#bodyInfo>tr>td:nth-child(4),
		.basic_table>#bodyInfo>tr>td:nth-child(5),
		.basic_table>#bodyInfo>tr>td:nth-child(6){
			width:0%;
			display:none;
		}

		.basic_table>thead>tr>th:nth-child(4),
		.basic_table>thead>tr>th:nth-child(5){
			width:0%;
			display:none;
		}
		.basic_table>thead>tr>th:nth-child(3){
			padding-left:8%;
		}

		.basic_table>#bodyInfo>tr>td>table>tbody>tr>td:nth-child(2),
		.basic_table>#bodyInfo>tr>td>table>tbody>tr>td:nth-child(3){
			display:none;
			width:0%;
		}
		.basic_table>#bodyInfo>tr>td>table>tbody>tr>td:nth-child(4){
			width:100%; 
		}
	}
		@media all and (max-width:600px) {
			.paginate {
	   			margin-top: 20px;
			}
			#subject{
				width: 303px; 
				text-aling:center;
				transition: all 0.2s;
		    	-webkit-transition: all 0.2s;
			}
			#searchKeyword{
				width: 170px;
			}
	}
	@media (max-width: 430px){
		#searchKeyword{
				width: 130px;
				transition: all 0.2s;
		    	-webkit-transition: all 0.2s;
			}
	}
	@media (max-width: 410px){
		#subject{
			width: 275px; 
			text-aling:center;
			transition: all 0.2s;
	    	-webkit-transition: all 0.2s;
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
		    <span class="active">E-Journals</span>        
		</div>
		<span href="#" class="center_text_01">E-Journals</span>
	</div> 
		
	<div class="under_bar"></div>
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
				<!-- <div class="tabMenu" >
				</div> -->
				<div class="surch_box center">
			    	<!-- <div class="surch_box"> -->
				        <div id="atozCont" style="float:none;">
				       <%--  	<h3><a href="${ctx}/elib/ejournals">전체</a></h3> --%>
							<div class="atozSearch">
								<ul>
									<li>								
										<a title="A" onclick="fn_search(1,'20','A')" href="#">A</a>
										<a title="B" onclick="fn_search(1,'20','B')" href="#">B</a> 
										<a title="C" onclick="fn_search(1,'20','C')" href="#">C</a> 
										<a title="D" onclick="fn_search(1,'20','D')" href="#">D</a> 
										<a title="E" onclick="fn_search(1,'20','E')" href="#">E</a> 
										<a title="F" onclick="fn_search(1,'20','F')" href="#">F</a> 
										<a title="G" onclick="fn_search(1,'20','G')" href="#">G</a> 
										<a title="H" onclick="fn_search(1,'20','H')" href="#">H</a> 
										<a title="I" onclick="fn_search(1,'20','I')" href="#">I</a> 
										<a title="J" onclick="fn_search(1,'20','J')" href="#">J</a> 
										<a title="K" onclick="fn_search(1,'20','K')" href="#">K</a> 
										<a title="L" onclick="fn_search(1,'20','L')" href="#">L</a> 
										<a title="M" onclick="fn_search(1,'20','M')" href="#">M</a>
									</li>
									<li>
										<a title="N" onclick="fn_search(1,'20','N')" href="#">N</a>
										<a title="O" onclick="fn_search(1,'20','O')" href="#">O</a> 
										<a title="P" onclick="fn_search(1,'20','P')" href="#">P</a> 
										<a title="Q" onclick="fn_search(1,'20','Q')" href="#">Q</a> 
										<a title="R" onclick="fn_search(1,'20','R')" href="#">R</a> 
										<a title="S" onclick="fn_search(1,'20','S')" href="#">S</a> 
										<a title="T" onclick="fn_search(1,'20','T')" href="#">T</a> 
										<a title="U" onclick="fn_search(1,'20','U')" href="#">U</a> 
										<a title="V" onclick="fn_search(1,'20','V')" href="#">V</a> 
										<a title="W" onclick="fn_search(1,'20','W')" href="#">W</a> 
										<a title="X" onclick="fn_search(1,'20','X')" href="#">X</a> 
										<a title="Y" onclick="fn_search(1,'20','Y')" href="#">Y</a> 
										<a title="Z" onclick="fn_search(1,'20','Z')" href="#">Z</a> 
										<a title="숫자" onclick="fn_search(1,'35','숫자')" href="#" class="atozTwoLayer"> 
											<span>숫<br>자</span>
										</a>
										
									</li>
									<li>
										<a title="가" onclick="fn_search(1,'21','가')" href="#">가</a>
										<a title="나" onclick="fn_search(1,'22','나')" href="#">나</a>
										<a title="다" onclick="fn_search(1,'23','다')" href="#">다</a> 
										<a title="라" onclick="fn_search(1,'24','라')" href="#">라</a> 
										<a title="마" onclick="fn_search(1,'25','마')" href="#">마</a> 
										<a title="바" onclick="fn_search(1,'26','바')" href="#">바</a> 
										<a title="사" onclick="fn_search(1,'27','사')" href="#">사</a> 
										<a title="아" onclick="fn_search(1,'28','아')" href="#">아</a> 
										<a title="자" onclick="fn_search(1,'29','자')" href="#">자</a> 
										<a title="차" onclick="fn_search(1,'30','차')" href="#">차</a> 
										<a title="카" onclick="fn_search(1,'31','카')" href="#">카</a> 
										<a title="타" onclick="fn_search(1,'32','타')" href="#">타</a> 
										<a title="파" onclick="fn_search(1,'33','파')" href="#">파</a> 
										<a title="하" onclick="fn_search(1,'34','하')" href="#">하</a>
									</li>
								</ul><!-- cont end -->
							</div><!-- AtoZ Search end --> 
						</div>	
		           		<div class="surch_box1 center move" style="margin-bottom:0;">
<%-- 							<select id="subject">
				           		<option value="all">주제 분야를 선택하세요</option>
				           		<c:forEach items="${subList}" var="eJournals">
				           		<option value="${eJournals}">${eJournals}</option>
				           		</c:forEach>       		
				           	</select> --%>
							<span id="subject">   
				       			<select id="searchKey" name="searchKey" title="분류"> 
				 					<option value="allSe">전체</option> 
				 					<option value="titleSe">Title</option> 
				 					<option value="db">DB명</option> 
				 					<option value="issn">ISSN</option> 
				 				</select> 
								<input type="text" id="searchKeyword" name="searchKeyword" placeholder="검색어를 입력하여 주십시오." value="${boardNotiVo.searchWord}" onkeydown="fn_ejournals_enter_search(this);"/>
				           		<input type="button" id="btnSearch" value="검색" onclick="fn_search(1, 1  ,$('#searchKeyword').val());"/>			                		 
			 				</span>
			           	</div>
		 			<!-- </div>  -->
				</div>
		
				<div id="divRefreshArea">
					<p id="topInfo" class="top9"></p>
					<table class = 'basic_table'>
						<%-- <caption>
						 	 공지사항 -  번호, 구분, DB 명, 내용, 주제분야, 오류신고, 설명서 
						</caption> --%>
						<%-- <colgroup>
							<col style="width:34%">				
							<col style="width:10%">
							<col style="width:16%">
							<col style="width:16%">
							<col style="width:16%">
							<col style="width:8%">
						</colgroup> --%>
						<thead>
							<tr>
								<th scope='col'>Journal title</th>
								<th scope='col'>ISSN</th>
								<th scope='col'>DB</th>
								<th scope='col'>COVERAGE</th>
								<th scope='col'>EMBARGO</th>
								<th scope='col'>Actions</th>
							</tr>
						</thead>
						<%-- <colgroup>
							<col style="width:45%">				
							<col style="width:17%">
							<col style="width:20%">
							<col style="width:13%">
							<col style="width:13%">
							<col style="width:12%">
						</colgroup>
						<thead>
							<tr>
								<th scope='col'>Journal title</th>
								<th scope='col'>ISSN</th>
								<th scope='col'>DB</th>
								<th scope='col'>COVERAGE</th>
								<th scope='col'>EMBARGO</th>
								<th scope='col'>Actions</th>
							</tr>
						</thead> --%>
						<tbody id = 'bodyInfo'>
						</tbody>
					</table>
				</div>
				<div id="paging" class="paginate" style="text-align: center;"></div>
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