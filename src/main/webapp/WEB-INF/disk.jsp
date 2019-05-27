<!-- 页面复用: 左列表 顶部列表 设置active即可 -->
<%@ page import="com.jkk.service.AttrToken" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/default.css"> <!--link_tag -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/file.css"> <!--link_tag -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/title.css"> <!--link_tag -->

    <title>在线网盘-全部文件</title>
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery-checkbox-set.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/md5.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/title.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/file.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/static/js/file-fn.js"></script>
    <script type="text/javascript">
        var file_num = 0; //显示的文件数
        var file_start = 0; // 文件从哪开始找 分页
        var base_path= "${pageContext.request.contextPath}";
        var folder_id_now = 0; // 当前页面所属用户的文件夹
        var has_next = 1; // 用户是否还有文件
        var template="<tr class=\"file_tr\" id=\"{rs_id}\" type={file_type}><td class=\"file_left\"><div class=\"checkbox_div\"><input type=\"checkbox\"></div><img src=\""+base_path+"/static/img/file/file_ico/{file_ico}.png\" class=\"file_img\"><a href=\"#\" class=\"a_file_name\"><span class=\"file_name\">{file_name}</span></a></td><td class=\"file_mid\">{file_size}</td><td class=\"file_right\">{file_time}</td></tr>\n";
    </script> <!-- 全局变量 -->

    <script type="text/javascript">
        $(document).ready(function () {
            var title;
            var r;
            var rename_checked;
            $('#tipModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget);
                title = button.data('title');
                var placeholder = button.data('placeholder');
                var spant = button.data('spant');
                r = button.data('r');

                var modal = $(this);
                var modal_title = modal.find('.modal-title');
                var modal_input = modal.find('.modal-body input');
                var modal_span = modal.find('#modal_span');

                modal_title.text("");
                modal_input.attr('placeholder',"");
                modal_input.val('');
                modal_span.text("");

                if(r=='rename'){
                    // 重命名默认打开就有文件名在input中
                    rename_checked=$($(":checked")[0]).parent().parent();
                    modal_input.val(rename_checked.find('.file_name').text());
                }

                modal_title.text(title);
                modal_input.attr('placeholder',placeholder);
                modal_span.text(spant);

            });
            $('#tipModal').find("#modal_btn").click(function () {
                var val = $('#tipModal').find(".modal-body input").val();
                if (val=="" || val==null){
                    tip_show(title+"不能为空","danger");
                } else {
                    switch (r) {
                        case "new":
                            $.get(base_path+"/file/c",{'r':r,'val':val,'now':folder_id_now},function (data) {
                                if (data.status==200){
                                    tip_show("新建成功","success");
                                    cleanPage();
                                    get_next_file(file_start,folder_id_now);
                                }else {
                                    tip_show(data.msg,"danger");
                                }

                            },"json");
                            break;
                        case "rename":
                            var t=rename_checked.parent().attr('type');
                            var id=rename_checked.parent().attr('id');
                            var rename_val = [id,val];
                            $.ajax({
                                type:'GET',
                                traditional:true,
                                url:base_path+"/file/c",
                                data:{'r':r,'val':rename_val,'t':t,'now':folder_id_now},
                                dataType:'json',
                                success: function (data) {

                                }
                            })
                            break;
                    }
                }
            });


            var willDel = [];
            $('#yesnoModal').on('show.bs.modal', function (event) {
                willDel = new Array();
                var button = $(event.relatedTarget);
                var modal = $(this);
                var spant = modal.find('#spant');

                $.each($(":checked").parent().parent().parent(),function (x,i) {
                    var id = $(i).attr('id');
                    var type = $(i).attr('type');
                    willDel.push(base_path+"/file/c?r=del&t="+type+"&val="+id);
                });
                $(spant).text(willDel.length);
            });
            $("#modal_confim").click(function () {
                (function delRun(index) {
                    $.get(willDel[index],function () {
                        if (++index < willDel.length){
                            delRun(index);
                        } else {
                            tip_show("删除成功","success");
                            cleanPage();
                            get_next_file(file_start,folder_id_now);
                        }
                    })
                })(0);
            });

        });
    </script> <!-- 模态框处理 -->
    <script type="text/javascript">
        $(document).ready(function () {
            $("#upload_file").click(function () {
                $("#upload_file_btn").click();
                $(this).parent().parent().removeClass('open');
                return false;
            });
            $("#upload_file_btn").change(function (e) {
                if($(this).val() != ""){
                    var f = $(this)[0].files[0];
                    if (f.size > 100*1024*1024) {
                        tip_show("单次上传大小不能超过100MB!",'danger');
                    }else {
                        upload_step1(f);
                    }
                }
            })

        });

        function file_upload_submit(f,md5){
            var formData = new FormData();
            formData.append('file',f);
            formData.append('md5',md5);
            formData.append('folder',folder_id_now);
            $.ajax({
                type:'POST',
                url:base_path+'/file/up',
                data:formData,
                contentType: false,
                processData: false,
                beforeSend: function(){
                    $("#tip_span").text("正在上传,请稍后.....");
                    $("#alert_div").attr('class','alert alert-info');
                    my_show();
                },
                success: function (ret) {
                    ret = JSON.parse(ret);
                    if(ret.status == '1') {
                        cleanPage();
                        get_next_file(file_start,folder_id_now);
                        tip_show("上传成功!",'success');
                    }else {
                        tip_show(ret.error_msg,'danger');
                    }
                    $("#upload_file_btn").val("");
                },
                error: function () {
                    tip_show("未知错误","danger");
                }
            });
        }
    </script><!-- 文件上传 -->
    <script type="text/javascript">
        var timer = null;
        function tip_show(s,wclass) {
            $("#tip_span").text(s);
            // success绿色 info蓝色 danger红色
            $("#alert_div").attr('class','alert alert-'+wclass);
            my_show();
            setTimeout("my_hide();",1000);
        }
        function my_show(){
            var elemt = $("#tip");
            clearTimeout(timer);
            elemt.stop(true);
            elemt.css('display','inline');
            elemt.css('margin-top','0px');
            elemt.css('opacity','1');
        }
        function my_hide(){
            var elemt = $("#tip");
            elemt.stop(true);
            elemt.animate({'margin-top':'30px'},{queue:false,duration:400});
            elemt.animate({'opacity':'0'},{queue:false,duration:400});
            timer = setTimeout("$(\"#tip\").css('display','none')",400);
        }
    </script> <!-- 动画 -->
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btn_download").click(function () {
                $.each($(":checked").parent().parent().parent(),function (x,i) {
                    var rsid = $(i).attr('id');
                    var url = base_path+'/file/down?rsid='+rsid;
                    createIFrame(url, 100, 10000);
                });
                // 没有好的办法了...
                function createIFrame(url, triggerDelay, removeDelay) {
                    setTimeout(function() {
                        var frame = $('<iframe style="display: none;" class="multi-download"></iframe>');
                        frame.attr('src', url);
                        $(document.body).after(frame);
                        setTimeout(function() {
                            frame.remove();
                        }, removeDelay);
                    }, triggerDelay);
                }
            });
        })
    </script> <!-- 批量下载 -->
    <script type="text/javascript">
        $(document).ready(function () {
            get_next_file(file_start,folder_id_now);
        });
    </script><!-- 初始化页面 -->
</head>
<body>
    <div id="warp" style="min-width: 1100px;user-select: none;">
        <div id="title">
            <div id="title_left" style="background-image: url(${pageContext.request.contextPath}/static/img/file/logo.png);"></div>
            <div id="title_main">
                <ul class="ul_my" id="ul_title">
                    <li class="li_float_left li_title title_active" style="margin-left: 10px;">
                        <a href="#" class="a_block">文件</a>
                    </li>
                    <li class="li_float_left li_title">
                        <a href="#" class="a_block">分享</a>
                    </li>
                </ul>
                <div id="title_right">
                    <div id="user_name_group">
                        <img src="${pageContext.request.contextPath}/static/img/user/default.jpg" id="user_name_img">
                        <div id="user_name">用户名</div>
                        <span class="glyphicon glyphicon-chevron-down" style="margin-right: 20px;"></span><!--向下箭头-->
                        
                        <div id="user_name_animation_nomal"><!--隐藏动画-->
                            <div id="user_name_animation_top" style="background-image: url(${pageContext.request.contextPath}/static/img/file/user-level-bg-0.png);"><!--顶部-->
                                <div id="user_name_animation_top_img_bg">
                                    <img id="user_name_animation_top_img" src="${pageContext.request.contextPath}/static/img/user/default.jpg">
                                </div>
                                <span id="user_name_animation_top_username">用户名</span>
                            </div>

                            <div id="user_name_animation_main">
                                <ul class="ul_my">
                                    <a href="#" class="a_user_name_animation"><li>个人资料</li></a>
                                    <!-- 无二级密码跳设置 有跳修改密码-->
                                    <a href="#" class="a_user_name_animation"><li>二级密码</li></a>
                                    <a href="#" class="a_user_name_animation"><li>退出</li></a>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <input type="text" class="form-control" placeholder="搜索文件" aria-describedby="basic-addon1" style="display: inline;width: 200px;border-radius: 100px;">
                    <button class="btn_search" style="font-size: 100%;margin-left: -35px;">
                        <span class="glyphicon glyphicon-search" style="margin-left: 5px;font-size: 15px;"></span>
                    </button>
                    
                </div>
            </div>
        </div>
        <div id="main">
            <div id="main_left" style="position: relative;">
                <ul class="ul_my">
                    <a href="#" class="a_left" style="margin-top: 10px;" id="left_list_active"> <!--bug可能-->
                        <li class="li_left">
                            <span class="glyphicon glyphicon-folder-open" id="glyphicon_li_left"></span> <!--图标-->
                            全部文件
                        </li>
                    </a>
                    <a href="#" class="a_left"><li class="li_left">图片</li></a>
                    <a href="#" class="a_left"><li class="li_left">视频</li></a>
                    <a href="#" class="a_left"><li class="li_left">音乐</li></a>
                    <a href="#" class="a_left"><li class="li_left">文档</li></a>
                    <a href="#" class="a_left"><li class="li_left">其他</li></a>
                    <a href="#" class="a_left">
                        <li class="li_left">
                            <span class="glyphicon glyphicon-paperclip" id="glyphicon_li_left"></span>
                            我的分享
                        </li>
                    </a>
                    <a href="#" class="a_left">
                        <li class="li_left">
                            <span class="glyphicon glyphicon-trash" id="glyphicon_li_left"></span>
                            回收站
                        </li>
                    </a>
                </ul>
                <div id="left_bottom">
                    <div id="left_process_bar">
                        <!-- 进度条示例 -->
                        <div class="progress" style="height: 5px;">
                            <!-- 进度条填充 -->
                            <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;"></div>
                        </div>
                    </div>
                    <!-- 后端交互 -->
                    <div style="font-size: 10px;">
                        <span id="span_used_capacity">800MB</span>
                        <span>/</span>
                        <span id="span_all_capacity">1G</span>
                    </div>
                    
                </div>
            </div>
            <div id="main_main">
                <div id="main_main_top">
                    <div class="btn-group">
                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="glyphicon glyphicon-cloud-upload" style="margin-right: 2px;"></span>上传
                        </button>
                        <ul class="dropdown-menu">
                            <li id="upload_file"><a href="#">上传文件</a></li>
                            <li role="separator" class="divider" style="margin: 2px 0;"></li>
                            <li id="upload_folder"><a href="#">上传文件夹</a></li>
                        </ul>
                        <form style="display: none;" id="upload_file_form" enctype="multipart/form-data">
                            <input type="file" name="file" id="upload_file_btn">
                        </form>
                    </div>
                    <button type="button" class="btn btn-light button_main_main_top" data-toggle="modal" data-target="#tipModal"
                            data-title="新建文件夹" data-placeholder="请输入文件夹名字" data-r="new" style="border: 1px #C3EAFF solid;">
                        <span class="glyphicon glyphicon-hdd" style="margin-right: 2px;"></span> 新建文件夹
                    </button>
                    <div class="btn-group button_main_main_top" id="btn_group" style="display: none;">
                        <button id="btn_download" type="button" class="btn btn-default button_main_main_top">
                            <span class="glyphicon glyphicon-cloud-download" style="margin-right: 2px;"></span>下载
                        </button>
                        <button id="btn_share" type="button" class="btn btn-default button_main_main_top">
                            <span class="glyphicon glyphicon-tags" style="margin-right: 2px;"></span>
                            分享
                        </button>
                        <button id="btn_delete" type="button" class="btn btn-default button_main_main_top" data-toggle="modal" data-target="#yesnoModal">删除</button>
                        <button id="btn_rename" type="button" class="btn btn-default button_main_main_top" data-toggle="modal" data-target="#tipModal"
                                data-title="重命名" data-placeholder="请输入名称" data-r="rename">重命名</button>
                    </div>
                </div>

                <div style="padding-right: 20px;padding-left: 20px;">
                    <span>全部文件</span>
                    <div style="float: right">
                        <span>共加载</span>
                        <span id="file_num">0</span>
                        <span>个</span>
                    </div>
                </div>

                <div style="height: 20px;margin-top: 5px;">
                    <div id="filehead_left">
                        <input type="checkbox" id="all_file">
                        <span class="span_file_attr">文件名</span>
                    </div>
                    <div id="filehead_mid">
                        <span class="span_file_attr">大小</span>
                    </div>
                    <div id="filehead_right">
                        <span class="span_file_attr">修改日期</span>
                    </div>
                </div>
                <div id="file_main" style="">
                    <table id="file_table">
                        <%--0代表文件夹--%>
                    </table>
                </div>
            </div>
            
        </div>
        <div id="tip" style="display: none;">
            <div class="alert alert-danger" role="alert" style="font-size:17px;text-align: center;padding: 10px;" id="alert_div">
                <span id="tip_span"></span>
            </div>
        </div>
        <!-- 通用输入框 -->
        <div class="modal fade" id="tipModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <span class="col-form-label" id="modal_span" style="font-size: 15px;"></span>
                        <input type="text" class="form-control" id="input_text" style="margin-top: 10px;">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" id="modal_btn" data-dismiss="modal">确定</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- 确定取消框 -->
        <div class="modal fade" id="yesnoModal" tabindex="-1" role="dialog" aria-labelledby="yesnoModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">删除文件</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        确认删除这
                        <span id="spant"></span>
                        个文件吗
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">我在想想</button>
                        <button type="button" class="btn btn-primary" id="modal_confim" data-dismiss="modal">确认</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>