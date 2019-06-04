<%--
  Created by IntelliJ IDEA.
  User: jkkwjk
  Date: 2019/6/3
  Time: 23:06
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/user_info_default.css"> <!--link_tag -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/del_account.css"> <!--link_tag -->

    <title>修改密码</title>
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/title.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            timerf(3);
        });
        function timerf(num){
            if(num == 0){
                $("#btn").text("确定注销");
                $("#btn").attr("disabled",false);
            }else {
                $("#btn").text("确定注销 ( " + (num-1).toString()+" )");
                setTimeout("timerf("+ (num-1).toString() +")",1000);
            }

        }
    </script> <!-- 倒计时按钮 -->
    <script type="text/javascript">
        $(document).ready(function () {
            $("#modal_confim").click(function () {
                $.post("${pageContext.request.contextPath}/user/del",function (data) {
                    if (data.status==200){
                        tip_show("注销成功","info");
                        setTimeout(function () {
                            window.location.href = "${pageContext.request.contextPath}/login.jsp";
                        },1400);
                    } else {
                        tip_show(data.error_msg,"danger");
                    }
                },'json');
            });
        });
    </script><!-- 模态框处理 -->
    <script type="text/javascript">
        $(document).ready(function () {
            $($("#ul_title").find("li")[1]).addClass('title_active');
            $($(".list_active")[2]).attr('id','left_list_active');
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
                    <span class="span_right_main_top" style="color: red">账号注销</span>
                </div>
                <div id="right_main_main" style="display: inline-block;">
                    <div id="right_main_main_left" style="padding-top: 50px;">
                        <center><span style="font-size: 20px">确定注销账号?</span></center>
                        <div id="span_tip">注销后您将:</div>
                        <div id="main_main">
                            <ul class="ul_main">
                                <li class="ul_main_li"><span class="span_li_black">无法登录网盘</span></li>
                                <li class="ul_main_li"><span class="span_li_black">丢失文件数据</span></li>
                                <li class="ul_main_li"><span class="span_li_black">分享链接失效</span></li>
                            </ul>
                            <button type="button" class="btn btn-danger my_btn" id="btn" disabled data-toggle="modal" data-target="#yesnoModal">确定注销</button>
                        </div>
                    </div>
                </div>
                <div id="right_main_main_right">
                </div>
            </div>
        </div>
    </div>
    <div id="warp_bottom"></div>
    <%@ include file="/WEB-INF/template/tip_show.jsp"%>
    <div class="modal fade" id="yesnoModal" tabindex="-1" role="dialog" aria-labelledby="yesnoModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">注销账号</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    再次确认注销?
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
