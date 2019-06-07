<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'test.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
	<form action="notice.do?method=cheshi" method="post">
		邮件号：<input type="text" name="mailNo" id ="mailNo"><br>
		交寄日期：<input type="text" name="jjtimestart"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
							readonly="readonly" id="jjtimestart" value="" /> - <input
							type="text" name="jjtimeend"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
							readonly="readonly" id="jjtimeend" value="" /><br>
		结算日期：<input type="text" name="jjtimestart"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
							readonly="readonly" id="jjtimestart" value="" /> - <input
							type="text" name="jjtimeend"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
							readonly="readonly" id="jjtimeend" value="" />
							<input type="submit" name="提交" value="提交">
	</form>
  </body>
</html>
