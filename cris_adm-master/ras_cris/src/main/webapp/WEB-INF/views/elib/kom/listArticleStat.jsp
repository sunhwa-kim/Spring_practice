<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<script type="text/javascript" src="${ctxt}/resources/js/chart/jui/jquery-ui.min.js"></script>
<script type="text/javascript" src="${ctxt}/resources/js/chart/jui/core.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctxt}/resources/js/chart/jui/chart.js" ></script>
<link rel="stylesheet" href="${ctxt}/resources/js/chart/jui/jquery-ui.min.css" />

<style>
	.div_journal:nth-child(odd) {background-color:#FCFDFF;text-align: center;}
	.div_journal:nth-child(2n) {background-color:#eeee;text-align: center;}
	.div_journal td {text-align: center;}
	.tb_head{
			    height: 50px;
			    border-right: 1px solid #e1e1e1;
			    border-bottom: 1px solid #e1e1e1;
			    background-color: #f7f7f7;
			    text-align: center;
			    vertical-align: middle;
			    font-size: 13px;
			    font-weight: bold;
			    line-height: 19px;
			}
</style>

<script>

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
		$('#srchChoice option[value='+searchType+']').attr('selected',true);
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


function fn_search(page){
	//현재 페이지 세팅
	cuurPage= page;
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/

	$('#page').val(cuurPage);

	$('#searchType').val($('#srchChoice option:selected').val());
	
	var params = {};
  		params.page=cuurPage;


    $.ajax({
        url: '${ctxt}/elib/kom/selectArticleYearStat.do',
        data: params,
        type: 'POST',
        dataType: 'text',
        cache: false,
        success: function(rtnXml) {
   
        	xmlList = $(rtnXml).find('item');

        	//"PUB_YEAR","CNT"
        	
        	html="";
			if(xmlList.length > 0){
				
				xmlList.each(function(cnt){
			
					var obj = $(this);
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					html += '<tr class="div_journal" >';
					html += ' <td>'+obj.find('PUB_YEAR').text() +'</td>';
					html += ' <td>'+obj.find('CNT').text() +'</td>';
					html += ' <td>'+obj.find('CNT_RT').text() +' </td>';
					html += '</tr>';
					
		        });
			    $("#bodyInfo").html(html);
			    
			    fn_createChart($(rtnXml).find('chart_data').text());
			  
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$("#bodyInfo").html('<tr><td colspan="5" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
} 

function fn_createChart(chart_data){
	var chart = jui.include("chart.builder");

	var c = chart("#result", {
	    axis : [{
	        x : {
	            type : "block",
	            domain : "PUB_YEAR",
	            line : true
	        },
	        y : {
	            type : "range",
	            domain : function(d) { return [0,d.CNT +2000]; },
	            step : 10,
	            line : true
	        },
	        data : eval(chart_data)

	    }],
	    brush : [{
	        type : "column",
	        target : [ "CNT"],
	        outerPadding : 15
	    }],
	    event : {
	        click : function(obj, e) {
	            showEventMessage(obj);
	        }
	    }
	});

	// Events defined by the method
	c.on("rclick", function(obj, e) {
	});

}

function showEventMessage(obj){
	
}

</script>
<form id="junalForm" name="junalForm" method="post" action="" >
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" id="bibctrlno" name="bibctrlno" value="" />
	<input type="hidden" id="page" name="page" value="" />
</form> 

<div id="container" class="container">
	<div id="divUcont_cont">
	<div class="sub_center_text">
      <div class="sub_center_nav"> 
	      <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
	      <span> > </span> 
	      <span>전자자원</span>
	      <span> > </span>
	      <span class="active">KoreaOpenMed</span>        
      </div>
        <div class="sub_center_wrap">
	        <a href="#" class="center_text_01">연도별논문현황</a>
		</div>
	</div> 
	
	<div class="under_bar"></div>	
	
	
	<div id="result" style="height: 500px;width: 100%;">
	
	</div>
	
	<div id="divUcont_cont">
		<hr>

		<!-- atozCont -->

		<div style="float: left; width: 30%;">
			<c:forEach var="item" items="${sub_cls}" varStatus="stat">
				<div style="float: left; margin-right: 2%;">
					<a href="${ctxt}/${item.ref_val1}">${item.cd_nm}</a>
				</div>
				<c:if test="${(stat.index + 1 ) % 3 == 0}">
					<br />
				</c:if>
			</c:forEach>
		</div>

		<br />

		<div id="divRefreshArea" style="float: left; width: 100%;">
			<p id="topInfo"></p>
			<div style="float: left; width: 100%;">
				<div style="float: left; width: 100%;">
					<table class="basic-table center" style="width: 100%;">
						<caption></caption>
						<colgroup>
							<col style="width: 30%">
							<col style="width: 40%">
							
							<col style="width: 40%">
						</colgroup>
						<thead>
							<tr class="tb_head">
								<th style="padding: 0;">연도</th>
								<th style="padding: 0;">논문수</th>
								<th style="padding: 0;">비율</th>
							</tr>
						</thead>
						<tbody id='bodyInfo'>

						</tbody>
					</table>
					<div id="paging" class="paginate"></div>
				</div>
			</div>
		</div>
	</div>
	</div>
</div>
