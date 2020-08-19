<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
	ul.gnb1>li{
		width:23%;
	}
	ul.gnb1>li:last-child{
		width:31%;
	}	
	
	@media all and (max-width:540px) {
		ul.gnb1{
			font-size:11px;
		}
	}
	@media all and (max-width:502px){
		#englogo{
			margin:0;
		}	
		.hamburger_drop.on {
			display:block !important;
			left:55% !important;
			transition:left 0.5s;
			-webkit-transition:left 0.5s;
		}
		.hamburger_drop>ul>li{
			padding: 10px 0 10px 15px;
		}
	}
	@media all and (max-width:480px) {
	.foot1{
		margin-left:0;
	}
	.foot{
		display:block;
	}
}
}
</style>
<!-- 상단메뉴 -->
<nav id="nav_gnb">
<a id="englogo" href="${ctxt}/index/engindex.do"></a>
		
 		<div class="hamburger">
					<p>
						<span></span><span></span><span></span>
					</p>
		</div>
		<div class="curtain"></div>
		<div class="hamburger_drop">
			<ul class="hamburger_drop_box">	
				<li class="hamburger_drop_login"><a href="${ctxt}/login/user/login.do" id="top_a">Login <!--  <i class="fas fa-sign-in-alt"></i> --> </a></li>
								
				<li class="dorp_in_drop">
					<a href="/ncmiklib<c:out value='/eng/engAbout.do'/>"> <span>About NCMIK</span></a>
				</li>	
				<li class="dorp_in_drop">
					<a href="/ncmiklib<c:out value='/eng/engFacilities.do'/>"><span>Facilities</span></a>
				</li>	
				<li class="dorp_in_drop">
					<a href="/ncmiklib<c:out value='/eng/engServices.do'/>"> <span>Services</span></a>
				</li>
				<li class="dorp_in_drop">
					<a href="/ncmiklib<c:out value='/eng/engContact.do'/>"> <span>Contact Information</span></a>
				</li>							
			</ul>
		</div>

<!-- 	<ul class="gnb1"> -->
<%-- 		<c:forEach var="menuVo" items="${sys_topMenu}" varStatus="stat"> --%>
<%-- 			<c:if test="${menuVo.menuNm ne '시스템관리자'}"> --%>
<!-- 				<li> -->
<%-- 				<a href="/ncmiklib<c:out value='${menuVo.url}'/>"> <span> <c:out value="${menuVo.menuNm}" /> </span> </a>  --%>
<%-- 					<c:if test="${not empty menuVo.subList}"> --%>
<!-- 						<ul class="gnb2"> -->
<%-- 							<c:forEach var="subMenuVo" items="${menuVo.subList}"> --%>
<!-- 								<li> -->
<%-- 									<a href="<c:out value='${subMenuVo.url}'/>" <c:if test="${subMenuVo.selYn eq true}"> style="color:#0599df !important;"</c:if> >  --%>
<%-- 									 	<span><c:out value="${subMenuVo.menuNm}" /></span> --%>
<!-- 									</a> -->
<!-- 							 	</li> -->
<%-- 								<input type="hidden" name="selYn" value="${subMenuVo.selYn}" /> --%>
<%-- 							</c:forEach> --%>
<!-- 						</ul> -->
<%-- 					</c:if> --%>
<!-- 				</li> -->
<%-- 			</c:if> --%>
<%-- 		</c:forEach> --%>
<!-- 	</ul> -->
	
	<ul class="gnb1 clear">
				<li>
				<a href="/ncmiklib<c:out value='/eng/engAbout.do'/>"> <span> <c:out value="About NCMIK" /></span></a> 
				</li>
				<li>
				<a href="/ncmiklib<c:out value='/eng/engFacilities.do'/>"> <span> <c:out value="Facilities" /></span></a> 
				</li>
				<%-- <li>
				<a href="/ncmiklib<c:out value='/eng/engOperationHour.do'/>"> <span> <c:out value="Operation Hour" /></span></a> 
				</li> --%>
				<li>
				<a href="/ncmiklib<c:out value='/eng/engServices.do'/>"> <span> <c:out value="Services" /></span></a> 
				</li>
				<li>
				<a href="/ncmiklib<c:out value='/eng/engContact.do'/>"> <span> <c:out value="Contact Information" /></span></a> 
				</li>
	</ul>
</nav>





 

