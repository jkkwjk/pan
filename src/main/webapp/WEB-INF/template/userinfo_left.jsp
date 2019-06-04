<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jkk.service.AttrToken" %>
<div id="left_list">
    <div id="left_list_userinfo">
        <div id="left_list_userinfo_username">
            <img style="width: 70px;height: 70px;" class="get_user_img" src="${pageContext.request.contextPath}/static/img/user/${requestScope[AttrToken.DATA].imgPath}">
            <div id="left_list_userinfo_username_right">
                <p style="margin-top: 20px;">
                    <span class="span_left_list_userinfo_username get_user_name" style="font-family: 微软雅黑;">${requestScope[AttrToken.DATA].userName}</span>
                </p>
                <p style="margin-top: 5px;">
                    <span class="span_left_list_userinfo_username" style="font-size: 12px;color: #666;">欢迎您!</span>
                </p>
            </div>
        </div>
        <div id="left_list_userinfo_bottom">
            <p><span class="span_left_list_userinfo_username" style="font-weight: 600;">最近一次登录在:</span></p>
            <p><span class="span_left_list_userinfo_username" style="margin-left: 45px;">${requestScope[AttrToken.DATA].lastLoginTime}</span></p>
        </div>
    </div>
    <div id="div_left_ul">
        <ul class="ul_my" style="margin-top: 20px;">
            <a href="${pageContext.request.contextPath}/user/c?url=user%2Fuser.jsp" class="a_left list_active" style="margin-top: 10px;">
                <li class="li_left">
                    <span class="glyphicon glyphicon-user" id="glyphicon_li_left"></span> <!--图标-->
                    个人信息
                </li>
            </a>
            <a href="${pageContext.request.contextPath}/user/c?url=user%2FchangePWD.jsp" class="a_left list_active">
                <li class="li_left">
                    <span class="glyphicon glyphicon-lock" id="glyphicon_li_left"></span> <!--图标-->
                    修改密码
                </li>
            </a>
            <a href="${pageContext.request.contextPath}/user/c?url=user%2Fdel.jsp" class="a_left list_active">
                <li class="li_left">
                    <span class="glyphicon glyphicon-off" id="glyphicon_li_left"></span> <!--图标-->
                    账号注销
                </li>
            </a>
        </ul>
    </div>
</div>
