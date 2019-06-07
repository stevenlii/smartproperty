<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>结账出错汇总表</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css"/>
	-->
<link rel="stylesheet" href="uploadify/uploadify.css" type="text/css"></link>
<link rel="stylesheet" type="text/css"
	href="jeasyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="jeasyui/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="css/sys.css" /> 
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="uploadify/swfobject.js"></script>
<script type="text/javascript" src="js/vtip-min.js"></script>
<script type="text/javascript" src="jeasyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript"
	src="uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<script type="text/javascript" src="js/import.js"></script>
<script type="text/javascript" src="js/mask.js"></script>
<script type="text/javascript" src="js/jquery.autocomplete.js"></script>
<script type="text/javascript">
	$(function() {
	 compayCodeselect("1","entpsCode");
	});
</script>
</head>
<body class="easyui-layout">
	<div id="mainPanle" region="center" style="overflow: auto;"
		border="false" >
		<form action="" method="post"
			id="form" name="form">
			<table align="center" width="459" border="0">
				<tr>
					<td align="right"><input type="radio" value="1" name="mailerrortype" checked="checked"></td>
					<td>有结算无交寄	</td>
					<td align="right"><input type="radio" value="0" name="mailerrortype"></td>
					<td>应收货款和实收货款不符</td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td><input id="pa95button" type="submit" value="提交" />
					<td></td>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>

</html>
