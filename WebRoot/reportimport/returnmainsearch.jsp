<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>退回查询</title>
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
		$("#pa95button")
				.click(
						function() {
							var returnmailNum = $("#returnmailNum").val();
							var pa95startmonth = $("#pa95startmonth").val();
							var pa95endmonth = $("#pa95endmonth").val();
							var entpsCode = $("#entpsCode").val();
							returnlist(returnmailNum, pa95startmonth,
									pa95endmonth, entpsCode,
									"search.do?method=getReturnmultipleList");
							$("#allreportsearch").dialog("close");
						});
		$("#searchbutton").click(function() {
			importfinance("查询退回", "allreportsearch");
		});
		$("#pa95button2")
				.click(
						function() {
							var returnmailNum = $("#returnmailNum2").val();
							if (checkMailNum2())
								returnlist(returnmailNum, '', '', '',
										"search.do?method=getReturnmultipleList");
							if (checkMailNum2())
								$
										.ajax({
											type : "POST",
											dataType : "text",
											url : "search.do?method=getReturnmultipleListLength&nowdate="
													+ new Date(),
											data : {
												"page" : $(".pagination-num")
														.val(),
												"rows" : $(
														".pagination-page-list")
														.attr("select",
																"selected")
														.val(),
												"returnmailNum2" : $(
														"#returnmailNum2")
														.val()
											},
											success : function(data) {
												showmessager(data);
											}
										});

						});
		$("#searchbutton2").click(function() {
			importfinance("查询退回", "allreportsearch2");
		});
		//多选查询 

	});
	var isimport = true;
	function importfinance(addTitle, addId) {
		if (isimport) {
			importreport('uploadify1', 'import', 'returnImport', 'fileQueue1',
					'allreportimport');//退回信息
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

	//退回信息
	function returnlist(returnmailNum, pa95startmonth, pa95endmonth, entpsCode,
			searchmethod) {
		$("#tab").datagrid(
				{
					singleSelect : false,
					fit : true,
					queryParams : {
						returnmailNum : returnmailNum,
						StartDate : pa95startmonth,
						EndDate : pa95endmonth,
						entpsCode : entpsCode
					},
					pageSize : 20,
					pageList : [ 20, 30, 50 ],
					url : searchmethod,
					columns : [ [ {
						field : "mailNum",
						title : "邮件号",
						width : fillsize(0.1)
					}, {
						field : "deptName",
						title : "入网企业",
						width : fillsize(0.1)
					}, {
						field : "returnDate",
						title : "退回日期",
						width : fillsize(0.1)

					} ] ],
					pagination : true,
					toolbar : [
							{
								text : "按综合查询导出TXT",
								handler : function() {
									if (getRows("tab") != "") {
										FinanceListreturn(returnmailNum,
												pa95startmonth, pa95endmonth,
												entpsCode);
									} else {
										showmsg("没有要导出的数据");
									}

								}
							},
							"-",
							{
								text : "按批量查询导出TXT",
								handler : function() {
									if (getRows("tab") != "") {
										if ($("#returnmailNum2").val() != "") {
											ReturnList3(returnmailNum);
										} else {
											showmsg("没有要导出的数据");
										}

									} else {
										showmsg("没有要导出的数据");
									}

								}

							},
							"-",
							{
								text : "按综合查询导出EXCEL",
								handler : function() {
									if (getRows("tab") != "") {
										ListreturnEXCEL(returnmailNum,
												pa95startmonth, pa95endmonth,
												entpsCode);
									} else {
										showmsg("没有要导出的数据");
									}

								}

							}, "-", {
								text : "按批量查询导出EXCEL",
								handler : function() {
									if (getRows("tab") != "") {
										if ($("#returnmailNum2").val() != "") {
											ListreturnEXCEL2(returnmailNum);
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
	function FinanceListreturn(returnmailNum, pa95startmonth, pa95endmonth,
			entpsCode) {
		$("#returnmailNum3").attr("value", returnmailNum);
		$("#pa95startmonth3").attr("value", pa95startmonth);
		$("#pa95endmonth3").attr("value", pa95endmonth);
		$("#entpsCode3").attr("value", entpsCode);
		$("#export1").submit();
	}

	/**
	 导出调用方法TXT
	 */
	function ReturnList3(returnmailNum) {
		$("#returnmailNum4").attr("value", returnmailNum);
		$("#exportreturn").submit();
	}

	/**
	 导出调用方法EXCWL
	 */
	function ListreturnEXCEL(returnmailNum, pa95startmonth, pa95endmonth,
			entpsCode) {
		$("#returnmailNum5").attr("value", returnmailNum);
		$("#pa95startmonth5").attr("value", pa95startmonth);
		$("#pa95endmonth5").attr("value", pa95endmonth);
		$("#entpsCode5").attr("value", entpsCode);
		$("#exportreturn3").submit();
	}

	/**
	 导出调用方法
	 */
	function ListreturnEXCEL2(returnmailNum) {
		$("#returnmailNum6").attr("value", returnmailNum);
		$("#exportreturn4").submit();
	}

	function checkMailNum2() {
		var returnmailNum2 = document.getElementById("returnmailNum2").value;
		if (returnmailNum2 == 0) {
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
	<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
		<div id="mainPanle" region="center" style="overflow: hidden"
			border="false">
			<div id="allreportsearch" style="height: 30%; display: block;">
			<table><tr><td>
					<form action="" method="post" id="form" name="">
						<table align="center" width="437" border="0">
							<tr>
								<td colspan="2" align="left">
									<font color="red" style="font-size: 14">综合查询:</font>
								</td>
							</tr>
							<tr>
								<td width="75" align="right">
									邮件号:
								</td>
								<td width="346">
									<input type="text" name="mailNum" id="returnmailNum" value="" />

								</td>
							</tr>
							<tr>
								<td align="right">
									入网公司:
								</td>
								<td>
									<select id="entpsCode" name="entpsCode" style="width: 124px;">
										<option value="">
											请选择
										</option>
									</select>

								</td>
							</tr>
							<tr>
								<td align="right">
									退回日期:
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
									&nbsp;
								</td>
								<td>
									<input id="pa95button" type="button" value="查询" />
								</td>
							</tr>
						</table>
					</form>
				</td><td>
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
									<textarea rows="5" cols="35" id="returnmailNum2" name="mailNum"
										value=""></textarea>
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
				</td></tr></table>
			</div>
			<hr />
			<div style="height: 65%;">
				<table id="tab" width="100%" height="100%" border="false"></table>
			</div>

			<div style="display: none;">
				<form action="search.do?method=exportReturnList" method="post"
					id="export1" name="export1">
					<input type="text" name="returnmailNum3" id="returnmailNum3"
						value="" />
					<input type="text" name="entpsCode3" id="entpsCode3" value="">
					<input type="text" name="pa95startmonth3" id="pa95startmonth3"
						value="" />
					<input type="text" name="pa95endmonth3" id="pa95endmonth3" value="" />
				</form>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportReturnList" method="post"
					id="exportreturn" name="exportreturn">
					<textarea name="returnmailNum4" id="returnmailNum4" value=""></textarea>
				</form>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportReturnEXCEL" method="post"
					id="exportreturn3" name="exportreturn3">
					<input type="text" name="returnmailNum5" id="returnmailNum5"
						value="" />
					<input type="text" name="entpsCode5" id="entpsCode5" value="">
					<input type="text" name="pa95startmonth5" id="pa95startmonth5"
						value="" />
					<input type="text" name="pa95endmonth5" id="pa95endmonth5" value="" />
				</form>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportReturnEXCEL" method="post"
					id="exportreturn4" name="exportreturn4">
					<textarea name="returnmailNum6" id="returnmailNum6" value=""></textarea>
				</form>
			</div>
		</div>
	</body>
</html>