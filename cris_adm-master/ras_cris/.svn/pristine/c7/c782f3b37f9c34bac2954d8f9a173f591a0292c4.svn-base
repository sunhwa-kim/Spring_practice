(function($){


// 중앙 비쥬얼 슬라이드
$.fn.visualSlide = function(){
	var box = $(this);
	var pic = box.find(".pic");
	var picDiv = pic.find("div");
	var btn = box.find(".btn a");
	var width = picDiv.width();
	var length = picDiv.length;

	pic.prepend(picDiv.clone());
	pic.append(picDiv.clone());

	pic.css("width", width*length * 3);

	
	function defaults(){
		pic.css("margin-left", -(width*length));
	}
	defaults();

	btn.click(function(e){
		if(pic.is(":animated")) return false;

		if(this.className == "next"){
			pic.stop().animate({"margin-left": "-=" + width + "px"}, 1000, "easeInOutCubic", function(){
				pic.children().first().appendTo(pic);
				defaults();
			});
		}else if(this.className == "prev"){
			pic.stop().animate({"margin-left": "+=" + width + "px"}, 1000, "easeInOutCubic", function(){
				pic.children().last().prependTo(pic);
				defaults();
			});
		}

		e.preventDefault();
	});
	
}

// 소개 배너
$.fn.fadeInBanner = function(){
	var box = $(this);
	var img = box.find(".pic img");
	var btn = box.find(".btn");
	img.each(function(){
		btn.append("<a href=''></a>");
	});
	var btnA = btn.find("a");
	btnA.eq(0).addClass("on");

	btnA.click(function(e){
		if(this.className == "on"){return false;}
		e.preventDefault();

		var i = $(this).index();

		btnA.filter(".on").removeClass("on");
		$(this).addClass("on");
		
		img.filter(":visible").fadeOut(300);
		img.eq(i).fadeIn(300);
	});
}


// 포토갤러리
$.fn.slideGallery = function(){
	var box = $(this);	
	var pic = box.find(".pic");
	var img = pic.find("img");
	var btn = box.find(".btn a");
	var txt = box.find(".txt");
	var num = 0;

	txt.eq(num).show().css("bottom","0");
	btn.click(function(e){		
		if(img.is(":animated")) return false;
		e.preventDefault();
		
		txt.eq(num).stop().animate({"bottom":"-53px"}, 300, function(){
			$(this).hide();
		});

		if(this.className == "next"){
			img.eq(num).stop().animate({"left":"-100%"}, 300, function(){
				$(this).hide().css("left", "100%");
			});

			num++
			if(num >= img.length){num = 0;}
			img.eq(num).show().stop().animate({"left":0}, 300);
		}else if(this.className == "prev"){
			img.eq(num).stop().animate({"left":"100%"}, 300, function(){
				$(this).hide();
			});

			num--;
			if(num < 0){num = img.length-1;}
			img.eq(num).show().css("left","-100%").stop().animate({"left":0}, 300);
		}

		txt.eq(num).show().stop().animate({"bottom":0}, 300);

	});
}


// 공지, 자료실
$.fn.listTwoTab = function(){
	var wrap = $(this);
	var h3 = wrap.find("h3");
	var h3A = h3.children();
	var box = wrap.find(".box");

	h3A.click(function(e){
		e.preventDefault();
		if( $(this).children().attr("src").indexOf("_on") >= 0 ) return false;

		$(this).children().attr("src",$(this).children().attr("src").replace(".png","_on.png"));
		$(this).parent().siblings().find("img").attr("src",$(this).parent().siblings().find("img").attr("src").replace("_on.png",".png"));

		var i = $(this).parent().index();

		box.filter(".on").removeClass("on").siblings(".box").addClass("on");

	});
}



})(jQuery);

$(function(){
	//$("#x_visual").visualSlide();
    //$("#x_soge").fadeInBanner();
	//$("#x_gallery").slideGallery();
    //$("#x_gong").listTwoTab();
});