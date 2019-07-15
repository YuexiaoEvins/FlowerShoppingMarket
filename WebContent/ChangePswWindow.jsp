<%@page import="util.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/login.css">
<title>更改密码</title>
<script type="text/javascript">
function CheckPassword()
{
	var strText = document.getElementById("password").value;
	var strRefill = document.getElementById("refill").value; 
	var refill1 = document.getElementById("refill1");
	var password1 = document.getElementById("password1");
	password1.style.color="red";
	if(strText==null||strText=="")
	{
		password1.innerHTML="密码不能为空！";
		return false;
	}else {
		if (strText==strRefill) {
			refill1.innerHTML=null;
		}
		password1.innerHTML=null;
		return true;
	}	
}
function CheckRefill()
{
	var strText = document.getElementById("refill").value;
	var passwordText = document.getElementById("password").value;
	var refill1 = document.getElementById("refill1");
	refill1.style.color="red";
	if(strText==null||strText==""||strText!=passwordText)
	{
		refill1.innerHTML="请输入相同密码！";
		return false;
	}else {
		refill1.innerHTML=null;
		return true;
	}	
}
function CheckSubmit(){
	if (CheckPassword()&&CheckRefill()) {
		return true;
	}
	else {
		alert("密码输入不正确，请填写完！");
		return false;
	}
}
</script>
</head>
<body>
<form action="ChangePsw.jsp" method="post" onsubmit="return CheckSubmit()">

		<div class="regist">
			<div class="regist_center">
				<div class="regist_top">
					<div class="left fl">会员注册</div>
					<div class="right fr"><a href="index.jsp" target="_self">商城主页</a></div>
					<div class="clear"></div>
					<div class="xian center"></div>
				</div>
				<div class="regist_main center">
					<div class="username"><span style="color: red">*&nbsp;</span>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:&nbsp;&nbsp;<input class="shurukuang" type="password" onblur="CheckPassword()" name="password" id="password" placeholder="请输入你的密码"/><span id="password1">请输入6位以上字符</span></div>
					<div class="username"><span style="color: red">*&nbsp;</span>确认密码:&nbsp;&nbsp;<input class="shurukuang" type="password" onblur="CheckRefill()" name="refill" id="refill" placeholder="请确认你的密码"/><span id="refill1">两次密码要输入一致哦</span></div>
				</div>
				<div class="regist_submit">
					<input class="submit" type="submit" name="register" value="更改密码" >
				</div>
				<div class="regist_submit">
					<input class="submit" type="reset" name="rewrite" value="重填" >
				</div>
			</div>
		</div>
</form>
</body>
</html>