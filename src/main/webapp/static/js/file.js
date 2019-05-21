//对于文件夹 lable为文件夹名 filetype=0
//对于文件 lable为md5 filetype=1
//安全可选: 交提下载请求后 应判断md5和文件名是否为该用户
$(document).ready(function(){
    // file 逻辑
    var file_num = 16; //显示的文件数
    var check_file_arr = new Array();

    ///
    /// 表格列单击 只会增加check数量
    ///
    $(".file_tr").click(function(){
        var checkbox = $(this).find("td")[0];
        checkbox = $(checkbox).find("input");
        $(checkbox).only_select();
        var select_file_num = $(":checked[id!='all_file']").length;
        if (select_file_num < file_num) {
            $.set_elemt_check($("#all_file"),false);
        }
        btn_group_display();
    });
    ///
    /// 除了全选之外的所有checkbox被单击
    ///
    $(":checkbox").click(function(e){
        if ($(this).get_checked()){
            $(this).set_checked(false);
        } else{
            $(this).set_checked(true);
        }
        var select_file_num = $(":checked[id!='all_file']").length;
        if (select_file_num == file_num) {
            $.set_elemt_check($("#all_file"),true);
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
    ///
    /// 扩大checkbox的点击范围
    ///
    $(".checkbox_div").click(function(e){
        $($(this).find("input")).trigger('click');
        e.stopPropagation();
    });
});
function div_disable(elemt){
    elemt.fadeOut(100);
}
function div_able(elemt){
    elemt.fadeIn(100);
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
    // 文件夹不能下载
    var b=1;
    $.each($(":checked"),function (i,item) {
        if(($(item).parent().parent().parent().attr("type")) == 1){
            $("#btn_download").attr('disabled',true);
            b=0;
            return false;
        }
    });
    if (b==1) {
        $("#btn_download").attr('disabled',false);
    }
}