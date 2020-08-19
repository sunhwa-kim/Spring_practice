<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn", "\n"); //Space, Enter
      pageContext.setAttribute("br", "<br/>"); //br 태그
%> 


<script type="text/javascript">
var bibctrlno="<c:out value='${mlibVo.bibctrlno}' />";

$(function(){
});
</script>
<form name="reqForm" method="post">
	<!-- 컨텐츠 영역 -->
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>의과학도서관</span>
			<span> > </span>
			<span class="active">소장정보</span>        			      
		</div>
		<span class="center_text_01">소장정보</span>
	</div> 
	<div class="under_bar"></div>	
		
	<div  class= "content_wrap">
		<div class="content_box">
			<div class="content_list">
					<!-- 서지 소장정보 영역 -->
						<table class="basic_table" summary="번호, 등록번호, 청구기호, 배가위치, 도서상태, 반납예정일, 예약 정보를 가지고 있는 소장정보 테이블 입니다.">
							<caption>소장정보 표</caption>
							<colgroup>
								<col width="20%">
								<col width="20%">
								<col width="*">
								<col width="15%">	
								<col width="15%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">등록번호</th>
									<th scope="col">청구기호</th>
									<th scope="col">권차사항</th>
									<th scope="col">자료상태</th>
									<th scope="col">배가위치</th>
								</tr>
							</thead>
							<tbody id="bodyInfo">
								<c:forEach var="list" items="${list}" varStatus="status">
								<tr>
									<td style="text-align: center" >${list.acsno }</td>
									<td style="text-align: center" >${list.callno }&nbsp;${list.pubyear }</td>
									<td style="text-align: center" >${list.volumeno }</td>
									<td style="text-align: center" >${list.mtrlstatus }</td>
									<td style="text-align: center" >${list.bookcasetype }</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<!-- 컨텐츠 영역 -->
			</div>




<!-- 처리 메세지 PARAM -->
	<input type="hidden" id="message" name="message" value="<c:out value='${message}'/>" alt="message">	

    <!-- 검색 PARAM -->
	<input type="hidden" id="page" name="page" value="<c:out value='${resultVO.page}'/>" alt="pageNum" />
	<input type="hidden" id="searchCondition" name="searchCondition" value="<c:out value='${resultVO.searchCondition}' />"  alt="검색콤보" />
	<input type="hidden" id="searchKeyword" name="searchKeyword" value="<c:out value='${resultVO.searchKeyword}' />" alt="검색어" />
	
	<input type="hidden" id="rnd_id" name="rnd_id" value="<c:out value='${resultVO.rnd_id}'/>"  alt="id" />
	<input type="hidden" id="rdcnt" name="rdcnt" value="<c:out value='${resultVO.rdcnt}'/>"  alt="검색콤보" />
	<input type="hidden" id="downcnt" name="downcnt" value="<c:out value='${resultVO.downcnt}'/>"  alt="검색콤보" />
	<input type="hidden" id="rnd_abs" name="rnd_abs" value="${fn:replace(resultVO.rnd_abs, crcn , '<br/>')}"  alt="검색콤보" />
	
	<!-- 파일 다운로드 PARAM  -->
	<%-- <input type="hidden" id="atch_link_id" name="atch_link_id" value="${resultVO.atch_link_id}" alt="첨부파일ID "/> --%>
	<%-- <input type="hidden" id="alit_sj" name="alit_sj" value="${resultVO.alit_sj}" alt="공지 제목 "/> --%>
	
	<!-- 목록 화면 주소  -->
	<input type="hidden" id="returnListPage" name="returnListPage" value="${ctxt}/archive/rnd/rndList.do"  alt= "returnPage" />
	<input type="hidden" id="returnArchiveMainPage" name="returnArchiveMainPage" value="${ctxt}/archive/intro/archiveIntro.do"  alt= "returnArchiveMainPage" />
	<input type="hidden" id="returnRecentlyPage" name="returnRecentlyPage" value="${ctxt}/archive/intro/archiveRecentlyList.do"  alt= "returnRecentlyPage" />
	<input type="hidden" id="returnDownloadPage" name="returnDownloadPage" value="${ctxt}/archive/intro/archiveTopDownloadList.do"  alt= "returnRecentlyPage" />
	
	
	
	<!-- 필터 유지 위한 PARAM -->
	<input type="hidden" name="fillterYearList_s" id="fillterYearList_s" value = "<c:out value='${resultVO.fillterYearList_s}'/>" alt="필터 발행년도" />
 	<input type="hidden" name="fillterLangList_s" id="fillterLangList_s" value = "<c:out value='${resultVO.fillterLangList_s}'/>" alt="필터 언어" />
 	
 	<input type="hidden" name="fillterYearCnt" id="fillterYearCnt" value = "<c:out value='${resultVO.fillterYearCnt}'/>" alt="필터 발행년도 CNT" />
	<input type="hidden" name="fillterLangCnt" id="fillterLangCnt" value = "<c:out value='${resultVO.fillterLangCnt}'/>" alt="필터 언어 CNT" />
	
	<!-- 리턴 페이지  -->
	<input type="hidden" id="returnPageGbn" name="returnPageGbn" value="<c:out value='${resultVO.returnPageGbn}'/>"  alt="returnPageGbn">
</form>


