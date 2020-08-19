(function($){

$.fn.subPageTop = function(){
	var container = $("#container");
	var box = $(this);
	var sgnb = box.find("> nav ul");
	var boxLi = sgnb.children();
	var top = sgnb.children(".top");
	var depA = sgnb.find(".dep > a");
	var depAA = depA.next().find("a");

	$(window).scroll(function(){
		if( $(window).scrollTop() > 116 ){
			container.addClass("on");
			box.addClass("on");
			top.addClass("on");
		}else{
			container.removeClass("on");
			box.removeClass("on");
			top.removeClass("on");
		}
	}).scroll();

	top.click(function(e){
		e.preventDefault();
		$("html,body").stop().animate({"scrollTop": 0}, 800);
	});
	
	depA.click(function(e){
		e.preventDefault();
		var t = $(this);
		t.toggleClass("on");
		t.next().toggle();
	});

}

})(jQuery);

$(function(){
	$("#s_visual").subPageTop();
	$("#container").css("height", $("#container").height());
});