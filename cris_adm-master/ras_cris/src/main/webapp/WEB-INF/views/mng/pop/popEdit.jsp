<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>팝업수정 | 정부출연연구기관 채용정보서비스</title>
</head>
<body>
<script type="text/javascript" src="${ctxt}/resources/smartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
$(function(){
    
	var str = $('#param_post_yn').val(); 
    
	if (  str =='Y'){
		 $('input[name=post_yn][value=Y').prop('checked',true);
		 $('input[name=post_yn][value=N').prop('checked',false);
	}else{
		 $('input[name=post_yn][value=Y').prop('checked',false);
		 $('input[name=post_yn][value=N').prop('checked',true);
	}  
	
	
	if($("#messege").val() != ''){
	    alert( $("#messege").val());
	  }
	$("#messege").val('');
		
	
	 if($("#param_file_nm").val() == ''){
		$("#del_btn").hide();

		$("#uploadFile").attr("disabled", false);
	}else{
		$("#del_btn").show();
	
		$("#uploadFile").attr("disabled", true);
	} 

	cmmfn_set_datepicker($("#pop_str_dt"), "yy-mm-dd");
	cmmfn_set_datepicker($("#pop_end_dt"), "yy-mm-dd");
});

	//저장
	function fn_save(){
		
	  
		
		var str_dt = $("#pop_str_dt").val();
		var end_dt = $("#pop_end_dt").val();
		var pop_titl = $("#pop_titl").val();
		var pop_ctts = $("#pop_ctts").val();
		var pop_link = $("#pop_link").val();
	
		if(pop_titl == ""){
			alert("팝업명을 입력해주십시오 ","c");
			$("#pop_titl").focus();
			
			return ;
		}
		
		if(str_dt == "" ){
			alert("시작일자를 입력해주십시오 ","c");
			$("#pop_str_dt").focus();
			 
			return ;
		}
		if(end_dt == "" ){
			alert("종료일자를 입력해주십시오 ","c");
			$("#pop_end_dt").focus();
			return ;
		}
		
		if(str_dt > end_dt ){
			alert("종료일자(to)보다 시작일자(from)가 클수 없습니다.","c");
			
			return;
		} 		
		
		if($("#uploadFile").val() =="" && $("#file_del").val()!=""){
			alert("첨부파일을 입력해 주십시오.","c");
		
			return;
		} 
		
		
		var form  = document.form;
		
		
		
		form.action = '${ctxt}/mng/pop/updatePop.do';
		form.submit();
	}
	
	
	
	// 첨부 파일 다운로드
	function fn_downLoad(){		
		var downform = document.downForm;
		downform.action = '${ctxt}/mng/pop/downFile.do';
		downform.submit();
	}

	function fn_fileDel(){	
		$("#downLoad_file").remove();
		$("#file_del").val("del_file");
		$("#del_btn").hide();
		$("#uploadFile").attr("disabled", false);
	}
	
	
	</script>
<!--  게시여부를 위한 hidden --> 
<input type="hidden" value="${dtlList.post_yn}" id="param_post_yn" >
<!--  삭제버튼 처리를 위한 hidden -->   
<input type="hidden" value="${dtlList.pop_file_nm}" id="param_file_nm" > 
<!--  메세지처리를 위한 hidden -->
 <input type="hidden" id="messege" name="messege" value="${messege}">
<!--    파일 다운로드 처리위한form -->
<form id= "downForm" name=  "downForm" action ="" method="post"  enctype="multipart/form-data">
<input type="hidden" value="${dtlList.pop_file_sn}" id="down_file_sn" name = "pop_file_sn"  > 
<input type="hidden" value="${dtlList.pop_sn}" id="down_pop_sn" name = "pop_sn" >

</form>

 <div id="container">
		<div id="content">

		<h2>팝업관리</h2>
		<div class='bview'>
		
		 <form id="form" name="form" action="" method="post" enctype="multipart/form-data">
		
			 <!-- 수정form 날리기위한 hidden-->
			 <input type="hidden" value="${dtlList.pop_sn}" id="pop_sn" name = "pop_sn" >
			 <input type="hidden" value="${dtlList.pop_file_sn}" id="file_sn" name = pop_file_sn  > <!-- 파일수정을 위해서.. -->
			 <input type="hidden" value="${dtlList.create_id}" id="chk_create_id" name = "write_id" > <!-- 파일수정을 위해서.. -->
			 <input type="hidden" value="" id="file_del" name = "file_del" ><!-- 파일삭제수정을 위해서.. -->
				<table class='bbs' cellspacing='0' summary='제목, 게시기간, 게시여부, 링크, 팝업내용, 첨부파일'>
					<caption>팝업등록</caption>
					<colgroup>
						<col width='15%' />
						<col width='35%' />
						<col width='15%' />
						<col width='35%' />
					</colgroup>
					<tbody>
						<tr>
							<th scope='row'>팝업명</th>
							<td colspan='3' >  
							
								<input id="pop_titl" name="pop_titl" class="full"  type="text" value="${dtlList.pop_titl}" title="제목"/>		
											
							</td>
						</tr>
						<tr>
							<th scope='row'>게시일자</th>
							<td>
								<div class="item">
				
									  <input type="text"  id="pop_str_dt"  name="pop_str_dt"  style="width:70px" maxlength="8" onblur="javascript:fn_validDate(this)"
									  value ="${dtlList.pop_str_dt.substring(0,4)}-${dtlList.pop_str_dt.substring(4,6)}-${dtlList.pop_str_dt.substring(6,8)}" >
									   -  <input type="text"  id="pop_end_dt"  name ="pop_end_dt"  style="width:70px" maxlength="8" onblur="javascript:fn_validDate(this)"
									   value ="${dtlList.pop_end_dt.substring(0,4)}-${dtlList.pop_end_dt.substring(4,6)}-${dtlList.pop_end_dt.substring(6,8)}" >

								  
								</div>
							</td>

						    <th scope='row'>게시여부</th>
							<td>
								<div class="item">
									<input class="i_radio" id="post_yn" name="post_yn"   type="radio"  value ="Y" title="게시여부" 	/>
									<label for="c1" title="예">예</label> 
									<input class="i_radio" id="post_yn" name="post_yn" type="radio" value ="N"  title="게시여부" />
									<label for="c2" title="아니오">아니오</label> 
								</div>
							</td>

						</tr>
						<tr>
							<th scope='row'>링크</th>
							<td colspan = '3'>
							<input id="pop_link" name="pop_link" type="text"   class="full"  value="${dtlList.pop_link}"  title="링크"/>
							</td>
						
						</tr>
						<tr>
							<th scope='row'>팝업 왼쪽 여백</th>
							<td >
							<input id="pop_left" name="pop_left" type="text"   class="full"  value="${dtlList.pop_left}"  title="팝업 왼쪽 여백"/>
							</td>
							<th scope='row'>팝업 상단 여백</th>
							<td >
							<input id="pop_top" name="pop_top" type="text"   class="full"  value="${dtlList.pop_top}"  title="팝업 상단 여백"/>
							</td>
						</tr>
						<tr>
							<th scope='row'>팝업 세로 크기</th>
							<td >
							<input id="pop_width" name="pop_width" type="text"   class="full"  value="${dtlList.pop_width}"  title="팝업 세로 크기"/>
							</td>
							<th scope='row'>팝업 가로 크기</th>
							<td >
							<input id="pop_height" name="pop_height" type="text"   class="full"  value="${dtlList.pop_height}"  title="팝업 가로 크기"/>
							</td>
						</tr>
						<tr>
							<th scope='row'>팝업 오픈 페이지</th>
							<td >
							<input id="pop_page" name="pop_page" type="text"   class="full"  value="${dtlList.pop_page}"  title="팝업 오픈 페이지"/>
							</td>
							<th scope='row'>팝업 위치</th>
							
							<td >
	
							<div class="item">
									<input class="i_radio" id="pop_pos1" name="pop_pos"   type="radio"  value ="Y" ${dtlList.pop_pos eq 'Y' ? 'checked="checked"':''}title="팝업 " 	/>
									<label for="c1" title="팝업">팝업</label> 
									<input class="i_radio" id="pop_pos2" name="pop_pos" type="radio" value ="N"  ${dtlList.pop_pos eq 'N' ? 'checked="checked"':''} title="레이아웃" />
									<label for="c2" title="레이아웃">레이아웃</label> 
								</div>
							</td>
						</tr>
						<tr>
							<th scope='row'>팝업내용</th>
							<td colspan = '3'>
								<div class="item">
									<textarea id="pop_ctts" name="pop_ctts" rows="10" style= "width:98%;" title="팝업 내용" >${dtlList.pop_ctts}</textarea>

								</div>
							</td>
						</tr>
						<tr>
					        <th scope="row">파일</th>
					        <td colspan="3" >
								<span>
									<a href="#none"  id="downLoad_file" onclick="javascript:fn_downLoad()" >${dtlList.pop_file_nm}</a>
								</span>
										<button  type="button" id=del_btn  name= "del_btn" onclick="javascript:fn_fileDel()">삭제</button><br/>
								 
					        </td>
				        </tr>
			          	<tr id = "fileRow">
				            <th style="vertical-align:top;" class="addFileBtn">첨부파일</th>
				            <td id="uploadFiles" colspan="3">
				              <div class="fileDiv">
					              <input type="file"  class="uploadFile" id="uploadFile" name="uploadFile" onchange="javascript:fileCheck(this , 30 , 'pop');"  style="width:88% ;display:inline;" />
				              </div>
				            </td>
	          			</tr>
						
					</tbody>
				</table>
			
		</form>		
			</div>

		<div class="bbs_btn">
			<a href='${ctxt}/mng/pop/popList.do' class='btn02 btnR'><span>취소</span></a>
			<a href='javascript:fn_save()'  class='btn01 btnR' name = 'save_btn'><span>저장</span></a>
		</div>

	


	</div>
	</div>
  	
  	
	
</body>
</html>