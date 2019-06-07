<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>邮件结算统计</title>
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
		compayCodeselect("1", "Infe_tonet_Code");
		fulldate("pa95button", "pa95startmonth", "pa95endmonth");
	});
	function woquexport(){
		var isexportfile = "${statis}";
		if (isexportfile == "" || isexportfile == null){
			showmsg("导出的数据为空！");
			return false;
		}else {
			window.open("mailSuccessAction.do?method=downfile");
			return true;
		}
	}
	//导出EXCEL文件 
	function exportexcel() {
		var isexportfile = "${statis}";
		if (isexportfile == "" || isexportfile == null) {
			showmsg("导出的数据为空！");
			return false;
		} else {
			window.open("mailSuccessAction.do?method=downEXCEL");
			return true;
		}
	}
</script>
</head>
<body class="easyui-layout">

	<div id="mainPanle" region="center" style="overflow: auto;"
		border="false">

		<!--速递局人员查询页面-->
		<form action="mailSuccessAction.do?method=getStatistics" method="post"
			id="form" name="form">
			<table align="center" width="459" border="0">
				<tr>
					<td align="right">结算日期:</td>
					<td><input type="text" name="StartDate"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" id="pa95startmonth" value="" />-<input
						type="text" name="EndDate"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" id="pa95endmonth" value="" /></td>
				</tr>
				<tr>
					<td align="right">入网企业代码:</td>
					<td>
						<!--  <input type="text" name="Infe_tonet_Code" id="Infe_tonet_Code" value="" />-->

						<select id="Infe_tonet_Code" name="Infe_tonet_Code"
						style="width: 124px;">
							<option value="">请选择</option>
					</select></td>
				</tr>
				<tr>
					<td align="right">结算邮件类型标识:</td>
					<td><SELECT id="BillMailTypes" name="BillMailTypes"
						style="width: 124px;">
							<OPTION selected value="妥投">妥投</OPTION>
							<OPTION value="退回">退回</OPTION>
					</SELECT></td>
				</tr>
				<tr>
					<td></td>
					<td><input id="pa95button" type="submit" value="提交" /></td>
				</tr>
			</table>
		</form>
		<!--速递局人员邮件页面结束-->
		<div>
			<div align="right" style="margin-right: 300px;">
				<a target="_blank" href="javascript:void()" style="color: green"><input
					onclick="return woquexport()" type="button" id="export" value="导出" />
				</a>
				<a  href="javascript:void()"
					style="color: green"><input onclick="return exportexcel()" type="button"
					value="导出EXCEL" />
				</a>
			</div>
			<table width="800" border="0" align="center">
				<tr>
					<td width="200">下级入网企业代码</td>
					<td width="140">邮件数量</td>
					<td width="131">实收费用</td>
					<td width="74">服务费</td>
					<td width="54">结算费</td>
					<td width="131">退回邮费</td>
					<td width="74">合计费用</td>
					<td width="54">结算货款</td>
					<td width="100">结算余额</td>
				</tr>
				<c:forEach items="${statis}" var="list">
					<tr>
						<td height="43">${list[0]}</td>
						<td>${list[1]}</td>
						<td>${list[2]}</td>
						<td>${list[3]}</td>
						<td>${list[4]}</td>
						<td>${list[5]}</td>
						<td>${list[6]}</td>
						<td>${list[7]}</td>
						<td>${list[8]}</td>
						<td>${list[9]}</td>
					</tr>
				</c:forEach>
			</table>
			<table width="800" border="0" align="center">
				<c:forEach items="${listall}" var="list">
					<tr>
						<td height="23">合计</td>
						<td height="23">${list[0]}</td>
						<td>${list[1]}</td>
						<td>${list[2]}</td>
						<td>${list[3]}</td>
						<td>${list[4]}</td>
						<td>${list[5]}</td>
						<td>${list[6]}</td>
						<td>${list[7]}</td>
						<td>${list[8]}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</body>

</html>
