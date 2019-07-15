<%@page import="util.DBHelper"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="javax.naming.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册成功页面</title>
</head>
<body>
<%
		
		//Context ctx = null;
		//DataSource ds = null;
		Statement stmt =null;
		ResultSet rs = null;
		Connection conn = null;
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		
		String id=request.getParameter("id").trim();//去除首尾空格
		String name=request.getParameter("name").trim();
		String password=request.getParameter("password").trim();
		String refill=request.getParameter("refill").trim();
		int age=Integer.parseInt(request.getParameter("age").trim());
		String phone=request.getParameter("phone").trim();
		String province=request.getParameter("province").trim();
		String city=request.getParameter("city").trim();
		String address=request.getParameter("address").trim();
		
		try{
		conn=DBHelper.getConnection();
		stmt = conn.createStatement();
		PreparedStatement pstmt;
		if(id!=null ){
			rs=stmt.executeQuery("select * from myuser where id='"+id+"'");
			
			if(rs.next()){
				out.print("<script>alert('用户名已存在，请重新输入');window.location.href='registered'</script>");
			}else{
				if(province.equals("请选择省份"))
					province="";
				if(city.equals("请选择城市"))
					city="";
				if(password.equals(refill)){
					pstmt=conn.prepareStatement("insert into myuser(id,name,psw,age,phone,province,city,address) values(?,?,?,?,?,?,?,?)");
	 				pstmt.setString(1, id);
	 				pstmt.setString(2, name);
	 				pstmt.setString(3, password);
	 				pstmt.setInt(4, age);
	 				pstmt.setString(5, phone);
	 				pstmt.setString(6, province);
	 				pstmt.setString(7, city);
	 				pstmt.setString(8, address);
	 				pstmt.executeUpdate();
					out.print("<script>alert('注册成功！');window.location.href='index.jsp'</script>");
				}
			}
			}else {
				out.print("姓名不能为空");
			}
		}catch(Exception ex){
			ex.printStackTrace();
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