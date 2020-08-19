<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>




     
<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>정책 및 뷰어</span>
			<span> > </span>
			<span class="active">저작권 정책</span>
		</div>
		<span class="center_text_01">저작권 정책</span>
</div> 
	<div class="under_bar"></div>
			

<div class="content_wrap">
	<div class="content_box">		
		<div class="content_list">
			<div class="list_title"><p>저작권 정책</p></div><br>
				<ul>
					<li>
						<ul>
							<li class="hyphen">우리 기관 홈페이지에서 제공하는 모든 자료는 저작권법에 의하여 보호받는 저작물로서, 별도의 저작권 표시 또는 출처를 명시한 경우를 제외하고는 원칙적으로 우리 기관에 저작권이 있으며, 이를 무단 복제, 배포하는 경우에는 저작권법 제 97조 5조에 의한 저작재산권 침해죄에 해당함을 유념하시기 바랍니다.</li><br>
							<li class="hyphen">우리 기관에서 제공하는 자료로 수익을 얻거나 이에 상응하는 혜택을 얻고자 하는 경우에는 우리 기관과 사전에 별도의 협의를 하거나 허락을 얻어야 하며, 협의 또는 허락에 의한 경우에도 출처가 질병관리본부임을 반드시 명시해야 합니다.</li><br>
							<li class="hyphen">우리 기관의 컨텐츠를 적법한 절차에 따라 다른 인터넷 사이트에 게재하는 경우에도 단순한 오류 정정 이외에 내용의 무단 변경을 금지하여, 이를 위반할 때에는 형사 처벌을 받을 수 있습니다. 또한 다른 인터넷 사이트에서 우리 기관 홈페이지로 링크하는 경우에도 링크사실을 우리 기관에 반드시 통지하여야 합니다.</li><br>
							<li class="hyphen">저작권법 제24조의2에 따라 질병관리본부에서 저작재산권의 전부를 보유한 저작물의 경우에는 별도의 이용허락 없이 자유이용이 가능합니다.
												단, 자유이용이 가능한 자료는<span>“공공저작물 자유이용허락 표시 기준(공공누리,KOGL) 제1유형"</span><img src="${ctxt}/resources/images/sub/19589_body_1_3.jpg" style="vertical-align: middle;">공공누리 공공저작물 자유이용허락 을 부착하여 개방하고 있으므로 공공누리 표시가 부착된 저작물인지를 확인한 이후에 자유 이용하시기 바랍니다. 자유이용의 경우에는 반드시 저작물의 출처를 구체적으로 표시하여야 합니다. 공공누리가 부착되지 않은 자료들을 사용하고자 할 경우에는 담당자와 사전에 협의한 이후에 이용하여 주시기 바랍니다</li>
						</ul>
					</li>
				</ul>
		</div>
	</div>		
</div>
	

<!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" />
