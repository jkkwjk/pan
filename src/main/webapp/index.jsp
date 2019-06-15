<%@ page import="com.jkk.model.User" %>
<%@ page import="com.jkk.service.AttrToken" %>
<%@ page import="com.jkk.service.impl.User.LoginImpl" %>
<%@ page import="com.jkk.model.UserInfo" %>
<%@ page import="com.jkk.service.impl.User.UserInfoImpl" %>
<html>
<body>
<%
    LoginImpl login = new LoginImpl();
    User user = login.login("test","Jkk112233");
    session.setAttribute(AttrToken.USER,user);
%>
<jsp:forward page="/login"></jsp:forward>
</body>
</html>
