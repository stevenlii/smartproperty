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
		$("#roletree").tree({
			url : "role.do?method=showRoleTree",
			onClick : function() {
				var node = $("#roletree").tree("getSelected");
				showRoleToUserTab(node.id);
				showModuleToRoleTab(node.id);
				showOperateToRoleTab(node.id);
			},
			onLoadError : function() {
				$.messager.alert("提示", "角色树加载数据出错~~", "error");
			}
		});
	});

	//模块树刷新方法

	function reload() {
		var node = $("#roletree").tree("getSelected");
		if (node) {
			$("#roletree").tree("reload", node.target);
		} else {
			$("#roletree").tree("reload");
		}
	}
	function showRoleToUserTab(nodeid) {
		$("#roletab").datagrid({
			fit : true,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "role.do?method=getRoleUserByRoleId&nodeId=" + nodeid,
			columns : [ [ {
				field : "ck",
				checkbox : true
			}, {
				field : "username",
				title : "角色对应的用户ID",
				width : fillsize(0.4),
				formatter : function(value, rec) {
					return rec.tbAdmUser.username;
				}
			}, {
				field : "ryname",
				title : "角色对应的用户姓名",
				width : fillsize(0.4),
				formatter : function(value, rec) {
					return rec.tbAdmUser.ryname;
				}
			} ] ],
			pagination : true,
			toolbar : [ {
				text : "添加所选角色对应用户",
				iconCls : "icon-add",
				handler : function() {
					adduserToRole();
				}
			}, "-", {
				text : "删除所选角色对应用户",
				iconCls : "icon-remove",
				handler : function() {
					var row = $("#roletab").datagrid("getSelected");
					if (row == null) {
						$.messager.alert("提示", "选择一条记录", "info");
					} else {
						deleteuserFromRole();
					}
				}
			} ]
		});
	}
	//添加所选角色对应用户
	function adduserToRole() {
		$("#cc").combotree({  
		    url:""  
		}); 
		var node = $("#roletree").tree("getSelected");
		$("#usertorole").datagrid({
			pageSize : 50,
			pageList : [ 50, 100, 200 ],
			url : "AdmUser.do?method=getSelectList",
			columns : [ [ {
				field : "ck",
				checkbox : true
			}, {
				field : "username",
				title : "用户登录名",
				width : fillsize(0.18)
			}, {
				field : "deptname",
				title : "所属公司",
				width : fillsize(0.16),
				formatter : function(value, rec) {
					return rec.tbadmDept.deptname;
				}
			}, {
				field : "remark",
				title : "备注",
				width : fillsize(0.15)
			} ] ],
			pagination : true
		});
		$("#selectUser").show();
		$("#selectUser")
				.dialog(
						{
							title : "选择用户",
							modal : true,
							width : 580,
							height : 400,
							collapsible : true,
							minimizable : false,
							maximizable : false,
							buttons : [
									{
										text : "提交",
										iconCls : "icon-ok",
										handler : function() {
											var ids = [];
											var rows = $("#usertorole")
													.datagrid("getSelections");
											for ( var i = 0; i < rows.length; i++) {
												ids.push(rows[i].userid);
											}
											if (ids.length > 0) {
												$
														.ajax({
															type : "POST",
															dataType : "text",
															url : "role.do?method=addUserToRole&nowdate="
																	+ new Date(),
															data : {
																"userIds" : ids
																		.join(),
																"roleId" : node.id
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
																showRoleToUserTab(node.id);
															}
														});
												$("#selectUser")
														.dialog("close");
											} else {
												$.messager.alert("提示信息",
														"没有选择角色！", "warning");
											}

										}
									}, {
										text : '取消',
										handler : function() {
											$("#selectUser").dialog("close");
										}
									} ]
						});
	}
	function deleteuserFromRole() {
		var node = $("#roletree").tree("getSelected");
		var ids = [];
		var rows = $("#roletab").datagrid("getSelections");
		for ( var i = 0; i < rows.length; i++) {
			ids.push(rows[i].roleUserId);
		}
		$.ajax({
			type : "POST",
			dataType : "text",
			url : "role.do?method=deleteUserFromRole&nowdate=" + new Date(),
			data : {
				"roleUserIds" : ids.join()
			},
			success : function(data) {
				$.messager.show({
					title : "提示信息",
					msg : data,
					showType : "show",
					timeout : 3000
				});
				showRoleToUserTab(node.id);
			}
		});

	}
	//////////////////////////////////////////////////////////////////////////////
	//添加模块到角色
	function addModuleToRole() {
		var node = $("#roletree").tree("getSelected");
		$("#usertorole").datagrid({
			pageSize : 50,
			pageList : [ 50, 100, 200 ],
			url : "module.do?method=getModuleById",
			columns : [ [ {
				field : "ck",
				checkbox : true
			}, {
				field : "moduleName",
				title : "模块名",
				width : fillsize(0.18)
			}, {
				field : "moduleUrl",
				title : "映射路径",
				width : fillsize(0.16)
			}, {
				field : "modulePName",
				title : "父目录",
				width : fillsize(0.15)
			} ] ],
			pagination : true
		});
		$("#selectUser").show();
		$("#selectUser")
				.dialog(
						{
							title : "选择模块",
							modal : true,
							width : 580,
							height : 400,
							collapsible : true,
							minimizable : false,
							maximizable : false,
							buttons : [
									{
										text : "提交",
										iconCls : "icon-ok",
										handler : function() {
											var ids = [];
											var rows = $("#usertorole")
													.datagrid("getSelections");
											for ( var i = 0; i < rows.length; i++) {
												ids.push(rows[i].moduleId);
											}
											if (ids.length > 0) {
												$
														.ajax({
															type : "POST",
															dataType : "text",
															url : "role.do?method=addModuleToRole&nowdate="
																	+ new Date(),
															data : {
																"ids" : ids
																		.join(),
																"roleId" : node.id
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
																showModuleToRoleTab(node.id);
															}
														});
												$("#selectUser")
														.dialog("close");
											} else {
												$.messager.alert("提示信息",
														"没有选择模块！", "warning");
											}

										}
									}, {
										text : '取消',
										handler : function() {
											$("#selectUser").dialog("close");
										}
									} ]
						});
	}
	function showModuleToRoleTab(nodeid) {

		$("#moduletab").datagrid({
			fit : true,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "role.do?method=getModuleRoleByRoleId&nodeId=" + nodeid,
			columns : [ [ {
				field : "ck",
				checkbox : true
			}, {
				field : "moduleName",
				title : "角色对应的模块名称",
				width : fillsize(0.4),
				formatter : function(value, rec) {
					return rec.sysModule.moduleName;
				}
			}, {
				field : "moduleUrl",
				title : "角色对应的模块映射路径",
				width : fillsize(0.4),
				formatter : function(value, rec) {
					return rec.sysModule.moduleUrl;
				}
			} ] ],
			pagination : true,
			toolbar : [ {
				text : "添加角色对应的模块",
				iconCls : "icon-add",
				handler : function() {
					addModuleToRole();
				}
			}, "-", {
				text : "删除角色对应的模块",
				iconCls : "icon-remove",
				handler : function() {
					var row = $("#moduletab").datagrid("getSelected");
					if (row == null) {
						$.messager.alert("提示", "选择一条记录", "info");
					} else {
						deleteModuleFromRole();
					}
				}
			} ]
		});
	}
	function deleteModuleFromRole() {
		var node = $("#roletree").tree("getSelected");
		var ids = [];
		var rows = $("#moduletab").datagrid("getSelections");
		for ( var i = 0; i < rows.length; i++) {
			ids.push(rows[i].moduleRoleId);
		}
		$.ajax({
			type : "POST",
			dataType : "text",
			url : "role.do?method=deleteModuleFromRole&nowdate=" + new Date(),
			data : {
				"ids" : ids.join()
			},
			success : function(data) {
				$.messager.show({
					title : "提示信息",
					msg : data,
					showType : "show",
					timeout : 3000
				});
				showModuleToRoleTab(node.id);
			}
		});

	}
	///////////////////////////////////////////////////////////////////////////////////////
	//添加操作到角色
	function addOperateToRole() {
		var node = $("#roletree").tree("getSelected");
		$("#usertorole").datagrid({
			pageSize : 50,
			pageList : [ 50, 100, 200 ],
			url : "operate.do?method=getList&nowdate" + new Date(),
			columns : [ [ {
				field : "ck",
				checkbox : true
			}, {
				field : "cnname",
				title : "操作名",
				width : fillsize(0.2),
				formatter : function(value, rec) {
					return rec.sysssDd.cnname;
				}
			}, {
				field : "moduleName",
				title : "所属模块名",
				width : fillsize(0.2),
				formatter : function(value, rec) {
					return rec.sysModule.moduleName;
				}
			}, {
				field : "modulePName",
				title : "模块顶级目录",
				width : fillsize(0.2),
				formatter : function(value, rec) {
					return rec.sysModule.modulePName;
				}
			} ] ],
			pagination : true
		});
		$("#selectUser").show();
		$("#selectUser")
				.dialog(
						{
							title : "选择操作",
							modal : true,
							width : 580,
							height : 400,
							collapsible : true,
							minimizable : false,
							maximizable : false,
							buttons : [
									{
										text : "提交",
										iconCls : "icon-ok",
										handler : function() {
											var ids = [];
											var rows = $("#usertorole")
													.datagrid("getSelections");
											for ( var i = 0; i < rows.length; i++) {
												ids.push(rows[i].operateid);
											}
											if (ids.length > 0) {
												$
														.ajax({
															type : "POST",
															dataType : "text",
															url : "role.do?method=addOperateToRole&nowdate="
																	+ new Date(),
															data : {
																"ids" : ids
																		.join(),
																"roleId" : node.id
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
																showOperateToRoleTab(node.id);
															}
														});
												$("#selectUser")
														.dialog("close");
											} else {
												$.messager.alert("提示信息",
														"没有选择模块！", "warning");
											}

										}
									}, {
										text : '取消',
										handler : function() {
											$("#selectUser").dialog("close");
										}
									} ]
						});
	}
	function showOperateToRoleTab(nodeid) {

		$("#operatetab").datagrid({
			fit : true,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "role.do?method=getOperateRoleByRoleId&nodeId=" + nodeid,
			columns : [ [ {
				field : "ck",
				checkbox : true
			}, {
				field : "modulePName",
				title : "角色对应的操作所属模块父级名",
				width : fillsize(0.2),
				formatter : function(value, rec) {
					return rec.sysOperate.sysModule.modulePName;
				}
			}, {
				field : "moduleName",
				title : "角色对应的操作所属模块名",
				width : fillsize(0.2),
				formatter : function(value, rec) {
					return rec.sysOperate.sysModule.moduleName;
				}
			}, {
				field : "cnname",
				title : "角色对应的操作名称",
				width : fillsize(0.2),
				formatter : function(value, rec) {
					return rec.sysOperate.sysssDd.cnname;
				}
			} ] ],
			pagination : true,
			toolbar : [ {
				text : "添加角色对应的操作",
				iconCls : "icon-add",
				handler : function() {
					addOperateToRole();
				}
			}, "-", {
				text : "删除角色对应的操作",
				iconCls : "icon-remove",
				handler : function() {
					var row = $("#operatetab").datagrid("getSelected");
					if (row == null) {
						$.messager.alert("提示", "选择一条记录", "info");
					} else {
						deleteOperateFromRole();
					}
				}
			} ]
		});
	}
	function deleteOperateFromRole() {
		var node = $("#roletree").tree("getSelected");
		var ids = [];
		var rows = $("#operatetab").datagrid("getSelections");
		for ( var i = 0; i < rows.length; i++) {
			ids.push(rows[i].operateroleid);
		}
		$.ajax({
			type : "POST",
			dataType : "text",
			url : "role.do?method=deleteOperateFromRole&nowdate=" + new Date(),
			data : {
				"ids" : ids.join()
			},
			success : function(data) {
				$.messager.show({
					title : "提示信息",
					msg : data,
					showType : "show",
					timeout : 3000
				});
				showOperateToRoleTab(node.id);
			}
		});

	}
	/////////////////////////////////////////////////////////////////////////////////
	//添加角色
	function addrole() {
		resetContent("roleform");
		$("#addRole").show();
		$("#addRole").dialog({
			title : "添加角色",
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
					$("#roleform").form("submit", {
						url : "role.do?method=addRole",
						onSubmit : function() {
							return $(this).form("validate");
						},
						success : function(data) {
							$("#addRole").dialog("close");
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
					$("#addRole").dialog("close");
				}
			} ]
		});
	}
	//更新 角色
	function updaterole() {
		var node = $("#roletree").tree("getSelected");
		if (node == null) {
			$.messager.alert("提示信息", "请选择要修改的角色！", "info");
		}
		$.ajax({
			type : "POST",
			dataType : "json",
			url : "role.do?method=toeditRole&nowdate=" + new Date(),
			data : {
				"roleId" : node.id
			},
			success : function(data) {
				$("#rolePid").attr("value", data.rolePid);
				$("#roleId").attr("value", data.roleId);
				$("#roleName").attr("value", data.roleName);
				$("#remark").attr("value", data.remark);
			}
		});
		$("#addRole").show();
		$("#addRole").dialog({
			title : "添加角色",
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
					$("#roleform").form("submit", {
						url : "role.do?method=updateRole",
						onSubmit : function() {
							return $(this).form("validate");
						},
						success : function(data) {
							$("#addRole").dialog("close");
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
				text : '取消',
				handler : function() {
					$("#addRole").dialog("close");
				}
			} ]
		});
	}
	//删除角色
	function deleterole() {
		var node = $("#roletree").tree("getSelected");
		if (node == null) {
			$.messager.alert("提示信息", "请选择要删除的角色！", "info");
		}
		$.ajax({
			type : "POST",
			dataType : "text",
			url : "role.do?method=deleteRole&nowdate=" + new Date(),
			data : {
				"roleId" : node.id
			},
			success : function(data) {
				$.messager.show({
					title : "提示信息",
					msg : data,
					showType : "show",
					timeout : 3000
				});
			}
		});
	}
</script>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
	<div region="west" style="width: 150px;overflow: hidden" id="west"
		border="false">
		<div
			style="background-color: #E0EC00;margin-top: 1px;text-align: center;">
			<a href="javascript:void(0)" onclick="addrole()" title="添加角色~"
				class="vtip">添加</a>| <a href="javascript:void(0)"
				onclick="updaterole()" title="修改角色~" class="vtip">修改</a>| <a
				href="javascript:void(0)" onclick="deleterole()" title="删除角色~"
				class="vtip">删除</a>| <a href="javascript:void(0)" onclick="reload()"
				title="刷新选中节点下的角色~" class="vtip">刷新</a>
		</div>
		<ul id="roletree" style="margin-top: 3px"></ul>
	</div>
	<div id="mainPanle" region="center" style="overflow: hidden;"
		border="false">
		<div class="easyui-tabs" id="1" style="overflow: hidden;" fit="true">
			<div title="角色对应用户" border="false">
				<table id="roletab" width="100%" height="100%" border="false"></table>
			</div>
			<div title="角色对应模块" border="false">
				<table id="moduletab" width="100%" height="100%" border="false"></table>
			</div>
			<div title="角色对应操作" border="false">
				<table id="operatetab" width="100%" height="100%"></table>
			</div>
		</div>
	</div>
	<div id="addRole" style="display: none;text-align: center;">
		<form action="" name="roleform" id="roleform" method="post">
			<input type="hidden" name="rolePid" id="rolePid"> <input
				type="hidden" name="roleId" id="roleId">
			<table>
				<tr>
					<td>角色名称：</td>
					<td><input type="text" name="roleName" id="roleName"
						class="easyui-validatebox" required="true">
					</td>
				</tr>
				<tr>
					<td>角色说明：</td>
					<td><textarea rows="" cols="" name="remark" id="remark"></textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="selectUser"
		style="display: none;text-align: center;overflow: hidden;">
		<table id="usertorole"
			style="width: 565px;height: 328px;overflow: hidden;"></table>
	</div>
</body>
</html>