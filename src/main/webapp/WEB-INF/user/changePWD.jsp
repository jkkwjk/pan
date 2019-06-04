<%--
  Created by IntelliJ IDEA.
  User: jkkwjk
  Date: 2019/6/3
  Time: 12:56
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/change_pwd.css"> <!--link_tag -->

    <title>修改密码</title>
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/title.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery-from.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <script type="text/javascript">
        var base_path = "${pageContext.request.contextPath}";
    </script>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#pwd").keyup(function(){
                if(!($("#pwd").isPassword())){
                    $("#span_pwd").css("display","inline");
                }else{
                    $("#span_pwd").css("display","none");
                }

                if ($("#pwd").val() != $("#confim_pwd").val()){
                    $("#span_confim").css("display","inline");
                }else {
                    $("#span_confim").css("display","none");
                }
                if(can_submit()) {
                    $("#login_submit").attr("disabled",false);
                }else {
                    $("#login_submit").attr("disabled",true);
                }
            });
            $("#confim_pwd").keyup(function(){
                if ($("#pwd").val() != $("#confim_pwd").val()){
                    $("#span_confim").css("display","inline");
                }else {
                    $("#span_confim").css("display","none");
                }
                if(can_submit()) {
                    $("#login_submit").attr("disabled",false);
                }else {
                    $("#login_submit").attr("disabled",true);
                }
            });
            $("#old_pwd").keyup(function(){
                if(can_submit()) {
                    $("#login_submit").attr("disabled",false);
                }else {
                    $("#login_submit").attr("disabled",true);
                }
            });
            $("#login_submit").click(function () {
                var old = $("#old_pwd").val();
                var new_pwd = $("#pwd").val();
                $.post(base_path+'/user/cp',{'old':old,'new':new_pwd},function (data) {
                    if (data.status==200){
                        tip_show("修改成功!",'success');
                        $("#old_pwd").val("");
                        $("#pwd").val("");
                        $("#confim_pwd").val("");
                    } else {
                        tip_show(data.error_msg,'danger');
                        $("#pwd").val("");
                        $("#confim_pwd").val("");
                    }

                    if(can_submit()) {
                        $("#login_submit").attr("disabled",false);
                    }else {
                        $("#login_submit").attr("disabled",true);
                    }
                },'json');
            });
        });
        function can_submit(){
            if (($("#pwd").isPassword()) && $("#pwd").val() == $("#confim_pwd").val() && $("#old_pwd").val()!="") {
                return true;
            }else {
                return false;
            }
        }
    </script> <!-- 登录密码修改 -->
    <script type="text/javascript">
        $(document).ready(function () {
            $($("#ul_title").find("li")[1]).addClass('title_active');
            $($(".list_active")[1]).attr('id','left_list_active');
        });

    </script> <!-- 初始化页面 -->
</head>
<body>
<div id="warp" style="min-width: 1100px;">
    <%@ include file="/WEB-INF/template/title.jsp"%>
    <div id="main">
        <div id="main_content">
            <%@ include file="/WEB-INF/template/userinfo_left.jsp"%>
            <div id="right_main">
                <div id="right_main_top">
                    <span class="span_right_main_top">修改密码</span>
                </div>
                <div id="right_main_main">
                    <div id="right_main_main_left">
                        <div class="right_main_main_left_item">
                            <div class="right_main_main_left_item_top">
                                <span class="span_right_main_top" style="font-size: 17px;">登录密码修改</span>
                            </div>
                            <div class="right_main_main_left_item_main">
                                <div class="input_group">
                                    <span class="span_right_main_main_left_attr">原始密码:</span>
                                    <input type="password" class="form-control input_right_main_main_left" placeholder="Old Password" id="old_pwd">
                                </div>
                                <div class="input_group">
                                    <span class="span_right_main_main_left_attr">新密码:</span>
                                    <div style="position: relative;">
                                        <input type="password" class="form-control input_right_main_main_left" id="pwd" placeholder="New Password">
                                        <span class="pwd_tip" id="span_pwd">*6-16个字符，需要有大小写</span>
                                    </div>
                                </div>
                                <div class="input_group">
                                    <span class="span_right_main_main_left_attr">再次输入:</span>
                                    <div style="position: relative;">
                                        <input type="password" class="form-control input_right_main_main_left" id="confim_pwd" placeholder="Confirm new password">
                                        <span class="pwd_tip" id="span_confim">*密码需与上面一致</span>
                                    </div>
                                </div>
                                <div class="input_group" style="float: right;">
                                    <button type="button" class="btn btn-success" style="margin-right: 5px;width: 120px;" id="login_submit" disabled>修改登录密码</button>
                                </div>
                            </div>

                        </div>
                        <c:if test="${requestScope[AttrToken.CONFIM]}">
                        <script type="text/javascript">
                                $(document).ready(function(){
                                    $("#pwd_er").keyup(function(){
                                        if(!($("#pwd_er").isPassword())){
                                            $("#span_pwd_er").css("display","inline");
                                        }else{
                                            $("#span_pwd_er").css("display","none");
                                        }

                                        if ($("#pwd_er").val() != $("#confim_pwd_er").val()){
                                            $("#span_confim_er").css("display","inline");
                                        }else {
                                            $("#span_confim_er").css("display","none");
                                        }
                                        if(can_submit()) {
                                            $("confim_submit").attr("disabled",false);
                                        }else {
                                            $("#confim_submit").attr("disabled",true);
                                        }
                                    });
                                    $("#confim_pwd_er").keyup(function(){
                                        if ($("#pwd_er").val() != $("#confim_pwd_er").val()){
                                            $("#span_confim_er").css("display","inline");
                                        }else {
                                            $("#span_confim_er").css("display","none");
                                        }
                                        if(can_submit_er()) {
                                            $("#confim_submit").attr("disabled",false);
                                        }else {
                                            $("#confim_submit").attr("disabled",true);
                                        }
                                    });
                                    $("#old_pwd_er").keyup(function(){
                                        if(can_submit_er()) {
                                            $("#confim_submit").attr("disabled",false);
                                        }else {
                                            $("#confim_submit").attr("disabled",true);
                                        }
                                    });
                                    $("#confim_submit").click(function () {
                                        var old = $("#old_pwd_er").val();
                                        var new_pwd = $("#pwd_er").val();
                                        $.get(base_path+'/user/cp',{'old':old,'new':new_pwd},function (data) {
                                            if (data.status==200){
                                                tip_show("修改成功!",'success');
                                                $("#old_pwd_er").val("");
                                                $("#pwd_er").val("");
                                                $("#confim_pwd_er").val("");
                                            } else {
                                                tip_show(data.error_msg,'danger');
                                                $("#pwd_er").val("");
                                                $("#confim_pwd_er").val("");
                                            }

                                            if(can_submit_er()) {
                                                $("#confim_submit").attr("disabled",false);
                                            }else {
                                                $("#confim_submit").attr("disabled",true);
                                            }
                                        },'json');
                                    });
                                });
                                function can_submit_er(){
                                    if (($("#pwd_er").isPassword()) && $("#pwd_er").val() == $("#confim_pwd_er").val() && $("#old_pwd_er").val()!="") {
                                        return true;
                                    }else {
                                        return false;
                                    }
                                };
                            </script> <!-- 二次密码修改 -->
                        <div class="right_main_main_left_item" style="margin-top: 50px;">
                            <div class="right_main_main_left_item_top">
                                <span class="span_right_main_top" style="font-size: 17px;">二级密码修改</span>
                            </div>
                            <div class="right_main_main_left_item_main">
                                <div class="input_group">
                                    <span class="span_right_main_main_left_attr">原始密码:</span>
                                    <input type="password" class="form-control input_right_main_main_left" placeholder="Old Password" id="old_pwd_er">
                                </div>
                                <div class="input_group">
                                    <span class="span_right_main_main_left_attr">新密码:</span>
                                    <div style="position: relative;">
                                        <input type="password" class="form-control input_right_main_main_left" id="pwd_er" placeholder="New Password">
                                        <span class="pwd_tip" id="span_pwd_er">*6-16个字符，需要有大小写</span>
                                    </div>
                                </div>
                                <div class="input_group">
                                    <span class="span_right_main_main_left_attr">再次输入:</span>
                                    <div style="position: relative;">
                                        <input type="password" class="form-control input_right_main_main_left" id="confim_pwd_er" placeholder="Confirm new password">
                                        <span class="pwd_tip" id="span_confim_er">*密码需与上面一致</span>
                                    </div>
                                </div>
                                <div class="input_group" style="float: right;">
                                    <button type="button" class="btn btn-success" style="margin-right: 5px;width: 120px;" id="confim_submit" disabled>修改二级密码</button>
                                </div>
                            </div>
                        </div>
                        </c:if>
                        <c:if test="${!requestScope[AttrToken.CONFIM]}">
                        <div class="right_main_main_left_item" style="margin-top: 50px;">
                            <div class="right_main_main_left_item_top" style="border-bottom: 0px;">
                                <a style="display: inline-block;" href="${pageContext.request.contextPath}/user/c?url=user%2FdefineCPWD.jsp"><span class="span_right_main_top" style="font-size: 17px;">创建二级密码</span></a>
                            </div>
                        </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="warp_bottom"></div>
    <%@ include file="/WEB-INF/template/tip_show.jsp"%>
</div>
</body>
</html>