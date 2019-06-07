<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>投递查询</title>
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
		$("#pa95button")
				.click(
						function() {
							var tdghmailNum = $("#tdghmailNum").val();
							var pa95startmonth = $("#pa95startmonth").val();
							var pa95endmonth = $("#pa95endmonth").val();
							var tdfinished = $("#tdfinished").val();
							TdghList(tdghmailNum, pa95startmonth, pa95endmonth,
									tdfinished,
									"search.do?method=getTdghmultipleList");
							$("#allreportsearch").dialog("close");
						});
		$("#searchbutton").click(function() {
			importfinance("查询退回", "allreportsearch");
		});
		$("#pa95button2").click(
				function() {
					var tdghmailNum = $("#tdghmailNum2").val();
					var tdfinished = $("#tdfinished2").val();
					if (checkMailNum2())
						TdghList(tdghmailNum, '', '', tdfinished,
								"search.do?method=getTdghmultipleList");
				});
		$("#searchbutton2").click(function() {
			importfinance("查询退回", "allreportsearch2");
		});
		//多选查询 

	});

	function searchmultiple2(tdghmailNum2) {
		$.ajax({
			type : "POST",
			dataType : "text",
			url : "search.do?method=getTdghmultipleList&nowdate=" + new Date(),
			data : {
				"tdghmailNum2" : tdghmailNum2
			},
			success : function(data) {
				flashTable("tab");
				showmsg(data);
			}
		});
	}
	function searchmultiple() {
		$("#allreportsearch2").dialog({
			title : "录入交寄信息",
			modal : true,
			width : 600,
			height : 400,

			minimizable : false,
			maximizable : false,
			buttons : [ {
				text : "添加",
				iconCls : "icon-ok",
				handler : function() {
					$("#allreportsearch2form").form("submit", {
						url : "search.do?method=getTdghmultipleList",
						onSubmit : function() {
							return $(this).form("validate");
						},
						success : function(data) {
							$("#allreportsearch2").dialog("close");
							flashTable("tab");
							showmsg(data);
						}
					});

				}
			}, {
				text : "取消",
				iconCls : "icon-undo",
				handler : function() {
					$("#allreportsearch2").dialog("close");
				}
			} ]
		});
	}
	/**
	 * 投递信息*/

	function TdghList(tdghmailNum, pa95startmonth, pa95endmonth, tdfinished,
			searchmethod) {
		$("#tab").datagrid(
				{
					nowrap : false,
					singleSelect : true,
					striped : true,
					fit : true,
					pageNumber : 1,
					pageSize : 20,
					pageList : [ 20, 30, 50 ],
					url : searchmethod,
					queryParams : {
						tdghmailNum : tdghmailNum,
						StartDate : pa95startmonth,
						EndDate : pa95endmonth,
						tdfinished : tdfinished
					},
					columns : [ [ {
						field : "mailnum",
						title : "业主名",
						width : fillsize(0.1)
					}, {
						field : "tdfinishedtime",
						title : "业主电话",
						width : fillsize(0.16)

					}, {
						field : "entpscode",
						title : "房产号",
						width : fillsize(0.1)
					}, {
						field : "tdfinished",
						title : "房产面积",
						width : fillsize(0.1)
					}, {
						field : "portrayal",
						title : "其它补充",
						width : fillsize(0.3)
					} ] ],
					pagination : true,
					toolbar : [
							{
								text : "按综合查询导出TXT",
								handler : function() {
									if (getRows("tab") != "") {
										FinanceList2(tdghmailNum,
												pa95startmonth, pa95endmonth);
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
										if ($("#tdghmailNum2").val() != "") {
											FinanceList3(tdghmailNum);
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
										ListTdghEXCEL(tdghmailNum,
												pa95startmonth, pa95endmonth);
									} else {
										showmsg("没有要导出的数据");
									}

								}

							}, "-", {
								text : "按批量查询导出EXCEL",
								handler : function() {
									if (getRows("tab") != "") {
										if ($("#tdghmailNum2").val() != "") {
											ListTdghEXCEL2(tdghmailNum);
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
	function FinanceList2(tdghmailNum, pa95startmonth, pa95endmonth) {
		$("#tdghmailNum3").attr("value", tdghmailNum);
		$("#pa95startmonth3").attr("value", pa95startmonth);
		$("#pa95endmonth3").attr("value", pa95endmonth);
		$("#export").submit();
	}
	/**
	 导出调用方法TXT
	 */
	function FinanceList3(tdghmailNum) {
		$("#tdghmailNum4").attr("value", tdghmailNum);
		$("#export2").submit();
	}

	/**
	 导出调用方法EXCEL
	 */
	function ListTdghEXCEL(tdghmailNum, pa95startmonth, pa95endmonth) {
		$("#tdghmailNum5").attr("value", tdghmailNum);
		$("#pa95startmonth5").attr("value", pa95startmonth);
		$("#pa95endmonth5").attr("value", pa95endmonth);
		$("#exportexcel").submit();
	}
	/**
	 导出调用方法EXCEL
	 */
	function ListTdghEXCEL2(tdghmailNum) {
		$("#tdghmailNum6").attr("value", tdghmailNum);
		$("#exportexcel2").submit();
	}
	var isimport = true;
	function importfinance(addTitle, addId) {
		if (isimport) {
			importreport('uploadify1', 'import', 'tdghImport', 'fileQueue1',
					'bodymask');//退回信息
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

	function checkMailNum2() {
		var tdghmailNum2 = document.getElementById("tdghmailNum2").value;
		if (tdghmailNum2 == 0) {
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
			<div id="allreportsearch" style="height: 23%; display: block;">
			<table><tr><td>
					<form action="" method="post" id="form" name="form">
						<input type="hidden" name="tdfinished" id="tdfinished" value="妥投">
						<table align="center" width="400" border="0">
							<tr>
								<td colspan="2" align="left">
									<font color="red" style="font-size: 14"> 综合查询:</font>
								</td>
							</tr>
							<tr>
								<td width="75" align="right">
									房产号:
								</td>
								<td width="346">
									<input type="text" name="houseNo" id="houseNo" value="" />
									<span id="houseNo" style="color: #FF0000"></span>
								</td>
							</tr>
							<tr>
								<td width="75" align="right">
									业主名:
								</td>
								<td width="346">
									<input type="text" name="ownerName" id="ownerName" value="" />
									<span id="ownerName" style="color: #FF0000"></span>
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
				</td></tr></table>
			</div>
			<hr style="margin-top: 5px;" />
			<div style="margin-bottom: 0px; height: 420px;">
				<table id="tab" width="100%" height="100%" border="false"></table>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportTdghList" method="post"
					id="export" name="export">
					<input type="hidden" name="tdfinished3" id="tdfinished3" value="妥投">
					<input type="text" name="tdghmailNum3" id="tdghmailNum3" value="" />
					<input type="text" name="pa95startmonth3" id="pa95startmonth3"
						value="" />
					<input type="text" name="pa95endmonth3" id="pa95endmonth3" value="" />
				</form>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportTdghList" method="post"
					id="export2" name="export2">
					<input type="hidden" name="tdfinished3" id="tdfinished3" value="妥投">
					<textarea rows="5" cols="35" id="tdghmailNum4" name="tdghmailNum4"
						value=""></textarea>
				</form>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportTdghEXCEL" method="post"
					id="exportexcel" name="exportexcel">
					<input type="hidden" name="tdfinished5" id="tdfinished5" value="妥投">
					<input type="text" name="tdghmailNum5" id="tdghmailNum5" value="" />
					<input type="text" name="pa95startmonth5" id="pa95startmonth5"
						value="" />
					<input type="text" name="pa95endmonth5" id="pa95endmonth5" value="" />
				</form>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportTdghEXCEL" method="post"
					id="exportexcel2" name="exportexcel2">
					<input type="hidden" name="tdfinished5" id="tdfinished5" value="妥投">
					<textarea rows="5" cols="35" id="tdghmailNum6" name="tdghmailNum6"
						value=""></textarea>
				</form>
			</div>

		</div>
	</body>
</html>