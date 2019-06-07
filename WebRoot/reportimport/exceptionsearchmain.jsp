<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>异常录入</title>
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
		exceptionlist('');
		//异常邮件信息
		$("#importbutton").click(function() {
			importfinance("装载异常邮件", "allreportimport");
		});
		$("#pa95button").click(function() {
			var search = new Array();
			search[0] = $("#idmniidmniCompany").val();//登记人
			search[1] = $("#idmnimailNum").val();
			search[2] = $("#pa95startmonth").val();
			search[3] = $("#pa95endmonth").val();
			exceptionlist(search);
			$("#allreportsearch").dialog("close");
		});
		$("#searchbutton").click(function() {
			importfinance("查询异常邮件", "allreportsearch");
		});
		$("#createexceptionbutton").click(function() {
			//$("#amount").numberbox("clear");
			createexception();
		});
		$("#updateexceptionbutton").click(
				function() {
					var row = $("#tab").datagrid("getSelected");
					if (row == null) {
						$.messager.alert("警告信息", "选择一条记录", "warning");
					} else {
						updateexception("异常邮件录入", "exceptionform", row,
								"addexception",
								"input.do?method=updateException");
					}

				});
		$("#deleteexceptionbutton").click(function() {
			var row = $("#tab").datagrid("getSelected");
			if (row == null) {
				$.messager.alert("警告信息", "选择一条要删除的记录！", "warning");
			} else {
				$.messager.confirm("确认", "确定要删除?", function(r) {
					if (r) {
						deleall("input.do?method=deleteExceptionById");
					}
				});
			}

		});

		$("#clearexceptionbutton").click(function() {
			clearSelect("tab");
		});

		// 邮件号验证
		$.extend($.fn.validatebox.defaults.rules, {
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
			importreport('uploadify1', 'import', 'exceptionImport',
					'fileQueue1', 'allreportimport');//异常信息
			isimport = false;
		}
		$("#" + addId).show();
		$("#" + addId).dialog({
			title : addTitle + "信息",
			modal : true,
			width : 550,
			height : 400,
			collapsible : true,
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

	function createexception() {
		resetContent("exceptionform");
		var dt = new Date().format("yyyy-MM-dd");
		$("#billDate").val(dt); //
		$("#addexception").show();
		$("#addexception")
				.dialog(
						{
							title : "录入异常邮件信息",
							modal : true,
							width : 400,
							height : 300,
							minimizable : false,
							maximizable : false,
							buttons : [
									{
										text : "添加",
										iconCls : "icon-ok",
										handler : function() {
											if (b == 0) {
												if ($("#billDate").val() != null
														&& $("#billDate").val() != "") {
													$("#exceptionform")
															.form(
																	"submit",
																	{
																		url : "input.do?method=addException",
																		onSubmit : function() {
																			return $(
																					this)
																					.form(
																							"validate");
																		},
																		success : function(
																				data) {
																			$(
																					"#addexception")
																					.dialog(
																							"close");
																			flashTable("tab");
																			showmsg(data);
																		}

																	});
												} else {
													//alert("登记日期不为空");
													$.messager.alert("警告信息",
															"登记日期不为空",
															"warning");
												}
											}
										}
									}, {
										text : "取消",
										iconCls : "icon-undo",
										handler : function() {
											$("#addexception").dialog("close");
										}
									} ]
						});
	}

	//异常信息
	function exceptionlist(search) {
		$("#tab").datagrid({
			singleSelect : false,
			fit : true,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "search.do?method=getExceptionList",
			queryParams : {
				subscriber : search[0],
				mailNum : search[1],
				StartDate : search[2],
				EndDate : search[3]
			},
			columns : [ [ {
				field : "billDate",
				title : "登记日期",
				width : fillsize(0.1)

			}, {
				field : "mailNum",
				title : "邮件号",
				width : fillsize(0.1)
			}, {
				field : "amount",
				title : "金额",
				width : fillsize(0.1)

			}, {
				field : "company",
				title : "公司名称",
				width : fillsize(0.1)

			}, {
				field : "whyException",
				title : "异常原因",
				width : fillsize(0.1)

			}, {
				field : "subscriber",
				title : "登记人",
				width : fillsize(0.1)
			} ] ],
			pagination : true

		});

	}

	//根据邮件号得到公司及金额
	var b = 0;
	function showMailNum() {
		var num = $("#mailNum").val();//得到邮件号码
		if (num != "" && num != null) {
			$
					.post(
							"input.do?method=checkExceptionMailNum&mailNum="
									+ num,
							function(a) {
								//alert("a的值"+a);
								if (a == null || a == '' || a == undefined) {
									b = 1;
									document.getElementById("show").style.display = "block";
								} else {
									var st = a.split(",");
									$("#amount").val(st[0]);
									$("#company").val(st[1]);
									document.getElementById("show").style.display = "none";
									b = 0;
								}
							});
		}
	}

	/**
	 *修改异常信息
	 */
	function updateexception(updattitle, updatform, row, updatId, updatMethod) {
		resetContent(updatform);
		$("#id").attr("value", row.id);
		$("#billDate").attr("value", row.billDate);
		$("#mailNum").attr("value", row.mailNum);
		$("#amount").attr("value", row.amount);
		$("#company").attr("value", row.company);
		$("#whyException").attr("value", row.whyException);
		$("#subscriber").attr("value", row.subscriber);
		updat(updattitle, updatform, updatId, updatMethod);
	}
</script>
</head>

<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
	<div region="north" split="true" border="false"
		style="height: 25px;padding: 2px 0 0 2px;">
		<c:if test="${sessionScope.exceptionsearch eq 'search'}">
			<button id='searchbutton'>查询</button>
		</c:if>
	</div>
	<div id="mainPanle" region="center" style="overflow: hidden"
		border="false">
		<table id="tab" width="100%" height="100%" border="false"></table>
	</div>
	<div id="allreportimport" style="height: 20%;display:none;">
		<!-- 异常邮件信息导入页面开始 -->
		<div id="1" style="display: none; overflow: hidden;">

			异常邮件信息(
			<target ="_blank" style="color: green">模板下载（缺！）) <input
				type="file" name="uploadify1" id="uploadify1" /> <a
				href="javascript:$('#uploadify1').uploadifyUpload();">上传</a>|
			<a href="javascript:$('#uploadify1').uploadifyClearQueue()">
				取消上传</a>
			<div id="fileQueue1"></div>
		</div>
	</div>
	<div id="allreportsearch" style="height: 20%;display:none;">
		<form action="" method="post" id="form" name="">
			<table width="467" border="0" align="center">

				<tr>
					<td align="right">邮件号:</td>
					<td><input type="text" name="mailNum" id="idmnimailNum"
						value="" /></td>
				</tr>
				<tr>
					<td align="right">登记日期:</td>
					<td><input type="text" name="pa95startmonth"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" id="pa95startmonth" value="" />-<input
						type="text" name="pa95endmonth"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" id="pa95endmonth" value="" /></td>
				</tr>
				<tr>
					<td width="102" align="right">登记人:</td>
					<td width="349"><input type="text" name="subscriber"
						id="idmniidmniCompany" value="" /></td>
				</tr>
				<tr>
					<td></td>
					<td><input id="pa95button" type="button" value="查询" />
					</td>
				</tr>
			</table>
		</form>

	</div>
	<!--异常邮件添加页面-->
	<div id="addexception" style="display: none; text-align: center;">
		<form action="" method="post" id="exceptionform" name="exceptionform">
			<input type="hidden" name="id" id="id"> <input type="hidden"
				name="tbType" id="tbType" value="">
			<table style="text-align: center;">

				<tr>
					<td align="right"><font color="red">*</font>邮件号:</td>
					<td><input type="text" id="mailNum" name="mailNum"
						onblur="showMailNum()" width="220px" class="easyui-validatebox"
						required="true" validType="mailcheck" missingMessage="必填"
						style="width: 150px;" /> <span id="show" style="display:none; "><font
							color="red">邮件不存在</font>
					</span></td>
				</tr>
				<tr>
					<td align="right">金额:</td>
					<td><input type="text" name="amount" id="amount"
						style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>
				</tr>
				<tr>
					<td align="right">公司名称:</td>
					<td><input type="text" name="company" id="company"
						style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>
				</tr>
				<tr>
					<td align="right"><font color="red">*</font>异常原因:</td>
					<td><textarea rows="2" cols="22" id="whyException"
							name="whyException" class="easyui-validatebox" required="true"
							missingMessage="必填" style="width: 150px;"></textarea>
					</td>
				</tr>
				<tr>
					<td align="right">登记人:</td>
					<td><input type="text" name="subscriber" id="subscriber"
						style="width: 150px;" class="easyui-validatebox">
					</td>
				</tr>
				<tr>
					<td align="right"><font color="red">*</font>登记日期:</td>
					<td><input type="text" name="billDate" id="billDate"
						style="width: 150px;"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" value=""></td>
				</tr>
			</table>
		</form>
	</div>
	<!--异常邮件添加页面结束-->

</body>
</html>