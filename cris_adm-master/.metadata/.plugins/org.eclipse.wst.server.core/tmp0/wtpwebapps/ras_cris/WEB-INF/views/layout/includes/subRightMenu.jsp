<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- rightMenu -->​
	  
	 <script>
// 슬라이더바 (발행년도)	
// 	var statdate = "${vo.startDate}";
// 	var enddate = "${vo.endDate}";
//   $( function() {
//     $( "#slider-range" ).slider({
//       range: true,
//       min: 0,
//       max: 2018,
//       values:[statdate,enddate],
//       slide: function( event, ui ) {
//         $( "#amount" ).val(  ui.values[ 0 ] + " - " + ui.values[ 1 ] );
//         $("#startDate").val(ui.values[0]);
//         $("#endDate").val(ui.values[1]);
//       }
//     });
//     $( "#amount" ).val($( "#slider-range" ).slider( "values", 0 ) +
//       " - " + $( "#slider-range" ).slider( "values", 1 ) );
//   } ); 
  </script>
 	<!--검색제한-->
	<c:if test="${vo.searchSubTarget ne 'total'}">
		<div id="sidebar-right" style="margin-top:134px;">
		
			<ul class="acc-menu" id="accordionMenu1">
				<li class="sidebar-right-text acc-menu_bg tasks"><i
							class="fas fa-tasks"></i>검색결과제한</li>
				<li data-extension="close">
					<div class="main-title"><a>발행년도</a></div>
					<ul id="groupNlmc" class="sub">
						<li style="text-align: center" class="date">
						<label for="str_dt" class="hide"></label>
						<input type="text" style="width: 55px; margin-left: 1%;text-align: center;height: 18px;" maxlength="4" id="startDate" title="startDate" name="startDate" value="${vo.startDate}" onblur=""> 
						-
						<label for="end_dt" class="hide"></label>
						<input type="text" style="width: 55px; margin-left: 1%; text-align: center;height: 18px;" maxlength="4" id="endDate" title="endDate" name="endDate" value="${vo.endDate}"  onblur="">
						</li> 	
					 	
					 	 <li id="moreYear"><a class="more_btn2" href="javascript:moveYear();" >적용</a></li>
					</ul>
				</li>   
				<li data-extension="close">
					<div class="main-title"><span class="folder"> </span><a>주제</a></div>
					<ul id="groupNlmc" class="sub">
						<c:forEach var="nlmcGroupList" items="${data.nlmcGroupList}" varStatus="status">
							<li class="nlmcClass" <c:if test="${status.count >3}">style="display:none;"</c:if>>
							<input type="checkbox" name="searchNlmcList" value="${nlmcGroupList.groupNm}" <c:forEach var="searchNlmcList" items="${vo.searchNlmcList}" varStatus="status"><c:if test="${searchNlmcList eq nlmcGroupList.groupNm}"> checked="checked" </c:if> </c:forEach>>
							<a class="check_chlid">${nlmcGroupList.groupNm}(${nlmcGroupList.groupCnt})</a>
							</li>
						</c:forEach>
						<li id="moreNlmc"><a class="more_btn2" href="javascript:moreNlmc(this);" >더보기</a></li>
					</ul>
				</li>
				<li data-extension="close">
					<div class="main-title"><span class="folder"> </span><a>언어</a></div>
					<ul id="groupLang" class="sub">
						<c:forEach var="langGroupList" items="${data.langGroupList}" varStatus="status">
							<li class="langClass" <c:if test="${status.count >3}">style="display:none;"</c:if>>
							<input type="checkbox" name="searchLangList" value="${langGroupList.groupNm}" <c:forEach var="searchLangList" items="${vo.searchLangList}" varStatus="status"><c:if test="${searchLangList eq langGroupList.groupNm}"> checked="checked" </c:if> </c:forEach>>
							<a class="check_chlid">${langGroupList.groupNm}(${langGroupList.groupCnt})</a>
							</li>
						</c:forEach>
						<li id="moreLang"><a class="more_btn2" href="javascript:moreLang(this);" >더보기</a></li>
					</ul>
				</li>
			</ul> 
		</div>
	</c:if>
 	<!--검색제한 끝-->

<!-- rightMenu End -->