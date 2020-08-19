<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="kr.go.cris.commons.utils.CommonUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true" %> 
<script type="text/javascript" src="<c:url value='/resources/js/search/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/search/search.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/search/pagenav.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/search/searchedkwd.js'/>"></script>
	
<script type="text/javascript">

	var pageNum = "${param.pageNum}" == '' ? 1 :"${param.pageNum}";

	var pubmedResult = {
		"pubmedArea": null,
		"category": "PUBMED",
		"subCategory": "all",
		"pageNum": pageNum,
		"keyWord": "${searchQuery}", //"${param.kwd}",
		//"keyWord": "science",
		//검색어에 2008[pdat] 발행년도를 넣어서 조회할수 있다
		//[journal]+AND+breast+cancer+AND+2008[pdat]
		//science[journal]+AND+breast+cancer+AND+2008[pdat]
		
		"getPubmedInfo": function(id, callBack, cnt) {
			var $p = pubmedResult;
			
			var url = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi";
			var data = {
				"db": "pubmed",
				"version": "2.0",
				"id": id,
				"api_key" : "8a6f7ad390de25d3de3133fa95d7eead9d09"
			};
			
			var success = function(xml) {
 				console.log(xml);
 				
				var xmlDoc = $(xml);
				var documentSummary = xmlDoc.find("DocumentSummary");
				
				var pubmedInfo = {
					"uId": id,
					"pubDate":			$p.fn.getContentValue(documentSummary, "PubDate"),
					"ePubDate":			$p.fn.getContentValue(documentSummary, "EPubDate"),
					"source":			$p.fn.getContentValue(documentSummary, "Source"),
					"lastAuthor":		$p.fn.getContentValue(documentSummary, "LastAuthor"),
					"title":			$p.fn.getContentValue(documentSummary, "Title"),
					"BookTitle":		$p.fn.getContentValue(documentSummary, "BookTitle"),
					"sortTitle":		$p.fn.getContentValue(documentSummary, "SortTitle"),
					"nlmUniqueID":		$p.fn.getContentValue(documentSummary, "NlmUniqueID"),
// 					"recordStatus":		$p.fn.getContentValue(documentSummary, "RecordStatus"),
					"pubStatus":		$p.fn.getContentValue(documentSummary, "PubStatus"),
					"pmcRefCount":		$p.fn.getContentValue(documentSummary, "PmcRefCount"),
					"fullJournalName":	$p.fn.getContentValue(documentSummary, "FullJournalName"),
					"viewCount":		$p.fn.getContentValue(documentSummary, "ViewCount"),
					"docType":			$p.fn.getContentValue(documentSummary, "DocType"),
					"sortPubDate":		$p.fn.getContentValue(documentSummary, "SortPubDate"),
					"sortFirstAuthor":	$p.fn.getContentValue(documentSummary, "SortFirstAuthor"),
					
					"volume":			$p.fn.getContentValue(documentSummary, "Volume"),
					"issue":			$p.fn.getContentValue(documentSummary, "Issue"),
					"pages":			$p.fn.getContentValue(documentSummary, "Pages"),
					"eLocationID":		$p.fn.getContentValue(documentSummary, "ELocationID"),
					
					"authors": 			$p.fn.getContentArray(documentSummary, "Authors"),
					"articleIds": 		$p.fn.getContentArray(documentSummary, "ArticleIds"),
					"history": 			$p.fn.getContentArray(documentSummary, "History"),
					
					"lang": 			$p.fn.getContentValue(documentSummary, "Lang > string"),
					"pubType": 			$p.fn.getContentValue(documentSummary, "PubType > flag"),
				};
					
				
				callBack(pubmedInfo,cnt);
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
					
					success(data);
				};
				
				xdr.open('GET', url, false);
				xdr.send();
			}
			else {
				$.ajax({
					"url": url,
					"type": 'get',
					crossDomain: true,
 					//"async": "false",
 					async: true,
					"contentType": "application/x-www-form-urlencoded; charset=utf-8",
					"data": data,
					"success": success,
					"error": function(request,status,error) {
						console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
			}
		},
		"getPubmedList": function(term, retMax, retStart, callBack) {
			var url = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi";
			var data = {
				"db": "pubmed",
				"term": term,
				"RetStart": retStart,
				"RetMax": retMax,
				"api_key" : "8a6f7ad390de25d3de3133fa95d7eead9d09"
			};
			
			var success =  function(xml) {
				
				var xmlDoc = $(xml);
				var ids = xmlDoc.find("eSearchResult > IdList > Id");
				var count = xmlDoc.find("eSearchResult > Count");
				pubCnt =count.text() * 1;
				
				if(pubCnt == 0){
					$("#pubmedArea").html('<div class="not_found">' + "검색조건에 해당하는 결과가 없습니다. 다른 검색조건을 선택해 주세요." + '</div>');
				}
				
				//console.log(xml);
				var pubmedList = {
					"count": count.text() * 1,
					"ids": [],
				};
				
				if (ids) {
					$.each(ids, function(i,id){
						id = $(id);
						id = id.text();
						
						pubmedList.ids.push(id);
					});
				}
				
				callBack(pubmedList);
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
					
					success(data);
				};
				
				xdr.open('GET', url, false);
				xdr.send();
			}
			else {
				$.ajax({
					"url": url,
					"type": 'get',
					crossDomain: true,
// 					"async": false,
					async: true,
					"contentType": "application/x-www-form-urlencoded; charset=utf-8",
					"data": data,
					"dataType": "xml",
					"success": success,
					"error": function(request,status,error) {
						console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
			}
		},
		"setPubmedSelectTab": function(pubmedList) {
			var pubmedTotal = pubmedList.count;
			
			//outerElement.outerTotalCount.PUBMED = (pubmedTotal * 1) ? (pubmedTotal * 1) : 0;
			//outerElement.make();
		},
		"setPubmed": function(pubmedList) {
			
			var $p = pubmedResult;
			var pubmedArea = $p.pubmedArea;
			var category = $p.category;
			var pageNum = $p.pageNum * 1;
			var retStart = (pageNum - 1) * 10;
			
			if (pubmedList) {
				var pubmedIds = pubmedList.ids;
				var pubmedTotal = pubmedList.count;
				
				var topElement = {
					"title": $("<div>", {
						"id": "Dnew_title2",
						"style": "margin-top: 0px;",
					}),
					"sTitle": $("<div>", {
						"id": "stab_stitle_2",
						"style": "margin-top: 10px;",
					}),
					"ul": $("<ui>", {
						"class": "red1_bold",
					}),
					"li": $("<li>", {
						"style": "float: left;",
					}),
					
					"make": function() {
						var $th = topElement;
						
						var title = $th.title;
						var sTitle = $th.sTitle;
						var ul = $th.ul;
						var li = $th.li;
						var pubmedTotalAddComma =pubmedTotal;
// 						li.text("PUBMED (" + pubmedTotalAddComma + ")");
// 						ul.append(li);
						sTitle.append(ul);
						title.append(sTitle);
						return title;
					},
				};
				
				var midElement = {
					"box1": $("<div>"),
					"sbox1": $("<ul>", {
						"id": "Dnew_SBOX1",
						"class": "sidebar-right-text2",
						"style": "",
					}),
					"div": $("<div>", {
						"style": "min-height: 70px; border-bottom:1px solid #CCDDED; margin-bottom:10px;padding-bottom:10px;",
					}),
					"a": $("<a>", {
						"href": "javascript:void(0);",
					}),
					"ul1": $("<ui>", {
						"id": "Dnew_title3",
						"class": "blue4bold",
					}),
					"ul2": $("<ui>", {
						"class": "Nfont_f12",
						"style": "",
					}),
					"li1": $("<li>", {
						"class": "Nfont_f12",
						"style": "",
					}),
					"li2": $("<li class=\"li_t sidebar-right-text2\">"),
					"li3": $("<li class=\"li_a\">"),
					"li4": $("<li>", {
						"class": "Nfont_f12gray",
						"style": "",
					}),
					"li5": $("<li>", {
						"class": "Nfont_f12gray",
					}),
					
					"make": function(count, pubmedObj) {
												
						var $th = midElement;
						var box1 = $th.box1.clone();
						var sbox1 = $th.sbox1.clone();
						var div = $th.div.clone();
						var a = $th.a.clone();
						var ul1 = $th.ul1.clone();
						var ul2 = $th.ul2.clone();
						var li1 = $th.li1.clone();
						var li2 = $th.li2.clone();
						var li3 = $th.li3.clone();
						var li4 = $th.li4.clone();
						var li5 = $th.li5.clone();
						var uId = pubmedObj.uId;
						var title = pubmedObj.BookTitle != '' ?pubmedObj.BookTitle:pubmedObj.title;
					  				
						
						var source = pubmedObj.source;
						var pubDate = pubmedObj.pubDate;
						var volume = pubmedObj.volume;
						var issue = pubmedObj.issue;
						var pages = pubmedObj.pages;
						var eLocationID = pubmedObj.eLocationID;
						var recordStatus = pubmedObj.recordStatus;
						var authors = pubmedObj.authors;
						
//  						console.log(uId);
//  						console.log(title);
//  						console.log(source);
//  						console.log(pubDate);
//  						console.log(volume);
						
						li1.text(count + ".");
						sbox1.append(li1);
						
						a.text(title).bind("click", function() {
							// 상세 내용 클릭시 이동 이벤트
							var url =  '/search/searchPubmedDtl.do?uId='+uId;
							location.href=url;

						});
						
						//javascript: fncMemberIn();
						//$(a).attr('href','/search/searchPubmedDtl.do?uId='+uId);
						$(a).attr('href','javascript:fn_page("'+uId+'")');
						
						
						li2.append(a);
						ul1.append(li2);
						
						var authorsText = "";
						if (authors) {
							$.each(authors, function(i, author){
								if (author.name) {
									if (i > 0) {
										authorsText += ", ";
									}
									authorsText += author.name;
								}
							});
						}
						else {
							authorsText = "[No authors listed]";
						}
						li3.text(authorsText);
						
						var infoText = "";
						infoText += source ? source + ". " : "";
						infoText += pubDate ? pubDate + "; " : "";
						infoText += volume ? volume : "";
						infoText += issue ? "(" + issue + ")" : "";
						infoText += pages ? ":" + pages + ". " : "";
						infoText += eLocationID ? ":" + eLocationID + ". " : "";
						li4.text(infoText);
						
						li5.text("PMID: " + uId + (recordStatus ? "[" + recordStatus + "]" : ""));
						
						ul2.append(li3).append(li4).append(li5);
						div.append(ul1).append(ul2);
						
						box1.append(sbox1).append(div);
						
						return box1.children();
					},
				};
				
				var bottonElement = {
					"div": $("<div>", {
						"style": "clear: left;",
					}),
					"p": $("<p>", {
						"class": "more_result",
					}),
					"a": $("<a>", {
						"href": "javascript:void(0);",
						"style": "background-image: url(/images/ncmik/ptl/search/ico_more_result.gif); background-repeat: no-repeat; background-position-x: 100%; background-position-y: 2px;",
					}),
					"line": $("<div>", {
						"style": "border-top: #ccc 1px dashed; margin:20px 0;",
					}),
					
					"make": function() {
						var $th = bottonElement;
						
						var bottom = $("<div>");
						
						var div = $th.div;
						var p = $th.p;
						var a = $th.a;
						var line = $th.line;
						
						
						if (category == "TOTAL") {
							a.html("PUBMED 더보기&nbsp;&nbsp;&nbsp;&nbsp;").bind("click", function() {
								goCategory('PUBMED');
							});
							p.append(a);
							div.append(p);
							
						}
						else if (category != "TOTAL") {
// 							div.html(pageNav("gotoPage", pageNum, 10, pubmedTotal, 1))
// 							.attr({
// 								"class": "paging-item",
// 								"style": "margin-left:40%; padding-bottom: 30px;",
								
// 							}); 
							
							$("#paging").html(pageNav("gotoPage", pageNum, 10, pubmedTotal, 1));
							
						}
					
						bottom.append(div).append(line);
						
						return bottom.children();
					},
				};
				//pubmed 데이터 조회
				if (pubmedIds.length) {
					
					pubmedArea.append(topElement.make());
					pubmedArea.append($("<div>", {"style": "clear: left;", "id":"pub_body"}));

					var str_html ="";
					var html_array = new Array();
					var isProc=false;
					
					$.each(pubmedIds, function(i, pubmedId) {
						var box1 = $("<div>", {
							"id": "Dnew_box1",
							"style": "clear: left; padding-top: 0px; padding-top: 15px;",
						});
						
						$p.getPubmedInfo(pubmedId, function(pubmedInfo,cnt) {
							box1.append(midElement.make(cnt + 1 + retStart, pubmedInfo));
							html_array[cnt] = box1.html();
							
							if(html_array.length == 10){
								if(isProc){
									return false;
								}
								isProc=!isProc;
								
								str_html += html_array["0"];
								str_html += html_array["1"];
								str_html += html_array["2"];
								str_html += html_array["3"];
								str_html += html_array['4'];
								str_html += html_array["5"];
								str_html += html_array["6"];
								str_html += html_array["7"];
								str_html += html_array["8"];
								str_html += html_array["9"];
								
								str_html += bottonElement.make().html();
								
								var encode_str_html = encodeingString(str_html);
								$('#pub_body').html(encode_str_html);
							}
						}, i);

					});
			
				}
			}
		},
		"fn": {
			"getContentValue": function(xmlElement, tagName) {
				xmlElement = $(xmlElement);
				var nodeList = xmlElement.find(tagName);
				
				var returnValue = null;
				
				if(nodeList.length){
					var node = $(nodeList[0]);
					
					returnValue = node.text();
				}
				return returnValue;
			},
			"getContentArray": function(xmlElement, type) {
				var $p = pubmedResult;
				
				var returnArray = null;
				
				xmlElement = $(xmlElement);
				
				if (type == "Authors" || type == "ArticleIds" || type == "History") {
					var nodeList = xmlElement.find(type);
					
					if (nodeList.length) {
						var node = $(nodeList[0]);
						var nodeChildren = node.children();
						
						if (nodeChildren.length) {
							returnArray = [];
							
							$.each(nodeChildren, function(i, node){
								node = $(node);
								
								var obj = {};
								
								if (type == "Authors") {
									obj["name"] =		$p.fn.getContentValue(node, "Name");
									obj["authType"] =	$p.fn.getContentValue(node, "AuthType");
								}
								else if (type == "ArticleIds") {
									obj["idType"] =		$p.fn.getContentValue(node, "IdType");
									obj["idTypeN"] =	$p.fn.getContentValue(node, "IdTypeN");
									obj["value"] =		$p.fn.getContentValue(node, "Value");
								}
								else if (type == "History") {
									obj["pubStatus"] =	$p.fn.getContentValue(node, "PubStatus");
									obj["date"] =		$p.fn.getContentValue(node, "Date");
								}
									
								returnArray.push(obj);
							});
						}
					}
				}
				
				return returnArray;
			},
		},
	};
	
	$(function() {
		var $p = pubmedResult;
		
		var category = $p.category;
		var subCategory = $p.subCategory;
		var pageNum = $p.pageNum;
		var keyWord = $p.keyWord;
		
		if (category == "TOTAL" || category == "PUBMED" || category == "KOLIS" || category == "NDSL") {
			$p.pubmedArea = $("#pubmedArea");
			
			var term = keyWord;
			var retMax = category == "TOTAL" ? 3 : 10;
			var retStart = ((pageNum * 1) - 1) * 10;
			
			if (subCategory == "all") {
				$p.getPubmedList(term, retMax, retStart, function(pubmedList) {
					if (category == "TOTAL" || category == "PUBMED") {
						$p.setPubmed(pubmedList);
					}
					
					$p.setPubmedSelectTab(pubmedList);
				});
			}
			else if (category == "TOTAL" || category == "PUBMED") {
				$p.getPubmedList(term, retMax, retStart, function(pubmedList) {
					$p.setPubmed(pubmedList);
				});
			}
		}
	});
	
	
	
	function fn_page(uId){
		$("#uId").val(uId);
		var form = document.reqForm;
		form.action="${ctxt}/search/searchPubmedDtl.do"
		form.submit();
	}
	
		
	
	function encodeingString(str){
  		 var encodeingStr = str.replace(/&lt;/g, '<').replace(/&gt;/g, '>'); 
  		 return encodeingStr; 
	}
	
	
</script>

 <style>
/* .sub_book_wrap{
   list-style: none;
   width: 100%;
   display: inline-block;
   float: left;
}
#paging{
    text-align: center;
    padding-top: 55px;
} */
ul, li{
	list-style: none;
}
</style>

<!-- historyForm -->
<form name="historyForm" method="get" action="${ctxt}/search/searchPubmed.do" >	
	<input type="hidden" id="searchQueryMove" name="searchQuery" value="${vo.searchQuery}" />
	<input type="hidden" name="kwd" value="${param.kwd}"/>
	<input type="hidden" name="category" value="${param.category}"/>
	<input type="hidden" name="subCategory" value="${param.subCategory}"/>
	<input type="hidden" name="pageNum" value="${param.pageNum}"/>
	<input type="hidden" name="fltGetCnt" value="${param.fltGetCnt}"/>
	<input type="hidden" id="searchSortMove" name="searchSort" value="${vo.searchSort}" />
	<input type="hidden" id="searchTargetMove" name="searchTarget" value="${vo.searchTarget}" />
	<input type="hidden" id="searchSubTargetMove" name="searchSubTarget" value="${vo.searchSubTarget}" />
	<input type="hidden" id="searchYearMove" name="searchYear" value="${vo.searchYear}" />
	<input type="hidden" id="searchNlmcMove" name="searchNlmc" value="${vo.searchNlmc}" />
	<input type="hidden" id="searchLangMove" name="searchLang" value="${vo.searchLang}" />
</form>

<!-- reqForm -->
<form name="reqForm" method="get" action="">
	<input type="hidden" id="uId" name="uId" value=""/>
	<input type="hidden" id="edsCnt" name="edsCnt" value="${edsCnt}" />
	<input type="hidden" id="searchQueryMove" name="searchQuery" value="${vo.searchQuery}" />
	<input type="hidden" name="kwd" value="${param.kwd}"/>
</form>

	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>통합검색</span>
			<span> > </span>
			<span class="active">PubMed</span>        
		</div>
		<span class="center_text_01">PubMed</span>
	</div>
	<div class="under_bar"></div>

	<div class="content_wrap" style="min-height: 700px;">
		<div class="content_box">
			<div class="content_list">
				
<!-- 					<div class="list_title"> -->
<!-- 						<p id="search_cn">PubMed<span id="topCnt"></span></p> -->
<!-- 					</div>	 -->
					
					<div class="under_bar2"></div>
					
					<div class="" id = "div_body">
						
						<div id="pubmedArea"></div>
					
					</div>
						<div id="paging" class="paginate"></div>
				
			</div>
		</div>
	</div>