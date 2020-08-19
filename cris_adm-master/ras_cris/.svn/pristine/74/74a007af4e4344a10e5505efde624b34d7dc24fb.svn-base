<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!--  국내학술논문 -->

<c:if test="${vo.searchTarget eq 'inkorea'}" >
	<%@include file="./inkoreaSearch.jsp"%>
</c:if>
<!--  소장자료 -->
<c:if test="${vo.searchTarget eq 'book'}" >
	<%@include file="./bookSearch.jsp"%>
</c:if>
<!--  아카이브 -->
<c:if test="${vo.searchTarget eq 'archive'}" >
	<%@include file="./archiveSearch.jsp"%>
</c:if>

<script>     
/* $(function() {
	//모바일 메뉴
	$(".hamburger").on("click",function(){  
		alert('1212112121212')
	    $(".hamburger_drop").toggleClass("on");
	    $(".dorp_in_drop").click(function(){
	    	   var submenu = $(this).children("ul");
	    	   alert(submenu.is(":visible"));
	            if( submenu.is(":visible") ){
	                submenu.slideUp();   
	            }else{
	                submenu.slideDown();
	            }
	    });   
	});
	
	
}); */
</script>