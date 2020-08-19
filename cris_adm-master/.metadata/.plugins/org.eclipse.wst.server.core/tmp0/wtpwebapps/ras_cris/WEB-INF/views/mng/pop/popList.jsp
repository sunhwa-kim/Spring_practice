<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
var xmlList;
var html="";
var cuurPage;
var uploadPath = "";
$(function(){
  
	if($("#messege").val() != ''){
   	 alert( $("#messege").val());
    }
    $("#messege").val('');
	
    var page =$('#page').val();
	if(page == '' ){
		page=1;
	}
	
	fn_search(page);
	
  


});

/*
* 페이징 처리 2 : 페이지 num를 조회조건으로 넘겨서 조회, 페이지 이동시 ajax 재호출
*/
function fn_search(page){
	//현재 페이지 세팅
		cuurPage= page;
	
	
		var page = $("form[name=popInfoVo]").serialize();
		var param_combo = "";
		var param_search = $('#searchBox').val();
		
		if( param_search != ''){
			if ($('#srchChoice').val() == 'all' ){
				param_combo = 'all';		
			}else if($('#srchChoice').val() == 'titl' ){
				param_combo = 'titl';
			}else{
				param_combo = 'ctts';
			}
		}

	  	$('#page').val(cuurPage);
  	  	
    $.ajax({
        url: '${ctxt}/mng/pop/readPopList.do',
        //data: formData,
        data: {'page' : $('#page').val(),'param_search':param_search, 'param_combo':param_combo},
        type: 'GET',
        //formData로 data 보낼경우 false로 세팅,그외에는 밑에 text/xml데이터로 세
        //contentType: "text/xml;charset=utf-8",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        //contentType: false,
        dataType: 'text',
	    //processData: false,
        success: function(rtnXml) {
   
        	xmlList = $(rtnXml).find('item');

        	pagetotalCnt=0;
        	html="";
			if(xmlList.length > 0){
				//총페이지수
				pagetotalCnt = Number($(rtnXml).find('totalCnt').text());
				//업로드패스 
				uploadPath = $(rtnXml).find('uploadPath').text();
				uploadPath = uploadPath.substring(0, uploadPath.length-1);
				
				xmlList.each(function(cnt){
			
					var obj = $(this);
					
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					html += '<tr>';
					html += ' <td>'+obj.find('pop_sn').text() +'</td>';
					
					//운영
					//html += ' <td><a href="${ctxt}/mng/pop/popView.do?pop_sn='+obj.find('pop_sn').text()+'"><img  width="200" height="200"  src="'+uploadPath+obj.find('pop_file_path').text()+'/'+obj.find('pop_file_conv_nm').text() +'"/></a></td>';
					//로컬
					html += ' <td><a href="${ctxt}/mng/pop/popView.do?pop_sn='+obj.find('pop_sn').text()+'"><img  width="200" height="200"  src="${ctxt}'+uploadPath+'/'+obj.find('pop_file_conv_nm').text() +'"/></a></td>';
				
					html += ' <td><a href="${ctxt}/mng/pop/popView.do?pop_sn='+obj.find('pop_sn').text()+'">'+obj.find('pop_titl').text() +'</a></td>';
					html += ' <td>'+obj.find('pop_str_dt').text().substring(0,4)
									+"-"+obj.find('pop_str_dt').text().substring(4,6)
									+"-"+obj.find('pop_str_dt').text().substring(6,8) +
							'</td>';
					html += ' <td>'+obj.find('pop_end_dt').text().substring(0,4)
									+"-"+obj.find('pop_end_dt').text().substring(4,6)
									+"-"+obj.find('pop_end_dt').text().substring(6,8) +
							'</td>';
					html += ' <td>'+obj.find('post_yn').text() +'</td>';
					html += '</tr>';
					
		        });
				//페이징처리
			    $('#paging').paging({
			    	
					 current:cuurPage
					,max:pagetotalCnt
					,length:pageLen
					,onclick:function(e,page){
						cuurPage=page;
						fn_search(cuurPage);
					}
				});
				
			    $("#bodyInfo").html(html);
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$('#paging').children().remove();
				
				$("#bodyInfo").html('<tr><td colspan="6" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
        	fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}


function onClickEnter(){
	
	if(event.keyCode == 13){
		fn_search(1);
		
		return;
	}
}

</script>
<form name="popInfoVo" method="post">
	<input type="hidden" name="page" id="page" value="" /> 
</form>

   <input type="hidden" id="messege" name="messege" value="${messege}">
  
  	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>센터안내</span>
			<span> > </span>
			<span class="active">공지사항</span>        
		</div>
		<span class="center_text_01" >공지사항</span>
	</div> 
	<div class="under_bar"></div>
  
   <div class = "content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div id="search-group" >
					<div class="search-input">
						<label for="searchCombo"></label>
							<select id="searchCondition" name="searchCondition"  title="분류">
								<option value="all">제목 + 내용</option>
								<option value="titl">제목 </option>
								<option value="ctts">내용</option>
							</select>
						<input type="text" id="searchKeyword" name="searchKeyword" maxlength="30" onkeydown="javascript:onClickEnter()" placeholder="검색어를 입력해주세요." />
			
						<span class="right">
							<a  href="javascript:fn_search(1)" class="btn_sch"><span>조회</span></a>
						</span>
					</div>
				</div>
				<h5 class="title">팝업목록</h5>
			
				<table cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="10%">
					<col width="40%">
					<col width="20%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>이미지</th>
						<th>제목</th>
						<th>게시시작일</th>
						<th>게시종료일</th>
						<th>게시여부</th>
					</tr>
				</thead>
				
			
				     <tbody id="bodyInfo">
					</tbody>
				</table>
					<div id="paging" class="paginate" style ="text-align: center;"></div>
		
		
				 <div class="bbs_btn">
					<a href='${ctxt}/mng/pop/popWrite.do' name="save_btn" class='btn01 btnR'><span>등록</span></a>
				</div> 
		
			</div>
		</div>
	</div>
  	
  	
	