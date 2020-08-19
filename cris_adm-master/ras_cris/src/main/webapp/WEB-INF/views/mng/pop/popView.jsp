<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>팝업상세 | 정부출연연구기관 채용정보서비스</title>
</head>
<body>

<script type="text/javascript">


$(function(){
	if($("#messege").val() != ''){
    alert( $("#messege").val());
    }
    $("#messege").val('');

});
//uploadPath
<%String url =  (String)request.getAttribute("pathUrl");%>


function fn_del(){
	if(confirm("게시글을 삭제 하시겠습니까?")){
		var form = document.form;
		form.action = "${ctxt}/mng/pop/deletePop.do";
		form.submit();
	}
}
</script>

 <div id="container">
		<div id="content">

		<h2>팝업관리</h2>


		<div class='bview'>
		 	 <form id="form" name="form" action="" method="post" enctype="multipart/form-data">
		 	    <input type="hidden" id="messege" name="messege" value="${messege}"><!-- message 처리위한  hidden-->	 	    
		 	    <input type="hidden" id="pop_sn" name="pop_sn" value="${dtlList.pop_sn}"><!-- 삭제처리위한  hidden-->
		 	    <input type="hidden" id="pop_file_sn" name="pop_file_sn" value="${dtlList.pop_file_sn}"><!-- 삭제처리위한  hidden-->
		 	    <input type="hidden" value="${dtlList.create_id}" id="create_id" name = "write_id" ><!-- 삭제처리위한  hidden-->
				<table class='bbs' cellspacing='0' summary='팝업명, 등록, 게시일자, 링크, 게시여부, 팝업이미지, 팝업내용'>
					<caption>게시글 제목</caption>
					<colgroup>
						<col width='15%' />
						<col width='35%' />
						<col width='15%' />
						<col width='35%' />
					</colgroup>
					<tbody>
						<tr>
							<th scope='row'>팝업명</th>
							<td colspan='3' class='subject'>${dtlList.pop_titl}</td>
						</tr>
						<tr>
							<th scope='row'>등록</th>
							<td>${dtlList.create_id} / ${dtlList.create_dttm.substring(0,10)}</td>
							<th scope='row'>게시일자</th>
							<td>${dtlList.pop_str_dt.substring(0,4)}-${dtlList.pop_str_dt.substring(4,6)}-${dtlList.pop_str_dt.substring(6,8)}  
							  ~ ${dtlList.pop_end_dt.substring(0,4)}-${dtlList.pop_end_dt.substring(4,6)}-${dtlList.pop_end_dt.substring(6,8)}</td>
							  
							  
						</tr>
						<tr>
							<th scope='row'>링크</th>
							<td><a href = "${dtlList.pop_link}"  target="_blank" >${dtlList.pop_link}</a></td>
							<th scope='row'>게시여부</th>
							<td>${dtlList.post_yn}</td>
						</tr>
						<tr>
							<th scope='row'>팝업 왼쪽 여백</th>
							<td>${dtlList.pop_left}</td>
							<th scope='row'>팝업 상단 여백</th>
							<td>${dtlList.pop_top}</td>
						</tr>
						<tr>
							<th scope='row'>팝업 세로 크기</th>
							<td>${dtlList.pop_width}</td>
							<th scope='row'>팝업 가로 크기</th>
							<td>${dtlList.pop_height}</td>
						</tr>
						<tr>
							<th scope='row'>팝업 오픈 페이지</th>
							<td>${dtlList.pop_page}</td>
							<th scope='row'>팝업 위치</th>
							<td>
								<c:choose>
									<c:when test="${dtlList.pop_pos == 'Y'}">
										팝업
									</c:when>
									<c:otherwise>
										레이아웃
									</c:otherwise>
								</c:choose> 
							</td>
						</tr>
						<tr>
							<th scope='row'>팝업이미지</th>  <!--  업로드 패스경로  -->
							
							<!-- 운영일때 -->
							<%--<td><img  width="200" height="200"  alt="팝업이미지" src = "<%= url.substring(0, url.length()-1)%>${dtlList.pop_file_path}/${dtlList.pop_file_conv_nm}"/></td> --%>
						
							<!-- 로컬일때  -->
							<td><img  width="200" height="200"  alt="팝업이미지" src = "${ctxt}${pathUrl}${dtlList.pop_file_conv_nm}"/></td>
								
							<th scope='row'>팝업내용</th>
						
							<td>${dtlList.pop_ctts}</td>
						</tr>
					</tbody>
				</table>
			 </form>
				
		</div>

		<div class="bbs_btn">
			<a href='${ctxt}/mng/pop/popList.do' class='btn02 btnR'><span>목록</span></a>
			<%-- <c:if test="${userVo.user_sn != null}">
				<sec:authorize ifAnyGranted="ROLE_ADMIN">
					<a  href="javascript:fn_del()" name="del_btn" class='btn02 btnR'><span>삭제</span></a>
						<a href="${ctxt}/mng/pop/popEdit.do?pop_sn=${dtlList.pop_sn}" name="upd_btn" class='btn01 btnR'><span>수정</span></a>
				</sec:authorize>
				<c:if test="${userVo.user_sn == dtlList.user_sn}">
					<sec:authorize ifNotGranted="ROLE_ADMIN" >
						<a  href="javascript:fn_del()" name="del_btn" class='btn02 btnR'><span>삭제</span></a>
						<a href="${ctxt}/mng/pop/popEdit.do?pop_sn=${dtlList.pop_sn}" name="upd_btn" class='btn01 btnR'><span>수정</span></a>
					</sec:authorize>
				</c:if>
			</c:if> --%>
			
			<a  href="javascript:fn_del()" name="del_btn" class='btn02 btnR'><span>삭제</span></a>
			<a href="${ctxt}/mng/pop/popEdit.do?pop_sn=${dtlList.pop_sn}" name="upd_btn" class='btn01 btnR'><span>수정</span></a>
		</div>

	


	</div>
	</div>
	
  
	
</body>
</html>