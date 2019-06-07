<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>退回录入</title>
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
		returnlist();
		//退回信息
		$("#importbutton").click(function() {
			importfinance("装载退回", "allreportimport");
		});
		$("#pa95button").click(function() {
			var returnmailNum = $("#returnmailNum").val();
			var pa95startmonth = $("#pa95startmonth").val();
			var pa95endmonth = $("#pa95endmonth").val();
			returnlist(returnmailNum, pa95startmonth, pa95endmonth);
			$("#allreportsearch").dialog("close");
		});
		$("#searchbutton").click(function() {
			importfinance("查询退回", "allreportsearch");
		});
		$("#deletebutton").click(function() {
			importfinance("删除退回", "allreportdel");
		});
		$("#pa95delbutton").click(function() {
			var tbName = $("#pa95tbName").val();
			deleTbName("import.do?method=financeDelete", tbName, '');
			$("#allreportdel").dialog("close");
		});
		$("#createreturnbutton").click(
		
		     function() {
			   createreturn();
				
			 });
				
		$("#updatereturnbutton").click(
				function() {
				
				var row = $("#tab").datagrid("getSelections");
//			alert(row.length);
			if(row.length<1){
			$.messager.alert("警告信息", "选择一条记录", "warning");
			}
			if(row.length==1){
			 	 row = $("#tab").datagrid("getSelected");
				updatereturn("退回录入", "returnform", row, "addreturn",
								"input.do?method=updateReturn");
			}
			if(row.length>1){
//				alert("请选择要一条修改的数据");
				$.messager.alert("警告信息", "选择一条记录", "warning");
			}
					
				});
		$("#deletereturnbutton").click(function() {
			var row = $("#tab").datagrid("getSelected");
			if (row == null) {
				$.messager.alert("警告信息", "选择一条要删除的记录！", "warning");
			} else {
				$.messager.confirm("确认", "确定要删除?", function(r) {
					if (r) {
						deleall("input.do?method=deleteReturnById");
					}
				});
			}
		});

		$("#clearreturnbutton").click(function() {
			clearSelect("tab");
		});

		// 邮件号验证
		$.extend($.fn.validatebox.defaults.rules, {
			mailcheck : {
				validator : function(value) {
					return /^EC\d{9}CS$/.test(value);
				},
				message : "邮件号不正确"
			}
		});

	});
	var isimport = true;
	function importfinance(addTitle, addId) {
		if (isimport) {
			importreport('uploadify1', 'import', 'returnImport', 'fileQueue1',
					'allreportimport');//退回信息
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
	
 
							
	function createreturn() {
		resetContent("returnform");
			var dt = new Date().format("yyyy-MM-dd");
		$("#returnDate").val(dt); //投诉日期
		$("#addreturn").show();
		$("#addreturn").dialog({
			title : "录入退回信息",
			modal : true,
			width : 400,
			height : 300,
            minimizable : false,
			maximizable : false,
			buttons : [ {
				text : "添加",
				iconCls : "icon-ok",
				handler : function() {
					if(b==0){
						$("#returnform").form("submit", {
						url : "input.do?method=addReturn",
						onSubmit : function() {
							return $(this).form("validate");
						},
						success : function(data) {
							$("#addreturn").dialog("close");
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
					$("#addreturn").dialog("close");
				}
			} ]
		});
	}
	
	//退回信息
	function returnlist(returnmailNum, pa95startmonth, pa95endmonth) {
		$("#tab").datagrid({
			singleSelect : false,
			fit : true,
			queryParams : {
				mailNum : returnmailNum,
				StartDate : pa95startmonth,
				EndDate : pa95endmonth
			},
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "search.do?method=getReturnExcelList",
			columns : [ [ {
				field : "ck",
				checkbox : true
			}, {
				field : "mailNum",
				title : "邮件号",
				width : fillsize(0.1)
			}, {
				field : "deptName",
				title : "入网企业",
				width : fillsize(0.1)
			},{
				field : "returnDate",
				title : "退回日期",
				width : fillsize(0.1)

			} ] ],
			pagination : true

		});

	}

	/**
	 *修改退回信息
	 */
	function updatereturn(updattitle, updatform, row, updatId, updatMethod) {
		resetContent(updatform);
		$("#returnid").attr("value", row.id);
		$("#mailNum").attr("value", row.mailNum);
		$("#entpsCode").attr("value", row.entpsCode);
		$("#returnDate").attr("value", row.returnDate);
		updat(updattitle, updatform, updatId, updatMethod);
	}
	
	//根据邮件号是否存在
	var b=0;
	function   showMailNum(){
	   var num = $("#mailNum").val();//得到邮件号码
	   if (num != "" && num != null) {
			$.post("input.do?method=checkReturnMailNum&mailNum="+num,function(a) {
			//alert("a的值"+a);
			if(a==null || a=='' || a==undefined){
				b=1;
				document.getElementById("show").style.display="block";
			}else{
				document.getElementById("show").style.display="none";
				b=0;
			}
		  }); 
	 }
	 }
	
	
</script>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
	<div region="north" split="true" border="false"
		style="height: 25px;padding: 2px 0 0 2px;">
	
		<c:if test="${sessionScope.returnupdate eq 'update'}">
			<button id='updatereturnbutton'>修改</button>
		</c:if>
		
	</div>
	<div id="mainPanle" region="center" style="overflow: hidden"
		border="false">
		<table id="tab" width="100%" height="100%" border="false"></table>
	</div>
	<div id="allreportimport" style="height: 20%;display:none;">
		<!-- 退回信息导入页面开始 -->
		<div id="1" style="display: none; overflow: hidden;">

			退回信息( <a href="reportimport/templates/退回装载模板.xls" target="_blank"
				style="color: green">模板下载</a>) <input type="file" name="uploadify1"
				id="uploadify1" /> <a
				href="javascript:$('#uploadify1').uploadifyUpload();"
				onclick="hasfile('uploadify1')">上传</a>| <a
				href="javascript:$('#uploadify1').uploadifyClearQueue();"> 取消上传</a>
			<div id="fileQueue1"></div>
		</div>
	</div>
	<div id="allreportsearch" style="height: 20%;display:none;">
		<form action="" method="post" id="form" name="">
		
			<table align="center" width="437" border="0">
				<tr>
					<td width="75" align="right">邮件号:</td>
					<td width="346"><input type="text" name="mailNum"  
						id="returnmailNum" value="" />
					</td>
				</tr>
				<tr>
					<td align="right">退回日期:</td>
					<td><input type="text" name="pa95startmonth"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" id="pa95startmonth" value="" />-<input
						type="text" name="pa95endmonth"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" id="pa95endmonth" value="" /></td>
				</tr>
				<tr>
					<td align="right">&nbsp;</td>
					<td><input id="pa95button" type="button" value="查询" /></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="allreportdel" style="height: 20%;display:none;">
		<form action="" method="post" id="form" name="">
			<font color="red">表来源名</font>删除: <input type="text" name="tbName"
				id="pa95tbName" value="" /> <input id="pa95delbutton" type="button"
				value="删除" />
		</form>

	</div>
	<!--退回添加页面-->
	<div id="addreturn" style="display: none; text-align: center;">
		<form action="" method="post" id="returnform" name="returnform">
			<input type="hidden" name="id" id="returnid"> <input
				type="hidden" name="tbType" id="tbType" value="return">
			<table style="text-align: center;">
				<tr>
					<td align="right"><font color="red">*</font>邮件号:</td>
					<td><input type="text" id="mailNum" name="mailNum" onblur="showMailNum()"
						width="220px" class="easyui-validatebox" required="true"
						validType="mailcheck" missingMessage="必填" style="width: 150px;" />
					<span id="show" style="display:none; " ><font color="red">邮件不存在</font></span>
					</td>
				</tr>
                <tr>
					<td align="right">入网企业代码:</td>
					<td><input type="text" name="entpsCode" id="entpsCode"
						style="width: 150px;" class="easyui-validatebox"
						readonly="readonly">
					</td>
				</tr>
				<tr>
					<td align="right">退回日期:</td>
					<td><input type="text" name="returnDate" id="returnDate"
						style="width: 150px;"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
						readonly="readonly" value=""></td>
				</tr>
			</table>
		</form>
	</div>
	<!--退回添加页面结束-->

</body>
</html>