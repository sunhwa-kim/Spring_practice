/*
 * 첨부파일 미리보기
 * */

$(document).ready(function () {
	previewAction(); //미리보기 바인드
});

/**
* 미리보기 액션
* 
* @param
* 
* @return
*/
function previewAction() {
    $('.bt_text_preview').on('click', function (e) {
		var pk = $(this).children('.pk').text();
		var scn = $(this).children('.scn').text();
		var seq = $(this).children('.seq').text();
		
		if(pk != "" && scn != "" && $(this).siblings('.preview_box').css('display') == 'none') {
			$(this).siblings('.preview_box').children('.in_box').load(getFileCont(pk, scn, seq));				
		}
		
		$(this).siblings('.preview_box').fadeToggle();
		e.preventDefault();
    });

	$('.preview_box .bt_close').bind('click', function(e){
		$(this).parent('.preview_box').fadeOut();
		e.preventDefault();
	});    
}


function preview(filePath, fileDownType, category, extension){
	
	if(category == "TONGTONG" || category == "TIMS"){
		sHtmlViewer(filePath, "", extension);
		return false;
	}
	
	if(category == "SKINSTALL"){
		filePath = filePath.replace("K:","\\\\skinstall\\install");
		filePath = filePath.replace("L:","\\\\rndinstall\\install");
		filePath = filePath.replace("M:","\\\\clxinstall\\install");
		filePath = filePath.replace("N:","\\\\ic_file01\\소프트웨어");
	}
	
	//이미지 체크
	var imgCheck = imgExtensionCheck(extension);
	var action = "./preview";
	var args = {
			'attachFileUrl': encodeURI(filePath),
			'category' : category,
			'fileDownType' : fileDownType
		};
	
	$.ajax({
		type: "GET",
		url: action,	
		data: args,
		dataType: "json",
		success: function(data){
			
			//이미지 
			if(imgCheck){
				window.open(data.filePath.replace('C:/Tomcat7/webapps',''));  
				
			//첨부파일 미리보기 호출
			}else{
				sHtmlViewer(data.filePath, data.fileName, data.extension);
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown){
			alert("XMLHttpRequest="+XMLHttpRequest.responseText+"\ntextStatus="+textStatus+"\nerrorThrown="+errorThrown);
		}
	});
}

function sHtmlViewer(filePath, fileName, extension){
	
	var kwd = $('#kwd').val();
	var url = "/sHtmlViewer/viewer.jsp?";
	var args = 	"FFILEPATH="  	+ filePath.replace('C:/Tomcat7/webapps/sHtmlViewer/','')
			+ 	"&FFILENAME=" 	+ fileName
			+	"&FEXT=" 		+ extension
			+	"&FKEYWORD=" 	+ kwd;
	
	window.open(url+args , '', ''); 
}

/**
 * 첨부파일 내용 가져오기(text)
 * 
 * @param
 * 
 * @return string(url)
 */
function getFileCont(pk, scn, seq) {
	var url = "text?";
	
	var params = "";
	params += "pk=" + encodeURIComponent(pk);
	params += "&kwd=" + encodeURIComponent($('#kwd').val());
	params += "&scn=" + scn;
	params += "&seq=" + seq;
	params = url + params;
	return params;
}

// 이미지 체크
function imgExtensionCheck(extension){
	
	var imgCheck = false;
	var imgs = ['jpg','bmp','gif','tif'];
	
	for(var i=0; i < imgs.length; i++){
		
		if(extension == imgs[i]){
			imgCheck = true;
			break;
		}
	}
	
	return imgCheck;
}

// ENPDB, SKINSTALL
function fileDownLoad(filePath, category, fileDownType){
		
	if(category == "SKINSTALL"){
		filePath = filePath.replace("K:","\\\\skinstall\\install");
		filePath = filePath.replace("L:","\\\\rndinstall\\install");
		filePath = filePath.replace("M:","\\\\clxinstall\\install");
		filePath = filePath.replace("N:","\\\\ic_file01\\소프트웨어");
	}
	
	var action = "./fileDown";
	var args = {
			'attachFileUrl': encodeURI(filePath),
			'category' : category,
			'fileDownType' : fileDownType
		};
	
	$.ajax({
		type: "GET",
		url: action,	
		data: args,
		dataType: "json",
		success: function(data){
			
			window.open(data.filePath.replace('C:/Tomcat7/webapps',''));  
				
		},
		error: function(XMLHttpRequest, textStatus, errorThrown){
			alert("XMLHttpRequest="+XMLHttpRequest.responseText+"\ntextStatus="+textStatus+"\nerrorThrown="+errorThrown);
		}
	});
}