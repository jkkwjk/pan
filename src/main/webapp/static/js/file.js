//对于文件夹 lable为文件夹名 filetype=0
//对于文件 lable为md5 filetype=1
//安全可选: 交提下载请求后 应判断md5和文件名是否为该用户
$(document).ready(function(){
    $(document).on("click","#ol_leader>li>a",ol_leader_click);
    function ol_leader_click() {
        var obj = $(this).parent();
        obj.nextAll().remove();

        obj.html($(this).text());

        folder_id_now = obj.attr('fid');

        cleanPage();
        get_next_file(file_start,folder_id_now);

        return false;
    };
    ///
    /// 表格列单击 只会增加check数量
    ///
    $(document).on("click",".file_tr",file_tr_click);
    function file_tr_click(){
        var checkbox = $(this).find("td")[0];
        checkbox = $(checkbox).find("input");
        $(checkbox).only_select();
        btn_group_display();
    }
    ///
    /// 除了全选之外的所有checkbox被单击
    ///
    $(document).on("click",":checkbox",checkbox_checked_click);
    function checkbox_checked_click(e){
        if ($(this).get_checked()){
            $(this).set_checked(false);
        } else{
            $(this).set_checked(true);
        }
        btn_group_display();
        e.stopPropagation();
    }
    $("#all_file").unbind("click");
    ///
    /// 全选被单击
    ///
    $("#all_file").bind("click",function(){
        if (file_num==0){
            return false;
        }
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
    $(document).on("click",".a_file_name",a_file_name_click);
    function a_file_name_click(){
        var obj = $(this).parent().parent();

        if(obj.attr('type') == '1') {
            var rsid = obj.attr('id');
            var url = base_path+'/file/down?rsid='+rsid;
            window.location.href=url
        }else {
            folder_id_now = obj.attr('id');
            var name = obj.find('.file_name').text();
            $("#ol_leader").append("<li fid=\""+folder_id_now+"\">"+name+"</li>");
            // 对倒数第二个对象可点击处理
            var add_click_obj = $("#ol_leader>li").eq(-2);
            add_click_obj.html("<a href='#'>"+ add_click_obj.html() +"</a>");

            cleanPage();
            get_next_file(file_start,folder_id_now);
        }
        return false;
    }
    ///
    /// 扩大checkbox的点击范围
    ///
    $(document).on("click",".checkbox_div",checkbox_div_click);
    function checkbox_div_click(e){
        $($(this).find("input")).trigger('click');
        e.stopPropagation();
    }
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
        div_able($(".btn_group"));
    } else{
        div_disable($(".btn_group"));
    }

    if(num == 1){
        $("#btn_share").attr('disabled',false);
        $("#btn_rename").attr('disabled',false);
    }else {
        $("#btn_share").attr('disabled',true);
        $("#btn_rename").attr('disabled',true);
    }
    if (num == file_num) {
        $.set_elemt_check($("#all_file"),true);
    } else if (num  < file_num) {
        $.set_elemt_check($("#all_file"),false);
    }

    // 分享按钮行为
    if (num == 1){
        $("#btn_ban_share").attr('disabled',false);
        $("#btn_open_url").attr('disabled',false);
        $("#btn_re_share").attr('disabled',false);
    } else {
        $("#btn_ban_share").attr('disabled',true);
        $("#btn_open_url").attr('disabled',true);
        $("#btn_re_share").attr('disabled',true);
    }
    // 过期文件不能打开链接
    var guoqi_obj = $($($("input:checked[id!='all_file']").parent().parent().parent()[0]).find("#guoqi")[0]);
    if (guoqi_obj.text() != ''){
        $("#btn_open_url").attr('disabled',true);
    }
    // 文件夹不能下载
    var b=1;
    $.each($(":checked"),function (i,item) {
        if(($(item).parent().parent().parent().attr("type")) == 0){
            $("#btn_download").attr('disabled',true);
            b=0;
            return false;
        }
    });
    if (b==1) {
        $("#btn_download").attr('disabled',false);
    }
}