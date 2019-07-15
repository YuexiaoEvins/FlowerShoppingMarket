<%@page import="util.User"%>
<%@page import="util.OrderItems"%>
<%@page import="util.OrderItemsDAO"%>
<%@page import="util.Order"%>
<%@page import="util.OrderDAO"%>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@ page import="util.ItemsDAO" %>
<%@ page import="util.Items"  %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>查看订单</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">    
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
  </head>
  
  <body>

	<!-- start banner_x -->
		<div class="banner_x center">	
			<div class="wdgwc fl ml40"><a href="index.jsp">商城主页</a></div>		
			<div class="wdgwc fl ml40">我的购物车</div>
			<div class="wxts fl ml20">温馨提示：产品是否购买成功，以最终下单为准哦，请尽快结算</div>
			<div class="dlzc fr">
				<ul>
					<%
    	User user = (User)session.getAttribute("user");
    	if(user == null)
    	{
    		%>
					<li><a href="login.jsp">登录</a></li>
					<li>|</li>
					<li><a href="registered.jsp">注册</a></li>
					<%
    	}else
    	{
    		if(user.getUid().equals("root"))
    		{
        		%>
        			<li><a>账号：<%=user.getUid() %></a></li>
					<li>|</li>
					<li><a>欢迎你，<%=user.getUname() %></a></li>
					<li>|</li>
					<li><a href="order.jsp">所有订单</a></li>
					<li>|</li>
					<li><a href="loginout.jsp">退出账户</a></li>
					<%
    		}
    		else
    		{
        		%>
        			<li><a>账号：<%=user.getUid() %></a></li>
					<li>|</li>
					<li><a>欢迎你，<%=user.getUname() %></a></li>
					<li>|</li>
					<li><a href="self_info.jsp">个人信息</a></li>
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
		<div class="xiantiao"></div>
		<div class="gwcxqbj">
		<br>
		<br>

				
						<%
						OrderDAO orderDAO = new OrderDAO();
				    	OrderItemsDAO orderItemsDAO = new OrderItemsDAO();
				    	ArrayList<Order> orderlist = new ArrayList<Order>();
				    	if(user.getUid().equals("root"))
				    	{
				    		orderlist = orderDAO.getAllOrder();
				    	}
				    	else
				    	{
				    		orderlist = orderDAO.getOrderByOid(user.getUid());
				    	}  		
				    	if(orderlist!=null&&orderlist.size()>0)
				    	{
				    		for(int i=0;i<orderlist.size();i++){
				                Order order = orderlist.get(i);
					
		%>
			<div class="gwcxd center">
				<div class="top2 center">
					<div class="sub_top fl">用户账号:<%=order.getUid() %></div>
					<div class="sub_top fl">购买人：<%=order.getUname() %></div>
					<div class="sub_top fl">订单号：</div>
					<div class="sub_top fl"><%=order.getOid() %></div>
					<div class="sub_top fl"></div>
					<div class="sub_top fr"></div>
					<div class="clear"></div>
				</div>
				<div class="top2 center">
					<div class="sub_top fl"></div>
					<div class="sub_top fl">商品名称</div>
					<div class="sub_top fl">单价</div>
					<div class="sub_top fl">数量</div>
					<div class="sub_top fl">小计</div>
					<div class="sub_top fr">商品号</div>
					<div class="clear"></div>
				</div>
				<br>
				                <%
                
		        for (Iterator iterator = order.getOrderItemslist().iterator(); iterator.hasNext();) {
					OrderItems orderItems = (OrderItems) iterator.next();
					%>
				<div class="content2 center">
					<div class="sub_content fl ">
						
					</div>
					<div class="sub_content fl"><img width="70px" height="70px" src="images/<%=orderItems.getGpicture() %>"></div>
					<div class="sub_content fl ft20"><%=orderItems.getGname() %></div>
					<div class="sub_content fl "><%=orderItems.getGprice()%></div>
					<div class="sub_content fl">
						<span><%=orderItems.getGnum() %></span>
					</div>
					<div class="sub_content fl"><%=(orderItems.getGprice()*orderItems.getGnum())%></div>
					<div class="sub_content fl"><%=orderItems.getGid() %></div>
					<div class="clear"></div>
				</div>
							<%
			}%>
			<div class="content2 center">
					<div class="sub_content fl ">
						
					</div>
					<div class="sub_content fl"></div>
					<div class="sub_content fl ft20"></div>
					<div class="sub_content fl "></div>
					<div class="sub_content fl">总共：</div>
					<div class="sub_content fl"><%=order.getSum() %></div>
					<div class="sub_content fl"></div>
					<div class="clear"></div>
				</div>
				</div>	
			<br>
			<br>
			<%
		}
}
				    	else
				    	{
				    		%>
				    		<div class="jiesuandan mt20 center">

				<div class="jiesuan center">
					<div class="jiesuanjiage fl"><span>没有订单！</span> </div>
					<div class="jiesuanjiage fl"><a  style="font-size: 24px;font-weight: bold;color:#ff6700; text-decoration: underline;" href="index.jsp">去逛逛吧!</a> </div>
					
					<div class="clear"></div>
				</div>
				<div class="clear"></div>
			</div>
				    		<%
				    	}
		%>	
							
			
		</div>

	
	<footer class="mt20 center">			
			<div>京ICP证110507号 京ICP备10046444号 京公网安备11010802020134号 京网文[2014]0059-0009号</div> 
			<div>违法和不良信息举报电话：185-0130-1238，本网站所列数据，除特殊说明，所有数据均出自学生实验测试</div>
	</footer>

  </body>
</html>