<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

$(function(){ 
   	//cmmfn_set_datepicker($("#startDate"), "%Y-%m-%d");
	//cmmfn_set_datepicker($("#endDate"), "%Y-%m-%d");
	
	cmmfn_set_datepicker($("#startDate2"), "%Y-%m-%d");
	cmmfn_set_datepicker($("#endDate2"), "%Y-%m-%d");
	

    $(".tab_content").hide(); 
    $(".tab_content:first").show();

    $("ul.tabs li").click(function () {
        $("ul.tabs li").removeClass("active").css("color", "#003964");
        //$(this).addClass("active").css({"color": "darkred","font-weight": "bolder"});
        $(this).addClass("active").css("color", "#003964");
        $(".tab_content").hide()
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn()
    });
	
	
$("#writeFormSubmit").click(function() {
	// 유효성 검사
	var frm = document.writeForm;
	var fltWhereQuery =" ";
	var issue ="";

		if(frm.sYear.value != ""  || frm.eYear.value != ""  ){
            if (frm.sYear.value != "" && (parseInt(frm.sYear.value)<1800 || parseInt(frm.sYear.value)>2100) ) {
            	alert("검색년도 범위를 초과 하였습니다. ");
            	return false;
            }
            if (frm.eYear.value != "" && (parseInt(frm.eYear.value)<1800 || parseInt(frm.eYear.value)>2100) ) {
            	alert("검색년도 범위를 초과 하였습니다. ");
            	return false;
            }            
			if(frm.sYear.value != ""  && frm.eYear.value == ""  ){
				fltWhereQuery = fltWhereQuery + frm.and7.value +" flt_dateIssued_v in {'"+frm.sYear.value+"'} ";
			} else if(frm.sYear.value == ""  && frm.eYear.value != ""  ){
				fltWhereQuery = fltWhereQuery + frm.and7.value +" flt_dateIssued_v in {'"+frm.eYear.value+"'} ";
			} else if(frm.sYear.value != ""  && frm.eYear.value != ""  ){
				if (frm.sYear.value > frm.eYear.value) {
					alert("시작년도가 종료년도 보다 큽니다.");
					return false;
				}  else {
					for(var i=frm.sYear.value; i<frm.eYear.value; i++) {
						issue=issue+"'"+i+"',";
					}	
					    issue=issue+"'"+frm.eYear.value+"'";
				   fltWhereQuery = fltWhereQuery + frm.and7.value +" dateIssued in {"+issue+"} ";
				}
			}	

		}

		frm.fltWhereQuery.value=fltWhereQuery;
		
  });		
  
});

function onlyNumber(event){
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
	console.log(event.keyCode);
    if (event.keyCode == 86 && event.ctrlKey || event.keyCode == 88 && event.ctrlKey)
    {
    	 event.keyCode = 0;
         event.cancelBubble = true;
       return;
    }
    if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) ) {
        return;
    }
    else if( ( keyID ==8  ) || ( keyID ==9  ) || ( keyID ==46 ) || ( keyID >=37 && keyID <= 40  ) ) {
        return;
    }
    else {
        return false;
    }


}
function kwdFocus2(){
	$("#conD").focus();
}

/* 논문검색 조회 */
function fn_search1(){
	  $("input[name=f1]").val($('#f1 :selected').val());
 	  $("input[name=v1]").val($('#v1').val());
 	  $("input[name=and1]").val($('#and1 :selected').val());
 	  $("input[name=f2]").val($('#f2 :selected').val());
 	  $("input[name=v2]").val($('#v2').val());
 	  $("input[name=and2]").val($('#and2').val());
 	  $("input[name=f3]").val($('#f3 :selected').val());
 	  $("input[name=v3]").val($('#v3').val());
 	  $("input[name=broadSubject]").val($('#broadSubject :selected').val());
 	  var str_listGbn = "";
 	  $('input[name=_listGbn]:checked').each(function(cnt){
 		 if(cnt >0 ){str_listGbn +=",";}
 		 str_listGbn += $(this).val();	 
 	  });
 	  $("input[name=listGbn]").val(str_listGbn);
 	  $("input[name=orderType]").val();
 	  $("input[name=str_dt]").val($('#startDate').val());
 	  $("input[name=end_dt]").val($('#endDate').val());
 	  
	var form = document.writeForm;
	form.submit(); 
	
}

/* 논문검색 조회 */
function fn_search2(){
    $("input[name=broadSubject]").val($('#broadSubject :selected').val());
	  var str_listGbn = "";
 	  $('input[name=_listGbn2]:checked').each(function(cnt){
 		 if(cnt >0 ){str_listGbn +=",";}
 		 str_listGbn += $(this).val();	 
 	  });
 	  $("input[name=listGbn]").val(str_listGbn);
	var form = document.journalForm;
	form.submit();
	
}


function fn_selTab(tab){
	if(tab == 1){
		$('#writeFormSubmit').attr('style','');
		$('#writeFormSubmit2').attr('style','display:none;');
	}else{
		$('#writeFormSubmit').attr('style','display:none;');
		$('#writeFormSubmit2').attr('style','');
	}
}

</script>  
<style>  

#writeFormSubmit{
	position:absolute;
	margin-top:-50px;
}
#writeFormSubmit2{
	position:absolute;
	margin-top:-70px;
}
td.volume_td{
	position:relative;   
	width:100%;
}
.volume_td>span{
	padding:0 2%;   
	box-sizing:border-box; 
	float:left; 
}
.tblStyle01 tbody>tr:nth-child(6)>td.volume_td>input.txt{
	width:42%;
	max-width:181px;
	padding:0;
	padding-left:10px;
	box-sizing:border-box;
	float:left;
	margin-right:0;
}
.tblStyle01 tbody>tr:nth-child(6)>td.volume_td>input.txt:last-child{
	float:right;
}

.jour_srch{
    height: 38px;
    border: 1px solid #ccc;
    color: #7f7f7f;
    margin-right: 0px;
    padding:0px;
    padding-left:3%;
}

.tab_content{
   min-height: 400px;	
}
.lang_sel{
   height: 38px;
   border: 1px solid #ccc;
   color: #7f7f7f;
   margin-right: 8px;
   padding: 0 10px;
}
.pubType_sel{
   height: 38px;
   border: 1px solid #ccc;
   color: #7f7f7f;
   margin-right: 8px;
   padding: 0 10px;
}
td>.center_span{
	position:absolute;
	left:50%;
	top:40%;
	transform:translate(-50%,-50%);
	-o-transform:translate(-50%,-50%);
	-ms-transform:translate(-50%,-50%);
	-moz-transform:translate(-50%,-50%);
	-webkit-transform:translate(-50%,-50%);
}
#writeForm, #journalForm{
	max-width:600px;
}
.tblStyle01 #journalinfo{
	margin-right:0;
}
.tblStyle01 #journalinfo{
	padding:0;
	padding-left:3%;
}
@media all and (max-width:920px) {
	#container-wrap{
		min-height:auto;
		transition:all 0.3s;
		-webkit-transition:all 0.3s; 
	}
}
@media all and (max-width:718px) {
	.volume_td>span{
		padding:0 2%;
	}
	.tblStyle01 tbody>tr:nth-child(6)>td.volume_td>input.txt{
		width:41%;
	}
}
@media all and (max-width:510px) {
	.center_text_01{
		font-size:20px;
		transition:all 0.3s;
		-webkit-transition:all 0.3s; 
	}
	.tblStyle01 dd.last-child>label{
		font-size:11px;
		margin-right: 5px;
	}
}

@media all and (max-width:656px) {
	.volume_td>span{
		padding:0 3%;
	}
	.tblStyle01 tbody>tr:nth-child(6)>td.volume_td>input.txt{
		width:38%;
	}
}
@media all and (max-width:600px) {
	.tblStyle01 tbody>tr:nth-child(6)>td>input.txt{
		height:
		38px;
	}
}
@media all and (max-width:568px) {
	.tblStyle01 tbody>tr:nth-child(6)>td.volume_td>input.txt{
		width:36%;
	}
}
@media all and (max-width:502px) {
	ul.tabs li{
		width:120px;
		transition:all 0.3s;
		-webkit-transition:all 0.3s; 
	}
}

@media all and (max-width:415px) {
	.tblStyle01 tbody>tr:nth-child(6)>td.volume_td>input.txt{
		width:34%;
	}
}
@media all and (max-width:410px) {
	#writeFormSubmit2 {
	    margin-top: -70px;
	}
}
@media all and (max-width:401px) {
	#writeFormSubmit{
    margin-top: -50px;
}
@media all and (max-width:363px) {
	.tblStyle01 tbody>tr:nth-child(6)>td.volume_td>input.txt{
		width:32%;
	}
}
</style>
	<div class="sub_center_text">
		    <div class="sub_center_nav"> 
			     <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			     <span> > </span> 
			     <span>전자자원</span>
			     <span> > </span>
			     <span class="active">Korea OpenMed</span>        
		    </div>						
			<span href="#" class="center_text_01">Advanced Search</span>
		</div> 
	<div class="under_bar"></div>
	
	<div class="content_wrap" >
		<div class="content_box">
			<div class="content_list">
			    <ul class="tabs">
			        <li class="active" rel="tab1" onclick="fn_selTab(1)">Article Search</li>
			        <li rel="tab2" onclick="fn_selTab(2)">Journal Search</li>
			    </ul>
			    <div class="tab_container">
			        <div id="tab1" class="tab_content"><!-- 1 tab start -->
						<div class="detail_searchFrm">
							<form id="writeForm"  style="height:280px;margin:0 auto;" name="writeForm" method="post" action="${ctxt}/elib/kom/listArticle.do"  >
								<input type="hidden" name="f1" value=""/>
								<input type="hidden" name="v1" value=""/>
								<input type="hidden" name="and1" value=""/>
								<input type="hidden" name="f2" value=""/>
								<input type="hidden" name="v2" value=""/>
								<input type="hidden" name="and2" value=""/>
								<input type="hidden" name="f3" value=""/>
								<input type="hidden" name="v3" value=""/>
								<input type="hidden" name="and3" value=""/>
								<input type="hidden" name="broadSubject" value=""/>
								<input type="hidden" name="listGbn" value=""/>
								<input type="hidden" name="orderType" value=""/>
								<input type="hidden" name="str_dt" value=""/>
								<input type="hidden" name="end_dt" value=""/>
								<input type="hidden" name="detailYn" value="Y"/>
								<input type="hidden" name="searchGubun" value="board"/>
					 	  
								<table class="tblStyle01" style="border-bottom:0;">
									<colgroup>
										<col style="width:25%">
										<col style="width:50%">
										<col style="width:25%">
									</colgroup>
									<tbody style="border-bottom:1px solid #CCDDED">
										<tr>
											<th>  
												<select name="searchCondition1" id="f1" class="select" title="첫번째 검색선택">
													<%-- <option value="all_idx" <c:if test="${param.f1 eq ''}">selected</c:if>>전체</option> --%>
													<option value="all_idx" <c:if test="${param.f1 eq ''}">selected</c:if>>All Fields</option>
													<option value="title" <c:if test="${param.f1 eq 'title_idx'}">selected</c:if>>Title</option>
													<option value="author" <c:if test="${param.f1 eq 'author_idx'}">selected</c:if>>Author</option>
													<option value="journal" <c:if test="${param.f1 eq 'journal_idx'}">selected</c:if>>Journal Title</option>
													<option value="keyword" <c:if test="${param.f1 eq 'keyword_idx'}">selected</c:if>>Keyword</option>
													<option value="publisher" <c:if test="${param.f1 eq 'flt_publisher_v'}">selected</c:if>>Publisher</option>
												</select>
											</th>
											<td>
												<input type="text" id="v1" name="detailInput1" class="input_txt" value="<c:out value='${param.v1}'/>"  title="첫번째 검색단어입력">
											</td>
											<td>
												<select id="and1" name="selectOption1" class="select fr" title="첫번째 검색조건">
													<option value="and" <c:if test="${param.and1 eq 'and'}">selected</c:if>>AND</option>
													<option value="or" <c:if test="${param.and1 eq 'or'}">selected</c:if>>OR</option>
													<option value="not" <c:if test="${param.and1 eq 'and not'}">selected</c:if>>NOT</option>
											    </select>
											</td>
										</tr>
										<tr>
										  	<th> 
										    	<select id="f2" name="searchCondition2" class="select" title="두번째 검색선택">
										    		<option value="title" <c:if test="${param.f1 eq 'title_idx'}">selected</c:if>>Title</option>
													<option value="author" <c:if test="${param.f1 eq 'author_idx'}">selected</c:if>>Author</option>
													<option value="affiliation" >Affiliation</option>
													<option value="journal" <c:if test="${param.f1 eq 'journal_idx'}">selected</c:if>>Journal Title</option>
													<option value="keyword" <c:if test="${param.f1 eq 'keyword_idx'}">selected</c:if>>Keyword</option>
													<option value="publisher" <c:if test="${param.f1 eq 'flt_publisher_v'}">selected</c:if>>Publisher</option>
										  		</select>
											</th>
											<td>
												<input type="text" name="detailInput2" id="v2" class="input_txt"value="<c:out value='${param.v2}'/>" title="두번째 검색단어입력">												
											</td>
											<td>	
												<select id="and2" name="selectOption2" class="select fr" title="두번째 검색조건">
													<option value="and" <c:if test="${param.and2 eq 'and'}">selected</c:if>>AND</option>
													<option value="or" <c:if test="${param.and2 eq 'or'}">selected</c:if>>OR</option>
													<option value="not" <c:if test="${param.and2 eq 'and not'}">selected</c:if>>NOT</option>
												</select>
											</td>
										</tr>
										<tr>
									  		<th> 
									     		<select name="searchCondition3" id="f3" class="select" title="세번째 검색선택">
									     			<option value="author" <c:if test="${param.f1 eq 'author_idx'}">selected</c:if>>Author</option>
									     			<option value="title" <c:if test="${param.f1 eq 'title_idx'}">selected</c:if>>Title</option>
									     			<option value="affiliation">Affiliation</option>
													<option value="journal" <c:if test="${param.f1 eq 'journal_idx'}">selected</c:if>>Journal Title</option>
													<option value="keyword" <c:if test="${param.f1 eq 'keyword_idx'}">selected</c:if>>Keyword</option>
													<option value="publisher" <c:if test="${param.f1 eq 'flt_publisher_v'}">selected</c:if>>Publisher</option>
									  			</select>
											</th>
											<td>
												<input type="text" name="detailInput3" id="v3" class="input_txt" value="<c:out value='${param.v3}'/>" title="세번째 검색단어입력">
											</td>
											<td>
												<select name="selectOption3" id="and2" class="select fr" title="세번째 검색조건">
												  <option value="and" <c:if test="${param.and3 eq 'and'}">selected</c:if>>AND</option>
												  <option value="or" <c:if test="${param.and3 eq 'or'}">selected</c:if>>OR</option>
												  <option value="not" <c:if test="${param.and3 eq 'and not'}">selected</c:if>>NOT</option>
												</select> 
											</td>
										</tr> 
									
									
										<tr>
											<th class="text">Subject Area</th>
											<td colspan="2">
									    		<select name="subjectArea" id="broadSubject" class="select fr" style="width:100%">
													<option value="all" >All</option>
													<c:forEach var="item" items="${sub_cls}" varStatus="stat">
													<%-- <option value="${item.ref_val2}" >${item.ref_val1}</option> --%>
													<option value="${item.ref_val1}" >${item.ref_val1}</option>
													</c:forEach>
									     		</select>
									     	</td>
									 	</tr>
									 	<tr>
										   	<th class="text">Indexed in</th>
										   	<td colspan="2">
												<dl class="detailSrch_location">
													<dd style="margin-left: 10px">    
													    <label for="category1"><input type="checkbox" name="indexedInList" id="category1" value="MEDLINE" <c:if test="${param.category eq 'INKOREA'}">checked</c:if> />MEDLINE</label>
														<label for="category2"><input type="checkbox" name="indexedInList" id="category2" value="SCI(E)" <c:if test="${param.category eq 'BOOK'}">checked</c:if> />SCI(E)</label>
														<label for="category3"><input type="checkbox" name="indexedInList" id="category3" value="SCOPUS" <c:if test="${param.category eq 'REPORT'}">checked</c:if> />SCOPUS</label>
														<label for="category5"><input type="checkbox" name="indexedInList" id="category5" value="KCI" <c:if test="${param.category eq 'NONBOOK'}">checked</c:if> />KCI</label>                	  
												   </dd>
										 		</dl>
											</td>
									    </tr>
										<tr> 
									    	<th class="text">Publication Type</th>
									      	<td colspan="2" style="position:relative;">
										    	<!-- <input type="text" maxlength="8" title="detailInput4" name="detailInput4"> -->
										    	<select name="detailInput4" id="" class="select fr pubType_sel" style="width:100%" title="PublicationType">
										    		<option value="">All</option>
										    		<option value="">Review</option>
										    		<option value="">Case Reports</option>
										    		<option value="">Editorial</option>
										    		<option value="">Letter</option>
										    	</select>
											</td>
										</tr>
										<tr> 
									    	<th class="text">Publication Date</th>
									      	<td colspan="2" style="position:relative;">
										    	<!-- <input type="text" maxlength="10" id="startDate" title="start_dt" name="startDate" onblur="javascript:fn_validDate(this)"><span class="center_span">-</span> 
												<label for="end_dt" class="hide"></label>
												<input type="text" maxlength="10" id="endDate" title="end_dt" name="endDate" onblur="javascript:fn_validDate(this)"> -->
												<input id="startDate" name="startDate"  class="full" maxlength="4" type="text"  style="width: 20%;text-align: center;" title="PublicationDate"/> - 
												<input id="endDate" name="endDate"  class="full" maxlength="4"  type="text"  style="width: 20%;text-align: center;" title="PublicationDate"/>
											</td>
										</tr>
										<tr> 
									    	<th class="text">Language</th>
									      	<td colspan="2" style="position:relative;">
										    	<!-- <input type="text" maxlength="8" title="Language" name="detailInput5"> -->
										    	<select name="detailInput5" id="" class="select fr lang_sel" style="width:30%" title="Language">
										    		<option value="all">All</option>
										    		<option value="English">English</option>
										    		<option value="Korean">Korean</option>
										    	</select>
										    	
											</td>
										</tr>
										<!-- <tr> 
									    	<th class="text">Publisher</th>
									      	<td colspan="1" style="position:relative;">
										    	<input type="text" maxlength="8" title="Publisher" name="detailInput6">
											</td>
										</tr> -->
									</tbody>
								</table>
								<input name="subCategory" value="in" type="hidden">          
								<input name="fltWhereQuery" value="" type="hidden"/>
								<input name="isNull" value="true" type="hidden">      
								<input name="hstrDiv" value="2" type="hidden">	
								<input name="wkid" value="" type="hidden">	
								
								
								<br/><br/>
							</form>
							
						</div>
					</div><!-- 1 tab end  -->
					
			        <!-- #tab1 -->
			        <div id="tab2" class="tab_content">
			        	<div class="detail_searchFrm">
						 	<form id="journalForm" style="margin:0 auto" name="journalForm" method="post" action="${ctxt}/elib/kom/listJunal.do"  >
								<input type="hidden" name="broadSubject" value=""/>
								<input type="hidden" name="listGbn" value=""/>
								<input type="hidden" name="detailYn" value="Y"/>
								<input type="hidden" name="searchCondition1" value="journal"/>
								<input type="hidden" name="searchCondition2" value="publisher"/>
								<input type="hidden" name="selectOption1" value="and"/>
								
						 		<table class="tblStyle01"style="border-bottom:0;">
						            <colgroup>
										<col style="width:25%">
										<col style="width:75%">
									</colgroup>
						            <tbody style="border-bottom:1px solid #CCDDED">
							  			<tr>
											<th class="text" style="min-width:100px;">Journal Title</th>
											<td>
												<input type='text' class="input_txt"  style="width:97%;background:none;" id="journalinfo" name="detailInput1" onkeypress="javascript:if(event.keyCode==13){fn_search2();}" />
											</td>
								 	 	</tr>
							     		<tr> 
									    	<th class="text">Publisher</th>
									      	<td colspan="1" style="position:relative;">
										    	<input class="jour_srch" type="text"  title="Publisher" style="width:97%;" name="detailInput2">
											</td>
										</tr>
							     		<tr>
					                		<th class="text" style="min-width:100px;">Subject Area</th>
					                		<td>
												<select name="detailInput3" id="broadSubject" class="select fr" style="width:100%; margin:0; padding:0 4%;">
													<option value="" >All</option>
													<c:forEach var="item" items="${sub_cls}" varStatus="stat">
													<option value="${item.ref_val2}" >${item.ref_val1}</option>
													</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<th class="text" style="min-width:100px;">Indexed in</th>
											<td>
												<dl class="detailSrch_location">  
													<dd style="margin-left: 10px">     
											    		<label for="category1"><input type="checkbox" name="detailInput4" id="category1" value="MEDLINE" <c:if test="${param.category eq 'INKOREA'}">checked</c:if> />MEDLINE</label>
														<label for="category2"><input type="checkbox" name="detailInput4" id="category2" value="SCI(E)" <c:if test="${param.category eq 'BOOK'}">checked</c:if> />SCI(E)</label>
														<label for="category3"><input type="checkbox" name="detailInput4" id="category3" value="SCOPUS" <c:if test="${param.category eq 'REPORT'}">checked</c:if> />SCOPUS</label>
														<label for="category5"><input type="checkbox" name="detailInput4" id="category5" value="KCI" <c:if test="${param.category eq 'NONBOOK'}">checked</c:if> />KCI</label>                	  
											   		</dd>
											 	</dl>
											</td>
										</tr>
										<tr> 
									    	<th class="text">Publication Date</th>
									      	<td colspan="2" style="position:relative;">
										    	<!-- <input type="text" maxlength="8" id="startDate" title="start_dt" name="startDate" onblur="javascript:fn_validDate(this)"><span class="center_span">-</span> 
												<label for="end_dt" class="hide"></label>
												<input type="text" maxlength="8" id="endDate" title="end_dt" name="endDate" onblur="javascript:fn_validDate(this)">-->
											 	<input id="startDate2" name="startDate"  class="full"  type="text"  style="width: 48%;" title="PublicationDate"/>-
												<input id="endDate2" name="endDate"  class="full"  type="text"  style="width: 48%;" title="PublicationDate"/>
											</td>
										</tr>
										<tr> 
									    	<th class="text">Volume</th>
									      	<td colspan="1" class="volume_td">
										    	<span style="line-height:40px;width: 20%;">Vol</span>  
										    	<span style="line-height:40px;width: 20%;"><input class="jour_srch" type="text" title="Vol" name="detailInput5"></span>
										    	<span style="line-height:40px;width: 20%;">No</span>    
										    	<span style="line-height:40px;width: 20%;"><input class="jour_srch" type="text" title="No" name="detailInput6"></span>
											</td>
										</tr>    
										<tr>
											<th class="text" style="min-width:100px;">KNLM ID</th>  
											<td>
												<input type='text' class="input_txt jour_srch"  style="width:97%;" id="" name="detailInput7"/>
											</td>
								 	 	</tr>
					              	</tbody>   
					          	</table>
							</form>
						</div>
					</div>     
			        <!-- #tab2 -->
			        
			        <div id="tab3" class="tab_content"></div>
					<!-- #tab3 -->
				</div>
		    	<!-- .tab_container -->
		    	<div class="btn-group" style="margin-top: 50px;">
					<div class="dschBtn">
						<button type="button" id="writeFormSubmit" class='sch_smit' onclick="fn_search1()"><i class="fas fa-search"></i></button>
						<button type="button" id="writeFormSubmit2" style="display: none;" class='sch_smit' onclick="fn_search2()"><i class="fas fa-search"></i></button>
					</div>
					<a href="${ctxt}/elib/kom/listKom.do" style="float: right;margin-bottom:10px;" title="BACK"  class="basic-btn margin_left">Previous</a>
				</div>
		    </div>    
		</div>
	</div>