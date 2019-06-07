<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>赔偿信息导入</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css"/>
	-->
<link rel="stylesheet" href="uploadify/uploadify.css" type="text/css"></link>
<link rel="stylesheet" type="text/css"
	href="jeasyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="jeasyui/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="css/sys.css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="uploadify/swfobject.js"></script>
<script type="text/javascript" src="js/vtip-min.js"></script>
<script type="text/javascript" src="jeasyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript"
	src="uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<script type="text/javascript" src="js/import.js"></script>
<script type="text/javascript" src="js/mask.js"></script>
<script type="text/javascript">
	$(function() {
		showimportreport(1);

		FinanceList('');
		//赔偿信息
		$("#importbutton").click(function() {
			importfinance("装载赔偿", "allreportimport")
		});
		$("#pa95button").click(function() {
			var search = new Array();
			search[0] = $("#idmniidmniCompany").val();
			search[1] = $("#idmnimailNum").val();
			search[2] = $("#pa95startmonth").val();
			search[3] = $("#pa95endmonth").val();
			FinanceList(search);
			$("#allreportsearch").dialog("close");
		});
		$("#searchbutton").click(function() {
			importfinance("查询赔偿", "allreportsearch")
		});
		$("#deletebutton").click(function() {
			importfinance("删除赔偿", "allreportdel")
		});
		$("#pa95delbutton").click(function() {
			var tbName = $("#pa95tbName").val();
			deleTbName("import.do?method=indemnifyDelete", tbName, '');
			$("#allreportdel").dialog("close");
		});
		$("#createindemnifybutton").click(function() {
			$("#idmniAmount").numberbox("clear");
			createindemnify();
		});
		$("#updateindemnifybutton").click(function() {
			var row = $("#tab").datagrid("getSelected");
			if (row == null) {
				$.messager.alert("警告信息", "选择一条记录", "warning");
			} else {
				updateindemnify(row);
			}

		});
		$("#deleteindemnifybutton").click(function() {
			var row = $("#tab").datagrid("getSelected");
			if (row == null) {
				$.messager.alert("警告信息", "选择一条要删除的记录！", "warning");
			} else {
				$.messager.confirm("确认", "确定要删除?", function(r) {
					if (r) {
						deleall("input.do?method=deleteIndemnifyById");
					}
				});
			}

		});

		$("#clearindemnifybutton").click(function() {
			clearSelect("tab");
		});

		//自定义验证
		$.extend($.fn.validatebox.defaults.rules, {
			//长度验证
			length : {
				validator : function(value, param) {
					return value.length >= param[0];
				},
				message : "长度不能超过(1000)个字符"
			},
			//邮件号验证
			mailcheck : {
				validator : function(value) {
					return /^EC\d{9}CS$/.test(value);
				},
				message : "邮件号不正确"

			}

		});
	});

	var isimport = true;
	function importfinance(addTitle, addId) {
		if (isimport) {
			importreport('uploadify1', 'import', 'indemnifyImport',
					'fileQueue1', 'allreportimport');//赔偿信息
			isimport = false;
		}
		$("#" + addId).show();
		$("#" + addId).dialog({
			title : addTitle + "信息",
			modal : true,
			width : 500,
			height : 300,
			minimizable : false,
			maximizable : false
		});
	}

	//传入div的id,动态显示隐藏不同的上传按钮
	function showimportreport(showid) {
		$("#allreportimport").children("div").each(function(i) {
			var t = $(this).attr("id");
			if (showid == t) {
				$(this).show();
			} else {
				$(this).hide();
			}
		});
	}

	/**
	 * 赔偿信息
	 */
	function FinanceList(search) {
		$("#tab").datagrid({
			nowrap : false,
			singleSelect : false,
			striped : true,
			fit : true,
			queryParams : {
				idmniCompany : search[0],
				mailNum : search[1],
				StartDate : search[2],
				EndDate : search[3]
			},
			pageNumber : 1,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "search.do?method=getIndemnifyList",
			columns : [ [ {
				field : "ck",
				checkbox : true
			}, {
				field : "deptName",
				title : "涉及赔偿公司",
				width : fillsize(0.1)
			}, {
				field : "idmniMail",
				title : "涉及赔偿邮件",
				width : fillsize(0.1)
			}, {
				field : "idmniAmount",
				title : "赔偿金额",
				width : fillsize(0.1)
			}, {
				field : "idmniDate",
				title : "赔偿日期",
				width : fillsize(0.1)

			}, {
				field : "idmniReason",
				title : "赔偿原因",
				width : fillsize(0.2)
			}, {
				field : "remark",
				title : "备注",
				width : fillsize(0.2)
			}, {
				field : "tbName",
				title : "表来源名",
				width : fillsize(0.2)
			} ] ],
			pagination : true
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

	function createindemnify() {
		resetContent("indemnifyform");

		var dt = new Date().format("yyyy-MM-dd");
		$("#idmniDate").val(dt); //投诉日期
		$("#addindemnify").show();
		$("#addindemnify").dialog({
			title : "录入理赔信息",
			modal : true,
			width : 400,
			height : 300,
			minimizable : false,
			maximizable : false,
			buttons : [ {
				text : "添加",
				iconCls : "icon-ok",
				handler : function() {
					if (b == 0) {
						$("#indemnifyform").form("submit", {
							url : "input.do?method=addIndemnify",
							onSubmit : function() {
								return $(this).form("validate");
							},
							success : function(data) {
								$("#addindemnify").dialog("close");
								flashTable("tab");
								showmsg(data);
							}
						});
					}
				}
			}, {
				text : "取消",
				iconCls : "icon-undo",
				handler : function() {
					$("#addindemnify").dialog("close");
				}
			} ]
		});
	}

	function updateindemnify(row) {
		resetContent("indemnifyform");
		$("#id").attr("value", row.id);
		$("#tbMonth").attr("value", row.tbMonth);
		$("#idmniCompany").attr("value", row.idmniCompany);
		$("#idmniMail").attr("value", row.idmniMail);
		$("#idmniAmount").numberbox("setValue", row.idmniAmount);
		$("#idmniDate").attr("value", row.idmniDate);
		$("#idmniReason").attr("value", row.idmniReason);
		$("#remark").attr("value", row.remark);
		$("#addindemnify").show();
		$("#addindemnify").dialog({
			title : "更新理赔信息",
			modal : true,
			width : 400,
			height : 300,
			minimizable : false,
			maximizable : false,
			buttons : [ {
				text : "更新",
				iconCls : "icon-ok",
				handler : function() {
					$("#indemnifyform").form("submit", {
						url : "input.do?method=updateIndemnify",
						onSubmit : function() {
							return $(this).form("validate");
						},
						success : function(data) {
							$("#addindemnify").dialog("close");
							flashTable("tab");
							showmsg(data);
						}
					});
				}
			}, {
				text : "取消",
				iconCls : "icon-undo",
				handler : function() {
					$("#addindemnify").dialog("close");
				}
			} ]
		});
	}
	//for check null file
	function hasfile(uploaId) {
		if (!$("#" + uploaId).children().size() == 1) {
			showmsg("请选择上传文件");
			return false;
		}
	}
	function hascanclefile(uploaId) {
		if (!$("#" + uploaId).children().size() == 1) {
			showmsg("没有需要上传的文件");
			return false;
		}
	}
	//根据邮件号得到涉及赔偿的公司
	var b = 0;
	function showMailNum() {
		var num = $("#idmniMail").val();//得到邮件号码
		if (num != "" && num != null) {
			$.post("input.do?method=checkMailNum&mailNum=" + num, function(a) {
				//alert("a的值"+a);
				if (a == null || a == '' || a == undefined) {
					b = 1;
					document.getElementById("show").style.display = "block";

				} else {
					$("#idmniCompany").val(a); //涉及赔偿的公司
					document.getElementById("show").style.display = "none";
					b = 0;
				}
			});
		}
	}
</script>
</head>
<body class="easyui-layout" scroll="no">
	<div region="north" split="true" border="false"
		style="height: 25px;padding: 2px 0 0 2px;">
		<!-- 
		<c:if test="${sessionScope.indemnifyadd eq 'add'}">
			<button id='importbutton'>装载</button>
		</c:if>
		<c:if test="${sessionScope.indemnifysearch eq 'search'}">
			<button id='searchbutton'>查询</button>
		</c:if>
		-->
		<c:if test="${sessionScope.indemnifydel eq 'del'}">
			<button id='deletebutton'>删除</button>
		</c:if>
		 
		<!-- 
		<c:if test="${sessionScope.indemnifycreate eq 'create'}">
			<button id='createindemnifybutton'>添加</button>
		</c:if>
		<c:if test="${sessionScope.indemnifyupdate eq 'update'}">
			<button id='updateindemnifybutton'>修改</button>
		</c:if>
		 -->
		<c:if test="${sessionScope.indemnifydelsingle eq 'delsingle'}">
			<button id='deleteindemnifybutton'>删除赔偿</button>
		</c:if>
		<!--  
		<c:if test="${sessionScope.indemnifycleartab eq 'cleartab'}">
			<button id='clearindemnifybutton'>清除选择</button>
		</c:if>
		-->
	</div>
	<div id="mainPanle" region="center" style="overflow: hidden"
		border="false">
		<table id="tab" border="false">
		</table>

		<div id="allreportimport" style="height: 20%;display:none;">
			<!-- 赔偿信息导入页面开始 -->
			<div id="1" style="display: none; overflow: hidden;">

				赔偿信息( <a href="reportimport/templates/赔偿数据批次装载表模板.xls"
					target="_blank" style="color: green">模板下载</a>) <input type="file"
					name="uploadify1" id="uploadify1" /> <a
					href="javascript:$('#uploadify1').uploadifyUpload();">上传</a>|
				<a href="javascript:$('#uploadify1').uploadifyClearQueue();">
					取消上传</a>
				<div id="fileQueue1"></div>
			</div>
		</div>
		<div id="allreportsearch" style="height: 20%;display:none;">
			<form action="" method="post" id="form" name="">
				<table width="467" border="0" align="center">
					<tr>
						<td width="102" align="right">涉及赔偿公司:</td>
						<td width="349"><input type="text" name="idmniCompany"
							id="idmniidmniCompany" value="" /></td>
					</tr>
					<tr>
						<td align="right">邮件号:</td>
						<td><input type="text" name="mailNum" id="idmnimailNum"
							value="" /></td>
					</tr>
					<tr>
						<td align="right">赔偿日期:</td>
						<td><input type="text" name="pa95startmonth"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
							readonly="readonly" id="pa95startmonth" value="" />-<input
							type="text" name="pa95endmonth"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
							readonly="readonly" id="pa95endmonth" value="" /></td>
					</tr>
					<tr>
						<td></td>
						<td><input id="pa95button" type="button" value="查询" />
						</td>
					</tr>
				</table>
			</form>

		</div>
		<div id="allreportdel" style="height: 20%;display:none;">
			<form action="" method="post" id="form" name="">
				根据 <font color="red">表来源名</font>删除: <input type="text" name="tbName"
					id="pa95tbName" value="" /> <input id="pa95delbutton"
					type="button" value="删除" />
			</form>

		</div>

	</div>
	<!--赔偿单个邮件录入页面-->
	<div id="addindemnify" style="display: none; text-align: center;">
		<form action="" method="post" id="indemnifyform" name="indemnifyform">
			<input type="hidden" name="id" id="id"> <input type="hidden"
				name="tbType" id="tbType" value="">
			<table style="text-align: center;">
				<tr>
					<td align="right"><font color="red">*</font>涉及赔偿邮件:</td>
					<td><input type="text" name="idmniMail" id="idmniMail"
						onblur="showMailNum()" style="width: 150px;"
						class="easyui-validatebox" required="true" min="0"
						missingMessage="必填" validType="mailcheck"> <span id="show"
						style="display:none; "><font color="red">邮件不存在</font>
					</span></td>

				</tr>
				<tr>
					<td align="right">涉及赔偿公司:</td>
					<td><input type="text" name="idmniCompany" id="idmniCompany"
						style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>
				</tr>
				<tr>
					<td align="right">赔偿金额:</td>
					<td><input type="text" name="idmniAmount" id="idmniAmount"
						style="width: 150px;" class="easyui-numberbox" min="0"
						precision="2">
					</td>
				</tr>
				<tr>
					<td align="right">赔偿日期:</td>
					<td><input type="text" name="idmniDate" id="idmniDate"
						style="width: 150px;"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" value=""></td>
				</tr>
				<tr>
					<td align="right"><font color="red">*</font>赔偿原因:</td>
					<td><textarea rows="2" cols="22" id="idmniReason"
							name="idmniReason" class="easyui-validatebox"
							style="width: 150px;" required="true" validtype="length[0,1000]"
							missingMessage="必填"></textarea>
					</td>
				</tr>
				<tr>
					<td align="right">备注:</td>
					<td><textarea rows="2" cols="22" id="remark" name="remark"
							class="easyui-validatebox" validtype="length[0,1000]"
							style="width: 150px;"></textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!--赔偿单个邮件录入页面结束-->
</body>

</html>
