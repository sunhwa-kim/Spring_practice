/** 공통 첨부파일 관리시스템 */
var formStr = "<form name='fileDownloadPopupForm' id='fileDownloadPopupForm' method='post'>";
formStr += "<input type='hidden' name='cmd' id='cmd' />" ;
formStr += "<input type='hidden' name='mode' id='mode' />" ;
formStr += "<input type='hidden' name='comfile_u' id='comfile_u' />" ;
formStr += "<input type='hidden' name='comfile_c' id='comfile_c' />" ; 
formStr += "<input type='hidden' name='comfile_s' id='comfile_s' />" ;
formStr += "<input type='hidden' name='comfile_f' id='comfile_f' />" ;
formStr += "<input type='hidden' name='comfile_a' id='comfile_a' />" ;
formStr += "<input type='hidden' name='comfile_pt' id='comfile_pt' />" ;
formStr += "<input type='hidden' name='comfile_pu' id='comfile_pu' />" ;
formStr += "<input type='hidden' name='comfile_cb' id='comfile_cb' />" ;
formStr += "<input type='hidden' name='comfile_se' id='comfile_se' />" ;
formStr += "</form>" ;
document.write( formStr ) ;

function popAttfileUpload( f , c , u , s , pt , cb ){
	var url = "/upload_comm/file.do" ;
	var fFile = document.getElementById( "fileDownloadPopupForm" ) ;
	
	fFile.cmd.value = "uploadForm" ;
	fFile.comfile_u.value = u ;
	fFile.comfile_c.value = c ;
	fFile.comfile_s.value = s ;
	fFile.comfile_f.value = f ;
	fFile.comfile_cb.value = cb ;
	fFile.comfile_pt.value = pt ;
	fFile.comfile_pu.value = location.href ;
	
    window.open("about:blank", "fileDownloadPopupForm", "width=550 height=500 scrollbars=yes menubar=no location=no") ;  // 팝업창 호출
	fFile.action = url ;
	fFile.target = "fileDownloadPopupForm" ;
	fFile.submit() ;
}

function popAttfileUploadS( f , c , u , s , pt , cb , se ){
	var url = "/upload_comm/file.do" ;
	var fFile = document.getElementById( "fileDownloadPopupForm" ) ;
	
	fFile.cmd.value = "uploadFormS" ;
	fFile.comfile_u.value = u ;
	fFile.comfile_c.value = c ;
	fFile.comfile_s.value = s ;
	fFile.comfile_f.value = f ;
	fFile.comfile_cb.value = cb ;
	fFile.comfile_se.value = se ;
	fFile.comfile_pt.value = pt ;
	fFile.comfile_pu.value = location.href ;
	
    window.open("about:blank", "fileDownloadPopupForm", "width=550 height=500 scrollbars=yes menubar=no location=no") ;	// 팝업창 호출
	fFile.action = url ;
	fFile.target = "fileDownloadPopupForm" ;
	fFile.submit() ;
}

function popAttfileModify( f , c , u , s , pt , cb ){
	var url = "/upload_comm/file.do" ; 
	var fFile = document.getElementById( "fileDownloadPopupForm" ) ;
	
	fFile.cmd.value = "uploadForm" ;
	fFile.mode.value = "modify" ;
	fFile.comfile_u.value = u ;
	fFile.comfile_c.value = c ;
	fFile.comfile_s.value = s ;
	fFile.comfile_f.value = f ;
	fFile.comfile_cb.value = cb ;
	fFile.comfile_pt.value = pt ;
	fFile.comfile_pu.value = location.href ;

    window.open("about:blank", "fileDownloadPopupForm", "width=550 height=500 scrollbars=yes menubar=no location=no") ;   // 팝업창 호출
	fFile.action = url ;
	fFile.target = "fileDownloadPopupForm" ;
	fFile.submit() ;
}

function popAttfileModifyS( f , c , u ,  s , pt , cb , se ){

	var url = "/upload_comm/file.do" ; 
	var fFile = document.getElementById( "fileDownloadPopupForm" ) ;
	
	fFile.cmd.value = "uploadFormS" ;
	fFile.mode.value = "modify" ;
	fFile.comfile_u.value = u ;
	fFile.comfile_c.value = c ;
	fFile.comfile_s.value = s ;
	fFile.comfile_f.value = f ;
	fFile.comfile_cb.value = cb ;
	fFile.comfile_se.value = se ;
	fFile.comfile_pt.value = pt ;
	fFile.comfile_pu.value = location.href ;

    window.open("about:blank", "fileDownloadPopupForm", "width=550 height=500 scrollbars=yes menubar=no location=no") ;     // 팝업창 호출
	fFile.action = url;
	fFile.target = "fileDownloadPopupForm";
	fFile.submit();
}

function popAttfileViewInternal( f , c , u , a , pt ){
	var url = "/upload_comm/file.do" ; 
	var fFile = document.getElementById( "fileDownloadPopupForm" ) ;
	
	fFile.cmd.value = "fileView" ;
	fFile.comfile_f.value = f ;
	fFile.comfile_c.value = c ;
	fFile.comfile_u.value = u ;
	fFile.comfile_a.value = a ;
	fFile.comfile_pt.value = pt ;
	fFile.comfile_pu.value = location.href ;

    window.open("about:blank", "fileDownloadPopupForm", "width=600 height=500 scrollbars=yes menubar=no location=no") ;			// 팝업창 호출
	fFile.action = url;
	fFile.target = "fileDownloadPopupForm";
	fFile.submit();
}

function popAttfileViewInternalS( f , c , u , a , pt , se ){

	var url = "/upload_comm/file.do" ; 
	var fFile = document.getElementById( "fileDownloadPopupForm" ) ;
	
	fFile.cmd.value = "fileViewS" ;
	fFile.comfile_f.value = f ;
	fFile.comfile_c.value = c ;
	fFile.comfile_u.value = u ;
	fFile.comfile_a.value = a ;
	fFile.comfile_se.value = se ;
	fFile.comfile_pt.value = pt ;
	fFile.comfile_pu.value = location.href ;

    window.open("about:blank", "fileDownloadPopupForm", "width=600 height=500 scrollbars=yes menubar=no location=no") ;    // 팝업창 호출
	fFile.action = url ;
	fFile.target = "fileDownloadPopupForm" ;
	fFile.submit() ;
}

function popAttfileUploadBoms( f , c , u , s , pt , cb ){
	
	var url = "/upload_comm/file.do" ;
	var fFile = document.getElementById( "fileDownloadPopupForm" ) ;
	
	fFile.cmd.value = "uploadFormBoms" ;
	fFile.comfile_u.value = u ;
	fFile.comfile_c.value = c ;
	fFile.comfile_s.value = s ;
	fFile.comfile_f.value = f ;
	fFile.comfile_cb.value = cb ;
	fFile.comfile_pt.value = pt ;
	fFile.comfile_pu.value = location.href ;

    window.open("about:blank", "fileDownloadPopupForm", "width=800 height=600 scrollbars=yes menubar=no location=no") ;    // 팝업창 호출
	fFile.action = url ;
	fFile.target = "fileDownloadPopupForm" ;
	fFile.submit() ;
}

function popAttfileUploadBomsS( f , c , u , s , pt , cb , se ){
	
	var url = "/upload_comm/file.do" ;
	var fFile = document.getElementById( "fileDownloadPopupForm" ) ;
	
	fFile.cmd.value = "uploadFormBomsS" ;
	fFile.comfile_u.value = u ;
	fFile.comfile_c.value = c ;
	fFile.comfile_s.value = s ;
	fFile.comfile_f.value = f ;
	fFile.comfile_cb.value = cb ;
	fFile.comfile_se.value = se ;
	fFile.comfile_pt.value = pt ;
	fFile.comfile_pu.value = location.href ;

    window.open("about:blank", "fileDownloadPopupForm", "width=800 height=600 scrollbars=yes menubar=no location=no") ;    // 팝업창 호출
	fFile.action = url ;
	fFile.target = "fileDownloadPopupForm" ;
	fFile.submit() ;
}

function popAttfileModifyBoms( f , c , u , s , pt , cb ){

	var url = "/upload_comm/file.do" ; 
	var fFile = document.getElementById( "fileDownloadPopupForm" ) ;
	
	fFile.cmd.value = "uploadFormBoms" ;
	fFile.mode.value = "modify" ;
	
	fFile.comfile_u.value = u;
	fFile.comfile_c.value = c;
	fFile.comfile_s.value = s;
	fFile.comfile_f.value = f;
	fFile.comfile_pt.value = pt;
	fFile.comfile_pu.value = location.href;
	fFile.comfile_cb.value = cb;

   // 팝업창 호출
    window.open("about:blank", "fileDownloadPopupForm", "width=800 height=600 scrollbars=yes menubar=no location=no");
	fFile.action = url;
	fFile.target = "fileDownloadPopupForm";
	fFile.submit();
}

function popAttfileModifyBomsS( f , c , u , s , pt , cb , se ){

	var url = "/upload_comm/file.do" ; 
	var fFile = document.getElementById( "fileDownloadPopupForm" ) ;
	
	fFile.cmd.value = "uploadFormBomsS" ;
	fFile.mode.value = "modify" ;
	
	fFile.comfile_u.value = u ;
	fFile.comfile_c.value = c ;
	fFile.comfile_s.value = s ;
	fFile.comfile_f.value = f ;
	fFile.comfile_cb.value = cb ;
	fFile.comfile_se.value = se ;
	fFile.comfile_pt.value = pt ;
	fFile.comfile_pu.value = location.href ;
	
    window.open("about:blank", "fileDownloadPopupForm", "width=800 height=600 scrollbars=yes menubar=no location=no") ;     // 팝업창 호출
	fFile.action = url ;
	fFile.target = "fileDownloadPopupForm" ;
	fFile.submit() ;
}

function popAttfileViewInternalBoms(f, c, u, addReason, pt){

	var url = "/upload_comm/file.do" ; 
	var fFile = document.getElementById( "fileDownloadPopupForm" ) ;
	
	fFile.cmd.value = "fileViewBoms";
	
	fFile.comfile_f.value = f;
	fFile.comfile_c.value = c;
	fFile.comfile_u.value = u;
	fFile.comfile_a.value = addReason;
	fFile.comfile_pu.value = location.href;
	fFile.comfile_pt.value = pt;
	// 팝업창 호출
    window.open("about:blank", "fileDownloadPopupForm", "width=800 height=600 scrollbars=yes menubar=no location=no");
	fFile.action = url;
	fFile.target = "fileDownloadPopupForm";
	fFile.submit();
}

function popAttfileViewInternalBomsS(f, c, u, addReason, pt , se ){

	var url = "/upload_comm/file.do" ; 
	var fFile = document.getElementById( "fileDownloadPopupForm" ) ;
	
	fFile.cmd.value = "fileViewBomsS" ;
	fFile.comfile_f.value = f ;
	fFile.comfile_c.value = c ;
	fFile.comfile_u.value = u ;
	fFile.comfile_a.value = a ;
	fFile.comfile_se.value = se ;
	fFile.comfile_pt.value = pt ;
    fFile.comfile_pu.value = location.href ;
	
    window.open("about:blank", "fileDownloadPopupForm", "width=800 height=600 scrollbars=yes menubar=no location=no") ;	// 팝업창 호출
	fFile.action = url ;
	fFile.target = "fileDownloadPopupForm" ;
	fFile.submit() ;
}

function popAttfileUploadIn( f , c , u , s , pt , cb ){
	
	var url = window.location.protocol + "//is.cdc.go.kr/upload_comm/file.do" ;
	var fFile = document.getElementById( "fileDownloadPopupForm" ) ;
	
	fFile.cmd.value = "uploadFormIn" ;
	fFile.comfile_u.value = u ;
	fFile.comfile_c.value = c ;
	fFile.comfile_s.value = s ;
	fFile.comfile_f.value = f ;
	fFile.comfile_cb.value = cb ;
	fFile.comfile_pt.value = pt ;
	fFile.comfile_pu.value = location.href ;
	
    window.open("about:blank", "fileDownloadPopupForm", "width=550 height=500 scrollbars=yes menubar=no location=no") ;  // 팝업창 호출
	fFile.action = url ;
	fFile.target = "fileDownloadPopupForm" ;
	fFile.submit() ;
}

function popAttfileModifyIn( f , c , u , s , pt , cb ){

	var url = window.location.protocol + "//is.cdc.go.kr/upload_comm/file.do" ; 
	var fFile = document.getElementById( "fileDownloadPopupForm" ) ;
	
	fFile.cmd.value = "uploadFormIn" ;
	fFile.mode.value = "modify" ;
	fFile.comfile_u.value = u ;
	fFile.comfile_c.value = c ;
	fFile.comfile_s.value = s ;
	fFile.comfile_f.value = f ;
	fFile.comfile_cb.value = cb ;
	fFile.comfile_pt.value = pt ;
	fFile.comfile_pu.value = location.href ;

    window.open("about:blank", "fileDownloadPopupForm", "width=550 height=500 scrollbars=yes menubar=no location=no") ;   // 팝업창 호출
	fFile.action = url ;
	fFile.target = "fileDownloadPopupForm" ;
	fFile.submit() ;
}

function popAttfileUploadBomsIn( f , c , u , s , pt , cb ){

	var url = window.location.protocol + "//is.cdc.go.kr/upload_comm/file.do" ;
	var fFile = document.getElementById( "fileDownloadPopupForm" ) ;
	
	fFile.cmd.value = "uploadFormBomsIn" ;
	fFile.comfile_u.value = u ;
	fFile.comfile_c.value = c ;
	fFile.comfile_s.value = s ;
	fFile.comfile_f.value = f ;
	fFile.comfile_cb.value = cb ;
	fFile.comfile_pt.value = pt ;
	fFile.comfile_pu.value = location.href ;

    window.open("about:blank", "fileDownloadPopupForm", "width=800 height=600 scrollbars=yes menubar=no location=no") ;    // 팝업창 호출
	fFile.action = url ;
	fFile.target = "fileDownloadPopupForm" ;
	fFile.submit() ;
}

function popAttfileModifyBomsIn( f , c , u , s , pt , cb ){

	var url = window.location.protocol + "//is.cdc.go.kr/upload_comm/file.do" ; 
	var fFile = document.getElementById( "fileDownloadPopupForm" ) ;
	
	fFile.cmd.value = "uploadFormBomsIn" ;
	fFile.mode.value = "modify" ;
	
	fFile.comfile_u.value = u;
	fFile.comfile_c.value = c;
	fFile.comfile_s.value = s;
	fFile.comfile_f.value = f;
	fFile.comfile_pt.value = pt;
	fFile.comfile_pu.value = location.href;
	fFile.comfile_cb.value = cb;

   // 팝업창 호출
    window.open("about:blank", "fileDownloadPopupForm", "width=800 height=600 scrollbars=yes menubar=no location=no");
	fFile.action = url;
	fFile.target = "fileDownloadPopupForm";
	fFile.submit();
}

function popAttfileViewInternalIn( f , c , u , a , pt ){

	//var url = window.location.protocol + "//is.cdc.go.kr/upload_comm/file.do" ; 
	var url = "https://is.cdc.go.kr/upload_comm/file.do" ;
	var fFile = document.getElementById( "fileDownloadPopupForm" ) ;
	
	fFile.cmd.value = "fileViewIn" ;
	fFile.comfile_f.value = f ;
	fFile.comfile_c.value = c ;
	fFile.comfile_u.value = u ;
	fFile.comfile_a.value = a ;
	fFile.comfile_pt.value = pt ;
	fFile.comfile_pu.value = location.href ;

    window.open("about:blank", "fileDownloadPopupForm", "width=600 height=500 scrollbars=yes menubar=no location=no") ;			// 팝업창 호출
	fFile.action = url;
	fFile.target = "fileDownloadPopupForm";
	fFile.submit();
}

function deleteContents(f, c){
	
	var url = "/upload_comm/file.do?cmd=fileGroupDelete";  
	
	// ***** 수정 불가 *****//
	url += "&comfile_c=" + c;
	url += "&comfile_f=" + f;
	
	$.ajax({
		url:url,
		type:'GET',
		dataType:'jsonp',
		jsonp:'callback',
		success: function (data){
			if(data.result){
				try{
					// 함수 구현
					orgFormSubmit();
				}catch(err){
					alert('삭제처리 중 오류가 발생하였습니다.');
				}
				
			} else {
				alert(data.resultMsg);
			}
		},
		error: function (e){
			alert(e.messages);
		}
	});
}

function cancelRegContents(f, c){
	
	var url = "/upload_comm/file.do?cmd=fileGroupDelete";  
	// ***** 수정 불가 *****//
	url += "&comfile_c=" + c;
	url += "&comfile_f=" + f;
	
	$.ajax({
		url:url,
		type:'GET',
		dataType:'jsonp',
		jsonp:'callback',
		success: function (data){
			if(data.result){
				try{
					// 함수 구현
					cancelRegOrg();
				}catch(err){
					alert('업로드된 첨부파일이 삭제되지 않았습니다.');
				}
				
			} else {
				alert(data.resultMsg);
			}
		},
		error: function (e){
			alert(e.messages);
		}
	});
}

function fixChiper( n , digits ){
	var zero = '' ;
	n = n.toString() ;
	if ( n.length < digits ){
		for( i = 0 ; i < digits - n.length ; i++ ){
			zero += '0' ;
		}
	}
	return zero + n ;
}

function getFileKey(){
	var d = new Date() ;
	var result = "" ;
	result += fixChiper( d.getFullYear() , 4 ) ;
	result += fixChiper( d.getMonth() + 1 , 2 ) ;
	result += fixChiper( d.getDate() , 2 ) ;
	result += fixChiper( d.getHours() , 2 ) ;
	result += fixChiper( d.getMinutes() , 2 ) ;
	result += fixChiper( d.getSeconds() , 2 ) ;
	result += fixChiper( d.getMilliseconds() , 3 ) ;
	return result ;
}

function popAttfileView( f , c , pt ){
	popAttfileViewInternal( f , c , '' , '' , pt ) ;
}

function popAttfileViewS( f , c , pt , se ){
	popAttfileViewInternalS( f , c , '' , '' , pt , se ) ;
}

function popAttfileViewBoms( f , c , pt ){
	popAttfileViewInternalBoms( f , c , '' , '' , pt ) ;
}

function popAttfileViewBomsS( f , c , pt , se ){
	popAttfileViewInternalBomsS( f , c , '' , '' , pt , se ) ;
}

function popAttfileViewWithReason( f , c , u , pt ){
	popAttfileViewInternal( f , c , u , 'Y' , pt ) ;
}

function popAttfileViewWithReasonS( f , c , u , pt , se ){
	popAttfileViewInternalS( f , c , u , 'Y' , pt , se ) ;
}

function popAttfileViewIn( f , c , pt ){
	popAttfileViewInternalIn( f, c , '' , '' , pt) ;
}

function popAttfileViewBomsIn( f , c , pt ){
	popAttfileViewInternalBomsIn( f , c , '' , '' , pt ) ;
}

function popAttfileViewWithReasonIn( f , c , u , pt ){
	popAttfileViewInternalIn( f , c , u , 'Y' , pt) ;
}