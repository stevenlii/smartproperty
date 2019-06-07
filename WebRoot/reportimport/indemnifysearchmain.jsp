<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>赔偿信息查询</title>
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
		compayCodeselect("1", "idmniidmniCompany");
		$("#pa95button").click(function() {

			var search = new Array();
			search[0] = $("#idmniidmniCompany").val();
			search[1] = $("#idmnimailNum").val();
			search[2] = $("#pa95startmonth").val();
			search[3] = $("#pa95endmonth").val();
			FinanceList(search, "search.do?method=getIndemnifySearchList");
			$("#allreportsearch").dialog("close");
		});
		$("#searchbutton").click(function() {
			importfinance("查询赔偿", "allreportsearch");
		});

		$("#pa95button2").click(function() {
			var search = new Array();
			search[1] = $("#idmnimailNum2").val();
			if (checkMailNum2())
				FinanceList(search, "search.do?method=getIndemnifySearchList");
		});
		$("#searchbutton2").click(function() {
			importfinance("查询赔偿", "allreportsearch2");
		});
		//多选查询 

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

	/**
	 * 赔偿信息
	 */
	function FinanceList(search, searchmethod) {
		$("#tab").datagrid({
			nowrap : false,
			singleSelect : false,
			striped : true,
			fit : true,
			queryParams : {
				idmniCompany : search[0],
				idmnimailNum : search[1],
				StartDate : search[2],
				EndDate : search[3]
			},
			pageNumber : 1,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : searchmethod,
			columns : [ [ {
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
			pagination : true,
			toolbar : [ {
				text : "按综合查询导出TXT",
				handler : function() {
					if (getRows("tab") != "") {
						FinanceListidmni(search);
					} else {
						showmsg("没有要导出的数据");
					}

				}
			}, "-", {
				text : "按批量查询导出TXT",
				handler : function() {
					if (getRows("tab") != "") {
						if($("#idmnimailNum2").val()!=""){
							FinanceListidmni3(search);
						}else{
						    showmsg("没有要导出的数据");
						}
						
					} else {
						showmsg("没有要导出的数据");
					}

				}

			},"-", {
				text : "按综合查询导出EXCEL",
				handler : function() {
					if (getRows("tab") != "") {
						ListidmniEXCEL(search);
					} else {
						showmsg("没有要导出的数据");
					}

				}

			},"-", {
				text : "按批量查询导出EXCEL",
				handler : function() {
					if (getRows("tab") != "") {
					if($("#idmnimailNum2").val()!=""){
							ListidmniEXCEL2(search);
						}else{
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
	function FinanceListidmni(search) {
		$("#idmniCompany3").attr("value", search[0]);
		$("#idmnimailNum3").attr("value", search[1]);
		$("#pa95startmonth3").attr("value", search[2]);
		$("#pa95endmonth3").attr("value", search[3]);
		$("#export").submit();

	}

	/**
	 导出调用方法TXT
	 */
	function FinanceListidmni3(search) {
		$("#idmnimailNum4").attr("value", search[1]);
		$("#export2").submit();
	}

/**
	导出调用方法EXCEL
	 */
	function ListidmniEXCEL(search) {
		$("#idmniCompany5").attr("value", search[0]);
		$("#idmnimailNum5").attr("value", search[1]);
		$("#pa95startmonth5").attr("value", search[2]);
		$("#pa95endmonth5").attr("value", search[3]);
		$("#exportexcel").submit();

	}

	/**
	 导出调用方法EXCEL
	 */
	function ListidmniEXCEL2(search) {
		$("#idmnimailNum6").attr("value", search[1]);
		$("#exportexcel2").submit();
	}


	function checkMailNum2() {
		var idmnimailNum2 = document.getElementById("idmnimailNum2").value;
		if (idmnimailNum2 == 0) {
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
			<table><tr><td>
				<form action="" method="post" id="form" name="">
					<table width="437" border="0" align="center">
						<tr>
							<td colspan="2" align="left">
								<font color="red" style="font-size: 14">综合查询:</font>
							</td>
						</tr>
						<tr>
							<td width="81" align="right">
								涉及赔偿公司:
							</td>
							<td width="340">
								<!-- 
						<input type="text" name="idmniCompany"
							id="idmniidmniCompany" value="" /> -->
								<select id="idmniidmniCompany" name="idmniCompany"
									style="width: 124px;">
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
								<input type="text" name="mailNum" id="idmnimailNum" value="" />
							</td>
						</tr>
						<tr>
							<td align="right">
								赔偿日期:
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
							<td></td>
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
								<textarea rows="5" cols="35" id="idmnimailNum2" name="mailNum"
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
			<div style="height: 65%;"><table id="tab" border="false"></table></div>
			<div style="display: none;">
				<form action="search.do?method=exportIndemnifyList" method="post"
					id="export" name="export">
					<input type="text" name="idmniCompany3" id="idmniCompany3" value="" />
					<input type="text" name="idmnimailNum3" id="idmnimailNum3" value="" />
					<input type="text" name="pa95startmonth3" id="pa95startmonth3"
						value="" />
					<input type="text" name="pa95endmonth3" id="pa95endmonth3" value="" />

				</form>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportIndemnifyList" method="post"
					id="export2" name="export2">
					<textarea id="idmnimailNum4" name="idmnimailNum4" value=""></textarea>
				</form>
			</div>

			<div style="display: none;">
				<form action="search.do?method=exportIndemnifyEXCEL" method="post"
					id="exportexcel" name="exportexcel">
					<input type="text" name="idmniCompany5" id="idmniCompany5" value="" />
					<input type="text" name="idmnimailNum5" id="idmnimailNum5" value="" />
					<input type="text" name="pa95startmonth5" id="pa95startmonth5"
						value="" />
					<input type="text" name="pa95endmonth5" id="pa95endmonth5" value="" />

				</form>
			</div>
			<div style="display: none;">
				<form action="search.do?method=exportIndemnifyEXCEL" method="post"
					id="exportexcel2" name="exportexcel2">
					<textarea id="idmnimailNum6" name="idmnimailNum6" value=""></textarea>
				</form>
			</div>
		</div>

	</body>

</html>
