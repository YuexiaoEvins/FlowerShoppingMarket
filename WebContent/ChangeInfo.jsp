<%@page import="util.UserDAO"%>
<%@page import="util.User"%>
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
		
		
		Statement stmt =null;
		ResultSet rs = null;
		Connection conn = null;
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		User user = (User) session.getAttribute("user");
		String name=request.getParameter("name").trim();
		int age=Integer.parseInt(request.getParameter("age").trim());
		String phone=request.getParameter("phone").trim();
		String province=request.getParameter("province").trim();
		String city=request.getParameter("city").trim();
		String address=request.getParameter("address").trim();
		
		
		UserDAO userDAO = new UserDAO();
		PreparedStatement pstmt;
		if(province.equals("请选择省份"))
			province="";
		if(city.equals("请选择城市"))
			city="";
		user.setUname(name);
		user.setAge(age);
		user.setPhone(phone);
		user.setProvince(province);
		user.setCity(city);
		user.setAddress(address);
	 	userDAO.UpdateUserInfo(user);
	 	session.setAttribute("user", user);
	 	out.print("<script>alert('更改信息成功！');window.location.href='self_info.jsp'</script>");
		%>


</body>
</html>