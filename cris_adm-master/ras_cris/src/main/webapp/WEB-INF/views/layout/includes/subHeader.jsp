<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page
	import="org.springframework.web.servlet.i18n.SessionLocaleResolver"%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.11/css/all.css" integrity="sha384-p2jx59pefphTFIpeqCcISO9MdVfIm4pNnsL08A6v5vaQc4owkQqxMV8kg4Yvhaw/" crossorigin="anonymous">
<link rel="stylesheet" href="//cdn.rawgit.com/hiun/NanumSquare/master/nanumsquare.css">
<%
	String locale = String.valueOf(request.getSession().getAttribute(
			SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME));
%>
<script type="text/javascript">
 
$(function() {
	
	//모바일 메뉴
	$(".hamburger").on("click",function(){ 
	    $(".hamburger_drop").toggleClass("on");
	    $(".curtain").fadeToggle("2000");
	});
	$(".dorp_in_drop").click(function(){
  	   var submenu = $(this).children("ul");
  	    if( submenu.is(":visible") ){
              submenu.slideUp();
          }else{
              submenu.slideDown();
          } 
   });
	
});




	function fn_mylibarary(){
		location.href="${ctxt}/mylib/lib/listMyLib.do";
	}
	function logout(){
		var emplyrkey = "<c:out value='${NCMIK_ELIB_EMPLYRKEY}'/>";
		if (confirm('로그아웃 하시겠습니까?')) {
			var beforeCallBack = null;
			var afterCallBack = function() {
				var form = $('<form action="${ctxt}/login/logout.do" method="post"></form>');
				//form.append('<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/></form>');
				form.append('</form>');
				form.appendTo('body');
				form.submit();
			};
			var delayCallBack = function() {
				console.log("실패: 프록시 로그아웃 - 프록시 서버가 응답하지 않습니다");
				
				afterCallBack();
			};
			proxyLogout(emplyrkey, beforeCallBack, afterCallBack, delayCallBack);	//프록시 로그아웃			
		};
	}
	function engMainOpen(){
		location.href="${ctxt}/index/engindex.do";
	}
	
	function goSearch(){
				
		var search = $("#search_text").val();
		if(search==""){
			alert("검색어를 입력해 주십시오.");
		}else{
			$('#mloader').show();   	
			
			var form = document.moveParam;
			$('#param_query').val(search);
			$('#searchQuery').val(search);
			form.action="${ctxt}/search/AdvancedSearch";
			form.submit();
			
		}    
	} 

	<%-- proxy check --%>
	function proxLogin(emplyrkey, beforeCallBack, afterCallBack, delayCallBack) {
		//request login to proxy server
		var url = "http://152.99.73.136/lp1117_login~req.do?";
		var liid = $.trim(emplyrkey);
		
		if (liid) {
			url += "about:blank";
			liid += ";01";
			
			var body = $(document.body); 
			var loginIframe = $("#proxyLoginIframe");
			var loginForm = $("#proxyLoginForm");
			
			if (!loginIframe[0]) {
				loginIframe = $("<iframe>", {
					"id": "proxyLoginIframe",
					
					"name": "proxyLoginIframe", 
					"src": "about:blank",
					"height": "0",
					"width": "0",
					"title": "프록시 로그인 iframe",  
					"style": "display: none;",
				});
				
				body.append(loginIframe);
			}
			
			if (!loginForm[0]) {
				loginForm = $("<form>", {
					"id": "proxyLoginForm",
					
					"action": url,
					"method": "post",
					"target": loginIframe.attr("name")
				});
				
				body.append(loginForm);
				
				var loginInput = $("<input>",{
					"type":"hidden",
					
					"id":"liid",
					"name":"liid",
					
					"value":liid
				});
				
				loginForm.append(loginInput);
			}
			
			var onloadCnt = 0;
			loginIframe.off("load").on("load", function(e) {
				onloadCnt ++;
				
				if (onloadCnt == 1) {
					console.log("프록시 로그인 - start", e);
					
					if ($.isFunction(beforeCallBack)) {
						beforeCallBack();
					}
				}
				else if (onloadCnt == 2) {
					console.log("프록시 로그인 - end", e);
					
					if ($.isFunction(afterCallBack)) {
						afterCallBack();
					}
				}
			});
			
			loginForm.submit();
			
			setTimeout(function(e) {//응답 지연 대비(인터넷이 안되는 환경 등)
				if (onloadCnt == 0) {
					console.log("프록시 로그인 응답지연 - ", e);
					
					loginIframe.remove();
					
					if ($.isFunction(delayCallBack)) {
						delayCallBack();
					}
				}
			}, 3000);//3초
			
			return true;
		}
		else {
			var msg = "오류: 프록시 로그인 할 수 없습니다..!\n[EMPLYRKEY:" + emplyrkey + "]";
			console.log(msg);
			alert(msg);
			
			return false;
		}
	}

	function proxyLogout(emplyrkey, beforeCallBack, afterCallBack, delayCallBack) {//프록시 서버에 로그아웃 요청한다
		var url = "//152.99.73.136/lp1125_logout~asd?";
		var loid = $.trim(emplyrkey);
		
		if (loid) {
			url += "about:blank";
			
			var body = $(document.body); 
			var logoutIframe = $("#proxyLogoutIframe");
			var logoutForm = $("#proxyLogoutForm");
			
			if (!logoutIframe[0]) {
				logoutIframe = $("<iframe>", {
					"id": "proxyLogoutIframe",
					
					"name": "proxyLogoutIframe", 
					"src": "about:blank",
					"height": "0",
					"width": "0",
					"title": "프록시 로그아웃 iframe",  
					"style": "display: none;",
				});
				
				body.append(logoutIframe);
			}
			
			if (!logoutForm[0]) {
				logoutForm = $("<form>", {
					"id": "proxyLogoutForm",
					
					"action": url,
					"method": "post",
					"target": logoutIframe.attr("name")
				});
				
				body.append(logoutForm);
				
				var logoutInput = $("<input>",{
					"type":"hidden",
					
					"id":"loid",
					"name":"loid",
					
					"value":loid
				});
				
				logoutForm.append(logoutInput);
			}
			
			var onloadCnt = 0;
			logoutIframe.off("load").on("load", function(e) {
				onloadCnt ++;
				
				if (onloadCnt == 1) {
					console.log("프록시 로그아웃 - 시작", e);
					
					if ($.isFunction(beforeCallBack)) {
						beforeCallBack();
					}
				}
				else if (onloadCnt == 2) {
					console.log("프록시 로그아웃 - 끝", e);
					
					if ($.isFunction(afterCallBack)) {
						afterCallBack();
					}
				}
			});
			
			logoutForm.submit();
			
			setTimeout(function(e) {//응답 지연 대비(인터넷이 안되는 환경 등)
				if (onloadCnt == 0) {
					console.log("프록시 로그아웃 응답지연 - ", e);
					
					logoutIframe.remove();
					
					if ($.isFunction(delayCallBack)) {
						delayCallBack();
					}
				}
			}, 3000);//3초
			
			return true;
		}
		else {
			var msg = "오류: 프록시 로그아웃 할 수 없습니다..!\n[EMPLYRKEY:" + emplyrkey + "]";
			console.log(msg);
			alert(msg);
			
			return false;
		}
	}		
			
</script>

<script type="text/javaScript">
<%-- 프록시 서버 로그인 --%>
function proxyloginCheck() {
	var emplyrkey = "<c:out value='${NCMIK_ELIB_EMPLYRKEY}'/>";
	var login = "<c:out value='${NCMIK_ELIB_LOGIN}'/>";
	
	//console.log(emplyrkey + ", " + login);
	
	if (login == "LOGIN") {
		var isLogin = "<c:out value='${userVo}' />";
		
		if (isLogin != "") {
			<%-- 현재 아이디로 로그아웃 호출 후 로그인 호출 (프록시서버 로그인 오버플로 방지) --%>
			var beforeCallBack = null;
			var afterCallBack = function() {
				proxLogin(emplyrkey);		//프록시 로그인
			};
			var delayCallBack = function() {
				console.log("실패: 프록시 로그아웃 - 프록시 서버가 응답하지 않습니다");
				
				afterCallBack();
			};
			
			proxyLogout(emplyrkey, beforeCallBack, afterCallBack, delayCallBack);	//프록시 로그아웃
		}
	}
}

proxyloginCheck();	<%-- 프록시 서버 로그인 --%>
</script>

<style>
#mloader{
  position: fixed;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 99999;
  background-color: #000;
  opacity: 0.7;
  display:none;
} 
  
#mloader .masterkey_blink {
	font-size:20px;
	font-weight:bold;
	color:white;
	margin: 10% 45%;
    -webkit-animation: masterkey_blink 3s linear infinite;
    animation: masterkey_blink 3s linear infinite;
}  

#mloader2{
  position: fixed;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 99999;
  background-color: #000;
  opacity: 0.7;
  display:none;
} 
  
#mloader2 .masterkey_blink2 {
	font-size:20px;
	font-weight:bold;
	color:white;
	margin: 10% 45%;
    -webkit-animation: masterkey_blink2 3s linear infinite;
    animation: masterkey_blink2 3s linear infinite;
}  
@media (max-width: 600px){
	#mloader .masterkey_blink  {
	  margin: 35% 35% !important;
	}
}  

@media (max-width: 600px){
	#mloader2 .masterkey_blink2  {
	  margin: 35% 23% !important;
	}
} 

</style>

 <header id="header">
			<!-- 상단 로그인 부분 -->
			<div class="top_login">
							
					<c:choose>
						<c:when test="${userVo eq null}">
							<a href="${ctxt}/login/user/login.do" id="top_a">로그인</a>
						</c:when>
						<c:otherwise>
							<a href="${ctxt}/member/regi/infoMember.do"  id="top_a" ><c:out value="${userVo.emplyrnm}"/>님</a>
							<span style="color:#999;font-size:11px;">(</span> <a href="javascript:logout();"  id="top_a">로그아웃</a> <span style="color:#999;font-size:11px;">)</span> 
							<span id="top_b">ㅣ</span>
							<a href="#" id="top_a" onclick="fn_mylibarary()">My Library</a>
							
							<div class="mesh">	
								<c:forEach items="${userVo.roleList}" var="item" >
			                    	<c:if test="${item eq 'ROLE_ADMIN' }">
			                        	<a href="${ctxt}/mng/menu/listMenu.do" id="top_a">관리자</a>
			                    	</c:if>
		                   		</c:forEach>
		                   		<c:if test="${bMeshMenuView == true}">     
		                   			<span id="top_b">ㅣ</span>
				                    <c:if test="${userVo.mesh eq '1'}">                 
				                        <a id="top_a" href="${ctxt}/mesh/indexer/listPapers.do"   target="_blank" rel="noopener noreferrer" title="새창" >MeSH 색인관리</a>
				                    </c:if>
				                    <c:if test="${userVo.mesh eq '0'}">
				                        <a  id="top_a" href="${ctxt}/mesh/reviewer/listPapers.do"   target="_blank" rel="noopener noreferrer" title="새창" >MeSH 색인관리</a>
				                    </c:if>
	                   			</c:if>  
	                   		</div>
						</c:otherwise>
					 </c:choose>
						<!-- <a id="top_b">ㅣ</a>
						<a href="#" id="top_a">사이트맵</a> -->
						<span id="top_b">ㅣ</span>
						<a href="javascript:engMainOpen();" id="top_a" class="english_btn">ENGLISH</a>
						
			</div>
			
			<!-- 상단 전체 div -->
			<div class="headerWrap">
				<!-- 로고 -->

				<a id="logo" href="${ctxt}/index/index.do"></a>
				<div class="hamburger">
					<p>
						<span></span><span></span><span></span>
					</p>
				</div>
				
				<div class="curtain"></div> 
				<div class="hamburger_drop">
					<ul class="hamburger_drop_box">
					<!-- 로그아웃상태 -->
					<c:choose>
					<c:when test="${userVo eq null}">
						<li class="hamburger_drop_login"><a href="${ctxt}/login/user/login.do" id="top_a">Login <!--  <i class="fas fa-sign-in-alt"></i> --> </a></li>
					</c:when>
					<c:otherwise>
					 <li class="hamburger_drop_login"><a href="${ctxt}/member/regi/infoMember.do"  id="top_a" style="border:0;"><c:out value="${userVo.emplyrnm}"/>님</a>
			    			<span style="color:#999;"></span> <a href="javascript:logout();"  id="top_a">LogOut</a> <span style="color:#999;"></span>
					</li> 	
					</c:otherwise>
					</c:choose>
					<!-- 로그인상태 -->
					
						<c:forEach var="menuVo" items="${sys_topMenu}" varStatus="stat">
							<c:if test="${menuVo.menuNm ne '시스템관리자'}">
								<li class="dorp_in_drop">
									<span> <c:out value="${menuVo.menuNm}" /></span><i class="fa fa-caret-down" aria-hidden="true"></i>
									<c:if test="${not empty menuVo.subList}">
										<ul class="dorp_in_drop_box" style="display:none;">
											<c:forEach var="subMenuVo" items="${menuVo.subList}">
												<li>
													<a href="/ncmiklib<c:out value='${subMenuVo.url}'/>" <c:if test="${subMenuVo.selYn eq true}"> style="color:#0599df !important;"</c:if> > 
									 					<span><c:out value="${subMenuVo.menuNm}" /></span>
													</a>
												</li>
												<input type="hidden" name="selYn" value="${subMenuVo.selYn}" />
											</c:forEach>
										</ul>
									</c:if>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
					<!-- 통합검색 -->
					<div class="navbar-wrapper">
						<form id="searchForm" name="searchForm" action="${ctxt}/search/search.do"  method="post" onsubmit="return false;">
						   	<div id="Search_bg">
								<section class="webdesigntuts-workshop">
									<div class="mainsearchbox">   
										<c:if test="${vo.searchGubun ne 'board'}">
											<input type="search" id="search_text" name="" value="${kwd != null ? kwd : query}" placeholder="">
										</c:if>
										<c:if test="${vo.searchGubun eq 'board'}">
											<input type="search" id="search_text" name="" value="${kwd != null ? kwd : query}" placeholder="">
										</c:if>
										<button onclick="goSearch();"><i class="fas fa-search"></i></button>
									</div>
								</section>   
							</div>        
						</form>   
					</div> 
			</div>
			<!-- 상단 전체 div 끝 -->
		    <!-- 메뉴 -->
			<div class="menu_div">
				<!-- 메뉴 드롭다운-->
				<%@include file="./subMenu.jsp"%>
			</div>
			<!-- 메뉴 끝-->
			<div id="mloader"><div class="masterkey_blink">LOADING...</div></div>
				<div id="mloader2"><div class="masterkey_blink2">LOADING...</div></div>
 </header>
