<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script>

function meshSch(type,stext){
	var frm = document.meshSchForm;
	$('#meshDesc').val(stext);
	frm.submit();
}

function fn_journal(journal,type){
	
	$('#s1').val(type);
	$('#d1').val(journal);
	var form = document.journalForm;
	form.submit();
}

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
function fn_goJournalList(jval,gbn){
	var form = document.junalForm;
	$('#filterGbn').val(gbn);
	$('#filterVal').val(jval);
	form.action = "${ctxt}/elib/kom/listJunal.do";
	form.submit();
}
   
</script>
        

<style> 
    #junal_t{ 
	    margin: 0; 
	    display: inline-block;
	    border-top: 0px solid rgba(0,0,0,0.3);
	    font-size: 22px;
    }
    .view_table>tbody.report>tr>th{
    	border-right: 0px solid #CCDDED;
	    background: none;
	    text-align:right;
	    color:#3c3a3a;
	    width:20%;
    }
    .view_table>tbody.report>tr{
    	
    } 
    .view_table>tbody.report>tr:last-child{
    	border-bottom:1px solid #98BCDB;
    }
    .view_table>tbody.report>tr {
	    border-bottom: 0px solid #CCDDED;
	}
    .content_box>.content_list>.list_title>p:before, .content_box .content_list .list_title p:before, .content_box>.content_list>.sub_book_wrap>.list_title>p:before {
    content: "";
	}
	.view_table>tbody.report>tr>th{
		height:auto;
		line-height:20px;
	}
	@media (max-width: 800px){
		.view_table>tbody.report>tr>th{
			width:25%;
		}
		.view_table>tbody.report>tr>td{
			width:75%;
		}
	}
	@media (max-width: 550px){
		.view_table>tbody.report>tr>th{
			width:35%;
		}
		.view_table>tbody.report>tr>td{
			width:65%;
		}
	}
	@media (max-width: 410px){
		.view_table>tbody.report>tr>th{
			width:50%;
		}
		.view_table>tbody.report>tr>td{
			width:50%;
		}
	}
</style>

<form id="meshSchForm" name="meshSchForm" method="post" action="<c:out value="/ncmiklib"/>/elib/kom/meshDtl.do"  >
    <input type="hidden" id="meshDesc" name="meshDesc" value="" />
</form>    
<form id="junalForm" name="junalForm" method="post" action="" >
	<input type="hidden" id="bibctrlno" name="bibctrlno" value="" />
	<input type="hidden" id="page" name="page" value="" />
	<input type="hidden" id="filterGbn" name="filterGbn" value="" />
	<input type="hidden" id="filterVal" name="filterVal" value="" />
</form>        

<!-- 	<div id="divUcont_cont"> -->  
		<div class="sub_center_text">
			<div class="sub_center_nav">
				<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>
				<span> > </span> <span>전자자원</span> <span> > </span> <span class="active">Korea OpenMed</span>
			</div>
<!-- 			<span class="center_text_01">학술지 상세정보</span> -->
		</div>

		<div class="under_bar"></div>

		<div class="content_wrap">
			<div class="content_box">
				<div class="content_list">
						<div class="list_title">
							<p id="junal_t"><c:out value='${junal.TITLE}'/></p>
						</div>
						<!-- <div class="under_bar2"></div>   -->
						
<!-- 						<div class="sub_book_wrap" id = "div_body"> -->
							<div id="bodyInfo">
								<form action="" name="upCdForm" id="upCdForm" method="post">
								<input type="hidden" name="up_cd" value="NCMIK" /> 
								<input type="hidden" name="cd_ord" value="0" /> <input type="hidden" name="save_type" id="save_type" value="" /> 
								<%-- <h3>${junal.TITLE}</h3> --%>
								<table class="view_table junalDtl_table" style="">
									<colgroup>
										
									</colgroup>
									<tbody class="report">
										<c:if test="${junal.ABBREVIATIONTTITLE ne null}">
										<tr>
											<th><span class="must"></span><label  
												for="cd_desc">Title Abbreviation</label></th>
											<td colspan="3"><c:out value='${junal.ABBREVIATIONTTITLE}'/></td>
										</tr>
										</c:if>   
										<c:if test="${junal.ALTERNATIVETITLE ne null}">
										<tr>
											<th><span class="must"></span><label
												for="cd_desc">Title(s)</label></th>
											<td colspan="3"><c:out value='${junal.ALTERNATIVETITLE}'/></td>
										</tr>
										</c:if>
										<c:if test="${junal.VARIANTSNAME ne null}">
										<tr>
											<th><span class="must"></span><label
												for="cd_desc">Other Title(s)</label></th>
											<td colspan="3"><c:out value='${junal.VARIANTSNAME}'/></td>
										</tr>
										</c:if>   
										<c:if test="${junal.PUBLISHER ne null}">
										<tr>
											<th><span class="must"></span><label
												for="cd_desc">Publisher</label></th>
											<td colspan="3"><a href="javascript:fn_goJournalList('${junal.PUBLISHER}','publisher')" >${junal.PUBLISHER}</a></td>
										</tr>
										</c:if>
										<c:if test="${junal.STARTYEAR ne null}">
											<c:set var="year" value="${fn:split(junal.STARTYEAR,'-')}" />
												<c:forEach var="item" items="${year}" varStatus="g">
												<tr>
													<th><span class="must"></span>
													<c:if test="${g.index == 0}">
														<label for="cd_desc">Publication Start Year</label>
													</c:if>
													<c:if test="${g.index > 0}">
														<label for="cd_desc">Publication End Year</label>
													</c:if>
													</th>
													<td colspan="3">${item}</td>
												</tr>
											</c:forEach> 
										</c:if>
										<c:if test="${junal.PUBLICATIONFREQUENCY ne null}">
										<tr>
											<th><span class="must"></span><label
												for="cd_desc">Frequency</label></th>
											<td colspan="3"><a href="javascript:fn_goJournalList('${junal.PUBLICATIONFREQUENCY}','frequency')" >${junal.PUBLICATIONFREQUENCY}</a></td>
										</tr>
										</c:if>
										<c:if test="${junal.LANGUAGE ne null}">
											<c:set var="lang" value="${fn:split(junal.LANGUAGE,',')}" />
											<c:forEach var="item" items="${lang}" varStatus="g">
											<tr <c:if test="${g.index > 0}">style="line-height:5px;height:10px;"</c:if>>
												<th><span class="must"></span>
													<c:if test="${g.index == 0}">
															<label for="cd_desc">Language</label>
													</c:if>
													<c:if test="${g.index > 0}">
														<label for="cd_desc"></label>
													</c:if>    
												</th>		
												<td colspan="3">
													${item}
												</td>
											</tr>
											</c:forEach> 
										</c:if>
										<c:if test="${junal.PISSN ne null}">
										<tr>
											<th><span class="must"></span><label
												for="cd_desc">ISSN</label></th>
											<td colspan="3">(p)${junal.PISSN}</td>
										</tr>
										</c:if>
										<c:if test="${junal.EISSN ne null}">
										<tr style="line-height:5px;height:10px;">
											<th><span class="must"></span><label
												for="cd_desc"></label></th>
											<td colspan="3">(e)<c:out value='${junal.EISSN}'/></td>
										</tr>
										</c:if>
										<c:if test="${junal.DOI ne null}">
										<tr>
											<th><span class="must"></span><label
												for="cd_desc">DOI</label></th>
											<td colspan="3"><a
												href="javascript:doiPopupOpen('<c:out value="${junal.DOI}"/>')">
													<c:out value='${junal.DOI}'/></a></td>
										</tr>
										</c:if>
										<!-- 선행 후행 학습지 -->
										<c:if test="${junal.CONTINUES ne null}">
										<tr>
											<th><span class="must"></span><label
												for="cd_desc">Continues</label></th>
											<td colspan="3"><a class="auth_name" href="javascript:fn_goJournalDtl('${junal.CONTINUES_NO}')">${junal.CONTINUES}</a></td>
										</tr>
										</c:if>
										<c:if test="${junal.CONTINUEDBY ne null}">
										<tr>
											<th><span class="must"></span><label
												for="cd_desc">Continues By</label></th>  
											<td colspan="3"><a class="auth_name" href="javascript:fn_goJournalDtl('${junal.CONTINUEDBY_NO}')">${junal.CONTINUEDBY}</a></td>
										</tr>
										</c:if>
										<c:if test="${junal.LINKOUTURL ne null}">
											<c:set var="elink" value="${fn:split(junal.LINKOUTURL,',')}" />
											<c:forEach var="item" items="${elink}" varStatus="g">
											<tr <c:if test="${g.index > 0}">style="line-height:5px;height:10px;"</c:if>>
												<th><span class="must"></span>
													<c:if test="${g.index == 0}">
															<label for="cd_desc">Electronic Link</label>
													</c:if>
													<c:if test="${g.index > 0}">
														<label for="cd_desc"></label>
													</c:if>
												</th>		
												<td colspan="3">  
													<a href="javascript:window.open('${item}');">${item}</a>
												</td>
											</tr>
											</c:forEach> 
											<c:if test="${junal.NCMIKID ne null}">  
												<tr>
													<th><span class="must"></span><label for="cd_desc"></label></th>
													<td colspan="3"><a href="javascript:fn_goJournal('${junal.BIBCTRLNO}');">http://library.nih.go.kr/${junal.NCMIKID}</a></td>
												</tr>
											</c:if>
										</c:if>
										<c:if test="${junal.LINKOUTURL eq null and junal.NCMIKID ne null}">
											<tr>
												<th><span class="must"></span><label for="cd_desc">Electronic Link</label></th>
												<td colspan="3"><a href="javascript:fn_goJournal('${junal.BIBCTRLNO}');">http://library.nih.go.kr/${junal.NCMIKID}</a></td>
											</tr>
										</c:if>
										
										<c:if test="${junal.SUBJECTAREA ne null}">
										<tr>
											<th><span class="must"></span><label
												for="cd_desc">Subject Area</label></th>   
											<td colspan="3"><a href="javascript:fn_goJournalList('${junal.SUBJECTAREA}','subjectArea')" >${junal.SUBJECTAREA }</a></td>
										</tr>
										</c:if>
										<c:if test="${junal.MESH ne null}">
											<c:set var="mesh" value="${fn:split(junal.MESH,',')}" />
											<c:forEach var="item" items="${mesh}" varStatus="g">
											<tr <c:if test="${g.index > 0}">style="line-height:5px;height:10px;"</c:if> >
												<th><span class="must"></span>
													<c:if test="${g.index == 0}">
															<label for="cd_desc">MeSH</label>
													</c:if>
													<c:if test="${g.index > 0}">
														<label for="cd_desc"></label>
													</c:if>
												</th>		
												<td colspan="3">  
													<a style="color: #14376c;" href="javascript:meshSch('MeSHTopicalDesc','<c:out value="${item}"/>')"><c:out value="${item}"/></a>
												</td>
											</tr>
											</c:forEach> 
										</c:if>
										<c:if test="${junal.INDEXEDIN ne null}">
											<c:set var="index" value="${fn:split(junal.INDEXEDIN,',')}" />
											<c:forEach var="item" items="${index}" varStatus="g">
											<tr <c:if test="${g.index % 2 == 0}">style="line-height:5px;height:10px;"</c:if>>
												<th><span class="must"></span>
													<c:if test="${g.index == 0}">
															<label for="cd_desc">Indexed in</label>
													</c:if>
													<c:if test="${g.index > 0}">
														<label for="cd_desc"></label>
													</c:if>
												</th>		
												<td colspan="3">
													<a href="javascript:fn_goJournalList('${item}','indexedIn')" >${item}</a>
												</td>
											</tr>
											</c:forEach> 
										</c:if>
										<c:if test="${junal.PUBLICATIONTYPE ne null}">
										<tr>
											<th><span class="must"></span><label
												for="cd_desc">Publication Type(s)</label></th>
											<td colspan="3"><c:out value='${junal.PUBLICATIONTYPE}'/></td><!-- periodicals -->
										</tr>
										</c:if>
										<%-- 20181122 제거 요청 
										<c:if test="${junal.EXTERNALURL ne null}">
										<tr>
											<th><span class="must"></span><label
												for="cd_desc">Notes</label></th>
											<td colspan="3">${junal.EXTERNALURL}</td>
										</tr>
										</c:if> 
										--%>
										<c:if test="${junal.NCMIKID ne null}">
										<tr>
											<th style="border-bottom:0;"><span class="must"></span><label
												for="cd_desc">KNLM ID</label></th>
											<td colspan="3"><c:out value='${junal.NCMIKID}'/></td>
										</tr>
										</c:if>
									</tbody>
								</table>
							</form>
							</div>
							<!-- <div class="under_bar2"></div>   -->
							<div id="paging" class="paginate"></div>
							<div class="btn-group back" style="height:38px;">
								<a href="javascript:history.back(-1)" title="BACK"
									class="basic-btn back" style="bottom:0;">Journal List</a>
							</div>
				</div>
			</div>
		</div>
<form id="journalForm" name="journalForm" method="post" action="${ctxt}/elib/kom/listArticle.do"  >
	<input type="hidden" id="cate" name="subCategory" value="in"/>
	<input type="hidden" id="sba" name="subjectArea" value="all"/>
	<input type="hidden" id="s1" name="searchCondition1" value="journal"/>
	<input type="hidden" id="s2" name="searchCondition2" value="title"/>  
	<input type="hidden" id="s3" name="searchCondition3" value="author"/>
	<input type="hidden" id="d1"  name="detailInput1" value=""/>
	<input type="hidden" id="o1"  name="selectOption1" value="and"/>  
	<input type="hidden" id="o2"  name="selectOption2" value="and"/>
	<input type="hidden" id="o3"  name="selectOption3" value="and"/>
	<input type="hidden" id="d2"  name="detailInput2" value=""/>  
	<input type="hidden" id="d3"  name="detailInput3" value=""/>
	<input type="hidden" id="d4"  name="detailInput4" value=""/>
	<input type="hidden" id="d5"  name="detailInput5" value="all"/>
	<input type="hidden" id="sd"  name="startDate" value=""/>
	<input type="hidden" id="ed"  name="endDate" value=""/>
	<input type="hidden" id="isNull"  name="isNull" value="true"/>
	<input type="hidden" id="hstrDiv"  name="hstrDiv" value="2"/>
	<input type="hidden" id="jwkid"  name="wkid" value=""/>
	<input type="hidden" name="detailYn" value="Y"/>
	<input type="hidden" name="searchGubun" value="board"/>
</form>