<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="${ctxt}/resources/js/common.js"></script>
<script type="text/javascript">

var xmlList;
var html="";
var cuurPage;
var pageTotalCnt = 0;
var dataTotalCnt = 0;
var my_libr_id="";
$(function(){
	  
	if($("#messege").val() != ''){
    	fn_alert( $("#messege").val());
    }
    $("#messege").val('');
	
    var page =$('#page').val();
	if(page == '' ){
		page=1;
	}
	
	var selectMenu = $('#selectMenu').val();
	if(selectMenu == ''){
		selectMenu = '1';
	}
	
    var searchOption = $("#searchOption").val();
 
	if(searchOption != '' ){
		$('#searchCondition option[value='+searchOption+']').attr('selected',true);
	}	 
    
	// 화면 목록 조회
	fn_search(page,selectMenu);
	
	
});

function fn_search(page){
	//현재 페이지 세팅
	cuurPage= page;
	
	/***************************************************************
	* 화면별로 따로 세팅 조회조건
	****************************************************************/

	$('#page').val(cuurPage);
	

	var params = {};
  		params.page=cuurPage;
		params.searchKeyword = $('#searchKeyword').val();
		params.searchCondition = $('#searchCondition option:selected').val();
		
		
    $.ajax({
        url: '${ctxt}/mylib/lib/readMyLib.do',
        data: params,
        type: 'POST',
        dataType: 'text',
        cache: false,
        success: function(rtnXml) {
   
        	xmlList = $(rtnXml).find('item');

        	pageTotalCnt=0;
        	dataTotalCnt=0;
        	
        	html="";
        	
        	
			if(xmlList.length > 0){
				//총페이지수
				pageTotalCnt = Number($(rtnXml).find('totalPageCnt').text());
				dataTotalCnt = Number($(rtnXml).find('totalDataCnt').text());

				
				//사용자 분기에 필요한 변수 선언
				var innerIp = '${INNER_IP}';
				var loginid = '${userVO.loginid}';
				var mouLoan = '${userVO.mouLoan}';
				var elibYn = '${userVO.elibagree}';
				var instttyid = '${userVO.instttyid}';
				
				xmlList.each(function(cnt){
			
					var obj = $(this);
					my_libr_id = obj.find('my_libr_id').text();
					var regi_no = obj.find('regi_no').text();
					var title =obj.find('sj').text();
					if(title.length > 50){
						title = title.substring(0,50)+"...";
					}
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					
					html += '<tr>';
					
					html += ' <td style="text-align: center" >'+'<input type="checkbox" name="chkObj" id="chkObj" value='+obj.find('my_libr_id').text()+'>'+'<input type="hidden" name='+obj.find('my_libr_id').text()+' id='+obj.find('my_libr_id').text()+' value='+regi_no+'>'+'</td>';
					
					html += ' <td style="text-align: center" >'+obj.find('order_sn').text() +'</td>';
						
					html += ' <td style="text-align: center" title="'+obj.find('item_ty_cd').text()+'">'+obj.find('item_ty_cd').text() + '</td>';
					if(obj.find('item_ty_cd').text() != 'E-Books'){
						html += ' <td style="text-align: left" ><a href="'+obj.find('regi_no').text()+'" ><input type="hidden" name="sj" id="'+obj.find('my_libr_id').text()+'my'+'" value="'+obj.find('sj').text()+'">'+obj.find('sj').text() + '</a></td>';	
					}else{
						
						html += '<td style="text-align: left" >';
						//사용자별 분기 시작
						if(regi_no == ''){
							html += obj.find('sj').text();  //+ obj.find('issn').text();
						}else if( innerIp == 'Y'){
							html += '<a href="#" onclick="elibPopInternalIp(\'' +regi_no +'\', \'E\');" title="새창">'+'<span style="color:#1A96D9" title="새창">'+obj.find('sj').text() +'</span>' +'</a>';
						}else if( loginid == ''){ <%-- 로그인 안했을때 --%>
							html += '<a href="#" onclick="javascript:popLink();" title="새창">'+ obj.find('sj').text() +'</a>';
						}else{
							<%-- 무제한 이용 --%>
							if( elibagree == '1' || elibagree == '5'){
								html += '<a href="#" onclick="elibPop(\''+ regi_no +'\', \'E\');" title="새창">'+ obj.find('sj').text()  + '</a>';
							<%-- 건물내 이용 --%>
	 						}else if(elibagree == '2' && innerIp == 'Y'){
								html += '<a href="#" onclick="elibPopInternalIp(\''+ regi_no +'\', \'E\');" title="새창">'+ obj.find('sj').text()  + '</a>';
							<%-- 소속 직원 이용가능 --%>	
							}else if(elibagree == '3' && (instttyid == '1' || instttyid == '2')){
								html += '<a href="#" onclick="elibPopInternalIp(\''+ regi_no +'\', \'E\');" title="새창">'+ obj.find('sj').text()  + '</a>';
							<%-- 승인회원 이용가능 --%>
							}else if((elibagree == '2' || elibagree == '3' || elibagree == '4') && elibYn == 'Y'){
								html += '<a href="#" onclick="elibPop(\''+ regi_no +'\', \'E\');" title="새창">'+ obj.find('sj').text() + '</a>';
							}else{
								html += obj.find('sj').text() + '</span>';
							}
						}
						html += '</td>';
					}
					
					
					html += ' <td style="text-align: center" >'+obj.find('writer_nm').text() + '</td>';
					
					html += ' <td style="text-align: center" >'+obj.find('issue_year').text() + '</td>';
					
					html += ' <td style="text-align: center" >'+obj.find('regi_day').text()+'</td>';
					
					html += '</tr>';
					 
		        });
				//페이징처리
			    $('#paging').paging({
			    	
					 current:cuurPage
					,max:pageTotalCnt
					,length:pageLen
					,onclick:function(e,page){
						cuurPage=page;
						
						// 페이지 이동시 PARAM 초기화
						//$("#searchKeyword").val("");
						//$("#searchCondition").val("");
						
						fn_search(cuurPage);
					}
				});
			    $("#topInfo").html("<span class = 'gray'>["+ cuurPage +" / "+pageTotalCnt+" Pages]</span> <span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.");
			    $("#bodyInfo").html(html);
			  
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
				$('#paging').children().remove();
				$("#topInfo").html("<span class = 'gray'>[1 / 1 Pages]</span> <span class = 'txt-red' > 0 </span> 건이 검색되었습니다.");
				$("#bodyInfo").html('<tr><td colspan="6" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
			}
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}


//체크박스 전체선택, 전체해제 
function checkAll(){
      if( $("#chkAll").is(':checked') ){
        $("input[name=chkObj]").prop("checked", true);
      }else{
        $("input[name=chkObj]").prop("checked", false);
      }
}

//내 서재 삭제
function updateMyLib(){
  var my_libr_id = "";
  var chkNum =0;
  
  $( "input[name='chkObj']:checked" ).each (function (){
	  my_libr_id = my_libr_id + $(this).val()+"," ;
	  chkNum++;
  });
  my_libr_id = my_libr_id.substring(0,my_libr_id.lastIndexOf( ","));
 
  if(my_libr_id == ''){
    alert("삭제할 항목을 선택해주세요.");
    return false;
  }
 
  var bool = confirm(chkNum+"개의 항목이 선택되었습니다. 삭제를 진행하시겠습니까?");
  
  if(bool){
	  $.ajax({
	        url: '${ctxt}/mylib/lib/updateMyLib.do',
	        data: {"my_libr_id":my_libr_id},
	        type: 'POST',
	        dataType: 'text',
	        cache: false,
	        success: function(rtnXml) {
	        	alert('정상적으로 삭제를 진행하였습니다.');
				fn_search(cuurPage);
					
	        },
	        error : function(){                              // Ajax 전송 에러 발생시 실행
	            fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
	          }
	  });
  }else{
	  
	  alert("삭제를 진행하지 않습니다.");
	  
  }
}


//상세화면 조회
function fn_page(regi_no){
	
	$('#regi_no').val(regi_no);
	var form=document.reqForm;
	form.action="${ctxt}/mlib/mlibView.03do?bibctrlno="+regi_no;
	form.submit();
	
}

    
/*SNS로전송 */
function sendSNSto(sns,title){
	
	
 	  var id = $("input[name=chkObj]:checked").val();
 	  if(id == null || id ==undefined){
 		  alert('공유할 항목을 선턱해주세요.');
 		  return;
 	  }
 	  
 	  var chk_cnt = 0;
 	  $("input[name=chkObj]:checked").each(function() { 
 			chk_cnt++;	 
 	  });

 	  if(chk_cnt > 1){
 		 alert('공유 항목은 하나만 선택 가능 합니다.');
		  return;
 	  }
 	  
 	  var TITLE = $("#"+id+"my").val();
 	  var val = $("#"+id).val();
 	
	  var FACEBOOK = 'http://www.facebook.com/sharer/sharer.php?u='+encodeURIComponent(val);// + "&t=" +TITLE;
	  var TWITTER = "http://twitter.com/share?text=" + TITLE + "&url=" + encodeURIComponent(val);
	  var GOOGLEPLUS ='https://plus.google.com/share?url='+ encodeURIComponent(val); 
	  
		switch(sns){
		 case "facebook":
			
		 $('meta[name=faceDes]').attr('content' , TITLE);						 
		  window.open(FACEBOOK, "facebookWindow",'width=960,height=500,directories=0,resizable=1,menubar=0,status=0,toolbar=0,scrollbars=1');
		  
		  break;
		 case "twitter":
		  window.open(TWITTER, "twitterWindow",'width=960,height=500,directories=0,resizable=1,menubar=0,status=0,toolbar=0,scrollbars=1');
		  break;
		 case "googleplus":
		  window.open(GOOGLEPLUS, "googleWindow",'width=960,height=500,directories=0,resizable=1,menubar=0,status=0,toolbar=0,scrollbars=1');
		  break;
		} 

} 
</script>
<style>
.btn-group.back{
	margin-top: 18px
}
.btn-group.back >a{
   padding-right: 7px;
} 

</style>


<form name="reqForm" method="post">
 	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>My Library</span>
			<span> > </span>
			<span class="active">내 서재</span>        
		</div>
		<span class="center_text_01">내 서재</span>
	</div> 
	<div class="under_bar"></div>		
 		
 	<div class="content_wrap">
 		<div class="content_box">
			<div class="content_list">	
 		
	        <div id="search-group">
				<div class="search-input">
					<label for="searchCombo"></label>
					<select id="searchCondition" name ="searchCondition" title="분류">
						<option value="ALL">전체</option>
						<option value="TITL">서명</option>
						<option value="AUTH">저자</option>
					</select>
					<label for="searchBox"></label>
					<input type="text" id="searchKeyword" name= "searchKeyword" value="${libVo.searchKeyword}" onkeydown="fn_enter_search(this);" placeholder="검색어를 입력해주세요."/>
	            	<input type="button" id="btnSearch" value="검색" onclick="javascript:fn_search(1)"/>
				</div>
			</div>
			  
			<p id="topInfo"></p>
			
			<table class = 'basic_table'>
				<caption>
				</caption>
					<colgroup>
						<col style="width:5%">
						<col style="width:7%">
					    <col style="width:10%">
					    <col>
					    <col style="width:15%">
					    <col style="width:15%">
					    <col style="width:10%">
					</colgroup>
					
					<thead>
						<tr>
							<th scope="col"><input type="checkbox" name="chkAll" id="chkAll" onclick="checkAll()">
							<th scope="col">번호</th>
							<th scope="col">자료유형</th>
							<th scope="col">서명</th>
							<th scope="col">저자명</th>
							<th scope="col">발행년도</th>
							<th scope="col">등록일</th>
						</tr>
					</thead> 
					<tbody id = 'bodyInfo'>
					
					</tbody>
			</table>
			<div class="btn-group back">
					<a style="float: right;" href="javascript:sendSNSto('twitter','국립의과학지식센터>센터 이용안내')" class="sns_br_none"><img style="height: 25px; width: 25px;" src="${ctxt}/resources/images/sub/ic_twitter.gif" alt="twitter-새창" title="twitter-새창" /></a>
					<a style="float: right;" href="javascript:sendSNSto('facebook','국립의과학지식센터>센터 이용안내')" class="sns_br_none"><img style="height: 25px; width: 25px;" src="${ctxt}/resources/images/sub/ic_facebook.gif" alt="facebook-새창" title="facebook-새창"/></a>
					<a style="float: right;" href="javascript:sendSNSto('googleplus','국립의과학지식센터>센터 이용안내')" class="sns_br_none"><img style="height: 25px; width: 25px;" src="${ctxt}/resources/images/sub/google-plus.png" alt="google-새창" title="google-새창"/></a>
			</div>
			<div class="btn-group">	
					<a href='javascript:updateMyLib();' class='basic-btn' ><span>삭제</span></a>
			</div>
			<div id="paging" class="paginate"></div>
				
				</div>
			</div>
		</div>
	
	<!-- 추가 PARAM -->
	<input type="hidden" id="messege" name="messege" value="${messege}" alt="message">
	<input type="hidden" name="page" id="page" value="${libVo.page}" alt="pageNum" /> 
	<input type="hidden" name="searchOption" id="searchOption" value="${libVo.searchCondition}" alt="콤보param" /> 
	<input type="hidden" name="my_libr_id" id="my_libr_id" value="${libVo.my_libr_id}" alt="my_libr_id" />
	<input type="hidden" name="regi_no" id="regi_no" value="${libVo.regi_no}" alt="regi_no" />
	<input type="hidden" name="item_ty_cd" id="item_ty_cd" value="${libVo.item_ty_cd}" alt="item_ty_cd" />
 	<!-- 공통  필수 PARAM -->
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/>
	
</form>