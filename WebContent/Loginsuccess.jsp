<%@page import="util.User"%>
<%@page import="util.UserDAO"%>
<%@page import="util.DBHelper"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="javax.naming.*"%>
<%request.setCharacterEncoding("utf-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>判断登录</title>
</head>
<body>
	<%
		Statement stmt =null;
		ResultSet rs = null;
		Connection conn = null;
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id").trim();
		String password = request.getParameter("password").trim();
		try{
			conn=DBHelper.getConnection();
			stmt = conn.createStatement();
			rs=stmt.executeQuery("select * from shopping.myuser where id='"+id+"'");
			if(rs.next()){
				
				rs=stmt.executeQuery("select * from shopping.myuser where id='"+id+"' and psw='"+password+"'");
				if(rs.next()){
					String name = rs.getString("name");
					UserDAO userDAO = new UserDAO();
					User user = userDAO.getUserByUid(id);
					session.setAttribute("user", user);
					out.print("<script>alert('登录成功');window.location.href='index.jsp'</script>");
				}else{
					out.print("密码输入错误！！！<br>"+"重新<a href=\"login.jsp\">登录</a>");
				}
			}else{
				out.print("<font color=red>"+id+"</font>用户不存在！！！<br>"+"请点击<a href=\"registered.jsp\">注册</a>");
			}
		}catch(Exception e){
			e.printStackTrace();
			out.print(e);
		}finally{
			if(rs!=null)
			{
				try{
                    rs.close();
                    rs = null;
                }catch(Exception ex){
                    ex.printStackTrace();
                }
			}
			if(stmt!=null)
			{
				try{
                    stmt.close();
                    stmt=null;
                }catch(Exception ex){
                    ex.printStackTrace();
                }
			}
		}
	%>

</body>
</html>