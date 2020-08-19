<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
var xmlList;
var html="";
var cuurPage;
var isFilter="N";
var pageTotalCnt = 0;
var dataTotalCnt = 0;

var junalPageLen=10;

var str_vocatermid = "${vocatermid}";
var isVocatermid =false;
var detailYn = '${searchVo.detailYn}';

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
		$('#srchChoice option[value='+searchType+']').attr('selected',true);
	}
	//
	if(str_vocatermid != '' ){
		$('#div_vocatermid').attr('style','display:none;');
		isVocatermid=true;
	}else if('${searchVo.filterGbn}' == 'subjectArea'){
		var filterVal = '${searchVo.filterVal}';  

		$('#vocatermid option').each(function(){
			if($(this).attr('id') == filterVal){
				$(this).attr('selected',true);
			}   
		});
	}
	        
	// 화면 목록 조회
	fn_search(page);  
	    
});  

function fn_goJournal(str_bibctrlno){
	var form = document.junalForm;
	$('#bibctrlno').val(str_bibctrlno);
	form.action = "${ctxt}/elib/kom/junalHistory.do";
	form.submit();
}
function fn_goJournalDtl(str_bibctrlno){
	var form = document.junalForm;
	$('#bibctrlno').val(str_bibctrlno);
	form.action = "${ctxt}/elib/kom/junalDtl.do";
	form.submit();
}

var str_searchType;
var str_searchCondition;

function fn_enterSearch(param){
	isFilter="N";
	var id_val = $(param).attr('id');	
	
	if(event.keyCode == 13)
	{
		event.preventDefault();
		fn_search(1);
	}	
}

function fn_firstSearch(page){
	isFilter="N";
	fn_search(page)
}
var param_searchType;
var param_searchCondition;
var param_searchKeyword;

function fn_search(page){
	//현재 페이지 세팅
	
	cuurPage= page;
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/	
	$('#page').val(cuurPage);

	
	
	if(!isVocatermid){
		str_vocatermid = $('#vocatermid :selected').val();
	}
	
	var params = {};
  		params.page=cuurPage;
  		params.orderBy =  $("#selectbox1 option:selected").val();
  		params.pageSize =  $("#selectbox2 option:selected").val();
		params.junalName = $('#searchKeyword').val();

		if('${searchVo.filterGbn}' != ''){
			switch ('${searchVo.filterGbn}') {
			case "publisher":
				params.publisher='${searchVo.filterVal}';
				break;
			case "frequency":
				params.frequency='${searchVo.filterVal}';
				break;
			case "indexedIn":
				params.indexedIn='${searchVo.filterVal}';
				break;

			default:
				break;
			}
		}
		
		params.vocatermid = str_vocatermid;
		
		if(arguments[1] != undefined){
			params.searchType = "atoz";
			params.searchCondition = arguments[1];
			params.searchKeyword = arguments[2];
			param_searchType = "atoz";
			param_searchCondition = arguments[1];
			param_searchKeyword= arguments[2];
		}
		//필터 유지
		if(isFilter == "Y"){
			params.searchType = param_searchType;
			params.searchCondition = param_searchCondition;
			params.searchKeyword = param_searchKeyword;	
		}
		//상세검색

		if(detailYn == 'Y'){
			params.title = '${searchVo.detailInput1}';
			params.publisher = '${searchVo.detailInput2}';
			params.broadSubject = '${searchVo.detailInput3}';
			params.inf = '${searchVo.detailInput4}';
			params.startDate = '${searchVo.startDate}';
			params.endDate = '${searchVo.endDate}';
			params.vol = '${searchVo.detailInput5}';
			params.no = '${searchVo.detailInput6}';
			params.knlmId= '${searchVo.detailInput7}';
		}
		
		junalPageLen = $("#selectbox2 :selected").val();
		
		params.itemsPerPage=junalPageLen;
		
    $.ajax({
        url: '${ctxt}/elib/kom/readJunal.do',
        data: params,
        type: 'post',
        dataType: 'text',
        cache: false,
        beforeSend : function(){
        	$('#mloader').show();    
        }, 
        success: function(rtnXml) {
   
        	xmlList = $(rtnXml).find('item');

        	pageTotalCnt=0;
        	dataTotalCnt=0;
        	
        	html="";
			var strPage = 0;
			var endPage = 0;
        	if(xmlList.length > 0){ 
				//총페이지수
				pageTotalCnt = Number($(rtnXml).find('totalPageCnt').text());
				dataTotalCnt = Number($(rtnXml).find('totalDataCnt').text());
				
				xmlList.each(function(cnt){

					var obj = $(this);
					if(cnt == 0){
						strPage = Number(obj.find('order_sn').text());
						endPage = strPage + xmlList.length -1;
					}   
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					html += '<tr class="div_journal">';
					html += ' <td style="text-align:center">'+obj.find('order_sn').text() +'</td>';
					html += ' <td><a style="cursor: pointer;" href="javascript:fn_goJournalDtl(\''+obj.find('bibctrlno').text() +'\')" >'+obj.find('title').text() + '<br/>'+ obj.find('abbreviation').text() +'</a></td>';
					html += ' <td>'+obj.find('publisher').text() +'</td>';
					html += ' <td style="text-align:center">'+obj.find('pissn').text()+"(p)"+"<br />";
					if(obj.find('eissn').text()!= ''){
					html +=  obj.find('eissn').text()+"(e)";
					}
					html += '</td>';
					html += ' <td style="text-align:center"><a href="javascript:fn_goJournal(\''+obj.find('bibctrlno').text() +'\')" >'+obj.find('volumename').text() +' '+ obj.find('years').text()+'</a></td>';
					html += ' <td style="text-align:center"><a href="javascript:fn_goJournal(\''+obj.find('bibctrlno').text() +'\')" >'+obj.find('volumenamemin').text()+' '+ obj.find('yearsmin').text()+ '</a></td>';
					html += '</tr>';
					
		        });
			
				//페이징처리
			    $('#paging').paging({
					 current:cuurPage
					,max:pageTotalCnt
					,length:junalPageLen
					,onclick:function(e,page){
						cuurPage=page;
						isFilter="Y";
						fn_search(cuurPage);
					}
				});
			    //$("#topInfo").html("<span class='gray'>["+ cuurPage +" / "+pageTotalCnt+" Pages]</span><span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.");
			    $("#topInfo").html("<span class = 'txt-red' >Search results: ("+strPage +" &nbsp;to&nbsp; "+ endPage +" &nbsp;of&nbsp; " + dataTotalCnt + ") </span>" );
			    
			    $("#bodyInfo").html(html);
			  
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$('#paging').children().remove();
				
				$("#bodyInfo").html('<tr><td colspan="6" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        },
        complete: function() {
        	detailYn = 'N';
        	$('#mloader').hide();  
        }
    });
} 

</script>

<style>
#searchKeyword{
	padding-left: 10px;
	font-size: 14px;
}
#div_vocatermid{
	width:100%;
	max-width: 294px;
	margin-bottom:0px
}
.basic_table.font tbody{
	text-align: left;
	
}
#bodyInfo>tr>td:nth-child(3){
	text-indent: 0;
}



#selectbox1, #selectbox2  {
	width: 90px;
	background: url(../../resources/images/sub/sub_op.PNG) 70px no-repeat;
	background-size:7px auto;
}

.selectbox_wrap{
	margin-bottom:5px;
}
@media (max-width: 600px){
	#topInfo.top9{
		margin-top:30px;
		transition: all 0.3s;
	    -webkit-transition: all 0.3s;
	}
	.selectbox_wrap {
	    float: none;
		display:inline-block;
		width:195px;
		text-align:center;
		position: absolute;
	    left: 50%;
	    margin-top:-40px;
	    transform: translate(-50%,0);
	    transition: all 0.3s;
	    -webkit-transition: all 0.3s;
	}
	
}
@media (max-width: 450px){
	.basic_table.font{
		font-size:12px;
		letter-spacing:-0.3px;
	}
}
@media (max-width: 370px){
	.content_box>.content_list {
    	padding: 10px 5px;
    }
	#div_vocatermid{
		width:100%;
		max-width: 250px;
	}
	#searchKeyword.full_input {
	    width: 198px;
	    left: 0;
	}
}
#mloader{
  position: fixed;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 99999;
  background-color: #000;
  opacity: 0.7;
  display:none;
}

#mloader .masterkey_blink {
	font-size:20px;
	font-weight:bold;
	color:white;
	margin: 10% 45%;
    -webkit-animation: masterkey_blink 3s linear infinite;
    animation: masterkey_blink 3s linear infinite;
}    
</style>

<form id="junalForm" name="junalForm" method="post" action="" >
	<input type="hidden" id="bibctrlno" name="bibctrlno" value="" />
	<input type="hidden" id="page" name="page" value="" />
</form> 

		<div class="sub_center_text">
		    <div class="sub_center_nav"> 
			     <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			     <span> > </span> 
			     <span>전자자원</span>
			     <span> > </span>
			     <span class="active">Korea OpenMed</span>        
		    </div>						
			<span href="#" class="center_text_01">Journal List</span>
		</div> 
	<div class="under_bar"></div>
	<!-- 로딩바 -->

	<div id="mloader"><div class="masterkey_blink">LOADING...</div></div>
	
	<div class="content_wrap">    
		<div class="content_box">
			<div class="content_list">
				<!-- <div class="tabMenu" ></div> -->	
				<div class="surch_box center">
						<div id="atozCont" style="float:none;">
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
						<div class="surch_box1 center"" id="div_vocatermid">
							<select style="width: 100%" onchange="fn_search(1)" id="vocatermid">
							<option value="">All Fields</option>
							<c:forEach var="item" items="${sub_cls}" varStatus="stat">
								<option value="${item.ref_val2}" id="${item.ref_val1}">
								<a href="javascript:fn_search(1,'36','${item.ref_val2}')">${item.ref_val1}</a>
								</option>
							</c:forEach>
							</select><!-- 셀렉트박스 -->
							
							
							<span> 
								<input type="text" id="searchKeyword" class="full_input" name="searchKeyword" placeholder="Search for" value="" onkeydown="fn_enterSearch(this);" /> 
								<button id="btnSearch" class="btnSearch" value="" onclick="fn_firstSearch(1)" ><i class="fas fa-search"></i></button>
								<!-- <span class="btnSearch_icon" style="position:absolute; right:20px; margin-top:-32px;cursor:pointer;"><i class="fas fa-search"></i></span> -->
							</span>
							
						</div>
	
						
					
				</div>
				
				<div id="divRefreshArea" style="margin-bottom: 85px;">
				<div class="selectbox_wrap">		
					<select id="selectbox1" class="sub_select"  onchange = "javascript:fn_search(1);">
					  <option value="TYPE_A">Sort by </option>
					  <!-- <option value="TYPE_A">오름차순</option>
					  <option value="TYPE_B">내림차순</option>
					  <option value="TYPE_D">오래된순</option> -->
					  <option value="TYPE_C">Most Recent</option>
					  <option value="TYPE_D">Best Match</option>
					</select>
					<select id="selectbox2" class="sub_select"  onchange = "javascript:fn_search(1);">
					  <option value="10">Perpage</option>
					  <option value="10">10</option>
					  <option value="20">20</option>
					  <option value="30">30</option>
					  <option value="50">50</option>
					</select>   
				</div>
					<p id="topInfo" class="top9"></p>   
					
					<div>
						<div>
							<table class="basic_table zero_margin font border-right margin_b_65" >   
								<caption></caption>
								<colgroup>
									<col style="width: 5%">
									<col style="width: 29%">
									<col style="width: 30%"> 
									<col style="width: 12%">
									<col style="width: 12%">
									<col style="width: 12%">
								</colgroup>
								<thead>
									<tr class="tb_head">
										<th rowspan='2' style="padding: 0;">No</th>
										<th rowspan='2' style="padding: 0;">Journal Title</th>
										<th rowspan='2' style="padding: 0;">Publisher</th>
										<th rowspan='2' style="padding: 0;">ISSN</th>
										<th colspan='2' style="padding: 5px;">Volumes in the Journal</th>
									</tr>
									<tr class="tb_head">
										<th>Latest</th>
										<th>First</th>
									</tr>
								</thead>
								<tbody id='bodyInfo'>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div id="paging" class="paginate"></div>
				<div class="btn-group back">
					<a href="javascript:history.back(-1)" title="BACK" class="basic-btn back margin_b_45" >Previous</a>
				</div>
			</div>
		</div>
	</div>
