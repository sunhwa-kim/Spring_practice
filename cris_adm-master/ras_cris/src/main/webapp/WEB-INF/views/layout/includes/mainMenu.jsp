<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 상단메뉴 -->
<nav id="nav_gnb">
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
											<a href="${ctxt}<c:out value='${subMenuVo.url}'/>" <c:if test="${subMenuVo.selYn eq true}"> style="color:#0599df !important;"</c:if> > 
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
			<%-- 
				<c:if test="${bMeshMenuView == true}">     	                   			
                     <li>  
                      <c:if test="${userVo.mesh eq '1'}">                 
                         <a id="top_a" href="${ctxt}/mesh/indexer/listPapers.do"   target="_blank" rel="noopener noreferrer" title="새창" >MeSH 색인관리</a>
                      </c:if>
                      <c:if test="${userVo.mesh eq '0'}">
                         <a  id="top_a" href="${ctxt}/mesh/reviewer/listPapers.do"   target="_blank" rel="noopener noreferrer" title="새창" >MeSH 색인관리</a>
                      </c:if>
                     </li>
            	</c:if> 
				 --%>
			</ul>
		</div>
		
		
 
	<ul class="gnb1">
		<c:forEach var="menuVo" items="${sys_topMenu}" varStatus="stat">
			<c:if test="${menuVo.menuNm ne '시스템관리자' && menuVo.menuNm ne 'My Library'}">
				<li>
				<a href="${ctxt}<c:out value='${menuVo.url}'/>"> <span> <c:out value="${menuVo.menuNm}" /> </span> </a> 
					<c:if test="${not empty menuVo.subList}">
						<ul class="gnb2">
							<c:forEach var="subMenuVo" items="${menuVo.subList}">
								<li>
									<a href="${ctxt}<c:out value='${subMenuVo.url}'/>" <c:if test="${subMenuVo.selYn eq true}"> style="color:#0599df !important;"</c:if> > 
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
</nav>





 

