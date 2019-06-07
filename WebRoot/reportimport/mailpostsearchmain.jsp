<%@page import="java.util.Date"%>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>交寄信息导入</title>
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
		<script type="text/javascript"
			src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="js/common.js"></script>
		<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript"
			src="uploadify/jquery.uploadify.v2.1.4.min.js"></script>
		<script type="text/javascript" src="js/import.js"></script>
		<script type="text/javascript" src="js/mask.js"></script>

		<script type="text/javascript">
	$(function() {
		compayCodeselect("1", "entpsCode");
		$("#pa95button").click(
				function() {
					var mailpostsearch = new Array();
					mailpostsearch[0] = $("#entpsCode").val();
					mailpostsearch[1] = $("#mailpostmailNum").val();
					mailpostsearch[2] = $("#pa95startmonth").val();
					mailpostsearch[3] = $("#pa95endmonth").val();
					mailpostsearch[4] = $("#orderNum").val();
					FinanceList(mailpostsearch,
							"search.do?method=getMailPostSearchList");
					$("#allreportsearch").dialog("close");
				});

		$("#searchbutton").click(function() {
			importfinance("查询交寄", "allreportsearch");
		});

		$("#pa95button2")
				.click(
						function() {
							var mailpostsearch = new Array();
							mailpostsearch[1] = $("#mailpostmailNum2").val();
							if (checkMailNum2())
								FinanceList(mailpostsearch,
										"search.do?method=getMailPostSearchList");
							if (checkMailNum2())
								$
										.ajax({
											type : "POST",
											dataType : "text",
											url : "search.do?method=getMailPostSearchListLength&nowdate="
													+ new Date(),
											data : {
												"page" : $(".pagination-num")
														.val(),
												"rows" : $(
														".pagination-page-list")
														.attr("select",
																"selected")
														.val(),
												"mailpostmailNum2" : $(
														"#mailpostmailNum2")
														.val()
											},
											success : function(data) {
												showmessager(data);
											}
										});

						});

		$("#searchbutton2").click(function() {
			importfinance("查询交寄", "allreportsearch2");
		});

	});

	var isimport = true;
	function importfinance(addTitle, addId) {
		if (isimport) {
			importreport('uploadify1', 'import', 'mailPostImport',
					'fileQueue1', 'allreportimport');//交寄信息
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

	/**
	 * 交寄信息
	 */
	function FinanceList(mailpostsearch, searchmethod) {
		$("#tab").datagrid({
			nowrap : false,
			singleSelect : false,
			striped : true,
			fit : true,
			queryParams : {
				entpsCode : mailpostsearch[0],
				mailpostmailNum : mailpostsearch[1],
				StartDate : mailpostsearch[2],
				EndDate : mailpostsearch[3],
				orderNum : mailpostsearch[4]

			},
			pageNumber : 1,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : searchmethod,
			columns : [ [ {
				field : "clientCode",
				title : "客户代码",
				width : fillsize(0.1)
			}, {
				field : "deptName",
				title : "入网企业",
				width : fillsize(0.1)
			}, {
				field : "postDate",
				title : "交寄日期",
				width : fillsize(0.1)

			}, {
				field : "mailNum",
				title : "邮件号",
				width : fillsize(0.1)
			}, {
				field : "inAmount",
				title : "应收货款",
				width : fillsize(0.1)
			}, {
				field : "payment",
				title : "支付方式",
				width : fillsize(0.1)
			}, {
				field : "insurAmount",
				title : "保险保价金额",
				width : fillsize(0.1)
			}, {
				field : "insurance",
				title : "保险保价",
				width : fillsize(0.1)
			}, {
				field : "recipts",
				title : "收件人",
				width : fillsize(0.1)
			}, {
				field : "reciptsAdr",
				title : "收件人地址",
				width : fillsize(0.1)
			}, {
				field : "tel",
				title : "电话号码",
				width : fillsize(0.1)
			}, {
				field : "postCode",
				title : "邮编",
				width : fillsize(0.1)
			}, {
				field : "postFrom",
				title : "寄出地",
				width : fillsize(0.1)
			}, {
				field : "postTo",
				title : "寄达地",
				width : fillsize(0.1)
			}, {
				field : "orderNum",
				title : "订单号",
				width : fillsize(0.1)
			}, {
				field : "goods",
				title : "货物名称",
				width : fillsize(0.1)
			}, {
				field : "remark",
				title : "备注",
				width : fillsize(0.1)
			}, {
				field : "weight",
				title : "重量",
				width : fillsize(0.1)
			}, {
				field : "fee",
				title : "资费",
				width : fillsize(0.1)
			}, {
				field : "tbType",
				title : "表类型",
				width : fillsize(0.1)
			}, {
				field : "tbName",
				title : "表来源名",
				width : fillsize(0.1)
			} ] ],
			toolbar : [ {
				text : "按综合查询导出TXT",
				handler : function() {
					if (getRows("tab") != "") {
						FinanceListmailpost(mailpostsearch);
					} else {
						showmsg("没有要导出的数据");
					}

				}
			}, "-", {
				text : "按批量查询导出TXT",
				handler : function() {
					if (getRows("tab") != "") {
						if ($("#mailpostmailNum2").val() != "") {
							FinanceListmailpost3(mailpostsearch);
						} else {
							showmsg("没有要导出的数据");
						}

					} else {
						showmsg("没有要导出的数据");
					}
				}

			}, "-", {
				text : "按综合查询导出EXCEL",
				handler : function() {
					if (getRows("tab") != "") {
						ListmailpostEXCEL(mailpostsearch);
					} else {
						showmsg("没有要导出的数据");
					}

				}

			}, "-", {
				text : "按批量查询导出EXCEL",
				handler : function() {
					if (getRows("tab") != "") {

						if ($("#mailpostmailNum2").val() != "") {
							ListmailpostEXCEL2(mailpostsearch);
						} else {
							showmsg("没有要导出的数据");
						}

					} else {
						showmsg("没有要导出的数据");
					}

				}

			} ],

			pagination : true
		});

	}

	/**
	导出调用方法
	 */
	function FinanceListmailpost(mailpostsearch) {
		$("#entpsCode3").attr("value", mailpostsearch[0]);
		$("#mailpostmailNum3").attr("value", mailpostsearch[1]);
		$("#pa95startmonth3").attr("value", mailpostsearch[2]);
		$("#pa95endmonth3").attr("value", mailpostsearch[3]);
		$("#orderNum3").attr("value", mailpostsearch[4]);
		$("#exportmailpost").submit();

	}

	/**
	导出调用方法EXCEL
	 */
	function ListmailpostEXCEL(mailpostsearch) {
		$("#entpsCode5").attr("value", mailpostsearch[0]);
		$("#mailpostmailNum5").attr("value", mailpostsearch[1]);
		$("#pa95startmonth5").attr("value", mailpostsearch[2]);
		$("#pa95endmonth5").attr("value", mailpostsearch[3]);
		$("#orderNum5").attr("value", mailpostsearch[4]);
		$("#exportmailpost3").submit();

	}

	/**
	 导出调用方法TXT
	 */
	function FinanceListmailpost3(mailpostsearch) {
		$("#mailpostmailNum4").attr("value", mailpostsearch[1]);
		$("#exportmailpost2").submit();
	}

	/**
	 导出调用方法TXT
	 */
	function ListmailpostEXCEL2(mailpostsearch) {
		$("#mailpostmailNum6").attr("value", mailpostsearch[1]);
		$("#exportmailpost4").submit();
	}

	function checkMailNum2() {
		var mailpostmailNum2 = document.getElementById("mailpostmailNum2").value;
		if (mailpostmailNum2 == 0) {
			var divNode1 = document.getElementById("mailinfo2");
			divNode1.innerHTML = "邮件号不能为空";
			return false;
		} else {
			var divNode1 = document.getElementById("mailinfo2");
			divNode1.innerHTML = "";
			return true;
		}

	}

	//右下角提示信息
	function showmessager(data) {
		$.messager.show({
			title : "提示信息",
			msg : data,
			showType : "show",
			timeout : 0

		});
	}
</script>


	</head>
	<body class="easyui-layout" scroll="no">
		<div id="mainPanle" region="center" style="overflow: hidden"
			border="false">
			<div id="allreportsearch" style="height: 30%; display: block;">
				<table>
					<tr>
						<td>
							<form action="" method="post" id="form" name="">
								<table align="center" width="440" border="0">
									<tr>
										<td colspan="2" align="left">
											<font color="red" style="font-size: 14">综合查询:</font>
										</td>
									</tr>
									<tr>
										<td width="81" align="right">
											入网企业代码:
										</td>
										<td width="340">
											<select id="entpsCode" name="entpsCode" style="width: 124px;">
												<option value="">
													请选择
												</option>
											</select>
										</td>
									</tr>
									<tr>
										<td align="right">
											邮件号:
										</td>
										<td>
											<input type="text" name="mailNum" id="mailpostmailNum"
												value="" />
										</td>
									</tr>
									<tr>
										<td align="right">
											交寄日期:
										</td>
										<td>
											<input type="text" name="pa95startmonth"
												onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
												readonly="readonly" id="pa95startmonth" value="" />
											-
											<input type="text" name="pa95endmonth"
												onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
												readonly="readonly" id="pa95endmonth" value="" />
										</td>
									</tr>
									<tr>
										<td align="right">
											订单号:
										</td>
										<td>
											<input type="text" name="orderNum" id="orderNum" value="" />
										</td>
									</tr>
									<tr>
										<td></td>
										<td>
											<input id="pa95button" type="button" value="查询" />
										</td>
									</tr>
								</table>
							</form>
						</td>
						<td>
							<form action="" method="post" id="allreportsearch2form" name="">
								<table align="center" width="437" border="0">
									<tr>
										<td colspan="2" align="left">
											<font color="red" style="font-size: 14">根据邮件号批量查询:</font>
										</td>
									</tr>
									<tr>
										<td width="75" align="right">
											邮件号:
										</td>
										<td width="346">
											<textarea rows="5" cols="35" id="mailpostmailNum2"
												name="mailNum" value=""></textarea>
											<span id="mailinfo2" style="color: #FF0000"></span>
										</td>
									</tr>
									<tr>
										<td align="right">
											&nbsp;
										</td>
										<td>
											<input id="pa95button2" type="button" value="查询" />
										</td>
									</tr>
								</table>
							</form>
						</td>
					</tr>
				</table>
			</div>
			<hr />
			<div style="height: 65%;">
				<table id="tab" border="false">
				</table>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportMailpostList" method="post"
					id="exportmailpost" name="exportmailpost">
					<input type="text" name="entpsCode3" id="entpsCode3" value="" />
					<input type="text" name="mailpostmailNum3" id="mailpostmailNum3"
						value="" />
					<input type="text" name="pa95startmonth3" id="pa95startmonth3"
						value="" />
					<input type="text" name="pa95endmonth3" id="pa95endmonth3" value="" />
					<input type="text" name="orderNum3" id="orderNum3" value="" />
				</form>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportMailpostList" method="post"
					id="exportmailpost2" name="exportmailpost2">
					<textarea id="mailpostmailNum4" name="mailpostmailNum4" value=""></textarea>
				</form>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportMailpostEXCEL" method="post"
					id="exportmailpost3" name="exportmailpost3">
					<input type="text" name="entpsCode5" id="entpsCode5" value="" />
					<input type="text" name="mailpostmailNum5" id="mailpostmailNum5"
						value="" />
					<input type="text" name="pa95startmonth5" id="pa95startmonth5"
						value="" />
					<input type="text" name="pa95endmonth5" id="pa95endmonth5" value="" />
					<input type="text" name="orderNum5" id="orderNum5" value="" />
				</form>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportMailpostEXCEL" method="post"
					id="exportmailpost4" name="exportmailpost4">
					<textarea id="mailpostmailNum6" name="mailpostmailNum6" value=""></textarea>
				</form>
			</div>

		</div>
	</body>
</html>
