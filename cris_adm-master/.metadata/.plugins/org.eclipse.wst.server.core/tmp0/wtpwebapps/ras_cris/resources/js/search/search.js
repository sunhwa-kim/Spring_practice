/*******************************************************
* 프로그램명 	 : search.js   # 검색기능
* 설명           : 통합검색용 자바스크립트
* 작성일         : 2012.01.03
* 작성자         : 장진후
* 수정내역     	 :
  *****************************************************/

/* ************************** 
 * 운영 : CONTEXT_PATH = "/ncmik";
 * 개발 : CONTEXT_PATH = "/ncmik";
 * 개발자 : CONTEXT_PATH = "";
 ************************** */
var CONTEXT_PATH = "/ncmiklib"; //  real or po.linksoft.co.kr
//var CONTEXT_PATH = ""; // dev
/* ************************** */
var ctgr_val = "";
  
var page_url 	= "search.do";
var page_url2 	= CONTEXT_PATH + "/search/totalSearch.do";

var srchFrm 	= "searchForm";
var hstrFrm 	= "historyForm";
var detlFrm 	= "detailSearchForm";
var fltrFrm 	= "searchFilterForm";
var fltrRgtFrm 	= "searchFilterForm2";
var dtlFrm 		= "detailForm";

/*
function openPubReader(mbid){
	
	var url = CONTEXT_PATH + "/ptl/kdr/atc/initAtcPubreaderView.do" + "?pmcid=" + mbid;
//	<c:url value='/js/jquery-1.7.1.min.js' />
	var W = 1000;
	var H = 500;
    var L = ((screen.width) - W) / 2;
    var T = ((screen.height) - H) / 2;
    //window.open(+',TEST,width='+W+',height='+H+',top='+T+',left='+L+',resizable=yes, scrollbars=yes');
    window.open(url,'newwindow','top=10, left=10, width=950, height=700, toolbar=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=no');
}

function openKPMC(kpmcid){
	
	var url = CONTEXT_PATH + '/ptl/kdr/atc/initAtcView.do?pmcid='+kpmcid;
	
	var W = 1000;
	var H = 500;
	var L = ((screen.width) - W) / 2;
	var T = ((screen.height) - H) / 2;
	//window.open(+',TEST,width='+W+',height='+H+',top='+T+',left='+L+',resizable=yes, scrollbars=yes');
	
	window.open(url,'newwindow','top=10, left=10, width=950, height=700, toolbar=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=no');
}
*/
function openPopup(url){
	var W = 1000;
	var H = 500;
	var L = ((screen.width) - W) / 2;
	var T = ((screen.height) - H) / 2;
	
	window.open(url,'newwindow','top=10, left=10, width=950, height=700, toolbar=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=no');
}
function openKPMC3() {
	var params = "<params> "
			   + "<param name='path'><![CDATA[/journals/]]></param>"
			   + "<param name='base_url'>http://152.99.73.137/</param>"
			   + "<param name='cdata_flag'>on</param>"
			   + "<param name='approot_path'>/kopmc/</param>"
			   + "</params>";
	var paramsEnc = encodeURIComponent(params);
	var env = "<Environment> "
		   + "<REMOTE_ADDR>106.240.74.171</REMOTE_ADDR>"
		   + "<HTTP_USER_AGENT>Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; InfoPath.2)</HTTP_USER_AGENT>"
		   + "</Environment>";
	var envEnc = encodeURIComponent(env);
	var url = "http://211.41.63.66:19991/";
	//var url = "http://152.99.73.137/ppmc/ptpmcrender.fcgi";
		
	$.support.cors = true;
	$.ajax({
		"type": "GET",
		"url": url,
		"dataType": "jsonp",
		"jsonp" : "success",
		"success": function(data){
			alert(data);
		},
		"error": function(xhr, status, error) {
			alert('error');
		}
	});
	
}
function openKPMC2(kpmcId, taget){
	var url = "";
	//alert("aa");
	//if (taget == "ARTICLE"){
	//	url = CONTEXT_PATH + "/ptl/kdr/atc/kpmcArticle.do?type=classic&kpmcId=" + kpmcId;
	//	openPopup(url);
	//} else if (taget == "PUBREADER"){
	//	url = CONTEXT_PATH + "/ptl/kdr/atc/kpmcArticle.do?type=pubreader&kpmcId=" + kpmcId;
	//	openPopup(url);
	//} else {
		url =  CONTEXT_PATH + "/ptl/kdr/atc/kdrKojInfoView.do";
		$.ajax({
			"type": "POST",
			"url": url,
			"dataType": "json",
			"data": {
				"kpmcId": kpmcId
			},
			"success": function(data){
				if(data != null){
					console.log(data.kpmcId);
					
					var url = null;
					if(taget == "ARTICLE"){ /*collect*/
						console.log(data.articleUrl);
						//url = data.articleUrl;
						url = CONTEXT_PATH + "/ptl/kdr/atc/kpmcArticle.do?type=classic&kpmcId=" + kpmcId;
						//location.href = url;
						openPopup(url);
					}
					else if(taget == "PUBREADER"){
						console.log(data.pubReaderUrl);
						//url = data.pubReaderUrl;
						url = CONTEXT_PATH + "/ptl/kdr/atc/kpmcArticle.do?type=pubreader&kpmcId=" + kpmcId;
						openPopup(url);
					}
					else if(taget == "PDF"){
						console.log(data.pdfUrl);
						//url = data.pdfUrl;
						url = CONTEXT_PATH + "/ptl/kdr/atc/kpmcArticle.do?type=pdf&kpmcId=" + kpmcId;
						openPopup(url);
					}
					else if(taget == "EPUB"){
						console.log(data.ePubUrl);
						url = data.ePubUrl;
					}
					
				}else{
					alert("해당하는 데이터(" + kpmcId + ")가 없습니다.");
				}
			},
			"error": function(xhr, status, error) {
				//console.log(xhr);
				//console.log(status);
				//console.log(error);
				location.href = CONTEXT_PATH + "/cmm/login/PTLLogin.do";
			}
		});
	//}
}

function openOrgInfo(kpmcId, taget){
	
	
	
}

function getURLdata(targetURL){
	var url = CONTEXT_PATH + "/ptl/kdr/atc/getURLdata.do";
	console.log("targetURL: "+targetURL);
	
	var rtn = null;
	
	$.ajax({
		"type": "POST",
		"url": url,
		"dataType": "text",
		"async": false,
		"data": {
			"targetURL": targetURL
		},
		"success": function(data){
			if(data != null){
				console.log(data);
				rtn = data;
			}
		},
		"error": function(xhr, status, error) {
			console.log(xhr);
			console.log(status);
			console.log(error);
		}
	});
	
	return rtn;
}


/**
* onload시 실행되는 functions
**/
$(document).ready(function(){
	
	//init();		// 검색화면 초기화
	
	detlInit();	// 상세검색화면 초기화
	//fltrInit();	// 필터검색화면 초기화
	//akcInit();	// 자동완성 초기화
	ctgrInit();	// 카테고리 초기화
	
	
	// 우측 모듈 레이어 전체제어
	$('.arr').bind('click', function(){
		//현재 부모의 부모의 두번째 자식을 제어함.
		var ctr_lay = $(this).parent().parent().children().next();	// 디자인 통일화가 필요함.
		
		if( $(this).text() == "▼" ){	// 클릭할 수 있을 경우
			$(this).text('▲');
			ctr_lay.show('fast');
			$(this).css({"background-position":""});
		}else{
			$(this).text('▼');
			ctr_lay.hide('fast');
			$(this).css({"background-position":"0 -14px"});
		}
	});	

	
});
 
/**
* 상세검색 화면 자동 초기화 
*
* @ param 
*
* @ return	void		
**/	
function detlInit(){
	var sepa = "_";
	var hstr_frm = getForm(hstrFrm);
	if (hstr_frm == null) return;
	var ctgr_flds = CommonUtil.getValue(hstr_frm, "category");
	var ext_flds = CommonUtil.getValue(hstr_frm, "fileExt");
	var srch_fd = CommonUtil.getValue(hstr_frm, "srchFd");
	var date = CommonUtil.getValue(hstr_frm, "date");
	var sort = CommonUtil.getValue(hstr_frm, "sort");
	
	// 상세검색 체크박스 초기화(체크)
	$('.detl_dd').children('input:checkbox').each(function(){
		if(ext_flds.indexOf(this.value) > -1)	this.checked = true;
	});
	
	// 상세검색  라디오박스 초기화(체크)
	$('.detl_dd').children('input:radio').each(function(){	
		if(ctgr_flds.indexOf(this.value) > -1)	this.checked = true;
		if(srch_fd.indexOf(this.value) > -1)  this.checked = true;			
		if(date.indexOf(this.value) > -1)  this.checked = true;
	});
	
	// 상세검색  정렬 초기화(셀렉트박스)
	$('#d1_sort').children('option').each(function(){
		if(sort == this.value)	this.selected = true;
	});
	
	// 상세검색의 클릭시 액션
	/*
	$('.detl_dd').children('input:checkbox').bind('click',function(){		
		var temp_str = "";
		var is_total = false;
		
		// total 체크박스 체크 유무
		if($(this).val() == "TOTAL"){
			is_total = true;
		}
		
		// detl_dd class의 포함된 checkbox만 가져옴.
		$(this).parent().children('input:checkbox:checked').each(function(){
			if(is_total == false){				
				if(this.value == "TOTAL"){
					this.checked = false; 
				}else{
					temp_str += this.value + sepa;
				}
			}else{				
				if(this.value != "TOTAL"){
					this.checked = false;
				}
			}
		});
		
		if(temp_str == ""){
			temp_str = "TOTAL";
		}else{
			temp_str = temp_str.substring(0,temp_str.length-sepa.length);
		}
			
		var frm = getForm(detlFrm);
		
		CommonUtil.setValue(frm, "fileExt", temp_str);		
		
	});
	
	// 상세검색 날짜 클릭 액션
	$('#detl_date').children('input:radio').bind('click',function(){
		choiceDatebutton("startDate", "endDate", this.value, 1);
	});	
	
	// 상세검색 레이어 토글
	$('#dt_btn').bind('click',function(){
		$('#sch_more').slideToggle('slow');
	});
	*/
	// 상세검색 닫기 액션
	$('#detl_close').bind('click',function(){
		$('#sch_more').slideToggle('slow');
	});
	
	// 상세검색 폼 엔터키처리(for IE BUG...)	
//	$('#sch_more').keydown(function(event){
//		if(event.keyCode == 13)  
//			detlSchKwd();		
//	});
	
	// 상세검색에서 검색 키 작동
	/*$('.sch_more_bt').children('input').bind('click', function(){
		detlSchKwd();
	});	*/	
	
	
}

/**
* 필터검색 화면 자동 초기화 
*
* @ param 
*
* @ return	void		
**/
function fltrInit(){	
	var category = CommonUtil.getValue(getForm(srchFrm), "category");
    
	// 필터호출을 하지 말아야 될 카테고리	
	if( category == "NBLOG" || category == "DVCLIP" ){	
		return false;
	}
	
	var fltr_frm = getForm(fltrFrm);	
	var year = CommonUtil.getValue(fltr_frm, "year");
	var file_ext = CommonUtil.getValue(fltr_frm, "fileExt");
	var sepa = "_";
	
	// 연도 체크 박스 세팅
	$('.s_year > li > input:checkbox').each(function(){		
		if(year.indexOf($(this).val()) > -1){
			this.checked = true;
		}
	});
	
	// 첨부파일 체크 박스 세팅
	$('.file_type > li > input:checkbox').each(function(){
		if(file_ext.indexOf($(this).val()) > -1){
			this.checked = true;
		}
	});
	
	// 연도 체크 박스 액션
	$('.s_year > li > input:checkbox').bind('click', function(){		
		var temp = "";
		
		if($(this).val() == "TOTAL"){	// 전체를 선택할 경우
			$('.s_year > li > input:checkbox').each(function(){
				if($(this).val() != "TOTAL"){
					this.checked = false;	// 나머지 체크박스 체크 해제
				}
			});
			
			CommonUtil.setValue(fltr_frm, "year", "TOTAL");
			
		}else{	// 전체 이외의 체크박스를 선택할 경우
			$('.s_year > li > input:checkbox').each(function(){
				if($(this).val() == "TOTAL"){	// 전체 체크박스 체크 해제
					this.checked = false;
				}
			});
			
			// 체크된 값을 찾아서 값을 합친다.(ex : 값1_값2_)
			$('.s_year > li > input:checkbox:checked').each(function(){					
				temp += this.value + sepa;	
			});
			
			// 값이 있을 경우 마지막에 붙여진 구분자를 지운다.(ex: 값1_값2_ => 값1_값2)
			if(temp.length != 0){	
				temp = temp.substring(0, temp.length-sepa.length);
			}else{
				temp = "TOTAL";
			}
			
			CommonUtil.setValue(fltr_frm, "year", temp);
			
		}
	});
	
	// 첨부파일 체크 박스 액션
	$('.file_type > li > input:checkbox').bind('click', function(){
		var temp = "";
		
		if($(this).val() == "TOTAL"){	// 전체 선택할 경우 나머지 체크 박스 체크 해제
			$('.file_type > li > input:checkbox').each(function(){
				if($(this).val() != "TOTAL"){
					this.checked = false;
				}
			});
			
			CommonUtil.setValue(fltr_frm, "fileExt", "TOTAL");
		}else{			
			$('.file_type > li > input:checkbox').each(function(){
				if($(this).val() == "TOTAL"){
					this.checked = false;
				}
			});
						
			$('.file_type > li > input:checkbox:checked').each(function(){				
				temp += this.value + sepa;
			});
			
			if(temp.length != 0){
				temp = temp.substring(0, temp.length-sepa.length);
			}else{
				temp = "TOTAL";
			}
			
			CommonUtil.setValue(fltr_frm, "fileExt", temp);
		}
	});
	
	// 필터(정렬) 기능
	$('#arange > li').bind('click', function(){
		var btn_txt = repSpace($(this).text());
		
		if(btn_txt == "정확도"){
			goSrch("sort","r");
		}else if(btn_txt == "최신순"){	// 최신순
			goSrch("sort","d");
		}
	});
	
	// 필터 (영역) 기능
	$('#area > li').bind('click', function(){
		var btn_txt = repSpace($(this).text());
		
		if(btn_txt == "제목"){
			goSrch("srchFd","title");
		}else if(btn_txt == "제목+본문"){
			goSrch("srchFd","ttbd_idx");
		}
	});
	
	// 전체 초기화
	$('.ta_c').children('a').bind('click', function(){
		var frm = getForm(fltrFrm);
				
		CommonUtil.setValue(frm, "startDate", "");
		CommonUtil.setValue(frm, "endDate", "");
		CommonUtil.setValue(frm, "sort", "r");
		CommonUtil.setValue(frm, "srchFd", "ttbd_idx");
		CommonUtil.setValue(frm, "year", "TOTAL");
		CommonUtil.setValue(frm, "fileExt", "TOTAL");
		
		$('.filler_tab').removeClass('filler_tab_on');
		
		$('.s_year > li > input:checkbox').each(function(){
			if($(this).val() != "TOTAL"){
				this.checked = false;
			}else{
				this.checked = true;
			}				
		});
		
		$('.file_type > li > input:checkbox').each(function(){
			if($(this).val() != "TOTAL"){
				this.checked = false;
			}else{
				this.checked = true;
			}	
		});
	});
}

/**
* 카테고리 초기화 
*
* @ param 
*
* @ return	void		
**/
function ctgrInit(){	
	
	// 카테고리 셀렉트 박스 클릭시
	$('#cateName').bind('click',function(){
		if( $('#sch_arr').hasClass('sch_arr') == true ){
			$('#sch_arr').removeClass('sch_arr').addClass('sch_arr_on');
			$('#sel_sch').show('fast');
		}else{
			$('#sch_arr').removeClass('sch_arr_on').addClass('sch_arr');
			$('#sel_sch').hide('fast');
		}
	});

}

/**
* 입력받은 키워드로 Default 검색
*
* @ param kwd - 검색어   
*
* @ return	void
**/	
function dftSchKwd( kwd ){
	if(kwd == ""){
		alert("검색어를 입력해주세요.");
		return false;
	}else{		
		callKwdCookie(kwd);		
		
		window.location.href = page_url + "?kwd=" + kwd;
	}
}


/**
* 입력받은 키워드로 Default 검색
*
* @ param kwd - 검색어   
*
* @ return	void
**/	
function dftSchKwd2( kwd ){
	if(kwd == ""){
		alert("검색어를 입력해주세요.");
		return false;
	}else{		
		callKwdCookie(kwd);		
		
		window.location.href = page_url2 + "?kwd=" + kwd;
	}
}


/**
* 입력받은 키워드로 검색
*
* @ param frmObj - 폼오브젝트   
*
* @ return	boolean
**/	
function srchKwd( frmObj ){
	var kwd = frmObj.kwd.value;
	
	if(kwd == ""){
		alert("검색어를 입력해주세요.");
		return false;
	}else{		
		callKwdCookie(kwd);
		
		CommonUtil.setValue(frmObj, "kwd", kwd);
		frmObj.submit();
	}				
}

/**
* 입력받은 키워드로 검색(상세검색)
*
* @ param kwd - 검색어   
*
* @ return	void	
**/	
function detlSchKwd(){
	var hstr  	 = getForm(hstrFrm);

	var chkCtgr	= new Object();
	var field 	= new Object();
	var value 	= new Object();
	var compute	= new Object();
	var sort 	= new Object();
	
	chkCtgr	= document.getElementsByName("dChkCtgr");
	field 	= document.getElementsByName("dField");
	value 	= document.getElementsByName("dValue");
	compute	= document.getElementsByName("dCompute");
	sort 	= document.getElementsByName("dSort");
	
	var strChkCtgr	= "";	//chkCtgr
	var qryWhere 	= "";	//field, value, compute
	var qryOrder 	= "";	//sort
	
	//검색대상 카테고리 
	for(var i=0; i<chkCtgr.length; i++){
		if(chkCtgr[i].checked){
			if(chkCtgr[i].value=="TOTAL"){
				strChkCtgr = "TOTAL" ;
				break; 
			}else{
				if( strChkCtgr != "" ){
					strChkCtgr += "," ;
				}
				strChkCtgr += chkCtgr[i].value ;
			}
		}
	}
	 
	//WHERE절 쿼리
	for(var i=0; i<field.length ; i++){
		var sub = "";
		sub = field[i].value + " = '" + value[i].value + "' ";
		if( i != compute.length ){
			sub += compute[i].value + " " ;
		}
		qryWhere += sub;
	}
	//ORDERBY절 쿼리
	if(sort[0].value == 1){ //1:정확도(Default)		
		qryOrder = "";
	}else{				 	//2:최신순
		qryOrder = "order by updateDate desc"; 
	}
	
//	alert('strChkCtgr->' + strChkCtgr);
//	alert('qryWhere->' + qryWhere);
//	alert('qryOrder->' + qryOrder);
	hstr.detailSearch.value 		= true ;		//Controller에서 통합검색과 상세검색 분기 시 사용
	hstr.detailCategory.value 		= strChkCtgr ;	//Controller에서 체크 카테고리만  검색 시 사용
	hstr.detailWhereQuery.value 	= qryWhere ; 	//DAO에서 조건설정 ex)sb.append(params.getDetailWhereQuery() + searchMethod);
	hstr.detailOrderQuery.value 	= qryOrder ; 	//DAO에서 조건설정 ex)search.setOrderBy(params.getDetailOrderQuery());
	alert('hstr.detailSearch.value_'+hstr.detailSearch.value);
	alert('hstr.detailCategory.value_'+hstr.detailCategory.value);
	alert('hstr.detailWhereQuery.value_'+hstr.detailWhereQuery.value);
	alert('hstr.detailOrderQuery.value_'+hstr.detailOrderQuery.value);
	hstr.submit();
}

/**
 * 필터검색수행
 */
function fltSchKwd(fieldName, elmtName){
	var hstr  	 = getForm(hstrFrm);
	var fValue 	 = new Object();
	var qryWhere = "";
	var sub		 = "";
	
	fValue 	= document.getElementsByName(elmtName);
	
	//WHERE절 쿼리생성
	qryWhere= "and " + fieldName + " in {" ;
	for(var i=0; i<fValue.length ; i++){
		if(fValue[i].checked){
			if( sub != "" ){
				sub += "," ;
			}
			sub += "'" + fValue[i].value + "'" ;
		}
	}
	qryWhere += sub + "}" ;		// ex) and 필드명 in {'값1','값3'}
	
	hstr.fltWhereQuery.value = qryWhere;
	////////////alert("fltSchKwd:"+hstr.fltWhereQuery.value);
//	dftSchKwd(frm.kwd.value);
	hstr.submit();
}

/**
 * 다중필터검색수행
 */
function fltMulSchKwd(category,div){
	
	var hstr  	 = getForm(hstrFrm);
	var fValue 	 = new Object();
	var qryWhere = "";
	var sub		 = "";
	var fieldName = "";
	
	var fltBefDivs = "";//필터항목 구분값(placeOfPubFilter....
	var fltBefCnts = "";//필터리스트의 현재 갯수..5,10,15
	var fltBefVals = "";//체크한 필터값
	var fltBefChkCnt = "";//체크한 필터갯수
	
	//book의 타켓 필터 flt_placeOfPublication_v(발행지), flt_language_l(언어)
	if(category == 'BOOK' || category == 'REPORT' || category == 'NONBOOK' || category == 'journal'){
		
		var cnt = 0;
		fValue = document.getElementsByName('placeOfPub');
		fieldName = 'flt_placeOfPublication_v';
		for(var i=0; i<fValue.length ; i++){
			if(fValue[i].checked){
				cnt++;
			}
		}
		if(cnt > 0){
			
			//fltBef
			if(fltBefDivs == ""){
				fltBefDivs = "placeOfPubFilter";
			}else{
				fltBefDivs += ",placeOfPubFilter";
			}
			if(fltBefCnts == ""){
				fltBefCnts = fValue.length+"";
			}else{
				fltBefCnts += ","+fValue.length;
			}
			if(fltBefChkCnt == ""){
				fltBefChkCnt = cnt+"";
			}else{
				fltBefChkCnt += ","+cnt;
			}
			
			
			if(div == 2){//or조건
				if(qryWhere == ""){
					qryWhere += "and (" + fieldName + " in {" ;
				}else{
					qryWhere += "or " + fieldName + " in {" ;
				}
			}else{
				qryWhere += "and " + fieldName + " in {" ;
			}//and 조건
			for(var i=0; i<fValue.length ; i++){
				if(fValue[i].checked){
					if( sub != "" ){
						sub += "," ;
					}
					sub += "'" + fValue[i].value + "'" ;
					
					//fltBef
					if(fltBefVals == ""){
						fltBefVals = i+"";
					}else{
						fltBefVals += ","+i+"";
					}
				}
			}
			qryWhere += sub + "} " ;		// ex) and 필드명 in {'값1','값3'}
		}
		if(cnt > 0){
			var nullif = "";
		}
		
		
		var cnt = 0;
		sub = "";
		fValue = document.getElementsByName('language');
		fieldName = 'flt_language_l';
		for(var i=0; i<fValue.length ; i++){
			if(fValue[i].checked){
				cnt++;
			}
		}
		if(cnt > 0){
			//fltBef
			if(fltBefDivs == ""){
				fltBefDivs = "languageFilter";
			}else{
				fltBefDivs += ",languageFilter";
			}
			if(fltBefCnts == ""){
				fltBefCnts = fValue.length+"";
			}else{
				fltBefCnts += ","+fValue.length;
			}
			if(fltBefChkCnt == ""){
				fltBefChkCnt = cnt+"";
			}else{
				fltBefChkCnt += ","+cnt;
			}
			
			if(div == 2){//or조건
				if(qryWhere == ""){
					qryWhere += "and (" + fieldName + " in {" ;
				}else{
					qryWhere += "or " + fieldName + " in {" ;
				}
			}else{
				qryWhere += "and " + fieldName + " in {" ;
			}//and 조건
			for(var i=0; i<fValue.length ; i++){
				if(fValue[i].checked){
					if( sub != "" ){
						sub += "," ;
					}
					sub += "'" + fValue[i].value + "'" ;
					
					//fltBef
					if(fltBefVals == ""){
						fltBefVals = i+"";
					}else{
						fltBefVals += ","+i+"";
					}
				}
			}
			qryWhere += sub + "} " ;		// ex) and 필드명 in {'값1','값3'}
		}
		
		var cnt = 0;
		fValue = new Object();//추가 0205
		fValue = document.getElementsByName('subject');
		fieldName = 'flt_authorKeyword_l';
		for(var i=0; i<fValue.length ; i++){
			if(fValue[i].checked){
				cnt++;
			}
		}
		
		if(cnt > 0){
			
			//fltBef
			if(fltBefDivs == ""){
				fltBefDivs = "subjectFilter";
			}else{
				fltBefDivs += ",subjectFilter";
			}
			if(fltBefCnts == ""){
				fltBefCnts = fValue.length+"";
			}else{
				fltBefCnts += ","+fValue.length;
			}
			if(fltBefChkCnt == ""){
				fltBefChkCnt = cnt+"";
			}else{
				fltBefChkCnt += ","+cnt;
			}
			
			
			if(div == 2){//or조건
				if(qryWhere == ""){
					qryWhere += "and (" + fieldName + " in {" ;
				}else{
					qryWhere += "or " + fieldName + " in {" ;
				}
			}else{
				qryWhere += "and " + fieldName + " in {" ;
			}//and 조건
			
			sub = "";//추가 0205
			
			for(var i=0; i<fValue.length ; i++){
				if(fValue[i].checked){
					if( sub != "" ){
						sub += "," ;
					}
					sub += "'" + fValue[i].value + "'" ;
					
					//fltBef
					if(fltBefVals == ""){
						fltBefVals = i+"";
					}else{
						fltBefVals += ","+i+"";
					}
				}
			}
			qryWhere += sub + "} " ;		// ex) and 필드명 in {'값1','값3'}
		}
		
		
		var cnt = 0;
		fValue = new Object();//추가 0205
		fValue = document.getElementsByName('author');
		fieldName = 'authorlist_idx';
		for(var i=0; i<fValue.length ; i++){
			if(fValue[i].checked){
				cnt++;
			}
		}
		
		if(cnt > 0){
			//fltBef
			if(fltBefDivs == ""){
				fltBefDivs = "authorFilter";
			}else{
				fltBefDivs += ",authorFilter";
			}
			if(fltBefCnts == ""){
				fltBefCnts = fValue.length+"";
			}else{
				fltBefCnts += ","+fValue.length;
			}
			if(fltBefChkCnt == ""){
				fltBefChkCnt = cnt+"";
			}else{
				fltBefChkCnt += ","+cnt;
			}
			
			
			if(div == 2){//or조건
				if(qryWhere == ""){
					qryWhere += "and (" + fieldName + " in {" ;
				}else{
					qryWhere += "or " + fieldName + " in {" ;
				}
			}else{
				qryWhere += "and " + fieldName + " in {" ;
			}//and 조건
			
			sub = "";//추가 0205
			
			for(var i=0; i<fValue.length ; i++){
				if(fValue[i].checked){
					if( sub != "" ){
						sub += "," ;
					}
					sub += "'" + fValue[i].value + "'" ;
					
					//fltBef
					if(fltBefVals == ""){
						fltBefVals = i+"";
					}else{
						fltBefVals += ","+i+"";
					}
				}
			}
			qryWhere += sub + "} " ;		// ex) and 필드명 in {'값1','값3'}
		}
		
		var cnt = 0;
		fValue = new Object();//추가 0205
		fValue = document.getElementsByName('publisher');
		fieldName = 'flt_hasPublisher_v';
		for(var i=0; i<fValue.length ; i++){
			if(fValue[i].checked){
				cnt++;
			}
		}
		
		if(cnt > 0){
			
			//fltBef
			if(fltBefDivs == ""){
				fltBefDivs = "publisherFilter";
			}else{
				fltBefDivs += ",publisherFilter";
			}
			if(fltBefCnts == ""){
				fltBefCnts = fValue.length+"";
			}else{
				fltBefCnts += ","+fValue.length;
			}
			if(fltBefChkCnt == ""){
				fltBefChkCnt = cnt+"";
			}else{
				fltBefChkCnt += ","+cnt;
			}
			
			
			if(div == 2){//or조건
				if(qryWhere == ""){
					qryWhere += "and (" + fieldName + " in {" ;
				}else{
					qryWhere += "or " + fieldName + " in {" ;
				}
			}else{
				qryWhere += "and " + fieldName + " in {" ;
			}//and 조건
			
			sub = "";//추가 0205
			
			for(var i=0; i<fValue.length ; i++){
				if(fValue[i].checked){
					if( sub != "" ){
						sub += "," ;
					}
					sub += "'" + fValue[i].value + "'" ;
					
					//fltBef
					if(fltBefVals == ""){
						fltBefVals = i+"";
					}else{
						fltBefVals += ","+i+"";
					}
				}
			}
			qryWhere += sub + "} " ;		// ex) and 필드명 in {'값1','값3'}
		}
		
		
		
		var cnt = 0;
		fValue = new Object();//추가 0205
		fValue = document.getElementsByName('pubyear');
		fieldName = 'issued';
		for(var i=0; i<fValue.length ; i++){
			if(fValue[i].checked){
				cnt++;
			}
		}
		
		if(cnt > 0){
			
			//fltBef
			if(fltBefDivs == ""){
				fltBefDivs = "pubyearFilter";
			}else{
				fltBefDivs += ",pubyearFilter";
			}
			if(fltBefCnts == ""){
				fltBefCnts = fValue.length+"";
			}else{
				fltBefCnts += ","+fValue.length;
			}
			if(fltBefChkCnt == ""){
				fltBefChkCnt = cnt+"";
			}else{
				fltBefChkCnt += ","+cnt;
			}
			
			
			if(div == 2){//or조건
				if(qryWhere == ""){
					qryWhere += "and (" + fieldName + " in {" ;
				}else{
					qryWhere += "or " + fieldName + " in {" ;
				}
			}else{
				qryWhere += "and " + fieldName + " in {" ;
			}//and 조건
			
			sub = "";//추가 0205
			
			for(var i=0; i<fValue.length ; i++){
				if(fValue[i].checked){
					if( sub != "" ){
						sub += "," ;
					}
					sub += "'" + fValue[i].value + "'" ;
					
					//fltBef
					if(fltBefVals == ""){
						fltBefVals = i+"";
					}else{
						fltBefVals += ","+i+"";
					}
				}
			}
			qryWhere += sub + "} " ;		// ex) and 필드명 in {'값1','값3'}
		}
		
		if(div == 2){//or조건
			if(qryWhere != ""){
				qryWhere += ")" ;
			}
		}
	}else if(category == 'ARTICLE' || category == 'INKOREA'){
		var cnt = 0;
		sub = "";
		fValue = document.getElementsByName('language');
		fieldName = 'flt_language_l';
		for(var i=0; i<fValue.length ; i++){
			if(fValue[i].checked){
				cnt++;
			}
		}
		
		if(cnt > 0){
			//fltBef
			if(fltBefDivs == ""){
				fltBefDivs = "languageFilter";
			}else{
				fltBefDivs += ",languageFilter";
			}
			if(fltBefCnts == ""){
				fltBefCnts = fValue.length+"";
			}else{
				fltBefCnts += ","+fValue.length;
			}
			if(fltBefChkCnt == ""){
				fltBefChkCnt = cnt+"";
			}else{
				fltBefChkCnt += ","+cnt;
			}
			
			if(div == 2){//or조건
				if(qryWhere == ""){
					qryWhere += "and (" + fieldName + " in {" ;
				}else{
					qryWhere += "or " + fieldName + " in {" ;
				}
			}else{
				qryWhere += "and " + fieldName + " in {" ;
			}//and 조건
			for(var i=0; i<fValue.length ; i++){
				if(fValue[i].checked){
					if( sub != "" ){
						sub += "," ;
					}
					sub += "'" + fValue[i].value + "'" ;
					
					//fltBef
					if(fltBefVals == ""){
						fltBefVals = i+"";
					}else{
						fltBefVals += ","+i+"";
					}
				}
			}
			qryWhere += sub + "} " ;		// ex) and 필드명 in {'값1','값3'}
		}
		
		
		
		
		
		
		
		var cnt = 0;
		sub = "";
		fValue = document.getElementsByName('meshPubType');
		fieldName = 'flt_meshPubType_l';
		for(var i=0; i<fValue.length ; i++){
			if(fValue[i].checked){
				cnt++;
			}
		}
		
		if(cnt > 0){
			//fltBef
			if(fltBefDivs == ""){
				fltBefDivs = "meshPubTypeFilter";
			}else{
				fltBefDivs += ",meshPubTypeFilter";
			}
			if(fltBefCnts == ""){
				fltBefCnts = fValue.length+"";
			}else{
				fltBefCnts += ","+fValue.length;
			}
			if(fltBefChkCnt == ""){
				fltBefChkCnt = cnt+"";
			}else{
				fltBefChkCnt += ","+cnt;
			}
			
			if(div == 2){//or조건
				if(qryWhere == ""){
					qryWhere += "and (" + fieldName + " in {" ;
				}else{
					qryWhere += "or " + fieldName + " in {" ;
				}
			}else{
				qryWhere += "and " + fieldName + " in {" ;
			}//and 조건
			for(var i=0; i<fValue.length ; i++){
				if(fValue[i].checked){
					if( sub != "" ){
						sub += "," ;
					}
					sub += "'" + fValue[i].value + "'" ;
					
					//fltBef
					if(fltBefVals == ""){
						fltBefVals = i+"";
					}else{
						fltBefVals += ","+i+"";
					}
				}
			}
			qryWhere += sub + "} " ;		// ex) and 필드명 in {'값1','값3'}
		}
			
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		var cnt = 0;
		fValue = new Object();//추가 0205
		fValue = document.getElementsByName('journal');
		fieldName = 'flt_containedInJournal_v';
		for(var i=0; i<fValue.length ; i++){
			if(fValue[i].checked){
				cnt++;
			}
		}
		
		if(cnt > 0){
			
			//fltBef
			if(fltBefDivs == ""){
				fltBefDivs = "journalFilter";
			}else{
				fltBefDivs += ",journalFilter";
			}
			if(fltBefCnts == ""){
				fltBefCnts = fValue.length+"";
			}else{
				fltBefCnts += ","+fValue.length;
			}
			if(fltBefChkCnt == ""){
				fltBefChkCnt = cnt+"";
			}else{
				fltBefChkCnt += ","+cnt;
			}
			
			
			if(div == 2){//or조건
				if(qryWhere == ""){
					qryWhere += "and (" + fieldName + " in {" ;
				}else{
					qryWhere += "or " + fieldName + " in {" ;
				}
			}else{
				qryWhere += "and " + fieldName + " in {" ;
			}//and 조건
			
			sub = "";//추가 0205
			
			for(var i=0; i<fValue.length ; i++){
				if(fValue[i].checked){
					if( sub != "" ){
						sub += "," ;
					}
					sub += "'" + fValue[i].value + "'" ;
					
					//fltBef
					if(fltBefVals == ""){
						fltBefVals = i+"";
					}else{
						fltBefVals += ","+i+"";
					}
				}
			}
			qryWhere += sub + "} " ;		// ex) and 필드명 in {'값1','값3'}
		}
		
		
		var cnt = 0;
		fValue = new Object();//추가 0205
		fValue = document.getElementsByName('textAvailable');
		
		fieldName = 'textAvailable';
		for(var i=0; i<fValue.length ; i++){
			if(fValue[i].checked){
				cnt++;
			}
		}
		
		if(cnt > 0){
			
			//fltBef
			if(fltBefDivs == ""){
				fltBefDivs = "textAvailableFilter";
			}else{
				fltBefDivs += ",textAvailableFilter";
			}
			if(fltBefCnts == ""){
				fltBefCnts = fValue.length+"";
			}else{
				fltBefCnts += ","+fValue.length;
			}
			if(fltBefChkCnt == ""){
				fltBefChkCnt = cnt+"";
			}else{
				fltBefChkCnt += ","+cnt;
			}
			
			
			if(div == 2){//or조건
				if(qryWhere == ""){
					qryWhere += "and (" + fieldName + " in {" ;
				}else{
					qryWhere += "or " + fieldName + " in {" ;
				}
			}else{
				qryWhere += "and " + fieldName + " in {" ;
			}//and 조건
			
			sub = "";//추가 0205
			
			for(var i=0; i<fValue.length ; i++){
				if(fValue[i].checked){
					if( sub != "" ){
						sub += "," ;
					}
					sub += "'" + fValue[i].value + "'" ;
					
					//fltBef
					if(fltBefVals == ""){
						fltBefVals = i+"";
					}else{
						fltBefVals += ","+i+"";
					}
				}
			}
			qryWhere += sub + "} " ;		// ex) and 필드명 in {'값1','값3'}
		}
		
		
		
		

		var cnt = 0;
		fValue = new Object();//추가 0205
		fValue = document.getElementsByName('pubyear');
		fieldName = 'issued';
		for(var i=0; i<fValue.length ; i++){
			if(fValue[i].checked){
				cnt++;
			}
		}
		
		if(cnt > 0){
			
			//fltBef
			if(fltBefDivs == ""){
				fltBefDivs = "pubyearFilter";
			}else{
				fltBefDivs += ",pubyearFilter";
			}
			if(fltBefCnts == ""){
				fltBefCnts = fValue.length+"";
			}else{
				fltBefCnts += ","+fValue.length;
			}
			if(fltBefChkCnt == ""){
				fltBefChkCnt = cnt+"";
			}else{
				fltBefChkCnt += ","+cnt;
			}
			
			
			if(div == 2){//or조건
				if(qryWhere == ""){
					qryWhere += "and (" + fieldName + " in {" ;
				}else{
					qryWhere += "or " + fieldName + " in {" ;
				}
			}else{
				qryWhere += "and " + fieldName + " in {" ;
			}//and 조건
			
			sub = "";//추가 0205
			
			for(var i=0; i<fValue.length ; i++){
				if(fValue[i].checked){
					if( sub != "" ){
						sub += "," ;
					}
					sub += "'" + fValue[i].value + "'" ;
					
					//fltBef
					if(fltBefVals == ""){
						fltBefVals = i+"";
					}else{
						fltBefVals += ","+i+"";
					}
				}
			}
			qryWhere += sub + "} " ;		// ex) and 필드명 in {'값1','값3'}
		}
		
		
		
		var cnt = 0;
		fValue = new Object();//추가 0205
		fValue = document.getElementsByName('author');
		fieldName = 'authorlist_idx';
		for(var i=0; i<fValue.length ; i++){
			if(fValue[i].checked){
				cnt++;
			}
		}
		
		if(cnt > 0){
			//fltBef
			if(fltBefDivs == ""){
				fltBefDivs = "authorFilter";
			}else{
				fltBefDivs += ",authorFilter";
			}
			if(fltBefCnts == ""){
				fltBefCnts = fValue.length+"";
			}else{
				fltBefCnts += ","+fValue.length;
			}
			if(fltBefChkCnt == ""){
				fltBefChkCnt = cnt+"";
			}else{
				fltBefChkCnt += ","+cnt;
			}
			
			
			if(div == 2){//or조건
				if(qryWhere == ""){
					qryWhere += "and (" + fieldName + " in {" ;
				}else{
					qryWhere += "or " + fieldName + " in {" ;
				}
			}else{
				qryWhere += "and " + fieldName + " in {" ;
			}//and 조건
			
			sub = "";//추가 0205
			
			for(var i=0; i<fValue.length ; i++){
				if(fValue[i].checked){
					if( sub != "" ){
						sub += "," ;
					}
					sub += "'" + fValue[i].value + "'" ;
					
					//fltBef
					if(fltBefVals == ""){
						fltBefVals = i+"";
					}else{
						fltBefVals += ","+i+"";
					}
				}
			}
			qryWhere += sub + "} " ;		// ex) and 필드명 in {'값1','값3'}
		}
		
		
		if(div == 2){//or조건
			if(qryWhere != ""){
				qryWhere += ")" ;
			}
		}
	}
	
	//isNull
	var isNull = $("form[name='historyForm']").find("input[name='isNull']").val();
	///////////alert("fltMulSchKwd:"+qryWhere);
	//isNull 이 값이 있다면 qryWhere 을 수정해야 한다.
	
	if(isNull == "true"){
		if(qryWhere != ""){
			qryWhere = qryWhere.substr(4);
			////////alert("fltMulSchKwd:"+qryWhere);
		}
	}
	
	hstr.fltWhereQuery.value = qryWhere;
	$("form[name='historyForm']").find("input[name='fltType']").val("");
	$("form[name='historyForm']").find("input[name='fltGetCnt']").val("");
	
	var fltBefAndOrChk = $("input[name=kolisCollectionSet]").val();
	
	$("form[name='historyForm']").find("input[name='fltBefDivs']").val(fltBefDivs);
	$("form[name='historyForm']").find("input[name='fltBefCnts']").val(fltBefCnts);
	$("form[name='historyForm']").find("input[name='fltBefVals']").val(fltBefVals);
	$("form[name='historyForm']").find("input[name='fltBefChkCnt']").val(fltBefChkCnt);
	$("form[name='historyForm']").find("input[name='fltBefAndOrChk']").val(fltBefAndOrChk);
	
	
	////////alert("fltMulSchKwd2:"+hstr.fltWhereQuery.value);
	
	hstr.submit();
	return;
}
/**
* 입력받은 카테고리값 검색
*
* @ param ctgr_val - 카테고리 코드   
*
* @ return	void
**/	
function goCategory(ctgr_val){
	var frm = getForm(hstrFrm);

	
	CommonUtil.setValue(frm, "ctgr", "TOTAL");
	CommonUtil.setValue(frm, "pageNum", "1");
	CommonUtil.setValue(frm, "category", ctgr_val);	
	
	//CommonUtil.setValue(frm, "fltWhereQuery", "");  그대로 따라가도록 처리
	
	CommonUtil.setValue(frm, "fltBefDivs", "");
	CommonUtil.setValue(frm, "fltBefCnts", "");
	CommonUtil.setValue(frm, "fltBefVals", "");
	CommonUtil.setValue(frm, "fltBefChkCnt", "");
	CommonUtil.setValue(frm, "fltBefAndOrChk", "");
	
	//CommonUtil.setValue(frm, "pageSize", "form[name=historyForm]").find("input[name=pageSize]").val());	
	//CommonUtil.setValue(frm, "subCategory", "ALL");
	
	CommonUtil.setValue(frm, "srchFd", "");
	if (frm.kwd.value=="") {
		if(ctgr_val=="INKOREA") 
			frm.action="${ctxt}/hm/inkorea"; 
		if(ctgr_val=="BOOK") 
			frm.action="${ctxt}/hm/book";
		if(ctgr_val=="REPORT") 
			frm.action="${ctxt}/hm/report";
		if(ctgr_val=="NONBOOK") 
			frm.action="${ctxt}/hm/nonbook";
		if(ctgr_val=="journal") 
			frm.action="${ctxt}/hm/Periodical";
		
	} else {
		
		if(ctgr_val=="INKOREA") 
    		CommonUtil.setValue(frm, "wkid", "21");
		if(ctgr_val=="BOOK") 
			CommonUtil.setValue(frm, "wkid", "1");
		if(ctgr_val=="REPORT")  
			CommonUtil.setValue(frm, "wkid", "4");
		if(ctgr_val=="NONBOOK") 
			CommonUtil.setValue(frm, "wkid", "3");
		if(ctgr_val=="journal")
			CommonUtil.setValue(frm, "wkid", "51");
		
		if(ctgr_val=="TOTAL")
		  frm.action="${ctxt}/search/inTotalSearchMain.do";
//		else
//		  frm.action="?";
		
	}
	frm.method="post";
	frm.submit();
}

/**
* 입력받은 카테고리값 검색 - 전자자원용
*
* @ param ctgr_val - 카테고리 코드   
*
* @ return	void
**/	
function goCategory2(ctgr_val){
	var frm = getForm(hstrFrm);
	CommonUtil.setValue(frm, "ctgr", "TOTAL");
	CommonUtil.setValue(frm, "pageNum", "1");
	CommonUtil.setValue(frm, "category", ctgr_val);	
	//CommonUtil.setValue(frm, "fltWhereQuery", "");
	CommonUtil.setValue(frm, "fltBefDivs", "");
	CommonUtil.setValue(frm, "fltBefCnts", "");
	CommonUtil.setValue(frm, "fltBefVals", "");
	CommonUtil.setValue(frm, "fltBefChkCnt", "");
	CommonUtil.setValue(frm, "fltBefAndOrChk", "");
	//CommonUtil.setValue(frm, "pageSize", "form[name=historyForm]").find("input[name=pageSize]").val());	
	//CommonUtil.setValue(frm, "subCategory", "ALL");
	CommonUtil.setValue(frm, "srchFd", "");
	
	if(ctgr_val=="INKOREA") 
		CommonUtil.setValue(frm, "wkid", "21");
	if(ctgr_val=="BOOK") 
		CommonUtil.setValue(frm, "wkid", "1");
	if(ctgr_val=="REPORT")  
		CommonUtil.setValue(frm, "wkid", "4");
	if(ctgr_val=="NONBOOK") 
		CommonUtil.setValue(frm, "wkid", "3");
	if(ctgr_val=="journal")
		CommonUtil.setValue(frm, "wkid", "51");

	if(ctgr_val=="TOTAL")
		  frm.action="${ctxt}/search/inTotalSearchMain.do";	
	
	frm.method="post";
	frm.submit();
}


/**
* 입력받은 카테고리값으로 전체검색
*
* @ param ctgr_val - 카테고리 코드   
*
* @ return	void
**/	
/*function goAllCategory(ctgr_val){
	var frm = getForm(srchFrm);
	
	CommonUtil.setValue(frm, "pageNum", "1");	
	CommonUtil.setValue(frm, "category", ctgr_val);	
	CommonUtil.setValue(frm, "isNull", "true");	
	
	
	//CommonUtil.setValue(frm, "pageSize", "form[name=historyForm]").find("input[name=pageSize]").val());	
	//CommonUtil.setValue(frm, "subCategory", "ALL");
	//$("#searchForm").attr("action", "<c:url value='/search/inSearch.do'/>");
	$("#searchForm").attr("action", "/search/inSearch.do");
	frm.submit();
}*/


/**
 * 입력받은 카테고리값 검색
 *
 * @ param ctgr_val - 카테고리 코드   
 *
 * @ return	void
 **/	
function goDetail( detailKey, detailType, detailTitle ){       
	var frm = getForm(dtlFrm);
	//alert("action = " + frm.action);
	CommonUtil.setValue(frm, "ctgr", "TOTAL");
	CommonUtil.setValue(frm, "detailKey", detailKey);	
	CommonUtil.setValue(frm, "detailType", detailType.toLowerCase());	
	CommonUtil.setValue(frm, "detailTitle", detailTitle);
	CommonUtil.setValue(frm, "kwd", "");  //2015.07.10 정책임요청 상세보기서 kwd 안보이게 처리
	//CommonUtil.setValue(frm, "subCategory", "ALL");
	
	if (detailType == "BOOK")
		CommonUtil.setValue(frm, "wkid", "1");
	else if (detailType == "NONBOOK")
		CommonUtil.setValue(frm, "wkid", "3");
	else if (detailType == "REPORT")
		CommonUtil.setValue(frm, "wkid", "4");
	else if (detailType == "article")
		CommonUtil.setValue(frm, "wkid", "21");
	else if (detailType == "journal")
		CommonUtil.setValue(frm, "wkid", "51");
	else
		CommonUtil.setValue(frm, "wkid", "");
	
	var title = detailTitle;
	
	var type = detailType;
	
	if(title != ""){
		callKwdCookie(title,type);
		//drawSearchedKwd();
	}
	
	frm.submit();
}
function goDetailJ( detailKey, detailType, detailTitle ){
	
	var frm = getForm(dtlFrm);
	
	CommonUtil.setValue(frm, "ctgr", "TOTAL");
	CommonUtil.setValue(frm, "detailKey", detailKey);	
	CommonUtil.setValue(frm, "detailType", detailType.toLowerCase());	
	CommonUtil.setValue(frm, "detailTitle", detailTitle);
	CommonUtil.setValue(frm, "kwd", "");  //2015.07.10 정책임요청 상세보기서 kwd 안보이게 처리

	
	frm.submit();
}
/**
 * 입력받은 카테고리값 검색
 *
 * @ param ctgr_val - 카테고리 코드   
 *
 * @ return	void
 **/	
function goDetail2(detailType, detailTitle ){
	
	var title = detailTitle;
	
	var type = detailType;
	
	if(title != ""){
		callKwdCookie(title,type);
		drawSearchedKwd();
	}
	
	/*//frm.submit();
	location.target = '_blank';
	location.href = detailUrl;*/
	
}

/**
* 입력받은 서브카테고리값 검색
*
* @ param ctgr_val, sub_ctgr_val - 카테고리 코드, 서브카테고리 코드   
*
* @ return	void
**/	
function goSubCategory( ctgr_val, sub_ctgr_val){
	var frm = getForm(hstrFrm);
	
	CommonUtil.setValue(frm, "ctgr", "TOTAL");
	CommonUtil.setValue(frm, "pageNum", "1");
	CommonUtil.setValue(frm, "category", ctgr_val);
	CommonUtil.setValue(frm, "subCategory", sub_ctgr_val);
	
	frm.submit();
}

/**
* 셀렉트 박스 카테고리 매칭 
*
* @ param value - 카테고리
*
* @ return	void	
**/	
function setSltBox( value ){
	var ctgr = "";
	
	for(var i=0;i<ctgr_cnt;i++){
		if(value == ctgr_arr[i][0]) 
			ctgr = ctgr_arr[i][1];
	}

	makeCtgrSltBox(ctgr);
	CommonUtil.setValue(getForm(srchFrm), "category", ctgr);	
}

/**
* 카테고리 셀렉트 박스 만들기(HTML) 
*
* @ param ctgr - 카테고리  
*
* @ return	void	
**/	
function makeCtgrSltBox( ctgr ){
	var temp_str = "";	
	
	for(var i=0;i<ctgr_cnt;i++){
		if(ctgr != ctgr_arr[i][1])
			temp_str += "<li>"+ctgr_arr[i][0]+"</li>";
	}
	
	$('#sel_sch').html(temp_str);
	
	$('#sel_sch').children().click(function(){
		var cate_nm = $(this).text();
		
		$('#cateName').children().first().text(cate_nm);
		$('#sch_arr').removeClass('sch_arr_on').addClass('sch_arr');
		$('#sel_sch').hide('fast');
		
		setSltBox(cate_nm);
	});
}

/**
* 카테고리 매칭 함수. 
* 카테고리명을 넘겨주면 코드를, 코드값을 넘겨주면 카테고리 명을 리턴
*
* @ param ctgr - 카테고리값 
* @ param type - 타입(0 : 카테고리명, 1 : 카테고리코드 )  
*
* @ return str 			
**/	
function rtnCtgrVal( ctgr, type ){
	var rtn_val = "";
	if( type != 0 && type != 1 )
		return rtn_val;
	
	for(var i=0;i<ctgr_cnt;i++){
		if( ctgr_arr[i][type] == ctgr ){
			if( type == 0 ){
				rtn_val = ctgr_arr[i][1];
			}else{
				rtn_val = ctgr_arr[i][0];
			}
		}
	}
	
	return rtn_val;
}

/**
* 폼 Object 리턴
* 
* @ param frm_nm (폼명)  
* 
* @ return  폼 객체 리턴
**/
function getForm( frm_nm ){
	return document.forms[frm_nm];
}


/**
* 마지막 공백일 시 제거 (trim) for ie 7.0 이하
* 
* @ param str  
* 
* @ return  rtn_str (공백 제거 str)
**/
function repSpace( str ){
	var rtn_str = "";
	
	if( str == "" ){
		return rtn_str;
	}
	
	if(str.substring(str.length-1, str.length) == " "){
		rtn_str = str.substring(0, str.length-1);
	}else{
		rtn_str = str;
	}
	
	return rtn_str;
}


/**
* 키워드 체크
* 
* @ param frmObj(폼 오브젝트)
* 
* @ return  true, false;
**/
function chkNullKwd( frmObj ){
	if(frmObj.kwd.value == ""){
		alert('값없음');
		return false;
	}else{		
		return true;
	}
}

/**
* 검색어 체크 
* 
* @ param	frm				- form Object
* 
* @ return   true / false 	- 키워드 있음(true) , 없음(false)
**/
function searchKwd(frm)
{
	var kwd = CommonUtil.getValue(frm, 'kwd');
	if (kwd == '')
	{
		alert('검색어를 입력해 주세요');
		return false;
	}
	else
	{
		return true;
	}
}

/**
* 원하는 조건으로 검색 
* 
* @ param	fd_nm(input name), val(넣을값)
*
* @ return   void
**/
function goSrch(fd_nm, val)
{
	var frm = getForm(hstrFrm);
	
	CommonUtil.setValue(frm, fd_nm, val);
	frm.submit();
}

/**
* 페이지 이동 ( historyForm사용)
* 
* @ param	pagenum		- 페이지 번호
*
* @ return   void
**/
function gotoPage(pagenum)
{
	/*
	var frm = getForm(hstrFrm);
	CommonUtil.setValue(frm, "ctgr", "TOTAL");
	CommonUtil.setValue(frm, "pageNum", "1");	
	CommonUtil.setValue(frm, "category", ctgr_val);	
	CommonUtil.setValue(frm, "fltWhereQuery", "");	
	//CommonUtil.setValue(frm, "pageSize", "form[name=historyForm]").find("input[name=pageSize]").val());	
	//CommonUtil.setValue(frm, "subCategory", "ALL");
	CommonUtil.setValue(frm, "srchFd", "");
	frm.submit();
	*/
	
	var frm = getForm(hstrFrm);
	
	CommonUtil.setValue(frm,"pageNum",pagenum);
	CommonUtil.setValue(frm,"fltGetCnt","");
	frm.submit();
}

/** 
 * 검색 필터옵션 초기화
 * 
 * @ param	
 *
 * @ return   void 
 */
function resetSearchFilter() 
{
	var frm = getForm(fltrFrm);		
	
	// 추가된 옵션의 경우 동일 방식으로 초기화 필요
	CommonUtil.setValue(frm, "sort", "");	// 정렬
	CommonUtil.setValue(frm, "srchFd", "");	// 영역
	CommonUtil.setValue(frm, "date", "0");	// 기간 (선택)
	CommonUtil.setValue(frm, "sliderValue", "5");	// 기간 (슬라이더)	
	CommonUtil.setValue(frm, "startDate", "");	// 기간 (시작일)
	CommonUtil.setValue(frm, "endDate", "");	// 기간 (종료일)
	checkBoxStat( frm.year, "0");				// 연도 - 배열
	checkBoxStat( frm.fileExt2, "0");			// 첨부문서 - 배열
	
	if ( frm.kwd.value != "" ) {
		frm.submit();	
	}
}

/**
* 현재 날짜 기준으로 날짜범위 계산 및 반영 ( detailSearchForm 사용)
* @ param	startname		- 시작일
* @ param    endname		- 종료일
* @ param    range		- 범위 (1일,(1) 1달(30), 3달(90)...)
* @ param    formType	- 1: detailForm, 2 : filterForm
*
* @ return   void
**/
function choiceDatebutton(startname, endname, range, formType)
{
	var startDate = '';
	var endDate   = '';
	var frm = getForm(detlFrm);
	
	if ( formType == 1 ) {
		frm = getForm(detlFrm);
	} else if (formType == 2 ) {
		frm = getForm(fltrFrm);
	}
	
	if (range == 1) {
		startDate 	= CommonUtil.getToday();
		endDate		= CommonUtil.getToday();
	}
	else if (range == 7) {
		startDate 	= CommonUtil.calcDateWeek(CommonUtil.getToday(),-1);
		endDate		= CommonUtil.getToday();
	}
	else if (range == 30) {
		startDate 	= CommonUtil.calcDateMonth(CommonUtil.getToday(),-1);
		endDate		= CommonUtil.getToday();
	}
	else if (range == 90) {
		startDate 	= CommonUtil.calcDateMonth(CommonUtil.getToday(),-3);
		endDate		= CommonUtil.getToday();
	}
	else if (range == 180) {
		startDate 	= CommonUtil.calcDateMonth(CommonUtil.getToday(),-6);
		endDate		= CommonUtil.getToday();
	}
	else if (range == 365) {
		startDate 	= CommonUtil.calcDateYear(CommonUtil.getToday(),-1);
		endDate		= CommonUtil.getToday();
	}
	else if (range == 1095) {
		startDate 	= CommonUtil.calcDateYear(CommonUtil.getToday(),-3);
		endDate		= CommonUtil.getToday();
	}

	CommonUtil.setValue(frm, startname, startDate);
	CommonUtil.setValue(frm, endname, endDate);
}



/**
* GNB창의 레이어 selectBox 창 컨트롤 ( searchForm 사용)
* @ param	code			- 코드값
* @ param    name			- 이름
*
* @ return   void
*
* 참고사항
* selectedSearch , searchSelect 의 레이어를 사용하며 style의 class명을 이용한 컨트롤
**/
function selectSearch(code, name)
{
    var selecttxt_obj  = document.getElementById("selectedSearch");		// 셀렉트박스 선택이름이 바뀔 텍스트위치
	var viewselect_obj = document.getElementById("searchSelect");		// 셀렉트박스 목록
	var frm = getGnbForm();
	
	// 텍스트 변경
	if (typeof(selecttxt_obj) == "object" && typeof(viewselect_obj) == "object" )
	{
		selecttxt_obj.innerHTML = name;				//셀렉트 박스 이름 변경
		viewselect_obj.className = "searchSelect_off";	//셀렉트 박스 목록 제거
		
		CommonUtil.setValue(frm, "category", code);	//폼값 싱크맞춤			
	}
}


/**
* 미리보기 기능구현
* @ param	divid		-  내용을 넣어줄 div의 id
* @ param    rowid		-  미리보기할 대상 데이터의 $ROWID 값
* @ param    index		-  다중첨부일 경우 몇번째 첨부문서인지의 index값 (0~)
* @ return   void
*
* 참고사항 
* 1) url의 내용을 divid의 레이어에 innerHTML해줌
* 2) 해당 div를 display none, block으로 토글해줌
* 3) 내부참조펑션 : konan_get_htmltext(Url)
**/
function konan_preview(divid, rowid, index)
{
	//preview.xxx 를 자동으로 체크해서 이름을 넘겨줌 (하드코딩해도됨)
	var preview_html = '';
	if      (document.location.pathname.indexOf('.jsp') > 0)
		preview_html += 'preview.jsp';
	else if (document.location.pathname.indexOf('.aspx') > 0)
		preview_html += 'preview.aspx';
	else if (document.location.pathname.indexOf('.asp') > 0)
		preview_html += 'preview.asp';	
	else if (document.location.pathname.indexOf('.php') > 0)
		preview_html += 'preview.php';	
	else if (document.location.pathname.indexOf('.html') > 0)
		preview_html += 'preview.html';	
		
	if (preview_html == '') {
		alert('미리보기할 URL 페이지가 등록되지 않았습니다');
		return;
	}
	
	var url 		= './'+preview_html+'?rowid='+rowid+'&index='+index+'&kwds=';
	var divboxobj 	= document.getElementById(divid+'_box');	// 외곽 box
	var divobj 		= document.getElementById(divid);			// 내용들어가는곳
	var default_str = '';
	
	if (divobj == null || divboxobj==null ) {
		alert('해당 div의 id를 찾을수 없습니다');
	}
	else {
		var kwds 	= '';
		kwds 		+= CommonUtil.getValues(getForm(detlFrm), 'kwd');
		kwds 		+= CommonUtil.getValues(getForm(detlFrm), 'preKwd');
		
		//키워드가 깨질 경우에는 인코딩 변경을 해지하거나, preview.jsp에서 kwds 파라미터 인코딩 관련 사항을 수정하세요.
		//url 		+= encodeURIComponent(kwds);
		url 		+= kwds;

		//기본값과 같을경우에만 요청해서 값을 바꿔줌
		if (CommonUtil.trim(divobj.innerHTML) == default_str)
		{
			var html = CommonUtil.UtltoHtml(url);
			if (CommonUtil.trim(html) == '') {
				//alert('첨부파일에 해당 키워드로 검색되지 않았습니다');
				divboxobj.style.display = 'none';
				return;
			}
			else {
				divobj.innerHTML = html;
			}
		}
		
		/*/미리보기 기능 토글
		if (typeof(divboxobj.style.display) != 'undefined')
		{
			if (divboxobj.style.display == 'none')
				divboxobj.style.display = 'block';
			else
				divboxobj.style.display = 'none';
		}*/
	}
}

/**
* 상세검색창 보기/숨기기  (토글처리)
* @ return   void
*
* 참고사항 
* "advanced_search" 레이어의 style class명을 체크하여 변경해줌
**/
function detailview()
{
	var divobj = document.getElementById("advanced_search");
	if (typeof(divobj.className) == "string")
	{
		if (divobj.className == "")
			divobj.className = "hidden";
		else
			divobj.className = "";
	}
}

/**
* GNB 영역 카테고리 선택
* @ return   void
*
* 참고사항 
* "searchSelectList" 레이어의 style.display 를 변경해줌
**/
function categotyView(flag)
{
	var divobj = document.getElementById("searchSelectList");
	
	if (flag == true)
		divobj.style.display = "block";
	else
		divobj.style.display = "none";

}

/**
* 파일다운로드 기능 (샘플)
* @ param   str		- 파일명
* @ return   void
*
**/
function fileDownload(str)
{
	alert("파일명 : " + str );
}

/**
* 첨부파일 새창으로 보기 (샘플)
* @ param   rowid		- 미리보기할 대상 데이터의 $ROWID 값
* @ param   index            -  다중첨부일 경우 몇번째 첨부문서인지의 index값 (0~)
* @ return   void
*
**/
function fileView(rowid, index)
{
	alert("새창으로 첨부파일 열기\nROWID="  + rowid + ", index=" + index );
}


/**
* 달력기능 호출
* @ param   checkname         - 미리보기할 대상 데이터의 $ROWID 값
* @ param   textid            -  달력에서 선택된 날짜가 출력될 <input type="text" ../> 의 ID
* @ param   divid             -  달력이 그려질 레이어 <div ...> 의  ID
* @ return   void
*
**/
function showCalendar(checkname, textid, divid, obj) {
	var target = document.getElementById(textid);
	var obj_x = CommonUtil.getElementX(target);
	var obj_y = CommonUtil.getElementY(target);
		
	//상세검색
	if (checkname != '') {
		var data = CommonUtil.getValue(getForm(detlFrm), checkname);
	    
		obj_y -= 60;
	
	    if (data == 'select')
	        konanCalendar.loadCalendar(textid, divid, obj_x, obj_y);
	    else
	        alert('기간입력을 눌러주세요');
	}
	//좌측영역
	else {
		obj_y = target.style.top;
		
		konanCalendar.loadCalendar(textid, divid, obj_x, obj_y);
	}
}


/**
* 텍스트박스 날짜 입력값 확인 (달력)
* @ param inputObj	입력창obj
*/
function checkDate (inputObj) {
	var pattern = /^[0-9]*$/;
	var target 	= inputObj.value;
	
	if(!pattern.test(target)) {
		inputObj.value = '';
		alert('숫자만 입력해주세요.');
	}
	else if (target.length > 8) {
		inputObj.value = '';
		alert('8자리로 입력해주세요. 예)\''+ CommonUtil.getToday() +'\'');
	}
	else if (target<19000101 || target>20331231) {
		alert('기간은 19000101 ~ 20331231 사이만 검색 가능합니다.');
		inputObj.value = '';
	}
}


/**
* 체크박스 전체 선택&해제
* @ param chkObj	체크박스obj
*/
function checkBoxStat (chkObj, div) {	
	if (div == 'TOTAL' || div == '0') {
		for (var i=1; i<chkObj.length; i++) {
			chkObj[i].checked = false;
		}
	}
	else {
		chkObj[0].checked = false;
	}
}

/**
* 해당 ID를 가진 DIV의 class명을 classname 으로 바꿔준다.
* 
* @ param objid(바꿀id값), classname(바꿀 class명)
* 
* @ return void	
*/
function evtChangeClassName(objid, classname) {
    var divobj  = document.getElementById(objid);
    if (divobj != null) {
          divobj.className = classname;
    } else {
          alert('해당 레이어의 ID \'' + objid + '\'는 찾을수 없습니다');
    }
}

/**
* 해당 ID를 가진 DIV의 class명을 classname 으로 바꿔준다. (토글형태)
* 
* @ param objid(바꿀id값), classname_show(보여줄 클래스명), classname_hidden(숨길 클래스명)
* 
* @ return void	
*/
function evtChangeClassNametg(objid, classname_show, classname_hidden) {
    var divobj  = document.getElementById(objid);
    if (divobj != null) {
	  		if (divobj.className == classname_hidden)
				divobj.className = classname_show;
			else
				divobj.className = classname_hidden;
    } else {
          alert('해당 레이어의 ID \'' + objid + '\'는 찾을수 없습니다');
    }
}

/*******************************************************
* 프로그램명 : search.js   # 공통기능
* 설명             : 통합검색용  범용 코드 구현 js Class (CommonUtil)
* 작성일         :  2010.04.05
* 작성자         : 정민철
* 수정내역     :
*
* 2010.03.25 - 첨부파일미리보기 펑션수정
* 2010.03.24 - trim, replaceAll 추가
* 2010.03.23 - getValues 기능추가
* 2010.03.17 - getValue의 checkbox 리턴값 버그 수정
  *****************************************************/
var CommonUtil = {
	
	/**
	* URL을 받아서 해당 결과를 String으로 리턴해줌
	* @ param   url		- 읽어올 페이지의 주소
	* 
	* @ return   str		-  url에서 보여지는 페이지 결과의 string
	*
	**/
	UtltoHtml : function (url) {
		var str = '';

		var xmlhttp = null;

		if(window.XMLHttpRequest) {
		   // FF 로 객체선언
		   xmlhttp = new XMLHttpRequest();
		} else {
		   // IE 경우 객체선언
		   xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		if ( xmlhttp ) 
		{//비동기로 전송
			xmlhttp.open('GET', url, false);
			xmlhttp.send(null);
			str = xmlhttp.responseText;
		}
		return str;
	},
	
	/**
	* form 의 특정 name에 값을 세팅해줌 (라디오버튼, input,hidden, 셀렉트 박스) 알아서 처리해줌
	* @ param   frmobj		- 폼오브젝트
	* @ param	name			- 해당 데이터의 name
	* @ param	value			- 세팅될 값
	*
	* @ return   void
	* 
	* 주의사항
	* name이 복수개일경우 첫번째에 값을 세팅해줌
	**/
	setValue : function (frmobj, name, value) {
		if ( typeof(frmobj) == "object" && typeof(frmobj.length) == "number");
		{
			for (var i=0; i< frmobj.length; i++)
			{
				if (frmobj[i].name == name)
				{
					if (frmobj[i].type=="text" || frmobj[i].type=="hidden" )
					{// hidden , text
						frmobj[i].value = value;
						break;
					}//--end: hidden, text
					else if (frmobj[i].type=="radio" && frmobj[i].value == value )
					{// radio 버튼
						 frmobj[i].checked = true;
						 break;
					}//--end:radio
					else if (frmobj[i].type=="checkbox")
					{//checkbox박스
						if (value == true)
							frmobj[i].checked = true;
						else
							frmobj[i].checked = false;
						
						break;
					}//--end:checkbox
					else if (frmobj[i].type=="select-one" && typeof(frmobj[i].options) == "object" && typeof(frmobj[i].length) == "number")
					{//select박스
						var selectidx = 0;
						for(var j=0; j<frmobj[i].length; j++)
						{
							if (value == frmobj[i].options[j].value)
							{
								selectidx = j;
								break;
							}
						}
						frmobj[i].selectedIndex = selectidx;
					}//--end:select
					
				}
				
			}
		}
	},
	
	/**
	* form 의 특정 name에 값을 가져옴 (라디오버튼, input,hidden, 셀렉트 박스 알아서 처리됨  )
	* @ param   frmobj		- 폼오브젝트
	* @ param	name			- 해당 데이터의 name
	*
	* @ return   해당 frmobj의 특정 name에 있는 값(value)
	* 
	* 주의사항
	* name이 복수개일경우 첫번째에 값을 리턴
	**/
	getValue : function (frmobj, name)	{
		var result = null;

		if ( typeof(frmobj) == "object" && typeof(frmobj.length) == "number");
		{
			for (var i=0; i< frmobj.length; i++)
			{
				if (frmobj[i].name == name)
				{
					if (frmobj[i].type=="text" || frmobj[i].type=="hidden" )
					{// hidden , text
						result = frmobj[i].value;
						break;
					}//--end: hidden, text
					else if (frmobj[i].type=="radio" && frmobj[i].checked == true)
					{// radio 버튼
						 result = frmobj[i].value;
						 break;
					}//--end:radio
					else if (frmobj[i].type=="checkbox")
					{//checkbox박스
						result = frmobj[i].checked;
						break;
					}//--end:checkbox
					else if (frmobj[i].type=="select-one" && typeof(frmobj[i].options) == "object" && typeof(frmobj[i].length) == "number")
					{//select박스
						var idx = frmobj[i].selectedIndex;
						result = frmobj[idx].value;
						break;
					}
				}
			}
		}
		return result;
	},
	
	/**
	* form 의 특정 name에 값을 가져옴(라디오버튼, input,hidden, 셀렉트 박스 알아서 처리됨  )
	*
	* @ param   frmobj		- 폼오브젝트
	* @ param	name			- 해당 데이터의 name
	*
	* @ return   해당 frmobj의 특정 name에 있는 값(value)
	* 
	* 주의사항
	* name이 복수개일경우 공백(space)을 넣어 나열된 값을 리턴
	**/
	getValues : function (frmobj, name)	{
		var result = "";

		if ( typeof(frmobj) == "object" && typeof(frmobj.length) == "number");
		{
			for (var i=0; i< frmobj.length; i++)
			{				
				if (frmobj[i].name == name)
				{
					if (frmobj[i].type=="text" || frmobj[i].type=="hidden" )
					{// hidden , text						
						result += frmobj[i].value;
					}//--end: hidden, text
					else if (frmobj[i].type=="radio" && frmobj[i].checked == true)
					{// radio 버튼
						 result += frmobj[i].value;
					}//--end:radio
					else if (frmobj[i].type=="checkbox")
					{//checkbox박스
						result += frmobj[i].checked;
					}//--end:checkbox
					else if (frmobj[i].type=="select-one" && typeof(frmobj[i].options) == "object" && typeof(frmobj[i].length) == "number")
					{//select박스
						var idx = frmobj[i].selectedIndex;
						result += frmobj[idx].value;
					}
					
					result += " ";
				}
			}
		}
		return result;
	},
	
	/**
	* YYYYMMDD를 DATE() 형으로 변환
	*
	* @ param   str			- YYYYMMDD형 스트링 형태의 날짜값
	*
	* @ return   			- Date() 형 날짜값
	**/
	string2date : function (str)
	{
		var year = "";
        var month = "";
        var day = "";

        if (typeof (str) == "string") {
            if (str.length < 8)
			{
				alert("[error - search.js] : string2date() 8자리 날짜가 아닙니다");
                return null;
			}
            year = parseInt(str.substring(0, 4));
            month = parseInt(str.substring(4, 6));
            day = parseInt(str.substring(6, 8));

            return Date(year, month - 1, day);

        }
	},
	
	/**
	* DATE() 형을 YYYYMMDD String형으로 리턴
	*
	* @ param   date			- Date()형 값
	*
	* @ return   			- "YYYYMMDD" string형 날짜데이터
	**/	
	date2string : function (date)
	{
		var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var day = date.getDate();

        if (month < 10)
            month = "0" + month;
        if (day < 10)
            day = "0" + day;

        return year + "" + month + "" + day;
	},
	
	/**
	* 오늘 날짜 리턴 
	*
	* @ param   
	*
	* @ return   			- YYYYMMDD 오늘날짜
	**/	
	getToday : function () {
			if (typeof(this.todaystr) == "undefined")
			{
				this.todaystr = this.date2string(new Date());
				
			}
			return this.todaystr;
	},
	
	/**
	* 날짜계산 (일단위)
	*
	* @ param   p_strdate		- YYYYMMDD 
	* @ param   p_agoday		- 0 : 오늘 ,    음수 : 과거 ,   양수: 미래       (일(Day)단위)
	*
	* @ return   			- YYYYMMDD 에서 p_agoday일 전후 
	**/	
	calcDateDay : function (p_strdate, p_agoday) {
		var result = "";
		var year,month,day;
		var tmp_strdate = ""+p_strdate;	//string형으로 변환
		
        if (typeof (tmp_strdate) == "string") {
            if (tmp_strdate.length == 8)
			{
				year = parseInt(tmp_strdate.substring(0, 4));
				month = parseInt(tmp_strdate.substring(4, 6));
				day = parseInt(tmp_strdate.substring(6, 8));
				
				result = new Date(year, month-1, day + p_agoday);
			}	
		}
		return this.date2string(result);
	},
	
	/**
	* 날짜계산 (주단위)
	*
	* @ param   p_strdate		- YYYYMMDD 
	* @ param   p_agoweek		- 0 : 오늘 ,    음수 : 과거 ,   양수: 미래       (주(Week)단위)
	*
	* @ return   			- YYYYMMDD 에서 p_agoweek 주 전후 
	**/	
	calcDateWeek : function (p_strdate, p_agoweek) {
		var agoDay = p_agoweek * 7;
		
		return this.calcDateDay(p_strdate, agoDay );
	},
	
	/**
	* 날짜계산 (월단위)
	*
	* @ param   p_strdate		- YYYYMMDD 
	* @ param   agoMonth		- 0 : 오늘 ,    음수 : 과거 ,   양수: 미래       (월(Month)단위)
	*
	* @ return   			- YYYYMMDD 에서 agoMonth 월 전후 
	**/	
	calcDateMonth : function (p_strdate, agoMonth) {
		var result = "";
		var year,month,day;
		var tmp_strdate = ""+p_strdate;	//string형으로 변환
		
        if (typeof (tmp_strdate) == "string") {
            if (tmp_strdate.length == 8)
			{
				year = parseInt(tmp_strdate.substring(0, 4));
				month = parseInt(tmp_strdate.substring(4, 6));
				day = parseInt(tmp_strdate.substring(6, 8));
				
				result = new Date(year, month-1+agoMonth, day);
			}	
		}
		return this.date2string(result);
	},
	
	/**
	* 날짜계산 (년단위)
	*
	* @ param   p_strdate		- YYYYMMDD 
	* @ param   agoYear		- 0 : 오늘 ,    음수 : 과거 ,   양수: 미래       (년(Year)단위)
	*
	* @ return   			- YYYYMMDD 에서 agoYear 년 전후 
	**/	
	calcDateYear : function (p_strdate, agoYear) {
		var result = "";
		var agoMonth = (agoYear + 0) * 12
		var tmp_strdate = ""+p_strdate;	//string형으로 변환
		
        result = this.calcDateMonth(p_strdate,agoMonth);
		
		return result;
	},
	
	/**
	* 문자열 치환
	*
	* @ param   target		- 원본 text
	* @ param   oldstr		- 변경 대상 string
	* @ param   newstr	- 변경될 string
	*
	* @ return   		- 치환된 text
	**/	
	replaceAll : function (target, oldstr, newstr)
	{
		var result = target;
		if (target != null)
		{
			result = target.split(oldstr).join(newstr);
		}
		return result;
	},
	
	/**
	* white Space제거
	*
	* @ param   str		- 문자열
	*
	* @ return   		- 제거된 문자열
	**/	
	trim : function (str)
	{
		var result = str;
		if (str != null)
		{
			result = result.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
		}
		return result;
	},
	
	//엘레먼트의 절대값 y픽셀을 구함
	getElementY : function(element)
	{
		var targetTop = 0;

		if (element.offsetParent) {
			while (element.offsetParent)
			{
				targetTop += element.offsetTop;
	            element = element.offsetParent;
			}
		}
		else if(element.y) {
			targetTop += element.y;
	    }

		return targetTop;
	},
	//엘레먼트의 절대값 x픽셀을 구함
	getElementX : function(element)
	{
		var targetTop = 0;

		if (element.offsetParent)
		{
			while (element.offsetParent)
			{
				targetTop += element.offsetLeft;
	            element = element.offsetParent;
			}
		}
		else if(element.x)
		{
			targetTop += element.x;
		}

		return targetTop;
	}
}