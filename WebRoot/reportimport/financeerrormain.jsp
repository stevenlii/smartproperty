
<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>测试</title>
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
				showimportreport(1);
				financelist();
				//选择要修改的财务信息id，单条则进进入修改页面，否则给予提醒信息
				$("#updatefinancebutton")
						.click(
								function() {
									var row = $("#tab").datagrid("getSelections");
									if (row.length < 1) {
										$.messager.alert("警告信息", "选择一条记录", "warning");
									}
									if (row.length == 1) {
										
										row = $("#tab").datagrid("getSelected");
										updatereturn("财务", "financeform", row,
												"addfinance",
												"input.do?method=updatefinanceerror");
									}
									if (row.length > 1) {
										$.messager.alert("警告信息", "选择一条记录", "warning");
									}
									if (row.consDate == null) {
										document.getElementById("jiaoji").style.display = "block";
										$("#consDate").attr("value", row.consDate);
									}
									if (row.consDate != null) {
										document.getElementById("jiaoji").style.display = "none";
									}
		
								});
				//将财务信息动态的显示在表格中
				$("#clearfinancebutton").click(function() {
					clearSelect("tab");
				});
			});
		
			//传入的id为动态显示页面上的form表单id：显示财务的信息
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
		
			//财务信息显示
			function financelist(mailNum, consDate, payFee, realFee) {
				$("#tab").datagrid( {
					singleSelect : false,
					fit : true,
					queryParams : {
						mailNum : mailNum,
						consDate : consDate,
						payFee : payFee,
						realFee : realFee
					},
					pageSize : 20,
					pageList : [ 20, 30, 50 ],
					url : "search.do?method=getFinanceErrorList",
					columns : [ [ {
						field : "ck",
						checkbox : true
					}, {
						field : "mailNum",
						title : "邮件号",
						width : fillsize(0.1)
					}, {
						field : "consDate",
						title : "交寄日期",
						width : fillsize(0.1),
						formatter : formatterdate
					}, {
						field : "payFee",
						title : "应收货款",
						width : fillsize(0.1)
					}, {
						field : "realFee",
						title : "实收货款",
						width : fillsize(0.1)
					} ] ],
					pagination : true
				});
			}
		
			/**
			 *修改财务信息
			 */
			function updatereturn(updattitle, updatform, row, updatId, updatMethod) {
				resetContent(updatform);
				$("#id").attr("value", row.id);
				$("#mailNum").attr("value", row.mailNum);
				$("#payFee").attr("value", row.payFee);
				$("#realFee").attr("value", row.realFee);
				updat(updattitle, updatform, updatId, updatMethod);
			}
			
		</script>
	</head>
	<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
		<div region="north" split="true" border="false"
			style="height: 25px; padding: 2px 0 0 2px;">
			<c:if test="${sessionScope.returnupdate eq 'update'}">
				<button id='updatefinancebutton'>
					修 改
				</button>
			</c:if>
		</div>
		<div id="mainPanle" region="center" style="overflow: hidden"
			border="false">
			<table id="tab" border="false"></table>
		</div>


		<!--财务信息修改页面-->
		<div id="addfinance"  style="display: none; text-align: center;">

			<form action="" method="post" id="financeform" name="financeform">


				<input type="hidden" name="id" id="id">
				<input type="hidden" name="tbType" id="tbType" value="return">
				<table style="text-align: center;">
					<tr>
						<td align="right">
							<font color="red"></font>邮件号:
						</td>
						<td>
							<input type="text" id="mailNum" name="mailNum">
						</td>
					</tr>
					<tr id="jiaoji" style="display: none;">
						<td align="right">
							交寄日期
						</td>
						<td>
							<input type="text" name="consDate"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
								readonly="readonly" id="consDate" value="" />
						</td>
					</tr>
					<tr>
						<td align="right">
							应收货款:
						</td>
						<td>
							<input type="text" id="payFee" name="payFee">
						</td>
					</tr>
					<tr>
						<td align="right">
							实收货款:
						</td>
						<td>
							<input type="text" id="realFee" name="realFee">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>