<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
        <!-- 좌측 메뉴 -->
        <div class="leftMenu">
          <!-- 서브 메뉴 -->
          <nav class="subMenu">
            <ul class="main">
              <c:forEach var="menuVo" items="${sys_leftMenu}" varStatus="status">
              <li <c:if test="${status.index eq 0}">class="first"</c:if>>
                <c:choose>
                	<c:when test="${fn:length(menuVo.subList) == 0}">
                		<a href="/ncmiklib<c:out value='${menuVo.url}'/>" <c:if test="${menuVo.selYn}">class="open"</c:if>><c:out value="${menuVo.menuNm}"/></a>	
                	</c:when>
                	<c:otherwise>
                		<a href="#none" <c:if test="${menuVo.selYn}">class="open"</c:if>><c:out value="${menuVo.menuNm}"/></a>
                	</c:otherwise>
                </c:choose>
                <ul class="sub<c:if test='${menuVo.selYn}'> open</c:if>">
                  <c:forEach var="subMenuVo" items="${menuVo.subList}">
                  <li><a href="<c:out value='${subMenuVo.url}'/>" <c:if test="${subMenuVo.selYn}">class="open"</c:if>><c:out value="${subMenuVo.menuNm}"/></a></li>
                  </c:forEach>
                </ul>
              </li>
              </c:forEach>
            </ul>
          </nav>
        </div>