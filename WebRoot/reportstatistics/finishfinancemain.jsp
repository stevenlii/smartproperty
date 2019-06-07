<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>已结账汇总表</title>
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
<script type="text/javascript" src="js/jquery.autocomplete.js"></script>
<script type="text/javascript">
	$(function() {
	 compayCodeselect("1","entpsCode");
		$("#pa95button").click(function() {
			 var searchmethod = new Array();
			 searchmethod[0]=$("#jjStartDate").val();
			 searchmethod[1]=$("#jjEndDate").val();
			 searchmethod[2]=$("#jsStartDate").val();
			 searchmethod[3]=$("#jsEndDate").val();
			 searchmethod[4]=$("#entpsCode").val();
			financeList(searchmethod);
		});
	});
	/**
	 * 财务信息
	 */
	function financeList(searchmethod) {
		$("#tab").datagrid({
			nowrap : false,
			singleSelect : false,
			showFooter:true,
			striped : true,
			fit : true,
			queryParams : {
				jjStartDate :searchmethod[0],
				jjEndDate : searchmethod[1],
				jsStartDate : searchmethod[2],
				jsEndDate : searchmethod[3],
				entpsCode : searchmethod[4]
			},
			pageNumber : 1,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "financeStatistics.do?method=getFinanceList",
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
			},  {
				field : "infetonetCode",
				title : "入网企业代码",
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
			} ] ],
			pagination : true
		});
	}
</script>
</head>
<body class="easyui-layout">
	<div id="mainPanle" region="center" style="overflow: auto;"
		border="false" >
		<form action="" method="post"
			id="form" name="form">
			<table align="center" width="459" border="0">
				<tr>
					<td align="right">交寄日期:</td>
					<td><input type="text" name="jjStartDate"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" id="jjStartDate" value="" />-<input
						type="text" name="jjEndDate"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" id="jjEndDate" value="" />
					</td>
				</tr>
					<tr>
					<td align="right">结算日期:</td>
					<td><input type="text" name="jsStartDate"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" id="jsStartDate" value="" />-<input
						type="text" name="jsEndDate"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" id="jsEndDate" value="" />
					</td>
				</tr>
				<tr>
					<td align="right">入网企业:</td>
					<td>
					<select id="entpsCode" name="entpsCode" style="width: 124px;">
							<option value="">请选择</option>
							</select>
					</td>
				</tr>
				<tr>
					<td></td>
					<td><input id="pa95button" type="button" value="提交" />
					</td>
				</tr>
			</table>
		</form>
		<div style="height: 75%">
			<table id="tab" ></table>
		</div>
	</div>
</body>

</html>
