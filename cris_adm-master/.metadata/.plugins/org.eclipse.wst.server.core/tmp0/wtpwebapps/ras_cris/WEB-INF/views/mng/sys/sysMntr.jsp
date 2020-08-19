<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<script type="text/javascript">
	$(function(){
		
		$('#search_opt').change(function(){
			
			if($('#search_opt option:selected').text() == '전체'){
				
				$('#sysMntrList > tr').attr('style', ''); 
			}else{
	 			$('#sysMntrList > tr').each(function(cnt){
		 			if($(this).find('td:eq(3)').text() == $('#search_opt option:selected').text()){
		 				$(this).attr('style', ''); 
		 			}else{
		 				$(this).attr('style', 'display:none'); 
		 			}	
		 		});
 			}
		});
		
		//테이블 선택 이벤트
		$('#sysMntrList > tr').click(function(){
			
			$('#sysMntrList > tr').removeClass();
			
			$(this).addClass('on');
	
			$('#mntr_dt').val($(this).find('td:eq(1)').text());
			$('#err_yn').val($(this).find('td:eq(5)').text());
			$('#err_prc_yn').val($(this).find('td:eq(6)').text());
			$('#err_prc_desc').val($(this).find('td:eq(10)').text());
			
			$.ajax({
			    url : '${ctxt}/mng/sys/selectMntrErr.do',
			    data : {"mntr_seq" : $(this).find('td:eq(0)').text()},   //전송파라미터
			    contentType: 'text/xml;charset=utf-8',   //서버로 데이터를 보낼 때 사용.
			    type : 'GET',
			    dataType : 'text',
			    success : function(result) {

							$('#errTxt').val(result);	
			    		},
			    error : function() { // Ajax 전송 에러 발생시 실행
			           	fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
			    		},
			});
		});

		//처리 완료 이벤트
		$('#err_prc').click(function(){
	
			if($('#err_prc_yn').val() != '미처리'){
				fn_alert('처리 대상이 아닙니다.','c');
				return;
			}
			if($('#err_prc_desc').val() == ''){
				fn_alert('처리내용을 적어주세요.','c');
				return;
			}
			
			var strConfirm = confirm("처리하시겠습니까?");
			
			if(strConfirm){
				var param = {};
					param.mntr_seq = $('.on').find('td:eq(0)').text();
					param.err_prc_desc = $('#err_prc_desc').val();
				
				$.ajax({
				    url : '${ctxt}/mng/sys/procErr.do',
				    data : param,   //전송파라미터
				    type : 'POST',
				    dataType : 'text',
				    success : function(result) {
				    		fn_alert('에러발생을 처리로 진행하셨습니다.');
				    		setTimeout(location.href="${ctxt}/mng/sys/sysMntr.do", 1500);
				    		},
				    error : function() { // Ajax 전송 에러 발생시 실행
				           	fn_alert("에러처리 진행에 실패하였습니다.");
				    		},
				});
			}
		});
		
		//처리 완료 이벤트
		$('#procSC').click(function(){
			if($('#err_prc_yn').val() == '미처리'){
				fn_alert('에러처리가 되지 않았습니다.','c');
				return;
			}
			var strConfirm = confirm("실행하시겠습니까?");
			
			if(strConfirm){
				$.ajax({
				    url : '${ctxt}/mng/sys/procSC.do',
				    data : {},   //전송파라미터
				    contentType: 'text/xml;charset=utf-8',   //서버로 데이터를 보낼 때 사용.
				    type : 'GET',
				    dataType : 'text',
				    success : function(result) {
				    		fn_alert('스켸쥴 실행이 정상 처리 되었습니다.');
				    		setTimeout(location.href="${ctxt}/mng/sys/sysMntr.do", 1000);
				    		},
				    error : function() { // Ajax 전송 에러 발생시 실행
				           	fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
				    		},
				});
			}
		});
		
		//온로드시 첫번째 로우클릭
		$('#sysMntrList > tr :first').click();
		
	});
	
</script>

<div id="container">
	<div id="divRefreshArea">
		<h2>시스템 모니터링</h2>  
		<div class="search_area" >
			<span class="search_label"><font style="font-weight: bold;"> 발생구분</font></span>
			<select id="search_opt">
				<option value="">전체</option>
				<c:forEach items="${err_list}" var="err">
				<option value="${err.cd}">${err.cd_nm}</option>
			</c:forEach>
		</select>
		</div>
		
		
		<br />
			<br />
		   <form id="form" name="form" action="" method="post">
		     <input type="hidden" id="rdtSn" name="rdtSn" value="">
		     <input type="hidden" id="orgCd" name="orgCd" value="">
		     <input type="hidden" id="isMove" name="isMove" value="">
		        <div class="bbsSearch">
		          <tr>
		          </tr>
		        </div>
		    </form>
		<div style="overflow-y: scroll; overflow-x: hidden; height: 400px" >
		    <!-- 목록 -->
		    <div class="table-b-wrap">
			  	<table class="table-b">
		      	<colgroup>
			        <col width="7%">
			        <col width="18%">
			        <col width="15%">
			        <col width="15%">
			        <col width="15%">
			        <col width="15%">
			        <col width="15%">
		      	</colgroup>
		    	<thead>
			        <tr>
			          <th>순번</th>
			          <th>일자</th>
			          <th>발생시간</th>
			          <th>발생구분</th>
			          <th>발생URL</th>
			          <th>에러여부</th>
			          <th>처리여부</th>
			          
			        </tr>
		      	</thead>
		      	<tbody id="sysMntrList">
		      		<c:forEach var="sysMntr" items="${sysMntrList}" >
		      			<tr>
		      				<td><c:out value="${sysMntr.mntr_seq}" /></td>
		      				<td><c:out value="${sysMntr.mntr_dt}" /></td>
		      				<td><c:out value="${sysMntr.create_dttm}" /></td>
							<td><c:out value="${sysMntr.mntr_gbn_nm}" /></td>
							<td><c:out value="${sysMntr.mntr_url}" /></td>
		      				<td <c:if test="${sysMntr.err_prc_yn eq '미처리'}">style="color:red;"</c:if>><c:out value="${sysMntr.err_yn}" /></td>
		      				<td <c:if test="${sysMntr.err_prc_yn eq '처리'}">style="color:green;"</c:if>><c:out value="${sysMntr.err_prc_yn}" /></td>
		      				<td style="display:none;"><c:out value="${sysMntr.ncmik_cnt}" /></td>
		      				<td style="display:none;"><c:out value="${sysMntr.sms_cnt}" /></td>
		      				<td style="display:none;"><c:out value="${sysMntr.eml_cnt}" /></td>
		      				<td style="display:none;"><c:out value="${sysMntr.err_prc_desc}" /></td>
		      			</tr>
		      		</c:forEach>
		      	</tbody>
		   		</table>
			</div>
		</div>
		
		<br />
		<table class="table-a" >
		    <colgroup>
		      <col width="100px">
		      <col width="150px">
		      <col width="100px">
		      <col width="100px">
		      <col width="100px">
		      <col width="*">
		    </colgroup>
		     <tbody>
		      	<tr class="">
		      		<th style="text-align: right" ><label for="mntr_dt">일자&nbsp;</label></th>
		           	<td class="left"><input type="text" id="mntr_dt" name="mntr_dt"  style="width: 90%;text-align: center;" value=""  readonly="readonly"></td>
		        	<th style="text-align: right" ><label for="err_yn">에러여부&nbsp;</label></th>
		           	<td class="left"><input type="text" id="err_yn" name="err_yn"  style="width: 85%;text-align: center;" value=""  readonly="readonly"></td>
		        	<th style="text-align: right" ><label for="err_prc_yn">에러처리여부&nbsp;</label></th>
		           	<td class="left" >
			           	<input type="text" id="err_prc_yn" name="err_prc_yn"  style="width: 15%;text-align: center;" value=""  readonly="readonly">
						<span class="admin_button">
							<label for="err_prc_desc">처리 :</label> <input type="text" id="err_prc_desc" style="width: 50%;" name="err_prc_desc" value="" />
							&nbsp;
							<input type="button" id="err_prc" name="err_prc"  style="width: 20%;" value="처리완료" />
							<input type="button" id="procSC" name="procSC"  style="width: 35%;display: none;" value="스켸쥴실행" readonly="readonly" />
						</span>
		           	</td>
		      	</tr>
		      	<tr>
		      		<td rowspan="5" colspan="6" style="border:0;">
		 			    <textarea rows="20" cols="6" style="width:100%;height:100%;background-color: black;color: white;" id="errTxt" title="" ></textarea>
				   </td> 
		      	</tr>
		    </tbody>
		    </table>
		
	 </div>
 </div>
