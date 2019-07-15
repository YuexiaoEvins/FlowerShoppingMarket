<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8"%>
<%@ page import="util.*"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>商品详细信息</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/style.css">

<style type="text/css">
</style>
<script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
<script type="text/javascript">
	//减数量
	function reductionOf(obj) {
		//减前判断
		if ($(obj).next().val() == '' || $(obj).next().val() <= 1) {
			$(obj).next().val(1);
		} else {
			$(obj).next().val(parseInt($(obj).next().val()) - 1);//数值减
		}

		$(obj).next().val($(obj).next().val());//赋值给框
		SumOfPrice();
	}
	//加数量
	function add(obj) {
		//加前判断

		if ($(obj).prev().val() == '') {
			$(obj).prev().val(1);
		}
		$(obj).prev().val(parseInt($(obj).prev().val()) + 1);//数值加
		$(obj).prev().val($(obj).prev().val());//赋值给框
		SumOfPrice();

	}
	//校验数字格式（只能输入正整数）
	function checkNumber(obj) {
		var reg = /^[1-9]\d*$/;
		if (!reg.test($(obj).val()) || $(obj).val() == '') {
			$(obj).val(1);
		}
	}
	function SumOfPrice() {
		var price = document.getElementById("price").innerHTML;
		var num = document.getElementById("quantity").value;
		var sum = num * price;
		var total = document.getElementById("total_price");
		total.innerHTML = sum;
	}
</script>
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
	<!-- xiangqing -->
	<%
		ItemsDAO itemsDao = new ItemsDAO();
		String s = request.getParameter("id");
		int temp_id = Integer.valueOf(s);
		Items item = itemsDao.getItemById(temp_id);
		if (item != null) {
	%>
	<div class="xiangqing">
		<div class="neirong w">
			<div class="xiaomi6 fl"><%=item.getName()%></div>
			<nav class="fr">
			<li><a>开发中</a></li>
			<li>|</li>
			<li><a>开发中</a></li>

			<div class="clear"></div>
			</nav>
			<div class="clear"></div>
		</div>
	</div>
	<div class="jieshao mt20 w">
		<div class="left fl">
			<img src="images/<%=item.getPicture()%>" width="562" height="562" />
		</div>
		<form action="/WebTest4/AddItemServlet" name="submit" method="post">
			<div class="right fr">
				<div class="h3 ml20 mt20"><%=item.getName()%></div>
				<div class="jianjie mr40 ml20 mt10">
					产地：<%=item.getCity()%>
					商品编号：<%=item.getId()%></div>
				<div class="jiage ml20 mt10"><%=item.getPrice()%>元/一捆
				</div>
				<div class="ft20 ml20 mt20">选择数量</div>
				<div class="xzbb ml20 mt10">
					<input id="good_id" name="good_id" value="<%=item.getId()%>"
						type="hidden">
					<div class="banben fl">
						<input
							style="width: 91px; height: 58px; border: 2px white; float: left;"
							type="button" value="-" onclick="reductionOf(this)" /> <input
							style="text-align: center; width: 95px; height: 58px; float: left;"
							type="text" value="1" onblur="checkNumber(this)" id="quantity"
							name="quantity" /> <input
							style="width: 91px; height: 58px; border: 2px white;"
							type="button" value="+" onclick="add(this)" />
					</div>

					<div class="clear"></div>
				</div>
				<div class="ft20 ml20 mt20">
					库存：<span class="bot mt20 ft20 ftbc"><%=item.getNumber()%></span>
				</div>
				<div class="xqxq mt20 ml20">
					<div class="top1 mt10">
						<div class="left1 fl"><%=item.getName()%></div>
						<div class="right1 fr" id="price"><%=item.getPrice()%></div>
						<div class="clear"></div>
					</div>
					<div class="bot mt20 ft20 ftbc">
						总计：<span id="total_price"><%=item.getPrice()%></span>
					</div>
				</div>
				<div class="xiadan ml20 mt20">
					<input class="jrgwc" type="submit" value="立即购买" id="buy"
						onclick="document.getElementById('action').value='立即购买';this.form.submit()">
					<input class="jrgwc" type="submit" value="添加到购物车" id="Add"
						onclick="document.getElementById('action').value='Add';this.form.submit()">
					<input class="jrgwc" type="hidden" id="action" name="action">

				</div>
			</div>
		</form>
		<div class="clear"></div>
	</div>
	<%
		}
	%>

	<!-- footer -->
	<footer class="mt20 center">
	<div>京ICP证110507号 京ICP备10046444号 京公网安备11010802020134号
		京网文[2014]0059-0009号</div>
	<div>违法和不良信息举报电话：185-0130-1238，本网站所列数据，除特殊说明，所有数据均出自学生实验测试</div>
	</footer>
</body>
</html>