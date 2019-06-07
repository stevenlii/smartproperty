<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>业主信息录入</title>
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
		ownerlist();
		
		$("#createnoticebutton").click(
				function() {
				   createnotic();
					ownerlist();
					houselist();
				});
		$("#updatenoticebutton").click(
				function() {
					
					var row = $("#tab").datagrid("getSelected");
					if (row == null ) {
						$.messager.alert("警告信息", "请选择一条记录", "warning");
					} else {
						houselist();
						resetContent("entrustformid");
						$("#id").attr("value", row.id);
						$("#ownerName").attr("value", row.ownerName);
						$("#remark").attr("value", row.remark);
						$("#ownerPhone").attr("value", row.ownerPhone);
						 $("#houseId").val(row.houseId);
						updat("房产", "entrustformid", "addhousediv",
								"owner.do?method=updateNotice");
					}
				});
		$("#deletenoticebutton").click(function() {
			var row = $("#tab").datagrid("getSelected");
			if (row == null) {
				$.messager.alert("警告信息", "选择一条要删除的记录！", "warning");
			} else {
				$.messager.confirm("确认", "确定要删除?", function(r) {
					if (r) {
						deleall("owner.do?method=deleteNoticeById");
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
			ids.push(rows[i].id);
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
		resetContent("entrustformid");
		$("#addhousediv").show();
		$("#addhousediv").dialog({
			title : "录入房产信息",
			modal : true,
			width : 400,
			height : 300,
            minimizable : false,
			maximizable : false,
			buttons : [ {
				text : "添加",
				iconCls : "icon-ok",
				handler : function() {
					
						$("#entrustformid").form("submit", {
						url : "owner.do?method=addNotice",
						onSubmit : function() {
							return $(this).form("validate");
						},
						success : function(data) {
							$("#addhousediv").dialog("close");
							flashTable("tab");
							showmsg(data);
						}
					});
					
				}
			}, {
				text : "取消",
				iconCls : "icon-undo",
				handler : function() {
					$("#addhousediv").dialog("close");
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
	 * 房产信息*/

	function ownerlist() {
		$("#tab").datagrid({
			nowrap : false,
			singleSelect : false,
			striped : true,
			fit : true,
			pageNumber : 1,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "owner.do?method=getHouseList",
			columns : [ [ {
				field : "ck",
				checkbox : true
			}, {
				field : "ownerName",
				title : "业主名",
				width : fillsize(0.1)
			}, {
				field : "ownerPhone",
				title : "业主电话",
				width : fillsize(0.2)
			}, {
				field : "houseId",
				title : "名下房产号",
				width : fillsize(0.1)
			}, {
				field : "houseArea",
				title : "房产面积",
				width : fillsize(0.1)
			} ] ],
			pagination : true
		});
	}
	//获取房产信息
	function houselist() {
		$("#houseId").empty();
		$("#houseId").append('<option value="无房产">无房产</option>');
		$.ajax({
			type : "POST",
			dataType : "json",
			url : "house.do?method=getHouseOnlyList",
			success : function(data) {
				$.each(data, function(i, v) {
					
					$("#houseId").append(
							"<option value='"+v.houseNo+"'>" + v.houseNo
									+ "</option>");
				});
			}
		});
	}
</script>

</head>

<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
	<div region="north" split="true" border="false"
		style="height: 25px;padding: 2px 0 0 2px;">
	<c:if test="${sessionScope.ownercreate eq 'create'}">
		<button id='createnoticebutton'>添加</button>
		</c:if>
		<c:if test="${sessionScope.ownerupdate eq 'update'}">
		<button id='updatenoticebutton'>修改</button>
		</c:if>
		<c:if test="${sessionScope.ownerdelsingle eq 'delsingle'}">
		<button id='deletenoticebutton'>删除</button>
		</c:if>
		<c:if test="${sessionScope.ownercleartab eq 'cleartab'}">
		<button id='clearnoticebutton'>清除选择</button>
		</c:if>
	</div>
	<div id="mainPanle" region="center" style="overflow: hidden"
		border="false">
		<table id="tab" width="100%" height="100%" border="false"></table>
	</div>
	<!--房产添加页面-->
	<div id="addhousediv" style="display: none; text-align: center;">
		<form action="" method="post" id="entrustformid" name="entrustformid">
			<input type="hidden" name="id" id="id">
			<table style="text-align: center;">

				<tr>
					<td width="40%">业主名：</td>
					<td><input style="width: 150px;" type="text"
						name="ownerName" id="ownerName" />
					</td>
				</tr>
				<tr>
					<td width="40%">业主电话：</td>
					<td><input style="width: 150px;" type="text" name="ownerPhone"
						 id="ownerPhone" />
					</td>
				</tr>
				<tr>
					<td width="40%">业主描述：</td>
					<td><textarea   style="width: 150px;height: 100px;"
						name="remark" id="remark" class="easyui-validatebox"></textarea>
					</td>
				</tr>
				<tr>
						<td width="40%">
							房产：
						</td>
						<td>
							<select name="houseId" id="houseId" class="easyui-validatebox"
								style="width: 150px"></select>
						</td>
					</tr>
			</table>
		</form>
	</div>
	<!--房产添加页面结束-->
</body>
</html>