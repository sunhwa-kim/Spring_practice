<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!-- 검색용 모바일메뉴 -->


<%@ page import="kr.go.cris.commons.utils.CommonUtil" %>
<%@ page session="true" %>

<script type="text/javascript">


$(function(){
	$(".sidebar-left-m").hide();  
	$(".category_select").click(function(){
		if( $(".sidebar-left-m").is(":visible") ){
			$(".sidebar-left-m").slideUp();
        }else{
        	$(".sidebar-left-m").slideDown();
        }
	});
});

</script>
<style>
.category_select{
	display:none;
}
.category{
    width: 100%;
    position: absolute;
    top: 204px;
    left: 1%;
    z-index:100;
}
.sub_left_ul-m{
	padding:5px 0;
	margin: 0;
}
.sidebar-left-m li{
	padding:5px 0;
}
.category{
	display: none;
}

@media (max-width: 990px){
	.category_select{
		display: inline-block;
		padding-left:10px;
	    cursor: pointer;
	    font-size:10px;
	}
	.sidebar-left-m{
		width: 140px;
		margin: 0;
		border: none;
		position: absolute;
		font-size:13px;
		text-align: center;    
		background: #fff;
    	border: 1px solid rgba(51,122,183,0.5);
	}
	.category{
		display: block;
	}
	.content_box>.content_list>.sub_book_wrap>.list_title {
    	display: block;
    }
}
@media (max-width: 502px){

	.category{
	    width: 100%;
	    position: absolute;
	    top: 215px;
	    left: 50%;
	    
	}
	.sidebar-left-m{
		transform:translate(-50%, 0);   
	 	-o-transform:translate(-50%, 0);
	 	-ms-transform:translate(-50%, 0);
	 	-moz-transform:translate(-50%, 0);
	 	-webkit-transform:translate(-50%, 0);
	}
}
</style>
	<div class="category">
	<div id="sidebar-left" class="sidebar-left sidebar-left-m">
		<div class="sidebar-left2">
			<ul class="sub_left_ul-m">
	           <c:if test = "${fn:length(sys_leftMenu) ne 0  }" >
		            <c:forEach var="menuVo1" items="${sys_leftMenu}" varStatus="status">	              
		                 	<c:if test="${menuVo1.lvl ne '0'}">
			                 		<c:if test="${menuVo1.lvl eq '1'}">
				                 		<li>
				                 		    <c:if test="${menuVo1.menu_con eq '0'}">
				                 		    	<a  href="#"> <c:out value="${menuVo1.menuNm}"/></a>
				                 		    </c:if>
				                 		    <c:if test="${menuVo1.menu_con eq '1'}">
				                 		    	<a href="javascript:fn_tab('${status.index}')" >  <c:out value="${menuVo1.menuNm}"/><span id="label_${status.index}"></span></a>
				                 		    </c:if>
				                 		</li>
			                 		</c:if>
		                 	</c:if>
		           </c:forEach>
	           </c:if>
			</ul>
		</div>
	</div>
	</div>
	
<%-- <form id="moveParam" name="moveParam" action="" method="post">
	<input type="hidden" id="searchQueryMove" name="searchQuery" value="${vo.searchQuery}" />
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form> --%>
