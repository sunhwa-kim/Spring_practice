<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
@media (max-width: 640px){
	.reference{
		padding-left:10px;
	}
	.img_box>.border_box>.pic {
	    width: 49%;
	    margin-right: 2%;
	    padding: 5px;
	}
	.img_box>.border_box>.pic:nth-child(3n) {
	    margin-right: 2%;
	}
	.img_box>.border_box>.pic:nth-child(2n) {
	    margin-right: 0%;
	}
}
@media (max-width: 480px){
	.image_caption {
	    font-size: 12px;
	    color: #47584D;
	}
	.foot {
	    display: block;
	}	
}
</style>
<div class="sub_center_text">
	<div class="sub_center_nav"> 
		<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>        
     	<span> > </span> 
     	<span class="active">Facilities</span>
    </div>
    <span class="center_text_01">Facilities</span>     
</div> 
<div class="under_bar"></div>
	
<div class="content_wrap">
	<div class="content_box">		
		<div class="content_list">		
			<p class="eng_text"><span>9 a.m. - 8 p.m. every weekdays</span></p>
			<p class="reference"><span>※</span> The <strong>NCMIK</strong> services and resources are open accessible to anyone.</p>		
		<br/>	
			<p class="eng_text">The NCMIK was constructed in the area of 9,918 m<sup>2</sup></p>
			<div style="width:100%;border:0;">
	        	<table class="basic_table" cellspacing="0" cellpadding="0" style="" summary="">
					<caption>Facilities</caption>
					<colgroup>
						<col width="20%">
						<col width="80%">
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col">Floor</th>
							<th scope="col">Facilities</th>
						</tr>
					</thead>
					<tbody id="bodyInfo">
						<tr>
							<td>Basement</td>
							<td>Stack Room</td>
						</tr>
						<tr>
							 <td>1st floor</td>
							 <td>Book Cafe, Exhibition Hall (KCDC Museum), Computer-assisted Training Room, Project Team Room</td>
					    </tr>
						<tr>
							 <td>2nd floor</td>
							 <td>Medical Library, Personal Research Rooms, International Conference Room, Division of Medical Science Knowledge Management(administrative office)</td>
					    </tr>
						<tr>
							 <td>3rd floor </td>
							 <td>Multimedia Library, Seminar room, Movie Theater, Division of Life Science Research management((administrative office)</td>
					    </tr>
						<tr>
							 <td>4th floor</td>
							 <td>Multimedia Studio, Data Analysis Room, Bio-medical Informatics Room(Clinical and Omics Data Archive), R&D Management Team Room </td>
					    </tr>
				    </tbody>
				</table>
			</div>
			<div class="img_box">
				<div class="border_box">
					<div class="pic">
						<p><img src="${ctxt}/resources/images/main/bookcafe.png"></p>
						<p class="image_caption">Book cafe</p>
					</div>
					<div class="pic">
						<p><img src="${ctxt}/resources/images/main/computerroom.png"></p>
						<p class="image_caption">Computer room</p>
					</div>
					<div class="pic">
						<p><img src="${ctxt}/resources/images/main/exhibitionhall.png"></p>
						<p class="image_caption">Exhibition hall</p>
					</div>
					<div class="pic">
						<p><img src="${ctxt}/resources/images/main/readingroom.png"></p>
						<p class="image_caption">Reading room</p>
					</div>
					<div class="pic">
						<p><img src="${ctxt}/resources/images/main/personalresearchroom.png"></p>
						<p class="image_caption">Personal research room</p>
					</div>
					<div class="pic">
						<p><img src="${ctxt}/resources/images/main/conferenceroom.png"></p>
						<p class="image_caption">Conference room</p>
					</div>
					<div class="pic">
						<p><img src="${ctxt}/resources/images/main/mulitimediaroom.png"></p>
						<p class="image_caption">Multimedia room</p>
					</div>
					<div class="pic">
						<p><img src="${ctxt}/resources/images/main/seminarroom.png"s></p>
						<p class="image_caption">Seminar room</p>
					</div>
					<div class="pic">
						<p><img src="${ctxt}/resources/images/main/mediastudio.png"></p>
						<p class="image_caption">Media studio</p>	
					</div>
					<p style="float:none; clear:both; margin:20px 0 10px 0;">Facilities of the NCMIK</p>
				</div>
			</div>
		</div>
	</div>		
</div>

<!-- 공통  필수 PARAM  -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" alt = "token" />


