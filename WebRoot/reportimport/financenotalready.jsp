<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>未结账汇总表</title>
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
		<script type="text/javascript"
			src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="js/common.js"></script>
		<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript"
			src="uploadify/jquery.uploadify.v2.1.4.min.js"></script>
		<script type="text/javascript" src="js/import.js"></script>
		<script type="text/javascript" src="js/mask.js"></script>
		<script type="text/javascript" src="js/jquery.autocomplete.js"></script>
		<script type="text/javascript">
	$(function() {
		compayCodeselect("1", "tonetCodefinanceAlready");
		fulldate("selectbutton", "pa95startmonthfinanceAlready",
				"pa95endmonthfinanceAlready");
	})
</script>

	</head>
	<body class="easyui-layout" scroll="no">
		<div region="center">
			<div id="allreportsearch" style="height: 35%; display: block;">
				<form action="financealready.do?method=getNotFinanceList"
					method="post" id="form" name="">
					<table width="437" border="0" align="center">
						<tr>
							<td align="right">
								交寄日期:
							</td>
							<td>
								<input type="text" name="pa95startmonthfinanceAlready"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
									readonly="readonly" id="pa95startmonthfinanceAlready" value="" />
								-
								<input type="text" name="pa95endmonthfinanceAlready"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
									readonly="readonly" id="pa95endmonthfinanceAlready" value="" />
							</td>
						</tr>
						<tr>
							<td align="right">
								入网企业:
							</td>
							<td>
								<select id="tonetCodefinanceAlready"
									name="tonetCodefinanceAlready" style="width: 160">
									<option value="">
										请选择
								</select>
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<input id="selectbutton" type="submit" value="查 询" />
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</body>
</html>
