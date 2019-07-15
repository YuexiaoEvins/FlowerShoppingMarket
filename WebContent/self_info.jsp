<%@page import="util.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>个人中心</title>
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
	<a href="./index.html" target="_blank"><div class="logo fl"></div></a>
	<a href=""><div class="ad_top fl"></div></a>
	<div class="nav fl">
		<ul>
			<li><a href="index.jsp">商城主页</a></li>
			<li><a href="">更多页面敬请期待</a></li>
		</ul>
	</div>
	<div class="search fr">
		<form action="" method="post">
			<div class="text fl">
				<input type="text" class="shuru"  placeholder="搜索引擎处在开发中。。。&nbsp;">
			</div>
			<div class="submit fl">
				<input type="submit" class="sousuo" value="搜索"/>
			</div>
			<div class="clear"></div>
		</form>
		<div class="clear"></div>
	</div>
</div>
<!-- end banner_x -->
<!-- self_info -->
	<div class="grzxbj">
		<div class="selfinfo center">
		<div class="lfnav fl">
			<div class="ddzx">个人中心</div>
			<div class="subddzx">
				<ul>
					<li><a href="./self_info.html" style="color:#ff6700;font-weight:bold;">我的个人中心</a></li>
					<li><a href="">剩余功能开发中</a></li>
				</ul>
			</div>
		</div>
		<div class="rtcont fr">
			
			<div class="grzlbt ml40">我的资料</div>
			<div class="subgrzl ml40"><span>账号</span><span><%=user.getUid() %></span></div>
			<div class="subgrzl ml40"><span>昵称</span><span><%=user.getUname() %></span></div>
			<div class="subgrzl ml40"><span>手机号</span><span><%=user.getPhone() %></span></div>
			<div class="subgrzl ml40"><span>年龄</span><span><%=user.getAge() %></span></div>
			<div class="subgrzl ml40"><span>收货地址</span><span><%=user.getAddress() %></span></div>
			<div class="subgrzl2 ml100"><span><a href="ChangeInfoWindow.jsp">编辑个人资料</a></span></div>
			<div class="subgrzl2 ml100"><span><a href="ChangePswWindow.jsp">修改密码</a></span></div>
		</div>
		
		<div class="clear"></div>
		</div>
	</div>
<!-- self_info -->
		
<footer class="mt20 center">			
			
	<div>京ICP证110507号 京ICP备10046444号 京公网安备11010802020134号 京网文[2014]0059-0009号</div> 
	<div>违法和不良信息举报电话：185-0130-1238，本网站所列数据，除特殊说明，所有数据均出自学生实验测试</div>
</footer>
</body>
</html>