<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- leftMenu -->
<script type="text/javascript">
$(function(){

	$(".sub_left_ul>li>a").click(function(){
		$(".sidebar-left2 ul ul").slideUp();
		if(!$(this).next().is(":visible")){
			$(this).next().slideDown();
		}
	})
	   
	if($(".sidebar-left2 ul ul li a").is(".menuLvl2")===true){
		$(".menuLvl2").parents().parents().slideDown();
		$(".menuLvl2").parents().parents().siblings('a').addClass("menuLvl1");
	}

	if($("#menuGubun").val() != undefined && $("#menuGubun").val() != ''){
		var menuGubun = $("#menuGubun").val().split('/');
		switch(menuGubun[1]){
		case 'elib':
			 $('.sidebar-left1').css('background-color','#5c755f');
			 break;
		case 'archive':
			 $('.sidebar-left1').css('background-color','#aa7d5e');
			 break;
		case 'mlib':
			 $('.sidebar-left1').css('background-color','#9c9f84');
			 break; 
		case 'data':
			 $('.sidebar-left1').css('background-color','#4d8963');
			 break;
		
		} 
	}
	

	
})

function fn_open(obj){
		$(".sub_left_ul ul ul").slideUp();
		if(!$("#"+obj).is(":visible")){
			$("#"+obj).slideDown();
		}
		
}

function lv1_click(obj){
		$('.menuLvl1').removeClass();
		$('#lv1_'+obj).addClass('menuLvl1');
}
</script>

<style>
	@media all and (max-width:990px) {
		#sidebar-left{
			width:0;
			display:none;
		}
	}
</style>
	<div id="sidebar-left" class="sidebar-left"> 
		<div class="sidebar-left1">
			<div  class="sub_left_div"></div>
		       <c:if test = "${fn:length(sys_leftMenu) ne 0  }" >		           
		           <c:forEach var="menuTitle" items="${sys_leftMenu}" varStatus="status">
		           	  <c:if test="${menuTitle.lvl eq '0'}">
		           	  		<span class="sub_left_text"><c:out value="${menuTitle.menuNm}"/></span>
		           	  		<input type="hidden" id="menuGubun" value="${menuTitle.url}">
		           	  </c:if>
		           </c:forEach>
		       </c:if>		
        </div>		    
		<div class="sidebar-left2">
			<ul class="sub_left_ul">
	           <c:if test = "${fn:length(sys_leftMenu) ne 0  }" >
		            <c:forEach var="menuVo1" items="${sys_leftMenu}" varStatus="status">	              
		                 	<c:if test="${menuVo1.lvl ne '0'}">		                 		
			                 		<c:if test="${menuVo1.lvl eq '1'}">		
				                 		<li>
				                 		    <c:if test="${menuVo1.menu_con eq '0'}">
				                 		    	<a  href="#" id="lv1_${status.index}" onclick="javascript:lv1_click(${status.index})"> <c:out value="${menuVo1.menuNm}"/></a>		                 		   
				                 		    </c:if>
				                 		    <c:if test="${menuVo1.menu_con eq '1'}">				                 		    	
			                 		    		<a <c:if test="${menuVo1.selYn eq true} ">id="lv1_${status.index}" class="menuLvl1"</c:if> href="${ctxt}<c:out value='${menuVo1.url}'/>" >  <c:out value="${menuVo1.menuNm}"/></a>		                 		                     		  						                 		    	
				                 		    </c:if>		
				                 			<ul>
				                 				<!-- 2레벨 -->
				                 				<c:forEach var="menuVo2" items="${sys_leftMenu}" varStatus="status">				                 			
					                 				<c:if test="${menuVo1.menu_id eq menuVo2.menu_prts_id}">
					                 					<li>					                 					
					                 						<c:if test="${menuVo2.menu_con eq '0'}">
								                 		    	<a  href="javascript:fn_open('lv3_${status.index}')" class="menuLvl1"> <c:out value="${menuVo2.menuNm}"/></a>
								                 		    </c:if>
								                 		    <c:if test="${menuVo2.menu_con eq '1'}">
								                 		    	<a <c:if test="${menuVo2.selYn eq true}">class="menuLvl2"</c:if> href="${ctxt}<c:out value='${menuVo2.url}'/>" ><c:out value="${menuVo2.menuNm}"/></a>
								                 		    </c:if>
					                 					</li>
						                					<!-- 3레벨 -->
						                					<li>
						                						<ul id="lv3_<c:out value='${status.index}'/>">
								                					<c:forEach var="menuVo3" items="${sys_leftMenu}" varStatus="status">
										                 				<c:if test="${menuVo2.menu_id eq menuVo3.menu_prts_id}">
										                 				<li><a <c:if test="${menuVo3.selYn eq true}">class="menuLvl2"</c:if> href="${ctxt}<c:out value='${menuVo3.url}'/>" ><img src="${ctxt}/resources/images/sub/bg_dot.png" style="margin-right:5px;margin-bottom:4px;"/> <c:out value="${menuVo3.menuNm}"/></a></li>
										                 				</c:if>
									                 				</c:forEach>
							                 					</ul>
							                 				</li>
					                 				</c:if>
				                 				</c:forEach>
				                 			</ul>						                 		
				                 		</li>
			                 		</c:if>
		                 	
		                 	</c:if>
		           </c:forEach>
	           </c:if>
			</ul>
		</div>
	
	</div>
	<form id="moveParam" name="moveParam" action="" method="post">
		<input type="hidden" id="searchQuery" name="searchQuery" value="" />
		<input type="hidden" id="param_query" name="query" value="" />
		<input type="hidden" id="detailYn" name="detailYn" value="N" />		   
		<input type="hidden" id="a" name="searchTarget" value="eds" />		
		<input type="hidden" id="b" name="pageNum" value="1" />		
	</form>

<!-- leftMenu End -->