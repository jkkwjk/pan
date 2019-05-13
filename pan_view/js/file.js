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
    // file 逻辑
    var file_num = 3; //显示的文件数
    var check_file_arr = new Array();

    ///
    /// 表格列单击
    ///
    $(".file_tr").click(function(){
        var checkbox = $(this).find("td")[0];
        checkbox = $(checkbox).find("input");
        $(checkbox).set_checked(true);
        var select_file_num = $(":checked[id!='all_file']").length;
        if (select_file_num == file_num) {
            $.set_elemt_check($("#all_file"),true);
        }
    });
    ///
    /// 除了全选之外的所有checkbox被单击
    ///
    $(":checkbox").click(function(e){
        if ($(this).get_checked()) {
            $(this).set_checked(false);
            var select_file_num = $(":checked[id!='all_file']").length;
            if (select_file_num < file_num) {
                $.set_elemt_check($("#all_file"),false);
            }
        }else {
            $(this).only_select();
        }
        e.stopPropagation();
    });
    $("#all_file").unbind("click");
    ///
    /// 全选被单击
    ///
    $("#all_file").bind("click",function(){
        if ($(this).get_checked()) {
            $(this).uncheck_all();
        } else {
            $(this).check_all();
        }
    });
});