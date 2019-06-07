<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>财务信息查询</title>
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
		compayCodeselect("1", "infetonetCode");
		$("#pa95button").click(function() {
			var mycars = new Array();
			mycars[0] = $("#financemailNum").val();
			mycars[1] = $("#pa95startmonth").val();
			mycars[2] = $("#pa95endmonth").val();
			mycars[3] = $("#aceptDatestartmonth").val();
			mycars[4] = $("#aceptDateendmonth").val();
			mycars[5] = $("#recipienName").val();
			mycars[6] = $("#infetonetCode").val();
			mycars[7] = $("#orderNum").val();
			mycars[8] = $("#billMailTypes").val();
			FinanceList(mycars, "search.do?method=getFinanceSearch");

			$("#allreportsearch").dialog("close");

		});
		$("#searchbutton").click(function() {

			importfinance("查询财务", "allreportsearch");
		});

		$("#pa95button2")
				.click(
						function() {
							var mycars = new Array();
							mycars[0] = $("#financemailNum2").val();
							if (checkMailNum2())
								FinanceList(mycars,
										"search.do?method=getFinanceSearch");
							if (checkMailNum2())
								$
										.ajax({
											type : "POST",
											dataType : "text",
											url : "search.do?method=getFinanceSearchListLength&nowdate="
													+ new Date(),
											data : {
												"page" : $(".pagination-num")
														.val(),
												"rows" : $(
														".pagination-page-list")
														.attr("select",
																"selected")
														.val(),
												"financemailNum2" : $(
														"#financemailNum2")
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
		//多选查询 

	});
	//右下角提示信息
	function showmessager(data) {
		$.messager.show({
			title : "提示信息",
			msg : data,
			showType : "show",
			timeout : 0

		});
	}

	var isimport = true;
	function importfinance(addTitle, addId) {
		if (isimport) {
			importreport('uploadify1', 'import', 'financeImport', 'fileQueue1',
					'allreportimport');//财务信息
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

	/**
	 * 财务信息
	 */
	function FinanceList(mycars, searchmethod) {
		$("#tab").datagrid({
			nowrap : false,
			singleSelect : false,
			striped : true,
			fit : true,
			queryParams : {
				financemailNum : mycars[0],
				pa95startmonth : mycars[1],
				pa95endmonth : mycars[2],
				aceptDatestartmonth : mycars[3],
				aceptDateendmonth : mycars[4],
				recipienName : mycars[5],
				infetonetCode : mycars[6],
				orderNum : mycars[7],
				billMailTypes : mycars[8]
			},
			pageNumber : 1,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : searchmethod,
			columns : [ [ {
				field : "mailNum",
				title : "邮件号",
				width : fillsize(0.12)
			}, {
				field : "billDate",
				title : "结算日期",
				width : fillsize(0.08)

			}, {
				field : "consDate",
				title : "交寄日期",
				width : fillsize(0.08)

			}, {
				field : "aceptDate",
				title : "收寄日期",
				width : fillsize(0.08)

			}, {
				field : "mailingDate",
				title : "投递日期",
				width : fillsize(0.1)

			}, {
				field : "recipienName",
				title : "收件人姓名",
				width : fillsize(0.08)
			}, {
				field : "recipienAddr",
				title : "收件人地址",
				width : fillsize(0.3)
			}, {
				field : "orderNum",
				title : "订单编号",
				width : fillsize(0.06)
			}, {
				field : "aceptSetupe",
				title : "收寄局机构",
				width : fillsize(0.06)
			}, {
				field : "mailingSetupe",
				title : "投递局机构",
				width : fillsize(0.06)
			}, {
				field : "tonetCode",
				title : "入网企业代码",
				width : fillsize(0.08)
			}, {
				field : "customerCode",
				title : "大客户代码",
				width : fillsize(0.08)
			}, {
				field : "deptName",
				title : "下级入网企业",
				width : fillsize(0.1)
			}, {
				field : "inferiorCode",
				title : "下级客户代码",
				width : fillsize(0.1)
			}, {
				field : "realFee",
				title : "实收费用",
				width : fillsize(0.06)
			}, {
				field : "sviceFee",
				title : "服务费",
				width : fillsize(0.06)
			}, {
				field : "setFee",
				title : "结算费",
				width : fillsize(0.06)
			}, {
				field : "returnFee",
				title : "退回邮费",
				width : fillsize(0.06)
			}, {
				field : "whyReturn",
				title : "退回原因",
				width : fillsize(0.06)
			}, {
				field : "total",
				title : "合计费用",
				width : fillsize(0.06)
			}, {
				field : "payFee",
				title : "应收货款",
				width : fillsize(0.06)
			}, {
				field : "billFee",
				title : "结算货款",
				width : fillsize(0.06)
			}, {
				field : "billBlace",
				title : "结算余额",
				width : fillsize(0.06)
			}, {
				field : "billMailTypes",
				title : "结算邮件类型标识",
				width : fillsize(0.1)
			}, {
				field : "rate",
				title : "费率",
				width : fillsize(0.06)
			}, {
				field : "tbName",
				title : "表来源名",
				width : fillsize(0.15)
			} ] ],
			pagination : true,
			pagination : true,
			toolbar : [ {
				text : "按综合查询导出TXT",
				handler : function() {
					if (getRows("tab") != "") {
						FinanceListfinance(mycars);
					} else {
						showmsg("没有要导出的数据");
					}

				}
			}, "-", {
				text : "按批量查询导出TXT",
				handler : function() {
					if (getRows("tab") != "") {
						if ($("#financemailNum2").val() != "") {
							FinanceListfinance2(mycars);
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
						ListfinanceEXCEL(mycars);
					} else {
						showmsg("没有要导出的数据");
					}

				}

			}, "-", {
				text : "按批量查询导出EXCEL",
				handler : function() {
					if (getRows("tab") != "") {
						if ($("#financemailNum2").val() != "") {
							ListfinanceEXCEL2(mycars);
						} else {
							showmsg("没有要导出的数据");
						}

					} else {
						showmsg("没有要导出的数据");
					}

				}

			} ]

		});
	}
	/**
	导出调用方法TXT
	 */
	function FinanceListfinance(mycars) {
		$("#financemailNum3").attr("value", mycars[0]);
		$("#pa95startmonth3").attr("value", mycars[1]);
		$("#pa95endmonth3").attr("value", mycars[2]);
		$("#aceptDatestartmonth3").attr("value", mycars[3]);
		$("#aceptDateendmonth3").attr("value", mycars[4]);
		$("#recipienName3").attr("value", mycars[5]);
		$("#infetonetCode3").attr("value", mycars[6]);
		$("#orderNum3").attr("value", mycars[7]);
		$("#billMailTypes3").attr("value", mycars[8]);
		$("#exportfinance").submit();
	}

	/**
	 导出调用方法TXT
	 */
	function FinanceListfinance2(mycars) {
		$("#financemailNum4").attr("value", mycars[0]);
		$("#exportfinance2").submit();
	}

	/**
	 导出调用方法EXCEL
	 */
	function ListfinanceEXCEL(mycars) {
		$("#financemailNum5").attr("value", mycars[0]);
		$("#pa95startmonth5").attr("value", mycars[1]);
		$("#pa95endmonth5").attr("value", mycars[2]);
		$("#aceptDatestartmonth5").attr("value", mycars[3]);
		$("#aceptDateendmonth5").attr("value", mycars[4]);
		$("#recipienName5").attr("value", mycars[5]);
		$("#infetonetCode5").attr("value", mycars[6]);
		$("#orderNum5").attr("value", mycars[7]);
		$("#billMailTypes5").attr("value", mycars[8]);
		$("#exportfinanceexcel").submit();

	}

	/**
	 导出调用方法EXCEL
	 */
	function ListfinanceEXCEL2(mycars) {
		$("#financemailNum6").attr("value", mycars[0]);
		$("#exportfinanceexcel2").submit();
	}

	function checkMailNum2() {
		var financemailNum2 = document.getElementById("financemailNum2").value;
		if (financemailNum2 == 0) {
			var divNode1 = document.getElementById("mailinfo2");
			divNode1.innerHTML = "邮件号不能为空";
			return false;
		} else {
			var divNode1 = document.getElementById("mailinfo2");
			divNode1.innerHTML = "";
			return true;
		}

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
								<table width="600" border="0" align="center">
									<tr>
										<td colspan="2" align="left">
											<font color="red" style="font-size: 14">综合查询:</font>
										</td>
									</tr>
									<tr>
										<td width="75">
											<span style="float: right">邮件号:</span>
										</td>
										<td>
											<input type="text" name="mailNum" id="financemailNum" />
										</td>
										<td>
											<span style="float: right">结算日期:</span>
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
										<td>
											<span style="float: right">收件人姓名:</span>
										</td>
										<td>
											<input type="text" name="recipienName" id="recipienName" />
										</td>
										<td>
											<span style="float: right">交寄日期:</span>
										</td>
										<td>
											<input type="text" name="aceptDatestartmonth"
												onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
												readonly="readonly" id="aceptDatestartmonth" value="" />
											-
											<input type="text" name="aceptDateendmonth"
												onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
												readonly="readonly" id="aceptDateendmonth" value="" />
										</td>
									</tr>
									<tr>
										<td>
											<span style="float: right">入网企业:</span>
										</td>
										<td>
											<!-- 	<input type="text" name="infetonetCode" id="infetonetCode"/> -->
											<select id="infetonetCode" name="infetonetCode"
												style="width: 124px;">
												<option value="">
													请选择
												</option>
											</select>
										</td>
										<td>
											<span style="float: right">订单号:</span>
										</td>
										<td>
											<input type="text" name="orderNum" id="orderNum" />
										</td>
									</tr>
									<tr>
										<td>
											<span style="float: right">投递状态:</span>
										</td>
										<td>
											<select id="billMailTypes" name="billMailTypes"
												style="width: 124px;">
												<option value="">
													请选择
												</option>
												<option value="妥投">
													妥投
												</option>
												<option value="退回">
													退回
												</option>
											</select>
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
											<textarea rows="5" cols="35" id="financemailNum2"
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
				<table id="tab" border="false"></table>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportFinanceList" method="post"
					id="exportfinance" name="exportfinance">
					<input type="text" name="financemailNum3" id="financemailNum3" />
					<input type="text" name="pa95startmonth3" id="pa95startmonth3"
						value="" />
					<input type="text" name="pa95endmonth3" id="pa95endmonth3" value="" />
					<input type="text" name="aceptDatestartmonth3"
						id="aceptDatestartmonth3" value="" />
					<input type="text" name="aceptDateendmonth3"
						id="aceptDateendmonth3" value="" />
					<input type="text" name="recipienName3" id="recipienName3" value="" />
					<input type="text" name="infetonetCode3" id="infetonetCode3"
						value="" />
					<input type="text" name="orderNum3" id="orderNum3" value="" />
					<input type="text" name="billMailTypes3" id="billMailTypes3"
						value="" />
				</form>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportFinanceList" method="post"
					id="exportfinance2" name="exportfinance2">
					<textarea id="financemailNum4" name="financemailNum4" value=""></textarea>
				</form>
			</div>

			<div style="display: none;">
				<form action="search.do?method=exportFinanceEXCEL" method="post"
					id="exportfinanceexcel" name="exportfinanceexcel">
					<input type="text" name="financemailNum5" id="financemailNum5" />
					<input type="text" name="pa95startmonth5" id="pa95startmonth5"
						value="" />
					<input type="text" name="pa95endmonth5" id="pa95endmonth5" value="" />
					<input type="text" name="aceptDatestartmonth5"
						id="aceptDatestartmonth5" value="" />
					<input type="text" name="aceptDateendmonth5"
						id="aceptDateendmonth5" value="" />
					<input type="text" name="recipienName5" id="recipienName5" value="" />
					<input type="text" name="infetonetCode5" id="infetonetCode5"
						value="" />
					<input type="text" name="orderNum5" id="orderNum5" value="" />
					<input type="text" name="billMailTypes5" id="billMailTypes5"
						value="" />
				</form>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportFinanceEXCEL" method="post"
					id="exportfinanceexcel2" name="exportfinanceexcel2">
					<textarea id="financemailNum6" name="financemailNum6" value=""></textarea>
				</form>
			</div>
		</div>
	</body>

</html>
