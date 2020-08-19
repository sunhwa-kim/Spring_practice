<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<script type="text/javascript">

var del_file_list = "";

$(function(){
	
	if($("#message").val() != ''){
		var msg = $("#message").val();
		if(msg == 'fail'){
			alert("저장에 실패하였습니다.");
		}else if(msg =='success'){
			alert("저장이 완료 되었습니다.");
		}else if(msg =='login'){
			alert("로그인을 수행해 주십시오.");
		}
    }
    $("#message").val('');
    
    var page =$('#page_pop').val();
	if(page == '' ){
		page=1;
	}
	
	
    // 달력구성
	cmmfn_set_datepicker($("#publishing_date"), "yy-mm-dd");
	
	// 년도 셋팅
	getYear("pubyear",10,0);
	getYear("occu_year",10,0);


	//  성과 발생 년도	
	var combo_occu_year = $("#combo_occu_year").val();	 
	if(combo_occu_year != '' ){
		$('#occu_year option[value='+combo_occu_year+']').attr('selected',true);
	}
	
//  성과 발생 년도	
	var combo_pubyear = $("#combo_pubyear").val();	 
	if(combo_pubyear != '' ){
		$('#pubyear option[value='+combo_pubyear+']').attr('selected',true);
	}
	
	
	
	// 보고서 자료의 성과번호를 가져오기 위해
	$("#dialog").dialog({ 
		//이벤트 발생했을때 보여주려면 autoOpen : false로 지정해줘야 한다.
		autoOpen: false, 
		//레이어팝업 넓이 
		width: 1200, 
		height : 700,
		//뒷배경을 disable 시키고싶다면 true 
		modal: false, 
		//버튼종류
		buttons: [ { 
			//버튼텍스트 
			text: "선택",
			//클릭이벤트발생시 동작
			click: function() { 
				
				var tdVal = $(".on").children();	

				$("#proj_tit_kor").val(tdVal.eq(1).text());
				$("#pi").val(tdVal.eq(2).text());
				$("#org_name").val(tdVal.eq(3).text());	
				$("#archive_busino").val(tdVal.eq(5).text());
				$("#archive_rep_id").val(tdVal.eq(6).text());
				$( this ).dialog( "close" );
				
				} 
		}, 
		{ 
			//버튼텍스트
			text: "취소", 
			//클릭이벤트발생시 동작 
			click: function() {
				$( this ).dialog( "close" ); 
				} 
		} 
		]
	});

	
});


function fn_linkSelect(row){
	var tdVal = $(row).children();		

	$("#proj_tit_kor").val(tdVal.eq(1).text());
	$("#pi").val(tdVal.eq(2).text());
	$("#org_name").val(tdVal.eq(3).text());
	//$("#proj_tit_kor").val(tdVal.eq(4).text());
	$("#archive_busino").val(tdVal.eq(5).text());
	$("#archive_rep_id").val(tdVal.eq(6).text());
	 
	$("#dialog").dialog( "close" );
}

function fn_linkClick(row){	
	$('#bodyInfo .on').attr('class','off');
	$(row).attr('class','on');			
}

function fn_rep_search(page){
	//현재 페이지 세팅
	
	
	cuurPage= page;
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/

	$('#page_pop').val(cuurPage);


	var params = {};
  		params.page=cuurPage;
		params.searchKeyword = $('#rep_searchKeyword').val();
		params.searchCondition = $('#rep_searchCondition option:selected').val(); 
	
		
    $.ajax({
        url: '${ctxt}/archive/report/reportRead.do',
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
					
					var rep_id = obj.find('rep_id').text();
											
					var proj_tit_kor = obj.find('proj_tit_kor').text();
					var proj_tit_eng = obj.find('proj_tit_eng').text();
					var pi = obj.find('pi').text();
					var pubyear = obj.find('pubyear').text();
					var busino = obj.find('busino').text();
					var org_name = obj.find('org_name').text();
					var order_sn = obj.find('order_sn').text();   // 정렬순서
				
					var proj_tit = "";
					if(proj_tit_kor != ''){
						proj_tit =  proj_tit_kor;
					}else{
						proj_tit =  proj_tit_eng;
					}
					
					html += '<tr  class="off"  ondblclick="javascript:fn_linkSelect(this);" onclick ="fn_linkClick(this)">';
					html += ' <td style = "text-align:center;">'+(dataTotalCnt  - (order_sn -1)) +'</td>';
					html += ' <td class= "text-left">' + proj_tit + '</td>' ;

					//if(proj_tit.length>30){
					//	html += proj_tit.substr(0,30)+"..." +'</td>';
					//}else{
					//		html += proj_tit +'</td>';								
					//}
					html += ' <td style = "text-align:center;">'+ pi + '</td>';
					html += ' <td style = "text-align:center;">'+ org_name +'</td>';
					html += ' <td style = "text-align:center;">'+ pubyear +'</td>';
					html += ' <td style = "text-align:center;">'+ busino +'</td>';
					html += ' <td style = "text-align:center; display: none">'+ rep_id +'</td>';						
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
						$("#rep_searchKeyword").val("");
						$("#rep_searchCondition").val("ALL");
						
						fn_rep_search(cuurPage);
					}
				});
			    $("#topInfo").html("<span class = 'gray'>["+ cuurPage +" / "+pageTotalCnt+" Pages]</span> <span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.");
			    $("#bodyInfo").html(html);
			  
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$('#paging').children().remove();
				
				$("#bodyInfo").html('<tr><td colspan="6" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
			
			$("#dialog").dialog("open");
			
			$(".ui-widget-content").css("background" , "#ffffff");
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}


//수정
function fn_save(){
	
	if(cmmfn_check_inputnull($("#pubyear, #occu_year , #archive_busino , #atc_title_kor ,#atc_title_eng , #journal_nm , #author ,#jour_str_page ,#jour_end_page ,#volumename , #publishing_date")) == false){
		
		return;
	}
	
	
	if(confirm("성과논문 내용을 저장 하시겠습니까?") ==false){
		return;
	}
		
	
	var form  = document.reqForm;
		
	form.submit();
}


function fn_delete(){

	/* if(confirm("삭제 하시겠습니까?") ==false){
		return;
	} */
		
	var form  = document.reqForm;
	form.action = "${ctxt}/archive/rnd/deleteArchiveRnd.do?${_csrf.parameterName}=${_csrf.token}";
	form.submit();
	
}


// 날짜 유효성 체크
function fn_validDate(obj) {

 	var str =  $(obj).val();

	  if(str!=""){
	
		  oDate = new Date();
		  oDate.setFullYear(str.substring(0, 4));
		  oDate.setMonth(parseInt(str.substring(5, 7)) - 1);
		  oDate.setDate(str.substring(8,10));

		  if( oDate.getFullYear()     != str.substring(0, 4)
		      || oDate.getMonth() + 1 != str.substring(5, 7)
		      || oDate.getDate()      != str.substring(8,10) ) {
	   	    
		  alert("날짜 형식이 유효하지 않습니다.");
		  $(obj).val("");
		  $(obj).focus();
		  
	      return false;
	      
	 	  }
	  }
}
	



	
function fn_backPage(param){
	
	var form=document.reqForm;
	if(param == 'V'){
		form.action="${ctxt}/archive/rnd/rndView.do?${_csrf.parameterName}=${_csrf.token}";	
	}else{
		form.action="${ctxt}/archive/rnd/rndList.do?${_csrf.parameterName}=${_csrf.token}";
	}
	
	form.submit();
	
}


//첨부파일(공통) 수정
function fileModify() {

	var atchLinkId = $("#atch_link_id").val();
	
	var contextName = "ncmik";
	var fileKey = atchLinkId;
	var userId = "${userVo.emplyrkey}";
 	var savePath = "archive_rnd";
	var pageTitle = "";
	
	if($("#atc_title_kor").val() != ""){
		pageTitle = $("#atc_title_kor").val();
	}else{
		pageTitle = $("#atc_title_eng").val();
	}

 popAttfileModify(fileKey, contextName, userId, savePath, pageTitle);
}

//첨부파일(공통) 보기
function fileView() {
	
	var atchLinkId = $("#atch_link_id").val();
	var rnd_id = $("#rnd_id").val();
	var contextName = "ncmik";
	var fileKey = atchLinkId;
	var pageTitle = "";
	
	if($("#atc_title_kor").val() != ""){
		pageTitle = $("#atc_title_kor").val();
	}else{
		pageTitle = $("#atc_title_eng").val();
	}

	fn_downloadUpdate(fileKey, contextName, pageTitle , rnd_id , 'rnd');
}

//첨부파일(공통) 삭제
function allDatafileDelete() {
	
	if(confirm("삭제 하시겠습니까?") ==false){
		return;
	}
	
	var atchLinkId = $("#atch_link_id").val();
	var contextName = "ncmik";
	var fileKey = atchLinkId;
		
	deleteContents(fileKey, contextName);
//	  alert('첨부파일 삭제처리 완료 : orgFormSubmit() 함수를 Call 함');
	  // 여기서 자동으로 orgFormSubmit() 함수를 불러줌
}

function orgFormSubmit() {
	fn_delete();
}

	
</script>
<style>
#rep_searchCondition{
	height: 38px;
    border: 1px solid #ccc;
    color: #7f7f7f;
    margin-right: 8px;
    padding: 0 10px;
    min-width:100px;
}
</style>
		
 <form id="reqForm" name="reqForm" action="${ctxt}/archive/rnd/updateArchiveRnd.do?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
			
	 <div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>아카이브</span>
			<span> > </span>
			<span>성과논문</span>        
			<span> > </span>
			<span class="active">성과논문 수정</span>
		</div>
		<span class="center_text_01">성과논문</span>
	</div> 
	<div class="under_bar"></div>
	
	<div class = "content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div class="list_title">
					<p id="search_cn">성과논문 수정<span id="topCnt"></span></p>
				</div>	
			<table class=  "view_table">
				<caption>
					성과논문 
				</caption>
				<colgroup>
					<col width='15%' />						
						<col width='35%' />
						<col width='15%' />
						<col width='35%' />														
				</colgroup>
				<tbody  class="report">
					<tr>
						<th scope='row'>발행년도   <span class="txt_red">*</span></th>
						<td>							
							<div  class="item">
								<select id="pubyear"  name="pubyear"  title="발행년도">
								</select>
						  	</div>		
						</td>	
						<th scope='row'>성과발생년도   <span class="txt_red">*</span></th>
						<td>
							<div  class="item">
								<select id="occu_year"  name="occu_year"  title="성과발생년도">
								</select>
						  	</div>	
						</td>						
					</tr>	
					<tr>
						<th scope='row'>연계과제   <span class="txt_red">*</span></th>
						<td colspan="3"  class="padding_l">    		
							<div>
				            <table class="right_0">
				              <caption>연계과제  <span class="txt_red">*</span></caption>
								<colgroup>
										<col width='12%' />						
										<col width='*%' />								
									</colgroup>
								<tbody>
									<tr>											
										<th scope='row' style="letter-spacing:3px;">과제번호</th>
										<td style="position:relative;">    												
											<input id="archive_busino" name="archive_busino"  class="full"  type="text" readonly="readonly" value ="${resultVO.archive_busino}" style="width:507px; background-color:rgb(235,235,228) ;" title="과제번호"/>	
											<input id="archive_rep_id" name="archive_rep_id"  class="full"  type="hidden" value = "${resultVO.archive_rep_id}" title="보고서 id" />
											<input name="btn_linkReport"  class="full selector_button right_0"  type="button"  value = "보고서선택" onclick="javascript:fn_rep_search('1')"/>
										</td>					
									</tr>
									<tr>
										<th scope='row'>책임연구원</th>
										<td colspan="3">   
											<input id="pi" name="pi"  class="full"  type="text"  disabled="disabled" style="width: 100%;" value = "${resultVO.pi}" title="책임연구원"/>
										</td>														
									</tr>	
									<tr>
										<th scope='row'>연구과제명</th>
										<td colspan="3">   
										<c:choose>
											<c:when test="${resultVO.proj_tit_kor ne ''}">
												<input id="proj_tit_kor" name="proj_tit_kor"  class="full" disabled="disabled"  type="text" value = "${resultVO.proj_tit_kor}"  style="width: 100%;" title="연구과제명_국문"/>
											</c:when>
											<c:otherwise>
												<input id="proj_tit_eng" name="proj_tit_eng"  class="full" disabled="disabled"  type="text" value = "${resultVO.proj_tit_eng}"  style="width: 100%;" title="연구과제명_영문"/>
											</c:otherwise>
										</c:choose>																								
										</td>						
									</tr>										
								</tbody>
				              </table>
							</div>	 								  				
						</td>																	
					</tr>					
					<tr>
						<th scope='row'>논문명   <span class="txt_red">*</span></th>
						<td colspan="3" class="padding_l">    		
							<div>
				              <table style="width: 100%">
				              <caption>논문명</caption>
								<colgroup>
									<col width='12%' />						
									<col width='*' />								
								</colgroup>
								<tbody>								
									<tr>
										<th scope='row'>국&nbsp; &nbsp; &nbsp;문</th>
										<td>   
											<input id="atc_title_kor" name="atc_title_kor"  class="full"  type="text" style="width: 100%;" value="${resultVO.atc_title_kor}" title="논문명_국문"/>
										</td>						
									</tr>
									<tr>
										<th scope='row'>영&nbsp; &nbsp; &nbsp;문</th>
										<td>   												
											<input id="atc_title_eng" name="atc_title_eng"  class="full"  type="text" style="width: 100%;" value="${resultVO.atc_title_eng}"  title="논문명_영문"/>
										</td>						
									</tr>	
								</tbody>
				              </table>
							</div>	 								  				
						</td>																	
					</tr>	
					<tr>						
						<th scope='row'>국내외구분</th>
						<td colspan="3" class="padding_l"> 						
							<input type="radio" class="radio_style2" id="inoutflag_in"  name="inoutflag" value="I" ${resultVO.inoutflag eq 'I'?'checked="checked"':''}  /> <label class="margin_r_20" for="inoutflag_in">국내</label>
							<input type="radio" class="radio_style2"  id="inoutflag_out" name="inoutflag" value="O" ${resultVO.inoutflag eq 'O'?'checked="checked"':''}  /> <label class="margin_r_20" for="inoutflag_out">국외</label>
						</td>						
					</tr>
					<tr>
						<th scope='row'>학술지명   <span class="txt_red">*</span></th>
						<td colspan="3"  class="padding_l">
							<input id="journal_nm" name="journal_nm"  class="full"  type="text" value="${resultVO.journal_nm}" style="width: 100%;" title="학술지명"/>
						</td>						
					</tr>
					<tr>
						<th scope='row'  >ISSN</th>
						<td>					
							<input id="rnd_issn" name="rnd_issn"  class="full"  type="text" value="${resultVO.rnd_issn}" title="ISSN"/>
						</td>
						<th scope='row'  >DOI</th>
						<td>
							<input id="doi" name="doi"  class="full"  type="text" value="${resultVO.doi}" title="ISSN"/>
						</td>						
					</tr>
					<tr>
						<th scope='row'>주저자명(제1저자)</th>
						<td colspan="3"  class="padding_l">
							<input id="author" name="author"  class="full"  type="text" value="${resultVO.author}" style="width: 100%;" title="주저자명(제1저자)"/>		
						</td>
					</tr>	
					<tr>
						<th scope='row'>공동저자</th>
						<td colspan="3" class="padding_l">
							<input id="co_author" name="co_author"  class="full"  type="text"  value="${resultVO.co_author}" style="width: 100%;" title="공동저자"/>	
						</td>	
					</tr>	
					<tr>
						<th scope='row'>교신저자</th>
						<td colspan="3" class="padding_l">
							<input id="commu_author" name="commu_author"  class="full"  type="text" value="${resultVO.commu_author}" style="width: 100%;" title="교신저자"/>	
						</td>
					</tr>	
					<%-- <tr>
						<th scope='row'>권/호</th>
						<td colspan="3">
							<input id="volumename" name="volumename"  class="full"  type="text" value="${resultVO.volumename}"  style="width: 20%;" title="권/호"/>	
						</td>							
					</tr>	 --%>
					<tr>
						<th scope='row'>논문페이지   <span class="txt_red">*</span></th>
						<td>  		
							<div>
				              <table style="width: 100%">
				              <caption>논문페이지</caption>
								<colgroup>
									<col width='40%' />						
									<col width='60%' />							
								</colgroup>
								<tbody>
									<tr>
										<th scope='row'>논문시작페이지</th>
										<td>   
											<input id="jour_str_page" name="jour_str_page"   class="full"  type="number" min="0" value="${resultVO.jour_str_page}"  title="논문시작페이지"/>			
										</td>						
									</tr>
									<tr>
										<th scope='row' style="letter-spacing:2px;">논문끝페이지</th>
										<td>   
											<input id="jour_end_page" name="jour_end_page"   class="full"   type="number" min="0" value="${resultVO.jour_end_page}"  title="논문끝페이지"/>														
										</td>						
									</tr>	
								</tbody>
				              </table>
							</div>	 								  				
						</td>
						<th scope='row'>권 / 호  <span class="txt_red">*</span></th>
						<td class="padding_l">
							<input id="volumename" name="volumename"  class="full"  type="text" value="${resultVO.volumename}"  style="width: 100%;" title="권/호"/>	
						</td>	
																							
					</tr>	
					<tr>
						<th scope='row'>SCI구분</th>
						<td>				
							<input type="radio" class="radio_style2" name="sci_gbn" value="Y" ${resultVO.sci_gbn eq 'Y'?'checked="checked"':''}  /> <label class="margin_r_20" for="sci_gbn_y">예</label>
							<input type="radio" class="radio_style2" name="sci_gbn" value="N" ${resultVO.sci_gbn eq 'N'?'checked="checked"':''}  /> <label class="margin_r_20" for="sci_gbn_n">아니오</label>
						</td>
						<th scope='row'>학술지출판일자   <span class="txt_red">*</span></th>
						<td>
							<input id="publishing_date" name="publishing_date"  class="full"  type="text" value="${resultVO.publishing_date}" style="width: 100%;" title="학술지출판일자"/>
						</td>
					</tr>
					<tr>
						<th scope='row'>학술지임팩트팩터</th>
						<td colspan="3" class="padding_l">
							<input id="impact_factor" name="impact_factor"  class="full"  type="text" value="${resultVO.impact_factor}"  style="width: 100%;" title="학술지임팩트팩터"/>
						</td>
					</tr>
					<tr>
						<th scope='row'>키워드</th>
						<td colspan="3"  class="padding_l">
							<input id="keyword" name="keyword"  class="full"  type="text"  value="${resultVO.keyword}" style="width: 100%;" title="키워드"/>
						</td>						
					</tr>	
					<tr>
						<th scope='row'>초록</th>
						<td colspan="3"  class="padding_l">      
						  <div  class="item">
							<textarea id="rnd_abs" name="rnd_abs"    rows="15"  style= "width:100%;"  title="초록" ><c:out value="${resultVO.rnd_abs}"></c:out></textarea>		
						  </div>					
						</td>							
					</tr>
					<tr>
				        <th scope="row">파일</th>
				        <td colspan="3" >
							<c:if test="${resultVO.atch_link_id != null}">
								<div>								
									<c:import charEncoding="utf-8" url="/cmm/fms/selectLinkFileInfs.do">
												<c:param name="param_atchFileId" value="${resultVO.atch_link_id}" />
									</c:import>
								</div>
							</c:if>
				        </td>
		       		</tr>	
					<tr id = "fileRow">
		            	<th>첨부파일</th>
			            <td id="uploadFiles" colspan="3">      
						   <input type='button' onClick='fileModify();' value='파일 수정'> 
					       <input type='button' onClick='fileView();' value='파일 보기'> 
			            </td>
	    			</tr>
	    										
				</tbody>
			</table>		

		<div class="btn-group">
				<a href="javascript:fn_backPage('V');" class='basic-btn'><span>취소</span></a>
				<a href="javascript:fn_backPage('R');" class='basic-btn'><span>목록으로</span></a>
				<a href="javascript:allDatafileDelete();"  class='basic-btn'><span>삭제</span></a>
				<a href="javascript:fn_save();"  class='basic-btn'><span>저장</span></a>
		</div>


	</div>
	</div>
	  
		
	
	
	
	<div id = "dialog" title="보고서 정보">  <!-- dialog 생성 -->
		        <div id="search-group">	  
				<div class="search-input" >
					<label for="searchCombo"></label>
					<select id="rep_searchCondition" name ="rep_searchCondition" title="분류">
						<option value="ALL">전체</option>
						<option value="TITL">연구과제명</option>
						<option value="PI">책임연구원</option>
						<option value="ORG">발행자</option>		
					</select>
					<label for="searchBox"></label>
					<input type="text" id="rep_searchKeyword" name= "rep_searchKeyword"  onkeydown="fn_enter_search(this);" placeholder="검색어를 입력해주세요."/>
	            	<input type="button" id="btnSearch" value="검색" onclick="javascript:fn_rep_search(1)"/>				                		
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
							<col style="width:10%">
							<col style="width:25%">
							<col style="width:10%">
							<col style="width:15%">				
						</colgroup>
						<thead>
						<tr>
							<th scope='col'>번호</th>
							<th scope='col'>연구과제명</th>
							<th scope='col'>책임연구원</th>
							<th scope='col'>발행자</th>		
							<th scope='col'>발행년도</th>
							<th scope='col'>과제번호</th>		
							<th scope='col' style="display: none">보고서id</th>												
						</tr>
						</thead>
						<tbody id = 'bodyInfo'>
							
						</tbody>
					</table>			
					<div id="paging" class="paginate"  style ="text-align: center;"></div>			
			</div>
	</div>
	
	<!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" />
	
   <!-- 검색 PARAM -->
	<input type="hidden" name="page" id="page" value="${resultVO.page}" alt="pageNum" /> 
	<input type="hidden" name="page_pop" id="page_pop" value="" alt="pageNum" /> 
	
	<input type="hidden" id="searchCondition" name="searchCondition" value="${resultVO.searchCondition}"  alt="검색콤보" />
	<input type="hidden" id="searchKeyword" name="searchKeyword" value="${resultVO.searchKeyword}" alt="검색어" />
	
	<input type="hidden" id="rnd_id" name="rnd_id" value="${resultVO.rnd_id}"  alt="id" />
	
	<!-- 콤보 셋팅 -->
	<input type="hidden" id="combo_occu_year" name="combo_occu_year" value="${resultVO.occu_year}" alt="occu_year">
	<input type="hidden" id="combo_pubyear" name="combo_pubyear" value="${resultVO.pubyear}" alt="pubyear">
	
	<!-- 처리 메세지 PARAM -->
	<input type="hidden" id="message" name="message" value="${message}" alt="message">		
	
	
	<!-- 필터 유지 위한 PARAM -->
	<input type="hidden" name="fillterYearList_s" id="fillterYearList_s" value = "${resultVO.fillterYearList_s}" alt="필터 발행년도" />
	
	<input type="hidden" name="fillterYearCnt" id="fillterYearCnt" value = "${resultVO.fillterYearCnt}" alt="필터 발행년도 CNT" />
		
	<!-- 리턴 페이지  -->
	<input type="hidden" id="returnPageGbn" name="returnPageGbn" value="${resultVO.returnPageGbn}"  alt="returnPageGbn">
		
	<input type="hidden" name="del_file_list" id="del_file_list" value="" />
	<input type="hidden" id="atch_link_id" name="atch_link_id" value="${resultVO.atch_link_id}" alt="atch_link_id">
	
</form>

<!-- 파일 다운로드폼  -->
<form id= "downForm" name=  "downForm" action ="" method="post"  enctype="multipart/form-data">
	<input type="hidden" value="${resultVO.rnd_id}" id="down_file_id" name = "down_file_id" >
</form>	