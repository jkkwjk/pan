<%@ page import="com.jkk.service.AttrToken" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/5/17
  Time: 14:19
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>网盘,让美好常驻于世间</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/default.css"> <!--link_tag -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/onepage-scroll.css"> <!--link_tag -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css"> <!--link_tag -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script><!--link_tag -->
    <script src="${pageContext.request.contextPath}/static/js/jquery.onepage-scroll.min.js"></script><!--link_tag -->
    <script src="${pageContext.request.contextPath}/static/js/jquery-from.js"></script>
    <script type="text/javascript">
    var max = 5; //图片最大数
    var up_text=["青春的我们","无缝衔接","保存美好","美丽的风景","精彩比赛"];
    var down_text=["值得去纪念","享受快捷办公","随时可以回忆","与你一起享受","随时随地回看"];
    var div_width=["316","353","353","353","353"];
    $(function(){
        $('.pic_scoll').onepage_scroll({
            pagination:false, //不显示右侧的小点点
            loop:false,
            keyboard:false,
            direction:'horizontal'
        });
        setTimeout("time_loop_img_scoll(1)",5000);
    });
    function time_loop_img_scoll(index){
        var add = '<section style="width: 100%; height: 100%; position: absolute; top: 0px; left: {1}00%;" data-index="{2}"><div class="bg_can_resize pic_blur" style="position: absolute; background-image: url(${pageContext.request.contextPath}/static/img/index/{0}.jpg);z-index: -1;"></div><div id="text_pic" style="height: 100px;width: {3}px;"><img src="${pageContext.request.contextPath}/static/img/index/leftquote.png" alt=""><div class="quote_text" style="margin-left: 48px; margin-top: -23px;">{4}</div><img src="${pageContext.request.contextPath}/static/img/index/rightquote.png" alt="" style="float: right;margin-top: 10px;"><div class="quote_text" style="margin-left: 83px;">{5}</div></div></section>';

        add=add.replace("{0}",index%max);
        add=add.replace("{1}",index);
        add=add.replace("{2}",eval(index)+1);
        add=add.replace("{3}",div_width[index%max]);
        add=add.replace("{4}",up_text[index%max]);
        add=add.replace("{5}",down_text[index%max]);
        $('.pic_scoll').append(add);
        $('.pic_scoll').moveDown();
        setTimeout("time_loop_img_scoll({0})".replace("{0}",index+1),5000);
    }
    </script> <!-- 背景图片滚动 -->
    <script type="text/javascript">
        $(document).ready(function(){
            $("#to_regedit").click(function(){
                $("#login_main").animate({'margin-left':'400px'});
                setTimeout(function (){$("#regedit_main").animate({'margin-left':'0px'});},500);
            });
            $("#login_btn").click(function () {
                $("#login_form").submit();
            });
            $("#regedit_code_btn").click(function () {
                change_imgcode();
                return false;
            });
            change_imgcode();
        });
        function change_imgcode() {
            $("#regedit_code_btn").attr("src","${pageContext.request.contextPath}/getcode?ts="+(new Date()).valueOf());
        }
    </script> <!-- 登录界面 验证码 -->
    <script type="text/javascript">
        $(document).ready(function () {
            <c:if test="${!empty sessionScope[AttrToken.ERROR_MSG]}">
            $("#login_name").val("${sessionScope[AttrToken.LOGIN_NAME]}");
            tip_show("${sessionScope[AttrToken.ERROR_MSG]}");
            ${sessionScope.remove(AttrToken.ERROR_MSG)}
            ${sessionScope.remove(AttrToken.LOGIN_NAME)}
            </c:if>
        });
    </script><!-- 用户名或密码错误 -->
    <script type="text/javascript">
        $(document).ready(function(){
            $("#regedit_btn").click(function () {
                $("#regedit_btn").attr('disabled',true);
                var dtd = $.Deferred();
                $.when(regedit_submit(dtd)).done(function () {
                    $("#regedit_btn").attr('disabled',false);
                })
            });
        });
        function regedit_submit(dtd){
            if (!$("#regedit_name").isUserName()) {
                dtd.resolve();
                tip_show("用户名非法!");
                return dtd;
            } else if (!$("#regedit_pwd").isPassword()) {
                dtd.resolve();
                tip_show("密码强度不够或太长!");
                return dtd;
            } else if($("#regedit_confim_pwd").val() != $("#regedit_pwd").val()) {
                dtd.resolve();
                tip_show("两次输入密码不同!");
                return dtd;
            } else if($("#regedit_code").val().length != 4) {
                dtd.resolve();
                tip_show("验证码错误");
                change_imgcode();
                return dtd;
            } else{
                $.getJSON("${pageContext.request.contextPath}/regedit",{'c':'username','val':$("#regedit_name").val()},function (data) {
                    if (data.ret == '1') {
                        $.getJSON("${pageContext.request.contextPath}/regedit",{'c':'valcode','val':$("#regedit_code").val()},function (data) {
                            if (data.ret == '1'){
                                dtd.resolve();
                                $("#regedit_form").submit();
                                return dtd;
                            } else if (data.ret == '0'){
                                dtd.resolve();
                                tip_show("验证码错误");
                                change_imgcode();
                                return dtd;
                            }
                        });
                    } else if (data.ret == '0') {
                        dtd.resolve();
                        tip_show("用户名重复!");
                        return dtd;
                    }
                });
            }
        }
    </script> <!-- 注册表单验证 -->
    <script type="text/javascript">
        var timer = null;
        function tip_show(s) {
            $("#tip_text").text(s);
            my_show();
            setTimeout("my_hide();",1000);
        }
        function my_show(){
            var elemt = $("#tip");
            clearTimeout(timer);
            elemt.stop(true);
            elemt.css('display','inline');
            elemt.css('margin-top','20px');
            elemt.css('opacity','1');
        }
        function my_hide(){
            var elemt = $("#tip");
            elemt.stop(true);
            elemt.animate({'margin-top':'50px'},{queue:false,duration:400});
            elemt.animate({'opacity':'0'},{queue:false,duration:400});
            timer = setTimeout("$(\"#tip\").css('display','none')",400);
        }
    </script> <!-- 动画 -->
</head>
<body>
<div id="warp" style="min-height: 800px;min-width: 800px;">
    <div class="pic_scoll">
        <section style="width: 100%; height: 100%;">
            <div class="bg_can_resize pic_blur" style="position: absolute; background-image: url(${pageContext.request.contextPath}/static/img/index/0.jpg);z-index: -1;"></div>
            <div id="text_pic" style="height: 100px;width: 316px;">
                <img src="${pageContext.request.contextPath}/static/img/index/leftquote.png" alt="">
                <div class="quote_text" style="margin-left: 48px; margin-top: -23px;">青春的我们</div>
                <img src="${pageContext.request.contextPath}/static/img/index/rightquote.png" alt="" style="float: right;margin-top: 10px;">
                <div class="quote_text" style="margin-left: 83px;">值得去纪念</div>
            </div>
        </section>
        <!-- 修改这里代码需要改js的才能生效 -->
    </div>
    <div id="mask"> <!--主登录界面-->
        <div id="login_main">
            <form action="${pageContext.request.contextPath}/login" method="post" id="login_form">
                <center>
                    <div style="font-size: 35px;margin-top: 15px;">登录</div>
                </center>
                <div style="margin-top: 30px;">
                    <span class="login_span">账号:</span>
                    <input id="login_name" type="text" class="form-control input_my" placeholder="账号" name="username">
                </div>
                <div style="margin-top: 5px;">
                    <span class="login_span">密码:</span>
                    <input type="password" class="form-control input_my" placeholder="密码" name="pwd">
                </div>
                <div style="margin-top: 10px;">
                    <button id="login_btn" type="button" class="btn btn-primary" style="width:379px;height: 40px;">立刻登录</button>
                </div>
                <div style="margin-top: 10px;">
                    <button id="to_regedit" type="button" class="btn btn-info" style="width: 379px;height: 40px;">没有账号? &nbsp;&nbsp;马上注册！</button>
                </div>
            </form>
        </div>
        <div id="regedit_main">
            <form action="${pageContext.request.contextPath}/regedit" method="post" id="regedit_form">
                <center>
                    <div style="font-size: 35px;margin-top: 15px;">注册</div>
                </center>
                <div style="margin-top: 30px;">
                    <span class="login_span">账&nbsp;&nbsp;号:</span>
                    <input id="regedit_name" type="text" style="width: 310px !important;margin-left: 20px;" class="form-control input_my" placeholder="用户名" name="username">
                </div>
                <div style="margin-top: 5px;">
                    <span class="login_span">密&nbsp;&nbsp;码:</span>
                    <input id="regedit_pwd" type="password" style="width: 310px !important;margin-left: 20px;" class="form-control input_my" placeholder="密码" name="pwd">
                </div>
                <div style="margin-top: 5px;">
                    <span class="login_span">确认密码:</span>
                    <input id="regedit_confim_pwd" style="width: 310px !important;" type="password" class="form-control input_my" placeholder="再次输入密码">
                </div>
                <div style="margin-top: 5px;">
                    <span class="login_span">验 证 码:</span>
                    <input id="regedit_code" type="text" style="width: 190px !important;margin-left: 7px;" class="form-control input_my" placeholder="验证码" name="code" maxlength="4">
                    <input id="regedit_code_btn" type="image" style="vertical-align:bottom" src="" width="115" height="35">
                </div>
                <div style="margin-top: 10px;">
                    <button id="regedit_btn" type="button" class="btn btn-success" style="width:379px;height: 40px;">注册</button>
                </div>
            </form>
        </div>
        <div id="tip">
            <div id="tip_text" class="alert alert-danger" role="alert" style="text-align: center">
                This is a danger alert—check it out!
            </div>
        </div>

    </div>
</div>
</body>
</html>
