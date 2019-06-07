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
		<script type="text/javascript"
			src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="js/common.js"></script>
		<link rel="stylesheet" type="text/css"
			href="jeasyui/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="jeasyui/themes/icon.css">
		<link rel="stylesheet" type="text/css" href="css/sys.css">
		<script type="text/javascript">

	$(function() {
	});
	//添加模块
	function addaction() {
		resetContent("moduleform");
		var node = $("#moduleTree").tree("getSelected");
		if (node == null) {
			$("#modulePid").attr("value", "-1");
		} else {
			$("#modulePid").attr("value", node.id);
		}
		$("#addmodule").show();
		$("#addmodule").dialog({
			title : "添加模块",
			modal : true,
			width : 280,
			height : 200,
			collapsible : true,
			minimizable : false,
			maximizable : false,
			buttons : [ {
				text : "提交",
				iconCls : "icon-ok",
				handler : function() {
					$("#moduleform").form("submit", {
						url : "module.do?method=addModule",
						onSubmit : function() {
							return $(this).form("validate");
						},
						success : function(data) {
							$("#addmodule").dialog("close");
							$.messager.show({
								title : "提示信息",
								msg : data,
								showType : "show",
								timeout : 3000
							});
							reload();
						}
					});
				}
			}, {
				text : "取消",
				handler : function() {
					$("#addmodule").dialog("close");
				}
			} ]
		});
	}
	//更新模块
	function updateaction() {
		var node = $("#moduleTree").tree("getSelected");
		if (node == null) {
			$.messager.alert("警告信息", "请选择要修改的模块！", "info");
		}
		$.ajax({
			type : "POST",
			dataType : "json",
			url : "module.do?method=toeditModule&nowdate=" + new Date(),
			data : {
				"moduleId" : node.id
			},
			success : function(data) {
				$("#moduleId").attr("value", data.moduleId);
				$("#modulePid").attr("value", data.modulePid);
				$("#moduleName").attr("value", data.moduleName);
				$("#moduleUrl").attr("value", data.moduleUrl);
				$("#modulePxh").numberbox("setValue", data.modulePxh);
			}
		});
		$("#addmodule").show();
		$("#addmodule").dialog({
			title : "更新模块",
			modal : true,
			width : 280,
			height : 200,
			collapsible : true,
			minimizable : false,
			maximizable : false,
			buttons : [ {
				text : "提交",
				iconCls : "icon-ok",
				handler : function() {
					$("#moduleform").form("submit", {
						url : "module.do?method=updateModule",
						onSubmit : function() {
							return $(this).form("validate");
						},
						success : function(data) {
							$("#addmodule").dialog("close");
							$.messager.show({
								title : "提示信息",
								msg : data,
								showType : "show",
								timeout : 3000
							});
							reload();
						}
					});
				}
			}, {
				text : "取消",
				handler : function() {
					$("#addmodule").dialog("close");
				}
			} ]
		});
	}
	//更新模块
	function deleteaction() {
		var node = $("#moduleTree").tree("getSelected");
		if (node == null) {
			$.messager.alert("警告信息", "请选择要修改的模块！", "info");
		}
		$.ajax({
			type : "POST",
			dataType : "text",
			url : "module.do?method=deleteModule&nowdate=" + new Date(),
			data : {
				"moduleId" : node.id
			},
			success : function(data) {
				$.messager.show({
					title : "提示信息",
					msg : data,
					showType : "show",
					timeout : 3000
				});
				reload();
			}
		});
	}
</script>
	</head>
	<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
		<div id="mainPanle" region="center" style="overflow: hidden">
			<table id="moduletab"></table>
		</div>
		<div id="addmodule"  style="display: none;text-align: center;">
			<form action="" name="moduleform"
				id="moduleform" method="post">
				<input type="hidden" name="modulePid" id="modulePid">
				<input type="hidden" name="moduleId" id="moduleId">
				<table>
					<tr>
						<td>
							模块名称：
						</td>
						<td>
							<input type="text" name="moduleName" id="moduleName"
								class="easyui-validatebox" required="true">
						</td>
					</tr>
					<tr>
						<td>
							排序号：
						</td>
						<td>
							<input type="text" name="modulePxh" id="modulePxh"
							class="easyui-numberbox">
						</td>
					</tr>
					<tr>
						<td>
							访问路径：
						</td>
						<td>
							<input type="text" name="moduleUrl" id="moduleUrl"
								class="easyui-validatebox" required="true">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>