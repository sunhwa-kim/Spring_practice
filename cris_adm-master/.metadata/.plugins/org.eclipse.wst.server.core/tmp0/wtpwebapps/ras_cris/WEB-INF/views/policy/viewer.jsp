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
			<span class="active">뷰어다운로드</span>
		</div>
		<span class="center_text_01">뷰어다운로드</span>
	</div> 
	<div class="under_bar"></div>			

<div class="content_wrap">
	<div class="content_box">		
		<div class="content_list">
			<div class="list_title"><p>홈페이지를 보기위한 최적의 컴퓨터 환경</p></div>
				<ul>
				<li class="hyphen">익스폴로러 9.0이상, 파이어 폭스 1.5, 오페라 7 이상, 화면해상도 1024x768 pixel 이상을 권장하며, 그 이상의 해상도에서 보시면 더 많은 내용을 화면 스크롤 없이 보실 수 있습니다.</li>
				<li>
					<table class="basic_table">
									<colgroup>
										<col style="width:20%">				
										<col style="width:*">
									</colgroup>
									<thead>
									<tr class="first">
										<th scope="col">항목</th>
										<th scope="col">뷰어 설명</th>
									</tr> 
									</thead>
									<tbody id="bodyInfo">
									<tr> 
										<td style="text-align:center;"><a target="_blank" rel="noopener noreferrer" href="http://www.hancom.com/cs_center/csDownload.do"><img src="${ctxt}/resources/images/sub/icon_viewer_hangul.gif"></a></td> 
										<td style="text-align:left;"><span>한글뷰어</span><br>한글 뷰어는 (주)한글과 컴퓨터에서 개발하여 배포하는 한글 전용 뷰어 프로그램입니다. 한글뷰어는 한글문서(*.hwp)의 내용을 확인하거나 인쇄할 수 있습니다.</td> 
									</tr>
									<tr>
										<td style="text-align:center;"><a target="_blank" rel="noopener noreferrer" href="https://get.adobe.com/reader/?loc=kr"><img src="${ctxt}/resources/images/sub/icon_viewer_acrobat.gif"></a></td> 
										<td style="text-align:left;"><span>아크로뱃리더 뷰어</span><br>PDF 문서는 문자나 그래프, 이미지를 원본형태로 담을 수 있는 파일 형식입니다.Adobe Acrobat Reader란 프로그램을 설치하면 인터넷상에서도
																								  PDF 첨부파일을 그대로 보거나 출력할 수 있습니다. 한번 설치하시면 이후에는 한번의 클릭으로 pdf파일을 바로 이용하실 수 있습니다.</td> 
									</tr>
									<tr>
										<td style="text-align:center;"><a target="_blank"  rel="noopener noreferrer" title="새창" href="http://www.microsoft.com/ko-kr/download/details.aspx?id=6"><img alt="Microsoft PowerPoint Viewer" width="118" height="52" src="${ctxt}/resources/images/sub/icon_viewer_powerpoint.gif"></a></td> 
										<td style="text-align:left;"><span>Microsoft PowerPoint Viewer</span><br>이 프로그램을 다운로드하여 사용하면 PowerPoint가 없거나 PowerPoint가 컴퓨터에 설치되어 있지 않은 사용자도 PowerPoint 프레젠테이션을 열어 볼 수 있습니다.</td> 
									</tr>
									<tr>
										<td style="text-align:center;"><a target="_blank"  rel="noopener noreferrer" title="새창" href="http://www.microsoft.com/ko-kr/download/details.aspx?id=10"><img alt="Microsoft Excel Viewer" width="118" height="52" src="${ctxt}/resources/images/sub/icon_viewer_excel.gif"></a></td> 
										<td style="text-align:left;"><span>Microsoft Excel Viewer</span><br>Excel 뷰어만 있으면 시스템에 Excel이 설치되어 있지 않아도 Excel로 작성된 문서를 읽을 수 있습니다.</td> 
									</tr>
									<tr>
										<td style="text-align:center;"><a target="_blank"  rel="noopener noreferrer" href="http://www.microsoft.com/ko-kr/download/details.aspx?id=4"><img alt="Microsoft Word Viewer" width="118" height="52" src="${ctxt}/resources/images/sub/icon_viewer_word.gif"></a></td> 
										<td style="text-align:left;"><span>Microsoft Word Viewer</span><br>Word 뷰어만 있으면 Word가 시스템에 설치되어 있지 않아도 Word로 작성된 문서를 사용할 수 있습니다.</td> 
									</tr>
									<tr>
										<td style="text-align:center;"><a target="_blank"  rel="noopener noreferrer" href="http://www.openoffice.org/download/index.html"><img alt="오픈오피스" width="118" height="52" src="${ctxt}/resources/images/sub/icon_viewer_openoffice.gif"></a></td> 
										<td style="text-align:left;"><span>오픈오피스</span><br>오픈오피스는 윈도우 및 리눅스를 포함한 다양한 플랫폼을 지원하는 무료 오피스 스위트입니다. 개인적인 용도 뿐만 아니라 회사에서도 사용이 가능하며 라이센스 걱정이 전혀 없습니다.</td> 
									</tr>
									</tbody>
								</table>
				</li>
				</ul>
		</div>	
	</div>		
</div>
	

<!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" />
