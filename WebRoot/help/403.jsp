<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
	<head>
	<base href="<%=basePath%>">
		<title></title>
		<style type=text/css>
.style1 {
	background: url('help/erro-bg.gif') no-repeat center;
	height: 500px;
	width:500px;
	margin: 0 auto;
}
.style2{
	margin: 0 auto;
}
.div1{
	padding-top:20px;
	margin-left: 120px;
	}
.div2{
	margin-bottom:50px;
	margin-left: 120px;
	}
.div3{
	padding-bottom:180px;
	margin-left: 240px;
	}
</style>
	</head>
	<body>
		<table class="style2">
			<tr>
				<td class="style1">
				<div class="div1">服务器出现错误，你不能访问这个页了!</div>
				<div class="div2"> 请联系系统管理员<br></div>
				<div class="div3"><img height="38" src="help/erro-jt.gif" width="56" border="0"/>
				<a href="help/help.jsp" target="_blank">ERROR:403</a>|<a href="login.jsp" target="_top">返回主页</a></div>
				</td>
			</tr>
		</table>
	</body>
</html>
