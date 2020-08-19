<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

var xmlList;
var html="";
var cuurPage;
var pageTotalCnt = 0;
var dataTotalCnt = 0;

$(function(){
     
   if($("#messege").val() != ''){
       fn_alert( $("#messege").val());
    }
    $("#messege").val('');
   
    var page =$('#page').val();
   if(page == '' ){
      page=1;
   }
   
 var searchOption = $("#searchOption").val();
 
   if(searchOption != '' ){
      $('#searchCondition option[value='+searchOption+']').attr('selected',true);
   }
//    var data_center_gbn=$('#health_type').val();
   /* if(data_center_gbn == ''){
      data_center_gbn="DATA_01"
   }  */
   
   // 화면 목록 조회
   fn_search(page);
    
});

//상세화면 조회
function fn_page(ins_id){
   
   $('#ins_id').val(ins_id);
   var form=document.reqForm;
   form.action="${ctxt}/data/relatedInsView.do?ins_id="+ins_id;
   form.submit();
   
}



function fn_data_enter_search(param){
   var id_val = $(param).attr('id');   
   
   if(event.keyCode == 13)
   {   
      event.preventDefault();
      fn_search(1);
   }   
}

function fn_popupChk(url){
   
   if(url == ''){
      alert("이미지 링크 주소가 존재하지 않습니다.");
      
      return;
   }

   popup(url,'1200','800','1');
}

function fn_search(page){
   
   //현재 페이지 세팅
   cuurPage= page;
   
   /***************************************************************
   * 화면별로 따로 세팅 조회조건
   ****************************************************************/

   $('#page').val(cuurPage);
   
   
   $('#searchCondition').val($('#searchCondition option:selected').val());
   

   
   var params = {};
        params.page=cuurPage;
      params.searchKeyword = $('#searchKeyword').val();
      params.searchCondition = $('#searchCondition option:selected').val();
   
      
    $.ajax({
        url: '${ctxt}/data/relatedInsRead.do',
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
            
            xmlList.each(function(cnt){
               
                  
               var obj = $(this);
               var atch_file_id = obj.find('atch_file_id').text();
               var url = obj.find('ins_url').text();
               var file_sn= obj.find('file_sn').text(); // 파일 순번 
               /***************************************************************
               * 화면별로 따로 세팅 테이블 데이터
               ****************************************************************/
               html += '<tr>';
               html += "<td>";
               html += '<a href="javascript:fn_popupChk(\''+url+'\');" >';
               html += "<img src='${ctxt}/cmmn/mainPopup/getImage.do?atch_file_id="+atch_file_id+"&file_sn="+ file_sn + "' alt='pop' title='pop' width=\"150\" height=\"36.84\"     ></a>";
               html += "</td>";
//                html += ' <td style ="text-align:center;">'+obj.find('ins_sj').text() + '</td>';
               html += ' <td style ="text-align:left;">'+obj.find('ins_cn').text() +'</td>';
               html += '</tr>';
                
              });
            //페이징처리
             $('#paging').paging({
                
                current:cuurPage
               ,max:pageTotalCnt
               ,length:pageLen
               ,onclick:function(e,page){
                  cuurPage=page;
                  
                  
                  //$("#searchKeyword").val("");
                  //$("#searchCondition").val("ALL");
                  
                  
                  fn_search(cuurPage);
               }
            });
            $("#topInfo").html("<span class = 'gray'>["+ cuurPage +" / "+pageTotalCnt+" Pages]</span><span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.");
             $("#bodyInfo").html(html);
           
         }else{
            /***************************************************************
            * 화면별로 따로 세팅 테이블 데이터 조회 없는경우
            ****************************************************************/                   
            //$("#searchKeyword").val("");
            //$("#searchCondition").val("ALL");
            
            $('#paging').children().remove();
            
            $("#topInfo").html("<span class = 'gray'>[1 / 1 Pages]</span><span class = 'txt-red' > 0 </span> 건이 검색되었습니다.");
            
            $("#bodyInfo").html('<tr><td colspan="5" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
         }
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}

</script>

   
      
      
<style>
	@media all and (max-width:750px) {
		#topInfo {
    	margin: 47px 0 10px 0;
    	transition:all 0.3s;
		-webkit-transition:all 0.3s;
		}
	}
	@media (max-width: 494px){
		.content_box>.content_list{
			padding-top:40px;
		}
	}
</style> 

<form name="reqForm">
   <div class="sub_center_text">
      <div class="sub_center_nav"> 
         <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
         <span> > </span> 
         <span>데이터센터</span>
         <span> > </span>
         <span class="active">유관기관 데이터</span>        
      </div>
      <span class="center_text_01">유관기관 데이터</span>
   </div> 
   <div class="under_bar"></div>      
             
   <div class="content_wrap">
      <div class="content_box">
         <div class="content_list">
         <!-- <div class="list_title">
            <p>유관기관</p>
         </div>    -->
           <div id="search-group">
              <div class="search-input">
               <label for="searchComboBox"></label>
               <select id="searchCondition" name="searchCondition" title="분류">
                  <option value="ALL">전체</option>
                  <option value="TITLE">포털사이트</option>
                  <option value="insCn">내용</option>
               </select>
               <label for="searchBox"></label>
               <input type="text" id="searchKeyword" name="searchKeyword" placeholder="검색어를 입력하여 주십시오." value="${relatedInsVo.searchKeyword}" onkeydown="fn_data_enter_search(this, $('#data_center_gbn').val());"/>
                  <input type="button" id="btnSearch" value="검색" onclick="javascript:fn_search(1)"/>
                                     
            </div>
         </div>
      
      
         <p id="topInfo"></p>
         
         <table class = 'basic_table'>
            <colgroup>
               <col style="width:18%">
<%--                <col style="width:20%"> --%>
               <col style="width:*">
            </colgroup>
            <thead>
            <tr>
<!--                <th scope='col'>이미지링크</th> -->
<!--                <th scope='col'>포털사이트</th> -->
<!--                <th scope='col'>내용</th>       -->
            </tr>
            </thead>
            <tbody id = 'bodyInfo'>
               
            </tbody>
         </table>
               
         <div id="paging" class="paginate"></div>
   </div>
   
      
      <!-- 추가 PARAM -->
   <input type="hidden" id="messege" name="messege" value="${messege}" alt="message">
   <input type="hidden" name="page" id="page" value="${relatedInsVo.page}" alt="pageNum" /> 
   <input type="hidden" name="ins_id" id="ins_id" value="${relatedInsVo.ins_id}" alt="data_center_id" />
   <input type="hidden" name="searchOption" id="searchOption" value="${relatedInsVo.searchCondition}" alt="콤보param" /> 
    
    <!-- 공통  필수 PARAM -->
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/>
   </div>
   </div>
   
   
</form>