<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<%
	response.addHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<title>物业智能管理系统</title>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/vtip-min.js"></script>
<script type="text/javascript" src="jeasyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/mainmenu.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/clock.js"></script>
<script type="text/javascript" src="js/mask.js"></script>
<link rel="stylesheet" type="text/css"
	href="jeasyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="jeasyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="css/sys.css">
<link rel="icon" href="images/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
<script type="text/javascript">
	$(function() {
		$("#reply")
				.click(
						function() {
							var tab = $('#tabs').tabs('getSelected'); // get selected panel
							$('#tabs')
									.tabs(
											'update',
											{
												tab : tab,
												options : {
													title : '代办回复',
													content:'<iframe name="indextab" scrolling="auto" frameborder="0" style="width:100%;height:100%;"></iframe>'
												}
											});
							window.open("${basePath}/tdgh/import.do?method=toreplycomplaintMain&replySuccess=false","indextab"); 
						});
	});
	function updateuser(uid, uname) {
		resetContent("modifyform");
		$("#userid").attr("value", uid);
		$("#username").attr("value", uname);
		$("#username").attr("readonly", "readonly");
		$("#modifyform").show();
		$("#modifyform").dialog({
			title : "修改密码",
			modal : true,
			width : 400,
			height : 260,
			collapsible : false,
			minimizable : false,
			maximizable : false,
			buttons : [ {
				text : "更新",
				iconCls : "icon-ok",
				handler : function() {
					$("#modifyform").form("submit", {
						url : "login.do?method=editpass",
						onSubmit : function() {
							return $(this).form("validate");
						},
						success : function(data) {
							$("#modifyform").dialog("close");
							showmsg(data);
						}
					});
				}
			}, {
				text : "取消",
				iconCls : "icon-undo",
				handler : function() {
					$("#modifyform").dialog("close");
				}
			} ]
		});
	}
	function showmask(msg) {
		$("#fbodymask").mask({
			maskMsg : msg,
			timeout : 600000
		});
	}
	function hidemask() {
		$("#fbodymask").mask("hide");
	}
</script>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no"
	id="fbodymask">
	<div region="north" split="true" border="false"
		style="overflow: hidden; height: 30px; background: url(images/layout-browser-hd-bg.gif) #7f99be repeat-x center 50%; line-height: 20px; color: #fff; font-family: Verdana, 微软雅黑, 黑体">
		<span class="head"><span id="clock"></span>|欢迎您:${user.ryname }
			<a href="javascript:void(0)"
			onclick="updateuser('${user.userid}','${user.username}')"
			id="editpass">修改密码</a> <a href="login.do?method=logout" id="loginOut">安全退出</a>
			<a target="_blank" href="${basePath}help/help.jsp" id="help_id">帮助</a>
		</span> <span style="padding-left: 10px; font-size: 16px;"><img
			src="images/blocks.gif" width="20" height="20" />欢迎使用物业智能管理系统</span>
	</div>
	<div region="south" split="true"
		style="height: 30px; background: #D2E0F2;">
		<div class="footer">CopyRight@<a href="http://www.paymoon.com/" target="_blank">paymoon.com</a></div>
	</div>
	<div region="west" hide="true" split="true" title="导航菜单"
		style="width: 180px;" id="west">
		<div id="nav" class="easyui-accordion" fit="true" border="false">
			<!--  导航内容 -->
		</div>
	</div>
	<div id="mainPanle" region="center"
		style="background: #eee; overflow-y: hidden">
		<div id="tabs" class="easyui-tabs" fit="true" border="false">
			<div id="welcome_daiban" title="欢迎使用"
				style="overflow: hidden; color: green;">
				<%-- <div align="center">
					系统消息：
					<c:choose>
						<c:when test="${sessionScope.replyNum gt 0}">   
       [<a href="javascript:void(0);" id="reply">${sessionScope.replyNum}条待回复信息</a>]  
  </c:when>
						<c:otherwise>   
        [没有消息,请注意刷新]
  </c:otherwise>
					</c:choose>
				</div>
				<hr /> --%>
				<div align="center">公告</div>
				<h1 align="center">标题：${note.noticeTitle}</h1><br/>
				<div align="center">${note.noticeContent}</div><br/>
				<div align="right" style="margin-right: 200px;">发布时间：${note.noticeDate}</div>
			</div>
		</div>
	</div>

	<div id="mm" class="easyui-menu" style="width: 150px;">
		<div id="mm-tabupdate">刷新</div>
		<div class="menu-sep"></div>
		<div id="mm-tabclose">关闭</div>
		<div id="mm-tabcloseall">全部关闭</div>
		<div id="mm-tabcloseother">除此之外全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-tabcloseright">当前页右侧全部关闭</div>
		<div id="mm-tabcloseleft">当前页左侧全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-exit">退出</div>
	</div>
	<!--用户修改密码页面-->
	<div id="editpassword" style="display: none; text-align: center;">
		<form action="" method="post" id="modifyform" name="modifyform">
			<input type="hidden" name="userid" id="userid">
			<table style="text-align: center;">
				<tr>
					<td width="30%">登录名：</td>
					<td><input type="text" name="username" id="username"
						readonly="readonly"></td>
				</tr>
				<tr>
					<td width="40%">原密码：</td>
					<td><input type="text" name="oldpassword" id="oldpassword"
						class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td width="40%">新密码：</td>
					<td><input type="password" name="newpassword" id="newpassword"
						class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td width="40%">确认密码：</td>
					<td><input type="password" name="confpassword"
						id="confpassword" class="easyui-validatebox" required="true">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!--用户修改密码页面结束-->
</body>
</html>