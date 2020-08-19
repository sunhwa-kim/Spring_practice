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
	      <span>의과학도서관</span>
	      <span> > </span>
	      <span class="active">단행본</span>        
      </div>
        
	        <a href="#" class="center_text_01">소장자료<span>(6건)</span></a>
</div> 
			
			<div class="under_bar"></div>
			
<!-- 도서 목록 -->
<div class="content_wrap">
		<!--소장전체-->
		<div class="sub_book_wrap">  		 
			 <div class="search_wrap">
				<div id="search-group">
					<div class="search-input">
						<label for="searchCombo"></label>
						<select id="searchCondition" name ="searchCondition" title="분류">
							<option value="ALL">전체</option>
							<option value="TITL">제목</option>
						</select>
						<label for="searchBox"></label>
						<input type="text" id="searchKeyword" name= "searchKeyword" value="<c:out value='${archiveReportVo.searchKeyword}'/>" onkeydown="fn_enter_search(this);" placeholder="검색어를 입력해주세요."/>
		            	<input type="button" id="btnSearch" value="검색" onclick="javascript:fn_search(1)"/>
					</div>
				</div>
			 </div>
			 
			 <div class="selectbox_wrap">
					<select id="selectbox1" class="sub_select">
					  <span class="sub_arr"></span>
					  <option value="1">정렬</option>
					  <option value="2">10</option>
					  <option value="3">20</option>
					  <option value="4">30</option>
					  <option value="5">50</option>
					</select>
					
					<select id="selectbox2" class="sub_select">
					  <span class="sub_arr"></span>
					  <option value="1">최신순</option>
					  <option value="2">인기순</option>
					  <option value="3">최신순</option>
					  <option value="4">최신순</option>
					  <option value="5">최신순</option>
					</select>                
					<a href="#" class="center_text_02">전체선택</a>
					<a href="#" class="center_text_02">내서재담기<div id="library1"></div></a>
					<a href="#" class="center_text_02">서지사항내려받기<div id="library2"></div></a>
				</div>
				
			 
			 <span class="center_text_001">단행본<span>(3건)</span></span>
			 <div class="under_bar2"></div>
			 <div>
			  <input id="option" type="checkbox" name="field" value="option">
			  <label for="option"><span><span></span></span></label>
				 <ul>
				  <li class="sub_center_cont_text">나는 나로 살기로 했다 : 냉담한 현실에서 어른살이를 위한 to do list</li> 
				  <li class="sub_center_cont_text02"><span class="text02_1">저자:</span> 김수현&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">발행처:</span> 마음의 숲&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">발행연도:</span> 2016</li>   
				  <li class="sub_center_cont_text02"><span class="text02_1">청구기호:</span> 818 김56ㄴ 2016 C.2&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">배가위치:</span> 종합자료실(2F)</li>   
				  <li class="sub_center_cont_text02"><a class="a_btn" href="#">소장정보</a> <a class="a_btn" href="#">상세정보</a> <a class="a_btn" href="#">원문정보</a></li>
				 </ul>
			 </div>   
				
			 <div> 
			  <input id="option" type="checkbox" name="field" value="option">
			  <label for="option"><span><span></span></span></label>					
				 <ul>
				  <li class="sub_center_cont_text">모든 문장은 나를 위해 존재한다 : 작가의 삶에 녹아든 문장들</li> 
				  <li class="sub_center_cont_text02"><span class="text02_1">저자:</span> 김진규&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">발행처:</span> 마음산책&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">발행연도:</span> 2009</li>   
				  <li class="sub_center_cont_text02"><span class="text02_1">청구기호:</span> 802 김78ㅁ 2009&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">배가위치:</span> -</li>   
				  <li class="sub_center_cont_text02"><a class="a_btn" href="#">소장정보</a> <a class="a_btn" href="#">상세정보</a> <a class="a_btn" href="#">원문정보</a></li> 
				 </ul>
			 </div>
				
			 <div>
			  <input id="option" type="checkbox" name="field" value="option">
			  <label for="option"><span><span></span></span></label>
				 <ul>
				  <li class="sub_center_cont_text">EU 개인정보보호법=EU persnal data protection law</li> 
				  <li class="sub_center_cont_text02"><span class="text02_1">저자:</span> 함인선&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">발행처:</span> 마로니에 &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">발행연도:</span> 2016</li>   
				  <li class="sub_center_cont_text02"><span class="text02_1">청구기호:</span> 362.0222 함68e 2016&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">배가위치:</span> 종합자료실(2F)</li>   
				  <li class="sub_center_cont_text02"><a class="a_btn" href="#">소장정보</a> <a class="a_btn" href="#">상세정보</a> <a class="a_btn" href="#">원문정보</a></li>    
				 </ul>
			 </div>
			<a class="more_btn" href="#">더보기</a>
		</div>
		<!--소장전체 끝-->				
		 
		 
			<!-- 단행본 -->
			<div class="sub_book_wrap">
				<span class="center_text_001">보고서<span>(2건)</span></span>
				<div class="under_bar2"></div>
					<div>  
					  <input id="option" type="checkbox" name="field" value="option">
					  <label for="option"><span><span></span></span></label>
						 <ul>
						  <li class="sub_center_cont_text">나는 나로 살기로 했다 : 냉담한 현실에서 어른살이를 위한 to do list</li> 
						  <li class="sub_center_cont_text02"><span class="text02_1">저자:</span> 김수현&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">발행처:</span> 마음의 숲&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">발행연도:</span> 2016</li>   
						  <li class="sub_center_cont_text02"><span class="text02_1">청구기호:</span> 818 김56ㄴ 2016 C.2&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">배가위치:</span> 종합자료실(2F)</li>   
						  <li class="sub_center_cont_text02"><a class="a_btn" href="#">소장정보</a> <a class="a_btn" href="#">상세정보</a> <a class="a_btn" href="#">원문정보</a></li>
						 </ul>
					</div>    
						
					<div>  
					  <input id="option" type="checkbox" name="field" value="option">
					  <label for="option"><span><span></span></span></label>
						 <ul>
						  <li class="sub_center_cont_text">모든 문장은 나를 위해 존재한다 : 작가의 삶에 녹아든 문장들</li> 
						  <li class="sub_center_cont_text02"><span class="text02_1">저자:</span> 김진규&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">발행처:</span> 마음산책&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">발행연도:</span> 2009</li>   
						  <li class="sub_center_cont_text02"><span class="text02_1">청구기호:</span> 802 김78ㅁ 2009&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">배가위치:</span> -</li>   
						  <li class="sub_center_cont_text02"><a class="a_btn" href="#">소장정보</a> <a class="a_btn" href="#">상세정보</a> <a class="a_btn" href="#">원문정보</a></li> 
						 </ul>
					</div>
					<a class="more_btn" href="#">더보기</a>
		    </div>		
			<!-- 단행본 끝 -->
			
			
			<!-- e-Book -->
			<div class="sub_book_wrap">
				<span class="center_text_001">비도서<span>(1건)</span></span>
				<div class="under_bar2"></div>
					<div>
					  <input id="option" type="checkbox" name="field" value="option">
					  <label for="option"><span><span></span></span></label>
						 <ul>
						  <li class="sub_center_cont_text">EU 개인정보보호법=EU persnal data protection law</li> 
				  		  <li class="sub_center_cont_text02"><span class="text02_1">저자:</span> 함인선&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">발행처:</span> 마로니에 &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">발행연도:</span> 2016</li>   
				 		  <li class="sub_center_cont_text02"><span class="text02_1">청구기호:</span> 362.0222 함68e 2016&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span class="text02_1">배가위치:</span> 종합자료실(2F)</li>   
				 		  <li class="sub_center_cont_text02"><a class="a_btn" href="#">소장정보</a> <a class="a_btn" href="#">상세정보</a> <a class="a_btn" href="#">원문정보</a></li>    
						 </ul>
					</div>    
					<a class="more_btn" href="#">더보기</a>
		    </div>		
			<!-- e-Book 끝 -->				 
</div> <!-- 도서 목록 끝 -->  
	
<%@include file="../layout/includes/subRightMenu.jsp"%>

