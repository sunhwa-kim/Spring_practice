<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<style type="text/css">
#paging{text-align:center;}
a.paging-item,a.paging-side{margin:0 .25em;}
a.paging-item.selected{font-weight:bold;}
</style>
		
<%-- 메뉴 코드 부분 --%>
<title>기관관리 | 정부출연연구기관 채용정보서비스</title>

<link href="${ctxt}/resources/css/tree/jquery.treeview.css" rel="stylesheet" type="text/css">
<link href="${ctxt}/resources/css/tree/code.css" rel="stylesheet" type="text/css">
<link href="${ctxt}/resources/css/ras.css" rel="stylesheet" type="text/css">
</head>

<body>
<div id="container">

<div id="content">


<script type="text/javascript">
var xmlList;
var html="";
var isChange = false;


$(function(){
	if($("#messege").val() != ''){
	    fn_alert( $("#messege").val());
	}
	
    $("#messege").val('');
    $("#saveType").val('');
    // 저장후에 저장된 기관코드 받아서... 재조회..
    if($("#result_org_cd").val() != ''){
    	fn_setOrg($("#result_org_cd").val());
	}else{
		fn_setOrg($('li[class=sub_tab_3] > a:first').attr('id'));
		
	}
    
	$('#search_btn').on('click',function(){fn_search()});
	$('#search_cd').on('keyup',function(e){if(e.which  == 13){ fn_search()} });
	
	

});

	/*
	*  기관선택 이벤트
	*/
	function fn_setOrg(orgCd){
		
		$('li[class=sub_tab_3] > a').attr('style','');
		$('li[class=sub_tab_3] > a[id='+orgCd+']').attr('style','color:red');
	
	    $('input[name=org_tag]').each(function(){
			  $(this).prop('checked',false);
		});
	    
		    $.ajax({
	        url: '${ctxt}/mng/org/selectOrg.do',
	        data : {"org_cd":orgCd },
	        type: 'GET',
	        contentType: "text/xml;charset=utf-8",
	        dataType: 'text',
	        success: function(rtnXml) {
	        	var xmlObj = $(rtnXml).find('item');
	
				if(xmlObj.length > 0){
					xmlObj.each(function(){
				    $('#org_cd').val($(this).find("org_cd").text());
				    $('#org_name').val($(this).find("org_name").text());
				    $('#org_titl').val($(this).find("org_titl").text());
				    $('#org_titl2').val($(this).find("org_titl2").text());
				    $('#org_smy').val($(this).find("org_smy").text());
				    $('#org_url').val($(this).find("org_url").text());
				    $('#org_vcr_url').val($(this).find("org_vcr_url").text());
				    $('#org_img_path').val($(this).find("org_img_path").text());
				    $('#org_year').val($(this).find("org_year").text());
				    $('#org_site').val($(this).find("org_site").text());
				    $('#org_tel').val($(this).find("org_tel").text());
				    $('#org_hr').val($(this).find("org_hr").text());
				    $('#org_file_nm').html('<a id="downLoad_file">'+ $(this).find("emp_info_file_nm").text()+'</a>' );
				    $('#param_file_nm').val($(this).find("emp_info_file_nm").text());
				    $('#emp_info_file_sn').val($(this).find("emp_info_file_sn").text());
				    
						if($("#param_file_nm").val() == ''){
							$("#del_btn").hide();
	
							$("#uploadFile").attr("disabled", false);
						}else{
							$("#del_btn").show();
						
							$("#uploadFile").attr("disabled", true);
						} 
						
					});
				
				   
				}else{
					$('#org_cd').val(orgCd);
				    $('#org_name').val($('a[id='+orgCd).parent().text());
				    $('#org_titl').val('');
				    $('#org_titl2').val('');
				    $('#org_smy').val('');
				    $('#org_url').val('');
				    $('#org_vcr_url').val('');
				    $('#org_img_path').val('');
				    $('#org_year').val('');
				    $('#org_site').val('');
				    $('#org_tel').val('');
				    $('#org_hr').val('');
				    $('#org_file_nm').text('');
				
				}
	
	        },
	        error: function(x, o, e) {
		            var msg = "페이지 호출 중 에러 발생 \n" + x.status + " : " + o + " : " + e; 
		            fn_alert(msg); 
		    }            
	    }); 
	    
		  
	    
	}
	
	function fn_changeType(){
		
		$("#saveType").val("U");
		
	}
	
	/*
	*  기관정보 저장
	*/
	function fn_save(){
																						
		if ($("#saveType").val() =='U' || $("#uploadFile").val()!="" || $("#downLoad_file").val()== undefined ){
			if(confirm("저장하시겠습니까?") ==true ){
				var form = document.orgVo;
				form.action = '${ctxt}/mng/org/saveOrg.do';
				form.submit();	
			}
		}else{
			
			fn_alert("수정된 내역이 없습니다." , "c");
		}
	}
	
	
	function fn_pop(){
		var strUrl = $('#org_url').val();
		
		if(strUrl == ''){
			fn_alert("url정보가 없습니다.",'c')
			return;
		}
		
		window.open(strUrl);
	}
	
	/**
	*  조회 이벤트
	*/
	function fn_search(){
	
		var cd_nm = $('#search_cd').val();
		if(cd_nm != ''){
			$('.sub_tab_3 > li').each(function(){
				if($(this).text().indexOf(cd_nm) != -1){
					fn_setOrg($(this).find('a').attr('id'))
					return false;
				}
			});
		}
	}
	
	function fn_fileDel(){	
		$("#downLoad_file").remove();
		$("#emp_info_file_del").val("del_file");
		$("#del_btn").hide();
		$("#uploadFile").attr("disabled", false);
	}	
			
</script>

<!--  삭제버튼 처리를 위한 hidden --> 
<input type="hidden" value="" id="param_file_nm" > 

<h2><spring:message code="menu.mng.institutesMgmt" /></h2>
	<div class="admin_left" style="width: 35%; height:660px;">
		<section>
		<br />
		<h5 class="title" style="margin-top:0% !important;">기관정보</h5>
		
			<div style="margin-left: 20px;"><label for="search_cd">기관명 :</label> 
				<input type="text" id="search_cd" value="" /> 
				<input type="button" id="search_btn" name="search_btn" value="조회" />
			</div>
			<br />
			<ul class="sub_tab_3">
				<c:forEach items="${org_cd_list}" var="org_cd" varStatus="">
					<li class="sub_tab_3"><a href="javascript:fn_setOrg('${org_cd.cd}');" id="${org_cd.cd}">${org_cd.cd_nm}</a></li>
				</c:forEach>             
			</ul>
			<br />
		</section>
	</div>
	<div class="admin_right" style="width: 60%;" >
	  <input type="hidden" id="messege" name="messege" value="${messege}">
	  <input type="hidden" id="result_org_cd" name="result_org_cd" value="${OrgVo.org_cd}">
	  <input type="hidden" name="saveType" id="saveType" value="" />
		<section>
			<form id="orgVo" name="orgVo" action="" method="post" enctype="multipart/form-data">				
				<input type="hidden" value="" id="emp_info_file_del" name = "emp_info_file_del" >  <!-- 파일삭제수정을 위해서.. -->
 		  		<input type="hidden" value="" id="emp_info_file_sn" name = emp_info_file_sn  > <!-- 파일수정을 위해서.. -->
				<input type="hidden" name="org_cd" id="org_cd" value="" />
				<table class="table-a">
				<colgroup>
		            <col width="20%" />
		            <col width="80%" />
		         </colgroup>
					<tr>
						<th>
							<label for="org_name">기관명</label>
						</th>
						<td class="left">
							<input type="text" readonly="readonly" name="org_name" id="org_name" style="border: 1px solid; margin-left: 5px; width: 95%;"  />
						</td>
					</tr>
					<tr>
						<th>
							<label for="org_name">제목</label>
						</th>
						<td class="left">
							<input type="text" name="org_titl" id="org_titl" style="border: 1px solid; margin-left: 5px; width: 95%;" onchange="fn_changeType()" />
						</td>
					</tr>
					<tr>
						<th>
							<label for="org_name">제목2</label>
						</th>
						<td class="left">
							<input type="text" name="org_titl2" id="org_titl2" style="border: 1px solid; margin-left: 5px; width: 95%;" onchange="fn_changeType()" />
						</td>
					</tr>
					<tr>
						<th><label for="org_url">홈페이지 URL</label></th>
						<td class="left">
							<input type="text" name="org_url" id="org_url" style="border: 1px solid; margin-left: 5px; width: 95%;" onchange="fn_changeType()"  />
						 	<!-- <input type="button" onclick="fn_pop();" name="search_btn" value="이동" /> -->
						</td>
					</tr>
					<tr>
						<th><label for="org_vcr_url">기관 홍보 영상 URL</label></th>
						<td class="left">
							<input type="text" name="org_vcr_url" id="org_vcr_url" style="border: 1px solid; margin-left: 5px; width: 95%;"  onchange="fn_changeType()" />
			
						</td>
					</tr>
					<tr>
						<th><label for="org_img_path">기관이미지경로</label></th>
						<td class="left">
							<input type="text" name="org_img_path" id="org_img_path" style="border: 1px solid; margin-left: 5px; width: 95%;" onchange="fn_changeType()" />
				
						</td>
					</tr>
					<tr>
						<th>설립목적/주요사업</th>
						<td class="left">
							<textarea id="org_smy" name="org_smy" class="i_text" style="border: 1px solid #a9a9a9; margin-left: 5px; width: 95%;" rows="10"  title="팝업 내용"  onchange="fn_changeType()" ></textarea>
						</td>
					</tr>	
					<tr>
						<th>인재상</th>
						<td class="left">
							<textarea id="org_hr" name="org_hr" class="i_text" style="border: 1px solid #a9a9a9; margin-left: 5px; width: 95%;" rows="10"  title="팝업 내용"  onchange="fn_changeType()" ></textarea>
						</td>
					</tr>
					<tr>
						<th><label for="org_year">설립연도</label></th>
						<td class="left">
							<input type="text" name="org_year" id="org_year" style="border: 1px solid; margin-left: 5px; width: 95%;" maxlength="4" onchange="fn_changeType()" />
						
						</td>
					</tr>	
					<tr>
						<th><label for="org_site">위치(본원)</label></th>
						<td class="left">
							<input type="text" name="org_site" id="org_site" style="border: 1px solid; margin-left: 5px; width: 95%;" onchange="fn_changeType()" />
						
						</td>
					</tr>	
					<tr>
						<th><label for="org_tel">대표전화</label></th>
						<td class="left">
							<input type="text" name="org_tel" id="org_tel" style="border: 1px solid; margin-left: 5px; width: 95%;" maxlength="12" onchange="fn_changeType()" />
				
						</td>
					</tr>		
					<tr>
				        <th rowspan="2"><label for="org_empinfo">고용정보 <br/> 안내이미지</label></th>
				        <td class="left">
							<span id="org_file_nm" class="left" >
								
								<!-- <input type="text" name="org_file_nm" id="org_file_nm" style="border: 1px solid; margin-left: 5px; width: 95%;" readonly="readonly" /> -->
							</span>
								 	<button  type="button" id=del_btn  name= "del_btn" onclick="javascript:fn_fileDel()">삭제</button><br/> 
							 
				        </td>
			        </tr>												
	          	    <tr id = "fileRow">
			            <td id="uploadFiles"  class="left" >
			              <div class="fileDiv">
				              <input type="file"  class="uploadFile" id="uploadFile" name="uploadFile" onchange="javascript:fileCheck(this , 30 , 'pop');"  style=" margin-left: 5px; width: 95%;" />
			              </div>
			            </td>
         			</tr>		
         						
				</table>
				<!-- <span class="align_r"> -->
				<div align="right">
					<input type="button" onclick="fn_save()" name="save_btn" value="저장" />
				</div>
				<!-- </span> -->
			</form>
		</section>
	</div>
	<div class="clear"></div>
	</div>
	</div>
</body>
</html>