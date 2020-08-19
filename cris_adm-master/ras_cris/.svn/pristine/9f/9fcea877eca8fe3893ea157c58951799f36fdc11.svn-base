<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>팝업신규등록 | 정부출연연구기관 채용정보서비스</title>
</head>
<body>
<script type="text/javascript">
$(function(){
	cmmfn_set_datepicker($("#pop_str_dt"), "yy-mm-dd");
	cmmfn_set_datepicker($("#pop_end_dt"), "yy-mm-dd");
});
	
	//수정
	function fn_save(){
	    
		var str_dt = $("#pop_str_dt").val();
		var end_dt = $("#pop_end_dt").val();
		var pop_titl = $("#pop_titl").val();
		var pop_link = $("#pop_link").val();
		var uploadFile = $("#uploadFile").val();
		
		if(pop_titl == ""){
			alert("팝업명을 입력해주십시오 ");
			$("#pop_titl").focus();
			return ;
		}
		
		if(str_dt == "" ){
			alert("시작일자를 입력해주십시오 ");
			 $("#pop_str_dt").focus();
			return ;
		}
		if(end_dt == "" ){
			alert("종료일자를 입력해주십시오 ");
			 $("#pop_end_dt").focus();
			return ;
		}
		if(str_dt > end_dt ){
			alert("종료일자(to)보다 시작일자(from)가 클수 없습니다.");
			
			return;
		}
		
 		if(pop_link == ""){
			alert("링크를 입력해주십시오 ");
			$("#pop_link").focus();
			return;
		}
		
		if(uploadFile == ""){
			alert("첨부파일을 입력해주십시오 ");
		
			return;
		} 
		
		
		var form  = document.form;
		
		
		
		form.action = '${ctxt}/mng/pop/insertPop.do';
		form.submit();
	}
	
	//  한글 유효성 체크
	/* function fn_dateChk(obj){
		var str = $(obj).val();
		if(str != ""){
		fn_validDate(obj);
		}
		
		var judge = false; 
		for(var i = 0; i < str.length; i++) { 
			var chr = str.substr(i,1); 
			chr = escape(chr); 
			if (chr.charAt(1) == "u") { 
				chr = chr.substr(2, (chr.length - 1)); 
				if((chr >= "3131" && chr <= "3163") || (chr >= "AC00" && chr <= "D7A3")) { 
				
					judge = true; 
					fn_alert("한글은 입력할 수 없습니다.","c");
					$(obj).val("");
					$(obj).focus();
				return false; 
				} 
			} 
		
		} 
	} */
	</script>


 <div id="container">
		<div id="content">

		<h2>팝업관리</h2>


		<div class='bview'>
		
		 <form id="form" name="form" action="" method="post" enctype="multipart/form-data">
				<table class='bbs' cellspacing='0' summary='제목, 게시기간, 게시여부, 링크, 팝업내용, 첨부파일'>
					<caption>팝업등록</caption>
					<colgroup>
						<col width='13%' />
						<col width='*' />
						<col width='13%' />
						<col width='*%' />
					</colgroup>
					<tbody>
						<tr>
							<th scope='row'>팝업명</th>
							<td colspan='3'>   
							  <div  class="item">
								<input id="pop_titl" name="pop_titl"   class="full"  type="text"  title="제목"/>		
							  </div>					
							</td>
						</tr>
						<tr>
							<th scope='row'>게시시간</th>
							<td>
								<div class="item">
									
							    <label for="pop_str_dt" class="hide"><!-- 시작일: --></label><input type="text" style="width:70px;"  maxlength="8" id="pop_str_dt"  title="시작일자" name="pop_str_dt" onblur="javascript:fn_validDate(this)" >
								   ~ &nbsp; <label for="pop_end_dt" class="hide"><!-- 종료일: --></label><input type="text" style="width:70px;" maxlength="8" id="pop_end_dt" title="종료일자"  name ="pop_end_dt" onblur="javascript:fn_validDate(this)">

								</div>
							</td>

						    <th scope='row'>게시여부</th>
							<td>
								<div class="item">
									<input class="i_radio"  name="post_yn"   type="radio"  value ="Y" title="게시여부" 	checked/>
									<label for="c1" title="예">예</label> 
									<input class="i_radio"  name="post_yn" type="radio" value ="N"  title="게시여부" />
									<label for="c2" title="아니오">아니오</label> 
								</div>
							</td>
						</tr>
						<tr>
							<th scope='row'>링크</th>
							<td colspan = '3'>
								<input id="pop_link" name="pop_link"  type="text"   class="full" title="링크"/>
							</td>
						</tr>
						<tr>
							<th scope='row'>팝업 왼쪽 여백</th>
							<td >
								<input id="pop_left" name="pop_left" type="text"   class="full" title="팝업 왼쪽 여백"/>
							</td>
							<th scope='row'>팝업 상단 여백</th>
							<td >
								<input id="pop_top" name="pop_top" type="text"   class="full"    title="팝업 상단 여백"/>
							</td>
						</tr>
						<tr>
							<th scope='row'>팝업 세로 크기</th>
							<td >
								<input id="pop_width" name="pop_width" type="text"   class="full"   title="팝업 세로 크기"/>
							</td>
							<th scope='row'>팝업 가로 크기</th>
							<td >
								<input id="pop_height" name="pop_height" type="text"   class="full"  title="팝업 가로 크기"/>
							</td>
						</tr>
						<tr>
							<th scope='row'>팝업 오픈 페이지</th>
							<td >
								<input id="pop_page" name="pop_page" type="text"   class="full"    title="팝업 오픈 페이지"/>
							</td>
							<th scope='row'>팝업 위치</th>
							<td >
								<div class="item">
									<input class="i_radio" id="pop_pos1" name="pop_pos"   type="radio"  value ="Y" checked title="팝업 " 	/>
									<label for="c1" title="팝업">팝업</label> 
									<input class="i_radio" id="pop_pos2" name="pop_pos" type="radio"   value ="N" title="레이아웃" />
									<label for="c2" title="레이아웃">레이아웃</label> 
								</div>
							</td>
						</tr>
						
						<tr>
							<th scope='row'>팝업내용</th>
							<td colspan = '3'>
								<div class="item">
									<textarea id="pop_ctts" name="pop_ctts"  rows="10"  style= "width:98%;" title="팝업 내용" ></textarea>								
					 			</div>
							</td>
						</tr>
					
			          	<tr>
				            <th style="vertical-align:top;" class="addFileBtn">첨부파일</th>
				            <td id="uploadFiles" colspan="3">
				              <div class="fileDiv">
					             <label for="uploadFile" class="hide">파일첨부하기</label>
					              <input onchange="javascript:fileCheck(this, 30 , 'pop');"  type="file" class="uploadFile" id="uploadFile" name="uploadFile" style="width:88% ;display:inline;" />
				              </div>
				            </td>
	          			</tr>
						
					</tbody>
				</table>
			
		</form>		
			</div>
		<div class="bbs_btn">
			<a href='${ctxt}/mng/pop/popList.do' class='btn02 btnR'><span>취소</span></a>
			<a href='javascript:fn_save()'  class='btn01 btnR' name ='save_btn' ><span>저장</span></a>
		</div>
	</div>
	</div>
</body>
</html>