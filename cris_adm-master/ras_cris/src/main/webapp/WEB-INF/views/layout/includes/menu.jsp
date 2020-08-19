<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <!-- 상단메뉴 -->

	  	<ul id="gnbPage">
	      <c:forEach var="menuVo" items="${sys_topMenu}" varStatus="stat">
	      <li>
	        <a href="${ctxt}<c:out value='${menuVo.url}'/>" class="gp${stat.index +1}"><c:out value="${menuVo.menuNm}"/></a>
	        <c:if test="${not empty menuVo.subList}">
	       		<div class="sub sub${stat.index+1}">
			        <ul>
			          <c:forEach var="subMenuVo" items="${menuVo.subList}">
			          	<li><a href="<c:out value='${subMenuVo.url}'/>" <c:if test="${subMenuVo.selYn eq true}" >style="color:#0599df !important;"</c:if> ><c:out value="${subMenuVo.menuNm}"/></a></li>
			        		<input type="hidden" name="selYn" value="${subMenuVo.selYn}" />
			          </c:forEach>
			        </ul>
	        	</div>
	        </c:if>
	      </li>       
	      </c:forEach>
	   	</ul>
  <a href="${ctxt}<c:out value='/rastech/test.do'/>"  > 테스트 </a>