<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="under_bar"></div>
		<div class="content_wrap">
			<div class="content_box">
					<div class="content_list">

		<!-- 컨텐츠 영역 -->
		<div class="list_title">
			<p>공지사항 상세</p>
		</div>
		<!-- <h2 class="depth-title">알림마당 상세</h2> -->

		<table class="view_table">
			<caption>공지사항 - 제목, 등록일 , 조회수 , 내용, 첨부파일</caption>
			<colgroup>
				<col style="width: 20%">
				<col>
			</colgroup>
			<tbody class="report">
				<tr>
					<th scope="row">분류</th>
					<td align="left">${resultDetailedVo.classification}</td>
				</tr>
				<tr>
					<th scope="row">제목</th>
					<td align="left">${resultDetailedVo.title}</td>
				</tr>
				<tr>
					<th scope="row">작성자</th>
					<td align="left">${resultDetailedVo.writer}</td>
				</tr>
				<tr>
					<th scope="row">등록일</th>
					<td align="left">${resultDetailedVo.insertdate_board}</td>

				</tr>
				<tr>
					<th scope="row">내용</th>
					<td align="left">
						<div id='divEtcarea' style="width: 100%;">${resultDetailedVo.idx_board}</div>
					</td>

				</tr>
				<tr>
					<th scope="row">상태</th>
					<td align="left">${resultDetailedVo.situation}</td>

				</tr>

				<%-- <tr>
					<th scope="row">첨부파일</th>
					<td><c:if test="${resultDetailedVo.atch_link_id != null}">
							<div>
								<br /> <input type='button' onClick='fileView();' value='파일 보기'
									class="gray" style="padding: 5px;">
								<c:import charEncoding="utf-8"
									url="/cmm/fms/selectLinkFileInfs.do">
									<c:param name="param_atchFileId"
										value="${resultDetailedVo.atch_link_id}" />
								</c:import>
							</div>
						</c:if></td>
				</tr> --%>
			</tbody>
		</table>




		<div class="btn-group">
		<!-- 	<a href="javascript:fn_returnListUrl()" class="basic-btn" role="button">목록으로</a>  -->
			<input type="button" id="returnBoardListQnA" name="" value="목록으로">
		</div>

		<!-- 컨텐츠 영역 -->


	</div>
	</div>
	</div>
	
<form name="reqForm" method="post">
	<input type="text" id="returnListPage" name="returnListPage" value="/cris/board/qna/board.do" alt="returnPage" />
	<input type="text" id="page" name="page" value="${resultDetailedVo.page}" alt="pageNum" /> 
	<%-- <input type="hidden" id="searchCondition" name="searchCondition" value="${resultDetailedVo.searchCondition}" alt="검색콤보" /> --%>
<%-- 	<input type="text" id="searchClassification" name="searchClassification" value="${resultDetailedVo.searchClassification}" alt="검색콤보" /> --%>
	<input type="text" id="searchClassification" name="searchClassification" value="${searchClassification}" alt="검색콤보" />
	<input type="text" id="searchCustomHeader" name="searchCustomHeader" value="${searchCustomHeader}" alt="검색콤보" />
	<input type="text" id="searchSituation" name="searchSituation" value="${searchSituation}" alt="검색콤보" />
	<input type="text" id="searchKeyword" name="searchKeyword" value="${searchKeyword}" title="검색어 입력" />
	<input type="text" id="idx_board" name="idx_board" value="${resultDetailedVo.idx_board}" alt="index" />
</form>  
</body>
<script type="text/javascript">

 var searchClassification = $('#searchClassification').val();
alert(searchClassification);

  	$('#returnBoardListQnA').click(function(){
//  		location.href='/cris/board/qna/board.do'
		
  		var form = document.reqForm;
  		var returnPage = form.returnListPage.value;	
  		form.action = returnPage;
  		form.submit();	
  	})
  </script>

 


</html>