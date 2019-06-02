<%@ page import="com.jkk.model.User" %>
<%@ page import="com.jkk.service.AttrToken" %>
<%@ page import="com.jkk.service.impl.User.LoginImpl" %>
<html>
<body>
<h2>Hello World!</h2>
<%--测试用--%>
<%
    LoginImpl login = new LoginImpl();
    User user = login.login("test","Jkk112233");
    session.setAttribute(AttrToken.USER,user);
%>
<jsp:forward page="WEB-INF/user/user.jsp"></jsp:forward>
<%--END--%>
</body>
</html>
