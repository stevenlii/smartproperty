<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>账务汇总出错表结果显示</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
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
		compayCodeselect("1", "entpsCode2");
		FinanceList('');
		$("#updatefinancebutton").click(function() {
			var row = $("#tab").datagrid("getSelections");
			//			alert(row.length);
				if (row.length < 1) {
					$.messager.alert("警告信息", "选择一条记录", "warning");
				}
				if (row.length == 1) {
					row = $("#tab").datagrid("getSelected");
					updatefinance("财务", "financeform", row, "addfinance",
							"input.do?method=updateFinance");

					createmailpost();
				}
				if (row.length > 1) {
					//				alert("请选择要一条修改的数据");
					$.messager.alert("警告信息", "选择一条记录", "warning");
				}
			});

		//自定义验证
		$
				.extend(
						$.fn.validatebox.defaults.rules,
						{
							// 邮件号验证
							mailcheck : {
								validator : function(value) {
									return /(^EC\d{9}CS$)|(^EC\d{9}CN$)/
											.test(value);
								},
								message : "邮件号不正确"
							},
							//邮政编码验证
							postCodecheck : {
								validator : function(value) {
									return /^[1-9]\d{5}$/.test(value);
								},
								message : "邮编应为6位邮政编码"
							},
							//长度验证
							length : {
								validator : function(value, param) {
									return value.length >= param[0];
								},
								message : "长度不能超过(40)个字符"
							},
							//电话验证
							telcheck : {
								validator : function(value) {
									return /(^(13[0-9]|15[012356789]|18[0236789]|14[57])[0-9]{8}$)|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$/
											.test(value);
								},
								message : "电话号码不正确"
							}

						});
	});

	var isimport = true;
	function importfinance(addTitle, addId) {
		if (isimport) {
			importreport('uploadify1', 'import', 'mailPostImport',
					'fileQueue1', 'allreportimport');//交寄信息
			isimport = false;
		}
		$("#" + addId).show();
		$("#" + addId).dialog( {
			title : addTitle + "信息",
			modal : true,
			width : 500,
			height : 300,
			minimizable : false,
			maximizable : false
		});
	}

	/***/
	//判断非1（基本）状态时，保险保价金额不能为空，应为1-99999元
	var n = 0;
	function checkinput() {
		var sta = $("#insurance").val();
		if (sta != 1 && sta != "") {
			var s = $("#insurAmount").val();
			//判断s是1-99999的整数
			if (isNaN(s) || s<1 || s>99999) {
				$.messager.alert("警告信息", "保险保价金额不能为空", "warning");
				n = 1;
			} else {
				n = 0;
			}

		}

	}

	/**
	 * 财务信息
	 */
	function FinanceList(finance) {
		$("#tab").datagrid( {
			singleSelect : false,
			fit : true,
			queryParams : {
				mailNum : finance[0],
				consDate : finance[1],
				payFee : finance[2],
				realFee : finance[3],
				billDate : finance[4],
				aceptDate : finance[5],
				mailingDate : finance[6],
				recipienName : finance[7],
				recipienAddr : finance[8],
				orderNum : finance[9],
				aceptSetupe : finance[10],
				mailingSetupe : finance[11],
				tonetCode : finance[12],
				customerCode : finance[13],
				infetonetCode : finance[14],
				inferiorCode : finance[15],
				sviceFee : finance[16],
				setFee : finance[17],
				returnFee : finance[18],
				whyReturn : finance[19],
				total : finance[20],
				billFee : finance[21],
				billBlace : finance[22],
				billMailTypes : finance[23],
				rate : finance[24],
				tbType : finance[25],
				tbName : finance[26],
				deptName : finance[27]
			},
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "search.do?method=getFinanceList&radiotype=radiotype.value",
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
				width : fillsize(0.1)
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

	

	function updatefinance(updattitle, updatform, row, updatId, updatMethod) {
		resetContent(updatform);
		$("#id").attr("value", row.id);
		$("#mailNum").attr("value", row.mailNum);
		$("#billDate").attr("value", row.billDate);
		$("#consDate").attr("value", row.consDate);
		$("#payFee").attr("value", row.payFee);
		$("#realFee").attr("value", row.realFee);
		$("#aceptDate").attr("value", row.aceptDate);
		$("#mailingDate").attr("value", row.mailingDate);
		$("#recipienName").attr("value", row.recipienName);
		$("#recipienAddr").attr("value", row.recipienAddr);
		$("#orderNum").attr("value", row.orderNum);
		$("#aceptSetupe").attr("value", row.aceptSetupe);
		$("#mailingSetupe").attr("value", row.mailingSetupe);
		$("#tonetCode").attr("value", row.tonetCode);
		$("#customerCode").attr("value", row.customerCode);
		$("#infetonetCode").attr("value", row.infetonetCode);
		$("#inferiorCode").attr("value", row.inferiorCode);
		$("#sviceFee").attr("value", row.sviceFee);
		$("#setFee").attr("value", row.setFee);
		$("#returnFee").attr("value", row.returnFee);
		$("#whyReturn").attr("value", row.whyReturn);
		$("#total").attr("value", row.total);
		$("#billFee").attr("value", row.billFee);
		$("#billBlace").attr("value", row.billBlace);
		$("#billMailTypes").attr("value", row.billMailTypes);
		$("#rate").attr("value", row.rate);
		$("#tbType").attr("value", row.tbType);
		$("#tbName").attr("value", row.tbName);
		$("#deptName").attr("value", row.deptName);

		updat(updattitle, updatform, updatId, updatMethod);
	}

	function createmailpost() {
		resetContent("mailpostform");
		var date=new Date().format("yyyy-MM-dd");
		$("#postDate").val(date);
		$("#addmailpost").show();
		$("#addmailpost").dialog( {
			title : "修改财务相关信息",
			modal : true,
			width : 620,
			height : 540,

			minimizable : false,
			maximizable : false,
			buttons : [ {
				text : "添加",
				iconCls : "icon-ok",
				handler : function() {

					checkinput();
					entpsCode2Notnull();
					if (n == 0&&e==0) {
						entpsCode2Notnull();
						$("#mailpostform").form("submit", {
							url : "input.do?method=addMailPost",
							onSubmit : function() {
								return $(this).form("validate");
							},
							success : function(data) {
								$("#addmailpost").dialog("close");
								flashTable("tab");
								showmsg(data);
							}
						});
					}
				}
			}, {
				text : "取消",
				iconCls : "icon-undo",
				handler : function() {
					$("#addmailpost").dialog("close");
				}
			} ]
		});
	}
	//*********自定义format方法		  
	Date.prototype.format = function(format) {
		var o = {
			"M+" : this.getMonth() + 1, //month        
			"d+" : this.getDate(), //day        
			"h+" : this.getHours(), //hour        
			"m+" : this.getMinutes(), //minute        
			"s+" : this.getSeconds(), //second        
			"q+" : Math.floor((this.getMonth() + 3) / 3), //quarter        
			"S" : this.getMilliseconds()
		//millisecond        
		};
		if (/(y+)/.test(format))
			format = format.replace(RegExp.$1, (this.getFullYear() + "")
					.substr(4 - RegExp.$1.length));
		for ( var k in o)
			if (new RegExp("(" + k + ")").test(format))
				format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
						: ("00" + o[k]).substr(("" + o[k]).length));
		return format;
	};

	
		var e=0;
	function entpsCode2Notnull(){
		var ent=$("#entpsCode2").val();
		if(ent=="请选择"){
			$.messager.alert("警告信息","请选择入网企业代码","warning");
				e = 1;
			}else{
				e = 0;
			}
		}

</script>
	</head>
	<body class="easyui-layout" scroll="no">
		<div region="north" split="true" border="false"
			style="height: 25px; padding: 2px 0 0 2px;">

			<button id='updatefinancebutton'>
				修改
			</button>
		</div>
		<div id="mainPanle" region="center" style="overflow: hidden"
			border="false">
			<table id="tab" border="false">
			</table>

			<!--交寄信息添加页面-->
			<div id="addmailpost" style="display: none; text-align: center;">
				<form action="input.do?method=updateFinance" method="post"
					id="financeform" name="financeform">
					<input type="hidden" name="id" id="id">
					<input type="hidden" name="tbType" id="tbType" value="return">
					<table style="text-align: center; width: 450">
						<tr>
							<td colspan="4" align="left">
								<font color="red" style="font-size: 14">财务信息的添加</font>
							</td>
						</tr>
						<tr>
							<td align="right" >
								<font color="red">*</font>邮件号:
							</td>
							<td >
								<input type="text" id="mailNum" name="mailNum" class="easyui-validatebox" required="true" 
									validType="mailcheck" missingMessage="必填">
							</td>
							<td align="right">
								交寄日期:
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
							<td align="right">
								实收货款:
							</td>
							<td>
								<input type="text" id="realFee" name="realFee">
							</td>
						</tr>
						<tr>
							<td align="center" colspan="2">
								<input id='updatebutton'  type="submit" value="修 改">
							</td>
							<td align="center" colspan="2">
								<input id='updatereset' type="reset" value="清 空">
							</td>
						</tr>

						<tr style="display: none;">
							<td>
								<input id="billDate" name="billDate"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
									readonly="readonly" type="text">
								<input id="aceptDate" name="aceptDate"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
									readonly="readonly" type="text">
								<input id="mailingDate" name="mailingDate"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
									readonly="readonly" type="text">
								<input id="recipienName" name="recipienName" type="text">
								<input id="recipienAddr" name="recipienAddr" type="text">
								<input id="orderNum" name="orderNum" type="text">
								<input id="aceptSetupe" name="aceptSetupe" type="text">
								<input id="mailingSetupe" name="mailingSetupe" type="text">
								<input id="tonetCode" name="tonetCode" type="text">
								<input id="customerCode" name="customerCode" type="text">
								<input id="infetonetCode" name="infetonetCode" type="text">
								<input id="inferiorCode" name="inferiorCode" type="text">
								<input id="sviceFee" name="sviceFee" type="text">
								<input id="setFee" name="setFee" type="text">
								<input id="returnFee" name="returnFee" type="text">
								<input id="whyReturn" name="whyReturn" type="text">
								<input id="total" name="total" type="text">
								<input id="billFee" name="billFee" type="text">
								<input id="billBlace" name="billBlace" type="text">
								<input id="billMailTypes" name="billMailTypes" type="text">
								<input id="rate" name="rate" type="text">
								<input id="tbType" name="tbType" type="text">
								<input id="tbName" name="tbName" type="text">
								<input id="deptName" name="deptName" type="text">

							</td>
						</tr>
					</table>
				</form>
				<hr style="height: 1px;" />
				<form action="" method="post" id="mailpostform" name="mailpostform">
					<input type="hidden" name="id" id="mailpostid">
					<input type="hidden" name="tbType" id="tbType" value="">
					<table style="text-align: center;">
						<tr>
							<td colspan="4" align="left">
								<font color="red" style="font-size: 14"> 交寄信息的添加 </font>
							</td>
						</tr>
						<tr>
							<td align="right">
								客户代码:
							</td>
							<td>
								<input type="text" name="clientCode" id="clientCode"
									style="width: 150px;" class="easyui-validatebox">
							</td>
							<td align="right">
								入网企业代码:
							</td>
							<td>
								<select id="entpsCode2" name="entpsCode" style="width: 150px;" >
									<option value="请选择">
										请选择
									</option>
								</select>
							</td>
						</tr>
						<tr>
							<td align="right">
								交寄日期:
							</td>
							<td>
								<input type="text" name="postDate" id="postDate"
									style="width: 150px;"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
									readonly="readonly" value="">
							</td>
							<td align="right">
								邮件号:
							</td>
							<td>
								<input type="text" name="mailpostmailNum" id="mailpostmailNum"
									style="width: 150px;" class="easyui-validatebox" required="true" 
									validType="mailcheck" missingMessage="必填">
							</td>
						</tr>
						<tr>
							<td align="right">
								<font color="red">*</font>应收货款:
							</td>
							<td>
								<input type="text" name="inAmount" id="inAmount"
									style="width: 150px;" class="easyui-numberbox" required="true"
									min="0" precision="2" validtype="length[1,99999]"
									missingMessage="必填">
							</td>
							<td align="right">
								支付方式:
							</td>
							<td>
								<select name="payment" id="payment" style="width: 150px;"
									class="easyui-validatebox">
									<option value="">
										请选择
									</option>
									<option value="1">
										现金/支票
									</option>
									<option value="2">
										记欠
									</option>
									<option value="3">
										托收
									</option>
									<option value="4">
										转帐
									</option>
									<option value="9">
										其他
									</option>
								</select>
							</td>
						</tr>
						<tr>
					<td align="right">保险保价:</td>

					<td><select name="insurance" id="insurance"
						style="width: 150px;" class="easyui-numberbox">
							<option value="">请选择</option>
							<option value="1">基本</option>
							<option value="2">保价</option>
							<option value="3">保险</option>
					</select></td>
					<td align="right">保险保价金额:</td>
					<td><input type="text" name="insurAmount" id="insurAmount"
						style="width: 150px;" onblur="checkinput()"
						class="easyui-numberbox" validtype="length[1,99999]" min="0"
						precision="2" invalidMessage="保险保价金额不能为空">
					</td>

				</tr>
						<tr>
							<td align="right">
								<font color="red">*</font>收件人:
							</td>
							<td>
								<input type="text" name="recipts" id="recipts"
									style="width: 150px;" class="easyui-validatebox"
									required="true" validtype="length[0,40]" missingMessage="必填"
									invalidMessage="不能超过40个字符！">
							</td>
							<td align="right">
								<font color="red">*</font>收件人地址:
							</td>
							<td>
								<input type="text" name="reciptsAdr" id="reciptsAdr"
									style="width: 150px;" class="easyui-validatebox"
									required="true" validtype="length[0,200]" missingMessage="必填"
									invalidMessage="不能超过200个字符！">
							</td>
						</tr>
						<tr>
							<td align="right">
								<font color="red">*</font>电话号码:
							</td>
							<td>
								<input type="text" name="tel" id="tel" style="width: 150px;"
									class="easyui-validatebox" required="true" validtype="telcheck"
									missingMessage="必填">
							</td>
							<td align="right">
								邮编:
							</td>
							<td>
								<input type="text" name="postCode" id="postCode"
									style="width: 150px;" class="easyui-validatebox"
									invalidMessage="邮编应为6位邮政编码" validtype="postCodecheck">
							</td>
						</tr>
						<tr>
							<td align="right">
								<font color="red">*</font>寄出地:
							</td>
							<td>
								<input type="text" name="postFrom" id="postFrom"
									style="width: 150px;" class="easyui-validatebox"
									validtype="length[0,40]" missingMessage="必填" required="true"
									invalidMessage="不能超过40个字符！">
							</td>
							<td align="right">
								<font color="red">*</font>寄达地:
							</td>
							<td>
								<input type="text" name="postTo" id="postTo"
									style="width: 150px;" class="easyui-validatebox"
									validtype="length[0,40]" missingMessage="必填" required="true"
									invalidMessage="不能超过40个字符！">
							</td>
						</tr>
						<tr>
							<td align="right">
								<font color="red">*</font>订单号:
							</td>
							<td>
								<input type="text" name="orderNum" id="orderNum2"
									style="width: 150px;" class="easyui-validatebox"
									required="true" validtype="length[0,30]" missingMessage="必填"
									invalidMessage="不能超过30个字符！">
							</td>
							<td align="right">
								<font color="red">*</font>货物名称:
							</td>
							<td>
								<input type="text" name="goods" id="goods" style="width: 150px;"
									class="easyui-validatebox" required="true"
									validtype="length[0,60]" missingMessage="必填"
									invalidMessage="不能超过60个字符！">
							</td>
						</tr>
						<tr>
							<td align="right">
								备注:
							</td>
							<td>
								<textarea rows="2" cols="22" name="remark" id="remark"
									style="width: 150px;" class="easyui-validatebox"
									validtype="length[0,200]" invalidMessage="不能超过200个字符！"></textarea>
							</td>
							<td align="right">
								重量:
							</td>
							<td>
								<input type="text" name="weight" id="weight"
									style="width: 150px;" class="easyui-numberbox">
							</td>
						</tr>
						<tr>
							<td align="right">
								资费:
							</td>
							<td>
								<input type="text" name="fee" id="fee" style="width: 150px;"
									class="easyui-numberbox" min="0" precision="2">
							</td>
						</tr>
					</table>
				</form>
			</div>
			<!--速递局人员单个邮件录入页面结束-->
		</div>
	</body>
</html>
