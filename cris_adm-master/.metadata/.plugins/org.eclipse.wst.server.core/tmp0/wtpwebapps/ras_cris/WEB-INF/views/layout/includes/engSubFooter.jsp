<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
 
$(function(){
	
	$(".footLink").hide();
	
	
});
</script>

<style>
	@media (max-width: 768px){
		#footer div.foot > div.foot1 {
		    width: 50%;
		    text-align:right;
		    height:45px;
		    line-height:45px;
		}
		#footer div.foot > div.foot2 {
		    width: 50%;
		     text-align:left;
		     height:45px;
		}
		#footer div.foot > div.foot2 img{
			height:100%;
		}
	}
 	@media all and (max-width:502px) {
	 	#footer .english_page{
			display:block;
		}
		.footLink{
			display:block !important;
		}
		#footer div.foot > div > div{
			padding:15px 10px;
		}
 	} 
 
 </style>

<footer id="footer">
 <!--policy email fSite-->
	<div class="footLinkWrap">
		<div class="footLink">
        	<div class="link">
        		<div class="english_page"><a href="${ctxt}/index/index.do">Korean</a></div>            	           
            </div>
        </div>
    </div>
    <!--policy email fSite-->
    
    <!--foot txt-->
    <div class="foot">
        	<div class="foot1"><img src="${ctxt}/resources/images/sub/engfoot01.png" alt="질병관리본부"></div>
        	<div class="foot2"><img src="${ctxt}/resources/images/sub/foot02.PNG" alt="질병관리본부"></div>
    	<div>
            <div>
                <address>National Center for Medical Information and Knowledge<br>
                 202 Osongsaengmyeong 2-ro, Osong-eup, Heungdeok-gu, Cheongju-si, Chungcheongbuk-do, Korea, 28160</address><br>
				Tel : 043-249-3000 Fax : 043-249-3034 E-mail : <a href="mailto:ncmik@korea.kr">ncmik@korea.kr</a><br>
                Copyright by NCMIK. All Rights Reserved.
        	</div>
            
        </div>
    </div>
    <!--foot txt-->
</footer>
