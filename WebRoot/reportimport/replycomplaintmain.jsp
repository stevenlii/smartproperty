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
		complaintselect("complaint", "0", "cpSpecie");//typeCode为0时，公司投诉邮局，为1时，相反，selectID为标签<select>里面的id
		complaintselect("complaint", "1", "cpSpecie2");//typeCode为0时，公司投诉邮局，为1时，相反，selectID为标签<select>里面的id
		var replySuccess = "${param.replySuccess}";
		if (replySuccess != null || replySuccess != "") {
			var complaintsearch = new Array();
			complaintsearch[13] = replySuccess;
			FinanceList(complaintsearch);
		} else {
			FinanceList('');
		}
		showimportreport(1);
		//投诉信息
		$("#importbutton").click(function() {
			importfinance("装载投诉", "allreportimport");
		});
		//投诉查询 
		$("#pa95button").click(function() {
			var complaintsearch = new Array();
			complaintsearch[0] = $("#complaintcpNum").val();
			complaintsearch[1] = $("#complaintmailCompany").val();
			complaintsearch[2] = $("#complaintdeliveryBur").val();
			complaintsearch[3] = $("#cpDatestartmonth").val();
			complaintsearch[4] = $("#pa95endmonth").val();
			complaintsearch[5] = $("#replyDatestartmonth").val();
			complaintsearch[6] = $("#replyDateendmonth").val();
			complaintsearch[7] = $("#complaintmailNum").val();
			complaintsearch[8] = $("#complaintpostFrom").val();
			complaintsearch[9] = $("#complaintrecipts").val();
			complaintsearch[10] = $("#complaintreciptsTel").val();
			complaintsearch[11] = $("#complaintreplyComment").val();
			complaintsearch[12] = $("#complaintcpType").val();
			FinanceList(complaintsearch);
			$("#allreportsearch").dialog("close");
		});
		$("#searchbutton").click(function() {
			importfinance("查询投诉", "allreportsearch");
		});
		$("#deletebutton").click(function() {
			importfinance("删除投诉", "allreportdel");
		});
		$("#pa95delbutton").click(function() {
			var tbName = $("#pa95tbName").val();
			deleTbName("import.do?method=financeDelete", tbName, '');
			$("#allreportdel").dialog("close");
		});

		$("#createcomplaintbutton").click(function() {
			createcomplaint();
		});
		$("#replycomplaintbutton").click(function() {
			var row = $("#tab").datagrid("getSelected");
			if (row == null) {
				$.messager.alert("警告信息", "选择一条回复记录", "warning");
			} else {
				replycomplaint(row);
			}
		});
		$("#updatecomplaintbutton").click(function() {
			var row = $("#tab").datagrid("getSelected");
			if (row == null) {
				$.messager.alert("警告信息", "选择一条记录", "warning");
			} else {
				updatecomplaint(row);
			}
		});
		$("#clearcomplaintbutton").click(function() {
			clearSelect("tab");
		});

		//自定义验证，验证合法性
		// 邮件号验证
		$
				.extend(
						$.fn.validatebox.defaults.rules,
						{

							mailcheck : {
								validator : function(value) {
									return /^EC\d{9}CS$/.test(value);
								},
								message : "邮件号不正确"

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
			importreport('uploadify1', 'import', 'complaintImport',
					'fileQueue1', 'allreportimport');//投诉信息
			isimport = false;
		}
		$("#" + addId).show();
		$("#" + addId).dialog({
			title : addTitle + "信息",
			modal : true,
			width : 500,
			height : 380,
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
	 * 投诉信息*/

	function FinanceList(complaintsearch) {
		$("#tab").datagrid({
			nowrap : false,
			singleSelect : true,
			striped : true,
			fit : true,
			queryParams : {
				cpNum : complaintsearch[0],
				mailCompany : complaintsearch[1],
				deliveryBur : complaintsearch[2],
				StartDate : complaintsearch[3],
				EndDate : complaintsearch[4],
				replyDatestartmonth : complaintsearch[5],
				replyDateendmonth : complaintsearch[6],
				mailNum : complaintsearch[7],
				postFrom : complaintsearch[8],
				recipts : complaintsearch[9],
				reciptsTel : complaintsearch[10],
				replyComment : complaintsearch[11],
				cpType : complaintsearch[12],
				replySuccess : complaintsearch[13]
			},
			pageNumber : 1,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "search.do?method=getComplaintList",
			columns : [ [ {
				field : "ck",
				checkbox : true
			}, {
				field : "cpNum",
				title : "投诉单号码",
				width : fillsize(0.1)
			}, {
				field : "cpDate",
				title : "投诉日期",
				width : fillsize(0.06)

			}, {
				field : "deptName",
				title : "邮购公司",
				width : fillsize(0.06)
			}, {
				field : "mailNum",
				title : "邮件号码",
				width : fillsize(0.06)
			}, {
				field : "postDate",
				title : "交寄日期",
				width : fillsize(0.06)

			}, {
				field : "postFrom",
				title : "寄出地",
				width : fillsize(0.08)
			}, {
				field : "recipts",
				title : "收件人",
				width : fillsize(0.08)
			}, {
				field : "reciptsAdr",
				title : "收件人地址",
				width : fillsize(0.06)
			}, {
				field : "reciptsTel",
				title : "收件人电话",
				width : fillsize(0.06)
			}, {
				field : "receiAmount",
				title : "应收货款",
				width : fillsize(0.06)
			}, {
				field : "deliveryBur",
				title : "投递局",
				width : fillsize(0.08)
			}, {
				field : "cpType",
				title : "投诉类别",
				width : fillsize(0.08)
			}, {
				field : "cpComment",
				title : "投诉内容",
				width : fillsize(0.3)
			}, {
				field : "faxDate",
				title : "传真日期",
				width : fillsize(0.1)

			}, {
				field : "cpSpecie",
				title : "投诉种类",
				width : fillsize(0.08)
			}, {
				field : "replyDate",
				title : "回复日期",
				width : fillsize(0.06)

			}, {
				field : "replyComment",
				title : "回复内容",
				width : fillsize(0.2)
			}, {
				field : "contact",
				title : "联系人",
				width : fillsize(0.06)
			}, {
				field : "contactTel",
				title : "联系电话",
				width : fillsize(0.06)
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

	//录入邮件号码后，邮购公司、寄出地、交寄日期、收件人、地址、电话、应收等信息都自动调出
	function mailShow() {
		var num = $("#mailNum").val();//得到邮件号码
		if (num != "" && num != null) {
			$.post("input.do?method=getComplainByMailNum&num=" + num, function(
					a) {
				var st = a.split(",");
				$("#mailCompany").val(st[0]);
				$("#postFrom").val(st[1]);
				$("#postDate").val(st[2]);
				$("#recipts").val(st[3]);
				$("#reciptsAdr").val(st[4]);
				$("#reciptsTel").val(st[5]);
				$("#receiAmount").val(st[6]);
				$("#cpNum").val(st[7]);
			});
		}
	}
	//录入邮件号码后，投递局、寄出地、交寄日期、收件人、地址、电话、应收等信息都自动调出
	function mailShow2() {
		var num2 = $("#mailNum2").val();//得到邮件号码
		if (num2 != "" && num2 != null) {
			$.post("input.do?method=getComplainByMailNum&num=" + num2,
					function(a) {
						var st = a.split(",");
						$("#mailCompany2").val(st[0]);
						$("#postFrom2").val(st[1]);
						$("#postDate2").val(st[2]);
						$("#recipts2").val(st[3]);
						$("#reciptsAdr2").val(st[4]);
						$("#reciptsTel2").val(st[5]);
						$("#receiAmount2").val(st[6]);
						$("#cpNum2").val(st[7]);
					});
		}
	}

	//显示隐藏
	function radioShow(id) {//显示公司投递邮局，隐藏邮局投递公司信息
		if (id == 'rad1') {
			document.getElementById("c1").style.display = "block";
			document.getElementById("c2").style.display = "none";

		} else {
			document.getElementById("c2").style.display = "block";
			document.getElementById("c1").style.display = "none";
		}
	}

	//添加
	function createcomplaint() {
		resetContent("complaintfrom");
		resetContent("fromcomplaint");
		var dt = new Date().format("yyyy-MM-dd");
		$("#cpDate").val(dt); //投诉日期
		$("#faxDate").val(dt); //发传单日期
		$("#cpDate2").val(dt); //投诉日期
		$("#faxDate2").val(dt); //发传单日期
		
		$("#complaintadd").show();
		$("#complaintadd").dialog({
			title : "录入投诉信息",
			modal : true,
			width : 600,
			height : 400,
			minimizable : false,
			maximizable : false,
			buttons : [ {
				text : "添加",
				iconCls : "icon-ok",
				handler : function() {

					if ($("input[name='myradio']:checked").val() == 0) {
						$("#complaintfrom").form("submit", {
							url : "input.do?method=addComplaint",
							onSubmit : function() {
								return $(this).form("validate");
							},
							success : function(data) {
								$("#complaintadd").dialog("close");
								flashTable("tab");
								showmsg(data);
							}
						});
					} else if ($("input[name='myradio']:checked").val() == 1) {
						$("#fromcomplaint").form("submit", {
							url : "input.do?method=addComplaint",
							onSubmit : function() {
								return $(this).form("validate");
							},
							success : function(data) {
								$("#complaintadd").dialog("close");
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
					$("#complaintadd").dialog("close");
				}
			} ]
		});

	}

	//回复
	function replycomplaint(row) {
		resetContent("formcom");
			var dt = new Date().format("yyyy-MM-dd");
		$("#replyDate3").val(dt); //投诉日期
		
	   $("#complaintid3").attr("value", row.complaintid);
		$("#mailNum3").attr("value", row.mailNum);
		$("#cpNum3").attr("value", row.cpNum);
		$("#mailCompany3").attr("value", row.mailCompany);
		$("#postFrom3").attr("value", row.postFrom);
		$("#postDate3").attr("value", row.postDate);
		$("#recipts3").attr("value", row.recipts);
		$("#reciptsAdr3").attr("value", row.reciptsAdr);
		$("#reciptsTel3").attr("value", row.reciptsTel);
		$("#postFrom3").attr("value", row.postFrom);
		$("#receiAmount3").attr("value", row.receiAmount);
		$("#cpDate3").attr("value", row.cpDate);
		$("#faxDate3").attr("value", row.faxDate);
		$("#cpSpecie3").attr("value", row.cpSpecie);
		$("#deliveryBur3").attr("value", row.deliveryBur);
		$("#cpType3").attr("value", row.cpType);
		$("#cpComment3").attr("value", row.cpComment);
	    $("#replyComment3").attr("value", row.replyComment);
		$("#contact3").attr("value", row.contact);
		$("#contactTel3").attr("value", row.contactTel);
		$("#addcomplaint").show();
		$("#addcomplaint")
				.dialog(
						{
							title : "录入回复信息",
							modal : true,
							width : 600,
							height : 450,

							minimizable : false,
							maximizable : false,
							buttons : [
									{
										text : "回复",
										iconCls : "icon-ok",
										handler : function() {
											if ($("#replyDate3").val() != null
													&& $("#replyDate3").val() != "") {
												$("#formcom")
														.form(
																"submit",
																{
																	url : "input.do?method=updateComplaint",
																	onSubmit : function() {
																		return $(
																				this)
																				.form(
																						"validate");
																	},
																	success : function(
																			data) {
																		$(
																				"#addcomplaint")
																				.dialog(
																						"close");
																		flashTable("tab");
																		showmsg("回复成功");
																	}
																});

											} else {

												$.messager.alert("警告信息",
														"回复日期不为空", "warning");

											}
										}
									}, {
										text : "取消",
										iconCls : "icon-undo",
										handler : function() {
											$("#addcomplaint").dialog("close");
										}
									} ]
						});
	}

	function updatecomplaint(row) {
		resetContent("complaintfrom");
		$("#complaintid").attr("value", row.complaintid);
		$("#mailNum").attr("value", row.mailNum);
		$("#cpNum").attr("value", row.cpNum);
		$("#mailCompany").attr("value", row.mailCompany);
		$("#postFrom").attr("value", row.postFrom);
		$("#postDate").attr("value", row.postDate);
		$("#recipts").attr("value", row.recipts);
		$("#reciptsAdr").attr("value", row.reciptsAdr);
		$("#reciptsTel").attr("value", row.reciptsTel);
		$("#postFrom").attr("value", row.postFrom);
		$("#receiAmount").attr("value", row.receiAmount);
		$("#cpDate").attr("value", row.cpDate);
		$("#faxDate").attr("value", row.faxDate);
		$("#cpSpecie").attr("value", row.cpSpecie);
		$("#deliveryBur").attr("value", row.deliveryBur);
		$("#cpType").attr("value", row.cpType);
		$("#cpComment").attr("value", row.cpComment);

		$("#mailNum2").attr("value", row.mailNum);
		$("#cpNum2").attr("value", row.cpNum);
		$("#postFrom2").attr("value", row.postFrom);
		$("#mailCompany2").attr("value", row.mailCompany);
		$("#postDate2").attr("value", row.postDate);
		$("#recipts2").attr("value", row.recipts);
		$("#reciptsAdr2").attr("value", row.reciptsAdr);
		$("#reciptsTel2").attr("value", row.reciptsTel);
		$("#postFrom2").attr("value", row.postFrom);
		$("#receiAmount2").attr("value", row.receiAmount);
		$("#cpDate2").attr("value", row.cpDate);
		$("#faxDate2").attr("value", row.faxDate);
		$("#cpSpecie2").attr("value", row.cpSpecie);
		$("#deliveryBur2").attr("value", row.deliveryBur);
		$("#cpType2").attr("value", row.cpType);
		$("#cpComment2").attr("value", row.cpComment);

		$("#complaintadd").show();
		$("#complaintadd").dialog({
			title : "投诉信息",
			modal : true,
			width : 700,
			height : 450,

			minimizable : false,
			maximizable : false,
			buttons : [ {
				text : "修改",
				iconCls : "icon-ok",
				handler : function() {
					$("#complaintfrom").form("submit", {
						url : "input.do?method=updateComplaint",
						onSubmit : function() {
							return $(this).form("validate");
						},
						success : function(data) {
							$("#complaintadd").dialog("close");
							flashTable("tab");
							showmsg(data);
						}
					});
				}
			}, {
				text : "取消",
				iconCls : "icon-undo",
				handler : function() {
					$("#complaintadd").dialog("close");
				}
			} ]
		});
	}
</script>

</head>

<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
	<div region="north" split="true" border="false"
		style="height: 25px;padding: 2px 0 0 2px;">


		<c:if test="${sessionScope.replyreply eq 'reply'}">
			<button id='replycomplaintbutton'>回复投诉</button>
		</c:if>
<!--  
		<c:if test="${sessionScope.replycleartab eq 'cleartab'}">
			<button id='clearcomplaintbutton'>清除选择</button>
		</c:if>
       
		<c:if test="${sessionScope.replysearch eq 'search'}">
			<button id='searchbutton'>查询</button>
		</c:if>
      -->
		<c:if test="${sessionScope.replyNum eq 0}">   
        [没有消息]
        </c:if>
	</div>
	<div id="mainPanle" region="center" style="overflow: hidden"
		border="false">
		<table id="tab" width="100%" height="100%" border="false"></table>
	</div>
	<!-- 投诉信息导入页面开始 -->
	<div id="allreportimport" style="height: 20%;display:none;">
		<div id="1" style="display: none; overflow: hidden;">
			投诉信息( <a href="reportimport/templates/投诉模块批次装载数据样表模板.xls"
				target="_blank" style="color: green">模板下载</a>) <input type="file"
				name="uploadify1" id="uploadify1" /> <a
				href="javascript:$('#uploadify1').uploadifyUpload();">上传</a>|
			<a href="javascript:$('#uploadify1').uploadifyClearQueue();">
				取消上传</a>
			<div id="fileQueue1"></div>
		</div>

		<div id="allreportdel" style="height: 20%;display:none;">
			<form action="" method="post" id="form" name="">
				根据 <font color="red">表来源名</font>删除: <input type="text" name="tbName"
					id="pa95tbName" value="" /> <input id="pa95delbutton"
					type="button" value="删除" />
			</form>
		</div>

	</div>

	<!-- 投诉信息查询页面开始 -->
	<div id="allreportsearch" style="height: 20%;display:none;">
		<form action="" method="post" id="form" name="">
			<table align="center" class="tableclass" width="452" border="0">
				<tr>
					<td width="90" align="right">投诉单号码:</td>
					<td width="346"><input type="text" name="cpNum"
						id="complaintcpNum" value="" />
					</td>
				</tr>
				<tr>
					<td align="right">邮购公司:</td>
					<td><input type="text" name="mailCompany"
						id="complaintmailCompany" value="" />
					</td>
				</tr>
				<tr>
					<td align="right">投递局:</td>
					<td><input type="text" name="deliveryBur"
						id="complaintdeliveryBur" value="" />
					</td>
				</tr>
				<tr>
					<td align="right">投诉时间:</td>
					<td><input type="text" name="cpDate"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" id="cpDatestartmonth" value="" />-<input
						type="text" name="cpDateendmonth"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" id="pa95endmonth" value="" />
					</td>
				</tr>
				<tr>
					<td align="right">处理时间:</td>
					<td><input type="text" name="replyDate"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" id="replyDatestartmonth" value="" />-<input
						type="text" name="replyDateendmonth"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" id="replyDateendmonth" value="" />
					</td>
				</tr>
				<tr>
					<td align="right">邮件号:</td>
					<td><input type="text" name="mailNum" id="complaintmailNum"
						value="" />
					</td>
				</tr>
				<tr>
					<td align="right">寄出地:</td>
					<td><input type="text" name="postFrom" id="complaintpostFrom"
						value="" />
					</td>
				</tr>
				<tr>
					<td align="right">收件人:</td>
					<td><input type="text" name="recipts" id="complaintrecipts"
						value="" />
					</td>
				</tr>
				<tr>
					<td align="right">电话:</td>
					<td><input type="text" name="reciptsTel"
						id="complaintreciptsTel" value="" />
					</td>
				</tr>
				<tr>
					<td align="right">处理状态:</td>
					<td><input type="text" name="replyComment"
						id="complaintreplyComment" value="" />
					</td>
				</tr>
				<tr>
					<td align="right">投诉类别:</td>
					<td><input type="text" name="cpType" id="complaintcpType"
						value="" />
					</td>
				</tr>
				<tr>
					<td align="right">&nbsp;</td>
					<td><input id="pa95button" type="button" value="查询" />
					</td>
				</tr>

			</table>

		</form>
	</div>
	<!-- 投诉信息查询页面结束 -->
	<div id="allreportdel" style="height: 20%;display:none;">
		<form action="" method="post" id="form" name="">
			根据 <font color="red">表来源名</font>删除: <input type="text" name="tbName"
				id="pa95tbName" value="" /> <input id="pa95delbutton" type="button"
				value="删除" />
		</form>
	</div>


	<!--速递局人员单件录入页面-->
	<div id="complaintadd" style="display: none; text-align: center;">

		<table style="text-align: center;">
			<tr>
				<td><input type="radio" id="rad1" name="myradio"
					checked="checked" value="0" onclick="radioShow('rad1')" />公司投诉邮局 <input
					type="radio" id="rad2" name="myradio" onclick="radioShow('rad2')"
					value="1" />邮局投诉公司 <label style="color: blue;">这里的邮局投诉公司只局限在自己的子公司</label>
				</td>
			</tr>
		</table>
		<form action="" method="post" id="complaintfrom" name="complaintfrom">
			<input type="hidden" name="complaintid" id="complaintid"> <input
				type="hidden" name="tbType" id="tbType" value="">
			<table id="c1">
				<tr>
					<td align="right">邮件号码:</td>
					<td align="left"><input type="text" name="mailNum"
						id="mailNum" style="width: 150px;" onblur="mailShow()"
						class="easyui-validatebox" required="true" validType="mailcheck"
						missingMessage="必填">
					</td>
					<td align="right">投诉单号码:</td>
					<td align="left"><input type="text" name="cpNum" id="cpNum"
						style="width: 150px;" class="easyui-validatebox"
						readonly="readonly" value="">
					</td>
				</tr>
				<tr>
					<td align="right">邮购公司:</td>
					<td align="left"><input type="text" name="mailCompany"
						id="mailCompany" style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>
					<td align="right">寄出地:</td>
					<td align="left"><input type="text" name="postFrom"
						id="postFrom" style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>
				</tr>
				<tr>
					<td align="right">交寄日期:</td>
					<td align="left"><input type="text" name="postDate"
						id="postDate" style="width: 150px;"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" value="">
					</td>
					<td align="right">收件人:</td>
					<td align="left"><input type="text" name="recipts"
						id="recipts" style="width: 150px;" class="easyui-validatebox"
						readonly="readonly" validType="length[0,500]">
					</td>
				</tr>
				<tr>
					<td align="right">收件人地址:</td>
					<td align="left"><input type="text" id="reciptsAdr"
						name="reciptsAdr" style="width: 150px;" class="easyui-validatebox"
						readonly="readonly" validType="length[0,1000]">
					</td>

					<td align="right">收件人电话:</td>
					<td align="left"><input type="text" name="reciptsTel"
						id="reciptsTel" style="width: 150px;" class="easyui-validatebox"
						readonly="readonly" validType="length[0,1000]">
					</td>
				</tr>
				<tr>
					<td align="right">应收货款:</td>
					<td align="left"><input type="text" name="receiAmount"
						id="receiAmount" style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>

					<td align="right">投诉日期:</td>
					<td align="left"><input type="text" name="cpDate" id="cpDate"
						style="width: 150px;"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" value="">
					</td>
				</tr>
				<tr>
					<td align="right">发传真时间:</td>
					<td align="left"><input type="text" name="faxDate"
						id="faxDate" style="width: 150px;"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" value="">
					</td>

					<td align="right">投诉种类:</td>
					<td align="left"><select id="cpSpecie" name="cpSpecie"
						style="width: 150px;">
							<option value="">请选择</option>
					</select>
					</td>
				</tr>
				<tr>
					<td align="right">被投诉投递局:</td>
					<td align="left"><input type="text" name="deliveryBur"
						id="deliveryBur" style="width: 150px;"
						onkeyup="toautocomplete('deliveryBur','input.do?method=getSyszhdmgndmSelectList&bur='+$('#deliveryBur').val()); ">
					</td>

					<td align="right">投诉类别:</td>
					<td align="left"><select id="cpType" name="cpType"
						style="width: 150px;">
							<option value="公司投诉邮局">公司投诉邮局</option>
							<option value="邮局投诉公司">邮局投诉公司</option>
					</select>
					</td>
				</tr>
				<tr>
					<td align="right">投诉内容:</td>
					<td align="left" colspan="3"><textarea rows="3" cols="22"
							id="cpComment" name="cpComment" class="easyui-validatebox"
							style="width: 400px;" required="true" missingMessage="必填"></textarea>
					</td>
				</tr>
			</table>
		</form>

		<form action="" method="post" id="fromcomplaint" name="fromcomplaint">
			<input type="hidden" name="complaintid" id="complaintid"> <input
				type="hidden" name="tbType" id="tbType" value="">
			<table id="c2" style="display: none;">
				<tr>
					<td align="right">邮件号码:</td>
					<td align="left"><input type="text" name="mailNum"
						id="mailNum2" style="width: 150px;" onblur="mailShow2()"
						class="easyui-validatebox" required="true" validType="mailcheck"
						missingMessage="必填">
					</td>
					<td align="right">投诉单号码:</td>
					<td align="left"><input type="text" name="cpNum" id="cpNum2"
						style="width: 150px;" class="easyui-validatebox">
					</td>
				</tr>
				<tr>
					<td align="right">投递局:</td>
					<td align="left"><input type="text" name="deliveryBur"
						id="deliveryBur2" style="width: 150px;" class="easyui-validatebox"
						onkeyup="toautocomplete('deliveryBur2','input.do?method=getSyszhdmgndmSelectList&bur='+$('#deliveryBur2').val()); ">
					</td>
					<td align="right">寄出地:</td>
					<td align="left"><input type="text" name="postFrom"
						id="postFrom2" style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>
				</tr>
				<tr>
					<td align="right">交寄日期:</td>
					<td align="left"><input type="text" name="postDate"
						id="postDate2" style="width: 150px;"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" value="">
					</td>
					<td align="right">收件人:</td>
					<td align="left"><input type="text" name="recipts"
						id="recipts2" style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>
				</tr>
				<tr>
					<td align="right">收件人地址:</td>
					<td align="left"><input type="text" id="reciptsAdr2"
						name="reciptsAdr" style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>
					<td align="right">收件人电话:</td>
					<td align="left"><input type="text" name="reciptsTel"
						id="reciptsTel2" style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>
				</tr>
				<tr>
					<td align="right">应收货款:</td>
					<td align="left"><input type="text" name="receiAmount"
						id="receiAmount2" style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>
					<td align="right">投诉日期:</td>
					<td align="left"><input type="text" name="cpDate" id="cpDate2"
						style="width: 150px;"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" value="">
					</td>
				</tr>
				<tr>
					<td align="right">发传真时间:</td>
					<td align="left"><input type="text" name="faxDate"
						id="faxDate2" style="width: 150px;"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" value="">
					</td>
					<td align="right">投诉种类:</td>
					<td align="left"><select id="cpSpecie2" name="cpSpecie"
						style="width: 150px;">
							<option value="">请选择</option>
					</select>
					</td>
				</tr>
				<tr>
					<td align="right">被投诉公司:</td>
					<td align="left"><input type="text" name="mailCompany"
						id="mailCompany2" style="width: 150px;" class="easyui-validatebox">
					</td>

					<td align="right">投诉类别:</td>
					<td align="left"><select id="cpType2" name="cpType"
						style="width: 150px;">
							<option value="公司投诉邮局">公司投诉邮局</option>
							<option value="邮局投诉公司">邮局投诉公司</option>
					</select>
					</td>
				</tr>
				<tr>
					<td align="right">投诉内容:</td>
					<td align="left" colspan="3"><textarea rows="3" cols="22"
							id="cpComment2" name="cpComment" class="easyui-validatebox"
							style="width: 400px;" required="true" missingMessage="必填"></textarea>
					</td>
				</tr>
			</table>
		</form>

	</div>
	<!---速递局人员单件录入页面结束-->

	<!-- 回复投诉信息页面 -->
	<div id="addcomplaint"
		style="height: 20%;display: none;text-align: center;">
		<form action="" method="post" id="formcom" name="">
			<input type="hidden" name="complaintid" id="complaintid3" value="">
			<input type="hidden" name="tbType" id="tbType" value="">
			<table>

				<tr>
					<td align="right">邮件号码:</td>
					<td align="left"><input type="text" name="mailNum"
						id="mailNum3" style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>
					<td align="right">投诉单号码:</td>
					<td align="left"><input type="text" name="cpNum" id="cpNum3"
						style="width: 150px;" class="easyui-validatebox"
						readonly="readonly" value="">
					</td>
				</tr>
				<tr>
					<td align="right">邮购公司:</td>
					<td align="left"><input type="text" name="mailCompany"
						id="mailCompany3" style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>
					<td align="right">寄出地:</td>
					<td align="left"><input type="text" name="postFrom"
						id="postFrom3" style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>
				</tr>
				<tr>
					<td align="right">交寄日期:</td>
					<td align="left"><input type="text" name="postDate"
						id="postDate3" style="width: 150px;" readonly="readonly" value="">
					</td>
					<td align="right">收件人:</td>
					<td align="left"><input type="text" name="recipts"
						id="recipts3" style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>
				</tr>
				<tr>
					<td align="right">收件人地址:</td>
					<td align="left"><input type="text" id="reciptsAdr3"
						name="reciptsAdr" style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>
					<td align="right">收件人电话:</td>
					<td align="left"><input type="text" name="reciptsTel"
						id="reciptsTel3" style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>
				</tr>
				<tr>
					<td align="right">应收货款:</td>
					<td align="left"><input type="text" name="receiAmount"
						id="receiAmount3" style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>
					<td align="right">投诉日期:</td>
					<td align="left"><input type="text" name="cpDate" id="cpDate3"
						style="width: 150px;" readonly="readonly" value="">
					</td>
				</tr>
				<tr>
					<td align="right">发传真时间:</td>
					<td align="left"><input type="text" name="faxDate"
						id="faxDate3" style="width: 150px;" readonly="readonly" value="">
					</td>
					<td align="right">投诉种类:</td>
					<td align="left"><input type="text" name="cpSpecie"
						id="cpSpecie3" style="width: 150px;" readonly="readonly">
				</tr>
				<tr>
					<td align="right">被投诉投递局:</td>
					<td align="left"><input type="text" name="deliveryBur"
						id="deliveryBur3" style="width: 150px;" readonly="readonly">
					</td>
					<td align="right">投诉类别:</td>
					<td align="left"><input type="text" name="cpType" id="cpType3"
						style="width: 150px;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td align="right">投诉内容:</td>
					<td align="left" colspan="3"><textarea rows="3" cols="22"
							id="cpComment3" name="cpComment" class="easyui-validatebox"
							style="width: 400px;" readonly="readonly"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="4"><hr />
					</td>
				</tr>
				<tr>

					<td align="right"><font color="red">*</font>回复日期:</td>
					<td align="left"><input type="text" name="replyDate"
						id="replyDate3" style="width: 150px;"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" value="">
					</td>
					<td align="right"><font color="red">*</font>回复内容:</td>
					<td align="left"><textarea rows="2" cols="22"
							id="replyComment3" name="replyComment" class="easyui-validatebox"
							style="width: 150px;" required="true" missingMessage="必填"></textarea>
					</td>
				</tr>
				<tr>

					<td align="right">联系人:</td>
					<td align="left"><input type="text" name="contact"
						id="contact3" style="width: 150px;" class="easyui-validatebox">
					</td>

					<td align="right">联系电话:</td>
					<td align="left"><input type="text" name="contactTel"
						id="contactTel3" style="width: 150px;" class="easyui-validatebox"
						validType="telcheck">
					</td>
				</tr>
			</table>

		</form>
	</div>
	<!-- 回复投诉信息页面 -->

</body>
</html>