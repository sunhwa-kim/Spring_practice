<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- 메뉴 드롭다운-->
<div id='cssmenu'>
	<ul>  
		<c:forEach var="menuVo" items="${sys_topMenu}" varStatus="stat">
			<c:if test="${menuVo.menuNm ne '시스템관리자'  && menuVo.menuNm ne 'My Library'}">
				<li>
				<a href="${ctxt}<c:out value='${menuVo.url}'/>"> <span> <c:out value="${menuVo.menuNm}" /></span></a> 
					<p class="curtain"></p>
					<c:if test="${not empty menuVo.subList}">
						<ul style="text-align: left; margin-left: 6px;">
							<c:forEach var="subMenuVo" items="${menuVo.subList}">
								<li class='has-sub'>
									<a href="${ctxt}<c:out value='${subMenuVo.url}'/>" <c:if test="${subMenuVo.selYn eq true}"> style="<!-- color:#0599df !important; -->"</c:if> > 
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


      


 

