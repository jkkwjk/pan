<%@ page import="com.jkk.model.User" %>
<%@ page import="com.jkk.service.AttrToken" %>
<html>
<body>
<h2>Hello World!</h2>
<%--测试用--%>
<%
    User user = new User();
    user.setName("admin");
    user.setUserId(1004);
    user.setPermissionId(0);
    session.setAttribute(AttrToken.USER,user);
%>
<jsp:forward page="WEB-INF/disk.jsp"></jsp:forward>
<%--END--%>
</body>
</html>
