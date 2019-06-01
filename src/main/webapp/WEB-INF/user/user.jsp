<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
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
</head>
<body>
<div id="warp" style="min-width: 1100px;min-height: 700px;">
    <%@include file="/WEB-INF/template/title.jsp"%>
    <div id="main">
        <div id="main_content">
            <div id="left_list">
                <div id="left_list_userinfo">
                    <div id="left_list_userinfo_username">
                        <img src="${pageContext.request.contextPath}/static/img/user/default.jpg" style="width: 70px;height: 70px;">
                        <div id="left_list_userinfo_username_right">
                            <p style="margin-top: 20px;">
                                <span class="span_left_list_userinfo_username" style="font-family: 微软雅黑;">用户名</span>
                            </p>
                            <p style="margin-top: 5px;">
                                <span class="span_left_list_userinfo_username" style="font-size: 12px;color: #666;">欢迎您!</span>
                            </p>
                        </div>
                    </div>
                    <div id="left_list_userinfo_bottom">
                        <p><span class="span_left_list_userinfo_username" style="font-weight: 600;">最近一次登录在:</span></p>
                        <p><span class="span_left_list_userinfo_username" style="margin-left: 45px;">2019-5-14 22:06:58</span></p>
                    </div>
                </div>
                <div id="div_left_ul">
                    <ul class="ul_my" style="margin-top: 20px;">
                        <a href="#" class="a_left" style="margin-top: 10px;" id="left_list_active">
                            <li class="li_left">
                                <span class="glyphicon glyphicon-user" id="glyphicon_li_left"></span> <!--图标-->
                                个人信息
                            </li>
                        </a>
                        <a href="#" class="a_left">
                            <li class="li_left">
                                <span class="glyphicon glyphicon-lock" id="glyphicon_li_left"></span> <!--图标-->
                                修改密码
                            </li>
                        </a>
                        <a href="#" class="a_left">
                            <li class="li_left">
                                <span class="glyphicon glyphicon-off" id="glyphicon_li_left"></span> <!--图标-->
                                账号注销
                            </li>
                        </a>
                    </ul>
                </div>
            </div>
            <div id="right_main">
                <div id="right_main_top">
                    <span class="span_right_main_top">个人信息</span>
                </div>
                <div id="right_main_main">
                    <div id="right_main_main_left">
                        <div class="right_main_main_left_item">
                            <span class="span_right_main_main_left_attr">用户名:</span>
                            <input type="text" class="form-control input_right_main_main_left" placeholder="User Name">
                        </div>
                        <div class="right_main_main_left_item">
                            <span class="span_right_main_main_left_attr">性别:</span>
                            <input type="radio" name="sex" id="man" style="margin-left: 15px;">男
                            <input type="radio" name="sex" id="women" style="margin-left: 30px;">女
                        </div>
                        <div class="right_main_main_left_item">
                            <span class="span_right_main_main_left_attr">公开邮箱:</span>
                            <input type="text" class="form-control input_right_main_main_left" placeholder="E-mail">
                        </div>
                        <div class="right_main_main_left_item">
                            <span class="span_right_main_main_left_attr">手机号:</span>
                            <input type="text" class="form-control input_right_main_main_left" placeholder="Phone Number">
                        </div>
                        <div class="right_main_main_left_item">
                            <span class="span_right_main_main_left_attr">个人网站:</span>
                            <input type="text" class="form-control input_right_main_main_left" placeholder="URL">
                        </div>
                        <div class="right_main_main_left_item">
                            <span class="span_right_main_main_left_attr">地理位置:</span>
                            <input type="text" class="form-control input_right_main_main_left" placeholder="Location">
                        </div>
                        <div class="right_main_main_left_item" style="float: right;">
                            <button type="button" class="btn btn-success" style="margin-right: 5px;width: 100px;">交提更新</button>
                        </div>
                    </div>
                    <div id="right_main_main_right">
                        <input id="change_img" type="image" src="${pageContext.request.contextPath}/static/img/user/default.jpg" width="100" height="100">
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
</div>
</body>
</html>