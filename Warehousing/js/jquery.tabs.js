$(function(){
	$("div.div_btn").click(function(){
		var sta = $("div.left").css("display");
		if(sta != "none")
		{
			$("div.left").hide();
			$(this).find("span").attr("class","open");
			$("div.right").css("width","98.2%");
			$("div.right_left").css("width","64%");
		}
		else { $("div.left").show();$(this).find("span").attr("class","close");$("div.right").css("width","83.2%");$("div.right_left").css("width","55%");}
	});
	$("div.t_con ul li").click(function(){
		$(this).addClass("click").siblings().removeClass("click");
	});
	$("div.left ul li").click(function(){
		var index = $("div.left ul li").index(this)+1;
		$(this).addClass("hover"+index).siblings().removeAttr("class");
		$(this).siblings().find("img").show();
		$(this).find("img").hide();
	})
})


$(function(){
	$("div.div_btn2").click(function(){
		var sta = $("div.left").css("display");
		if(sta != "none")
		{
			$("div.left").hide();
			$(this).find("span").attr("class","open");
			$("div.right").css("width","98.4%");
			$("div.right_left").css("width","64%");
		}
		else { $("div.left").show();$(this).find("span").attr("class","close");$("div.right").css("width","83.3%");$("div.right_left").css("width","55%");}
	});
	$("div.t_con ul li").click(function(){
		$(this).addClass("click").siblings().removeClass("click");
	});
	$("div.left ul li").click(function(){
		var index = $("div.left ul li").index(this)+1;
		$(this).addClass("hover"+index).siblings().removeAttr("class");
		$(this).siblings().find("img").show();
		$(this).find("img").hide();
	})
})