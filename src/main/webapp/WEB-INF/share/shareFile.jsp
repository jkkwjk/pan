<%--
  Created by IntelliJ IDEA.
  User: jkkwjk
  Date: 2019/6/5
  Time: 16:48
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jkk.tools.FileIcoTool" %>
<%@ page import="com.jkk.utils.StampDate" %>
<%@ page import="com.jkk.utils.FilesizeUtil" %>
<!DOCTYPE html>
<html>
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
        <div id="main_main">
            <div id="main_main_left">
                <div id="main_main_left_top">
                    <div class="div_over_hid1" style="width: 200px;">
                        <img src="${pageContext.request.contextPath}/static/img/file/file_ico/${FileIcoTool.getIco(requestScope[AttrToken.SHARE_FILE].file.fileName)}.png" width=25 style="vertical-align: text-bottom;">
                        <span id="span_file_name">${requestScope[AttrToken.SHARE_FILE].file.fileName}</span>
                    </div>
                    <div style="float: right">
                        <c:if test="${requestScope[AttrToken.SHARE_USER].userId==sessionScope[AttrToken.USER].userId}">
                        <button type="button" class="btn btn-light button_main_main_left_top" id="ban_share_btn">
                            <span class="glyphicon glyphicon-ban-circle" style="margin-right: 2px;"></span> 取消分享
                        </button>
                        <script type="text/javascript">
                            $(document).ready(function () {
                                $("#ban_share_btn").click(function () {
                                    var type = 1;
                                    $.post("${pageContext.request.contextPath}/share/del",{'type':type,'url':url},function (data) {
                                        if (data.status == 200){
                                            tip_show("取消分享成功!","success");
                                            setTimeout(function () {
                                                window.location.href="${pageContext.request.contextPath}/login";
                                            },1400);
                                        } else {
                                            tip_show(data.error_msg,"danger");
                                        }
                                    },'json');
                                });
                            });
                        </script>
                        </c:if>
                        <button type="button" class="btn btn-light button_main_main_left_top" id="download_btn">
                            <span class="glyphicon glyphicon-download-alt" style="margin-right: 2px;"></span>
                            <span id="download_span">下载</span>
                        </button>
                    </div>
                </div>
                <div id="main_main_left_mid">
                    <span class="glyphicon glyphicon-time" style="font-size: 16px; color: rgba(158, 158, 158, 0.753);"></span>
                    <span class="span_nomal" style="margin-left: 5px;">${StampDate.stampToDate(requestScope[AttrToken.NOW_TIME])}</span>
                    <span class="span_nomal" style="margin-left: 15px;">失效时间 : </span>
                    <span class="span_nomal" id="limit_time">${StampDate.stampToDate(requestScope[AttrToken.SHARE_FILE].limitTime)}</span>
                </div>
                <div id="main_main_left_main">
                    <div id="main_main_left_main_contain">
                        <div id="file_main">
                            <div>
                                <img id="file_ico" src="${pageContext.request.contextPath}/static/img/file/file_ico/${FileIcoTool.getIco(requestScope[AttrToken.SHARE_FILE].file.fileName)}.png">
                            </div>
                            <div class="span_nomal" id="file_main_size">
                                <span>文件大小:</span>
                                <span id="file_size">${FilesizeUtil.BToOther(requestScope[AttrToken.FILE_SIZE])}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="main_main_right">
                <div id="main_main_right_main">
                    <div id="main_main_right_main_img_bg">
                        <img src="${pageContext.request.contextPath}/static/img/user/${requestScope[AttrToken.SHARE_USER_DATA].imgPath}" id="main_main_right_main_img">
                    </div>
                    <div class="span_nomal" id="share_username">${requestScope[AttrToken.SHARE_USER_DATA].userName}</div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/template/tip_show.jsp"%>
</div>
</body>
</html>