(function($){


	
$.fn.gnbMenu = function(){
	var gnb = $(this);
	var gnbPage = gnb.children().children();
	var gnbLi = gnbPage.children();
	var gnbLiA = gnbLi.children();
	var sub = gnbLiA.next();

	gnbLi.eq(pn-1).children().addClass("on");

	gnbLi.on("mouseenter focus", function(e){
		e.preventDefault();
		var t = $(this);

		gnbLiA.removeClass("on");
		t.children().addClass("on");

		sub.hide();
		t.children(".sub").show();
	});

	gnb.on("mouseleave", function(){	
		
		if(page_idx != -1){
			gnbLiA.removeClass("on");
			gnbLi.eq(page_idx).children().addClass("on");
			sub.hide();
			gnbLi.eq(page_idx).children(".sub").show();
			
		}else{
			gnbLiA.removeClass("on");
			sub.hide();
			gnbLi.eq(pn-1).children().addClass("on");
		}
	});

	if(page_idx != -1){
		gnbLiA.removeClass("on");
		gnbLi.eq(page_idx).children().addClass("on");
		sub.hide();
		gnbLi.eq(page_idx).children(".sub").show();
		
	}

}

})(jQuery);

var page_idx = -1;

$(function(){
	var path = location.pathname;
	if( path.indexOf('index.do') != -1 || path.indexOf('siteMap.do') != -1 || path.indexOf('myPageView.do') != -1 ){
		page_idx = -1;
	}else{
		page_idx =  $('input[name=selYn][value=true]').parent().parent().parent().index();
	}

	$("#gnb").gnbMenu();
});