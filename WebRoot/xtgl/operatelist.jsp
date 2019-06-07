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
<link href="css/sys.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css"
	href="jeasyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="jeasyui/themes/icon.css">
<script src="js/jquery.js"></script>
<script type="text/javascript" src="jeasyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript">
	$(function() {
		operatelist();
		//operateselect('operate', 'operateddid');
		operatetree('operate', 'operateddid');
		octree('moduleId');
	});

	/**
	 * 下拉显示树形结构
	 */
	function octree(selectid) {
		$("#" + selectid).combotree({
			required : true,
			multiple : true,
			cache : false,
			url : "operate.do?method=orgCombotree"
		});

	}
	function operatetree(tbtype, selectId) {
		$("#" + selectId).combotree(
				{
					required : true,
					multiple : true,
					cache : false,
					url : "dd.do?method=getoperatetree&tbtype=" + tbtype
							+ "&nowdate=" + new Date()
				});

	}

	/**
	 * 显示列表
	 */
	function operatelist() {
		$("#tab").datagrid({
			singleSelect : true,
			fit : true,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "operate.do?method=getList",
			columns : [ [ {
				field : "ck",
				checkbox : true
			}, {
				field : "modulePName",
				title : "顶级目录",
				width : fillsize(0.2),
				formatter : function(value, rec) {
					return rec.sysModule.modulePName;
				}
			}, {
				field : "moduleName",
				title : "模块名",
				width : fillsize(0.2),
				formatter : function(value, rec) {
					return rec.sysModule.moduleName;
				}
			}, {
				field : "cnname",
				title : "操作名",
				width : fillsize(0.2),
				formatter : function(value, rec) {
					return rec.sysssDd.cnname;
				}
			} ] ],
			pagination : true,
			toolbar : [ {
				text : "添加",
				iconCls : "icon-add",
				handler : function() {
					addoperate();
				}
			}, "-", {
				text : "修改",
				iconCls : "icon-edit",
				handler : function() {
					var row = $("#tab").datagrid("getSelected");
					if (row == null) {
						$.messager.alert("警告信息", "选择一条记录", "warning");
					} else {
						updateoperate(row);
					}
				}
			}, "-", {
				text : "删除",
				iconCls : "icon-remove",
				handler : function() {
					var row = $("#tab").datagrid("getSelected");
					if (row == null) {
						$.messager.alert("警告信息", "选择一条要删除的记录！", "warning");
					} else {
						$.messager.confirm("确认", "确定要删除?", function(r) {
							if (r) {
								deleteoperate(row);
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

	/**
	 * 添加操作
	 */
	function addoperate() {
		resetContent("operatebean");
		$("#addoperate").show();
		$("#addoperate")
				.dialog(
						{
							title : "添加操作",
							modal : true,
							width : 400,
							height : 260,
							collapsible : true,
							minimizable : false,
							maximizable : false,
							buttons : [
									{
										text : "添加",
										iconCls : "icon-ok",
										handler : function() {
											var moduleIds = [];
											var ddids = [];
											var rowselect = $('#moduleId')
													.combo("getValues");
											var ddidselect = $('#operateddid')
													.combo("getValues");
											for ( var i = 0; i < rowselect.length; i++) {
												moduleIds.push(rowselect[i]);
											}
											for ( var i = 0; i < ddidselect.length; i++) {
												ddids.push(ddidselect[i]);
											}
											if (moduleIds.length > 0
													&& ddids.length > 0) {
												$
														.ajax({
															type : "POST",
															dataType : "text",
															url : "operate.do?method=addOperate&nowdate="
																	+ new Date(),
															data : {
																"moduleIdall" : moduleIds
																		.join(","),
																"ddidall" : ddids
																		.join(",")
															},
															success : function(
																	data) {
																$.messager
																		.show({
																			title : "提示信息",
																			msg : data,
																			showType : "show",
																			timeout : 3000
																		});
																flashTable("tab");
															}
														});
												$("#addoperate")
														.dialog("close");
											} else {
												$.messager.alert("提示信息",
														"请选择！", "warning");
											}
										}
									}, {
										text : "取消",
										iconCls : "icon-undo",
										handler : function() {
											$("#addoperate").dialog("close");
										}
									} ]
						});
	}
	/**
	 * 删除操作
	 */
	function deleteoperate(row) {
		$.ajax({
			type : "POST",
			dataType : "text",
			url : "operate.do?method=delOperate&nowdate=" + new Date(),
			data : {
				"operateid" : row.operateid
			},
			success : function(data) {
				flashTable("tab");
				showmsg(data);
			}
		});
	}
	/**
	 *更新操作
	 */

	function updateoperate(row) {

		resetContent("operatebean");
		$("#operateid").attr("value", row.operateid);
		$("#operateddid").combo("setValue", row.sysssDd.ddid);
		$("#moduleId").combotree("setValue", row.sysModule.moduleId);
		$("#moduleId").combotree("setText", row.sysModule.moduleName);

		$("#addoperate").show();
		$("#addoperate").dialog({
			title : "更新操作",
			modal : true,
			width : 400,
			height : 260,
			collapsible : true,
			minimizable : false,
			maximizable : false,
			buttons : [ {
				text : "更新",
				iconCls : "icon-ok",
				handler : function() {
					$("#operatebean").form("submit", {
						url : "operate.do?method=updateoperate",
						onSubmit : function() {
							return $(this).form("validate");
						},
						success : function(data) {
							$("#addoperate").dialog("close");
							flashTable("tab");
							showmsg(data);
						}
					});
				}
			}, {
				text : "取消",
				iconCls : "icon-undo",
				handler : function() {
					$("#addoperate").dialog("close");
				}
			} ]
		});

	}
</script>
</head>

<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
	<div id="mainPanle" region="center" style="overflow: hidden"
		border="false">
		<table id="tab" width="100%" height="100%" border="false"></table>
	</div>
	<div id="addoperate" style="display: none; text-align: center;">
		<form action="" method="post" id="operatebean" name="operatebean">
			<input type="hidden" name="operateid" id="operateid"> 模块 <select
				name="moduleId" id="moduleId" class="easyui-validatebox"
				style="width: 130px">
				<option value="">请选择</option>
			</select> 操作名: <select id="operateddid" name="ddid" style="width: 130px;"
				class="easyui-validatebox">
				<option value="">请选择</option>
			</select>
		</form>
	</div>
</body>
</html>

