<%@page import="util.ItemsDAO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="util.*"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>购物车</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
<script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
<script type="text/javascript">
//减数量
function reductionOf(obj) {
            //减前判断
	if ($(obj).next().val() == '' || $(obj).next().val() <= 1) {
		$(obj).next().val(1);
	}
	else{
		$(obj).next().val(parseInt($(obj).next().val()) - 1);//数值减
	}
	
	$(obj).next().val($(obj).next().val());//赋值给框
}
    //加数量
function add(obj) {
            //加前判断

	if ($(obj).prev().val() == '') {
		$(obj).prev().val(1);
	}
    $(obj).prev().val(parseInt($(obj).prev().val()) + 1);//数值加
    $(obj).prev().val($(obj).prev().val());//赋值给框

}
//校验数字格式（只能输入正整数）
function checkNumber(obj) {
	var reg = /^[1-9]\d*$/;
	if(!reg.test($(obj).val()) || $(obj).val()==''){
		$(obj).val(1);
	}
}

function checkEnsure() {
	if (<%=((String) session.getAttribute("userId")==null) %>) {
		return false;
	}
	document.getElementById('action').value='ensure';
	this.form.submit()
}
function submitYouForm(path,num){
 $('form'+num).action=path;
 $('form'+num).submit();
}
$(function(){
    $("input[type='checkbox']").click(function() {
		document.getElementById("isChecked").innerHTML=$("input[type='checkbox']:checked").length
    });
})
</script>
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
					<li><a href="order.jsp">个人订单</a></li>
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
			<div class="gwcxd center">
				<div class="top2 center">
					<div class="sub_top fl">勾选商品</div>
					<div class="sub_top fl">商品名称</div>
					<div class="sub_top fl">单价</div>
					<div class="sub_top fl">数量</div>
					<div class="sub_top fl">小计</div>
					<div class="sub_top fr">商品号</div>
					<div class="clear"></div>
				</div>
						<%
			HashMap shoppingCar = (HashMap) session.getAttribute("shoppingCar");
			int sum=0;
			if (shoppingCar != null) {
				ItemsDAO itemsDao = new ItemsDAO();
				Items item = new Items();
				
				Iterator iterator = shoppingCar.entrySet().iterator();
				while (iterator.hasNext()) {
					Map.Entry entry = (Map.Entry) iterator.next();
					int key = (int) entry.getKey();
					String temp_num = (String) entry.getValue();
					int num = Integer.parseInt(temp_num);
					item = itemsDao.getItemById(key);
					sum+=(num*item.getPrice());
					
		%>
				<form action="/WebTest4/AddItemServlet" name="form1" id="form1" method="post">
				<div class="content2 center">
					<div class="sub_content fl ">
						<input type="checkbox" name="good_id" value="<%=key %>" class="quanxuan" />
					</div>
					<div class="sub_content fl"><img width="70px" height="70px" src="images/<%=item.getPicture()%>"></div>
					<div class="sub_content fl ft20"><%=item.getName() %></div>
					<div class="sub_content fl "><%=item.getPrice() %></div>
					<div class="sub_content fl">
						<input class="shuliang" type="number" name="quantity" value="<%=num %>" step="1" min="1" max="99">
					</div>
					<div class="sub_content fl"><%=(num*item.getPrice()) %></div>
					<div class="sub_content fl"><%=item.getId() %></div>
					<div class="clear"></div>
				</div>
							<%
			}
		}
		%>	
							<input type="hidden" id="action" name="action">
				</form>	
			</div>
			<div class="jiesuandan mt20 center">
				<div class="tishi fl ml20">
					<ul>
						<li><input type="button" value="update" id="update" onclick="document.getElementById('action').value='update';document.getElementById('form1').submit()"></li>
						<li>|</li>
						<li><input type="button" value="delete" id="delete" onclick="document.getElementById('action').value='delete';document.getElementById('form1').submit()"></li>
						<li>|</li>
						<li><a href="index.jsp">继续购物</a></li>
						<li>|</li>
						
						<li>共<span><%if(shoppingCar==null)
										out.print(0);
						else
							out.print(shoppingCar.size());
							 %></span>件商品，已选择<span id="isChecked">0</span>件</li>
						<div class="clear"></div>
					</ul>
				</div>
				
				<div class="jiesuan fr">	
					<div class="jiesuanjiage fl">合计（不含运费）：<span><%=sum %></span></div>
					<div class="jsanniu fr"><input class="jsan" type="submit"value="确认订单" id="ensure" onclick="document.getElementById('action').value='ensure';document.getElementById('form1').submit()"/></div>
					<div class="clear"></div>
				</div>
				<div class="clear"></div>
			</div>			
		</div>

	
	<footer class="mt20 center">			
			<div>京ICP证110507号 京ICP备10046444号 京公网安备11010802020134号 京网文[2014]0059-0009号</div> 
			<div>违法和不良信息举报电话：185-0130-1238，本网站所列数据，除特殊说明，所有数据均出自学生实验测试</div>
	</footer>
</body>
</html>