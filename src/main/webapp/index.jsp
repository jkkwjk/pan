<%@ page import="com.jkk.model.User" %>
<%@ page import="com.jkk.service.AttrToken" %>
<%@ page import="com.jkk.service.impl.User.LoginImpl" %>
<html>
<body>
<h2>Hello World!</h2>
<%--测试用--%>
<%
    LoginImpl login = new LoginImpl();
    User user = login.login("test","jKK112233");
    session.setAttribute(AttrToken.USER,user);
%>
<jsp:forward page="/user/c?url=user%2FchangePWD.jsp"></jsp:forward>
<%--END--%>
</body>
</html>
