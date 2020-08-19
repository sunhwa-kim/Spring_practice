<meta http-equiv="x-ua-compatible" content="IE=edge; charset=UTF-8">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="kr.go.cris.commons.utils.CommonUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true" %>



<script type="text/javascript">

	
	function getContentValue(xmlElement, tagName) {
		xmlElement = $(xmlElement);
		var nodeList = xmlElement.find(tagName);
		
		var returnValue = null;
		if(nodeList.length){		
			var node = $(nodeList[0]);
			returnValue = node.text();
		}
		 
		return returnValue;
	}
	
	
	
	
	function getContentValueDOI(xmlElement, tagName) {
		xmlElement = $(xmlElement);
		var nodeList = xmlElement.find(tagName+'[EIdType="doi"]');
		
		var returnValue = null;
		
		if(nodeList.length){
			var node = $(nodeList[0]);
			returnValue = node.text();
		}
		return returnValue;
	}
	
	
	
	function getXmlData(Uid){
		
		var url = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?retmode=xml";
		var data = {
			"db": "pubmed",
			"id": Uid,
			"api_key" : "8a6f7ad390de25d3de3133fa95d7eead9d09"
		};
		
		if ('XDomainRequest' in window && window.XDomainRequest !== null) {// IE8 & 9 only Cross domain request
			url += "?" + $.param(data);
			
			var xdr = new XDomainRequest(); // Use Microsoft XDR
			
			xdr.onerror = function() {
				console.log("error!");
			};
			xdr.onprogress = function() {};
			xdr.onload = function () {
				var data = xdr.responseText;
				data = $.parseXML(data);
				
				$('#pubmedArea').html(data)
				//success(data);
			};
			
			xdr.open('GET', url, false);
			xdr.send();
		}else{
			$.ajax({
				"url": url,
				"type": 'POST',
				"data": data,
				"dataType": "xml",
				"success": function(result){
					
						console.log(result);	
						
						var xmlDoc = $(result);
						var documentSummary = xmlDoc.find("PubmedArticleSet");
						var dataChk = xmlDoc.find("ArticleTitle");
						
						if(dataChk.length > 0){
						
							var str_journal = "";
							str_journal += getContentValue(documentSummary, "MedlineJournalInfo > MedlineTA")+". ";
							str_journal += getContentValue(documentSummary, "PubDate > Year");
							if(getContentValue(documentSummary, "PubDate > Month") != null){ str_journal+= " " + getContentValue(documentSummary, "PubDate > Month") };
							if(getContentValue(documentSummary, "PubDate > Day") != null){ str_journal+= " " + getContentValue(documentSummary, "PubDate > Day") };
							
							if(getContentValue(documentSummary, "Volume") != null){ str_journal+= ";" + getContentValue(documentSummary, "Volume") };
							if(getContentValue(documentSummary, "Issue") != null){ str_journal+= "(" + getContentValue(documentSummary, "Issue") + ")" };
							
							if(getContentValue(documentSummary, "MedlinePgn") != null){ str_journal+= ":" + getContentValue(documentSummary, "MedlinePgn")  };
							
							if(getContentValue(documentSummary, "ELocationID") != null){ str_journal+= ". doi: " + getContentValueDOI(documentSummary, "ELocationID") };
							
							
							$('#Journal').html(str_journal );
							
							$('#ArticleTitle').html(getContentValue(documentSummary, "ArticleTitle"));
							
							$('#MedlineTA').html(getContentValue(documentSummary, "MedlineTA"));
							
							
							/* 민규 */
							/* 저자 소속기관 */
							var affiliation_Array = new Array();
							$(documentSummary.find("Affiliation")).each(function(cnt){
								affiliation_Array.push($(this).text());
							});
							affiliation_Array = affiliation_Array.reduce(function(a,b){if(a.indexOf(b) < 0)a.push(b);return a;},[]);
							for(var i=0; i < affiliation_Array.length; i++){
								if(i > 0 ) { 
									$('#affiliation').append("<br />") 
								}
								$('#affiliation').append(i+1+". " +affiliation_Array[i]);
							}
							
							/* 저자 정보*/
							var nodeList = documentSummary.find("Author");
												
							var auth_list ="";
							$(nodeList).each(function(cnt){
								if(cnt > 0){
									auth_list +=", "
								}
								var sub_info = "";
								$(this).find('AffiliationInfo').each(function(cnt2){
									if(cnt2 > 0){
										sub_info += ','
									}
									sub_info += jQuery.inArray($(this).find('Affiliation').text(), affiliation_Array) +1 ;
								});
								
								auth_list += $(this).find('LastName').text() +  " "+ $(this).find('Initials').text()+"<sup>"+sub_info+"</sup>";
								
							});
							
							$('#author').html(auth_list);
							
							var abstractText = "";						
							$(documentSummary.find("AbstractText")).each(function(cnt){
								if(cnt > 0 ){ abstractText += "<br />" };
								if( $(this).attr("Label") != null ){
									abstractText += $(this).attr("Label")+" : " +$(this).text();	
								}else{
									
									//abstractText += replaceStr($(this).text());
									abstractText += $(this).text();
									
									//abstractText += replaceStr($(this).html());
									//var a = result.getElementsByTagName("AbstractText")[0].innerHTML;
									//console.log(result.getElementsByTagName("AbstractText")[0].innerHTML);
									//console.log(this.innerHTML);
									//abstractText += a;
									
									
									
// 									var xmldom = $.parseXML('<gt>aa<sup>1</sup></gt>');
// 									$('#abstract').html($(xmldom).find("gt").text());
// 									console.log($(xmldom).find("gt").text());
									
// 									var ss = $(this).clone();
// 									alert( $(this).clone() );
									
									
									
//									abstractText += $(ss).html(); 
									
									
									
// 									var a = result.getElementsByTagName("AbstractText")[0].innerHTML;
// 									console.log(a);
// 									alert(a);
// 									abstractText += a;
// 									$('#abstract').html(a);
									
								}
							});
							
							
							var keyword = "";						
							$(documentSummary.find("Keyword")).each(function(cnt){
								if(cnt > 0 ){ keyword += "; " };
								keyword += $(this).text();
							});
							$('#abstract').html(abstractText);
							

							
							
							$('#keyword').html(keyword);
							$('#pmid').html(documentSummary.find('ArticleId[IdType=pubmed]').text());
							
							var doi = documentSummary.find('ArticleId[IdType=doi]').text();
							$('#doi').html( "<a rel='noopener noreferrer' href='//doi.org/"+doi+"' target='_blank'  >"+doi+"</a>" );
							
					
					}else{
						$('#ArticleTitle').html("조회된 내용이 없습니다.");
					}
				
				
				
				
				},
				"error": function(request,status,error) {
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
	}
	
	$(function() {
		getXmlData("${Uid}");
	});
	
	
	
	function replaceStr(str){
		
		console.log(str);
// 		str = str.replace(/</g,"&lt;");
// 		str = str.replace(/>/g,"&gt;");
// 		str = str.replace(/\"/g,"&quot;");
// 		str = str.replace(/\'/g,"&#39;");
// 		str = str.replace(/&amp;/g, '&');
		
		str = str.replace(/</g, "<");
 		str = str.replace(/>/g, ">");
		
		
		return str; 
	}
	
	
	
	
</script>
<form name="historyForm" method="get" action="${ctxt}/search/searchPubmed.do" >	
	<input type="hidden" name="searchQuery" value="${param.kwd}"/>
	<input type="hidden" name="category" value="${param.category}"/>
	<input type="hidden" name="subCategory" value="${param.subCategory}"/>
	<input type="hidden" name="pageNum" value="${param.pageNum}"/>
	<input type="hidden" name="fltGetCnt" value="${param.fltGetCnt}"/>
</form>

<style>
</style>

		<div class="sub_center_text">
		     <div class="sub_center_nav">   
		      <span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
		      <span> > </span> 
		      <span>통합검색</span>
		      <span> > </span>
		      <span class="active">PubMed</span>             
		     </div>
		     <span class="center_text_01">PubMed 상세</span>
		</div> 
	
	<div class="under_bar"></div>	
		
		<div class= "content_wrap">
			<div class="content_box">
				<div class="content_list">
					
					<div class="list_title">
						<p id="ArticleTitle" ></p>
					</div>
					
					<div>
						<p id="Journal"></p>					
					</div>
					
					<table class= "view_table"  id="userOff">
					<caption>PubMed 상세</caption>
					<colgroup>
						<col width="15%">
					</colgroup>
					<tbody class="report">
						<tr>
							<th>Authors</th>
							<td><span id="author"></span></td>
						</tr>
						<tr>
							<th>Author information</th>
							<td><span id ="affiliation"></span></td>
						</tr>
						<tr>
							<th>Abstract</th>
							<td><span id="abstract"></span></td>
						</tr>
						<tr>
							<th>Keywords</th>
							<td><span id="keyword"></span></td>
						</tr>
						<tr>
							<th>DOI</th>
							<td><span id="doi"></span></td>
						</tr>
						<tr>
							<th>PMID</th>
							<td><span id="pmid"></span></td>
						</tr>
					
					
					</table>
					
				
				
	<div class="btn-group"> 
		<a href="javascript:history.back(-1)" class="basic-btn" title="목록">목록</a>
	</div>			
	
			</div>
		</div>
	</div>
			
	



