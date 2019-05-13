//对于文件夹 lable为文件夹名 filetype=0
//对于文件 lable为md5 filetype=1
//安全可选: 交提下载请求后 应判断md5和文件名是否为该用户
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
    /// 表格列单击 只会增加check数量
    ///
    $(".file_tr").click(function(){
        var checkbox = $(this).find("td")[0];
        checkbox = $(checkbox).find("input");
        $(checkbox).set_checked(true);
        var select_file_num = $(":checked[id!='all_file']").length;
        if (select_file_num == file_num) {
            $.set_elemt_check($("#all_file"),true);
        }
        btn_group_display();
    });
    ///
    /// 除了全选之外的所有checkbox被单击
    ///
    $(":checkbox").click(function(e){
        if ($(this).get_checked()) { //减少check
            $(this).set_checked(false);
            var select_file_num = $(":checked[id!='all_file']").length;
            if (select_file_num < file_num) {
                $.set_elemt_check($("#all_file"),false);
            }
        }else { //增加或减少check
            $(this).only_select();
        }
        btn_group_display();
        e.stopPropagation();
    });
    $("#all_file").unbind("click");
    ///
    /// 全选被单击
    ///
    $("#all_file").bind("click",function(){
        if ($(this).get_checked()) { //check为0
            $(this).uncheck_all();
        } else { //check增加(没文件可能为0)
            $(this).check_all();
        }
        btn_group_display();
    });
    ///
    /// 文件链接被单击
    ///
    $(".a_file_name").click(function(){
        //文件夹 则打开
        //文件 则下载
        return false;
    });
});
function div_disable(elemt){
    elemt.css('display','none');
}
function div_able(elemt){
    elemt.css('display','inline-block');
}
function btn_group_display(){
    var num = $.check_num();
    if(num > 0){
        div_able($("#btn_group"));
    } else{
        div_disable($("#btn_group"));
    }
    if(num == 1){
        $("#btn_share").attr('disabled',false);
        $("#btn_rename").attr('disabled',false);
    }else {
        $("#btn_share").attr('disabled',true);
        $("#btn_rename").attr('disabled',true);
    }
}