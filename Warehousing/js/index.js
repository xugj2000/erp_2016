/**
 * Copyright Cc 2007 chinavisual.com
 *  manage design's indexpage
 * @author: purpen(www.chinavisual.com)
 */
$(function () {

    //$('#News_toparea ul').tabs();  
    //$('#Newsa_toparea').tabs();  
    //$('#Newsb_toparea').tabs();  
    $(".l_bg02").click(function () {
        $(".l_bg02").find("a").removeClass("ui-tscure")
        $(".l_bg02").not(this).next().hide();
        if ($(this).next().css("display") == "none") {
            $(this).next().show();
        }
        else {
            $(this).next().hide();
        }
        $(this).find("a").addClass("ui-tscure");

    })
});	
