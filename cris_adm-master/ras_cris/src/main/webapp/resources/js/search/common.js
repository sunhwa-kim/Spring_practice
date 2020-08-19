function init(){
	//표시 리스트
	/*
	var show_list = Array
	(
	"slide_sch",
	"slide_sch2"
	)
	
	for (var i = 0; i < show_list.length; i++){
		if(show_obj = document.getElementById(show_list[i])){
		show_obj.className = "";
		}else{
		 continue;
		}
	}
	
	var hdn_prev = document.getElementsByTagName('div');
	for (var l = 0; l < hdn_prev.length; l++){
		if (hdn_prev[l].className == "preview_box"){
			hdn_prev[l].className = "hidden";
		}else{
			continue;
		}
	}
	
	//히든 리스트
	var hdn_list = Array
	(
	"user_sch",
	"sch_more"
	)
	for (var j = 0; j < hdn_list.length; j++){
		if(hdn_obj = document.getElementById(hdn_list[j])){
		hdn_obj.className = "hidden";
		}else{
			continue;
		}
	}
	*/
	//트리메뉴
	
	/**
	 * 2013.11.05(수정: 정병호) (처리내역: 주석처리) 
	 * STR
	 */
	/*var m_con = 
	Array(
	document.getElementById("org_m"),
	document.getElementById("doc_list")
	);
	for(m=0; m<m_con.length; m++){
		if(m_con[m] == null){
			continue;
		}else{
			var count = m_con[m].childNodes;
			var hdn_obj  = m_con[m].getElementsByTagName("ul");
			for (var k = 0; k < hdn_obj.length; k++){
				hdn_obj[k].style.display="none";
			}
		}
	}*/
	/**
	 * END
	 */
	if(document.getElementById("gnb_more")){
		var gnb_m = document.getElementById("gnb_more")
		gnb_m.className = "hidden"; //더보기버튼
	}
	
} //초기 보여질 메뉴 설정

function slideAction(){
	var A_TPL1h = {
		'b_vertical' : false,
		'b_watch': true,
		'n_controlWidth': 149,
		'n_controlHeight': 17,
		'n_sliderWidth': 11,
		'n_sliderHeight': 15,
		'n_pathLeft' : -4,
		'n_pathTop' : -3,
		'n_pathLength' : 145,
		's_imgControl': 'images/bg_slider.gif',
		's_imgSlider': 'images/bt_slider.gif',
		'n_zIndex': 1
	}
	var A_INIT1h = {
		's_form' : 'detailSearchForm',
		's_name' : 'sliderValue',
		'n_minValue' : 1,
		'n_maxValue' : 5,
		//'n_value' : (document.forms['detailSearchForm'].sliderValue.value !='')? document.forms['detailSearchForm'].sliderValue.value:5,
		'n_step' : 1
	}

	//new slider(A_INIT1h, A_TPL1h, "sch_slider_bar1");
}

function slideAction2(){
	
	//카테고리에 따라 슬라이더 생성여부결정필요.
	var search_category = document.forms['searchForm'].category.value;
	if ( search_category == 'TOTAL' ||  search_category == 'JOURNAL' || search_category == 'BOOK' || search_category == 'journal'  || search_category == 'ARTICLE' || search_category == 'REPORT'
		|| search_category == 'MESH' ) {
		var A_TPL2h = {
			'b_vertical' : false,
			'b_watch': true,
			'n_controlWidth': 129,
			'n_controlHeight': 17,
			'n_sliderWidth': 11,
			'n_sliderHeight': 15,
			'n_pathLeft' : -4,
			'n_pathTop' : -3,
			'n_pathLength' : 125,
			's_imgControl': 'images/bg_slider2.gif',
			's_imgSlider': 'images/bt_slider.gif',
			'n_zIndex': 1
		}
		var A_INIT2h = {
			's_form' : 'searchFilterForm',
			's_name' : 'sliderValue',
			'n_minValue' : 1,
			'n_maxValue' : 5,
			//'n_value' : (document.forms['searchFilterForm'].sliderValue.value !='')? document.forms['searchFilterForm'].sliderValue.value:5,
			'n_step' : 1
		}

		//new slider(A_INIT2h, A_TPL2h, "sch_slider_bar2");	
	}
}


function pallet(cColor,bColor){
	var setobj  = document.getElementById("sch_color");
	if(cColor == ""){
		setobj.style.background = "url(images/bg_view_all.gif)";
		setobj.style.borderColor = "#fff";
	}else{
	setobj.style.background = cColor;
	setobj.style.borderColor = bColor;
	}
}//칼라피커


function show_m(obj){
	var t_obj = obj.parentNode;
	var show_obj = t_obj.childNodes;
	for (var i = 0; i < show_obj.length; i++){
		if (!(show_obj[i].tagName == "UL")){
			continue;
		}else{
			if(show_obj[i].style.display == "none"){
			show_obj[i].style.display="block";
			obj.setAttribute("src","images/ico_minus.gif");
			obj.setAttribute("alt","접기");
			}else{
			show_obj[i].style.display="none";
			obj.setAttribute("src","images/ico_plus.gif");
			obj.setAttribute("alt","펼치기");
			}
		}
	}
}

function side_m(obj){
	var t_obj = obj.parentNode;
	var show_obj = t_obj.childNodes;
	for (var i = 0; i < show_obj.length; i++){
		if (!(show_obj[i].tagName == "UL")){
			continue;
		}else{
			if(show_obj[i].style.display == "none"){
			show_obj[i].style.display="block";
			obj.setAttribute("src","images/ico_minus2.gif");
			obj.setAttribute("alt","접기");
			}else{
			show_obj[i].style.display="none";
			obj.setAttribute("src","images/ico_plus2.gif");
			obj.setAttribute("alt","펼치기");
			}
		}
	}
}


function sideTab(){
var obj = document.getElementById("side_tab");
if (obj == null) return false;
obj.style.width = obj.getElementsByTagName("LI").length*49+"px";
}
function mMove(m_bt){
	var obj = document.getElementById("side_tab");
	
	var objLeft;
	var objWidth;
	
	if (obj.currentStyle){
		objLeft = parseInt(obj.currentStyle.left);
		objWidth = parseInt(obj.currentStyle.width);
		
	}else if(window.getComputedStyle){
		var objStyle = document.defaultView.getComputedStyle(obj, null);
		objLeft = parseInt(objStyle.left);
		objWidth = parseInt(objStyle.width);
	}

	if(m_bt == 'right'){
		if (objLeft == (objWidth* -1)+49){
			return false;
		}else{
			obj.style.left = (objLeft -49)+"px";
		}
	}else if(m_bt == 'left'){
		if (objLeft == 0){
			return false;
		}else{
			obj.style.left = (objLeft +49)+"px";
		}
	}
}

function filterBtn(filterH){
	var filterObj = document.getElementById("filter");
	var msg;
	if (filterObj.className =="hidden"){
		filterObj.className = "filer";
		filterH.className = "bt_option"
		msg = "옵션닫기"
	}else if(filterObj.className =="filer"){
		filterObj.className ="hidden";
		filterH.className = "bt_option hdn"
		msg = "옵션펼치기"
	}
	filterH.firstChild.nodeValue = msg;
	 
}//옵션닫기,펼치기

/* SNS로 전송*/
//function sendSNS(sns,title) {
//	var HOST = encodeURIComponent(location.protocol + "//" + location.host);
//	var TITLE = encodeURIComponent(title);
//	
//	var FACEBOOK = "http://www.facebook.com/sharer/sharer.php?s=100&p[url]=" + encodeURIComponent(location.href) + "&p[title]="+TITLE;
//	var TWITTER  = "http://twitter.com/share?text=" + TITLE + "&url=" + encodeURIComponent(location.href);
//	var ME2DAY   = "http://me2day.net/posts/new?new_post[body]=" + TITLE + ":" + encodeURIComponent(location.href) + "&new_post[tags]=" + HOST;
//		
//	switch(sns) {
//	case "facebook":
//		window.open(FACEBOOK, "facebookWindow", 'width=960,height=500,directories=0,resizable=1,menubar=0,status=0,toolbar=0,scrollbars=1');
//		break;
//	case "twitter":
//		window.open(TWITTER, "twitterWindow",  'width=960,height=500,directories=0,resizable=1,menubar=0,status=0,toolbar=0,scrollbars=1');
//		break;
//	case "me2day":
//		window.open(ME2DAY, "me2dayWindow",  'width=960,height=500,directories=0,resizable=1,menubar=0,status=0,toolbar=0,scrollbars=1');
//		break;
//	}
//}


function addLoadEvent(func){
	var oldonload = window.onload;
	if (typeof window.onload != 'function'){
		window.onload = func;
	}else{
		window.onload = function(){
			oldonload();
			func();
		}
	}
} //실행 함수
addLoadEvent(init);
addLoadEvent(sideTab);

//addLoadEvent(slideAction);
//addLoadEvent(slideAction2);

/**
 * 콤마생성
 * str
 * maxLength : 최고 길이
 */
function addComma(str,maxLength) {
	
	var TemNum = '' + str;
	do {
	 TemNum = TemNum.replace(',','');
	} while(TemNum.match(','));
	
	if(maxLength != null){
		TemNum = TemNum.substring(0, maxLength);
	}
	if (isNaN(TemNum) ) {
		//viewAlert("숫자만 입력 하세요","");
		TemNum  = '';
		return TemNum;
	}else {
		var sSplit = new RegExp('([0-9])([0-9][0-9][0-9][,.])');
		var aNumber = TemNum.split('.');
		aNumber[0] += '.';
		do {
			aNumber[0] = aNumber[0].replace(sSplit, '$1,$2');
		} while (sSplit.test(aNumber[0]));
		if (aNumber.length > 1) {
			TemNum = aNumber.join('');
		}
		else {
			TemNum = aNumber[0].split('.')[0];
		}
		return TemNum;
	}
}

/**
 * remove Comma
 */	
function removeComma(value){
	var num = value.split(',');
	var result ='';
	for(var i = 0; i<num.length;i++){
		result += num[i];
	}
	return result;
}