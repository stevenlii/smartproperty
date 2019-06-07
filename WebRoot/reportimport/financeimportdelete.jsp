<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>财务信息导入</title>
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
<script type="text/javascript">
	$(function() {
		showimportreport(1);
		FinanceList('');
		//财务信息
		$("#importbutton").click(function() {
			importfinance("装载财务", "allreportimport")
		});
		$("#pa95button").click(function() {
			var mycars = new Array();
			mycars[0] = $("#financemailNum").val();
			mycars[1] = $("#pa95startmonth").val();
			mycars[2] = $("#pa95endmonth").val();
			mycars[3] = $("#aceptDatestartmonth").val();
			mycars[4] = $("#aceptDateendmonth").val();
			mycars[5] = $("#recipienName").val();
			mycars[6] = $("#aceptSetupe").val();
			mycars[7] = $("#mailingSetupe").val();
			mycars[8] = $("#tonetCode").val();
			mycars[9] = $("#customerCode").val();
			mycars[10] = $("#payFee").val();
			mycars[11] = $("#billMailTypes").val();
			FinanceList(mycars);
			$("#allreportsearch").dialog("close");
		});
		$("#searchbutton").click(function() {
			importfinance("查询财务", "allreportsearch")
		});
		$("#deletebutton").click(function() {
			importfinance("删除财务", "allreportdel")
		});
		$("#pa95delbutton").click(function() {
			var tbName = $("#pa95tbName").val();
			deleTbName("import.do?method=financeDelete", tbName, '');
			$("#allreportdel").dialog("close");
		});
		  
         $("#financedeletebutton").click(function() {
			importfinance("删除财务", "allreportdelete");
		});
		 
         $("#pa95buttondelete").click(function() {
			var  pa95startmonth=$("#pa95startmonth").val();
			var pa95endmonth=$("#pa95endmonth").val();
			delfinance("input.do?method=deleteFinance",pa95startmonth,pa95endmonth);
		$("#allreportdelete").dialog("close");
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
			width : 500,
			height : 300,
			collapsible : true,
			minimizable : false,
			maximizable : false
		});
	}

	//传入div的id,动态显示隐藏不同的上传按钮
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
				financemailNum : mycars[0],
				pa95startmonth : mycars[1],
				pa95endmonth : mycars[2],
				aceptDatestartmonth : mycars[3],
				aceptDateendmonth : mycars[4],
				recipienName : mycars[5],
				aceptSetupe : mycars[6],
				mailingSetupe : mycars[7],
				tonetCode : mycars[8],
				customerCode : mycars[9],
				payFee : mycars[10],
				billMailTypes : mycars[11]
			},
			pageNumber : 1,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "search.do?method=getFinanceList",
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
			pagination : true
		});
	}
	//for check null file
	function hasfile(uploaId) {
		if (!$("#" + uploaId).children().size() == 1) {
			showmsg("请选择上传文件");
			return false;
		}
	}
	function hascanclefile(uploaId) {
		if (!$("#" + uploaId).children().size() == 1) {
			showmsg("没有需要上传的文件");
			return false;
		}
	}
	
	function delfinance(delmethod,pa95startmonth,pa95endmonth)
	{
	  resetContent("form2");
	     $.ajax({
			type : "POST",
			dataType : "text",
			url : delmethod+"&nowdate=" + new Date(),
			data : {
			    "pa95startmonth" : pa95startmonth,
			    "pa95endmonth":pa95endmonth
			},
			success : function(data) {
				flashTable("tab");
				showmsg(data);
			}
		});
	
	}
</script>
</head>
<body class="easyui-layout" scroll="no">
	<div region="north" split="true" border="false"
		style="height: 25px;padding: 2px 0 0 2px;">
		<!-- 
		<c:if test="${sessionScope.financeadd eq 'add'}">
			<button id='importbutton'>装载</button>
		</c:if>
		<c:if test="${sessionScope.financesearch eq 'search'}">
			<button id='searchbutton'>查询</button>
		</c:if>
		 -->
		<c:if test="${sessionScope.financedel eq 'del'}">
			<button id='deletebutton'>删除</button>
		</c:if>
		<c:if test="${sessionScope.financedelete eq 'delete'}">
			<button id='financedeletebutton'>按条件删除</button>
		</c:if>
		
	</div>
	<div id="mainPanle" region="center" style="overflow: hidden"
		border="false">
		<table id="tab" border="false">
		</table>

		<div id="allreportimport" style="height: 20%;display:none;">
			<!-- 财务信息导入页面开始 -->
			<div id="1" style="display: none; overflow: hidden;">

				财务信息( <a href="reportimport/templates/财务信息装载模版.xls" target="_blank"
					style="color: green">模板下载</a>) <input type="file" name="uploadify1"
					id="uploadify1" /> <a
					href="javascript:$('#uploadify1').uploadifyUpload();">上传</a>|
				<a href="javascript:$('#uploadify1').uploadifyClearQueue()">
					取消上传</a>
				<div id="fileQueue1"></div>
			</div>
		</div>
		<div id="allreportdelete" style="height: 20%;display:none;">
			<form action="" method="post" id="form2" name="">
				<table width="473" border="0" align="center">
				<!-- 
					<tr>
						<td width="131" height="23"><span style="float:right ">邮件号:</span>
						</td>
						<td width="366"><input type="text" name="mailNum"
							id="financemailNum" style="width: 150px;"
							class="easyui-validatebox" />
						</td>
					</tr>
					 -->
					<tr>
						<td><span style="float:right ">结算日期:</span>
						</td>
						<td><input type="text" name="pa95startmonth"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
							readonly="readonly" id="pa95startmonth" value="" /> - <input
							type="text" name="pa95endmonth"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
							readonly="readonly" id="pa95endmonth" value="" />
						</td>
					</tr>
					<!-- 
					<tr>
						<td><span style="float:right ">交寄日期:</span>
						</td>
						<td><input type="text" name="aceptDatestartmonth"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
							readonly="readonly" id="aceptDatestartmonth" value="" /> - <input
							type="text" name="aceptDateendmonth"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
							readonly="readonly" id="aceptDateendmonth" value="" />
						</td>
					</tr>
					<tr>
						<td><span style="float:right ">入网企业:</span>
						</td>
						<td><input type="text" name="tonetCode" id="tonetCode"
							style="width: 150px;" /></td>
					</tr>
					  -->
					<tr>
						<td></td>
						<td><input id="pa95buttondelete" type="button" value="删除" />
						</td>
					</tr>
				</table>
			</form>

		</div>
		<div id="allreportdel" style="height: 20%;display:none;">
			<form action="" method="post" id="form" name="">
				根据 <font color="red">表来源名</font>删除: <input type="text" name="tbName"
					id="pa95tbName" value="" /> <input id="pa95delbutton"
					type="button" value="删除" />
			</form>

		</div>

	</div>

</body>

</html>
