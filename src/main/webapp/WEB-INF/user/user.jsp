<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/default.css"> <!--link_tag -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/title.css"> <!--link_tag -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/user_info_default.css"> <!--link_tag -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/user_info.css"> <!--link_tag -->

    <title>个人信息</title>
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/title.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery-from.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    <script type="text/javascript">
        var base_path = "${pageContext.request.contextPath}";
        var file = null;
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $($("#ul_title").find("li")[1]).addClass('title_active');

            $($(".list_active")[0]).attr('id','left_list_active');

            $.post(base_path+"/user/get",{'a':'sex'},function (data) {
                $("input[type=radio][name=sex][value="+data+"]").prop('checked',true);
            })
        });
    </script><!-- 页面初始化 -->
    <script type="text/javascript">
        $(document).ready(function () {
            $("#submit_btn").click(function () {
                var form_base = document.querySelector("#info_form"); // 必须用js方法取??
                var up_data = new FormData(form_base);
                if (file!=null){
                    up_data.append('file',file);
                }
                $.ajax({
                    type:'POST',
                    url:base_path+'/user/ud',
                    data:up_data,
                    contentType: false,
                    processData: false,
                    success: function (ret) {
                        ret = JSON.parse(ret);
                        if(ret.status == '1') {
                            tip_show("更新成功!",'success');
                            $.post("${pageContext.request.contextPath}/user/get",{'a':'name'},function (data) {
                                $(".get_user_name").text(data);
                            });
                            $.post("${pageContext.request.contextPath}/user/get",{'a':'img'},function (data) {
                                $(".get_user_img").attr('src','${pageContext.request.contextPath}/static/img/user/'+data);
                            });
                        }else {
                            tip_show(ret.error_msg,'danger');
                        }
                        file = null;
                    },
                    error: function () {
                        tip_show("未知错误","danger");
                    }
                });
            });


        });
    </script><!-- 更新交提 -->
    <script type="text/javascript">
        $(document).ready(function () {
            var imgReader = new FileReader();
            imgReader.onload = function (ev) {
                $("#change_img").attr("src",ev.target.result);
            };

            $("#change_img").click(function () {
                $("#img_file").click();
            });

            $("#img_file").change(function () {
                if($(this).val() != ""){
                    var f = $(this)[0].files[0];
                    if (f.size > 2*1024*1024) {
                        tip_show("图片太大 !",'danger');
                    }else {
                        file = f;
                        imgReader.readAsDataURL(file);
                    }
                }
            });
        });
    </script><!-- file事件转移 -->
</head>
<body>
<div id="warp" style="min-width: 1100px;min-height: 700px;">
    <%@include file="/WEB-INF/template/title.jsp"%>
    <div id="main">
        <div id="main_content">
            <%@ include file="/WEB-INF/template/userinfo_left.jsp"%>
            <div id="right_main">
                <div id="right_main_top">
                    <span class="span_right_main_top">个人信息</span>
                </div>
                <div id="right_main_main">
                    <form id="info_form" style="display: inline-block;">
                        <div id="right_main_main_left">
                            <div class="right_main_main_left_item">
                                <span class="span_right_main_main_left_attr">用户名:</span>
                                <input type="text" name="userName" value="${requestScope[AttrToken.DATA].userName}" class="form-control input_right_main_main_left user_name" placeholder="User Name">
                            </div>
                            <div class="right_main_main_left_item">
                                <span class="span_right_main_main_left_attr">性别:</span>
                                <input type="radio" name="sex" id="man" style="margin-left: 15px;" value="男">男
                                <input type="radio" name="sex" id="women" style="margin-left: 30px;" value="女">女
                            </div>
                            <div class="right_main_main_left_item">
                                <span class="span_right_main_main_left_attr">公开邮箱:</span>
                                <input type="text" name="eMail" value="${requestScope[AttrToken.DATA].eMail}" class="form-control input_right_main_main_left" placeholder="E-mail">
                            </div>
                            <div class="right_main_main_left_item">
                                <span class="span_right_main_main_left_attr">手机号:</span>
                                <input type="text" name="phone" value="${requestScope[AttrToken.DATA].phone}" class="form-control input_right_main_main_left" placeholder="Phone Number">
                            </div>
                            <div class="right_main_main_left_item">
                                <span class="span_right_main_main_left_attr">个人网站:</span>
                                <input type="text" name="website" value="${requestScope[AttrToken.DATA].website}" class="form-control input_right_main_main_left" placeholder="URL">
                            </div>
                            <div class="right_main_main_left_item">
                                <span class="span_right_main_main_left_attr">地理位置:</span>
                                <input type="text" name="location" value="${requestScope[AttrToken.DATA].location}" class="form-control input_right_main_main_left" placeholder="Location">
                            </div>
                            <div class="right_main_main_left_item" style="float: right;">
                                <button id="submit_btn" type="button" class="btn btn-success" style="margin-right: 5px;width: 100px;">交提更新</button>
                            </div>
                        </div>
                    </form>
                    <div id="right_main_main_right">
                        <input class="get_user_img" style="border-radius: 5px 5px 5px 5px;" id="change_img" type="image" src="${pageContext.request.contextPath}/static/img/user/${requestScope[AttrToken.DATA].imgPath}" width="100" height="100">
                        <div id="in_img_tip">
                            <span class="glyphicon glyphicon-pencil"></span>
                            <span>点击以编辑</span>
                        </div>
                        <span>100×100</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="warp_bottom"></div>
    <input type="file" id="img_file" style="display: none;" accept="image/*">
    <%@ include file="/WEB-INF/template/tip_show.jsp"%>
</div>
</body>
</html>