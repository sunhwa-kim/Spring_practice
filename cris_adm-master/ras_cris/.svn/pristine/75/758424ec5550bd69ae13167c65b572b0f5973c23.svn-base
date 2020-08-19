<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>  
$(function(){ 
	$('.yearClass').click(function(){
		$("#searchMove").find("input[name='searchYearList']").remove();
		$(".yearClass input").each(function(i){
			if($(this).is(":checked")){
				$("#searchMove").append("<input type='hidden' name='searchYearList' value='"+$(this).val()+"' />");
			}
		});
		
		$("#searchMove").submit();
	});
	
	$('.deptClass').click(function(){
		$("#searchMove").find("input[name='searchDeptList']").remove();
		$(".deptClass input").each(function(i){
			if($(this).is(":checked")){
				$("#searchMove").append("<input type='hidden' name='searchDeptList' value='"+$(this).val()+"' />");
			}
		});
		
		$("#searchMove").submit();
	});
	$('.subjectClass').click(function(){
		$("#searchMove").find("input[name='searchSubjectList']").remove();
		$(".subjectClass input").each(function(i){
			if($(this).is(":checked")){
				$("#searchMove").append("<input type='hidden' name='searchSubjectList' value='"+$(this).val()+"' />");
			}
		});
		
		$("#searchMove").submit();
	});
	
	$('.yearClass2').click(function(){
		$("#searchMove").find("input[name='searchYearList2']").remove();
		$(".yearClass2 input").each(function(i){
			if($(this).is(":checked")){
				$("#searchMove").append("<input type='hidden' name='searchYearList2' value='"+$(this).val()+"' />");
			}
		});
		
		$("#searchMove").submit();
	});
});


function fileView(atch_link_id, proj , idVal) {
	
	var atchLinkId = atch_link_id
	
	var contextName = "ncmik";
	var fileKey = atchLinkId;
	var pageTitle = proj;	
	var rep_id = idVal;
	
	if(atch_link_id == "" || atch_link_id == null ){
		alert("원문정보가 존재 하지 않습니다.");	
		
		return;
	}
	
	fn_downloadUpdate(fileKey, contextName, pageTitle , rep_id , 'report');
}

/**
 * 내서재담기 row
 */
function fn_selMyLib(rep_id) {
	
 	if ("${userVo.emplyrnm}" == "") {
		if (confirm("내서재 담기 기능을 선택하실 경우 로그인 하셔야합니다.\n로그인 화면으로 이동하시겠습니까?")) {
			location.href = "${ctxt}/login/user/login.do?returnURL=/search/report/reportList.do";
			return;
		} else {
			return;
		}
	} 
 	var params = {};
	params.key = rep_id;
	params.gbn = "report";
	
	$.ajax({
		url : "<c:url value='/mylib/lib/multiMylibSave.do'/>",
		data : params,
		type : 'post',
		dataType : 'json',
		success : function(data) {
			if(confirm("선택하신 총 1건 중\n내 서재 담기에 성공한 건수: "+data.sucCnt+"건\n이미 내 서재에 등록된 건수(내 서재 담기에 실패한 건수): "+data.dupCnt+"건 \n입니다.\n\n※ 내 서재 화면으로 이동하시겠습니까?")){
				location.href="<c:url value='/mylib/lib/listMyLib.do'/>";
				return;
			}else{
				return;
			}
		}
	}); 
}

/**
 * 내서재담기 row
 */
function fn_selMyLib2(rnd_id) {
	
 	if ("${userVo.emplyrnm}" == "") {
		if (confirm("내서재 담기 기능을 선택하실 경우 로그인 하셔야합니다.\n로그인 화면으로 이동하시겠습니까?")) {
			location.href = "${ctxt}/login/user/login.do?returnURL=/search/report/reportList.do";
			return;
		} else {
			return;
		}
	} 
 	var params = {};
	params.key = rnd_id;
	params.gbn = "rnd";
	
	$.ajax({
		url : "<c:url value='/mylib/lib/multiMylibSave.do'/>",
		data : params,
		type : 'post',
		dataType : 'json',
		success : function(data) {
			if(confirm("선택하신 총 1건 중\n내 서재 담기에 성공한 건수: "+data.sucCnt+"건\n이미 내 서재에 등록된 건수(내 서재 담기에 실패한 건수): "+data.dupCnt+"건 \n입니다.\n\n※ 내 서재 화면으로 이동하시겠습니까?")){
				location.href="<c:url value='/mylib/lib/listMyLib.do'/>";
				return;
			}else{
				return;
			}
		}
	}); 
}
</script>
<style>
.selectbox_wrap{
	height:38px; 
	position:relative;
	margin:0; 
	padding-top:0;
	margin-top:3px;
}
.center_radio_03, .center_text_03, #selectbox1{
    margin-top: 0px;
    height:38px;
    line-height:38px;
}
.center_text_01 {
	position:relative;
}
#search-group{
	margin-top:66px;  
}
.sub_center_cont_text {
    margin-bottom: 7px;
}
@media all and (max-width: 650px){
	.content_box>.content_list>.sub_book_wrap>.list_title {
	    font-size:15px;
	}
}
@media (max-width: 640px){
	#search-group.sub {
	    margin-top: 70px;
	    transition: all 0.3s;
	    -webkit-transition: all 0.3s;
	}
}
@media (max-width: 600px){
	#search-group {
	    right: 0;
	    left: 50%;
	    width: 100%;
	    transform: translate(-50%, 0);
	    -o-transform: translate(-50%, 0);
	    -ms-transform: translate(-50%, 0);
	    -moz-transform: translate(-50%, 0);
	    -webkit-transform: translate(-50%, 0);
	    text-align: center;
	    transition: all 0.3s;
	    -webkit-transition: all 0.3s;
	}
	.selectbox_wrap {
		padding-top:0;
		margin-top:0;
	    width: 100%;
	    height:67px;
	    width:344px;
	}
	.order-basic-btn{
		margin-left:0;
		position:absolute;
		left:50%;
		top:60%;
		transform: translate(-50%, 0);
	    -o-transform: translate(-50%, 0);
	    -ms-transform: translate(-50%, 0);
	    -moz-transform: translate(-50%, 0);
	    -webkit-transform: translate(-50%, 0);
		height:26px;
		line-height:26px;
	}
	.under_bar2 {
	    margin-top: 10px;
	    margin-bottom: 25px;
	}

.content_box>.content_list>.sub_book_wrap>.list_title {
    display: block;
}
/* .content_box>.content_list>.sub_book_wrap>.list_title.mliblist{
		display:none;
	} */
}
@media all and (max-width:502px) {
	.under_bar{
		display:none;
	}
    .content_box>.content_list{
    	margin-top: 0px;
    }	
	.content_box>.content_list>.sub_book_wrap>.list_title.mliblist{
		display:none;
	}
	.category_select{
		display: block;
	    position: absolute;
	    z-index: 100;
	    left: 61%;
	    cursor: pointer;
	        top: 0;
	}
	#search-group.sub {
    	margin-top: 35px;
    }
	.center_text_01 {
	    display: block;
	    width: 100%;
	    text-align: center;
	    transition: all 0.3s;
	    -webkit-transition: all 0.3s;
	    font-size: 18px;
	    margin-top: 10px;
	}
	.sub_book_wrap{
		margin-top:50px;
	}
}
@media all and (max-width:400px) {
	.selectbox_wrap {
		display:inline-block;	
		width:auto;
	}
	.selectbox_wrap>.center_radio_03{
		margin-left:10px;
	}
}
@media all and (max-width:352px) {
	.selectbox_wrap>.center_radio_03{
		margin-left:5px;
	}
}
</style>
<c:set var="archiveTotalSize" value="${data.arReport_totalSize + data.rnd_totalSize}" />
<c:if test="${vo.searchSubTarget eq 'total'}" >
	<div class="sub_center_text">
	      <div class="sub_center_nav"> 
		      <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
		      <span> > </span> 
		      <span>통합검색</span>
		      <span> > </span>
		      <span class="active">아카이브</span>        
	      </div>
			 <span class="center_text_01">아카이브 <span class="category_select">▼</span></span>
			
	</div> 
	<div class="under_bar"></div>
</c:if>			
	<!-- 아카이브 목록 -->
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
			<!--보고서-->
				<c:if test="${vo.searchSubTarget eq 'total'}">
					<div class="sub_book_wrap" style="width: 100%;">
				</c:if>
				<c:if test="${vo.searchSubTarget ne 'total'}">
					<div class="sub_book_wrap">
				</c:if>
			
			<c:if test="${vo.searchSubTarget eq 'report'}">
				<div style="width:100%; position:absolute; left:0; top:0;">
					<div class="sub_center_text">
					      <div class="sub_center_nav"> 
						      <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
						      <span> > </span> 
						      <span>통합검색</span>
						      <span> > </span>
						      <span>아카이브</span>
						      <span> > </span>
						      <span class="active">보고서</span>        
					      </div>
							  <span class="center_text_01">아카이브<span class="category_select">▼</span></span>
							  
					</div>
					<div class="under_bar"style="margin-top:5px;"></div>
				</div>
				
				<form id="repForm" name="repForm" action="${ctxt}/search/search.do" method="post">
					 <%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
					 <input type="hidden" name="searchTarget" value="archive"/>
			 	 	 <input type="hidden" name="searchSubTarget" value="report"/>
			 	 	 <input type="hidden" name="pageSize" value="10"/> 
<!-- 			 	 	 <div class="search_wrap"> -->
						 <div id="search-group" class="sub">
							<!-- <div class="search-input">
								<label for="searchCombo"></label>
								<select id="searchCondition" name="searchCondition" title="분류" style="min-width: 110px;">
									<option value="total">전체</option>
									<option value="title">연구과제명</option>
									<option value="pi">연구책임자</option>
									<option value="orgname">주관연구기관</option>							
								</select>
								<label for="searchBox"></label>
								<input type="text" id="searchKeyword" name="searchQuery" value="" onkeypress="javascript:if(event.keyCode == 13) { repGoSearch(); return false;}" class="txt" placeholder="검색어를 입력해주세요.">
				            	<input type="button" id="btnSearch" value="검색" onclick="javascript:repGoSearch();">               		
							</div> -->
						</div>
<!-- 					</div> -->
				 </form>
			 
				 <div class="selectbox_wrap">
					<input class="center_radio_03" style="margin-left:0;" name="searchSort" id="orderBy1" type="radio" value="recent" onclick="arSortSearch(this.value)" <c:if test="${vo.searchSort eq 'recent'}"> checked="checked"</c:if> /><label for="orderBy1" class="center_text_03"">최신순</label>					   
		    		<input class="center_radio_03" name="searchSort" id="orderBy3" type="radio" value="title_asc" onclick="arSortSearch(this.value)" <c:if test="${vo.searchSort eq 'title_asc'}"> checked="checked"</c:if> /><label for="orderBy3" class="center_text_03">제목오름차순</label>
			  	 	<input class="center_radio_03" name="searchSort" id="orderBy4" type="radio" value="title_desc" onclick="arSortSearch(this.value)" <c:if test="${vo.searchSort eq 'title_desc'}"> checked="checked"</c:if> /><label for="orderBy4" class="center_text_03">제목내림차순</label>			    	
					
					<select id="selectbox1" name="pageSize" class="sub_select" onchange="arMoveSize(this.value);">
						<option value="10" <c:if test="${vo.pageSize == 10}">selected="selected"</c:if>>10</option>
						<option value="20" <c:if test="${vo.pageSize == 20}">selected="selected"</c:if>>20</option>
						<option value="30" <c:if test="${vo.pageSize == 30}">selected="selected"</c:if>>30</option>
						<option value="50" <c:if test="${vo.pageSize == 50}">selected="selected"</c:if>>50</option>
					</select>
		
					<a class="order-basic-btn" href="javascript:goSubmit();">적용</a>
				</div>
				<div class="list_title mliblist"><p>보고서<span>(${data.arReport_totalSize}건)</span></p></div>
			</c:if>
				
			<c:if test="${vo.searchSubTarget eq 'total'}">
				<div class="list_title" style="margin-top:0;"><p>보고서<span>(${data.arReport_totalSize}건)</span></p></div>
			</c:if>
			 
			<c:if test="${vo.searchSubTarget eq 'total' || vo.searchSubTarget eq 'report'}">
				<div class="under_bar2"></div>
				<c:choose>
				<c:when test="${data.arReport_totalSize >0}">
				<c:forEach var="arReportList" items="${data.arReportList}" varStatus="status">
					<div style="padding-bottom:7px;position:relative;">
						<input id="option" type="checkbox" name="field" value="option" style="position: absolute;">
						<label for="option"><span><span></span></span></label>
						<div style="margin-left:28px;">		
							<ul>
								<li class="sub_center_cont_text"><a href = "${ctxt}/search/report/reportView.do?upd_yn=Y&rep_id=${arReportList.rep_id}"> ${arReportList.proj_tit_kor}</a></li> 
								<li class="sub_center_cont_text02"><span class="text02_1">연구책임자 : </span>${arReportList.pi}&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">주관연구기관 : </span>${arReportList.org_name}&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<span class="text02_1">연구비지원기관  : </span> ${arReportList.order_dept}&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<span class="text02_1"> 발행년도 : </span>${arReportList.pubyear}</li>
								<li class="sub_center_cont_text02"><a class="a_btn" href="javascript:fileView('${arReportList.atch_link_id}','${arReportList.proj_tit_kor}','${arReportList.rep_id}');">원문정보</a>&nbsp;&nbsp;&nbsp;<a class="a_btn" href="javascript:fn_selMyLib('${arReportList.rep_id}');">내서재담기</a></li>
							</ul>
						</div>
					</div>   
				</c:forEach>
				<c:if test="${vo.searchSubTarget eq 'total'}">
					<a class="more_btn" href="javascript:goSubTarget('report')"><span>more</span></a>
				</c:if>
				</c:when>
				<c:otherwise>
					<div class="not_found">검색조건에 해당하는 결과가 없습니다. 다른 검색조건을 선택해 주세요.</div>
				</c:otherwise>
				</c:choose>
			</c:if>
			<c:if test="${vo.searchSubTarget eq 'report'}">
				${data.arReport_totalPage}
			</c:if>
			<!--보고서 끝-->				
			
			<!-- 성과논문 임시 숨김 -->
			<!-- 성과논문 -->
			<%-- <c:if test="${vo.searchSubTarget eq 'rnd'}">
				<div style="width:100%; position:absolute; left:0; top:0;">
					<div class="sub_center_text">
					      <div class="sub_center_nav"> 
						      <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
						      <span> > </span> 
						      <span>통합검색</span>
						      <span> > </span>
						      <span>아카이브</span>
						      <span> > </span>
						      <span class="active">성과논문</span>        
					      </div>
							  <span class="center_text_01">아카이브 <span class="category_select">▼</span> </span>
							  
					</div>
					<div class="under_bar"style="margin-top:5px;"></div>
				</div> 
				<form id="rndForm" name="rndForm" action="${ctxt}/search/search.do" method="post">
					 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					 <input type="hidden" name="searchTarget" value="archive"/>
			 	 	 <input type="hidden" name="searchSubTarget" value="rnd"/>
			 	 	 <input type="hidden" name="pageSize" value="10"/> 
<!-- 					 <div class="search_wrap"> -->
						<div id="search-group" class="sub">
							<div class="search-input">
								<label for="searchCombo"></label>
								<select id="searchCondition" name ="searchCondition" title="분류">
									<option value="total">전체</option>
									<option value="title">제목</option>
								</select>
								<label for="searchBox"></label>
								<input type="text" id="rndQuery" name="searchQuery" onkeypress="javascript:if(event.keyCode == 13) { rndGoSearch(); return false;}" placeholder="검색어를 입력해주세요."/>
				            	<input type="button" id="btnSearch" value="검색" onclick="rndGoSearch();"/>
							</div>
						</div>
<!-- 					 </div> -->
				 </form>
				 
				 <div class="selectbox_wrap" style="position:relative; margin:0; padding-top:0;">
					<input class="center_radio_03" style="margin-left:0;" name="searchSort" id="orderBy1" type="radio" value="recent" onclick="arSortSearch(this.value)" <c:if test="${vo.searchSort eq 'recent'}"> checked="checked"</c:if> /><label for="orderBy1" class="center_text_03">최신순</label>					   
		    		<input class="center_radio_03" name="searchSort" id="orderBy3" type="radio" value="title_asc" onclick="arSortSearch(this.value)" <c:if test="${vo.searchSort eq 'title_asc'}"> checked="checked"</c:if> /><label for="orderBy3" class="center_text_03">제목오름차순</label>
			  	 	<input class="center_radio_03" name="searchSort" id="orderBy4" type="radio" value="title_desc" onclick="arSortSearch(this.value)" <c:if test="${vo.searchSort eq 'title_desc'}"> checked="checked"</c:if> /><label for="orderBy4" class="center_text_03">제목내림차순</label>			    	
					<select id="selectbox1" name="pageSize" class="sub_select" onchange="arMoveSize(this.value);">
						<option value="10" <c:if test="${vo.pageSize == 10}">selected="selected"</c:if>>10</option>
						<option value="20" <c:if test="${vo.pageSize == 20}">selected="selected"</c:if>>20</option>
						<option value="30" <c:if test="${vo.pageSize == 30}">selected="selected"</c:if>>30</option>
						<option value="50" <c:if test="${vo.pageSize == 50}">selected="selected"</c:if>>50</option>
					</select>
					<a class="order-basic-btn" href="javascript:goSubmit();">적용</a>
				</div>
				<div class="list_title mliblist"><p>성과논문<span>(${data.rnd_totalSize}건)</span></p></div>	 
			</c:if>
			
			<c:if test="${vo.searchSubTarget eq 'total'}" >
				<div class="list_title"><p>성과논문<span>(${data.rnd_totalSize}건)</span></p></div>	 
			</c:if>
			
			<c:if test="${vo.searchSubTarget eq 'total' || vo.searchSubTarget eq 'rnd'}" >
			<div class="under_bar2"></div>
				<c:choose>
			 	<c:when test="${data.rnd_totalSize >0}">
					<c:forEach var="rndList" items="${data.rndList}" varStatus="status">
					<div style="padding-bottom:7px;position:relative;">
						<input id="option" type="checkbox" name="field" value="option" style="position: absolute;">
						<label for="option"><span><span></span></span></label>
						<div style="margin-left:28px;">	 
							<ul>
								<li class="sub_center_cont_text"><a href = "${ctxt}/search/rnd/rndView.do?upd_yn=Y&rnd_id=${rndList.rnd_id}">${rndList.atc_title_kor}</a></li>  
								<li class="sub_center_cont_text02" style="padding-top:0px;">${rndList.author}&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;${rndList.publishing_date}&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;${rndList.volumename}&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;${rndList.jour_str_page}-${rndList.jour_end_page}</li>
								<li class="sub_center_cont_text02"><a class="a_btn" href="javascript:fileView('${rndList.atch_link_id}','${rndList.atc_title_kor}','${arReportList.rnd_id}');">원문정보</a>&nbsp;&nbsp;&nbsp;<a class="a_btn" href="javascript:fn_selMyLib2('${rndList.rnd_id}');">내서재담기</a></li>
							</ul>
						</div>
					</div>    
					</c:forEach>
					<c:if test="${vo.searchSubTarget eq 'total'}">
						<a class="more_btn" href="javascript:goSubTarget('rnd')"><span>more</span></a>
					</c:if>
				</c:when>
				<c:otherwise>
					<div class="not_found">검색조건에 해당하는 결과가 없습니다. 다른 검색조건을 선택해 주세요.</div>
				</c:otherwise>
				</c:choose>
				</c:if>
				<c:if test="${vo.searchSubTarget eq 'rnd'}">
					${data.rnd_totalPage}
				</c:if> --%>
		    </div>		
			<!-- 성과논문 끝 -->
			<%-- <%@include file="../layout/includes/subRightMenu.jsp"%>  --%>
		

	
 	<!-- rightMenu -->
	<!--아카이브(보고서)검색제한-->
	<c:if test="${vo.searchSubTarget eq 'report'}" >
		<div id="sidebar-right" style="margin-top:145px;">
			<div class="sidebar-right-text">검색결과제한</div>
				<ul class="acc-menu" id="accordionMenu1">
					<li data-extension="close">
						<div class="main-title"><a>발행년도</a></div>
						<ul id="groupNlmc" class="sub">
							<li>
							<label for="str_dt" class="hide"></label>
							<input type="text" style="width: 55px; margin-left: 1%;text-align: center;height: 18px;" maxlength="4" id="startDate" title="startDate" name="startDate" value="${vo.startDate}" onblur=""> 
							-
							<label for="end_dt" class="hide"></label>
							<input type="text" style="width: 55px; margin-left: 1%; text-align: center;height: 18px;" maxlength="4" id="endDate" title="endDate" name="endDate" value="${vo.endDate}"  onblur="">
							</li> 	
						 	<!--  <a class="more_btn2" href="javascript:moveYear();" style="margin-top: 5%;">적용</a>  -->
					 	 	<li id="moreYear"><a class="more_btn2" href="javascript:moveYear();" >적용</a></li>
						</ul>
					</li>
					<li data-extension="close">
						<div class="main-title"><span class="folder"> </span><a>연구비지원기관</a> </div>
						<ul class="sub" id ="fillter_dept">
							<c:forEach var="deptGroupList" items="${data.deptGroupList}" varStatus="status">
								<li class="deptClass">
									<input type="checkbox" id="${deptGroupList.groupNm}" name="searchDeptList" value="${deptGroupList.groupNm}" <c:forEach var="searchDeptList" items="${vo.searchDeptList}" varStatus="status"><c:if test="${searchDeptList eq deptGroupList.groupNm}"> checked="checked" </c:if> </c:forEach> >
									<label for="${deptGroupList.groupNm}">${deptGroupList.groupNm}(${deptGroupList.groupCnt})</label>
								</li>
							</c:forEach>
						</ul>
					</li>
					<li data-extension="close">
						<div class="main-title"><span class="folder"> </span><a>주제분류</a> </div>
						<ul class="sub" id ="fillter_dept">
							<c:forEach var="subjectGroupList" items="${data.subjectGroupList}" varStatus="status">
								<li class="subjectClass">
									<input type="checkbox" id="${subjectGroupList.groupNm}" name="searchDeptList" value="${subjectGroupList.groupNm}" <c:forEach var="searchSubjectList" items="${vo.searchSubjectList}" varStatus="status"><c:if test="${searchSubjectList eq subjectGroupList.groupNm}"> checked="checked" </c:if> </c:forEach> >
									<label for="${subjectGroupList.groupNm}">${subjectGroupList.groupNm}(${subjectGroupList.groupCnt})</label>
								</li>
							</c:forEach>
						</ul>
					</li>
				</ul>
				<a class="sidebar-right-text" href="javascript:fn_fillterControll('clear')">Clear All</a>
		</div>
	</c:if>
	<!--아카이브(보고서)검색제한 끝-->
	<!-- rightMenu End -->
	
	<!-- rightMenu -->
	<!--아카이브(성과논문)검색제한-->
	<c:if test="${vo.searchSubTarget eq 'rnd'}" >
		<div id="sidebar-right" style="margin-top:145px;">
			<div class="sidebar-right-text">검색결과제한</div>
				<ul class="acc-menu" id="accordionMenu1">
					<li data-extension="close">
						<div class="main-title"><span class="folder"> </span><a>발행년도</a></div>
						<ul id="groupNlmc" class="sub">
							<li>
							<label for="str_dt" class="hide"></label>
							<input type="text" style="width: 55px; margin-left: 1%;text-align: center;height: 18px;" maxlength="4" id="startDate" title="startDate" name="startDate" value="${vo.startDate}" onblur=""> 
							-
							<label for="end_dt" class="hide"></label>
							<input type="text" style="width: 55px; margin-left: 1%; text-align: center;height: 18px;" maxlength="4" id="endDate" title="endDate" name="endDate" value="${vo.endDate}"  onblur="">
							</li> 	
						 	<!--  <a class="more_btn2" href="javascript:moveYear();" style="margin-top: 5%;">적용</a>  -->
					 	 	<li id="moreYear"><a class="more_btn2" href="javascript:moveYear();" >적용</a></li>
						</ul>
					</li>		
				</ul>
				<a class="sidebar-right-text" href="javascript:fn_fillterControll('clear')">Clear All</a>
		</div>
	</c:if>
	<!--아카이브(성과논문)검색제한 끝--> 
	<!-- rightMenu End -->
	</div><!-- 아카이브 목록 끝 -->  		 
	</div> 
	</div>	


<form id="searchMove" name="searchMove" action="${ctxt}/search/search.do" method="post">
	<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
	<input type="hidden" id="searchQueryMove" name="searchQuery" value="${vo.searchQuery}" />
	<input type="hidden" id="pageNumMove" name="pageNum" value="${vo.pageNum}" />
	<input type="hidden" id="pageSizeMove" name="pageSize" value="${vo.pageSize}" />
	<input type="hidden" id="searchSortMove" name="searchSort" value="${vo.searchSort}" />
	<input type="hidden" id="searchTargetMove" name="searchTarget" value="${vo.searchTarget}" />
	<input type="hidden" id="searchSubTargetMove" name="searchSubTarget" value="${vo.searchSubTarget}" />
	<input type="hidden" id="searchYearMove" name="searchYear" value="${vo.searchYear}" />
	<input type="hidden" id="searchNlmcMove" name="searchNlmc" value="${vo.searchNlmc}" />
	<input type="hidden" id="searchLangMove" name="searchLang" value="${vo.searchLang}" />
	<input type="hidden" id="startDateMove" name="startDate" value="${vo.startDate}" />
	<input type="hidden" id="endDateMove" name="endDate" value="${vo.endDate}" />
	<c:if test ="${not empty vo.searchDeptList}">
		<c:forEach var="searchDeptList" items="${vo.searchDeptList}" varStatus="var">
			<input type="hidden" name="searchDeptList" value="${searchDeptList}" />
		</c:forEach>
	</c:if>
	<c:if test ="${not empty vo.searchSubjectList}">
		<c:forEach var="searchSubjectList" items="${vo.searchSubjectList}" varStatus="var">
			<input type="hidden" name="searchSubjectList" value="${searchSubjectList}" />
		</c:forEach>
	</c:if>
</form>
