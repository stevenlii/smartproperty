<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>综合查询</title>
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
		$("#pa95button").click(function() {
			var mycars = new Array();
			mycars[0] = $("#mailNum").val();
			mycars[1] = $("#entpsCode").val();
			mycars[2] = $("#aceptDatestartmonth").val();
			mycars[3] = $("#aceptDateendmonth").val();
			mycars[4] = $("#pa95startmonth").val();
			mycars[5] = $("#pa95endmonth").val();
			mycars[6] = $("#StartDate").val();
			mycars[7] = $("#EndDate").val();
			mycars[8] = $("#tdfinished").val();
			FinanceList(mycars);

			$("#allreportsearch").dialog("close");
		});
		$("#searchbutton").click(function() {

			importfinance("查询", "allreportsearch");
		});

	});

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
	function FinanceList(mycars) {

		$("#tab").datagrid({
			nowrap : false,
			singleSelect : false,
			striped : true,
			fit : true,
			queryParams : {
				mailNum : mycars[0],//邮件号码
				entpsCode : mycars[1], //邮购公司
				aceptDatestartmonth : mycars[2],//交寄日期
				aceptDateendmonth : mycars[3],
				pa95startmonth : mycars[4],//结算日期
				pa95endmonth : mycars[5],
				StartDate : mycars[6],//投递日期
				EndDate : mycars[7],
				tdfinished : mycars[8]
			},
			pageNumber : 1,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "search.do?method=getIntegratedList",

			columns : [ [ {
				field : "mailNo",
				title : "邮件号",
				width : fillsize(0.1)
				 
			}, {
				field : "goods",
				title : "货物名称",
				width : fillsize(0.08),
				formatter : function(value, rec) {
					if (rec.tbmailPost == null) {
						return "";
					} else {
						return rec.tbmailPost.goods;
					}

				}
			}, {
				field : "recipts",
				title : "收件人",
				width : fillsize(0.08),
				formatter : function(value, rec) {
					if (rec.tbmailPost == null) {
						return "";
					} else {
						return rec.tbmailPost.recipts;
					}

				}
			}, {
				field : "inAmount",
				title : "应收货款",
				width : fillsize(0.08),
				formatter : function(value, rec) {
					if (rec.tbmailPost == null) {
						return "";
					} else {
						return rec.tbmailPost.inAmount;
					}

				}
			}, {
				field : "entpsCode",
				title : "入网企业代码",
				width : fillsize(0.08),
				formatter : function(value, rec) {
					if (rec.tbmailPost == null) {
						return "";
					} else {
						return rec.tbmailPost.entpsCode;
					}

				}
			}, {
				field : "postTo",
				title : "寄达地",
				width : fillsize(0.08),
				formatter : function(value, rec) {
					if (rec.tbmailPost == null) {
						return "";
					} else {
						return rec.tbmailPost.postTo;
					}

				}
			}, {
				field : "postDate",
				title : "交寄日期",
				width : fillsize(0.08),
				formatter : function(value, rec) {
					if (rec.tbmailPost == null) {
						return "";
					} else {
						return rec.tbmailPost.postDate;
					}

				}

			}, {
				field : "tdfinishedtime",
				title : "投递日期",
				width : fillsize(0.08),
				formatter : function(value, rec) {
					if (rec.tbTdgh == null) {
						return "";
					} else {
						return rec.tbTdgh.tdfinishedtime;
					}
				}

			}, {
				field : "billDate",
				title : "结算日期",
				width : fillsize(0.08),

				formatter : function(value, rec) {
					if (rec.tbFinance == null) {
						return "";
					} else {
						return rec.tbFinance.billDate;
					}
				}

			}, {
				field : "tdfinished",
				title : "投递状态",
				width : fillsize(0.1),
				formatter : function(value, rec) {
					if (rec.tbTdgh == null) {
						return rec.portrayal;
					} else {
						return rec.tbTdgh.tdfinished;
					}
				}
			}, {
				field : "billMailTypes",
				title : "结算状态",
				width : fillsize(0.1),
				formatter : function(value, rec) {
					if (rec.tbFinance == null) {
						return "";
					} else {
						return rec.tbFinance.billMailTypes;
					}

				}
			}, {
				field : "realFee",
				title : "实收费用",
				width : fillsize(0.06),
				formatter : function(value, rec) {
					if (rec.tbFinance == null) {
						return "";
					} else {
						return rec.tbFinance.realFee;
					}

				}
			}, {
				field : "total",
				title : "合计费用",
				width : fillsize(0.06),
				formatter : function(value, rec) {
					if (rec.tbFinance == null) {
						return "";
					} else {
						return rec.tbFinance.total;
					}

				}
			}, {
				field : "billFee",
				title : "结算货款",
				width : fillsize(0.06),
				formatter : function(value, rec) {
					if (rec.tbFinance == null) {
						return "";
					} else {
						return rec.tbFinance.billFee;
					}
				}
			} ] ],
			pagination : true,
			toolbar : [ {
				text : "按综合查询导出TXT",
				handler : function() {
					if (getRows("tab") != "") {
						FinanceListIntegrated(mycars);
					} else {
						showmsg("没有要导出的数据");
					}

				}
			}, "-", {
				text : "按综合查询导出EXCEL",
				handler : function() {
					if (getRows("tab") != "") {
						ListIntegratedEXCEL(mycars);
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
	function FinanceListIntegrated(mycars) {
		$("#mailNum3").attr("value", mycars[0]);
		$("#entpsCode3").attr("value", mycars[1]);
		$("#aceptDatestartmonth3").attr("value", mycars[2]);
		$("#aceptDateendmonth3").attr("value", mycars[3]);
		$("#pa95startmonth3").attr("value", mycars[4]);
		$("#pa95endmonth3").attr("value", mycars[5]);
		$("#StartDate3").attr("value", mycars[6]);
		$("#EndDate3").attr("value", mycars[7]);
		$("#tdfinished3").attr("value", mycars[8]);
		$("#exportIntegrated").submit();

	}

	/**
	 导出调用方法EXCEL
	 */
	function ListIntegratedEXCEL(mycars) {
		$("#mailNum5").attr("value", mycars[0]);
		$("#entpsCode5").attr("value", mycars[1]);
		$("#aceptDatestartmonth5").attr("value", mycars[2]);
		$("#aceptDateendmonth5").attr("value", mycars[3]);
		$("#pa95startmonth5").attr("value", mycars[4]);
		$("#pa95endmonth5").attr("value", mycars[5]);
		$("#StartDate5").attr("value", mycars[6]);
		$("#EndDate5").attr("value", mycars[7]);
		$("#tdfinished5").attr("value", mycars[8]);
		$("#exportIntegratedexcel").submit();

	}
	function selectcheckBox() {
		if ($("#checkbox1").attr("checked") == "checked") {
			$("#show1").show();
		} else {
			$("#show1").hide();
		}

		if ($("#checkbox2").attr("checked") == "checked") {
			$("#show2").show();
		} else {
			$("#show2").hide();
		}

		if ($("#checkbox3").attr("checked") == "checked") {
			$("#show3").show();
		} else {
			$("#show3").hide();
		}
	}
</script>
	</head>
	<body class="easyui-layout" scroll="no">
		<div id="mainPanle" region="center" style="overflow: hidden"
			border="false">
			<table id="tab" border="false">
			</table>
			<div id="allreportsearch" style="height: 35%; display: block;">
				<form action="" method="post" id="form" name="">
					<table width="550" height="100" align="center">
						<tr>
							<td colspan="4" align="center">
								<font color="red" style="font-size: 14">综合查询</font>
							</td>
						</tr>
						<tr>
							<td align="center" width="131">
								<label>
									交寄条件
								</label>
								<input type="checkbox" name="checkbox" value="checkbox"
									id="checkbox1" onClick="selectcheckBox()" />

							</td>
							<td align="center" colspan="2" width="266">
								<label>
									投递条件
								</label>
								<input type="checkbox" name="checkbox" value="checkbox"
									id="checkbox2" onClick="selectcheckBox()" />

							</td>
							<td align="center" width="131">
								<label>
									财务条件
								</label>
								<input type="checkbox" name="checkbox" value="checkbox"
									id="checkbox3" onClick="selectcheckBox()" />
							</td>
						</tr>
					</table>
					<table width="550" style="display: none;" id="show1" align="center">
						<tr>
							<td>
								邮件号码:
								<input type="text" name="mailNum" id="mailNum">
							</td>
							<td>
								邮购公司:
								<select id="entpsCode" name="entpsCode" style="width: 124px;">
									<option value="">
										请选择
									</option>
								</select>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								交寄日期:
								<input type="text" name="aceptDatestartmonth"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
									readonly="readonly" id="aceptDatestartmonth" value="" />
								-
								<input type="text" name="aceptDateendmonth"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
									readonly="readonly" id="aceptDateendmonth" value="" />
							</td>
						</tr>
					</table>
					<table width="550" style="display: none;" id="show2" align="center">
						<tr>
							<td>
								投递日期:
								<input type="text" name="StartDate"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
									class="Wdate" readonly="readonly" id="StartDate" value="" />
								-
								<input type="text" name="EndDate"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
									class="Wdate" readonly="readonly" id="EndDate" value="" />
							</td>
						</tr>
					</table>
					<table width="550" style="display: none;" id="show3" align="center">
						<tr>
							<td>
								结算日期:
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
								投递状态:
								<select id="tdfinished" name="tdfinished" style="width: 124px;">
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
					</table>
					<div align="center">
						<input id="pa95button" type="button" value="查询" />
					</div>

				</form>
			</div>

			<div style="display: none;">
				<form action="search.do?method=exportIntegratedList" method="post"
					id="exportIntegrated" name="exportIntegrated">
					<input type="text" name="mailNum3" id="mailNum3">
					<input type="text" name="entpsCode3" id="entpsCode3" value="" />
					<input type="text" name="aceptDatestartmonth3"
						id="aceptDatestartmonth3" value="" />
					<input type="text" name="aceptDateendmonth3"
						id="aceptDateendmonth3" value="" />
					<input type="text" name="StartDate3" id="StartDate3" value="" />
					<input type="text" name="EndDate3" id="EndDate3" value="" />
					<input type="text" name="pa95startmonth3" id="pa95startmonth3"
						value="" />
					<input type="text" name="pa95endmonth3" id="pa95endmonth3" value="" />
					<input type="text" name="tdfinished3" id="tdfinished3" value="" />
				</form>
			</div>

			<div style="display: none;">
				<form action="search.do?method=exportIntegratedEXCEL" method="post"
					id="exportIntegratedexcel" name="exportIntegratedexcel">
					<input type="text" name="mailNum5" id="mailNum5">
					<input type="text" name="entpsCode5" id="entpsCode5" value="" />
					<input type="text" name="aceptDatestartmonth5"
						id="aceptDatestartmonth5" value="" />
					<input type="text" name="aceptDateendmonth5"
						id="aceptDateendmonth5" value="" />
					<input type="text" name="StartDate5" id="StartDate5" value="" />
					<input type="text" name="EndDate5" id="EndDate5" value="" />
					<input type="text" name="pa95startmonth5" id="pa95startmonth5"
						value="" />
					<input type="text" name="pa95endmonth5" id="pa95endmonth5" value="" />
					<input type="text" name="tdfinished5" id="tdfinished5" value="" />
				</form>
			</div>
		</div>
	</body>
</html>
