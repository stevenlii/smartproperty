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
		<script type="text/javascript"
			src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="js/common.js"></script>	
		<script type="text/javascript" src="js/userToCom.js"></script>	
		<script type="text/javascript">
	$(function() {
		userlist();
		getdept();
		//自定义验证，验证登录名的合法性
		$.extend($.fn.validatebox.defaults.rules,{
			usercheck:{
				validator:function(value) {
					return (value.replace(/\w/g, "").length == 0); 
				},message:"用户名应该为字母,下划线和数字~~"
			}
		});
	});
	/**
	 * 显示用户列表
	 */
	 function ss(rec){
	 return 
	 };
	function userlist() {
		$("#tab").datagrid({
			singleSelect : true,
			fit:true,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "AdmUser.do?method=getList",
			columns : [ [ {
				field : "ck",
				checkbox : true
			}, {
				field : "username",
				title : "用户ID",
				width : fillsize(0.15)
			}, {
				field : "ryname",
				title : "用户姓名",
				width : fillsize(0.15)
			}, {
				field : "deptname",
				title : "所属公司",
				width : fillsize(0.2),
				formatter : function(value, rec) {
					return rec.tbadmDept.deptname;
				}
			},  {
				field : "companytypeflag",
				title : "所属公司类型",
				width : fillsize(0.15),
				formatter : function(value, rec) {
					if(rec.tbadmDept.companytypeflag == "0"){
					return "邮政公司";
					}
					else if(rec.tbadmDept.companytypeflag == "1"){
					
					return "入网公司";
					}
					else{
					return "";
					}
					}
					
			},{
				field : "serialno",
				title : "顺序号",
				width : fillsize(0.15)
			},{
				field : "accessCompany",
				title : "所查看入网公司",
				width : fillsize(0.15),
				formatter : function(value, rec){
				if(rec.tbadmDept.companytypeflag == "0"){
				resetContent("#usertorole");
				var userid = rec.userid;
				return "<a href='#' onclick="+"\""+"getCompany('"+userid+"')"+"\""+">查看</a>&nbsp;&nbsp;&nbsp;"+
				"<a href='#' onclick="+"\""+"addCompany('"+userid+"')"+"\""+">添加对应 </a>&nbsp;&nbsp;&nbsp;"+
				"<a href='#' onclick="+"\""+"deleteCompany('"+userid+"')"+"\""+">删除</a>";
				}else{
				return "非邮局公司，无法查看";
				}
				}
			}, {
				field : "remark",
				title : "备注",
				width : fillsize(0.2)
			} ] ],
			pagination : true,
			toolbar : [ {
				text : "添加",
				iconCls : "icon-add",
				handler : function() {
					adduser();
				}
			}, "-", {
				text : "修改",
				iconCls : "icon-edit",
				handler : function() {
					var row = $("#tab").datagrid("getSelected");
					if (row == null) {
						$.messager.alert("警告信息", "选择一条记录","warning");
					}else{
						updateuser(row);
					}
				}
			}, "-", {
				text : "删除",
				iconCls : "icon-remove",
				handler : function() {
					var row = $("#tab").datagrid("getSelected");
					if(row==null){
						$.messager.alert("警告信息","选择一条要删除的记录！","warning");
					}else{
						$.messager.confirm("确认","确定要删除?",function(r){
							if(r){
								deleteuser(row);
								}
						});
					}
				}
			},"-", {
				text : "清除选择",
				iconCls : "icon-cancel",
				handler : function() {
					clearSelect("tab");
				}
			} ]
		});
	}
	
	
	
	/**
	 * 添加用户
	 */
	function adduser() {
		resetContent("userform");
		$("#adduser").show();
		$("#adduser").dialog({
			title : "添加用户",
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
					$("#userform").form("submit", {
						url : "AdmUser.do?method=addUser",
						onSubmit : function() {
							return $(this).form("validate");
						},
						success : function(data) {
							$("#adduser").dialog("close");
							flashTable("tab");
							showmsg(data);
						}
					});
				}
			}, {
				text : "取消",
				iconCls : "icon-undo",
				handler : function() {
					$("#adduser").dialog("close");
				}
			}]
		});
	}
	/**
	 * 删除用户
	 */
	function deleteuser(row) {
		$.ajax({
			type : "POST",
			dataType : "text",
			url : "AdmUser.do?method=delUser&nowdate=" + new Date(),
			data:{"userid":row.userid},
			success : function(data) {
				flashTable("tab");
				showmsg(data);
			}
		});
	}
	function updateuser(row){
		resetContent("userform");
		$("#userid").attr("value",row.userid);
		$("#username").attr("value",row.username);
		$("#username").attr("readonly","readonly");
		$("#ryname").attr("value",row.ryname);
		$("#password").attr("value",row.password);
		$("#serialno").numberbox("setValue",row.serialno);
		$("#remark").attr("value",row.remark);
		$("#deptid").attr("value",row.tbadmDept.deptid); 
		$("#adduser").show();
		$("#adduser").dialog({
			title : "更新用户",
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
					$("#userform").form("submit", {
						url : "AdmUser.do?method=updateUser",
						onSubmit : function() {
							return $(this).form("validate");
						},
						success : function(data) {
							$("#adduser").dialog("close");
							flashTable("tab");
							showmsg(data);
						}
					});
				}
			}, {
				text : "取消",
				iconCls : "icon-undo",
				handler : function() {
					$("#adduser").dialog("close");
				}
			}]
		});
	}
	//获取部门信息
	function getdept() {
		$.ajax({
			type : "POST",
			dataType : "json",
			url : "AdmDept.do?method=getDeptList&nowdate=" + new Date(),
			success : function(data) {
				$.each(data, function(i, v) {
					$("#deptid").append(
							"<option value='"+v.deptid+"'>" + v.deptname
									+ "</option>");
				});
			}
		});
	}
</script>
	</head>
	<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
	<div id="mainPanle" region="center"
			style="overflow: hidden" border="false">
		<table id="tab" width="100%" height="100%" border="false"></table>
	</div>
		<div id="adduser" style="display: none; text-align: center;">
			<form action="" method="post" id="userform" name="userform">
			<input type="hidden" name="userid" id="userid">
				<table align="center">
					<tr>
						<td width="30%">
							登录名：
						</td>
						<td>
							<input type="text" name="username" id="username"
								class="easyui-validatebox" validType="usercheck" required="true" >
						</td>
					</tr>
					<tr>
						<td width="30%">
							姓名：
						</td>
						<td>
							<input type="text" name="ryname" id="ryname"
								class="easyui-validatebox">
						</td>
					</tr>
					<tr>
						<td width="30%">
							密码：
						</td>
						<td>
							<input type="password" " name="password" id="password"
								class="easyui-validatebox" required="true">
						</td>
					</tr>
					<tr>
						<td width="30%">
							排序号:
						</td>
						<td>
							<input type="text" name="serialno" id="serialno"
								class="easyui-numberbox">
						</td>
					</tr>
					<tr>
						<td width="30%">
							备注：
						</td>
						<td>
							<textarea rows="2" cols="22" name="remark" id="remark"
								class="easyui-validatebox" ></textarea>
						</td>
					</tr>
					<tr>
						<td width="30%">
							部门：
						</td>
						<td>
							<select name="deptid" id="deptid" class="easyui-validatebox"
								style="width: 130px"></select>
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
