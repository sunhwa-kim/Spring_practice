<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<script type="text/javascript">

var html= "";
var xmlList= "";
var totCnt = 0;
var exUploadChk = false;
var searchBool = false;

$(function() {

		$("#dialog").dialog({ 
			//이벤트 발생했을때 보여주려면 autoOpen : false로 지정해줘야 한다.
			autoOpen: false, 
			//레이어팝업 넓이 
			width: 900, 
			height : 900,
			//뒷배경을 disable 시키고싶다면 true 
			modal: true, 
			//버튼종류
			buttons: [ { 
				//버튼텍스트 
				text: "Ok",
				//클릭이벤트발생시 동작
				click: function() { 
					$( this ).dialog( "close" );
					} 
			}, 
			{ 
				//버튼텍스트
				text: "Cancel", 
				//클릭이벤트발생시 동작 
				click: function() {
					$( this ).dialog( "close" ); 
					} 
			} 
			]
		});

});


function fn_openPop(busino,proj_tit_kor,proj_tit_eng,pi, 
		org_name,pubyear,subject,atch_link_id, error_cn){
	
	//var excel_upload_err_chk = "";
	//excel_upload_err_chk = excel_upload_err; // 파일 chk
	
	var num_chk = /^[0-9]+$/;
	var err_cont = ""; // 에러내용 담는곳
	var dhtml = "";

	
	dhtml += '<tr height="50px;">';
	dhtml += '<th scope="row">과제번호</th>'
	
	dhtml += ' <td style="text-align:center">' + busino + '</td>';  
	
	dhtml += '</tr>';
		
	dhtml += '<tr height="50px;">';
	dhtml += '<th scope="row">연구과제명_국문</th>'
		
	dhtml += ' <td style="text-align:center">' + proj_tit_kor + '</td>';  				

	dhtml += '</tr>';

	dhtml += '<tr height="50px;">';
	dhtml += '<th scope="row">연구과제명_영문</th>'	
	dhtml += ' <td style="text-align:center">' + proj_tit_eng + '</td>';  					
	dhtml += '</tr>';
		
	dhtml += '<tr height="50px;">';
	dhtml += '<th scope="row">책임연구원</th>'
	dhtml += ' <td style="text-align:center">' + pi + '</td>';  				
	dhtml += '</tr>';	

	dhtml += '<tr height="50px;">';
	dhtml += '<th scope="row">발행자</th>'	
	dhtml += ' <td style="text-align:center">' + org_name + '</td>';  				
	dhtml += '</tr>';
		
	dhtml += '<tr height="50px;">';
	dhtml += '<th scope="row">발행년도</th>'
	dhtml += ' <td style="text-align:center">' + pubyear + '</td>';  					
	dhtml += '</tr>';	

	dhtml += '<tr height="50px;">';
	dhtml += '<th scope="row">주제</th>'	
	dhtml += ' <td style="text-align:center">' + subject + '</td>';  					
	dhtml += '</tr>';
		
	dhtml += '<tr height="50px;">';
	dhtml += '<th scope="row">첨부파일키</th>'
	dhtml += ' <td style="text-align:center">' + atch_link_id + '</td>';  				
	dhtml += '</tr>';	

	dhtml += '<tr height="50px;">';
	dhtml +=    '<th scope="row">에러내용</th>'
	
	if(error_cn != ""){
		dhtml +=  "<td style='text-align:center'>"+ error_cn.substring( 0 , error_cn.length -1 ) +"</td>";
	}else{
		dhtml += '<td></td>';
	}	
	dhtml += '</tr>';
	
	$("#infoBody").html(dhtml);
	$("#dialog").dialog("open");
}


//엑셀 파일 업로드
function fn_ExcelUpload(){
	
	 if(exUploadChk == true){
		if(confirm("등록된 자료가 존재 합니다. 삭제하고 재등록 하시겠습니까?") ==false){				 
			 return;		 
		}
		
		$("#insertHtml").children().remove();
		$("#insertHtml").html('<tr><td colspan="4" align="center">엑셀 파일을 등록해 주십시오.</td></tr>');
		exUploadChk = false;
		totCnt = 0;
		
	
	 }
	
	var excelFileNames  =$('input[name=uploadFile]').val();
//	var zipFileNames  =$('input[name=uploadZipFile]').val();

	if(excelFileNames == undefined || excelFileNames.trim() == ''){
	   alert("파일을 선택하세요.");
	   return;
	}
	  
    var fileExt = excelFileNames.substring(excelFileNames.lastIndexOf(".")+1,excelFileNames.length);

    if(fileExt != "xls"){
       alert("양식 다운로드를 이용하여 작성된 엑셀(.xls)을 선택해주십시오.");
       return;
    }
   
	/* if(zipFileNames != undefined && zipFileNames.trim() != ''){
		var fileZip = zipFileNames.substring(zipFileNames.lastIndexOf(".")+1,zipFileNames.length);
		if(fileZip != "zip"){
		       alert(".zip 파일을 선택하세요");
		       return;
		    }
	}
    */
   var param = new FormData();
       param.append("uploadFile" ,  $("input[name=uploadFile]")[0].files[0]);
      // param.append("uploadZipFile" ,  $("input[name=uploadZipFile]")[0].files[0]);
       
   $.ajax({
       url: "${ctxt}/archive/report/reportExcelUpload.do" ,
       data: param,
       processData: false,
       contentType: false,
       type: 'POST',
       success: function(data){
    	
      	xmlList= "";
      	html = "";
       	xmlList = $(data).find('item');       	
   
       	if(xmlList.length > 0){
       		totCnt = xmlList.length;
       		
       		
       		
       		$("#insertHtml").children().remove();
       	
       		$("#uploadFile").val("");
			//$("#uploadZipFile").val("");
			
       		var resultMsg = $(data).find('resultVal').text();
       		if(resultMsg != ""){
       			if(resultMsg== "success"){
       				alert("자료가 정상적으로 등록되었습니다.");
       			}else if(resultMsg == "not"){
       				alert("입력된 자료가 존재하지 않습니다.");
       			}else if(resultMsg == "login"){
       				alert("로그인이 필요합니다.");
       			}else{
       				alert("자료가 등록되지 않았습니다.");
       			}
       			
       			$("#insertHtml").html('<tr><td colspan="4" align="center">엑셀 파일을 등록해 주십시오.</td></tr>');
       			
       		}else{
	       		xmlList.each(function(j){
	       			
      				var num_chk = /^[0-9]+$/;
					var obj = $(this);
	
					//var center_nm =obj.find('center_nm').text();
					
					//var charger_nm = obj.find('charger_nm').text();
					
					//var annual_gbn = obj.find('annual_gbn').text();
					//var annual_num = obj.find('annual_num').text();
					//var busi_nm = obj.find('busi_nm').text();
					//var detail_busi_nm = obj.find('detail_busi_nm').text();
					//var security_level = obj.find('security_level').text();
					//var security_rs = obj.find('security_rs').text();
					//var con_type = obj.find('con_type').text();
					//var private_rs = obj.find('private_rs').text();
					//var private_str_dt = obj.find('private_str_dt').text();
					//var private_end_dt = obj.find('private_end_dt').text();
					
					//var pi_dept = obj.find('pi_dept').text();
					//var rp = obj.find('rp').text();
					//var rp_dept = obj.find('rp_dept').text();
					//var order_dept = obj.find('order_dept').text();
					//var keyword_kor = obj.find('keyword_kor').text();
					//var keyword_eng = obj.find('keyword_eng').text();
					//var rep_abs = obj.find('rep_abs').text();
					var busino = obj.find('busino').text();
					var proj_tit_kor = obj.find('proj_tit_kor').text();
					var proj_tit_eng = obj.find('proj_tit_eng').text();
					var pi = obj.find('pi').text();
					var org_name = obj.find('org_name').text();
					var pubyear = obj.find('pubyear').text();
					var subject = obj.find('subject').text();
					var subject_nm = obj.find('subject_nm').text();
					var atch_link_id = obj.find('atch_link_id').text();
					var error_cn = obj.find('error_cn').text();
					
					
						
					// 첨부파일
					//var excel_upload = obj.find('excel_upload').text();		
					//var excel_upload_err = obj.find('excel_upload_err').text();			
					
					//if(rep_sj == ""){	 					
					//	rep_sj_chk = "<보고서명>";
					//}	
					
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					html += '<tr>'; 
					html += ' <td style="text-align:center">' + obj.find('rn').text() +'</td>'; 	

					
				 
				
					if(proj_tit_kor != ""){
						html += ' <td style="color:red;font-weight:bold;text-align:center">' + proj_tit_kor + '</td>';	
					}else{
						
						if(proj_tit_eng != ""){
							html += ' <td style="color:red;font-weight:bold;text-align:center">' + proj_tit_eng + '</td>';	
						}else{
							html += ' <td style="color:red;font-weight:bold;text-align:center">' + 'Null' + '</td>';
						}
						
					}
					
									
					html += '<td style="text-align:center">';					
					html += '<a href="javascript:fn_openPop(\''+busino+'\',\''+proj_tit_kor+'\',\''+proj_tit_eng+'\',\''+pi+'\', ';
					html += '\''+org_name+'\',\''+pubyear+'\',\''+subject_nm+'\',\''+atch_link_id+'\',\''+error_cn+'\' )">';						
					html += '<span class = "t5" title = "">상세보기</span>' + '</a></td>'; 	
					html += ' <td style="display:none"><span class="span_'+j+'"> </span></td>' 
					html += '</tr>';		
		
	       	});
	       		
	       		  exUploadChk = true;
	       		  $("#insertHtml").html(html);
       		}
       		
       	}else{
       		
      			$("#insertHtml").html('<tr><td colspan="4">조회 결과가 없습니다.</td></tr>');
       	}
       } ,
   	 error : function(){                              // Ajax 전송 에러 발생시 실행
   		 alert("자료가 등록되지 않았습니다.");
       }
   });
   
}



//업로드 정보 저장
function fn_egov_holiday_upload_save(){
	
	var list = [];
	var cnt=0;
	var reState = true;
	if(confirm("입력하신 내용을 저장하시겠습니까?") ==false)
		return;
	
	
	$('#holiday_upload tr').each(function(idx){
		if(idx > 0){
			var trObj = $(this);
			
			//데이터 조작이 없는 경우 처리안함
			if(trObj.find('td:eq(6)').text() != ""){
				reState  = false;
				//return false;
				
			}
		
			list[cnt] = { 
					"natn_holiday_no" : trObj.find('td:eq(1)').text() ,
					"yr" : trObj.find('td:eq(3)').text()  ,				
					"holiday_nm" : trObj.find('td:eq(4)').text(),
					"st_ymd" : trObj.find('td:eq(5)').text(),
					}	
		
			cnt++
		}
	});
	
	if(reState ==false){
		alert("에러내역이 존재합니다. 엑셀 파일을 다시 등록하여 주십시오.");
		
		return;
	}
	
	var sendList = {"list" : list};
	var resultList = JSON.stringify(sendList);
		
	//저장시작
	$.ajax({
	    url 		: g_context + "/modeholiday/xlsHolidaySave.do?srch_menu_nix=${param.srch_menu_nix}",
	    type  	: "POST",
	    data 		:{"dataList" : resultList},
		traditional : true,
		//contentType : "application/json;charset=UTF-8",
		//datatype	: "text",
     async: false,
     cache: false,
    // processData : false,
		success 	: function(data){     
	
			if(data == 300){
				alert("에러가 발생했습니다.");
				return false;
			}	
			alert("저장이 완료되었습니다.");
			
			$("#insertHtml").children().remove();
			$("#insertHtml").html('<tr><td colspan="4">엑셀 파일을 등록해 주십시오.</td></tr>');
			$("#uploadFile").val("");
			//$("#uploadZipFile").val("");
			exUploadChk = false;
		},
	    error: function(xhr, err){
			alert("에러가 발생했습니다. \n" + xhr.responseText);
	    }
	});
}

</script>


		
 <form id="reqForm" name="reqForm" action="" method="post" enctype="multipart/form-data">
	<div id="con" style="width: 100%;  position: relative;">
		<div class="sub_center_text">
	      	<div class="sub_center_nav"> 
				<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
				<span> > </span> 
				<span>아카이브</span>
				<span> > </span>
				<span>보고서</span>        
				<span> > </span>
				<span class="active">보고서 일괄등록</span>
			</div>
		    <span href="#" class="center_text_01">아카이브</span>
		</div> 		
		<div class="under_bar"></div>
		
		
		<div class = "content_wrap">
			<div class="content_box">
				<div class="content_list">
					<div id = "holiday_upload_list"  style="overflow:auto; width:100%; height:300px;" >		<!--holiday_upload_list STR 최초에 숨김  -->	
						<table class= "basic_table">
							<caption>보고서 일괄등록</caption>
						  	<colgroup>
								<col style="width:10%">			
								<col>
								<col style="width:10%">	
							</colgroup>  
							<thead>
								<tr>
									<th scope='col'>Line</th>	
									<th scope='col'>보고서 제목</th>				
									<th scope='col'>에러상세</th>					
								</tr>
							</thead>
							<tbody id = "insertHtml">
								<tr height="200px;"><td colspan="4" align="center">엑셀 파일을 등록해 주십시오.</td></tr>
							</tbody>
						</table>					
					</div>	<!-- holiday_upload_list div end -->	
	 		
	 		<div style="margin-top: 50px; margin-bottom: 50px;text-align: center;">
				<label for ="file">Excel File :</label> &nbsp;&nbsp;<input type="file" id="uploadFile" name="uploadFile" size="50">&nbsp;
		 	 	<!-- <label for ="file">Zip File  :</label>&nbsp;&nbsp;<input type="file" id="uploadZipFile" name="uploadZipFile" size="50">&nbsp; -->
			</div>	 	 
	 		<div class="btn-group">
	       		 <a href="javascript:fn_ExcelUpload()" class="basic-btn">XLS Upload</a>  	
				 <%-- <a href="${ctxt}/archive/report/xlsReportDownLoad.do" class="basic-btn">XLS 업로드 양식 다운로드</a> --%>      
				 <a href="${ctxt}/resources/archiveExcel/아카이브_보고서_업로드양식.xls" class="basic-btn">XLS 업로드 양식 다운로드</a>       		
			</div>
				
			<div style = "border: 1px solid grey; padding :10px; margin-top: 50px; line-height:200%" >
				<ul style="list-style: none;">
					<li>1.  "XLS 업로드 양식 다운로드" 버튼을 이용하여 정해진 양식으로 엑셀 자료를 등록 할수 있습니다.</li>					   
					
				    <li>2.  엑셀 파일을 등록 후 "XLS Upload" 버튼을 클릭 하십시오.</li>			
				      
				    <li style="margin-left: 20px;">     1) 에러 내역이 있으면 화면에 목록으로 나타나며 에러상세에서 내역을 보여줍니다.
				    <li style="margin-left: 40px;">         - 엑셀자료를 수정 후 다시 등록해 주십시오.
				    <li style="margin-left: 20px;">     2) 항목
				    <li style="margin-left: 40px;">         - Line : 엑셀의 오류가 발생한 행 번호를 표시
				    <li style="margin-left: 40px;">         - 보고서 제목 : 보고서의 연구과제명
				    <li style="margin-left: 40px;">         - 에러상세 : 오류가 발생한 자료의 상세 내역
			        <li style="margin-left: 20px;">     3) 에러 내역이 없으면 등록된 엑셀 자료를 버튼 클릭과 동시에 데이터베이스에 저장합니다. </li>       
				    <li>3.  에러 상세 </li>
				    <li style="margin-left: 20px;">     1) 상세보기를 클릭하면 해당 데이터의 상세 내역을 보여줍니다. </li>
				    <li style="margin-left: 20px;">     2) 에러내용에 오류 내용을 표현해 줍니다. </li>				    
					<li>4.  위 사항에 맞지않는 데이터는 에러상세에 표시 됩니다. 엑셀을 다시 수정 후 등록하여 주십시오.  </li>					
				</ul>			
			</div>	
	</div>  
		
	<div class="bbs_btn"  style = "text-align:  right;margin-top: 100px;">
				
				<!-- <a href='javascript:fn_save()'  class='btn01 btnR' name ='save_btn' ><span>저장</span></a> -->
	</div>
	
	<div id = "dialog" title="상세보기">  <!-- dialog 생성 -->
		<table  class= "basic_table">
					<caption style="display:none;" >					
					</caption>
					<colgroup>
						<col style="width:30%">
						<col>											
					</colgroup>
					<tbody id ="infoBody">
								
					</tbody>
		</table>
	</div>
	
	<!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" />
	
	<input type="hidden" id="message" name="message" value="${message}" alt="message">

</div>
</div>
</div>
</form>		
	
	