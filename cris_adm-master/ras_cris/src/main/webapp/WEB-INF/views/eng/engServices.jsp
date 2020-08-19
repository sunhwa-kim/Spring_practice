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
			      <span class="active">Services</span>
		      </div>  
		      <span class="center_text_01">Services</span>   
		</div> 
		<div class="under_bar"></div>	
<div class="content_wrap">
	<div class="content_box">		
		<div class="content_list">
			<div class="list_title"><p>Medical Library</p></div>
			<p class="eng_text">Since 2014, NCMIK has been collecting, organizing and preserving scholarly biomedical literature and relevant resources and providing free access to scientific information services. </p>
			<p class="eng_textdot">• Books, Journals and Multimedia</p>
			<p class="eng_textSub">It includes over 50 thousand biomedical literatures, journals, multimedia (DVDs, video clips), and resources. Anyone can visit and use check-in and-out services for viewing and utilize the facilities such as personal rooms for research, computer-assisted training room at the library.</p>
			<p class="eng_textdot">• Web-accessible Online Resources</p>
			<p class="eng_textSub">It also provides access to a wide variety of relevant web-accessible online resources including biomedical journal databases and research tools.</p>
			<p class="eng_textdot">• Korea OpenMed</p>
			<p class="eng_textSub">Korea OpenMed, biomedical article index database, provides access to over 280,000 domestic biomedical journal abstracts and the full texts of articles in some cases, The abstracts and full texts can be searched using MeSH terms, author names, title words, text words or phrases, journal names, or any combination of these. Simultaneously, it also provides access to international biomedical databases such as PubMed, PubMed Central, Science Direct, Embase. </p>
			<p class="eng_textSub">Korea OpenMed is available on a web site for biomedical literature at http://library.nih.go.kr.</p>
			<div class="list_title"><p>Healthcare Archives</p></div>
			<p class="eng_text">The NCMIK provides access to a policy reports, guidelines and R&D-related  articles that produced/published by government-fund support. </p>
			<div class="list_title"><p>KCDC Museum</p></div>
			<p class="eng_text">The NCMIK exhibits the historical collections of public health in Korea and presents the rich heritage and accomplishments of Korea Centers for Disease Control and Prevention(KCDC).</p>
			<div class="list_title"><p>Data Center</p></div>
			<p class="eng_text">The NCMIK provides data center service to perform on/off-line statistical analysis using SAS, SPSS, R, and utility applications. The users can use the Korea National Medical Insurance database on online connection as well disease-related datasets such as death registration and meteorological data.</p>
			<div class="list_title"><p>Training Center</p></div>
			<p class="eng_text">The NCMIK provides unmet need-based education programs(open knowledge seminars) to staffs and researchers of the KCDC. These include epidemilogical methods, statistical analysis with big data, and  media training.</p>
			<div class="list_title"><p>Publications of KCDC</p></div>
			<p class="eng_textdotT">• Osong Public Health and Research Perspectives</p>
			<p class="eng_textSub">The NCMIK publishes the Osong Public Health and Research Perspectives(Osong PHRP), bimonthly international journal by the Korea Centers for Disease Control and Prevention since 2010. (Korea CDC).</p>
			<p class="eng_textSub">The Osong PHRP focuses on emerging infectious diseases, vaccinlogy, zoonotic diseases, non-communicable diseases, intractable and rare diseases, and human genomics. The website is available at <a href="http://www.kcdc-phrp.org" target="_blank" rel="noopener noreferrer">http://www.kcdc-phrp.org.</a></p>
			<div class="img_box">
				<div class="border_box">
					<p class="w_report">
						<img src="${ctxt}/resources/images/main/osongresearch1.png" >
					</p>
					<p class="w_report">
						<img src="${ctxt}/resources/images/main/osongresearch2.png" >
					</p>
					<p class="image_caption" style="float:none; clear:both; padding:15px 0 10px 0; display:block;">Osong Public Health and Research Perspectives</p>	
				</div>
			</div>
			<p class="eng_textdotT">• Public Health Weekly Report</p>
			<p class="eng_textSub">The NCMIK publishes the Public Health Weekly Report(PHWR) by the Korea Centers for Disease Control and Prevention since 2007. </p>
			<p class="eng_textSub">The PHWR includes research articles, brief reports, along with statistics on national notifiable and sentinel-reporting infectious disease surveillance systems. Additionally,  laboratory-based sentinel surveillance data on virus/bacteria, and vector sentinel surveillance data on vector-borne diseases are also provided. The website is available at <a href="http://www.cdc.go.kr/phwr/" target="_blank" rel="noopener noreferrer">http://www.cdc.go.kr/phwr/</a></p>
			<div class="img_box">
				<div class="border_box">
					<p class="w_report">
						<img src="${ctxt}/resources/images/main/publichealth1.png">
					</p>
					<p class="w_report">
						<img src="${ctxt}/resources/images/main/publichealth2.png">
					</p>
					<p class="image_caption" style="float:none; clear:both; padding:15px 0 10px 0; display:block;">Public Health Weekly Report</p>		
				</div>
			</div>
		</div>
	</div>		
</div>

<!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" />


