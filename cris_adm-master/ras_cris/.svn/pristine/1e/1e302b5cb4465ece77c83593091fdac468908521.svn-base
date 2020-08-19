<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
function fn_search1(){
	//var keyword = $("#detailInput1").val(); + "" + $("#detailInput2").val(); +""+ $("#detailInput3").val();

	var keyword1 = $("#detailInput1").val();
	var keyword2 = $("#detailInput2").val();
	var keyword3 = $("#detailInput3").val();
	var keyword = keyword1+keyword2+keyword3;
	
	if(keyword==""){
		alert("검색어를 입력해주세요");
	}else{
		$("#writeForm").submit();	
	}
	
}
</script>

<style>
#content{
	float:none;
}

</style>
<head>
</head>
	<div id="detailed_search">
		<div id="detailed_search_box">
			<div class="ds_head">
				<p class="title">상세검색</p>
			</div>
			<div class="ds_body">
				<div class="detail_searchFrm">
					<form id="writeForm" name="writeForm" method="post" action="${ctxt}/search/search.do">
						<input type="hidden" id="detailYn" name="detailYn" value="Y" />						 	  
						<table class="detail_searchFrm_table" style="border-bottom: none">
							<colgroup>
								<col style="width:20%">
								<col style="width:65%">
								<col style="width:15%">
							</colgroup>
							<tbody>
								<tr>
									<th class="text">자료유형</th>
								   	<td colspan="2" style="padding-left:10px;">
										<dl class="detailSrch_location">
											<dd> 
												<input type="radio" name="searchTarget" id="inkorea" value="inkorea" class="center_radio_04 radio"> <label for="" class="center_text_04">국내학술논문</label> 
											    <input type="radio" name="searchTarget" id="archive" value="archive" class="center_radio_04 radio"> <label for="" class="center_text_04">아카이브</label>
											    <input type="radio" name="searchTarget" id="book" value="book"  class="center_radio_04 radio"> <label for="" class="center_text_04">소장자료</label>
												<input type="radio" name="searchTarget" id="" value="" class="center_radio_04 radio"> <label for="" class="center_text_04">pubmed</label>
												<input type="radio" name="searchTarget" id="" value="" class="center_radio_04 radio"> <label for="" class="center_text_04">전자자원</label>                	  
										   </dd>
								 		</dl>
									</td>
								</tr>
								<tr>    
									<th>  
										<select name="searchCondition1" id="" class="select1" title="">
											<option value="title">제목</option>
											<option value="author">저자</option>
											<option value="publisher">발행기관</option>
										</select>
									</th>
									<td>
										<input type="text" id="detailInput1" name="detailInput1" class="input2" value=""  title="첫번째 검색단어입력">
									</td>
									<td>
										<select id="" name="selectOption1" class="select2" title="첫번째 검색조건">
											<option value="and">AND</option>
											<option value="or">OR</option>
											<option value="not">NOT</option>
									    </select>
									</td>
								</tr>
								<tr>
								  	<th> 
								    	<select name="searchCondition2" id="" class="select1" title="">
								    		<option value="author">저자</option>
											<option value="title">제목</option>
											<option value="publisher">발행기관</option>
								  		</select>
									</th>
									<td>
										<input type="text" name="detailInput2" id="detailInput2" class="input2" value="" title="두번째 검색단어입력">
									</td>
									<td>
										<select id="" name="selectOption2" class="select2" title="두번째 검색조건">
											<option value="and">AND</option>
											<option value="or">OR</option>
											<option value="not">NOT</option>
										</select>
									</td>
								</tr>
								<tr>
							  		<th> 
							     		<select name="searchCondition3" id="" class="select1" title="세번째 검색선택">
							     			<option value="publisher">발행기관</option>
											<option value="author">저자</option>
											<option value="title">제목</option>
							  			</select>
									</th>
									<td>
										<input type="text" name="detailInput3" id="detailInput3" class="input2" value="" title="세번째 검색단어입력">
									</td>
									<td>
										<select id="" name="selectOption3" class="select2" title="세번째 검색조건">
											<option value="and">AND</option>
											<option value="or">OR</option>
											<option value="not">NOT</option>
										</select>
									</td>
								</tr> 
							    <tr> 
							    	<th class="text">발행년도</th>
							      	<td>
								    	<input type="text" maxlength="8" id="" title="" name="startDate" onblur="" class="date_cl"> 
								    	<span class="date_sp_cl">년 부터</span>										
										<input type="text" maxlength="8" id="" title="" name="endDate" onblur="" class="date_cl">
									</td>
								</tr>
								<tr>
									<th class="text">표준부호</th>
									<td>
										<select id="" name="" class="is_cl" title="">
											<option value="">ISBN</option>
											<option value="">ISSN</option>
										</select>
										<input type="text" id="" title="" name="" class="is_cl_in">
									</td>
								</tr>
								<tr style="border-bottom: 1px solid rgba(51,122,183,0.5);">
									<th class="text">분류기호</th>
									<td>
										<select id="" name="" class="is_cl" title="">
											<option value="">KDC</option>
											<option value="">NLMC</option>
										</select>
										<input type="text" id="" title="" name="" class="is_cl_in">
									</td>
									<td>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="btn-group">
							<div class="dschBtn">
								<button type="button" id="writeFormSubmit" class='sch_smit' onclick="fn_search1()">검색</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


