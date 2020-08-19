<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
var strQuery;

function fn_pdf(pdf_url){	
	window.open(replaceAll(pdf_url,'+','%2B'));
}
function replaceAll(str, searchStr, replaceStr) {
	  return str.split(searchStr).join(replaceStr);
}
    
$(function(){ 
    $(".tab_content").hide(); 
    $(".tab_content:first").show();
    
	 if($('#q_ti').val() != '' || $('#q_au').val() != ''  || $('#q_so').val() != ''  || $('#q').val() != ''){
		fn_search();
	 }
	 //키이벤트
	 $('.search-box input[type=text]').bind('keyup',function(e){if(e.keyCode == 13){fn_search();} });

});  
 
/* 상세 조회 */
function fn_edsMore(type){

	 strQuery = "";  
	 if($('#q_ti').val() != '' ){
		 strQuery = 'TI '+$('#q_ti').val();
	 }
	 if($('#q_au').val() != '' ){
		 if(strQuery != ''){strQuery +=' AND ';}
		 strQuery += 'AU '+$('#q_au').val();
	 }
	 if($('#q_so').val() != '' ){
		 if(strQuery != ''){strQuery +=' AND ';}
		 strQuery += 'SO '+$('#q_so').val();
	 }
	 
	 if($('#q').val() != ''){
		 if($('select[name=field_code] :selected').val() == ''){
			 if(strQuery != ''){strQuery +=' ';}
			 strQuery += $('#q').val();
		 }else{
			 if(strQuery != ''){strQuery +=' AND ';}
			 strQuery += $('select[name=field_code] :selected').val()+' ' +$('#q').val();
		 }
	 }       

	 if(strQuery == ''){
		 alert('검색어를 입력하세요.')
		 return;     
	 }  
   
	 $('#query').val(strQuery);
	 $('#kwd').val(strQuery);  
	 

	if(type == 'all'){
		$('#facetfilter').val('1,SourceType:Academic Journals,SourceType:Books,SourceType:Reports,SourceType:eBooks');
	}else if(type == 'j'){//논문
		$('#facetfilter').val('1,SourceType:Academic Journals');
		$('#action').val('addfacetfilter(SourceType:Academic Journals)');
	}else if(type == 'b'){//소장
		$('#facetfilter').val('1,SourceType:Books');
	}else if(type == 'r'){//리포트     
		$('#facetfilter').val('1,SourceType:Reports');
	}else if(type == 'e'){//ebook
		$('#facetfilter').val('1,SourceType:eBooks,ContentProvider:eBooks');
		$('#action').val('addfacetfilter(SourceType:eBooks)');
	}
	
	var form = document.edsForm;
	form.submit(); 
}

/* 논문검색 조회 */
function fn_search(searchCondition, page){
	 strQuery = "";  
	 if($('#q_ti').val() != '' ){
		 strQuery = 'TI '+$('#q_ti').val();
	 }
	 if($('#q_au').val() != '' ){
		 if(strQuery != ''){strQuery +=' AND ';}
		 strQuery += 'AU '+$('#q_au').val();
	 }
	 if($('#q_so').val() != '' ){
		 if(strQuery != ''){strQuery +=' AND ';}
		 strQuery += 'SO '+$('#q_so').val();
	 }
	 if($('#q').val() != ''){
		 if($('select[name=field_code] :selected').val() == ''){
			 if(strQuery != ''){strQuery +=' ';}
			 strQuery = $('#q').val();
		 }else{
			 if(strQuery != ''){strQuery +=' AND ';}
			 strQuery += $('select[name=field_code] :selected').val()+' ' +$('#q').val();
		 }
	 }

	 if(strQuery == ''){
		 alert('검색어를 입력하세요.')
		 return;     
	 }     
	     
	 $('#query').val(encodeURIComponent(strQuery));  
	     
	 $('#query').val(strQuery);   
	 $('#kwd').val(strQuery);
	  
	var params = {};
		params.query = strQuery;
		params.resultsperpage = 5;
		
		
		   
    $.ajax({
        url: '${ctxt}/elib/eds/searchList.do',
        data: params,
        type: 'POST',
        dataType: 'text',
        cache: false,
        beforeSend:function(){
        	$('#mloader').show();	
        },
        complete:function(){
        	$('#mloader').fadeOut();    
        },   
        success: function(rtnXml) {
        	var html = "";
        	var jsonList = JSON.parse(rtnXml);
        	var resultList = jsonList.resultsList;
        	$(resultList).each(function(cnt){
        		html += '<tr>'
        		html += '<td>'+Number(cnt +1)+'. </td>'
        		var item = this.itemList;
        		var dbid = this.dbId;
        		var pLink = this.pLink;
        		var an = this.an;
        		$(item).each(function(){
        			
        			if(this.label == 'Title'){  
        				var strData = this.data;
        				strData = strData.replace(/(<([^>]+)>)/ig,"");
        				if(strData.length > 100){
        					html += '<td> <a href="${ctxt}/elib/eds/Retrieve?menu=eds&dbid=' + dbid + '&an=' + an +'&kwd='+strQuery+'&target=edshome">' + strData.substring(0,70) + '...</a>';
        					//html += '<td> <a href="javascript:fn_pdf(\''+pLink+'\')">' + strData.substring(0,70) + '...</a>';
        				}else{
        					html += '<td> <a href="${ctxt}/elib/eds/Retrieve?menu=eds&dbid=' + dbid + '&an=' + an +'&kwd='+strQuery+'&target=edshome">' + this.data+ '</a>';
        					//html += '<td> <a href="javascript:fn_pdf(\''+pLink+'\')">' + this.data+ '</a>';
        				}      
        			}        		
        			if(this.label == 'Authors'){    
        				var strData = this.data;
        				strData = strData.replace(/(<([^>]+)>)/ig,"");
        				if(strData.length > 50){
        					html += '<br />'+  '<span class="name">' + strData.substring(0,70) + '...</span>';   
        				}else{
        					html += '<br />' +  '<span class="name">' + strData + '</span>';
        				}        
        				html += '</td>'
        			}        	       
        			  
        		});  
        		html += '</tr>'
			}); 
        	
        	var html2 = "";
        	var resultLists = jsonList.resultsLists;
        	
        	$(resultLists).each(function(cnt){
        		html2 += '<tr>'
        		html2 += '<td>'+Number(cnt +1)+'.</td>'
        		var item = this.itemList; 
        		var dbid = this.dbId;
        		var pLink = this.pLink;
        		var an = this.an;
        		$(item).each(function(){
        			if(this.label == 'Title'){
        				var strData = this.data;
        				strData = strData.replace(/(<([^>]+)>)/ig,"");
        				if(strData.length > 100){
        					//html2 += '<td> <a href="${ctxt}/elib/eds/Retrieve?dbid=' + dbid + '&an=' + an +'&kwd='+strQuery+'&target=edshome">' + strData.substring(0,70) + '...</a>';
        					html2 += '<td> <a href="javascript:fn_pdf(\''+pLink+'\')">' + strData.substring(0,70) + '...</a>';
        				}else{
        					//html2 += '<td> <a href="${ctxt}/elib/eds/Retrieve?dbid=' + dbid + '&an=' + an +'&kwd='+strQuery+'&target=edshome">' + this.data+ '</a>';
        					html2 += '<td> <a href="javascript:fn_pdf(\''+pLink+'\')">' + this.data+ '</a>';
        				}      
        			}        		
        			if(this.label == 'Authors'){    
        				var strData = this.data;
        				strData = strData.replace(/(<([^>]+)>)/ig,"");
        				if(strData.length > 50){
        					html2 += '<br />'+ '<span class="name">' + strData.substring(0,70) + '...</span>';   
        				}else{
        					html2 += '<br />' +  '<span class="name">' + strData +  '</span>' ;
        				}        
        				html2 += '</td>'
        			}       		
        		});  
        		html2 += '</tr>'
			}); 
        	
        	$('#recently_list').html(html);
        	$('#recently_list2').html(html2);
        	$('#searchguide').hide(); 
        	$('#searchArea').fadeIn();    
          
        },
        error : function(){                              // Ajax 전송 에러 발생시 실행
          fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
        }
    });
}

function fn_edsInfo(){
	var url = '${ctxt}/resources/images/eds_info.pdf';
	window.open(url);
}
      
</script>
<style>
table.eds_tb {
font-size: 13px;
}
table.eds_tb a{
 cursor: pointer;
}

table.eds_tb {
    border-collapse: separate;
    border-spacing: 1px;
    text-align: left;
    line-height: 1.4;
    width:90%;
    margin:0 auto;
  /* margin : 20px 10px; */
}
table.eds_tb th {
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
}   
table.eds_tb tr{
	height:63px;
}
table.eds_tb td {
	width:343px;
    padding: 10px;
    vertical-align: top; 
    border-bottom: 1px solid #ccc;
}
table.eds_tb tr:last-child th,
table.eds_tb tr:last-child td{
	border-bottom:0;
}
table.eds_tb td a{
	display:inline-block;
	width:323px;
	white-space: nowrap; 
    overflow: hidden;
    text-overflow: ellipsis; 
    font-size:14px;
}
.rd-search .search-box {
    margin-bottom: 2rem;
    padding: 2rem;
    border: 1px solid #E7E7E7;
    box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.2);
}
.center { 
    text-align: center;
}
input[type='text'].eds-form, input[type='password'].eds-form, input[type='search'].eds-form, input[type='radio'].eds-form, input[type='file'].eds-form {
    width:100%;
    display: block;
    position: relative;
    border: 1px solid #e6ebed;
    border-radius: 2px;
    background-color: #fff;
    -webkit-box-sizing: border-box;
    box-sizing: border-box; 
    font-weight: 300;
    vertical-align: middle;
    white-space: nowrap;
    height: 2.25rem;
    line-height: 2.25rem;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    padding: 0 0 0 10px;
    font-family:"Noto Sans Korean";
    font-weight:200;
}
/* placeholder */
::placeholder {
    color: #ccc;
    opacity: 1; /* Firefox */
    font-family:"Noto Sans Korean";
    font-weight:200;
    letter-spacing:-0.7px;
}

:-ms-input-placeholder { /* Internet Explorer 10-11 */
   color: #ccc;
   font-family:"Noto Sans Korean";
   font-weight:200;
   letter-spacing:-0.7px;
}

::-ms-input-placeholder { /* Microsoft Edge */
   color: #ccc;
   font-family:"Noto Sans Korean";
   font-weight:200;
   letter-spacing:-0.7px;
}
select.eds-form span, .eds-select span {  
    display: inline-block;
    white-space: nowrap;
}
.search-box{
	position:relative;
}
.search-box .row li:after{  
	clear:both;
	display:block;
	content:"";
}
.search-box .row li p{
	float:left;
	padding:0 0 5px 0;
	margin-top:0;
	margin-bottom:0;
} 
.search-box .row li:last-child p{
	padding:0;
}  
.search-box .row{
	width:100%;
	max-width:700px;
	display:inline-block;
	margin:0 auto;
	letter-spacing:-0.5px;
}
.search-box .row .row_left{
	width:25%;
	color: #7f7f7f;
}
.search-box .row_left label{
	width:100%;
	display:block;
	height:36px;
	line-height:36px;
	background: #EBEEF0;
}
.search-box .row_left select{
	width:100%;
    display:block;
    border: 1px solid #e6ebed;
    border-radius: 2px;
    -webkit-box-sizing: border-box;  
    box-sizing: border-box;
    vertical-align: middle;
    white-space: nowrap;
    height: 36px;
    line-height: 36px;
    background-color: #fff;
    cursor: pointer;
    padding-left:10px;
    color: #7f7f7f;
}
.search-box .row_right{
	width:74%;
	margin-left:1%;
}
.sch_smit{
	height:36px;
	line-height:36px;
	margin-bottom: 4px;
	margin-left:0;
}
#searchArea:after{
	display:block;
	content:"";
	clear:both;
}
.content_box>.content_list ul.list_full{
	margin-bottom:30px;
}
.under_bar3{
	margin-bottom:0px;
}
span.name{
    display:inline-block;
	width:323px;
	white-space: nowrap; 
    overflow: hidden;
    text-overflow: ellipsis;
	font-size:12px;
	color:#777;
}

.sidebar-right2 {
	width: 48%;
}
@media all and (max-width:1100px) {
	.rd-search .search-box {
	    padding: 1.5rem;
	}
}
 @media all and (max-width:903px) {
		.rd-search .search-box {
	    padding: 1rem;
	}
}
 @media all and (max-width:880px) {
	.dschBtn {
		    margin-right: 0px;
		}
		.sch_smit{
			margin-bottom:-5px;
		}
}
@media (max-width: 494px){
	.sch_smit{
   		margin-left: -15px;
	}
	.sidebar-right2{
   		width: 100%;
	}
	table.eds_tb td a {
		width: 120%;
		white-space:pre-line;
	}
	span.name {
		width: 120%;   
		white-space:pre-line;	
	}
	table.eds_tb td{  
		width: auto;
	}
	
}    
</style>       
	<div class="sub_center_text">
		    <div class="sub_center_nav"> 
			     <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			     <span> > </span> 
			     <span class="active">전자자원</span>
		    </div>						
			<span href="#" class="center_text_01">전자자원</span>
		</div>   
	<div class="under_bar"></div>
   
	<div class="content_wrap" style="min-height: 500px;">
		<div class="content_box">
			<div class="content_list">
		        <div id="tab1" class="tab_content"><!-- 1 tab start -->
					<div class="rd-search search friendly-search">  
						<form id="edsForm"  style="margin:0 auto;" name="edsForm" action="${ctxt}/elib/eds/listEds.do"  >
							<input type="hidden" id="query" value="" name="query"/>
							<input type="hidden" id="kwd" value="" name="kwd"/>
							<input type="hidden" id="action" value="" name="action"/>
							<input type="hidden" id="searchmode" value="all" name="searchmode"/>
							<input type="hidden" id="pagenumber" value="1" name="pagenumber"/>
							<input type="hidden" id="resultsperpage" value="10" name="resultsperpage"/>
							<input type="hidden" id="includefacets" value="y" name="includefacets"/>
							<input type="hidden" id="autosuggest" value="n" name="autosuggest"/>
							<input type="hidden" id="autocorrect" value="n" name="autocorrect"/>
							<input type="hidden" id="highlight" value="y" name="highlight"/>
							<input type="hidden" id="detailYn" name="detailYn" value="Y" />	
						</form>   
      
					    <input type="hidden" id="facetfilter" value="" name="facetfilter"/>
					    <div class="search-box center">   
					    	<ul class="row">
					    		<li>
					    			<p class="row_left">
										<select name="field_code" class="sort">
						                    <option value="" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;All</option>
						                    <option value="TI">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Title</option>
						                    <option value="SO">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Journals</option>
						                    <option value="AU">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Author</option>
						                    <option value="AB">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Abstract</option>
						                    <option value="IS">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ISSN</option>
						                    <option value="IB">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ISBN</option>
						                </select>
									</p>
					    			<p class="row_right"><input type="text" id="q" name="q" title="검색어 입력" placeholder="검색어 입력" class="eds-search-init eds-form width-one mlk"></p>
					    		</li>
					    		<li>
					    			<p class="row_left"><label>Title</label></p>
					    			<p class="row_right"><input type="text" id="q_ti" name="q_ti" title="제목" placeholder="제목" class="eds-search-init eds-form width-one mlk"></p>
					    		</li>
					    		<li>
					    			<p class="row_left"><label>Author</label></p>
					    			<p class="row_right"><input type="text" id="q_au" name="q_au" title="저자 입력" placeholder="저자명 입력" class="eds-search-init eds-form width-half mlk"></p>
					    		</li>
					    		<li>
					    			<p class="row_left"><label>Journals</label></p>
					    			<p class="row_right"><input type="text" id="q_so" name="q_so" title="저널 입력" placeholder="저널 입력" class="eds-search-init eds-form width-half mlk"></p>
					    		</li>
					    	</ul>
					    	<div class="dschBtn">
								<button type="button" id="writeFormSubmit" class='sch_smit' onclick="fn_search()"><i class="fas fa-search"></i></button>
							</div> 
					    </div>
					</div>
				</div><!-- 1 tab end  -->           
		    	<!-- .tab_container -->
		    
<!-- 		    		<div id="searchguide"  class="content_list">
						<div class="list_title"><p>국립의과학지식센터는 의과학 분야의 수요 높은 핵심 전자정보를 제공합니다.</p></div>
						<ul class="list_full">
							<li class="dashed">web-DB 16종, E-저널 13,000여종 구독 중(2018년도 기준)</li>
							<li class="dashed">방문 이용 시, 모든 구독 전자자원 이용 가능</li>
							<li class="dashed">온라인 이용: 회원 가입 및 전자자원 사용승인 후, 외부 이용 가능 (Web DB, E-저널 6,200여종)</li>
							<li style="font-size:13px;padding-left:25px; margin-top:5px;"><a href="javascript:fn_edsInfo();" >※&nbsp;<2018년 구독 전자자원 목록></a></li>
						</ul>
		    		</div> -->
		    		<div id="searchguide"  class="content_list" style="margin-left:5%;">
						<div class="list_title"><p>국립의과학지식센터는 의과학 분야의 수요 높은 핵심 전자정보를 제공합니다.</p></div>
						<ul class="list_full">
							<li class="dashed">온라인 회원은 약 6,200여종의 전자자원 이용이 가능하며, 방문 하시면 모든 구독 자원 이용이 가능합니다. (2018년 기준)   </li>
							<li style="font-size:13px;padding-left:3%; margin-top:5px;"><a href="javascript:fn_edsInfo();" >※&nbsp;전자자원 이용안내</a></li>
							<li style="font-size:13px;margin-left:4%; margin-top:10px;"><img src="${ctxt}/resources/images/edsIndex.png" style="width:90%;" /></li>
						</ul>     
		    		</div>     
		               
		    	<div id="searchArea" style="display: none;">  
					<div id="sidebar-right2" style="float: left;margin-right: 1%;">   
						<div class = "sideArea" style="height:auto">      
							<div class="sidebar-right-text2">   
								<span  style="vertical-align: middle">학술논문 <a class="more" href="javascript:fn_edsMore('j');">more +</a> </span>	
							</div>  
							<div class="under_bar3"></div>   
							<div style="width : 100%;  height: auto; margin-bottom:7px;">
								<div  class="">
									<table class="eds_tb">
										<tbody id="recently_list">   
										
										</tbody>
									</table>				   
								</div>
							</div>  
						</div>    
					</div>
					 
					<div id="sidebar-right2" style="float: left;margin-left: 2%;">
						<div class = "sideArea" style="height:auto;">
							<div class="sidebar-right-text2">
								<span  style="vertical-align: middle">e-book <a class="more" href="javascript:fn_edsMore('e');">more +</a> </span>	
							</div>
							<div class="under_bar3"></div>
							<div style="width : 100%;  height: auto; margin-bottom:7px;">
								<div  class="">
									<table class="eds_tb">
										<tbody id="recently_list2">   
										
										</tbody>
									</table>				   
								</div>
							</div>  
						</div>    
					</div>
				</div>
		    </div>            
		</div>
	</div>