<%--
  Created by IntelliJ IDEA.
  User: jkkwjk
  Date: 2019/6/5
  Time: 16:48
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jkk.service.AttrToken" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/default.css"> <!--link_tag -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/share.css"> <!--link_tag -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/title.css"> <!--link_tag -->

    <title>在线网盘-全部文件</title>
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/title.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</head>
<script type="text/javascript">
    var url = "${requestScope[AttrToken.SHARE_FILE].url}";
    $(document).ready(function () {
        $("#download_btn").click(function () {
            window.location.href="${pageContext.request.contextPath}/share/down?url="+url;
        });
    });
</script>
<body style="background-color: #F7F7F7;">
<div id="warp" style="min-width: 900px;">
    <%@ include file="/WEB-INF/template/title.jsp"%>
    <div id="main">
        <div id="main_main" style="height: 330px;">
            <div id="main_main_left">
                <div style="margin-top: 30px;text-align: center;">
                    <img src="${pageContext.request.contextPath}/static/img/file/share_error.png" alt="">
                    <div style="margin-top: 20px;color: #424e67;font-size: 13px;">${requestScope[AttrToken.RET].error_msg}</div>
                </div>
            </div>
            <div id="main_main_right">
                <div id="main_main_right_main">
                </div>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/template/tip_show.jsp"%>
</div>
</body>
</html>