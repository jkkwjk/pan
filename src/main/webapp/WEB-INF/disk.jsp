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
        var folder_id_now = 1; // 当前页面所属用户的文件夹
        var has_next = 1; // 用户是否还有文件
        var isloding = false; // 是否正在加载,只针对get_file_next有效
        var template="<tr class=\"file_tr\" id=\"{rs_id}\" type={file_type}><td class=\"file_left\"><div class=\"checkbox_div\"><input type=\"checkbox\"></div><img src=\""+base_path+"/static/img/file/file_ico/{file_ico}.png\" class=\"file_img\"><a href=\"#\" class=\"a_file_name\"><span class=\"file_name\">{file_name}</span></a></td><td class=\"file_mid\">{file_size}</td><td class=\"file_right\">{file_time}</td></tr>\n";
        var true_url = "${pageContext.request.scheme}${'://'}${pageContext.request.serverName}${':'}${pageContext.request.serverPort}${pageContext.request.contextPath}";
    </script> <!-- 全局变量 -->
    <script type="text/javascript">
        $(document).ready(function () {
            var nScrollHight;
            var nScrollTop;
            var nDivHight=$("#file_main").height();
            $("#file_main").on('scroll',function () {
                nScrollHight = $(this)[0].scrollHeight;
                nScrollTop = $(this)[0].scrollTop;
                if(nScrollTop + nDivHight >= nScrollHight-40){
                    get_next_file(file_start,folder_id_now);
                }
            });
        });
    </script> <!-- 分页查询 -->
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
                    rename_checked=$($(":checked[id!='all_file']")[0]).parent().parent();
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
                                    if (data.status==200){
                                        tip_show("重命名成功","success");
                                        cleanPage();
                                        get_next_file(file_start,folder_id_now);
                                    } else {
                                        tip_show(data.msg,"danger");
                                    }
                                }
                            });
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

                $.each($(":checked[id!='all_file']").parent().parent().parent(),function (x,i) {
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
    </script> <!-- 文件上传 -->
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btn_share").click(function () {
                var obj = $($("input:checked[id!='all_file']").parent().parent().parent()[0]);
                var type = obj.attr('type');
                var id = obj.attr('id');
                if (obj.attr('type')==1){
                    $.post(base_path+"/share",{'id':id,'type':type},function (data) {
                        if (data.status==200) {
                            $("#share_url").text("分享链接: "+true_url+'/share?type=1&url='+data.url);
                            $("#shareModal").modal();
                        } else if(data.status==202){
                            $("#share_url").text("分享已存在! 分享链接: "+true_url+'/share?type=1&url='+data.url);
                            $("#shareModal").modal();
                        } else {
                            tip_show(data.error_msg,'danger');
                        }
                    },'json');
                }else {
                    alert("暂不支持文件夹分享");
                }
            });

            // 分享按钮事件
            $("#btn_open_url").click(function () {
                var obj = $($("input:checked[id!='all_file']").parent().parent().parent()[0]);
                var url = obj.attr('url');
                var type = obj.attr('type');
                window.open(true_url+'/share?type='+type+'&url='+url);
            });
            $("#btn_ban_share").click(function () {
                var obj = $($("input:checked[id!='all_file']").parent().parent().parent()[0]);
                var url = obj.attr('url');
                var type = obj.attr('type');
                $.post(base_path+'/share/del',{'url':url,'type':type},function (data) {
                    if (data.status == 200){
                        tip_show("删除分享成功","success");
                        cleanPage();
                        get_share_file();
                    } else {
                        tip_show(data.error_msg,"danger");
                    }
                },'json');
            });
            $("#btn_re_share").click(function () {
                var obj = $($("input:checked[id!='all_file']").parent().parent().parent()[0]);
                var rsid = obj.attr('id');
                var type = obj.attr('type');
                $.post(base_path+'/share',{'id':rsid,'type':type},function (data) {
                    if(data.status==202){
                        tip_show("重新分享成功","success");
                        cleanPage();
                        get_share_file();
                    }else {
                        tip_show("重新分享失败","danger");
                    }
                },'json');
            });
        });
    </script> <!-- 文件分享 -->
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btn_download").click(function () {
                $.each($(":checked[id!='all_file']").parent().parent().parent(),function (x,i) {
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
            $(".btn_search").click(function () {
                cleanPage();
                start_search("搜索到的文件");
                $("#left_list_active").attr('id',''); //左边列表没有选中的对象
                search_file($("#search_val").val());
            });
            $(".a_left").click(function () {
                $("#left_list_active").attr('id','');
                $(this).attr('id','left_list_active');

                $("#not_share_display").css('display','inline-block');
                $("#share_display").css('display','none');

                var reg = $(this).find('li').attr('reg');
                var action = $(this).find('li').attr('action');
                if (reg != null && reg!= ""){
                    cleanPage();
                    start_search($(this).find('li').text()+"文件");
                    $.get(base_path+'/file/search',{'name':reg},function (data) {
                        $.each(data.data,function (i,item) {
                            parse_file(item);
                        });
                        file_num += parseInt(data.file_num);
                        $("#file_num").text(file_num);
                    },'json');
                } else {
                    switch (action) {
                        case "all":
                            stop_search(1,"全部文件");
                            get_next_file(file_start,folder_id_now);
                            break;
                        case "share":
                            cleanPage();
                            start_search("我的分享");
                            $("#not_share_display").css('display','none');
                            $("#share_display").css('display','inline-block');

                            get_share_file();
                            break;
                    }
                }
                return false;
            });
        });
    </script> <!-- 搜索以及左列表框事件处理 -->
    <script type="text/javascript">
        $(document).ready(function () {
            get_next_file(file_start,folder_id_now);
            $("#form_search").css('display','inline');

            $($("#ul_title").find("li")[0]).addClass('title_active');

            // 获取总容量
            $.post(base_path+"/file/c",function (data) {
                $("#span_used_capacity").text(data.used);
                $("#span_all_capacity").text(data.max);
                $("#vol").css('width',data.scale+'%');
            },'json');
        });
    </script><!-- 初始化页面 -->
</head>
<body>
    <div id="warp" style="min-width: 1000px;user-select: none;">
        <%@include file="/WEB-INF/template/title.jsp"%>
        <div id="main">
            <div id="main_left" style="position: relative;">
                <ul class="ul_my">
                    <a href="#" class="a_left" style="margin-top: 10px;" id="left_list_active"> <!--bug可能-->
                        <li class="li_left" action="all">
                            <span class="glyphicon glyphicon-folder-open" id="glyphicon_li_left"></span> <!--图标-->
                            全部文件
                        </li>
                    </a>
                    <a href="#" class="a_left"><li class="li_left" reg=".*.(jpg|png|gif)">图片</li></a>
                    <a href="#" class="a_left"><li class="li_left" reg=".*.(mp4|avi|mpg|mov|flv)">视频</li></a>
                    <a href="#" class="a_left"><li class="li_left" reg=".*.(mp3|wma|wav)">音乐</li></a>
                    <a href="#" class="a_left"><li class="li_left" reg=".*.pdf">文档</li></a>
                    <a href="#" class="a_left"><li class="li_left" reg=".*.(doc|docx|ppt|xls|xlsx)">办公</li></a>
                    <a href="#" class="a_left">
                        <li class="li_left" action="share">
                            <span class="glyphicon glyphicon-paperclip" id="glyphicon_li_left"></span>
                            我的分享
                        </li>
                    </a>
                </ul>
                <div id="left_bottom">
                    <div id="left_process_bar">
                        <div class="progress" style="height: 5px;">
                            <!-- 进度条填充 -->
                            <div class="progress-bar" style="width: 60%;" id="vol"></div>
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
                    <div id="search_display" style="display: inline-block;">
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
                    </div>
                    <div id="not_share_display" style="display: inline-block;">
                        <div class="btn-group button_main_main_top btn_group" id="btn_group" style="display: none;">
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
                    <div id="share_display" style="display: none;">
                        <div class="btn-group button_main_main_top btn_group" id="btn_group" style="display: none;">
                            <button id="btn_open_url" type="button" class="btn btn-default button_main_main_top">
                                <span class="glyphicon glyphicon-eye-open" style="margin-right: 2px;"></span>打开链接
                            </button>
                            <button id="btn_re_share" type="button" class="btn btn-default button_main_main_top">
                                <span class="glyphicon glyphicon-tags" style="margin-right: 2px;"></span>
                                重新分享
                            </button>
                            <button id="btn_ban_share" type="button" class="btn btn-default button_main_main_top">
                                <span class="glyphicon glyphicon-ban-circle" style="margin-right: 2px;"></span>
                                取消分享
                            </button>
                        </div>
                    </div>
                </div>

                <div style="padding-right: 20px;padding-left: 20px;">
                    <ol class="breadcrumb" id="ol_leader">
                        <li fid="1">全部文件</li>
                    </ol>
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
        <%@ include file="/WEB-INF/template/tip_show.jsp"%>
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
        <!-- 分享成功返回窗口 -->
        <div class="modal fade" id="shareModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" style="max-width: 600px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">分享成功 √ (于15天之后到期)</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="share_url" style="user-select: text;">

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>