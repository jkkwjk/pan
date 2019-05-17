$(document).ready(function(){
    //动画
    var timer = null;
    $("#user_name_group").mouseenter(function(){
        var elemt = $("#user_name_animation_nomal");
        clearTimeout(timer);
        elemt.stop(true);
        elemt.css('display','inline');
        elemt.animate({'opacity':'1'},{queue:false,duration:200});
        elemt.animate({'margin-top':'0px'},{queue:false,duration:200});

    });
    $("#user_name_group").mouseleave(function(){
        var elemt = $("#user_name_animation_nomal");
        elemt.stop(true);
        elemt.animate({'margin-top':'-10px'},{queue:false,duration:200});
        elemt.animate({'opacity':'0'},{queue:false,duration:200});
        timer = setTimeout("$(\"#user_name_animation_nomal\").css('display','none')",200);
    });
});