<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.springframework.web.servlet.i18n.SessionLocaleResolver"%>


<%
	String locale = String.valueOf(request.getSession().getAttribute(
			SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME));
%>
<script type="text/javascript">

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
function fn_mylibarary(){
	location.href="${ctxt}/mylib/lib/listMyLib.do";
}
function engMainOpen(){
	location.href="${ctxt}/index/engindex.do";
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

<header id="header">
	<!-- 상단 로그인 부분 -->
        <div class="top_login" style="z-index: 1;">
        				
                <c:choose>
                	<c:when test="${userVo eq null}">
                		<a href="${ctxt}/login/user/login.do"  id="top_a1">로그인</a>
                	</c:when>
                	<c:otherwise>
                		<a href="${ctxt}/member/regi/infoMember.do"  id="top_a2"><c:out value="${userVo.emplyrnm}"/>님</a>
		    			<span style="color:#999;">(</span> <a href="javascript:logout();"  id="top_a3">로그아웃</a> <span style="color:#999;">)</span>
		    			<span id="top_b">ㅣ</span>
		    			<a href="#" id="top_a4" onclick="fn_mylibarary()">My Library</a>
		    			
		    			<div class="mesh">	
							<c:forEach items="${userVo.roleList}" var="item" >
		                      <c:if test="${item eq 'ROLE_ADMIN' }">
		                         <a href="${ctxt}/mng/menu/listMenu.do" id="top_a5">관리자</a>
		                      </c:if>
	                   		</c:forEach>
	                   		<c:if test="${bMeshMenuView == true}">     
	                   			<span id="top_b">ㅣ</span>
		                      <c:if test="${userVo.mesh eq '1'}">                 
		                         <a id="top_a6" href="${ctxt}/mesh/indexer/listPapers.do"   target="_blank" rel="noopener noreferrer" title="새창" >MeSH 색인관리</a>
		                      </c:if>
		                      <c:if test="${userVo.mesh eq '0'}">
		                         <a  id="top_a7" href="${ctxt}/mesh/reviewer/listPapers.do"   target="_blank" rel="noopener noreferrer" title="새창" >MeSH 색인관리</a>
		                      </c:if>
	                   		</c:if>  
                   		</div>
                   		
                	</c:otherwise>
                </c:choose>
                <!--<a id="top_b">ㅣ</a>
                 <a href="#" id="top_a8">사이트맵</a> -->
                 <span id="top_b">ㅣ</span>
                 <a href="javascript:engMainOpen()"  class="english_btn" id="top_a">ENGLISH</a>
        </div>


	<!-- 메뉴 -->
	<div class="menu_div">
			<!-- 메뉴 드롭다운 -->    
			<%@include file="./mainMenu.jsp"%>
	</div>        
	
	
	<div id="under_bar"></div>
</header>
