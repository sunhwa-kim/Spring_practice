(function($){

$.fn.footerBarogagi = function(){
	var wrap = $(this);
	var baro = wrap.find(".baro");
	var list = baro.find(".list");
	var btn = baro.find(".btn");
	btn.click(function(e){
		e.preventDefault();
		if( list.is(":hidden") ){
			$(this).children().attr("src",$(this).children().attr("src").replace(".png","_on.png"));
			list.show();
		}else{
			$(this).children().attr("src",$(this).children().attr("src").replace("_on.png",".png"));
			list.hide();
		}		
	});
}

})(jQuery);

$(function(){
	$("#footer").footerBarogagi();
});