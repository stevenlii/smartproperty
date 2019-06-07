<%@ page language="java" pageEncoding="utf-8"%>
<html>
	<head>
		<%
			response.addHeader("Pragma", "no-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
		%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>部门维护</title>
		<link href="css/sys.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css"
			href="jeasyui/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="jeasyui/themes/icon.css">
		<script src="js/jquery.js"></script>
		<script type="text/javascript" src="jeasyui/jquery.easyui.min.js"></script>
		<script type="text/javascript"
			src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
			<script type="text/javascript" src="js/common.js"></script>	
		<script type="text/javascript">

	$(function() {
		deptlist();
	});
	/**
	 * 公司列表
	 */
	function deptlist() {
		$("#tabdpt").datagrid({
			singleSelect : true,
			fit : true,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "AdmDept.do?method=getList",
			columns : [ [ {
				field : "ck",
				checkbox : true
			}, {
				field : "deptname",
				title : "公司名称",
				width : fillsize(0.3)
			}, {
				field : "companycode",
				title : "公司代码",
				width : fillsize(0.3)
			}, {
				field : "companytypeflag",
				title : "类型",
				width : fillsize(0.3),
				formatter : function(value, rec) {
					if(value==1){
						return "入网公司";
					}else{
						return "邮政公司";
					}
				}
			}, {
				field : "serialno",
				title : "顺序号",
				width : fillsize(0.3)
			}, {
				field : "remark",
				title : "备注",
				width : fillsize(0.3)
			} ] ],
			pagination : true,
			toolbar : [ {
				text : "添加",
				iconCls : "icon-add",
				handler : function() {
					adddept();
				}
			}, "-", {
				text : "修改",
				iconCls : "icon-edit",
				handler : function() {
					var row = $("#tabdpt").datagrid("getSelected");
					if (row == null) {
						$.messager.alert("警告信息", "选择一条记录", "info");
					} else {
						updatedept(row);
					}
				}
			}, "-", {
				text : "删除",
				iconCls : "icon-remove",
				handler : function() {
					var row = $("#tabdpt").datagrid("getSelected");
					if (row == null) {
						$.messager.alert("警告信息","选择一条记录", "info");
					} else {
						deletedept(row);
					}
				}
			},"-", {
				text : "清除选择",
				iconCls : "icon-cancel",
				handler : function() {
					clearSelect("tabdpt");
				}
			} ]
		});
	}
	function adddept() {
		resetContent("deptform");
		$("#deptadd").show();
		$("#deptadd").dialog({
			title : "添加公司信息",
			modal : true,
			width : 400,
			height : 260,
			collapsible : true,
			minimizable : false,
			maximizable : false,
			buttons : [ {
				text : "添加",
				iconCls : "icon-ok",
				handler : function() {
					$("#deptform").form("submit", {
						url : "AdmDept.do?method=addDept",
						onSubmit : function() {
							return $(this).form("validate");
						},
						success : function(data) {
							$("#deptadd").dialog("close");
							flashTable("tabdpt");
							showmsg(data);
						}
					});
				}
			}, {
				text : "取消",
				iconCls : "icon-undo",
				handler : function() {
					$("#deptadd").dialog("close");
				}
			} ]
		});
	}
	function updatedept(row) {
		resetContent("deptform");
		$("#deptid").attr("value", row.deptid);
		$("#deptname").attr("value", row.deptname);
		$("#serialno").numberbox("setValue", row.serialno);
		$("#remark").attr("value", row.remark);
		$("#companycode").attr("value", row.companycode);
		$("#companytypeflag").attr("value", row.companytypeflag);
		if(row.companytypeflag==1){
			showdm(1);
		}else{
			showdm(0);
		}
		$("#deptadd").show();
		$("#deptadd").dialog({
			title : "更新公司信息",
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
					$("#deptform").form("submit", {
						url :"AdmDept.do?method=updateDept",
						onSubmit : function() {
							return $(this).form("validate");
						},
						success : function(data) {
							$("#deptadd").dialog("close");
							flashTable("tabdpt");
							showmsg(data);
						}
					});
				}
			}, {
				text : "取消",
				iconCls : "icon-undo",
				handler : function() {
					$("#deptadd").dialog("close");
				}
			} ]
		});
	}
	function deletedept(row) {
		$.ajax({
			type : "POST",
			dataType : "text",
			url : "AdmDept.do?method=deleteDept&nowdate=" + new Date(),
			data : {
				"deptid" : row.deptid
			},
			success : function(data) {
				flashTable("tabdpt");
				showmsg(data);
			}
		});
	}
	function showdm(showflag){
		if(showflag==1){
			$("#gsdm").show();
		}else{
			$("#gsdm").hide();
		}
	}
</script>
	</head>
	<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
	<div id="mainPanle" region="center"
			style="overflow: hidden;" border="false">
		<table id="tabdpt" width="100%" height="100%" border="false"></table>
		<div id="deptadd" style="display: none; text-align: center;">
			<form action="" name="deptform" id="deptform" method="post">
				<input type="hidden" name="deptid" id="deptid">
				<table style="text-align: center;">
					<tr>
						<td>
							公司名称：
						</td>
						<td>
							<input type="text" name="deptname" id="deptname"
								class="easyui-validatebox" required="true">
						</td>
					</tr>
					<tr>
						<td>
							类型：
						</td>
						<td>
						<select name="companytypeflag" id="companytypeflag" class="easyui-validatebox" style="width: 125px;" onchange="showdm($('#companytypeflag').val())">
							<option value="0">邮政公司</option>
							<option value="1">入网公司</option>
						</select>
						</td>
					</tr>
					<tr id="gsdm" style="display: none;">
						<td>
							公司代码：
						</td>
						<td>
							<input type="text" name="companycode" id="companycode"
								class="easyui-validatebox">
						</td>
					</tr>
					<tr>
						<td>
							排序号：
						</td>
						<td>
							<input type="text" name="serialno" id="serialno"
								class="easyui-numberbox">
						</td>
					</tr>
					<tr>
						<td>
							备注：
						</td>
						<td>
							<input type="text" name="remark" id="remark"
								class="easyui-validatebox">
						</td>
					</tr>
				</table>
			</form>
		</div>
		</div>
	</body>
</html>
