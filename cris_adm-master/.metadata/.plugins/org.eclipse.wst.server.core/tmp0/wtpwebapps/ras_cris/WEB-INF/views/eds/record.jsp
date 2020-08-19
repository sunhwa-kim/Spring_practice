
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="kr.go.cris.ptl.eds.bean.*" language="java"%>


<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.go.cris.ptl.eds.Helpers.*"%>

<%@page import="org.jsoup.Jsoup"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.io.*"%>
<%@page import="org.json.*"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.log4j.Logger"%> 


<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   

<% RetrieveResponse retrieveResponse = (RetrieveResponse)request.getSession().getAttribute("record");
   Result record = retrieveResponse.getResult();
   String picurl=""; %>
   
<link rel="stylesheet" href="${ctxt}/resources/css/ncmik/edsStyle/style.css" type="text/css" media="screen" />
<link rel="stylesheet" href="${ctxt}/resources/css/ncmik/edsStyle/pubtype-icons.css" type="text/css" media="screen" />

<script type="text/javascript">

	

	function fn_pdf(pdf_url){
		window.open(replaceAll(pdf_url,'+','%2B'));
	}
	function replaceAll(str, searchStr, replaceStr) {
	  return str.split(searchStr).join(replaceStr);
	}

	function fn_view(doi){   
		var l, t;
		l = (screen.width-1000);
		t = (screen.height-700)/2;
		window.open("http://doi.org/"+doi,'_pop','width='+1000+',height='+800+',left='+l+',top='+t+',resizable=0,scrollbars=1');
	}
	
	
	function fn_edsLink(edsLink, text){
		
		var userId = "<c:out value='${userVo.loginid}'/>";
		var innerIp = '${INNER_IP}';
		var exceptionYn = '${EXCEPTION_YN}';
		
		if(text.indexOf("Full Text") != -1 || text.indexOf("proxy_check") != -1){
		   
			if(innerIp == 'Y'){
				window.open(replaceAll(edsLink,'+','%2B'));
			}else if(exceptionYn == 'Y'){
				window.open("http://152.99.73.136/_Lib_Proxy_Url/" +replaceAll(edsLink,'+','%2B'));
			}else{
				if(userId != ''){
					window.open("http://152.99.73.136/_Lib_Proxy_Url/" +replaceAll(edsLink,'+','%2B'));
				}else{
					if (confirm('로그인 후 이용 가능한 서비스 입니다.\n로그인 하시겠습니까?')){ 
						location.href="${ctxt}/login/user/login.do?returnURL=/index/index.do";
					}
				}
			}	
		}else{
			window.open(replaceAll(edsLink,'+','%2B'));
		} 
		
	}
	
	function fn_send(pop_id){ 
		popOpen(pop_id);
	}
	function fn_close(pop_id){ 
		popClose(pop_id);
	}
	
	
	/* 파일생성  */
	function fn_createFile(){
		
		$('#file_type').val($('input[name=save_file]:checked').val());
		
		var file_form = document.file_form;
		

		if($('input[name=save_file]:checked').val() == 'xml'){
			file_form.action="${ctxt}/elib/eds/xmlDownload.do";
		}else{
			file_form.action="${ctxt}/elib/eds/csvDownload.do";
		}

		
		//file_form.action="${ctxt}/elib/kom/searchOutput.do";
		file_form.submit(); 
		
	}
	
	
	function fn_multiSave() {

		var chk_mylib_cnt = 0;
		var mylibChk = "";

		if ("${userVo.emplyrnm}" == "") {
			if (confirm("내서재 담기 기능을 선택하실 경우 로그인 하셔야합니다.\n로그인 화면으로 이동하시겠습니까?")) {
				location.href = "${ctxt}/login/user/login.do;"; //?searchCondition="+$('#searchCondition option:selected').val()+"&searchKeyword="+$('#searchKeyword').val();
				return;
			} else {
				return;
			}
		}

		var list = [];
		

		
		var edsurl = $("input[name=edsUrl]").val();
		var edsdbid = $("input[name=edsDbid]").val();
		var edsan = $("input[name=edsAn]").val();
		var edsti = $("input[name=edsTi]").val();
		var edsau = $("input[name=edsAu_mylib]").val();
		var edsyear = $("input[name=edsYear]").val();

		list[0] = {
			"edsurl" : edsurl,
			"edsdbid" : edsdbid,
			"edsan" : edsan,
			"edsti" : edsti,
			"edsau" : edsau,
			"edsyear" : edsyear
		}
			

			

		var sendList = {
			"list" : list
		};

		$.ajax({
			url : "${ctxt}/mylib/lib/edsMultiMylibSave.do",
			data : JSON.stringify(sendList),
			processData : false,
			type : 'POST',
			traditional : true,
			cache : false,
			dataType : 'json',
			success : function(data) {
				if (confirm("선택하신 총 " + "1"
						+ "건 중\n내 서재 담기에 성공한 건수: " + data.sucCnt
						+ "건\n이미 내 서재에 등록된 건수(내 서재 담기에 실패한 건수): " + data.dupCnt
						+ "건 \n입니다.\n\n※ 내 서재 화면으로 이동하시겠습니까?")) {
					location.href = "<c:url value='/mylib/lib/listMyLib.do'/>";
					return;
				} else {
					
					return;
				}
			}
		});

	}

</script>
 <style>
 	.view_table{
 
 	}
 	.view_table th{
 		background:none;
 		border-right:0;
 		font-size: 13px;
	    color: #333;
	    padding-left:20px;
 	}
 	.view_table td{
	    line-height:150%;
 	}
 </style>

</head>
	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>통합검색</span>
			<span> > </span>
			<span class="active">전자자원</span>        
		</div>      
		<span class="center_text_01">전자자원 상세</span>
	</div> 
	<div class="under_bar"></div>
	
	<div class= "content_wrap">
		<div class="content_box">
			<div class="content_list">
				<div class="record table full" style="margin:0;"> 
					<% 
					String accessGbn = "ok"; 
				  	String url="";
				  	String  urlName = "";
                    List<HashMap<String,String>> listMap = null;
                    %>
					<% if(retrieveResponse.getApiErrorMessage()!=null){
                    ApiErrorMessage aem=retrieveResponse.getApiErrorMessage();
                    String errorString=aem.getErrorDescription();%>
					<h1>
						<%out.println(errorString);%>
					</h1>
					<%}else{
                    ArrayList<Item> itemList=record.getItemList();
                    String title="";
                   
                    
                    for(Item dItem : itemList){
                	   if(dItem.getGroup().equals("Ti")){
                            title = dItem.getData();
                            break;
                        }
                	   if(dItem.getGroup().equals("URL")){  
                       	listMap = new ArrayList<HashMap<String,String>>();
                       	HashMap<String,String> map = null;
                       	url= dItem.getData();
                       	urlName = dItem.getLabel();
                       	int pos = url.indexOf("linkTerm");

	                       	while(pos != -1){
	                       		map = new HashMap<String,String>();
	                       		
	                       		url.substring(pos +10, url.indexOf("\"", pos +11));
	                       		map.put("linkTerm",url.substring(pos +10, url.indexOf("\"", pos +11)));
	                       		map.put("linkLabel", urlName);
	                       		listMap.add(map);                 		
	                       	    pos =  url.indexOf("linkTerm", pos + 1); 
	                       	}                            
                       } 
                    } %>
					<div class="list_title">
						<p id="search_cn"><%out.println(title);%></p>
					</div>
					
					<div class="Discovery_box">
						<div class="links">						
							
								<%-- <a  class="eds" href="http://search.ebscohost.com/login.aspx?direct=true&site=eds-live&db=<%=record.getDbId()%>&AN=<%=record.getAn()%>"> --%>
							
								<%-- <a class="eds" href="javascript:fn_pdf('http://search.ebscohost.com/login.aspx?direct=true&site=eds-live&db=<%=record.getDbId()%>&AN=<%=record.getAn()%>');">
								<!-- View in  -->More+
								</a> --%>
							
								 <!-- ****** str ******  -->
								<%if(record.getPdfAvailable().equals("1") || record.getEbookPdfAvailable().equals("1") || record.getEbookPubAvailable().equals("1") || record.getHtmlAvailable().equals("1") || !record.getOtherFullTextLinks().isEmpty()){ %>
								
									<!-- <label>Full Text:</label> -->
									<%
									 if(record.getHtmlAvailable().equals("1")){%>
										<span><a class="html fulltext" href="#html">HTML<!--  FullText --></a></span>
									<%}%> 
									
									<%if(record.getPdfAvailable().equals("1")){ %>
									<span><a class="pdf fulltext" href="javascript:fn_pdf('<%=record.getPdfLink()%>');" >PDF<!--  Full Text --></a></span>	                         
									<%} %>
									
									<%if(record.getEbookPdfAvailable().equals("1")){ %>
									<span><a class="pdf fulltext" href="javascript:fn_pdf('<%=record.getEbookPdfLink()%>');" >PDF<!--  Full Text --></a></span>	                         
									<%} %>
									
									<%if(record.getEbookPubAvailable().equals("1")){ %>
									<span><a class="pdf fulltext" href="javascript:fn_pdf('<%=record.getEbookPubLink()%>');" >EPUB<!--  Full Text --></a></span>	                         
									<%} %>
									
									
									<%																		
		                        	if(!record.getOtherFullTextLinks().isEmpty()){  
		                        	    for(Link link : record.getOtherFullTextLinks()){ %>
									<span>
										<%-- <a class="fulltext add" href="<%=link.getUrl()%>"><%=link.getType()%> --%>
										<a class="fulltext add" href="javascript:fn_pdf('<%=link.getUrl()%>');"><%=link.getType()%>
										<!-- Full Text --></a></span>
										<%}   
	                        		}%>
	                        		
								<%
								} 
																						
								%>
							    <!-- ***** end ***** -->						
								<!-- FullText 추가 이고장님 -->
							  <%
								if(record.getFullTextList() != null){
									  if(record.getFullTextList().size()>0){
									  	for(FullTextRas fullTextRas : record.getFullTextList()){								  		
									  %>
									 	 	<%-- <%=fullTextRas.getAvailability()%>  --%>
									     <%
									     if(fullTextRas.getFullTextRas() != null){						     		
								     		if(fullTextRas.getFullTextRas().size() >0){
										  		for(FullTextCustomLink fullTextCustomLink : fullTextRas.getFullTextRas()){		
										  			if(fullTextCustomLink.getText().indexOf("Access") >  0 ){
										  				accessGbn = "no";
										  			}
										  			String reUrl = fullTextCustomLink.getUrl().replaceAll("%27","");
											  %>	
											  
											   <a  class="fulltext" href="javascript:fn_edsLink('<%=reUrl%>','proxy_check')"><img src="<%=fullTextCustomLink.getIcon()%>"><span class="btn_name"><%=fullTextCustomLink.getText()%></span>	<!--  Full Text --></a>				   
											    			   	 
												<%--    	
													<%=fullTextCustomLink.getName()%>    
												   	<%=fullTextCustomLink.getCategory()%> 
												   	<%=fullTextCustomLink.getText()%>							   	 
												   	<%=fullTextCustomLink.getMouseOverText()%>  
											   	--%>
										   	 <%  
									  		}
									  	}
									  }					  	
								  	}
								  }
							  }
							  %>
						    <!-- FullText end 추가 이고장님 -->
						    
						   
						    
						    <!-- ***** str ***** -->
						     <%
						     if(listMap != null){
		 				  		for(HashMap map : listMap){
	                        	   if(accessGbn == "no"){ // 앞에 OpenAccess 가 있으면  없애자
	                        		   accessGbn = "ok";
	                        	   }else{
	                        		   %>
	                                   <a class="fulltext ebook_pdf" style="height: 20px;" href="javascript:fn_pdf('<%=map.get("linkTerm")%>')"><span class="btn_name"><%=map.get("linkLabel")%> </span><!--  Full Text --></a>
                      	       	 <%}	   
                        	    }
		 				  		
		 				 	 }  
						     
						     %>
						     <!-- ***** end ***** -->
						      
							 <!-- ***** str ***** -->
							<%						
							  if(!record.getCustomLinkList().isEmpty()) {
                                  for(CustomLink clink : record.getCustomLinkList()){
	                                   	if(StringUtils.equals("등재",clink.getText())){                         		
	       		                       %>
	       		                       <a  class="fulltext ebook_pdf" style="height: 20px;" href="javascript:fn_edsLink('<%=clink.getUrl()%>','proxy_check')"><img src="<%=clink.getIcon()%>" style="height:13px;margin-top:4px;"></a>
       								   <%  
	       	                           }else{	       	                        	   
    	                        	   	%>
       	                               <a  class="fulltext ebook_pdf" style="height: 20px;" href="javascript:fn_edsLink('<%=clink.getUrl()%>','proxy_check')"><img src="<%=clink.getIcon()%>"><span class="btn_name"><%=clink.getText()%></span></a>
       	        					   	<%     
	       	                           }
                                   }                                
                          	   }
							%>
							<!-- ***** end *****  -->
							
							
						</div>
						<div class="under_bar media_bar" ></div>
						<div>	
							<div class="button_box" style="padding-top:2px;text-align:right;">	
								<a href="#" onclick="javasctipt:fn_multiSave();"><i class="fas fa-book"></i>내서재담기 </a> 				
								<a href="#" onclick="javascript:fn_send('popup_file');"><i class="far fa-share-square"></i>내보내기</a>	
								
							
							</div>
							<div class="schedule2" id="popup_file" style="top: 120px;">
									<div class="main-title">
										File  
										<ul class="sub" id="fillter_article" style="list-style: none;padding: 0;margin: 0;">
											<!--<li class="on"><input type="radio" name="save_file" value="" />RIS<br /></li>
											<li class="on"><input type="radio" name="save_file" value="" />Bibtex<br /></li> -->  
											<li class="on"><input type="radio" name="save_file" value="csv" />CSV<br /></li>
											<li class="on" style="margin-top: 3px;"><input type="radio" name="save_file" value="xml" />XML<br /></li>
											<li class="on" style="margin-top: 3px;"><input type="radio" name="save_file" value="nbib" />NBIB<br /></li>
											<li class="on"></li>
											<li class="on" style="margin-top: 3px;"><button style="margin-left: 5%;" type="button" id="excelUp" onclick="fn_createFile()">파일생성</button>
											<button style="margin-left: 5%;" type="button" id="excelUp" onclick="fn_close('popup_file');">닫기</button></li>
										</ul>
									</div>
								</div>									
						</div>
							<%-- <div style="border:1px solid #f0f;">
								<ul class="table-cell-box">
									<li>
										<a href="http://search.ebscohost.com/login.aspx?direct=true&site=eds-live&db=<%=record.getDbId()%>&AN=<%=record.getAn()%>">
										View in EDS </a>
									</li>
								</ul>
								<%if(record.getPdfAvailable().equals("1") || record.getHtmlAvailable().equals("1") || !record.getOtherFullTextLinks().isEmpty()){ %>
								<ul class="table-cell-box">
									<!-- <label>Full Text:</label> -->
									<hr>
									<%if(record.getPdfAvailable().equals("1")){ %>
									<li><a class="icon pdf fulltext"
										href=<%=record.getPdfLink()%>>PDF Full Text</a></li>
									<%} 
		                            if(record.getHtmlAvailable().equals("1")){%>
									<li><a class="icon html fulltext" href="#html">HTML Full
											Text</a></li>
									<%}
		                        	if(!record.getOtherFullTextLinks().isEmpty()){
		                        	    for(Link link : record.getOtherFullTextLinks()){ %>
									<li><a class="icon fulltext" href="<%=link.getUrl()%>"><%=link.getType()%>
											- Full Text</a></li>
									<%}
		                        }%>
								</ul>
								<%} %>
							</div> --%>
					<div class="Discovery_content">
						<table class="view_table">
							<tbody class="report">
							<caption></caption>
							<colgroup> 
								<col width='20%' />						
								<col width='*' />
							</colgroup>
							<%for(Item item : itemList){
                            String data =item.getData();
                            if(item.getGroup().equals("Au")||item.getGroup().equals("Su")||item.getGroup().equals("Ca")){
                        	   //String value=SearchLinkBuilder.buildLink(item.getData());
                        	   String value=item.getData();
                        	   %>
								<tr>
									<th class="th"><%out.println(item.getLabel()+"");%></th>
									
									<%
										if(StringUtils.equals(item.getLabel(), "Authors")){
											//String[] authVal = value.split(";");	
											%>
											<td>
											<%
											
											if(!value.equals("")) {											
											//	System.out.println("value = " + value);
					                        	int searchKey = value.indexOf("<searchLink fieldCode=\"AU\"");
					                        	int searchKey2 = value.indexOf("<searchLink fieldCode=\"AR\"");
					                        	String idxKey = "<searchLink fieldCode=\"AU\"";
					                        	String idxKey2 = "</searchLink>";
					                        	if( searchKey != -1){
					                        		idxKey = "<searchLink fieldCode=\"AU\"";
					                        		idxKey2 = "</searchLink>";
					                        	}else if( searchKey2 != -1){
					                        		idxKey = "<searchLink fieldCode=\"AR\"";
					                        		idxKey2 = "</searchLink>";
					                        	}
					                        	
					                            int idx = value.indexOf(idxKey);
					                            int start = 0;
					                            int end = 0;
					                            int valueleng =0;
					                            String valueList = "";
					                            while(idx != -1){
					                         	   
					                         	   start = value.indexOf(">",idx);
					                         	   end = value.indexOf(idxKey2,idx);
					                         	   idx = value.indexOf(idxKey,idx+1);
					                         	//  System.out.println("222222 = = "+value);
					                         	   //if(3 > valueleng){
					                         		   if(valueleng > 0){
					                         			   valueList += ";";
					                         		   }  
					                         		 //  System.out.println("1111111 = = "+value);
					                         		   valueList += value.subSequence(start +1, end);
					                         		   
					                         	 //  }   
					                         	   valueleng++; 
					                            }
					                           // System.out.println("valueList= "+valueList);
					                            if(StringUtils.isNotBlank(valueList)){
					                            	  
					                            	String[] authVal = valueList.split(";");
					                            	for(int i=0; i < authVal.length; i ++){
					                            	
					                            		%>
					                            			<a href = "${ctxt}/search/AdvancedSearch.do?query-1=AND&action=AddQuery(AND,AU:<%=authVal[i].replaceAll(",","").replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "") %>)"><%=authVal[i]+"; "%></a>
					                            		<% 		
					                            	}					                            	
					                            }      							
											}
																				
											%>
											</td>	
											<%
										}else if(item.getGroup().equals("Su")){
											%>
											<td><%=value%></td>
									<%	
										}else{
									%>		
									<td><%=value%></td>
									<%
										}
									%>																	
								</tr>
							<%}else if(!item.getGroup().equals("Ti")){ %>
								<tr>
									<th class="th"><% out.println(item.getLabel()+"");%></th>
									<%
										if(item.getLabel().equals("DOI")){
											int linkidx = data.indexOf("linkWindow");
											if(linkidx != -1){
												data = data.substring(linkidx + 12 , data.indexOf("\"",linkidx + 13));
											}
									%>
										<td><a href="javascript:fn_view('<% out.println(data);%>')" style="cursor:pointer;"><% out.println(data);%></a></td>
									<%}else{ %>
									
										<td><% out.println(data);%></td>
									<%}%>  
								</tr>
								<%
                           	 }
                         }%>
							</tbody>
						</table>
						<%if(record.getHtmlAvailable().equals("1")){ %>
						<div id="html" style="margin-top: 30px">
								${htmlFullText}
<%-- 							<%out.println(record.getHtmlFullText()); %> --%>
<%-- 						<c:out value="<%=record.getHtmlFullText()%>" escapeXml="true" /> --%>


						</div>
						<%} %>
					</div>
					</div>
					<% String bookJacket ="";
                   if(record.getBookJacketList().size()>0){
                       for(int b=0;b<record.getBookJacketList().size();b++){
                	      if(record.getBookJacketList().get(b).getSize().equals("medium")){
                		     bookJacket = record.getBookJacketList().get(b).getTarget();
                             break;
                           } 
                	   }
                   }
                   if(!bookJacket.isEmpty()){%>
					<div class="jacket">
						<img src="<%=bookJacket%>" width="150px" height="200px" />
					</div>
					<%
                  }
                 }
                 %>
				</div>
				<div class="btn-group">  
					<a href="javascript:history.back();" class="basic-btn" title="목록">
						<%out.println("목록");%>
					</a>
				</div>  
				<!-- end record table -->
			</div>
			<!-- end topatabcontent -->
		</div>    
		<!--  end content -->
	</div>
	<!--  end container  -->
	
	<!-- file_form  -->
	<form  id="file_form" name="file_form" action="" >			
			<input type="hidden" id="file_type" name="file_type" value="">		
	</form>
	
	<!-- 내서재 담기 PARAM  STR -->
	<input type="hidden" id="edsUrl" name="edsUrl" value="${ctxt}/search/Retrieve">
	<input type="hidden" id="edsDbid" name="edsDbid" value="<%=record.getDbId()%>">
	<input type="hidden" id="edsAn" name="edsAn" value="<%=record.getAn()%>">
	
	<%
	String edsYear=  "";
	String edsTit=  "";
	String edsAu = "";
	if(record.getRecordInfo().size() > 0){
		if(StringUtils.isNotBlank(record.getRecordInfo().get(0).getDate_year()) 
				&& !StringUtils.equals(record.getRecordInfo().get(0).getDate_year(),"null")){
			edsYear = record.getRecordInfo().get(0).getDate_year();
		}else{
			edsYear = "";
		}
		
		if(StringUtils.isNotBlank(record.getRecordInfo().get(0).getTitle_full()) 
				&& !StringUtils.equals(record.getRecordInfo().get(0).getTitle_full(),"null")){
			edsTit = record.getRecordInfo().get(0).getTitle_full();
		}else{
			edsTit = "";
		}
		
		if (record.getRecordInfo().get(0).getRecordHasConRel() != null) {
			if (record.getRecordInfo().get(0).getRecordHasConRel().size() > 0) {
				for (RecordHasConRel recordHasConRel : record.getRecordInfo().get(0).getRecordHasConRel()) {
					edsAu = recordHasConRel.getNameFull();
					break;
				}				
			}
		}
	} 
	%>
	
	<input type="hidden" id="edsYear" name="edsYear" value="<%=edsYear%>">
	<input type="hidden" id="edsTi" name="edsTi" value="<%=edsTit%>">
	<input type="hidden" id="edsAu_mylib" name="edsAu_mylib" value="<%=edsAu%>">
	<!-- 내서재 담기 PARAM  END -->