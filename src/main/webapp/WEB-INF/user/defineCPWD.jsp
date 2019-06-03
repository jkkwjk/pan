<%--
  Created by IntelliJ IDEA.
  User: jkkwjk
  Date: 2019/6/3
  Time: 12:44
--%>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/confim_pwd.css"> <!--link_tag -->

    <title>二级密码</title>
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/title.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery-from.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
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
                    $("#submit").attr("disabled",false);
                }else {
                    $("#submit").attr("disabled",true);
                }
            });
            $("#confim_pwd").keyup(function(){
                if ($("#pwd").val() != $("#confim_pwd").val()){
                    $("#span_confim").css("display","inline");
                }else {
                    $("#span_confim").css("display","none");
                }
                if(can_submit()) {
                    $("#submit").attr("disabled",false);
                }else {
                    $("#submit").attr("disabled",true);
                }
            });
        });
        function can_submit(){
            if (($("#pwd").isPassword()) && $("#pwd").val() == $("#confim_pwd").val()) {
                return true;
            }else {
                return false;
            }
        };
    </script> <!-- 密码效验 -->
    <script type="text/javascript">
        $(document).ready(function () {
            $($("#ul_title").find("li")[1]).addClass('title_active');
        });
    </script><!-- 页面初始化 -->
</head>
<body>
<div id="warp" style="min-width: 1100px;">
    <%@ include file="/WEB-INF/template/title.jsp"%>
    <div id="main">
        <div id="main_top">
            <span class="span_strong">设置二级密码</span>
            <span class="span_lit_title">设置密码后删除文件需要二次验证</span>
        </div>
        <div id="main_main">
            <span style="margin-right: 10px;">二级密码:</span>
            <input id="pwd" type="password" class="form-control" style="width: 170px;height: 30px;display: inline-block;">
            <span class="pwd_tip" id="span_pwd">*密码长度为6-16个字符，需要大小写字符</span>
            <br>
            <div style="margin-top: 10px;">
                <span style="margin-right: 10px;font-size: 15px;">确认密码:</span>
                <input id="confim_pwd" type="password" class="form-control" style="width: 170px;height: 30px;;display: inline-block;">
                <span class="pwd_tip" id="span_confim" style="margin-left: 2px;">*密码需与上面一致</span>
            </div>
            <div style="margin-top: 10px;">
                <button type="button" class="btn btn-primary" style="width: 80px;" id="submit" disabled>确定</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>