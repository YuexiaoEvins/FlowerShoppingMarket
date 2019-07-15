<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/login.css">
<title>登录界面</title>
<script type="text/javascript">
function CheckId() 
{
	var strText = document.getElementById("id").value;
	var id1 = document.getElementById("id1");
	id1.style.color="red";
	if(strText==null||strText=="")
	{
		id1.innerHTML="用户名不能为空！";
		return false;
	}else {
		id1.innerHTML=null;
		return true;
	}	
}	

function CheckPassword()
{
	var strText = document.getElementById("password").value;
	var password1 = document.getElementById("password1");
	password1.style.color="red";
	if(strText==null||strText=="")
	{
		password1.innerHTML="密码不能为空！";
		return false;
	}else {
		password1.innerHTML=null;
		return true;
	}	
}
function CheckSubmit(){
	if (CheckId()&&CheckPassword()) {
		return true;
	}
	else {
		alert("信息不完全，请填写完！");
		return false;
	}
}
</script>
</head>
<body>
	<!-- login -->
		<div class="top center">
			<div class="logo center">
				<a href="./index.html" target="_blank"><img src="./image/mistore_logo.png" alt=""></a>
			</div>
		</div>
		<form  method="post" action="Loginsuccess.jsp" onsubmit="return CheckSubmit()" class="form center">
		<div class="login">
			<div class="login_center">
				<div class="login_top">
					<div class="left fl">会员登录</div>
					<div class="right fr">您还不是我们的会员？<a href="registered.jsp" target="_self">立即注册</a></div>
					<div class="clear"></div>
					<div class="xian center"></div>
				</div>
				<div class="login_main center">
					<div class="username">用户名:&nbsp;<input class="shurukuang" type="text" onblur="CheckId()" name="id" id="id" placeholder="请输入你的用户名"/><br><a id="id1"></a></div>
					<div class="username">密&nbsp;&nbsp;&nbsp;&nbsp;码:&nbsp;<input class="shurukuang" type="text" name="password" onblur="CheckPassword()" id="password" placeholder="请输入你的密码"/><br><a id="password1"></a></div>			
				</div>
				<div class="login_submit">
					<input class="submit" type="submit" name="submit" value="立即登录" >
				</div>
				<div class="login_submit">
					<input class="submit" type="reset" name="reset" value="重置" >
				</div>
			</div>
		</div>
		</form>

	</form>
		<footer>
			<div class="copyright">简体（开发中） | 繁体（开发中） | English（开发中） | 常见问题（开发中）</div>
			<div class="copyright">本网站全部数据仅仅用于学习实验，非商用</div>

		</footer>
</body>
</html>