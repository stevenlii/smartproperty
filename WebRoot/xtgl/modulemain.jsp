<%@ page language="java" pageEncoding="utf-8"%>
<html>
<head>
<%
	response.addHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统</title>

<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/vtip-min.js"></script>
<script type="text/javascript" src="jeasyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<link rel="stylesheet" type="text/css"
	href="jeasyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="jeasyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="css/sys.css">
<script type="text/javascript">
	$(function() {
		showModule();
	});

	/**
	 * 模块列表
	 */
	function showModule() {
		$("#tab")
				.datagrid(
						{
							singleSelect : true,
							fit : true,
							pageSize : 20,
							pageList : [ 20, 30, 50 ],
							url : "module.do?method=getModuleById",
							columns : [ [ {
								field : "ck",
								checkbox : true
							}, {
								field : "moduleName",
								title : "模块名称",
								width : fillsize(0.1)
							}, {
								field : "moduleUrl",
								title : "模块映射路径",
								width : fillsize(0.2)
							}, {
								field : "modulePxh",
								title : "序号",
								width : fillsize(0.05)
							}, {
								field : "modulePName",
								title : "父类模块名",
								width : fillsize(0.2)
							} ] ],
							pagination : true,
							toolbar : [
									{
										text : "添加",
										iconCls : "icon-add",
										handler : function() {
											 $("#modulePxh").numberbox("clear");
											showModuleParent('modulePid');
											add("模块列表", "moduleform",
													"addmodule",
													"module.do?method=addModule&newdate="+ new Date());
										}
									},
									"-",
									{
										text : "修改",
										iconCls : "icon-edit",
										handler : function() {
											var row = $("#tab").datagrid(
													"getSelected");
											if (row == null) {
												$.messager.alert("警告信息",
														"选择一条记录", "warning");
											} else {
												
												showModuleParent('modulePid');
												modifymodule("模块列表",
														"moduleform", row,
														"addmodule",
														"module.do?method=updateModule");
											}
										}
									},
									"-",
									{
										text : "删除",
										iconCls : "icon-remove",
										handler : function() {
											var row = $("#tab").datagrid(
													"getSelected");
											if (row == null) {
												$.messager.alert("警告信息",
														"选择一条要删除的记录！",
														"warning");
											} else {
												$.messager
														.confirm(
																"确认",
																"确定要删除?",
																function(r) {
																	if (r) {
																		dele(
																				row.moduleId,
																				'module.do?method=deleteModule');
																	}
																});
											}
										}
									}, "-", {
										text : "清除选择",
										iconCls : "icon-cancel",
										handler : function() {
											clearSelect("tab");
										}
									} ]
						});
	}
	function modifymodule(updattitle, updatform, row, updatId, updatMethod) {
		resetContent(updatform);
		$("#moduleId").attr("value", row.moduleId);
		$("#moduleName").attr("value", row.moduleName);
		$("#modulePxh").numberbox("setValue", row.modulePxh);
		$("#moduleUrl").attr("value", row.moduleUrl);
		$("#modulePid").attr("value", row.modulePid);
		updat(updattitle, updatform, updatId, updatMethod);
	}
</script>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">

	<div id="mainPanle" region="center" style="overflow: hidden" border="false">
		<table id="tab" border="false"></table>
	</div>
	<div id="addmodule" style="display: none;text-align: center;">
		<form action="" name="moduleform" id="moduleform" method="post">
			<input type="hidden" name="moduleId" id="moduleId">
			<table>
				<tr>
					<td>模块名称：</td>
					<td><input type="text" name="moduleName" id="moduleName"
						class="easyui-validatebox" required="true">
					</td>
				</tr>
				<tr>
					<td>排序号：</td>
					<td><input type="text" name="modulePxh" id="modulePxh"
						class="easyui-numberbox">
					</td>
				</tr>
				<tr>
					<td>映射路径：</td>
					<td><input type="text" name="moduleUrl" id="moduleUrl"
						class="easyui-validatebox" required="true">
					</td>
				</tr>
				<tr>
					<td>上级模块：</td>
					<td><select name="modulePid" id="modulePid"
						class="easyui-validatebox" style="width: 130px">
							
					</select>
					</td>

				</tr>
			</table>
		</form>
	</div>
	<div id="selectrole"
		style="display: none;text-align: center;overflow: hidden;">
		<table id="roletomodule"
			style="width: 565px;height: 328px;overflow: hidden;"></table>
	</div>
</body>
</html>