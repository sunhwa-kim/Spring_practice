var ctxt = "/cris";

var formStr = "<form name='popForm' id='popForm'>";
formStr += "<input type='hidden' name='rasParameter1' id='rasParameter1' />" ;
formStr += "<input type='hidden' name='rasParameter2' id='rasParameter2' />" ;
formStr += "</form>" ;
document.write(formStr) ;



// 공통 팝업 호출
function fn_cmmnPop(){
	
	$.ajax({
	    url: ctxt+'/mng/pop/mainPopList.do',						       
	    data: {},
	    type: 'GET',
	    dataType: 'text',
	    async: false, 
	    cache: false,        
	    success: function(result) {	
	    	var rtnObj = $(result);
	    	var html = "";        	
	        if (rtnObj.find('item').length > 0 ){
	        	var uploadPath = rtnObj.find('uploadPath').text();
				    uploadPath = uploadPath.substring(0, uploadPath.length-1);     	
	        		
				    rtnObj.find('item').each(function(){
				    	
				    	var pop_sn = $(this).find('pop_sn').text();  // path		
			        	var file_path = $(this).find('pop_file_path').text();  // path						        
			        	var file_conv_nm = $(this).find('pop_file_conv_nm').text(); // nm
			        	var pop_link = $(this).find('pop_link').text(); //link
			        	var path = ctxt+uploadPath+'/'+file_conv_nm;
			        	
			        	var pop_width = $(this).find('pop_width').text(); //pop_width
			        	var pop_height = $(this).find('pop_height').text(); //pop_height
			        	
			        	var pop_left = $(this).find('pop_left').text(); //pop_left
			        	var pop_top = $(this).find('pop_top').text(); //pop_top
			        	
			        	// 팝업띄우기
			        	fn_popContol(pop_sn, path, pop_width , pop_height ,pop_left ,pop_top);
				    });
				 
	 		}else{
	 			
	 		}
	    },
	    error : function(){                              // Ajax 전송 에러 발생시 실행
	    	fn_alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.','e');
	    }
	});
}

function fn_popContol(pop_sn, path, pop_width , pop_height ,pop_left ,pop_top){

    function getCookie(name){
        var nameOfCookie = name + "=";
        var x = 0;
        while (x <= document.cookie.length){
            var y = (x + nameOfCookie.length);
            if (document.cookie.substring(x, y) == nameOfCookie){
            if ((endOfCookie = document.cookie.indexOf(";", y)) == -1){
            endOfCookie = document.cookie.length;
            }
            return unescape (document.cookie.substring(y, endOfCookie));
            }
            x = document.cookie.indexOf (" ", x) + 1;
            if (x == 0) break;
        }
        return "";
    }
    if (getCookie(pop_sn) != "done" ){
        var popUrl = ctxt+"/indexPop.do";
        var popOption = "top="+pop_top +", left="+pop_left +", width="+pop_width+", height="+pop_height+", resizable=no, scrollbars=no, status=no;";      
       
        var form = document.getElementById("popForm") ;   

        window.open(popUrl,pop_sn,popOption);      
        
        form.action = popUrl; 
	   	form.method = "post";
	   	form.rasParameter1.value = pop_sn;
	   	form.rasParameter2.value = path;	   
	   	form.target = pop_sn;	   	
	   	form.submit();	
    }
}

function setCookie(name, value, expiredays){
    var todayDate = new Date();
        todayDate.setDate (todayDate.getDate() + expiredays);
        document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";";
   
    
}

function closePop(pop_sn){
	
	if ($("#popChk"+pop_sn).prop("checked", true)){
	    setCookie(pop_sn, "done", 1);
	    self.close();
    }
}

