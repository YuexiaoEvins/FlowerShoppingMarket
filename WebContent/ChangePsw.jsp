<%@page import="util.User"%>
<%@page import="util.UserDAO"%>
<%@page import="util.DBHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="javax.naming.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		User user = (User) session.getAttribute("user");
		String password=request.getParameter("password").trim();
		String refill=request.getParameter("refill").trim();
		UserDAO userDAO = new UserDAO();
		user.setPsw(password);
		userDAO.UpdateUserPsw(user);
	 	out.print("<script>alert('更改密码成功！');window.location.href='self_info.jsp'</script>");
				%>

</body>
</html>