<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- side -->


<script type="text/javascript">
window.onload = function () {
	if( $("#menutitle").text() != null ){	
		$(".side > h2").html( $("#menutitle").text());
	}
}

</script>
	<div class="side">
		<h2><!-- 정보 --></h2>
		<ul id="snavigation" class="side-menu">
           <c:if test = "${fn:length(sys_leftMenu) ne 0  }" >
	            <c:forEach var="menuVo" items="${sys_leftMenu}" varStatus="status">	              
		              <li>
         		       <a style="display: none" id="menutitle" href = "${ctxt}<c:out value='${menuVo.url}'/>" >  <c:out value="${menuVo.menuNm}"/>  </a>	       	
	                 	<c:if test="${menuVo.lvl != '0'}"> 
	                 	<a href="<c:out value='${menuVo.url}'/>"  <c:if test="${menuVo.selYn == 'true'}">style="color:red;"</c:if> />
	                 		<c:if test="${menuVo.lvl eq '1'}"> &nbsp;&nbsp;</c:if>
	                 		<c:if test="${menuVo.lvl eq '2'}"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-></c:if>
	                 			<c:out value="${menuVo.menuNm}"/>
	                 		
	                 	</c:if>
	                  </li>             
	           </c:forEach> 
           </c:if>
		</ul>
	</div>

<!-- //side -->