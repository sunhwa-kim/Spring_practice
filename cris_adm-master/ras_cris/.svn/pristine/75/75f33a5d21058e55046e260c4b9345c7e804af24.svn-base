<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>

<%
/**
  * @Class Name : getVolinfo.jsp
  * @Description : 볼륨정보
  * @Modification Information
  * @
  * @  수정일   	수정자		수정내용
  * @ ----------	------		---------------------------
  * @ 2015.07.15	명재홍		최초 생성
  * 
  /
  *  @author 온라인 개발팀 명재홍
  *  @since 2015.07.15
  *  @version 1.0
  *  @see
  */
%>
<%
SimpleDateFormat formattime = new SimpleDateFormat("yyyyMMdd");
//formattime = new SimpleDateFormat("yyyy MMM dd", Locale.UK);
formattime = new SimpleDateFormat("yyyy MMM", Locale.UK);
%>

<c:choose>
 <c:when test="${params.subCategory eq 'injournalList' || param.part eq 'continuedBy'}">




		        
    	<table cellspacing="10" cellpadding="10" border=5 class="grid" style="margin: 10px 0 0 0;border-spacing:10px 10px;" summary="조회된 목록입니다.">
			<colgroup>
			    <col width="10%">
				<col width="20%">
				<col width="50%">
				<col width="20%">
		    </colgroup>
		    

					
					
            <c:forEach var="reqstVO" items="${resultList}" varStatus="status">
					
					 
				<c:if test="${empty year}">	 
			     <tr>
					<th id="${reqstVO.years}" style="background-color:#dedede;color:black;font-weight:bold; min-width:100px;">Vol. ${reqstVO.volumeno}</th>
					<td style="width:70%;padding-left:10px;height:50px;">
				</c:if>
					
				           <c:choose>
 							<c:when test="${year eq reqstVO.years || empty year}">  
<%--                             <c:when test="${volumenoChk eq reqstVO.volumeno || empty volumenoChk}"> --%>
 
							</c:when>
							<c:otherwise>

									 </td>
								</tr>
							  </table>	
					    	<table cellspacing="10" cellpadding="10" border=5 class="grid" style="margin: 10px 0 0 0;border-spacing:10px 10px;" summary="조회된 목록입니다.">
							<colgroup>
							    <col width="10%">
								<col width="20%">
								<col width="50%">
								<col width="20%">
						    </colgroup>
		    
						     <tr>
								<th id="${reqstVO.years}" style="background-color:#dedede;color:black;font-weight:bold; min-width:100px;">Vol. ${reqstVO.volumeno}<%--${reqstVO.years} --%></th>
								<td style="width:70%;padding-left:10px;height:50px;">		

                                    <div>


                               <script>
                               if ($("#${year}").text() != "Vol. ${volumenoChk}")  {
                                     $("#${year}").append("~${volumenoChk}");
                               }  
                                  $("#${year}").append("<br>${year}");
                               </script>
							</c:otherwise>
						</c:choose>	
					
					
					<c:if test="${reqstVO.artcnt > 0}">
					
					   <c:if test="${volumenoChk ne reqstVO.volumeno}"></div><div style="clear:both;"></c:if>
					   
						<li style="width:130px;float:left;color:black;font-size:10pt;padding-top:5px;">
                                <fmt:parseDate value='${reqstVO.pubdate}' var='pubdate' pattern="yyyyMMdd" scope="page"/>
								<c:set var="pubdate2" value="${pubdate}" scope="page"  />						
						
							<span style="cursor:pointer;" onclick="goArticleList('<c:out value='${reqstVO.volumeno}'/>', '<c:out value='${reqstVO.volumeissue}'/>', '<c:out value='${reqstVO.years}'/>', '<%= formattime.format((Date)pageContext.getAttribute("pubdate2")) %>','<c:out value='${reqstVO.controlno}'/>','<c:out value='${reqstVO.seqno}'/>','<c:out value='${reqstVO.abbreviationttitle}'/>');">
							 V.<c:out value='${reqstVO.volumeno}'/>(<c:out value='${reqstVO.volumeissue}'/>)
                              <br/>  
 								<%= formattime.format((Date)pageContext.getAttribute("pubdate2")) %>
							</span>
						</li>	
						
						<c:set var="volumenoChk" value="${reqstVO.volumeno}"/>	
					</c:if>	
						
					<c:set var="year" value="${reqstVO.years}" ></c:set>
                    
					 
<%-- 					<td>    ${reqstVO.controlno} / ${reqstVO.seqno}  </td> --%>
				 		
			</c:forEach>	 
			                 </div>
			                 
                               <script>
                               if ($("#${year}").text() != "Vol. ${volumenoChk}")  {
                            	   
                                    $("#${year}").append("~${volumenoChk}");
                               }  
                                  $("#${year}").append("<br>${year}");
                               </script>
			
						 </td>
					</tr>
		   </tbody>
         </table>


		    					<script type="text/javascript">
								function goArticleList(volume, issue, year, month,controlno,seqno,jrnlNm) {
									document.listForm.volume.value = volume;
									document.listForm.issue.value  = issue;
									document.listForm.year.value  = year;
									document.listForm.month.value  = month;
									document.listForm.controlno.value  = controlno;
									document.listForm.seqno.value  = seqno;
									document.listForm.jrnlNm.value  = jrnlNm;
									document.listForm.action = "${ctxt}/search/retrieveGetJviList.do";
									document.listForm.submit();
								}
								</script>	
								
								<!-- 										        
								<form name="listForm" method="get">
								<input type="hidden" id="jrnlNo" name="jrnlNo" value=""/>
								<input type="hidden" id="jrnlNm" name="jrnlNm" value=""/>
								<input type="hidden" id="jrnlIssn" name="jrnlIssn" value=""/>
								<input type="hidden" id="volume" name="volume"/>
								<input type="hidden" id="issue"  name="issue"/>
								<input type="hidden" id="year"  name="year"/>
								<input type="hidden" id="month"  name="month"/>
								<input type="hidden" id="controlno"  name="controlno"/>
								<input type="hidden" id="seqno"  name="seqno"/>
								</form> 
								 -->


 </c:when>
 <c:when test="${param.wkid eq '21'}">


<link rel="stylesheet" href="<c:url value='/css/jquery.treeview.css'/>" />
<link rel="stylesheet" href="<c:url value='/css/screen.css'/>" />
<script src="<c:url value='/js/jquery.cookie.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/jquery.treeview.js'/>" type="text/javascript"></script>

<script type="text/javascript">
var $p = jQuery.noConflict();
$p(function() {
	$p("#tree").treeview({
				collapsed: true,
				animated: "medium",
				control:"#sidetreecontrol",
				persist: "location"
			});
		})
		
</script>


<!-- 	<div id="sidetreecontrol"><a href="#">전체 닫기</a> | <a href="#">전체 열기</a></div> -->

 <ul id="tree">
		
     <c:forEach var="reqstVO" items="${resultList}" varStatus="status">
        <fmt:parseDate value='${reqstVO.pubdate}' var='pubdate' pattern="yyyyMMdd" scope="page"/>
		<c:set var="pubdate2" value="${pubdate}" scope="page"  />
		<c:set var="volume" value="${reqstVO.volumeno}(${reqstVO.volumeissue})" scope="page"  />	
		
			<c:if test="${empty year}">	
			 <li <c:if test="${param.dateIssued eq reqstVO.years}">class="open"</c:if> style="padding-bottom: 5px;border-bottom:none;margin-top:0px;"><c:out value="${reqstVO.years}"/> 
			 <ul>
			</c:if>
				        <c:choose>
 						  <c:when test="${year eq reqstVO.years || empty year}">  
 			                 <li class="submenu  <c:if test="${param.volume eq volume}">on chked selected</c:if>" style="margin-top:0px;border-bottom: none;" > &nbsp; <a href="javascript://"  onclick="goArticleList('<c:out value='${reqstVO.volumeno}'/>', '<c:out value='${reqstVO.volumeissue}'/>', '<c:out value='${reqstVO.years}'/>', '<%= formattime.format((Date)pageContext.getAttribute("pubdate2")) %>','<c:out value='${reqstVO.controlno}'/>','<c:out value='${reqstVO.seqno}'/>','<c:out value='${reqstVO.abbreviationttitle}'/>');">V.<c:out value="${reqstVO.volumeno}"/> n.<c:out value="${reqstVO.volumeissue}"/></a> (<c:out value="${reqstVO.artcnt}"/>) <%= formattime.format((Date)pageContext.getAttribute("pubdate2")) %></li>
 						  </c:when>
						  <c:otherwise>
					 		 </ul>
						    </li>
							 <li <c:if test="${param.dateIssued eq reqstVO.years}">class="open"</c:if> style="padding-bottom: 5px;border-bottom:none;margin-top:0px;"><c:out value="${reqstVO.years}"/>
							 <ul>
				 			    <li class="submenu <c:if test="${param.volume eq volume}">on chked selected</c:if>" style="margin-top:0px;border-bottom: none;"> &nbsp; <a href="javascript://"  onclick="goArticleList('<c:out value='${reqstVO.volumeno}'/>', '<c:out value='${reqstVO.volumeissue}'/>', '<c:out value='${reqstVO.years}'/>', '<%= formattime.format((Date)pageContext.getAttribute("pubdate2")) %>','<c:out value='${reqstVO.controlno}'/>','<c:out value='${reqstVO.seqno}'/>','<c:out value='${reqstVO.abbreviationttitle}'/>');">V.<c:out value="${reqstVO.volumeno}"/> n.<c:out value="${reqstVO.volumeissue}"/></a> (<c:out value="${reqstVO.artcnt}"/>) <%= formattime.format((Date)pageContext.getAttribute("pubdate2")) %></li>				
						  </c:otherwise>
						</c:choose>	
			
			<c:set var="year" value="${reqstVO.years}" ></c:set>
	 </c:forEach>		
	 </ul>
    </li>	 
</ul>
 

 
 <script>
 /*메뉴슬라이딩 */
//  function initMenu() {
  
//    $('#menu ul').hide();
//    $('#menu ul').children('.on').parent().show();
//    //$('#menu ul:first').show();
//    $('#menu li a').click(
//      function() {
//        var checkElement = $(this).next();
//        if((checkElement.is('ul')) && (checkElement.is(':visible'))) {
//      	$('#menu ul:visible').slideUp(300);
//          return false;
//          }
//        if((checkElement.is('ul')) && (!checkElement.is(':visible'))) {
//          $('#menu ul:visible').slideUp(300);
//          checkElement.slideDown(300);
//          return false;
//          }
//        }
//      );
//    }
//  window.onload=initMenu;

function goArticleList(volume, issue, year, month,controlno,seqno,jrnlNm) {
	document.listForm.volume.value = volume;
	document.listForm.issue.value  = issue;
	document.listForm.year.value  = year;
	document.listForm.month.value  = month;
	document.listForm.controlno.value  = controlno;
	document.listForm.seqno.value  = seqno;
	document.listForm.jrnlNm.value  = jrnlNm;
	document.listForm.action = "${ctxt}/search/retrieveGetJviList.do";
	document.listForm.submit();
}
</script>											        

 </c:when>
 
 <c:otherwise>

	<script>
	function goYear() {
		document.detailForm.sYear.value=$("#selectYonPblicteYy option:selected").val();
		document.detailForm.submit();
	}
	</script>

  <div style="margin: 25px 0 0 0"> 연도선택 : 
  
		<select name="selectYonPblicteYy" class="u25 selectYonPblicteYyMm" id="selectYonPblicteYy" data-label="Dropdown Menu">
			 <option value="total" >전체</option>
			 <c:forEach var="reqstVO" items="${resultList}" varStatus="status"> 

			    <c:choose>
					<c:when test="${year eq reqstVO.years}"> 
                         
					</c:when>
					<c:otherwise>
					
					   <c:choose>
					     <c:when  test="${ empty param.sYear && status.count eq 1}">
					       <option value="${reqstVO.years}"  selected="selected">${reqstVO.years}</option>
					     </c:when>
					     <c:otherwise>
		                 <option value="${reqstVO.years}"  <c:if test="${reqstVO.years eq param.sYear}">selected="selected"</c:if>>${reqstVO.years}</option>
			             </c:otherwise>
				       </c:choose>	
		             
		             </c:otherwise>
			    </c:choose>	
		     <c:set var="year" value="${reqstVO.years}" ></c:set>

		     <c:if test="${status.count eq 1}"> <c:set var="cyear" value="${reqstVO.years}" ></c:set> </c:if>
		     </c:forEach>	 
		     
		</select>
		<c:if test="${not empty param.sYear}"> <c:set var="cyear" value="${param.sYear}" ></c:set> </c:if>
        <input type="button" name="검색" value=" 검색 " onclick="goYear()" class="gray" />

    </div>

    	<table cellspacing="0" cellpadding="0" class="table2" style="margin: 15px 0 0 0" summary="조회된 목록입니다.">	    
			<tr>
				<th scope="col">년도</th>
				<th scope="col">권호</th>
<!-- 				<th scope="col">volumeNo</th> -->
<!-- 				<th scope="col">volumeIssue</th> -->
<!--				<th scope="col">등록기사 수</th> -->
<!-- 				<th scope="col">등록번호</th> -->
 				<th scope="col">발행일</th>
				<th scope="col">입수상태</th>
				
			</tr>
					
					
            <c:forEach var="reqstVO" items="${resultList}" varStatus="status">

             <c:if test="${cyear eq reqstVO.years || cyear eq 'total'   }">
			  
			  <c:if test="${reqstVO.artcnt < 1}">
			    <tr onclick="alert('등록된 기사가 없습니다.');" style="background-color: rgb(255, 255, 255);">
              </c:if>
			  <c:if test="${reqstVO.artcnt > 0}">
			    <tr  onclick="goArticleList('${reqstVO.volumeno}', '${reqstVO.volumeissue}', '${reqstVO.years}', '','${reqstVO.controlno}','${reqstVO.seqno}');" onMouseOver="this.style.backgroundColor = '#F4F4F4'" onMouseOut="this.style.backgroundColor='#ffffff'"  style="cursor:pointer;background-color: rgb(255, 255, 255);">
              </c:if>
              
					<td style="color:black;font-weight:bold; min-width:100px;">${reqstVO.years}</td>
					<td>	
					  ${reqstVO.volumename} <!-- <span style="font-size:8pt;color:gray">(${reqstVO.artcnt})</span> -->
					 </td>
<%-- 						 <td>${reqstVO.volumeno}</td> --%>
<%-- 						 <td>${reqstVO.volumeissue}</td> --%>
<%--					 	 <td>${reqstVO.artcnt}</td> --%>
<%-- 						 <td>${reqstVO.controlno}</td> --%>
					<td>
 						 <fmt:parseDate value="${reqstVO.pubdate}" var="dateFmt" pattern="yyyyMMdd"/>
                         <fmt:formatDate value="${dateFmt}" pattern="yyyy.MM.dd"/>
 					</td>
					<td>
						<c:choose> <%-- 체크인상태(CheckinStatus) 입수(1),미착(2),클레임(3),결호(4),분실(5),입수/미착(6),입수/클래임(7),입수/결호(8),입수/분실(9) --%>
							<c:when test="${reqstVO.checkinstatus eq '1' }">입수</c:when>
							<c:when test="${reqstVO.checkinstatus eq '2' }">미착</c:when>
							<c:when test="${reqstVO.checkinstatus eq '3' }">클레임</c:when>
							<c:when test="${reqstVO.checkinstatus eq '4' }">결호</c:when>
							<c:when test="${reqstVO.checkinstatus eq '5' }">분실</c:when>
							<c:when test="${reqstVO.checkinstatus eq '6' }">입수/미착</c:when>
							<c:when test="${reqstVO.checkinstatus eq '7' }">입수/클레임</c:when>
							<c:when test="${reqstVO.checkinstatus eq '8' }">입수/결호</c:when>
							<c:when test="${reqstVO.checkinstatus eq '9' }">입수/분실</c:when>
						</c:choose>
					</td>
						 
					</tr>
				 </c:if>		
			</c:forEach>	 
		   </tbody>
         </table>



	</c:otherwise>
</c:choose>
       
