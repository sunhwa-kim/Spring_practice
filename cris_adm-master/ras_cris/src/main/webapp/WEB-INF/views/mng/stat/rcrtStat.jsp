<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>채용정보통계 | 정부출연연구기관 채용정보서비스</title>
</head>
<body>
<script type="text/javascript" src="${ctxt}/resources/js/chart/Nwagon.js"></script>
<link rel="stylesheet" href="${ctxt}/resources/css/chart/Nwagon.css">
<script type="text/javascript">


var org_name;
var total_val;

	$(function(){
		
		$(".search_area").css("height" , "60px");
		
		$('#search_opt').change(function(){
			
			if($('#search_opt option:selected').text() == '전체'){
				
				$('#sysMntrList > tr').attr('style', ''); 
			}else{
	 			$('#sysMntrList > tr').each(function(cnt){
		 			if($(this).find('td:eq(3)').text() == $('#search_opt option:selected').text()){
		 				$(this).attr('style', ''); 
		 			}else{
		 				$(this).attr('style', 'display:none'); 
		 			}	
		 		});
 			}
		});
		//년도 
		getYear("search_year",3,0);
		
		
		fn_search();

	});
	
	
function fn_search(){
	
	var params = {};
    params.year = $('#search_year option:selected').val();
    params.org_cd = $('#search_org option:selected').val();
    params.person_cd = $('#search_person option:selected').val();
    params.work_cd = $('#search_work option:selected').val();
    params.career_cd = $('#search_career option:selected').val();
    params.searchType = $('#searchType option:selected').val();

    $.ajax({
        url: '${ctxt}/mng/stat/selectRcrtStat.do',
        data: params,
        type: 'POST',
        dataType: 'text',
        cache: false,
        success: function(rtnXml) {
        	xmlList = $(rtnXml).find('item');
        	html="";
			if(xmlList.length > 0){
		
				org_name = new Array();
				total_val = new Array();
				
				xmlList.each(function(cnt){

					var obj = $(this);

					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					
					org_name.push(obj.find('org__snm').text());
					total_val.push(obj.find('total').text());
					
					html += '<tr>';
					html += ' <td>'+obj.find('year').text() +'</td>';
					html += ' <td style="text-align: center;" >'+obj.find('org__nm').text() +'</td>';
					html += ' <td>'+obj.find('mon__01').text() +'</td>';
					html += ' <td>'+obj.find('mon__02').text() +'</td>';
					html += ' <td>'+obj.find('mon__03').text() +'</td>';
					html += ' <td>'+obj.find('mon__04').text() +'</td>';
					html += ' <td>'+obj.find('mon__05').text() +'</td>';
					html += ' <td>'+obj.find('mon__06').text() +'</td>';
					html += ' <td>'+obj.find('mon__07').text() +'</td>';
					html += ' <td>'+obj.find('mon__08').text() +'</td>';
					html += ' <td>'+obj.find('mon__09').text() +'</td>';
					html += ' <td>'+obj.find('mon__10').text() +'</td>';
					html += ' <td>'+obj.find('mon__11').text() +'</td>';
					html += ' <td>'+obj.find('mon__12').text() +'</td>';
					html += ' <td>'+obj.find('total').text() +'</td>';
					
					html += '</tr>';
					
		        });

			    $("#statList").html(html);
			    
			    //차트 보이기 
			    //fn_createChart();
			    
			}else{
				$("#statList").html('<tr><td colspan="15" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
        	fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}

function fn_excel(){
	
	var strConfirm = confirm("엑셀다운로드 받으시겠습니까?");
	
	if(strConfirm){
		var params = {};
	    $('input[name=year]').val($('#search_year option:selected').val());
	    $('input[name=org_cd]').val($('#search_org option:selected').val());
	    $('input[name=person_cd]').val($('#search_person option:selected').val());
	    $('input[name=work_cd]').val($('#search_work option:selected').val());
	    $('input[name=career_cd]').val($('#search_career option:selected').val());
	    $('input[name=searchType]').val($('#searchType option:selected').val());

	     var form = document.statForm;
	     form.action = '${ctxt}/mng/stat/excelDown.do';
	     form.submit();
	}
}
	
	
function fn_createChart(){
	var options = {
			'legend': {
	            names: org_name,
	            hrefs: []
	        },
	        'dataset': {
	            title: 'Playing time per day',
	            values: total_val,
	            colorset: ['#56b4e9'],
	            fields:['채용건수']
	        },
	        'chartDiv': 'chart8',
	        'chartType': 'column',
	        'chartSize': { width: 1000, height: 500 },
	        'maxValue': 30,
	        'increment': 2
		};

		Nwagon.chart(options);
}

</script>
<div id="container">
	<div id="content">
		<h2> <spring:message code="menu.mng.rcrtStat" /></h2>  
		
		<div class="search_area" >
		<table id="search_table">
		<colgroup>
			<col width="10%">
			<col width="20%">
			<col width="10%">
			<col width="20%">
			<col width="10%">
			<col width="20%">
			<col width="10%">
		</colgroup>
			<tr>
				<td align="right">
					<span class="search_label">구분</span>
				</td>
				<td>	
					<select id="searchType">
						<option value="R" >채용등록현황</option>
						<option value="H" >인재등록현황</option>
					</select>
			    </td>
			    <td align="right">
					<span class="search_label">기관명</span>
				</td>
				<td>	
					<select id="search_org">
						<option value="">전체</option>
						<c:forEach items="${org_list}" var="org">
							<option value="${org.cd}" >${org.cd_nm}</option>
						</c:forEach>
					</select>
				</td>
				<td align="right">
					<span class="search_label">기준년도</span>
				</td>
				<td>	
					<select id="search_year">
					</select>
				
				</td>
				<td>
					<a href="javascript:fn_search(1)" name="search_btn"><span>조회</span></a>
				</td>
			</tr>
			<tr>
				 <td align="right">
					<span class="search_label">인력구분</span>
				</td>
			    <td>
					<select id="search_person">
						<option value="">전체</option>
						<c:forEach items="${person_list}" var="person">
							<option value="${person.cd}" >${person.cd_nm}</option>
						</c:forEach>
					</select>
				</td>
				 <td align="right">
					<span class="search_label">직종구분</span>
				</td>
			  	<td>	
					<select id="search_work">
						<option value="">전체</option>
						<c:forEach items="${work_list}" var="work">
							<option value="${work.cd}" >${work.cd_nm}</option>
						</c:forEach>
					</select>
				</td>
				 <td align="right">
					<span class="search_label">경력구분</span>
				</td>
			    <td>	
					<select id="search_career">
						<option value="">전체</option>
						<c:forEach items="${career_list}" var="career">
							<option value="${career.cd}" >${career.cd_nm}</option>
						</c:forEach>
					</select>
				</td>
				<td></td>
				<td></td>
			</tr>
		</table>
	</div>
	
			<div id="chart8"></div>
			
		   <form id="statForm" name="statForm" action="" method="post">
		     <input type="hidden" name="year" value="">
		     <input type="hidden" name="org_cd" value="">
		     <input type="hidden" name="person_cd" value="">
		     <input type="hidden" name="work_cd" value="">
		     <input type="hidden" name="career_cd" value="">
		     <input type="hidden" name="searchType" value="">
		    </form>
		<div style="overflow:visible; margin: 50px 0 0;" >
		<font color="red">※ 채용 집계 기준 : 기준년도의 채용시작일자로 집계</font><br />
		<font color="red">※ 인력 집계 기준 : 관심기관으로 집계</font><br /><br />
		    <!-- 목록 -->
		    <div class="table-b-wrap">
			  	<table class="table-b">
		      	<colgroup>
			        <col width="10%">
			        <col width="25%">
			        <col width="5%">
			        <col width="5%">
			        <col width="5%">
			        <col width="5%">
			        <col width="5%">
			        <col width="5%">
			        <col width="5%">
			        <col width="5%">
			        <col width="5%">
			        <col width="5%">
			        <col width="5%">
			        <col width="5%">
			        <col width="5%">
			        
		      	</colgroup>
		    	<thead>
			        <tr>
			          <th>년도</th>
			          <th>기관명</th>
			          <th>1월</th>
			          <th>2월</th>
			          <th>3월</th>
			          <th>4월</th>
			          <th>5월</th>
			          <th>6월</th>
			          <th>7월</th>
			          <th>8월</th>
			          <th>9월</th>
			          <th>10월</th>
			          <th>11월</th>
			          <th>12월</th>
			          <th>TOTAL</th>
			        </tr>
		      	</thead>
		      	<tbody id="statList">
	
		      	</tbody>
		   		</table>
			</div>
		</div>
		<br />
		<!-- <font color="red">※ 채용 집계 기준 : 기준년도의 채용시작일자로 집계</font><br />
		<font color="red">※ 인력 집계 기준 : 관심기관으로 집계</font><br /><br /> -->
		<div style="text-align:right;">
			<input type="button"  value="다운로드" name="exceldown_btn" onclick="fn_excel()" />
		</div>
		
	 </div>
 </div>
</body>
</html>