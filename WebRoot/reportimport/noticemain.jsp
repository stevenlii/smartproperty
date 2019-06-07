<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>投诉录入</title>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/vtip-min.js"></script>
<script type="text/javascript" src="jeasyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet" type="text/css" href="css/sys.css">
<link rel="stylesheet" href="uploadify/uploadify.css" type="text/css"></link>
<link rel="stylesheet" type="text/css"
	href="jeasyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="jeasyui/themes/icon.css" />
<script type="text/javascript" src="uploadify/swfobject.js"></script>
<script type="text/javascript"
	src="uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<script type="text/javascript" src="js/import.js"></script>
<script type="text/javascript" src="js/mask.js"></script>
<script type="text/javascript" src="js/jquery.autocomplete.js"></script>

<script type="text/javascript">
	$(function() {
		NoticeList();
		$("#createnoticebutton").click(
				function() {
				   createnotic();
					NoticeList();
				});
		$("#updatenoticebutton").click(
				function() {
					var row = $("#tab").datagrid("getSelected");
					if (row == null) {
						$.messager.alert("警告信息", "请选择一条记录", "warning");
					} else {
						resetContent("entrustform");
						$("#entrustid").attr("value", row.noticeid);
						$("#noticeTitle").attr("value", row.noticeTitle);
						$("#noticeContent").attr("value", row.noticeContent);
						$("#noticeDate").attr("value", row.noticeDate);
						updat("公告", "entrustform", "addentrust",
								"notice.do?method=updateNotice");
					}
				});
		$("#deletenoticebutton").click(function() {
			var row = $("#tab").datagrid("getSelected");
			if (row == null) {
				$.messager.alert("警告信息", "选择一条要删除的记录！", "warning");
			} else {
				$.messager.confirm("确认", "确定要删除?", function(r) {
					if (r) {
						deleall("notice.do?method=deleteNoticeById");
					}
				});
			}
		});
		$("#clearnoticebutton").click(function() {
			clearSelect("tab");
		});
	});
	function deleall(delemethod) {
		var ids = [];
		var rows = $("#tab").datagrid("getSelections");
		for ( var i = 0; i < rows.length; i++) {
			ids.push(rows[i].noticeid);
		} 
		$.ajax({
			type : "POST",
			dataType : "text",
			url : delemethod + "&nowdate=" + new Date(),
			data : {
				"entityid" : ids.join(",")
			},
			success : function(data) {
				$.messager.show({
					title : "提示信息",
					msg : data,
					showType : "show",
					timeout : 3000
				});
				flashTable("tab");
			}
		});

	}
function createnotic() {
		resetContent("entrustform");
		var dt = new Date().format("yyyy-MM-dd");
		$("#noticeDate").val(dt); //投诉日期
		$("#addentrust").show();
		$("#addentrust").dialog({
			title : "录入公告信息",
			modal : true,
			width : 400,
			height : 300,
            minimizable : false,
			maximizable : false,
			buttons : [ {
				text : "添加",
				iconCls : "icon-ok",
				handler : function() {
					
						$("#entrustform").form("submit", {
						url : "notice.do?method=addNotice",
						onSubmit : function() {
							return $(this).form("validate");
						},
						success : function(data) {
							$("#addentrust").dialog("close");
							flashTable("tab");
							showmsg(data);
						}
					});
					
				}
			}, {
				text : "取消",
				iconCls : "icon-undo",
				handler : function() {
					$("#addentrust").dialog("close");
				}
			} ]
		});
	}
	

//*********自定义format方法		  
	Date.prototype.format = function(format) {
		var o = {
			"M+" : this.getMonth() + 1, //month        
			"d+" : this.getDate(), //day        
			"h+" : this.getHours(), //hour        
			"m+" : this.getMinutes(), //minute        
			"s+" : this.getSeconds(), //second        
			"q+" : Math.floor((this.getMonth() + 3) / 3), //quarter        
			"S" : this.getMilliseconds()
		//millisecond        
		};
		if (/(y+)/.test(format))
			format = format.replace(RegExp.$1, (this.getFullYear() + "")
					.substr(4 - RegExp.$1.length));
		for ( var k in o)
			if (new RegExp("(" + k + ")").test(format))
				format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
						: ("00" + o[k]).substr(("" + o[k]).length));
		return format;
	};

	/**
	 * 公告信息*/

	function NoticeList() {
		$("#tab").datagrid({
			nowrap : false,
			singleSelect : false,
			striped : true,
			fit : true,
			pageNumber : 1,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "notice.do?method=getNoticeList",
			columns : [ [ {
				field : "ck",
				checkbox : true
			}, {
				field : "noticeTitle",
				title : "公告标题",
				width : fillsize(0.1)
			}, {
				field : "noticeContent",
				title : "公告内容",
				width : fillsize(0.2)
			}, {
				field : "noticeDate",
				title : "公告日期",
				width : fillsize(0.1)
			} ] ],
			pagination : true
		});

	}
</script>

</head>

<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
	<div region="north" split="true" border="false"
		style="height: 25px;padding: 2px 0 0 2px;">
		<c:if test="${sessionScope.noticecreate eq 'create'}">
		<button id='createnoticebutton'>添加</button>
		</c:if>
		<c:if test="${sessionScope.noticeupdate eq 'update'}">
		<button id='updatenoticebutton'>修改</button>
		</c:if>
		<c:if test="${sessionScope.noticedelsingle eq 'delsingle'}">
		<button id='deletenoticebutton'>删除</button>
		</c:if>
		<c:if test="${sessionScope.noticecleartab eq 'cleartab'}">
		<button id='clearnoticebutton'>清除选择</button>
		</c:if>
	</div>
	<div id="mainPanle" region="center" style="overflow: hidden"
		border="false">
		<table id="tab" width="100%" height="100%" border="false"></table>
	</div>
	<!--公告添加页面-->
	<div id="addentrust" style="display: none; text-align: center;">
		<form action="" method="post" id="entrustform" name="noticeid">
			<input type="hidden" name="noticeid" id="entrustid">
			<table style="text-align: center;">

				<tr>
					<td width="40%">公告标题：</td>
					<td><input style="width: 150px;" type="text"
						name="noticeTitle" id="noticeTitle" />
					</td>
				</tr>
				<tr>
					<td width="40%">公告日期：</td>
					<td><input style="width: 150px;" type="text" name="noticeDate"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" id="noticeDate" value="" />
					</td>
				</tr>
				<tr>
					<td width="40%">公告内容：</td>
					<td><textarea   style="width: 150px;height: 100px;"
						name="noticeContent" id="noticeContent" class="easyui-validatebox"></textarea>
					</td>
				</tr>
				
			</table>
		</form>
	</div>
	<!--公告添加页面结束-->
</body>
</html>