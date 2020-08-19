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
   var health_type=$('#health_type').val();
   
   // 화면 목록 조회
   fn_search(page, health_type);
    
});

function fn_pageLink(health_url){
   var health_url = health_url
   window.open(''+ health_url +'','_blank');
}

function fn_data_enter_search(param, health_type){
   var id_val = $(param).attr('id');   
   
   if(event.keyCode == 13)
   {   
      event.preventDefault();
      fn_search(1, health_type);
   }   
}
$(function(){      
    $(".tab-btn").eq(0).addClass("active");
    $(".tab-btn").click(function () {
        $(".tab-btn").removeClass("active");       
        $(this).addClass("active");
    });
});
function fn_search(page, health_type){

   //현재 페이지 세팅
   cuurPage= page;
   
   /***************************************************************
   * 화면별로 따로 세팅 조회조건
   ****************************************************************/

   $('#page').val(cuurPage);
   
   if(health_type != ""){
         $('#health_type').val(health_type);
   } 
   
   $('#searchCondition').val($('#searchCondition option:selected').val());
   
   
   
   var params = {};
        params.page=cuurPage;
      params.searchKeyword = $('#searchKeyword').val();
      params.searchCondition = $('#searchCondition option:selected').val();
      //params.data_center_gbn = $('#data_center_gbn').val();
      params.health_type = health_type;
   
      
    $.ajax({
        url: '${ctxt}/data/healthCareRead.do',
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
               var url = obj.find('health_url').text();
               var file_sn= obj.find('file_sn').text();
               var sj = obj.find('health_sj').text();
               var healthSj = "";
               if(sj.indexOf(';') == -1){
            	   healthSj = sj;
               }else{
            	   var arrSj = sj.split(';');
            	   healthSj = arrSj[0]+"<br/>"+arrSj[1];
            	   
               }
               
               var cn = obj.find('health_cn').text();
               var cnArr = "";
               var cn1 = "";
               var cn2 = "";
               if(cn.search('※') != -1){
	               cnArr = cn.split('※');
	               cn1 = cnArr[0];
	               cn2 = "※"+cnArr[1];
               }
              
               /***************************************************************
               * 화면별로 따로 세팅 테이블 데이터
               ****************************************************************/
               html += '<tr>';
//                html += "<td>";
//                html += "<img src='${ctxt}/cmmn/mainPopup/getImage.do?atch_file_id="+atch_file_id+"&file_sn="+ file_sn + "' alt='pop' title='pop' width=\"150\" height=\"36.84\"     ></a>";
//                html += "</td>";
               html += ' <td style ="text-align:center;"><a href="javascript:popup(\''+url+'\',1200,800,1);void(0)" >'+healthSj + '</a></td>';
               if(cn.search('※') != -1){
               	html += ' <td style ="text-align:left;"><p class="health">'+cn1 +'</p><p class="health2">'+cn2+'</p></td>';
               }else{
            	   html += ' <td style ="text-align:left;"><p class="health">'+cn +'</p></td>';   
               }
               html += '</tr>';
              });
            //페이징처리
             $('#paging').paging({
                
                current:cuurPage
               ,max:pageTotalCnt
               ,length:pageLen
               ,onclick:function(e,page){
                  cuurPage=page;
                  
                  
                  fn_search(cuurPage, health_type);
               }
            });
            $("#topInfo").html("<span class = 'gray'>["+ cuurPage +" / "+pageTotalCnt+" Pages]</span><span class = 'txt-red' >"+dataTotalCnt+"</span> 건이 검색되었습니다.");
             $("#bodyInfo").html(html);
           
         }else{
            /***************************************************************
            * 화면별로 따로 세팅 테이블 데이터 조회 없는경우
            ****************************************************************/                   
            
            $('#paging').children().remove();
            
            $("#topInfo").html("<span class = 'gray'>[1 / 1 Pages]</span> <span class = 'txt-red' > 0 </span> 건이 검색되었습니다.");
            
            $("#bodyInfo").html('<tr><td colspan="3" style="text-align: center" >조회된 내용이 없습니다.</td></tr>');
         }
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}


</script>

   
<style>
.basic_table { 
	    font-size: 14px; 
} 
	@media all and (max-width:750px) {
		#topInfo {
    	margin: 47px 0 10px 0;
    	transition:all 0.3s;
		-webkit-transition:all 0.3s;
		}
	}
	.tab-btn.list_data {
		padding:0 20px;
		margin-top: 0;
		height: 30px; 
	}
	.tab-group.list_data{
		margin: 60px auto 0 auto;
	}
   
    @media all and (max-width:1190px) {
	/* .tab-btn.list_data{
    	float: none;
   		padding: 0;
	}
	.tab-btn.list_data {
	   padding: 0;
	}*/
	
	.tab-group.list_data{
	   display: none;
	} 
	
	
  } 

   @media (max-width: 502px){
		#topInfo {
    		margin:85px 0 9px 0;
    	}
    	#search-group{
    		top:55px;
    	}
	}
   
   .health{
   	margin: 0px;
   }
   .health2{
   	margin: 0px;
   	text-indent: 5px;
   	font-size: 13px;
   }
</style>
      
   

<form name="reqForm">
   <div class="sub_center_text">
      <div class="sub_center_nav"> 
         <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
         <span> > </span> 
         <span>데이터센터</span>
         <span> > </span>
         <span class="active">보건의료정보</span>        
      </div>
      <span class="center_text_01">보건의료정보</span>
   </div> 
   <div class="under_bar"></div>      
             
   <div class="content_wrap">
      <div class="content_box">
         <div class="content_list">
           <div id="search-group">
              <div class="search-input">
               <label for="searchComboBox"></label>
               <select id="searchCondition" name="searchCondition" title="분류">
                  <option value="ALL">전체</option>
                  <option value="TITLE">포털사이트</option>
                  <option value="healthCn">내용</option>
               </select>
               <label for="searchBox"></label>
               <input type="text" id="searchKeyword" name="searchKeyword" placeholder="검색어를 입력하여 주십시오." value="${dataCenterVo.searchKeyword}" onkeydown="fn_data_enter_search(this, $('#health_type').val());"/>
                  <input type="button" id="btnSearch" value="검색" onclick="javascript:fn_search(1,$('#health_type').val())"/>
                                     
            </div>
         </div>
      
      
      <div class="tab-group list_data">
         <a href="#" class="tab-btn list_data" onclick="fn_search('1', 'ALL');">전체</a>
         <a href="#" class="tab-btn list_data" onclick="fn_search('1', 'health_01');">건강/질병정보</a>
         <a href="#" class="tab-btn list_data" onclick="fn_search('1', 'health_02');">데이터 분양/관리</a>
         <a href="#" class="tab-btn list_data" onclick="fn_search('1', 'health_03');">온라인 등록/신청</a>
         <a href="#" class="tab-btn list_data" onclick="fn_search('1', 'health_04');">학술정보</a>
         <a href="#" class="tab-btn list_data" onclick="fn_search('1', 'health_05');">통계정보</a>
         <!-- <a href="#" class="tab-btn list_data" onclick="fn_search('1', 'health_06');">교육정보</a> 2018.11.14 숨김 요청-->
      </div>  
         
         <p id="topInfo"></p>
         
         <table class = 'basic_table'>
            <colgroup>
               <col style="width:27%">
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
   <input type="hidden" name="page" id="page" value="${healthCareVo.page}" alt="pageNum" /> 
   <input type="hidden" name="health_type" id="health_type" value="${healthCareVo.health_type}" alt="health_type" />
   <input type="hidden" name="health_id" id="health_id" value="${healthCareVo.health_id}" alt="health_id" />
   <input type="hidden" name="searchOption" id="searchOption" value="${healthCareVo.searchCondition}" alt="콤보param" /> 
    
    <!-- 공통  필수 PARAM -->
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt="token"/>
   </div>
   </div>
   
   
</form>