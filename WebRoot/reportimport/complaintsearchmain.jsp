<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>投诉查询</title>
		<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript" src="js/vtip-min.js"></script>
		<script type="text/javascript" src="jeasyui/jquery.easyui.min.js"></script>
		<script type="text/javascript"
			src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
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
		compayCodeselect("1", "complaintmailCompany");
		//投诉查询 
		$("#pa95button").click(
				function() {
					var complaintsearch = new Array();
					complaintsearch[0] = $("#complaintcpNum").val();
					complaintsearch[1] = $("#complaintmailCompany").val();
					complaintsearch[2] = $("#complaintdeliveryBur").val();
					complaintsearch[3] = $("#cpDatestartmonth").val();
					complaintsearch[4] = $("#pa95endmonth").val();
					complaintsearch[5] = $("#replyDatestartmonth").val();
					complaintsearch[6] = $("#replyDateendmonth").val();
					complaintsearch[7] = $("#complaintmailNum").val();
					complaintsearch[8] = $("#complaintpostFrom").val();
					complaintsearch[9] = $("#complaintrecipts").val();
					complaintsearch[10] = $("#complaintreciptsTel").val();
					complaintsearch[11] = $("#complaintreplyComment").val();
					complaintsearch[12] = $("#complaintcpType").val();
					FinanceList(complaintsearch,
							"search.do?method=getComplaintSearchList");
					$("#allreportsearch").dialog("close");
				});
		$("#searchbutton").click(function() {
			importfinance("查询投诉", "allreportsearch");
		});

		$("#pa95button2").click(
				function() {
					var complaintsearch = new Array();
					complaintsearch[7] = $("#complaintmailNum2").val();
					if (checkMailNum2())
						FinanceList(complaintsearch,
								"search.do?method=getComplaintSearchList");
				});
		$("#searchbutton2").click(function() {
			importfinance("查询投诉", "allreportsearch2");
		});
		//多选查询 

	});

	var isimport = true;
	function importfinance(addTitle, addId) {
		if (isimport) {
			importreport('uploadify1', 'import', 'complaintImport',
					'fileQueue1', 'allreportimport');//投诉信息
			isimport = false;
		}
		$("#" + addId).show();
		$("#" + addId).dialog({
			title : addTitle + "信息",
			modal : true,
			width : 500,
			height : 380,
			minimizable : false,
			maximizable : false
		});
	}

	/**
	 * 投诉信息*/

	function FinanceList(complaintsearch, searchmethod) {
		$("#tab").datagrid({
			nowrap : false,
			singleSelect : false,
			striped : true,
			fit : true,
			queryParams : {
				cpNum : complaintsearch[0],
				mailCompany : complaintsearch[1],
				deliveryBur : complaintsearch[2],
				StartDate : complaintsearch[3],
				EndDate : complaintsearch[4],
				replyDatestartmonth : complaintsearch[5],
				replyDateendmonth : complaintsearch[6],
				complaintmailNum : complaintsearch[7],
				postFrom : complaintsearch[8],
				recipts : complaintsearch[9],
				reciptsTel : complaintsearch[10],
				replyComment : complaintsearch[11],
				cpType : complaintsearch[12],
				replySuccess : complaintsearch[13]
			},
			pageNumber : 1,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : searchmethod,
			columns : [ [ {
				field : "cpNum",
				title : "投诉单号码",
				width : fillsize(0.16)
			}, {
				field : "cpDate",
				title : "投诉日期",
				width : fillsize(0.1)

			}, {
				field : "deptName",
				title : "邮购公司",
				width : fillsize(0.09)
			}, {
				field : "mailNum",
				title : "邮件号码",
				width : fillsize(0.1)
			}, {
				field : "postDate",
				title : "交寄日期",
				width : fillsize(0.1)

			}, {
				field : "postFrom",
				title : "寄出地",
				width : fillsize(0.12)
			}, {
				field : "recipts",
				title : "收件人",
				width : fillsize(0.07)
			}, {
				field : "reciptsAdr",
				title : "收件人地址",
				width : fillsize(0.12)
			}, {
				field : "reciptsTel",
				title : "收件人电话",
				width : fillsize(0.09)
			}, {
				field : "receiAmount",
				title : "应收货款",
				width : fillsize(0.06)
			}, {
				field : "deliveryBur",
				title : "投递局",
				width : fillsize(0.08)
			}, {
				field : "cpType",
				title : "投诉类别",
				width : fillsize(0.08)
			}, {
				field : "cpComment",
				title : "投诉内容",
				width : fillsize(0.3)
			}, {
				field : "faxDate",
				title : "传真日期",
				width : fillsize(0.1)

			}, {
				field : "cpSpecie",
				title : "投诉种类",
				width : fillsize(0.08)
			}, {
				field : "replyDate",
				title : "回复日期",
				width : fillsize(0.1)

			}, {
				field : "replyComment",
				title : "回复内容",
				width : fillsize(0.2)
			}, {
				field : "contact",
				title : "联系人",
				width : fillsize(0.07)
			}, {
				field : "contactTel",
				title : "联系电话",
				width : fillsize(0.09)
			}, {
				field : "tbName",
				title : "表来源名",
				width : fillsize(0.1)
			} ] ],
			pagination : true,
			toolbar : [ {
				text : "按综合查询导出TXT",
				handler : function() {
					if (getRows("tab") != "") {
						FinanceListcomplaint2(complaintsearch);
					} else {
						showmsg("没有要导出的数据");
					}

				}
			}, "-", {
				text : "按批量查询导出TXT",
				handler : function() {
					if (getRows("tab") != "") {
						if ($("#complaintmailNum2").val() != "") {
							FinanceListcomplaint3(complaintsearch);
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
						ListcomplaintEXCEL(complaintsearch);
					} else {
						showmsg("没有要导出的数据");
					}

				}

			}, "-", {
				text : "按批量查询导出EXCEL",
				handler : function() {
					if (getRows("tab") != "") {
						if ($("#complaintmailNum2").val() != "") {
							ListcomplaintEXCEL2(complaintsearch);
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
	function FinanceListcomplaint2(complaintsearch) {
		$("#complaintcpNum3").attr("value", complaintsearch[0]);
		$("#complaintmailCompany3").attr("value", complaintsearch[1]);
		$("#complaintdeliveryBur3").attr("value", complaintsearch[2]);
		$("#cpDatestartmonth3").attr("value", complaintsearch[3]);
		$("#cpDateendmonth3").attr("value", complaintsearch[4]);
		$("#replyDatestartmonth3").attr("value", complaintsearch[5]);
		$("#replyDateendmonth3").attr("value", complaintsearch[6]);
		$("#complaintmailNum3").attr("value", complaintsearch[7]);
		$("#complaintpostFrom3").attr("value", complaintsearch[8]);
		$("#complaintrecipts3").attr("value", complaintsearch[9]);
		$("#complaintreciptsTel3").attr("value", complaintsearch[10]);
		$("#complaintreplyComment3").attr("value", complaintsearch[11]);
		$("#complaintcpType3").attr("value", complaintsearch[12]);
		$("#export").submit();

	}

	/**
	 导出调用方法TXT
	 */
	function FinanceListcomplaint3(complaintsearch) {
		$("#complaintmailNum4").attr("value", complaintsearch[7]);
		$("#export2").submit();
	}

	/**
	 导出调用方法EXCEL
	 */
	function ListcomplaintEXCEL(complaintsearch) {
		$("#complaintcpNum5").attr("value", complaintsearch[0]);
		$("#complaintmailCompany5").attr("value", complaintsearch[1]);
		$("#complaintdeliveryBur5").attr("value", complaintsearch[2]);
		$("#cpDatestartmonth5").attr("value", complaintsearch[3]);
		$("#cpDateendmonth5").attr("value", complaintsearch[4]);
		$("#replyDatestartmonth5").attr("value", complaintsearch[5]);
		$("#replyDateendmonth5").attr("value", complaintsearch[6]);
		$("#complaintmailNum5").attr("value", complaintsearch[7]);
		$("#complaintpostFrom5").attr("value", complaintsearch[8]);
		$("#complaintrecipts5").attr("value", complaintsearch[9]);
		$("#complaintreciptsTel5").attr("value", complaintsearch[10]);
		$("#complaintreplyComment5").attr("value", complaintsearch[11]);
		$("#complaintcpType5").attr("value", complaintsearch[12]);
		$("#exportexcel").submit();

	}

	/**
	 导出调用方法EXCEL
	 */
	function ListcomplaintEXCEL2(complaintsearch) {
		$("#complaintmailNum6").attr("value", complaintsearch[7]);
		$("#exportexcel2").submit();
	}

	function checkMailNum2() {
		var complaintmailNum2 = document.getElementById("complaintmailNum2").value;
		if (complaintmailNum2 == 0) {
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

	<body class="easyui-layout" style="overflow-y: hidden" scroll="no">

		<div id="mainPanle" region="center" style="overflow: hidden"
			border="false">
			<div id="allreportsearch" style="height: 45%; display: block;">
				<table>
					<tr>
						<td>
							<form action="" method="post" id="form" name="">
								<table align="center" class="tableclass" width="600" border="0">
									<tr>
										<td colspan="2" align="left">
											<font color="red" style="font-size: 14">综合查询:</font>
										</td>
									</tr>
									<tr>
										<td width="75" align="right">
											投诉单号码:
										</td>
										<td>
											<input type="text" name="cpNum" id="complaintcpNum" value="" />
										</td>
										<td align="right">
											邮购公司:
										</td>
										<td>
											<select id="complaintmailCompany" name="mailCompany"
												style="width: 124px;">
												<option value="">
													请选择
												</option>
											</select>
										</td>
									</tr>
									<tr>
										<td align="right">
											投递局:
										</td>
										<td>
											<input type="text" name="deliveryBur"
												id="complaintdeliveryBur" value="" />
										</td>
										<td align="right">
											投诉时间:
										</td>
										<td>
											<input type="text" name="cpDate"
												onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
												readonly="readonly" id="cpDatestartmonth" value="" />
											-
											<input type="text" name="cpDateendmonth"
												onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
												readonly="readonly" id="pa95endmonth" value="" />
										</td>
									</tr>
									<tr>
										<td align="right">
											邮件号:
										</td>
										<td>
											<input type="text" name="mailNum" id="complaintmailNum"
												value="" />
										</td>
										<td align="right">
											回复时间:
										</td>
										<td>
											<input type="text" name="replyDate"
												onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
												readonly="readonly" id="replyDatestartmonth" value="" />
											-
											<input type="text" name="replyDateendmonth"
												onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
												readonly="readonly" id="replyDateendmonth" value="" />
										</td>
									</tr>
									<tr>
										<td align="right">
											寄出地:
										</td>
										<td>
											<input type="text" name="postFrom" id="complaintpostFrom"
												value="" />
										</td>
										<td align="right">
											收件人:
										</td>
										<td>
											<input type="text" name="recipts" id="complaintrecipts"
												value="" />
										</td>
									</tr>
									<tr>
										<td align="right">
											电话:
										</td>
										<td>
											<input type="text" name="reciptsTel" id="complaintreciptsTel"
												value="" />
										</td>
										<td align="right">
											投诉类别:
										</td>
										<td>
											<select id="complaintcpType" name="cpType"
												style="width: 124px;">
												<option value="">
													请选择
												</option>
												<option value="公司投诉邮局">
													公司投诉邮局
												</option>
												<option value="邮局投诉公司">
													邮局投诉公司
												</option>

											</select>
										</td>
									</tr>
									<tr>
										<td align="right">
											回复内容:
										</td>
										<td>
											<textarea rows="2" cols="21" name="replyComment"
												id="complaintreplyComment"></textarea>
										</td>
									</tr>
									<tr>
										<td align="right">
											&nbsp;
										</td>
										<td>
											<input id="pa95button" type="button" value="查询" />
										</td>
									</tr>
								</table>
							</form>
						</td>
						<td>
							<form action="" method="post" id="allreportsearch2form" name="">
								<table align="center" width="400" border="0">
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
											<textarea rows="5" cols="35" id="complaintmailNum2"
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
			<div style="height: 50%">
				<table id="tab" width="100%" height="100%" border="false"></table>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportComplaintList" method="post"
					id="export" name="export">
					<input type="text" name="complaintcpNum3" id="complaintcpNum3"
						value="" />
					<input type="text" name="complaintmailCompany3"
						id="complaintmailCompany3" value="" />
					<input type="text" name="complaintdeliveryBur3"
						id="complaintdeliveryBur3" value="" />
					<input type="text" name="cpDatestartmonth3" id="cpDatestartmonth3"
						value="" />
					<input type="text" name="cpDateendmonth3" id="cpDateendmonth3"
						value="" />
					<input type="text" name="replyDatestartmonth3"
						id="replyDatestartmonth3" value="" />
					<input type="text" name="replyDateendmonth3"
						id="replyDateendmonth3" value="" />
					<input type="text" name="complaintmailNum3" id="complaintmailNum3"
						value="" />
					<input type="text" name="complaintpostFrom3"
						id="complaintpostFrom3" value="" />
					<input type="text" name="complaintrecipts3" id="complaintrecipts3"
						value="" />
					<input type="text" name="complaintreciptsTel3"
						id="complaintreciptsTel3" value="" />
					<input type="text" name="complaintreplyComment3"
						id="complaintreplyComment3" value="" />
					<input type="text" name="complaintcpType3" id="complaintcpType3"
						value="" />
				</form>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportComplaintList" method="post"
					id="export2" name="export2">
					<textarea id="complaintmailNum4" name="complaintmailNum4" value=""></textarea>
				</form>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportComplaintEXCEL" method="post"
					id="exportexcel" name="exportexcel">
					<input type="text" name="complaintcpNum5" id="complaintcpNum5"
						value="" />
					<input type="text" name="complaintmailCompany5"
						id="complaintmailCompany5" value="" />
					<input type="text" name="complaintdeliveryBur5"
						id="complaintdeliveryBur5" value="" />
					<input type="text" name="cpDatestartmonth5" id="cpDatestartmonth5"
						value="" />
					<input type="text" name="cpDateendmonth5" id="cpDateendmonth5"
						value="" />
					<input type="text" name="replyDatestartmonth5"
						id="replyDatestartmonth5" value="" />
					<input type="text" name="replyDateendmonth5"
						id="replyDateendmonth5" value="" />
					<input type="text" name="complaintmailNum5" id="complaintmailNum5"
						value="" />
					<input type="text" name="complaintpostFrom5"
						id="complaintpostFrom5" value="" />
					<input type="text" name="complaintrecipts5" id="complaintrecipts5"
						value="" />
					<input type="text" name="complaintreciptsTel5"
						id="complaintreciptsTel5" value="" />
					<input type="text" name="complaintreplyComment5"
						id="complaintreplyComment5" value="" />
					<input type="text" name="complaintcpType5" id="complaintcpType5"
						value="" />
				</form>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportComplaintEXCEL" method="post"
					id="exportexcel2" name="exportexcel2">
					<textarea id="complaintmailNum6" name="complaintmailNum6" value=""></textarea>
				</form>
			</div>


		</div>
	</body>
</html>