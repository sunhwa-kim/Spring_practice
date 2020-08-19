<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 차트 구성 SCRIPT STR-->
<script type="text/javascript" src="${ctxt}/resources/js/chart/jui/jquery-ui.min.js"></script>
<script type="text/javascript" src="${ctxt}/resources/js/chart/jui/core.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctxt}/resources/js/chart/jui/chart.js" ></script>
<link rel="stylesheet" href="${ctxt}/resources/js/chart/jui/jquery-ui.min.css" />
<!-- 차트 구성 SCRIPT END-->
<script type="text/javascript">
var returnGbn ='';

$(function(){
	
	if($("#returnPageGbn").val() != ''){
		returnGbn = $("#returnPageGbn").val();
	}
	
	fn_chartGrid();

});

//차트 그리기
function fn_chartGrid(){
	
	var chart = jui.include("chart.builder");
	
	chart("#gridChart", {
		width : 400,
		height : 300,
		padding : {
			left:30,
			top : 20
		},
	    axis : {
	        x : {
	            type : "block",
	            domain : "quarter",
	            line : true
	        },
	        y : {
	            type : "range",
	            domain : function(d) { return [d.count ]; },
	            step : 5,
	            line : true,
	            orient : "left"
	        },
	        data : [
	            { quarter : "view", count : $("#rdcnt").val() },
	            { quarter : "download", count : $("#downcnt").val() },

	        ]
	    },
	    brush : {
	        type : "column",
	        size : 30,
	        target : [ "count" ]
	    },
	    widget : [
	    /* 	{ type : "title", text : "Column Sample" }, */
	        { type : "tooltip" }
     /* 	{ type : "legend" } */
	    ]
	});
	
}


function fn_returnPage(param){
	
	var form = document.reqForm;
	var returnPage ='';
 
	if(param == 'R'){
		if(returnGbn != ''){
			if(returnGbn == 'aMain'){ // 아카이브 메인 우측 목록에서 옴. - 메인으로 이동
				returnPage = form.returnArchiveMainPage.value;
			}else if(returnGbn == 'recently'){ // 아카이브 recently , download  목록에서 옴 - 해당 목록으로 이동 
				returnPage = form.returnRecentlyPage.value;
			}else if(returnGbn == 'download'){
				returnPage = form.returnDownloadPage.value;			
			}
		}else{
			returnPage = form.returnListPage.value;
		}
    }else if(param == 'U'){
    	//returnPage= "${ctxt}/archive/report/reportEdit.do";
    }
	
	form.action = returnPage;
	form.submit();	
}



</script>


<form name="reqForm" method="post">
	
	 <div class="sub_center_text">
		      <div class="sub_center_nav"> 
			      <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			      <span> > </span> 
			      <span>아카이브</span>
			      <span> > </span>
			      <span>회색문헌</span>        			      
		      </div>
		        <div class="sub_center_wrap">
			        <a href="#" class="center_text_01">회색문헌</a>
				</div>
			</div> 
			
		<div class="under_bar"></div>
	<div class="content_wrap">		
		
			<!-- 컨텐츠 영역 -->
			<h2 class="depth-title">회색문헌 상세</h2>
			
				<table class ="view_table">
					<caption>
							회색문헌 상세
					</caption>
					<colgroup>
						<col style="width:20%">
						<col>							
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">제목</th>
							<td align="center">
								${resultVO.gl_sj}
							</td>
						</tr>
						<tr>
							<th scope="row">부서</th>
							<td align="center">
								${resultVO.deptid}
							</td>
						</tr>
						<tr>
							<th scope="row">등록일</th>
							<td align="center">
								${resultVO.frst_regist_pnttm}
							</td>
						</tr>					
					</tbody>
				</table>
				
				
		
			
			<div class="btn-group">
				<a href="javascript:fn_returnPage('R')" class="basic-btn">이전으로</a>
			</div> 
	
			     	<!-- 컨텐츠 영역 -->
			<div id="archive-chart">
				<div class="sidebar-chart-right-text">Item View & Download Count</div>
				<div id ="gridChart"> <!-- style="width: 400px; height: 400px"> -->
				</div>	
			</div> 
	
	
		
		
	</div>	
		
	

    <!-- 검색 PARAM -->
	<input type="hidden" id="page" name="page" value="${resultVO.page}" alt="pageNum" />
	<input type="hidden" id="searchCondition" name="searchCondition" value="${resultVO.searchCondition}"  alt="검색콤보" />
	<input type="hidden" id="searchKeyword" name="searchKeyword" value="${resultVO.searchKeyword}" alt="검색어" />
	
	
	<input type="hidden" id="rdcnt" name="rdcnt" value="${resultVO.rdcnt}"  alt="검색콤보" />
	<input type="hidden" id="downcnt" name="downcnt" value="${resultVO.downcnt}"  alt="검색콤보" />
	
	<!-- 목록 화면 주소  -->
	<input type="hidden" id="returnListPage" name="returnListPage" value="${ctxt}/archive/grey/greyList.do"  alt= "returnPage" />
	<input type="hidden" id="returnArchiveMainPage" name="returnArchiveMainPage" value="${ctxt}/archive/intro/archiveIntro.do"  alt= "returnArchiveMainPage" />
	<input type="hidden" id="returnRecentlyPage" name="returnRecentlyPage" value="${ctxt}/archive/intro/archiveRecentlyList.do"  alt= "returnRecentlyPage" />
	<input type="hidden" id="returnDownloadPage" name="returnDownloadPage" value="${ctxt}/archive/intro/archiveTopDownloadList.do"  alt= "returnRecentlyPage" />
	
	<!-- 리턴 페이지  -->
	<input type="hidden" id="returnPageGbn" name="returnPageGbn" value="${resultVO.returnPageGbn}"  alt="returnPageGbn">
	
	<!-- 공통  필수 PARAM  -->
	<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" /> --%>
	
</form>
