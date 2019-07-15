<%@page import="util.User"%>
<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8"%>
<%@ page import="util.ItemsDAO"%>
<%@ page import="util.Items"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>商城主界面</title>
<meta charset="UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link rel="stylesheet" type="text/css" href="css/style.css">
<!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->

</head>

<body>
	<!-- start header -->
	<header>
	<div class="top center">
		<div class="left fl">
			<ul>
				<li><a href="http://www.taobao.com/" target="_blank">淘宝首页</a></li>
				<li>|</li>
				<li><a href="index.jsp">商店主页</a></li>
				<li>|</li>
				<li><a href="">更多页面敬请期待</a></li>

			</ul>
		</div>
		<div class="right fr">
			<div class="gouwuche fr">
				<a href="cart.jsp">购物车</a>
			</div>
			<%
    	User user = (User)session.getAttribute("user");
    	if(user == null)
    	{
    		%>
			<div class="fr">
				<ul>
					<li><a href="login.jsp">登录</a></li>
					<li>|</li>
					<li><a href="registered.jsp">注册</a></li>
					<li>|</li>
					<%
    	}else
    	{
    		if(user.getUid().equals("root"))
    		{
        		%>
					<div class="gouwuche fr">
						<a href="order.jsp">所有订单</a>
					</div>
					<div class="fr">
						<ul>
							<li><a>账号：<%=user.getUid() %></a></li>
							<li>|</li>
							<li><a>欢迎你，<%=user.getUname() %></a></li>
							<li>|</li>
							<li><a href="loginout.jsp">退出账户</a></li>
							<%
    		}
    		else
    		{
        		%>
							<div class="gouwuche fr">
								<a href="order.jsp">我的订单</a>
							</div>
							<div class="fr">
								<ul>
									<li><a>账号：<%=user.getUid() %></a></li>
									<li>|</li>
									<li><a>欢迎你，<%=user.getUname() %></a></li>
									<li>|</li>
									<li><a href="self_info.jsp">个人中心</a></li>
									<li>|</li>
									<li><a href="loginout.jsp">退出账户</a></li>
									<%
    		}   		
    	}
    %>
								</ul>
							</div>
							<div class="clear"></div>
					</div>
					<div class="clear"></div>
			</div>
	</header>
	<!--end header -->


	<!-- start banner_x -->
	<div class="banner_x center">
		<div class="nav fl">
			<ul>
				<li><a href="">商城主页</a></li>
				<li><a href="">更多页面敬请期待</a></li>
			</ul>
		</div>
		<div class="search fr">
			<form action="" method="post">
				<div class="text fl">
					<input type="text" class="shuru"
						placeholder="&nbsp;&nbsp;&nbsp;搜索引擎处在开发中。。。&nbsp;">
				</div>
				<div class="submit fl">
					<input type="submit" class="sousuo" value="搜索" />
				</div>
				<div class="clear"></div>
			</form>
			<div class="clear"></div>
		</div>
	</div>
	<!-- end banner_x -->

	<!-- start danpin -->
	<div class="danpin center">
		<div class="biaoti center">花卉</div>
		<!-- 商品循环开始  -->
		<%
			int col_count=0;
            ItemsDAO itemsDao = new ItemsDAO();
            ArrayList<Items> list = itemsDao.getAllItems();
            if(list!=null&&list.size()>0){
                for(int i=0;i<list.size();i++){
                    Items item = list.get(i);
                    if(col_count%5==0)
                    {
                    	%>
		<div class="main center mb20">
			<%
                    }
                    %>
			<div class="mingxing fl mb20"
				style="border: 2px solid #fff; width: 230px; cursor: pointer;"
				onmouseout="this.style.border='2px solid #fff'"
				onmousemove="this.style.border='2px solid red'">
				<div class="sub_mingxing">
					<a href="details.jsp?id=<%=item.getId()%>" target="_blank"><img
						src="images/<%=item.getPicture() %>" alt=""></a>
				</div>
				<div class="pinpai">
					<a href="details.jsp?id=<%=item.getId()%>" target="_blank"><%=item.getName() %></a>
				</div>
				<br>
				<div class="jiage"><%=item.getPrice() %>元
				</div>
			</div>
			<%
                    col_count++;
                    if(col_count%5==0&&col_count!=0)
                    {
                    	
                    	%>
			<div class="clear"></div>
		</div>
		<%
                    	col_count=0;
                    }
                    

                }
            }  
           %>
	</div>
	<footer class="mt20 center">
	<div>京ICP证110507号 京ICP备10046444号 京公网安备11010802020134号
		京网文[2014]0059-0009号</div>
	<div>违法和不良信息举报电话：185-0130-1238，本网站所列数据，除特殊说明，所有数据均出自学生实验测试</div>
	</footer>
</body>
</html>