<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 
<script>
var chkYears ="";
var chkYears2 = "";
function goDetaileJrnList(bibctrlno,lb,idx,obj){

	//$('.div_journal').attr('style','border:1px solid #dedede;margin:0 0 3px 0;padding:0px;')
	//$(obj).parent().parent().parent().attr('style','border:2px solid #8B5927;margin:0 0 3px 0;padding:0px;')
	//$('#sel_journal').html('<div style="margin-left:40%;" ><h3>'+lb+ "</h3> " + $('.span_'+idx).text()+'</div>');
	
	var text = $('.span_'+idx).text();
	 
	
	$('.div_journal').attr('style','')
	$(obj).parent().parent().parent().attr('style','')
	$('#sel_journal').html('<div style="font-size:13px;line-height:140%;"><h3 id="sel_title" style="font-weight:bold; font-size:22px;color:#003964; margin-bottom:3px; margin-top:10px; text-align:center;">'+lb+ "</h3> " + $('.span_'+idx).text()+'</div>');
	
	$.ajax({
		url : '${ctxt}/elib/kom/junalDtlHistory.do',
		data :  {"bibctrlno" :bibctrlno },
		type : 'get',
		cache: false,
		success : function(rtnXml) {

			   
        	xmlList = $(rtnXml).find('item');
        	html="";
			if(xmlList.length > 0){

				xmlList.each(function(cnt){
			 
					var obj = $(this);
					 var years= obj.find('years').text() ;
					/***************************************************************
					* 화면별로 따로 세팅 테이블 데이터
					****************************************************************/
					
					 if(cnt != 0 && chkYears != years){					
		 					html += '</div>'; 
							html += '</div>';
						}
					
					if(chkYears != years){
						html += '<div class="journal_history">';
						html += '<div class="journal_history_list"><p>Vol.'+obj.find('volumeno').text() + '<br />'+years+'</p></div>';
	 					html += '<div class="journal_history_vol_box">';
					}
						
 						html += '<div class="vol_list"><div class="vol_list_content" onclick="goArticleList(\''+ obj.find('controlno').text() +'\',\''+ obj.find('seqno').text()+'\',\''+ obj.find('volumeno').text()+'\',\''+ obj.find('volumeissue').text()+'\',\''+ obj.find('pub_dt').text() +'\',\''+ obj.find('volumename').text() +'\')" >'+ 'V.' + obj.find('volumeno').text() + ' (' +obj.find('volumeissue').text() +')'+  '<br />'+obj.find('pub_dt').text() +' </div></div>';
 						
					
 					chkYears = years;
 					
		        });
			    $("#bodyInfo").html(html);
			  
			}else{
				/***************************************************************
				* 화면별로 따로 세팅 테이블 데이터 조회 없는경우
				****************************************************************/
	
				$("#bodyInfo").html('');
			}			
		},
		error : function() { // Ajax 전송 에러 발생시 실행
			alert('오류가 발생했습니다. 관리자에게 문의 바랍니다.');
		},
		complete : function(result) { //  success, error 실행 후 최종적으로 실행
			
		}
	}); 
	
}

 function goArticleList(bibctrlno, seqno,volumeno,volumeissue,pub_dt,volumename) {
	document.listForm.bibctrlno.value = bibctrlno;
	document.listForm.title.value = $('#sel_title').text();
	document.listForm.seqno.value = seqno;
	document.listForm.volumeno.value = volumeno;
	document.listForm.volumeissue.value = volumeissue;
	document.listForm.pub_dt.value = pub_dt;
	document.listForm.volumename.value = volumename;
	document.listForm.submit();
} 

$(function(){
		$('.div_journal').eq(0).find("ul > li > a").trigger("click");
});


function fn_goJournalDtl(str_bibctrlno){
	var form = document.junalForm;
	$('#bibctrlno').val(str_bibctrlno);
	form.action = "${ctxt}/elib/kom/junalDtl.do";
	form.submit();
}


</script>
<style>

	.vol_list_content {
	    width: 97%;
	    height:auto;
	    min-height: 40px;
	    margin: 1% 0 ;
	}
	.content_box>.content_list>.list_title>p:before, .content_box .content_list .list_title p:before, .content_box>.content_list>.sub_book_wrap>.list_title>p:before {
	    content: "";
	}
	a.info{
		color:#003964; 
		margin-left:10px;
	}
	a.info:hover{
		color:#B15735;
	}
	.div_journal a:after{
		clear:both;
		display:block;
		content:"";
	}
	.div_journal a>p:last-child{
		vertical-align:top;
	}
	p.fontst{
		padding-right:7px;
	}

</style>
<form id="junalForm" name="junalForm" method="post" action="" >
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" id="bibctrlno" name="bibctrlno" value="" />
</form> 
<div id="" class="">
	<div id="divUcont_cont">
		<div class="sub_center_text">
	      <div class="sub_center_nav"> 
		      <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
		      <span> > </span> 
		      <span>전자자원</span>
		      <span> > </span>
		      <span class="active">KoreaOpenMed</span>        
	      </div>
		      <!-- <span class="center_text_01">학술지 권호정보</span>         -->
		</div> 
	</div>
	<div class="under_bar"></div>	
<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div class="list_title">
					<p style="font-size:22px;">Journal History<span><a href="javascript:fn_goJournalDtl('${bibctrlno}');" class="info"><i class="fas fa-info-circle" style="vertical-align:middle;"></i></a></span></p>
				</div>
				<div class="div_content" style="">
					<form id="listForm" name="listForm" action="${ctxt}/elib/kom/historyDtl.do">
						<input type="hidden" name="bibctrlno" value="" /> 
						<input type="hidden" name="seqno" value="" /> 
						<input type="hidden" name="volumeno" value="" /> 
						<input type="hidden" name="volumeissue" value="" /> 
						<input type="hidden" name="pub_dt" value="" /> 
						<input type="hidden" name="volumename" value="" />
						<input type="hidden" name="title" value="" />
					</form>
					<div class="div_journal_box"  style="border:1px solid rgba(51,122,183,0.2); margin:10px 0 5px 0;" >
					<c:forEach var="reqstVO" items="${historyList}" varStatus="stat">
					  <div class="div_journal"  style="border:1px solid #dedede; margin:2px 2px 3px 0;padding:3px;"> 
						  <ul style="border:0px solid rgba(51,122,183,0.2); display:block; margin:6px 0; padding:6px 10px;">
							<li style="line-height:110%;">
								<a href="#" style="color:#555; font-size:12px; text-decoration:none; line-height:100%;" onclick="javascript:goDetaileJrnList('${reqstVO.metano}','${reqstVO.label}',${stat.index},this);"> 
								<p class="fontst" style="font-size:14px;float: left;margin: 0;"><c:out value="${reqstVO.label}" escapeXml="false" /> : </p>
								<div class="journalhis"> 	   
								<p class="span_${stat.index}" style="display: inline-block;margin: 0"><c:out value="${reqstVO.volumtext}" escapeXml="false" />
								</p>
								<br/>
								<p class="span_" style="display: inline-block;margin: 0">
									<c:if test="${ !empty reqstVO.pissn}"> pISSN <c:out value="${reqstVO.pissn}" escapeXml="false" /></c:if>
									<c:if test="${ !empty reqstVO.eissn}"><c:if test="${ !empty reqstVO.pissn}">,</c:if> eISSN <c:out value="${reqstVO.eissn}" escapeXml="false" /></c:if>
								</p>
								</div>
							  </a>	   
							</li>
						  </ul>
						<!-- continuedBy, continues,dateIssued,pissn, eissn  -->
					  </div>
					  
					</c:forEach>
					</div>
					<!-- 선택 데이터 -->
					<div id="sel_journal" style="/* border:1px solid #CCDDED;  */margin:0 0 5px 0; padding:0 0 10px 0; text-align:center; font-size:14px;">
					</div>
					<div id="bodyInfo">
					
					</div>
					<div class="btn-group" style="float: right;">
						<a href="javascript:history.back(-1)" title="학술지 목록" style="float: right;" class="basic-btn" >Journal List</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
