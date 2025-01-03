<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page isErrorPage="true" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%response.setHeader("refresh","2;URL=/z-index/login.jsp"); %>
	<h1 style="color:red">您无权访问该页面，3秒钟后自动跳转到登录页</h1>
</body>
</html>