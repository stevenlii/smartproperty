<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>投诉录入</title>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/vtip-min.js"></script>
<script type="text/javascript" src="jeasyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
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
		TdghList();
		$("#pa95button").click(function() {
			var collect = $("#collectmailNum").val();
			collecthper(collect, "import.do?method=tdghImport");
			$("#tdghcollect").dialog("close");
		});
		$("#tdghcollectbutton").click(function() {
			importfinance("网络采集", "tdghcollect");
		});
		//自定义验证
		//$.extend($.fn.validatebox.defaults.rules, {
			//邮件号验证
			//mailcheck : {
				//validator : function(value) {
					//return /^EC\d{9}CS$/.test(value);
				//},
				//message : "邮件号不正确"

			//}

		//});
	});
	function importfinance(addTitle, addId) {

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
	
	function formatDate(date) {  
	    if (!date) return;  
	    var format = "yyyy-MM-dd HH:mm:ss";  
	    switch(typeof date) {  
	        case "string":  
	            date = new Date(date.replace(/-/, "/"));  
	            break;  
	        case "number":  
	            date = new Date(date);  
	            break;  
	    }   
	    if (!date instanceof Date) return;  
	    var dict = {  
	        "yyyy": date.getFullYear(),  
	        "M": date.getMonth() + 1,  
	        "d": date.getDate(),  
	        "H": date.getHours(),  
	        "m": date.getMinutes(),  
	        "s": date.getSeconds(),  
	        "MM": ("" + (date.getMonth() + 101)).substr(1),  
	        "dd": ("" + (date.getDate() + 100)).substr(1),  
	        "HH": ("" + (date.getHours() + 100)).substr(1),  
	        "mm": ("" + (date.getMinutes() + 100)).substr(1),  
	        "ss": ("" + (date.getSeconds() + 100)).substr(1)  
	    };      
	    return format.replace(/(yyyy|MM?|dd?|HH?|ss?|mm?)/g, function() {  
	        return dict[arguments[0]];  
	    });                  
	}
	/**
	 * 投递信息*/

	function TdghList() {
		$("#tab").datagrid({
			nowrap : false,
			striped : true,
			fit : true,
			pageNumber : 1,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "search.do?method=getTdghList",
			columns : [ [{
				field : "mailNum",
				title : "邮件号码",
				width : fillsize(0.1)
			},  {
				field : "billDate",
				title : "处理日期",
				width : fillsize(0.12),
				formatter : formatDate
			}, {
				field : "deptName",
				title : "入网企业",
				width : fillsize(0.1)
			},{
				field : "mailAddress",
				title : "邮件到达地点",
				width : fillsize(0.2)
			}, {
				field : "mailState",
				title : "邮件状态",
				width : fillsize(0.2)
			} ,
			{
				field : "mailDesc",
				title : "邮件描述",
				width : fillsize(0.3)
			} ] ],
			pagination : true
		});

	}

</script>

</head>

<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
	<div region="north" split="true" border="false"
		style="height: 25px;padding: 2px 0 0 2px;">
		<c:if test="${sessionScope.tdghcollect eq 'collect'}">
			<button id='tdghcollectbutton'>网络采集</button>
		</c:if>


	</div>
	<div id="mainPanle" region="center" style="overflow: hidden"
		border="false">
		<table id="tab" width="100%" height="100%" border="false"></table>
	</div>
	<!--网络采集页面-->
	<div id="tdghcollect" style="display: none; text-align: center;">
		<form action="" method="post" id="tdghform" name="tdghform">
		<div align="center">每行一个邮件号码</div>
			<table style="text-align: center;">
				<tr>
					<td align="right">邮件号:</td>
					<td><textarea rows="2" cols="220" id="collectmailNum"
							name="mailNum" class="easyui-validatebox" required="true"
							style="width: 200px;height: 260px"></textarea>
					</td>
				<tr>
					<td></td>
					<td><input id="pa95button" type="button" value="开始采集" />
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!--投递添加页面结束-->
</body>
</html>