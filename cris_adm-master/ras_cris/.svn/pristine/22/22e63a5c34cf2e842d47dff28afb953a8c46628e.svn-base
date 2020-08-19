<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- leftMenu -->
<%@ page import="kr.go.cris.commons.utils.CommonUtil" %>
<%@ page session="true" %>
<script type="text/javascript" src="<c:url value='/resources/js/search/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/search/search.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/search/pagenav.js'/>"></script>

<script type="text/javascript">  

var pubCnt=0;  
  
$(function(){
	
	
  
	$(".sub_left_ul>li>a").click(function(){
		$(".sidebar-left2 ul ul").slideUp();
		if(!$(this).next().is(":visible")){
			$(this).next().slideDown();
		} 
	})  
	
	if($(".sidebar-left2 ul ul li a").is(".menuLvl2")===true){
		$(".menuLvl2").parents().parents().slideDown();
		$(".menuLvl2").parents().parents().siblings('a').addClass("menuLvl1");
	}
	
	//화면메뉴 보이기 처리
	$(".search_tab").css('display','none');
	$("#search_tab01").css('display','');
	//pubmed 화면 초기 온로드
	
	if("<c:out value='${dtl}'/>" != 'Y'){
		var total_cnt = Number("<c:out value='${data.volume_totalSize}'/>") + Number("<c:out value='${data.notbook_totalSize}'/>") + Number("<c:out value='${data.report_totalSize}'/>") + Number("<c:out value='${data.period_totalSize}'/>");
		var inkorea_cnt = Number("<c:out value='${data.inkorea_totalSize}'/>");
		var archive_cnt = Number("<c:out value='${data.arReport_totalSize}'/>"); // 성과논문 임시 숨김 + Number('${data.rnd_totalSize}')
		if("<c:out value='${vo.detailYn}'/>" == 'N'){
			fn_setCnt();
			$('#label_4').text(' ('+Number(total_cnt).toLocaleString('en').split(".")[0]+')' );
			$('#label_2').text(' ('+Number(inkorea_cnt).toLocaleString('en').split(".")[0]+')' );
			$('#label_3').text(' ('+Number(archive_cnt).toLocaleString('en').split(".")[0]+')');
			$('#label_1').text(" (<c:out value='${edsCnt}'/>)");
		}else{
			$('.sub_left_ul li').hide();
			switch("<c:out value='${vo.searchTarget}'/>"){
				case "eds":
					$('#label_1').text(" (<c:out value='${edsCnt}'/>)"); 
					$('.sub_left_ul li').eq(0).show();
					break;
				case "inkorea":
					$('#label_2').text(' ('+Number(inkorea_cnt).toLocaleString('en').split(".")[0]+')' );
					$('.sub_left_ul li').eq(1).show();
					break;
				case "achive":
					$('#label_3').text(' ('+Number(archive_cnt).toLocaleString('en').split(".")[0]+')');
					$('.sub_left_ul li').eq(2).show();
					break;
				case "book":
					$('#label_4').text(' ('+Number(total_cnt).toLocaleString('en').split(".")[0]+')' );
					$('.sub_left_ul li').eq(3).show();
					break;
				case "pubmed":
					fn_setCnt();  
					$('.sub_left_ul li').eq(4).show();
					break;
				default:  
					break;
			}
		
		}
	
	}
})

/**
 * 
 */
function fn_setCnt(){ 
	
	var search_param = "";
	if("<c:out value='${vo.pubSearchQuery}'/>" == ''){
		
		if("<c:out value='${vo.detailInput1}'/>" != ''){
			search_param += "<c:out value='${vo.detailInput1}'/>";
		}
		if("<c:out value='${vo.detailInput2}'/>" != ''){
			if(search_param != ''){
				var selectOpt = "<c:out value='${vo.selectOption1}'/>";
				search_param += ' ' + selectOpt.toUpperCase() + ' ';
			}
			search_param += "<c:out value='${vo.detailInput2}'/>";
		}
		if('${vo.detailInput3}' != ''){
			if(search_param != ''){
				var selectOpt = "<c:out value='${vo.selectOption2}'/>";
				search_param += ' ' + selectOpt.toUpperCase() + ' ';
			}
			search_param += "<c:out value='${vo.detailInput3}'/>";
		}
		if(search_param == ''){	
			search_param = "<c:out value='${vo.searchQuery}'/>";
		}
		$('#pubSearchQuery').val(search_param);
	}else if("<c:out value='${vo.pubSearchQuery}'/>" != ''){
		search_param = "<c:out value='${vo.pubSearchQuery}'/>";
	}

	var url = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi";
	var data = {
		"db": "pubmed",
		"term": search_param,
		"RetStart": 1,
		"RetMax": 2,
		"api_key" : "8a6f7ad390de25d3de3133fa95d7eead9d09"
	};
	
	var success =  function(xml) {	
		var xmlDoc = $(xml);
		var ids = xmlDoc.find("eSearchResult > IdList > Id");
		var count = xmlDoc.find("eSearchResult > Count");
		
		pubCnt =count.text() * 1;
		pubCnt = Number(pubCnt).toLocaleString('en').split(".")[0];
		
		$('#label_5').text(' ('+pubCnt+')');
		
		
	};
	
	if ('XDomainRequest' in window && window.XDomainRequest !== null) {// IE8 & 9 only Cross domain request
		url += "?" + $.param(data);
		
		var xdr = new XDomainRequest(); // Use Microsoft XDR
		
		xdr.onerror = function() {
			console.log("error!");
		};
		xdr.onprogress = function() {};
		xdr.onload = function () {
			var data = xdr.responseText;
			data = $.parseXML(data);
			
			success(data);
		};
		
		xdr.open('GET', url, false);
		xdr.send();
	}
	else {
		$.ajax({
			"url": url,
			"type": 'POST',
//				"async": false,
			"contentType": "application/x-www-form-urlencoded",
			"data": data,
			"dataType": "xml",
			"success": success,
			"error": function(request,status,error) {
				//win = window.open('http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi'); 
				//win.close(); 

				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}	
}

 
function fn_open(obj){
		$(".sub_left_ul ul ul").slideUp();
		if(!$("#"+obj).is(":visible")){
			$("#"+obj).slideDown();
		}
		
}

function fn_tab(idx){
	$(".search_tab").css('display','none');
	$("#search_tab0"+idx).css('display','');
	
	var form = document.moveParam;
	$('#mloader2').show();   
	switch(idx){
		case "2":	//국내학술논문
			$('#moveParam input[name=searchTarget]').val('inkorea');
			form.action="${ctxt}/search/search.do";
			break;
		case "1"://전자자원
			var query = "";
			if("<c:out value='${vo.searchQuery}'/>" =="" || "<c:out value='${vo.searchQuery}'/>" == null ){
				query = "<c:out value='${query_param}'/>";
				$('#param_query').val(query);
			}
			form.action="${ctxt}/search/AdvancedSearch";
			break;
		case "3"://아카이브
			$('#moveParam input[name=searchTarget]').val('archive');
			form.action="${ctxt}/search/search.do";
			break;
		case "4"://소장자료
			$('#moveParam input[name=searchTarget]').val('book');
			form.action="${ctxt}/search/search.do";
			break;
		case "5"://pubmed
			$('#moveParam input[name=searchTarget]').val('pubmed');
			form.action="${ctxt}/search/searchPubmed.do?";
			break;
	
	}
	form.submit();
	
	
	
}



</script>

	<div id="gnb">
	<div id="sidebar-left" class="sidebar-left">
		<div class="sidebar-left1">
			<div  class="sub_left_div"></div>
		       <c:if test = "${fn:length(sys_leftMenu) ne 0  }" >		           
		           <c:forEach var="menuTitle" items="${sys_leftMenu}" varStatus="status">
		           	  <c:if test="${menuTitle.lvl eq '0'}">
		           	  		<span class="sub_left_text"><c:out value="${menuTitle.menuNm}"/></span>
		           	  </c:if>
		           </c:forEach>
		       </c:if>		
        </div>		

		<div class="sidebar-left2">
			<ul class="sub_left_ul">
	           <c:if test = "${fn:length(sys_leftMenu) ne 0  }" >
		            <c:forEach var="menuVo1" items="${sys_leftMenu}" varStatus="status">	              
		                 	<c:if test="${menuVo1.lvl ne '0'}">
		                 		
			                 		<c:if test="${menuVo1.lvl eq '1'}">
				                 		<li>
				                 		    <c:if test="${menuVo1.menu_con eq '0'}">
				                 		    	<a  href="#"> <c:out value="${menuVo1.menuNm}"/></a>
				                 		    </c:if>
				                 		    <c:if test="${menuVo1.menu_con eq '1'}">
				                 		    	<a href="javascript:fn_tab('${status.index}')" >  <c:out value="${menuVo1.menuNm}"/><span id="label_${status.index}"></span></a>
				                 		    </c:if>
				                 		</li>
			                 		</c:if>
		                 	
		                 	</c:if>
		           </c:forEach>
	           </c:if>
			</ul>
		</div>
	
	</div>
	</div>

<form id="moveParam" name="moveParam" action="" method="post">
	<input type="hidden" id="param_searchQuery" name="searchQuery" value="<c:out value='${vo.searchQuery}'/>" />
	<input type="hidden" id="param_query" name="query" value="<c:out value='${vo.searchQuery}'/>" />
	<input type="hidden" id="pubSearchQuery" name="pubSearchQuery" value="<c:out value='${vo.pubSearchQuery}'/>" />
	<input type="hidden" id="detailYn" name="detailYn" value="<c:out value='${vo.detailYn}'/>" />		
	<input type="hidden" id="" name="searchTarget" value="<c:out value='${vo.searchTarget}'/>" />		
	<input type="hidden" id="" name="searchCondition1" value="<c:out value='${vo.searchCondition1}'/>" />		
	<input type="hidden" id="" name="searchCondition2" value="<c:out value='${vo.searchCondition2}'/>" />		
	<input type="hidden" id="" name="searchCondition3" value="<c:out value='${vo.searchCondition3}'/>" />		
	<input type="hidden" id="" name="detailInput1" value="<c:out value='${vo.detailInput1}'/>" />		
	<input type="hidden" id="" name="detailInput2" value="<c:out value='${vo.detailInput2}'/>" />		
	<input type="hidden" id="" name="detailInput3" value="<c:out value='${vo.detailInput3}'/>" />		
	<input type="hidden" id="" name="selectOption1" value="<c:out value='${vo.selectOption1}'/>" />		
	<input type="hidden" id="" name="selectOption2" value="<c:out value='${vo.selectOption2}'/>" />		
	<input type="hidden" id="" name="selectOption3" value="<c:out value='${vo.selectOption3}'/>" />		
	<input type="hidden" id="" name="pageNum" value="1" />		
</form>
