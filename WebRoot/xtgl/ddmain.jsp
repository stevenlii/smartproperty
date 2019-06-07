<%@ page language="java" pageEncoding="utf-8"%>
<html>
<head>
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
	function showlist(tag) {
		if (tag == 1) {//操作名信息
			$("#treedata").hide();
			$("#tabdata").show();
			operatelist();
		} else if (tag == 2) {//投诉类别信息
			$("#treedata").hide();
			$("#tabdata").show();
			complaintlist();
		}

	}
	/**
	 * 数据字典列表
	 */
	function zjzdlist(zdtype, titlename) {
		$("#tab")
				.datagrid(
						{
							title : titlename + "信息",
							singleSelect : true,
							fit : true,
							pageSize : 20,
							pageList : [ 20, 30, 50 ],
							url : "dd.do?method=getSjzdList&zdtype=" + zdtype,
							columns : [ [ {
								field : "ck",
								checkbox : true
							}, {
								field : "name",
								title : "名称",
								width : fillsize(0.2)
							}, {
								field : "remark",
								title : "备注",
								width : fillsize(0.2)
							} ] ],
							pagination : true,
							toolbar : [
									{
										text : "添加",
										iconCls : "icon-add",
										handler : function() {
											add(titlename, "sjzdform",
													"sjzddiv",
													"addSjzd&zdtype=" + zdtype);
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
												updatesjzd(titlename,
														"sjzdform", row,
														"sjzddiv", "updateSjzd");
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
																				row.id,
																				'deleteSjzdById');
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
	 * 操作名管理列表
	 */
	function operatelist() {
		$("#tab")
				.datagrid(
						{
							title : "信息",
							singleSelect : true,
							fit : true,
							pageSize : 20,
							pageList : [ 20, 30, 50 ],
							url : "dd.do?method=getDdList&tbtype=operate",
							columns : [ [ {
								field : "ck",
								checkbox : true
							}, {
								field : "enname",
								title : "名称",
								width : fillsize(0.2)
							}, {
								field : "cnname",
								title : "操作中文名",
								width : fillsize(0.2)
							} ] ],
							pagination : true,
							toolbar : [
									{
										text : "添加",
										iconCls : "icon-add",
										handler : function() {
											add("添加操作名", "operateform",
													"addoperate",
													"dd.do?method=addDd");
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
												updateoperate("修改操作名",
														"operateform", row,
														"addoperate",
														"dd.do?method=updateDd");
											}
										}
									},
									"-",
									{
										text : "删除操作名",
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
																				row.ddid,
																				'dd.do?method=delDdById');
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
	 * 投诉类别管理列表
	 */
	function complaintlist() {
		$("#tab")
				.datagrid(
						{
							title : "信息",
							singleSelect : true,
							fit : true,
							pageSize : 20,
							pageList : [ 20, 30, 50 ],
							url : "dd.do?method=getDdList&tbtype=complaint",
							columns : [ [ {
								field : "ck",
								checkbox : true
							}, {
								field : "typeCode",
								title : "投诉类型",
								width : fillsize(0.2),
								formatter : function(value, rec) {
									if (rec.typeCode == 0) {
										return "公司投诉邮局";
									} else {
										return "邮局投诉公司";
									}

								}
							}, {
								field : "cnname",
								title : "投诉种类名称",
								width : fillsize(0.2)
							}, {
								field : "enname",
								title : "投诉种类代码",
								width : fillsize(0.2)
							} ] ],
							pagination : true,
							toolbar : [
									{
										text : "添加",
										iconCls : "icon-add",
										handler : function() {
											add("添加操作名", "complaintform",
													"addcomplaint",
													"dd.do?method=addDd");
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
												updatecomplaint("修改操作名",
														"complaintform", row,
														"addcomplaint",
														"dd.do?method=updateDd");
											}
										}
									},
									"-",
									{
										text : "删除操作名",
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
																				row.ddid,
																				'dd.do?method=delDdById');
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
	function updateoperate(updattitle, updatform, row, updatId, updatMethod) {
		resetContent(updatform);
		$("#operateid").attr("value", row.ddid);
		$("#operatecnname").attr("value", row.cnname);
		$("#operatetenname").attr("value", row.enname);
		updat(updattitle, updatform, updatId, updatMethod);
	}
	function updatecomplaint(updattitle, updatform, row, updatId, updatMethod) {
		resetContent(updatform);
		$("#complaintid").attr("value", row.ddid);
		$("#complaintcnname").attr("value", row.cnname);
		$("#complaintenname").attr("value", row.enname);
		$("#complainttypeCode").attr("value", row.typeCode);
		updat(updattitle, updatform, updatId, updatMethod);
	}
</script>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
	<div region="west" style="width: 180px; overflow: hidden" id="west">
		<div
			style="background-color: #E0EC00; margin-top: 1px; text-align: center;">
			数据字典</div>
		<ul id="list" style="margin-top: 3px">
			<li class="sjzd-li"><a href="javascript:void(0)"
				onclick="showlist('1')" class="vtip" title="操作名管理">操作名管理</a></li>
			<li class="sjzd-li"><a href="javascript:void(0)"
				onclick="showlist('2')" class="vtip" title="基础字典">投诉类别管理</a></li>
			<li class="sjzd-li"><a href="javascript:void(0)"
				onclick="showlist('11')" class="vtip" title="基础字典">基础字典</a></li>
		</ul>
	</div>
	<div id="mainPanle" region="center" style="overflow: hidden">
		<div class="easyui-tabs" id="treedata"
			style="display: none;width: 100%;height: 100%;" fit="true"></div>
		<div style="display: none;width: 100%;height: 100%;" id="tabdata">
			<table id="tab" width="100%" height="100%"></table>
		</div>
	</div>
	<!--操作名添加页面-->
	<div id="addoperate" style="display: none; text-align: center;">
		<form action="" method="post" id="operateform" name="operateform">
			<input type="hidden" name="ddid" id="operateid"> <input
				type="hidden" name="type" id="operate" value="operate">
			<table style="text-align: center;">
				<tr>
					<td width="40%">操作中文名：</td>
					<td><input type="text" name="cnname" id="operatecnname"
						class="easyui-validatebox">
					</td>
				</tr>

				<tr>
					<td width="40%">操作英文名：</td>
					<td><input type="text" name="enname" id="operatetenname"
						class="easyui-validatebox">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!--操作名添加页面结束-->
	<!--操作名添加页面-->
	<div id="addcomplaint" style="display: none; text-align: center;">
		<form action="" method="post" id="complaintform" name="complaintform">
			<input type="hidden" name="ddid" id="complaintid"> <input
				type="hidden" name="type" id="complaint" value="complaint">
			<table style="text-align: center;">
				<tr>
					<td width="40%">投诉类型：</td>
					<td><select name="typeCode" id="complainttypeCode"
						style="width: 123px;" class="easyui-validatebox">
							<option value="0">公司投诉邮局</option>
							<option value="1">邮局投诉公司</option>
					</select>
				</tr>
				<tr>

					<td width="40%">投诉名称：</td>
					<td><input type="text" name="cnname" id="complaintcnname"
						class="easyui-validatebox">
					</td>
				</tr>

				<tr>
					<td width="40%">投诉代码：</td>
					<td><input type="text" name="enname" id="complaintenname"
						class="easyui-validatebox">
					</td>
				</tr>

			</table>
		</form>
	</div>
	<!--操作名添加页面结束-->
	<!-- 数据字典（邮路种类zdtype-0，邮路性质zdtype-1，邮路zdtype-2，邮件种类zdtype-3，邮件属性zdtype-4,代理商zdtype-5） -->
	<div id="sjzddiv" style="display: none;">
		<form action="" method="post" id="sjzdform" name="sjzdform">
			<input type="hidden" name="id" id="sjzdid" /> <input type="hidden"
				name="zdtype" id="sjzdtype">
			<table style="text-align: center;">
				<tr>
					<td>名称：</td>
					<td><input type="text" name="name" id="sjzdname"
						class="easyui-validatebox" required="true" />
					</td>
				</tr>
				<tr>
					<td>备注：</td>
					<td><input type="text" name="remark" id="sjzdremark" />
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>