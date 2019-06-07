<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>投递邮件统计</title>
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
<script type="text/javascript" LANGUAGE="javascript">
	$(function() {
		compayCodeselect("1", "entpsCode");
		fulldate("pa95button", "pa95startmonth", "pa95endmonth");
	});
	function woquexport(){
		var isexportfile = "${listall}";
		if (isexportfile == "" || isexportfile == null){
			showmsg("导出的数据为空！");
			return false;
		}else {
			window.open("tdghstatisticsAction.do?method=downfile");
			return true;
		}
	}
	function exportexcel(){
		var isexportfile = "${listall}";
		if (isexportfile == "" || isexportfile == null){
			showmsg("导出的数据为空！");
			return false;
		}else {
			window.open("tdghstatisticsAction.do?method=downEXCEL");
			return true;
		}
	}
</script>
</head>
<body class="easyui-layout">

	<div id="mainPanle" region="center" style="overflow: auto;"
		border="false">

		<!--速递局人员查询页面-->
		<form action="tdghstatisticsAction.do?method=getStatistics"
			method="post" id="form" name="form">
			<table align="center" width="459" border="0">
				<tr>
					<td align="right">邮件号码:</td>
					<td><input type="text" name="mailNum" id="mailNum" value="" />
					</td>
				</tr>
				<tr>
					<td align="right">投递日期:</td>
					<td><input type="text" name="StartDate"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						class="Wdate" readonly="readonly" id="pa95startmonth" value="" />-<input
						type="text" name="EndDate"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						class="Wdate" readonly="readonly" id="pa95endmonth" value="" />
					</td>
				</tr>
				<tr>
					<td align="right">入网企业:</td>
					<td>
						<!--  	<input type="text" name="entpsCode" id="entpsCode" value="" />-->

						<select id="entpsCode" name="entpsCode" style="width: 124px;">
							<option value="">请选择</option>
					</select>
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
				<a href="javascript:void()"
					style="color: green"><input onclick="return woquexport()" type="button"  
					value="导出TXT" />
				</a>
				<a href="javascript:void()"
					style="color: green"><input onclick="return exportexcel()" type="button"
					value="导出EXCEL" />
				</a>

			</div>
			<table id="statisticstable" width="800" border="0" align="center">
				<tr>
					<td width="100">邮件号码</td>
					<td width="100">入网企业</td>
					<td width="200">投递日期</td>
					<td width="350">描述</td>
					<td width="100">妥投/退回</td>
				</tr>
				<c:forEach items="${listall}" var="list">
					<tr>
						<td height="20">${list[0]}</td>
						<td>${list[1]}</td>
						<td>${list[2]}</td>
						<td>${list[3]}</td>
						<td>${list[4]}</td>
					</tr>
				</c:forEach>
				<tr>
					<td width="100">邮件数量</td>
					<td colspan="4" style="color: red">${listsize }</td>
				</tr>
			</table>
		</div>
	</div>
</body>

</html>
