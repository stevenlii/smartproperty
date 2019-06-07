<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>未结账汇总表</title>
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
		 var searchs = new Array();
		 searchs[0]=$("#starttime").val();
		 searchs[1]=$("#endtime").val();
		 searchs[2]=$("#entpsCode").val();
		 noFinanceList(searchs);
		});
	});
	
	/**
	 * 财务信息
	 */
	function noFinanceList(searchs) {
		$("#tab").datagrid({
			nowrap : false,
			showFooter:true,
			singleSelect : false,
			striped : true,
			fit : true,
			queryParams : {
				starttime : searchs[0],
				endtime : searchs[1],
				entpsCode : searchs[2]
			},
			pageNumber : 1,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "financeStatistics.do?method=getNoFinanceList",
			columns : [ [ {
				field : "mailNo",
				title : "邮件号",
				width : fillsize(0.12),
				formatter : function(value, rec) {
						return rec.tbmailPost.mailNum;
				}
			}, {
				field : "entpsCode",
				title : "入网企业",
				width : fillsize(0.08),
				formatter : function(value, rec) {
					return rec.tbmailPost.entpsCode;
			}
			}, {
				field : "postDate",
				title : "交寄日期",
				width : fillsize(0.08),
				formatter : function(value, rec) {
					return rec.tbmailPost.postDate;
			}
			},  {
				field : "inAmount",
				title : "应收货款",
				width : fillsize(0.1),
				formatter : function(value, rec) {
					return rec.tbmailPost.inAmount;
			}
			}, {
				field : "payment",
				title : "支付方式",
				width : fillsize(0.06),
				formatter : function(value, rec) {
					return rec.tbmailPost.payment;
			}
			}, {
				field : "insurAmount",
				title : "保险保价金额",
				width : fillsize(0.06),
				formatter : function(value, rec) {
					return rec.tbmailPost.insurAmount;
			}
			}, {
				field : "insurance",
				title : "保险保价",
				width : fillsize(0.06),
				formatter : function(value, rec) {
					return rec.tbmailPost.insurance;
			}
			}, {
				field : "recipts",
				title : "收件人",
				width : fillsize(0.06),
				formatter : function(value, rec) {
					return rec.tbmailPost.recipts;
			}
			}, {
				field : "reciptsAdr",
				title : "收件人地址",
				width : fillsize(0.06),
				formatter : function(value, rec) {
					return rec.tbmailPost.reciptsAdr;
			}
			}, {
				field : "tel",
				title : "电话号码",
				width : fillsize(0.06),
				formatter : function(value, rec) {
					return rec.tbmailPost.tel;
			}
			}, {
				field : "postCode",
				title : "邮编",
				width : fillsize(0.06),
				formatter : function(value, rec) {
					return rec.tbmailPost.postCode;
			}
			}, {
				field : "postFrom",
				title : "寄出地",
				width : fillsize(0.06),
				formatter : function(value, rec) {
					return rec.tbmailPost.postFrom;
			}
			}, {
				field : "postTo",
				title : "寄达地",
				width : fillsize(0.1),
				formatter : function(value, rec) {
					return rec.tbmailPost.postTo;
			}
			}, {
				field : "orderNum",
				title : "订单号",
				width : fillsize(0.1),
				formatter : function(value, rec) {
					return rec.tbmailPost.orderNum;
			}
			}, {
				field : "goods",
				title : "货物名称",
				width : fillsize(0.1),
				formatter : function(value, rec) {
					return rec.tbmailPost.goods;
			}
			}, {
				field : "remark",
				title : "备注",
				width : fillsize(0.1),
				formatter : function(value, rec) {
					return rec.tbmailPost.remark;
			}
			}, {
				field : "weight",
				title : "重量",
				width : fillsize(0.1),
				formatter : function(value, rec) {
					return rec.tbmailPost.weight;
			}
			}, {
				field : "fee",
				title : "资费",
				width : fillsize(0.1),
				formatter : function(value, rec) {
					return rec.tbmailPost.fee;
			}
			}] ],
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
					<td><input type="text" name="starttime"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" id="starttime" value="" />-<input
						type="text" name="endtime"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" id="endtime" value="" />
					</td>
				</tr>
				<tr>
					<td align="right">入网企业:</td>
					<td>
				<!-- 	<input type="text" name="entpsCode" id="entpsCode" value="" /> -->
					
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
		<div style="height: 70%">
			<table id="tab"></table>
		</div>
	</div>
</body>

</html>
