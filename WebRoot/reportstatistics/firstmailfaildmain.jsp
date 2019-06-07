<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>首次未妥投</title>
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
		fulldate("pa95button", "pa95startmonth", "pa95endmonth");
	});
	function woquexport(){
		var isexportfile = "${firstmailfaild}";
		if (isexportfile == "" || isexportfile == null){
			showmsg("导出的数据为空！");
			return false;
		}else {
			window.open("statisticsTdghFristFaildAction.do?method=downfile");
			return true;
		}
	}
	//导出EXCEL文件 
	function exportexcel() {
		var isexportfile = "${firstmailfaild}";
		if (isexportfile == "" || isexportfile == null) {
			showmsg("导出的数据为空！");
			return false;
		} else {
			window.open("statisticsTdghFristFaildAction.do?method=downEXCEL");
			return true;
		}
	}
</script>
</head>
<body class="easyui-layout">
	<div id="mainPanle" region="center" style="overflow: auto;"
		border="false">

		<!--速递局人员查询页面-->
		<form action="statisticsTdghFristFaildAction.do?method=getStatistics"
			method="post" id="form" name="form">
			<table align="center" width="459" border="0">
				<tr>
					<td align="right">处理日期:</td>
					<td><input type="text" name="StartDate"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						class="Wdate" readonly="readonly" id="pa95startmonth" value="" />-<input
						type="text" name="EndDate"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						class="Wdate" readonly="readonly" id="pa95endmonth" value="" />
					</td>
				</tr>
				<tr>
					<td></td>
					<td><input id="pa95button" type="submit" value="提交" />
					</td>
				</tr>
			</table>
		</form>
		<!--速递局人员邮件页面结束-->
		<div>
			<div align="right" style="margin-right: 300px;">

				<a  href="javascript:void()" style="color: green"><input
					onclick="return woquexport()" type="button" id="export" value="导出" />
				</a>
				<a  href="javascript:void()"
					style="color: green"><input onclick="return exportexcel()" type="button"
					value="导出EXCEL" />
				</a>

			</div>
			<table width="700" border="0" align="center">
				<tr>
					<td width="80">处理日期</td>
					<td width="100">邮件号码</td>
					<td width="120">入网公司</td>
					<td width="120">处理说明</td>

				</tr>
				<c:forEach items="${firstmailfaild}" var="list">
					<tr>
						<td height="23">${list[0]}</td>
						<td>${list[1]}</td>
						<td>${list[2]}</td>
						<td>${list[3]}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</body>

</html>
