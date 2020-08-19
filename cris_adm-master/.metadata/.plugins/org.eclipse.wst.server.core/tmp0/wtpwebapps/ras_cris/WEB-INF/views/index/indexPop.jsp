<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
	/* $(function(){
		//uploadPath
		 $.ajax({
		        url: '${ctxt}/mng/pop/mainPopList.do',						       
		        data: {},
		        type: 'GET',
		        dataType: 'text',
		        cache: false,
		        success: function(result) {	
		        
		        	var rtnObj = $(result);
		        	var html = "";
		        
		        	
		        if (rtnObj.find('item').length > 0 ){
		        	var uploadPath = rtnObj.find('uploadPath').text();
 				        uploadPath = uploadPath.substring(0, uploadPath.length-1);

		        	
		        	rtnObj.find('item').each(function(){
		        
			        	var file_path = $(this).find('pop__file__path').text();  // path						        
			        	var file_conv_nm = $(this).find('pop__file__conv__nm').text(); // nm
			        	var pop_link = $(this).find('pop__link').text(); //link
			        
		        		html += '<li><a href="'+pop_link+'"  target="_blank"><img width = "100%"  height = "100%" src="'+uploadPath+file_path+'/'+file_conv_nm +'" alt="팝업이미지" /></a></li>';
		        	});
		        	
		        	$("#test").html(html);
		 		}else{
		 			
		 		}
			    	
		        },
		        error : function(){                              // Ajax 전송 에러 발생시 실행
		        	fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
		        }
		    });
			
	}); */
</script>

<table>
  <tbody>
  <tr>
    <td><img src="${reParam2}" width="100%" height="100%" border="0"></td>

  </tr>
  <tr>
    <td height="30" align="right" bgcolor="#000000">
	    <table border="0" cellpadding="0" cellspacing="2">     	
	        <tbody>
		        <tr>
			        <td><input class="PopupCheck" type="checkbox" name="pop" id="popChk+${reParam1}" onclick="closePop('${reParam1}')"></td>
			        <td style="font-size:11px;color:#FFFFFF;">1일동안 이 창을 열지 않음</td>
		            <td style="font-size:11px;"><a href="javascript:self.close();" onfocus="this.blur()">[닫기]</a></td>
		        </tr>	       
	    	</tbody>    
	    </table>
    </td>
  </tr>
</tbody></table>
