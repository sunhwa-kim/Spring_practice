<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
$(function(){      
    $(".tab-btn").eq(0).addClass("active");
    $(".tab-btn").click(function () {
        $(".tab-btn").removeClass("active");       
        $(this).addClass("active");
    });
    $(".tab_content").hide();
    $(".tab_content:first").show();

    
    $("ul.tabs li").eq(0).addClass("active").css("color", "#003964");
    $("ul.tabs li").click(function () {
        $("ul.tabs li").removeClass("active").css("color", "#7f7f7f");       
        $(this).addClass("active").css("color", "#003964");
        $(".tab_content").hide()
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn()
    });
});
</script>

<style>
.tab_content{
	padding:40px 40px 0 40px;
	letter-spacing:-0.5px;
}
.content_box>.content_list ul {
    width: auto;
}
.tabContainer>.tabs>li{
	width:100px;
}

.visit_step_box > .visit_step > div{
	width:100%;
	height:100%;
	position:relative;
}

.visit_step_box > .visit_step > div > p{
	position:absolute;
}
.visit_step_box>li>div>p:first-child {
    left:50%; 
    top:20%;
    color:#fff;
    transform:translate(-50%, 0);
	-o-transform:translate(-50%, 0);
	-ms-transform:translate(-50%, 0);
	-moz-transform:translate(-50%, 0);
	-webkit-transform:translate(-50%, 0);
}

.visit_step_box>li>div>p:last-child{
	left:50%; 
    top:53%;
    transform:translate(-50%, 0);
	-o-transform:translate(-50%, 0);
	-ms-transform:translate(-50%, 0);
	-moz-transform:translate(-50%, 0);
	-webkit-transform:translate(-50%, 0);
}
.text_box{
	width:100%;
	text-align:center;
}
.dashed{
	width:97%;
	margin-left:3%;
}
.list_full.limit > li:before, .list_full > li > ul > li.dashed:before, .list_full > li.dashed:before {
    display: inline-block;
    content: "-";
    width: 15px;
    height: 15px;
    margin-left:-20px; 
}
@media all and (max-width:1040px) {
	.visit_step_box > .visit_step {
	    width: 110px;
	    height: 110px;
	    margin-right: 10px;
	    transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}	
	.visit_step_box>li>div>p.line {
	    height: 1px;
	    width: 90px;
	    top: 50%;
	    transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}  
	.visit_step_box>li>div>p:first-child {
	    top:10%;
	    transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
	.visit_step_box>li>div>p:last-child{
		top:55%;
		font-size:12px;
		letter-spacing:-0.3px;
		transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
}
@media all and (max-width:688px) {
	.visit_step_box > .visit_step {
		width: 100px;
	    height: 100px;
	    margin-right: 5px;
	    transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
	.visit_step_box>li>div>p.line {
	    height: 1px;
	    width: 80px;
	    top: 50%;
	    transition:all 0.3s;
		-webkit-transition:all 0.3s;
	}
	#tab4>#info_4>.content_list2>.list_full>.search_pic>img{
		padding:20px 10%;
	}
}
@media all and (max-width:632px) {
	.visit_step_box>li:last-child{
		margin:0 auto;
	}
	.circle_box{
		display:block;
		width:100%;
		height:435px;
	}
	.visit_step_box{
		display:block;
		position:relative;
	}
	.visit_step_box > .visit_step {
	    margin-right:0;
		float:none;
	    display:block;
	    margin:0 auto;
	    transition:all 0.3s;
		-webkit-transition:all 0.3s;
		position:absolute;
		left:10%;
	}
	.visit_step_box > .visit_step:nth-child(2){
		top:110px;
	}
	.visit_step_box > .visit_step:nth-child(3){
		top:220px;
	}
	.visit_step_box > .visit_step:nth-child(4){
		top:330px;
	}
	.visit_step_box > .visit_step.none:nth-child(2n-1){
		display:none;
		width:0;
	}
	.text_box{
		position:absolute;
		width:100%;
		top:0;
	}
	.visit_step_box > .visit_step.none  {
	    position:absolute;
	    text-align:left;
	    left:45%;
	}
	.visit_step_box > .visit_step.none > ul {
	    left: 0;
	    transform: translate(0,0);
	    -o-transform: translate(0,0);
	    -ms-transform: translate(0,0);
	    -moz-transform: translate(0,0);
	    -webkit-transform: translate(0,0);
	}
	.visit_step_box > .visit_step.none:nth-child(2) .visit_step_title>span{
	    color: #fff;
	    background: #1A5887;
	}
	.visit_step_box > .visit_step.none:nth-child(4) .visit_step_title>span{
		color: #fff;
		background: #81AED0;
	}
	.visit_step_box > .visit_step.none .visit_step_title{
		margin-top:0;
	}
	
	/* tab2 */
	#tab3 > #info_3 > .content_list2 > .list_full > .pic_box2 > img:first-child{
		margin-right:0;
		margin-bottom:5px;
	}
	#tab3 > #info_3 > .content_list2 > .list_full > .pic_box2 > img{
		width:100%;
		max-with:370px;
		/* max-height:280px; */
		float:none;
	}
}
@media all and (max-width:552px) {
	.visit_step_box > .visit_step.none  {
	   left:160px;
	}
}
@media (max-width: 494px){
	.tab_content {
    	padding: 10px 10px 0 10px;
    	transition: all 0.3s;
	    -webkit-transition: all 0.3s;
    }
    
}

@media (max-width: 430px){
	.visit_step_box > .visit_step.none {
	    left: 140px;
	}
	.visit_step_con{
		letter-spacing:-0.5px;
		margin-left:0;
	}
	.visit_step_box > .visit_step {
		left:5%;
	    transition: all 0.3s;
	    -webkit-transition: all 0.3s;
    }
    .content_box>.content_list ul{
    	width:100%;
    }
    .tabContainer>.tabs>li{
    	width:33.333333333333333333333333333333%;
    	transition: all 0.3s;
	    -webkit-transition: all 0.3s;
    }
}

</style>

	<div class="sub_center_text">
		<div class="sub_center_nav"> 
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
			<span> > </span> 
			<span>센터안내</span>
			<span> > </span>
			<span class="active">이용안내</span>        
		</div>
		<span class="center_text_01">이용안내</span>
	</div> 
	<div class="under_bar"></div>
			
	<div class="content_wrap">
		<div class="content_box">
			<div class="content_list">
			
				<div class="tabContainer" style="width:100%;"> 
					<ul class="tabs">
				        <li class="active" rel="tab1" >이용안내</li>
				        <li rel="tab3">시설안내</li>
<!-- 				        <li rel="tab3">시설예약</li>	 -->
				        <li rel="tab4">도움말</li>					    
					</ul>
				    <div class="tab_container" style="width:100%; color:#666;">
				        <div id="tab1" class="tab_content">
				        	<div id="info_1" class="info tab-panel active">
								<div class="content_list2">
									<div class="list_title"><p>이용시간</p></div>
									<ul class="list_full">
										<li class="dashed">평일 : 09:00 ~ 20:00 단, 야간(18:00이후)이용은 북카페(1층) 및 종합자료실(2층)만 가능</li>
									</ul>
									<div class="list_title"><p>휴관일</p></div>
									<ul class="list_full">
										<li class="dashed">토요일 및 법정공휴일</li>
										<li class="dashed">기타 기관이 필요에 의해 정하는 날</li>
									</ul>
									
									<div class="list_title"><p>이용대상 및 절차</p></div>
									<ul class="list_full">
										<li class="dashed">이용대상 : 만 16세이상 대한민국 국민 및 국내 거주 외국인</li>
										<li class="dashed">이용증
											<ul class="dashed_ul">
												<li>일일이용증 : 이용 전 발급, 이용 후 반납</li>
												<li>정기이용증 : 이용자가 영구적으로 소지</li>
												<li>임시출입증 : 교육, 세미나 및 회의 참석시, 견학, 전시실 관람 등</li>
											</ul>
										</li>
										<li class="dashed" style="margin-top:10px;">방문시 이용절차</li>
										<li style="margin-top:20px;width:100%;text-align:center;" class="circle_box">	
											<ul class="visit_step_box" style="width:auto;">
												<li class="visit_step" style="background:#003964;"><div><p class="strong">01</p><p class="line"></p><p style="color:#fff;">홈페이지<br/>회원가입</p></div></li>
												<li class="visit_step" style="background:#1A5887;"><div><p class="strong">02</p><p class="line"></p><p style="color:#fff;">이용증 발급</p></div></li>
												<li class="visit_step" style="background:#4D86B1;"><div><p class="strong">03</p><p class="line"></p><p style="color:#fff;">자료실</p></div></li>
												<li class="visit_step margin0" style="background:#81AED0;"><div><p class="strong">04</p><p class="line"></p><p style="color:#fff;">종료</p></div></li>
												<li class="text_box">
													<ul class="visit_step_box" style="width:auto;">
														<li class="visit_step none"></li>
														<li class="visit_step none">
															<ul>
																<li class="visit_step_title"><span>일일 이용증</span></li>
																<li class="visit_step_con">무인발급기 이용</li>														
																<li class="visit_step_title"><span>정기 이용증</span></li>
																<li class="visit_step_con">안내데스크 신분증 확인 후 발급</li>
																<li class="visit_step_title"><span>임시 출입증</span></li>
																<li class="visit_step_con">안내데스크 문의</li>
															</ul>
														</li>
														<li class="visit_step none"></li>
														<li class="visit_step none">
															<ul>
																<li class="visit_step_title"><span>일일 이용증</span></li>
																<li class="visit_step_con">투입구에 반납</li>														
																<li class="visit_step_title"><span>임시 출입증</span></li>
																<li class="visit_step_con">안내데스크 반납</li>
															</ul>
														</li>
													</ul>
												</li>
											</ul>
										</li>
										<!-- <li class="text_box">
											<ul class="visit_step_box" style="width:auto;">
												<li class="visit_step none"></li>
												<li class="visit_step none">
													<ul>
														<li class="visit_step_title"><span>일일 이용증</span></li>
														<li class="visit_step_con">무인발급기 이용</li>														
														<li class="visit_step_title"><span>정기 이용증</span></li>
														<li class="visit_step_con">안내데스크 신분증 확인 후 발급</li>
														<li class="visit_step_title"><span>입시 출입증</span></li>
														<li class="visit_step_con">안내데스크 문의</li>
													</ul>
												</li>
												<li class="visit_step none"></li>
												<li class="visit_step none">
													<ul>
														<li class="visit_step_title"><span>일일 이용증</span></li>
														<li class="visit_step_con">투입구에 반납</li>														
														<li class="visit_step_title"><span>임시 출입증</span></li>
														<li class="visit_step_con">안내데스크 반납</li>
													</ul>
												</li>
											</ul>
										</li> -->
									</ul>
								</div>
							</div>							            
				        </div>
				        <!-- #tab1 -->
<!-- 				        <div id="tab2" class="tab_content">							         -->
<!-- 				        	<div id="info_2" class="info tab-panel"> -->
<!-- 								<div class="content_list2"> -->
<!-- 									<div class="list_title"><p>종합자료실</p></div> -->
<!-- 									<ul class="list_full"> -->
<!-- 										<li class="dashed">이용시간 : 09:00 ~ 20:00</li> -->
<!-- 										<li class="dashed">의과학 전문서적, 보고서, 학술지, 일반 교양서적을 자유롭게 열람할 수 있는 공간입니다.</li> -->
<!-- 										<li class="dashed">설치장비 : 검색PC3대, 복사기 1대</li> -->
<!-- 										<li class="dashed">개인연구실 -->
<!-- 											<ul class="dashed_ul"> -->
<!-- 												<li>이용과 연구 편의를 제공하기 위한 열람공간입니다.</li> -->
<!-- 												<li>이용시간 : 09:00 ~ 20:00</li> -->
<!-- 												<li>이용방법 : 홈페이지 및 좌석예약시스템을 통한 사전예약 후 이용 가능</li> -->
<!-- 											</ul> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 									<div class="list_title"><p>멀티미디어자료실</p></div> -->
<!-- 									<ul class="list_full"> -->
<!-- 										<li class="dashed">이용시간 : 09:00 ~ 18:00</li> -->
<!-- 										<li class="dashed">Web DB, 전자저널 및 전자책, 원문검색 등 디지털자료와 DVD 등 멀티미디어자료를 이용할 수 있습니다. -->
<!-- 											<ul class="dashed_ul"> -->
<!-- 												<li>설치장비 : 레이저프린터(컬러,흑백), 스캐너</li> -->
<!-- 											</ul> -->
<!-- 										</li> -->
<!-- 										<li class="dashed">전자자원검색PC(12석), 인터넷이용PC(14석), 노트북석(8석)</li> -->
<!-- 										<li class="dashed">AV코너 -->
<!-- 											<ul class="dashed_ul"> -->
<!-- 												<li>의과학 관련 DVD 자료 이용</li> -->
<!-- 											</ul> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 				        </div> -->
				         <!-- #tab2 -->
				        
				        <div id="tab3" class="tab_content">
			            	<div id="info_3" class="info tab-panel">
								<div class="content_list2">
									
									<div class="list_title"><p>북카페 (1층)</p></div>
									<ul class="list_full">
										<li class="dashed">이용 시간 : 09:00 ~ 20:00 </li>
										<li class="dashed">도서관 휴게 공간으로써 자유롭게 이용할 수 있으며, 다양한 잡지를 열람 할 수 있습니다.</li>
										<li class="pic_box2" >
											<img src="${ctxt}/resources/images/sub/bookcafe1.jpg">
											<img src="${ctxt}/resources/images/sub/bookcafe2.jpg">
										</li>
									</ul>
									
									<div class="list_title"><p>전산교육실 (1층)</p></div>
									<ul class="list_full">
										<li class="dashed">이용 시간 : 09:00 ~ 18:00 </li>
										<li class="dashed">이용 방법 : 담당자(☎ 249-3036)와 협의 후 이용 가능합니다.</li>
										<li class="dashed">구성 안내 : 전자교탁 1대, 빔프로젝트 2대, 교육용 PC 44대</li>
										<li class="pic_box2" >
											<img src="${ctxt}/resources/images/sub/computereducationroom1.jpg">
											<img src="${ctxt}/resources/images/sub/computereducationroom2.jpg">
										</li>
									</ul>
									
									<div class="list_title"><p>종합자료실 (2층)</p></div>
									<ul class="list_full">
										<li class="dashed">이용 시간 : 09:00 ~ 20:00 </li>
										<li class="dashed">의과학 전문서적, 보고서, 학술지, 일반교양서적을 자유롭게 열람할 수 있는 공간입니다.</li>
										<li class="pic_box2" >
											<img src="${ctxt}/resources/images/sub/comprehensivearchive1.jpg">
											<img src="${ctxt}/resources/images/sub/comprehensivearchive2.jpg">
										</li>
									</ul>
									
									<div class="list_title"><p>개인연구실 (2층)</p></div>
									<ul class="list_full">
										<li class="dashed">이용 시간 : 09:00 ~ 18:00 </li>
										<li class="dashed">이용 방법 : 국립의과학지식센터 1층 좌석 예약 키오스크에서 예약 후 이용 가능합니다.</li>
										<li class="dashed">구성 안내 : 책상 1개, 의자 1개, 사물함 1개, 전등 1개</li>
										<li class="pic_box2" >
											<img src="${ctxt}/resources/images/sub/privatelaboratory1.jpg">
											<img src="${ctxt}/resources/images/sub/privatelaboratory2.jpg">
										</li>
									</ul>
									
									<div class="list_title"><p>회의실 (2층)</p></div>
									<ul class="list_full">
										<li class="dashed">이용 시간 : 09:00 ~ 18:00 </li>
										<li class="dashed">이용 방법 : 담당자(☎ 249-3036)와 협의 후 이용 가능합니다.</li>
										<li class="dashed">구성 안내 : 전자교탁 1대, 빔프로젝트 1대, 좌석 25석, 배석 12석</li>
										<li class="pic_box2" >
											<img src="${ctxt}/resources/images/sub/meetingroom1.jpg">
											<img src="${ctxt}/resources/images/sub/meetingroom2.jpg">
										</li>
									</ul>
									
									<div class="list_title"><p>멀티미디어실 (3층)</p></div>
									<ul class="list_full">
										<li class="dashed">이용 시간 : 09:00 ~ 18:00 </li>
										<li class="dashed">Web-DB 전자저널 및 전자책, 원문검색등 디지털 자료와 DVD등 멀티미디어 자료를 이용할 수 있습니다.</li>
										<li class="dashed">구성 안내 : PC 좌석 30대</li>
										<li class="pic_box2" >
											<img src="${ctxt}/resources/images/sub/multimediaroom3.jpg">
											<img src="${ctxt}/resources/images/sub/multimediaroom4.jpg">
										</li>
									</ul>
									
									<div class="list_title"><p>영화상영실 (3층)</p></div>
									<ul class="list_full">
										<li class="dashed">이용 시간 : 09:00 ~ 18:00 </li>
										<li class="dashed">이용 방법 : 담당자(☎ 249-3036)와 협의 후 이용 가능합니다.</li>
										<li class="dashed">구성 안내 : DVD 플레이어 1대, 빔프로젝트 1대, 좌석 18석</li>
										<li class="pic_box2" >
											<img src="${ctxt}/resources/images/sub/movietheater1.jpg">
											<img src="${ctxt}/resources/images/sub/movietheater2.jpg">
										</li>
									</ul>
									
									<div class="list_title"><p>세미나실 (3층)</p></div>
									<ul class="list_full">
										<li class="dashed">이용 시간 : 09:00 ~ 18:00 </li>
										<li class="dashed">이용 방법 : 담당자(☎ 249-3036)와 협의 후 이용 가능합니다.</li>
										<li class="dashed">구성 안내 : 빔프로젝트 1대, 좌석 14석</li>
										<li class="pic_box2" >
											<img src="${ctxt}/resources/images/sub/seminarroom1.jpg">
											<img src="${ctxt}/resources/images/sub/seminarroom2.jpg">
										</li>
									</ul>
									
									<div class="list_title"><p>영화제작실 (4층)</p></div>
									<ul class="list_full">
										<li class="dashed">이용 시간 : 09:00 ~ 18:00 </li>
										<li class="dashed">이용 방법 : 담당자(☎ 249-3036)와 협의 후 이용 가능합니다.</li>
										<li class="dashed">구성 안내 : 비디오 카메라 1대, 프롬포터 1대, 영상편집 소프트웨어 2대</li>
										<li class="pic_box2" >
											<img src="${ctxt}/resources/images/sub/productionroom1.jpg">
											<img src="${ctxt}/resources/images/sub/productionroom2.jpg">
										</li>
									</ul>
									
								</div>
							</div>
				        </div>
				        <!-- #tab3 -->
				        
				        <div id="tab4" class="tab_content">
			            	<div id="info_4" class="info tab-panel">
								<div class="content_list2">
									<div class="list_title"><p>메인검색</p></div>
									<ul class="list_full">
										<li class="search_pic"><img src="${ctxt}/resources/images/sub/search_image3.png"></li>
									</ul>
									<div class="list_title"><p>검색유형별</p></div>
									<ul class="list_full">
										<li class="dashed">통합검색 : 국립의과학지식센터 소장자료, 구독 중인 전자자원, 국내학술논문 등을 통합검색</li>
										<li class="dashed">국내학술논문 : 국내 발행 학술지 1,200여종의 서지정보 및 최근호 게재 학술논문 검색</li>
										<li class="dashed">소장자료 : 단행본, 연속간행물, 보고서, 비도서 등 소장자료 검색</li>
										<li class="dashed">전자자원 : E-Journals, E-Books, WebDB 등 구독 중인 전자자원의 서지 및 원문 검색</li>
										<li class="dashed">PubMed : 미국 국립의학도서관 제공 생의학 관련 의학문헌색인검색시스템 검색</li>
									</ul>
									<div class="list_title"><p>상세검색</p></div>
									<ul class="list_full">
										<li class="search_pic"><img src="${ctxt}/resources/images/sub/search_image5.png"></li>
									</ul>	
									<div class="list_title"><p>검색방법</p></div>
									<ul class="list_full">
										<li class="dashed">검색어를 포함하고 있는 모든 자료가 검색됩니다.</li>
										<li class="dashed">2개 이상의 검색어 선택시 논리연산자(AND, OR, NOT)를 이용하여 검색조건 지정</li>
									</ul>
									<div class="list_title"><p>자료구분</p></div>
									<ul class="list_full">
										<li class="dashed">국내학술논문 : 국내에서 발행되는 의과학 학술지에 게재된 학술논문</li>
										<li class="dashed">단행본 : 일회성으로 발간되는 국·내외 의과학분야 인쇄 및 전자 형태의 전문자료</li>
										<li class="dashed">보고서 : 국·내외에서 발간되는 의과학 관련 연구보고서</li>
										<li class="dashed">연속간행물 : 연속적으로 발행되는 국·내외 의과학 분야 전문자료</li>
										<li class="dashed">비도서 : 의과학 관련 비디오녹화자료 및 기타 시청각 자료</li>
									</ul>	
									<div class="list_title"><p>검색도움말</p></div>
									<ul class="list_full">
										<li class="dashed">서명 : 자료의 서명, 저널명, 논문명 등으로 검색</li>
										<li class="dashed">저자 : 저작에 책임을 지는 저자, 단체명 등으로 검색
											<ul class="dashed_ul">
												<li>외국인명은 성, 이름 순으로 입력</li>
												<li>ex)Gates bill</li>
											</ul>
										</li>
										<li class="dashed">주제 : 의학학술분류체계 MeSH 주제명으로 검색</li>
										<li class="dashed">국제표준번호 : 국제표준도서번호(ISBN)와 국제표준연속간행물번호(ISSN)로 검색
											<ul class="dashed_ul">
												<li>ex) ISBN 검색어 : 9788968381420</li>
												<li>ex) ISSN 검색어 : 2280-3301</li>
											</ul>
										</li>
									</ul>									
								</div>
							</div>
				        </div>
				        <!-- #tab4 -->
					</div>
				</div>
			</div>
		</div>
	</div>
    



	<%-- <div class="content_wrap">
		${infoVo.info_cn}
	</div> --%>
	<%-- <div class = "content_wrap">
		<div class="content_box">
			<div class="content_list">
				<!-- <div class="list_title">
					<p id="search_cn">Map</p>
				</div> -->
				${infoVo.info_cn}
			</div>
		</div>
	</div> --%>
	
	


