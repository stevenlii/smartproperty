<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>交寄信息导入</title>
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
	  compayCodeselect("1","entpsCode2");
		FinanceList('');
       
		//录入
		$("#createmailpostbutton").click(function() {
			$("#inAmount").numberbox("clear");
			$("#insurance").numberbox("clear");
			$("#insurAmount").numberbox("clear");
			$("#weight").numberbox("clear");
			createmailpost();
		});
	

		

		//自定义验证
		$
				.extend(
						$.fn.validatebox.defaults.rules,
						{
							// 邮件号验证
							mailcheck : {
								validator : function(value) {
									return /(^EC\d{9}CS$)|(^EC\d{9}CN$)/.test(value);
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
		$("#" + addId).dialog({
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

  var m=0;
   function  checkentpsCode2(){
    var code = $("#entpsCode2").val();
    if(code=="请选择")
    {
    $.messager.alert("警告信息", "入网公司不能为空", "warning");
      m=1;
    }else{
      m=0;
    }
   }


	
	/**
	 * 交寄信息
	 */
	function FinanceList(mailpostsearch) {
		$("#tab").datagrid({
			nowrap : false,
			singleSelect : false,
			striped : true,
			fit : true,
			queryParams : {
				entpsCode : mailpostsearch[0],
				mailNum : mailpostsearch[1],
				StartDate : mailpostsearch[2],
				EndDate : mailpostsearch[3],
				orderNum : mailpostsearch[4]

			},
			pageNumber : 1,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "search.do?method=getMailPostList",
			columns : [ [{
				field : "clientCode",
				title : "客户代码",
				width : fillsize(0.1)
			}, {
				field : "deptName",
				title : "入网企业",
				width : fillsize(0.1)
			}, {
				field : "postDate",
				title : "交寄日期",
				width : fillsize(0.1)

			}, {
				field : "mailNum",
				title : "邮件号",
				width : fillsize(0.1)
			}, {
				field : "inAmount",
				title : "应收货款",
				width : fillsize(0.1)
			}, {
				field : "payment",
				title : "支付方式",
				width : fillsize(0.1)
			}, {
				field : "insurAmount",
				title : "保险保价金额",
				width : fillsize(0.1)
			}, {
				field : "insurance",
				title : "保险保价",
				width : fillsize(0.1)
			}, {
				field : "recipts",
				title : "收件人",
				width : fillsize(0.1)
			}, {
				field : "reciptsAdr",
				title : "收件人地址",
				width : fillsize(0.1)
			}, {
				field : "tel",
				title : "电话号码",
				width : fillsize(0.1)
			}, {
				field : "postCode",
				title : "邮编",
				width : fillsize(0.1)
			}, {
				field : "postFrom",
				title : "寄出地",
				width : fillsize(0.1)
			}, {
				field : "postTo",
				title : "寄达地",
				width : fillsize(0.1)
			}, {
				field : "orderNum",
				title : "订单号",
				width : fillsize(0.1)
			}, {
				field : "goods",
				title : "货物名称",
				width : fillsize(0.1)
			}, {
				field : "remark",
				title : "备注",
				width : fillsize(0.1)
			}, {
				field : "weight",
				title : "重量",
				width : fillsize(0.1)
			}, {
				field : "fee",
				title : "资费",
				width : fillsize(0.1)
			}, {
				field : "tbType",
				title : "表类型",
				width : fillsize(0.1)
			}, {
				field : "tbName",
				title : "表来源名",
				width : fillsize(0.1)
			} ] ],
			pagination : true
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
	
	function createmailpost() {
		resetContent("mailpostform");
		var dt = new Date().format("yyyy-MM-dd");
		$("#postDate").val(dt); //
		
		$("#addmailpost").show();
		$("#addmailpost").dialog({
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

					checkinput();
                checkentpsCode2();
					if (n == 0  && m==0) {
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

	
	
</script>
</head>
<body class="easyui-layout" scroll="no">
	<div region="north" split="true" border="false"
		style="height: 25px;padding: 2px 0 0 2px;">
		
		<c:if test="${sessionScope.mailpostcreate eq 'create'}">
			<button id='createmailpostbutton'>录入</button>
		</c:if>
		
	</div>
	<div id="mainPanle" region="center" style="overflow: hidden"
		border="false">
		<table id="tab" border="false">
		</table>

		<div id="allreportimport" style="height: 20%;display:none;">
			<!-- 交寄信息导入页面开始 -->
			<div id="1" style="display: none; overflow: hidden;">

				交寄信息( <a href="reportimport/templates/交寄信息装载表模板.xls" target="_blank"
					style="color: green">模板下载</a>) <input type="file" name="uploadify1"
					id="uploadify1" /> <a
					href="javascript:$('#uploadify1').uploadifyUpload();">上传</a>|
				<a href="javascript:$('#uploadify1').uploadifyClearQueue();">
					取消上传</a>
				<div id="fileQueue1"></div>
			</div>
		</div>
		<div id="allreportsearch" style="height: 20%;display:none;">
			<form action="" method="post" id="form" name="">

				<table align="center" width="459" border="0">
					<tr>
						<td width="101" align="right">入网企业代码:</td>
						<td width="342"><input type="text" name="entpsCode"
							id="entpsCode" value="" /></td>
					</tr>
					<tr>
						<td align="right">邮件号:</td>
						<td><input type="text" name="mailNum" id="mailpostmailNum"
							value="" /></td>
					</tr>
					<tr>
						<td align="right">交寄日期:</td>
						<td><input type="text" name="pa95startmonth"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
							readonly="readonly" id="pa95startmonth" value="" />-<input
							type="text" name="pa95endmonth"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
							readonly="readonly" id="pa95endmonth" value="" />
						</td>
					</tr>
					<tr>
						<td align="right">订单号:</td>
						<td><input type="text" name="orderNum" id="orderNum" value="" />
						</td>
					</tr>
					<tr>
						<td></td>
						<td><input id="pa95button" type="button" value="查询" />
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
	<!--速递局人员单个邮件录入页面-->
	<div id="addmailpost" style="display: none; text-align: center;">
		<form action="" method="post" id="mailpostform" name="mailpostform">
			<input type="hidden" name="id" id="mailpostid"> <input
				type="hidden" name="tbType" id="tbType" value="">
			<table style="text-align: center;">
				<tr>
					<td align="right">客户代码:</td>
					<td><input type="text" name="clientCode" id="clientCode"
						style="width: 150px;" class="easyui-validatebox"></td>
					<td align="right"><font color="red">*</font>入网企业代码:</td>
					<td>
				<!-- 	<input type="text" name="entpsCode" id="entpsCode2"
						style="width: 150px;" class="easyui-validatebox"> -->
						
						<select id="entpsCode2" name="entpsCode" style="width: 150px;"class="easyui-validatebox">
							<option value="请选择">请选择</option>
							</select>
				</td>			
				</tr>
				<tr>
					<td align="right">交寄日期:</td>
					<td><input type="text" name="postDate" id="postDate"
						style="width: 150px;"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" value=""></td>
					<td align="right"><font color="red">*</font>邮件号:</td>
					<td><input type="text" name="mailNum" id="mailNum"
						style="width: 150px;" class="easyui-validatebox" required="true"
						validType="mailcheck" missingMessage="必填"  invalidMessage="邮件号不能为空"></td>
				</tr>
				<tr>
					<td align="right"><font color="red">*</font>应收货款:</td>
					<td><input type="text" name="inAmount" id="inAmount"
						style="width: 150px;" class="easyui-numberbox" required="true"
						min="0" precision="2" validtype="length[1,99999]"
						missingMessage="必填"></td>
					<td align="right">支付方式:</td>
					<td><select name="payment" id="payment" style="width: 150px;"
						class="easyui-validatebox">
							<option value="">请选择</option>
							<option value="1">现金/支票</option>
							<option value="2">记欠</option>
							<option value="3">托收</option>
							<option value="4">转帐</option>
							<option value="9">其他</option>
					</select></td>
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
					<td align="right"><font color="red">*</font>收件人:</td>
					<td><input type="text" name="recipts" id="recipts"
						style="width: 150px;" class="easyui-validatebox" required="true"
						validtype="length[0,40]" missingMessage="必填"
						invalidMessage="不能超过40个字符！"></td>
					<td align="right"><font color="red">*</font>收件人地址:</td>
					<td><input type="text" name="reciptsAdr" id="reciptsAdr"
						style="width: 150px;" class="easyui-validatebox" required="true"
						validtype="length[0,200]" missingMessage="必填"
						invalidMessage="不能超过200个字符！"></td>
				</tr>
				<tr>
					<td align="right"><font color="red">*</font>电话号码:</td>
					<td><input type="text" name="tel" id="tel"
						style="width: 150px;" class="easyui-validatebox" required="true"
						validtype="telcheck" missingMessage="必填"></td>
					<td align="right">邮编:</td>
					<td><input type="text" name="postCode" id="postCode"
						style="width: 150px;" class="easyui-validatebox"
						invalidMessage="邮编应为6位邮政编码" validtype="postCodecheck"></td>
				</tr>
				<tr>
					<td align="right"><font color="red">*</font>寄出地:</td>
					<td><input type="text" name="postFrom" id="postFrom"
						style="width: 150px;" class="easyui-validatebox"
						validtype="length[0,40]" missingMessage="必填" required="true"
						invalidMessage="不能超过40个字符！"></td>
					<td align="right"><font color="red">*</font>寄达地:</td>
					<td><input type="text" name="postTo" id="postTo"
						style="width: 150px;" class="easyui-validatebox"
						validtype="length[0,40]" missingMessage="必填" required="true"
						invalidMessage="不能超过40个字符！"></td>
				</tr>
				<tr>
					<td align="right"><font color="red">*</font>订单号:</td>
					<td><input type="text" name="orderNum" id="orderNum2"
						style="width: 150px;" class="easyui-validatebox" required="true"
						validtype="length[0,30]" missingMessage="必填"
						invalidMessage="不能超过30个字符！"></td>
					<td align="right"><font color="red">*</font>货物名称:</td>
					<td><input type="text" name="goods" id="goods"
						style="width: 150px;" class="easyui-validatebox" required="true"
						validtype="length[0,60]" missingMessage="必填"
						invalidMessage="不能超过60个字符！"></td>
				</tr>
				<tr>
					<td align="right">备注:</td>
					<td><textarea rows="2" cols="22" name="remark" id="remark"
							style="width: 150px;" class="easyui-validatebox"
							validtype="length[0,200]" invalidMessage="不能超过200个字符！"></textarea>
					</td>
					<td align="right">重量:</td>
					<td><input type="text" name="weight" id="weight"
						style="width: 150px;" class="easyui-numberbox"></td>
				</tr>
				<tr>
					<td align="right">资费:</td>
					<td><input type="text" name="fee" id="fee"
						style="width: 150px;" class="easyui-numberbox" min="0"
						precision="2"></td>
				</tr>
			</table>
		</form>
	</div>
	<!--速递局人员单个邮件录入页面结束-->
</body>

</html>
