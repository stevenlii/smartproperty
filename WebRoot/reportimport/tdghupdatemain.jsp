<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>投递更新</title>
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

<script type="text/javascript" >
	$(function() {
		TdghList();
		$("#createtdghbutton").click(
				function() {
					createtdgh();
				});
		$("#updatetdghbutton").click(
				function() {
				
				var row = $("#tab").datagrid("getSelections");
//			alert(row.length);
			if(row.length<1){
			$.messager.alert("警告信息", "选择一条记录", "warning");
			}
			if(row.length==1){
			 	 row = $("#tab").datagrid("getSelected");
				 updatetdgh(row);
			}
			if(row.length>1){
//				alert("请选择要一条修改的数据");
				$.messager.alert("警告信息", "选择一条记录", "warning");
			}
				
					
				});
		$("#deletetdghbutton").click(function() {
			var row = $("#tab").datagrid("getSelected");
			if (row == null) {
				$.messager.alert("警告信息", "选择一条要删除的记录！", "warning");
			} else {
				$.messager.confirm("确认", "确定要删除?", function(r) {
					if (r) {
						deleall("input.do?method=deleteTdghById");
					}
				});
			}
		});
		$("#cleartdghbutton").click(function() {
			clearSelect("tab");
		});
		
		
		//自定义验证
		$.extend($.fn.validatebox.defaults.rules, {
			//邮件号验证
			mailcheck : {
					validator : function(value) {
						return /^EC\d{9}CS$/.test(value);
					},
					message : "邮件号不正确"

				}
		 
		});
	});

function createtdgh() {
		resetContent("tdghform");
		 $("#addtdgh").show();
		$("#addtdgh").dialog({
			title : "录入投递信息",
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
						$("#tdghform").form("submit", {
						url : "input.do?method=addTdgh",
						onSubmit : function() {
							return $(this).form("validate");
						},
						success : function(data) {
							$("#addtdgh").dialog("close");
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
					$("#addtdgh").dialog("close");
				}
			} ]
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
          
function updatetdgh(row) {
			resetContent("tdghform");
			var s=$("#billDate").val(row.billDate);
			
			$("#id").attr("value", row.id);
			//$("#billDate").attr("value", row.billDate);
		    $("#billDate").attr("value", formatDate(new Date(row.billDate)));
			$("#mailNum").attr("value", row.mailNum);
			$("#mailAddress").attr("value", row.mailAddress);
			$("#mailState").attr("value", row.mailState);
			$("#mailDesc").attr("value", row.mailDesc);
			$("#entpsCode").attr("value", row.entpsCode);
		$("#addtdgh").show();
		$("#addtdgh").dialog({
			title : "更新投递信息",
			modal : true,
			width : 400,
			height : 300,
			minimizable : false,
			maximizable : false,
			buttons : [ {
				text : "更新",
				iconCls : "icon-ok",
				handler : function() {
					$("#tdghform").form("submit", {
						url : "input.do?method=updateTdgh",
						onSubmit : function() {
							return $(this).form("validate");
						},
						success : function(data) {
							$("#addtdgh").dialog("close");
							flashTable("tab");
							showmsg(data);
						}
					});
				}
			}, {
				text : "取消",
				iconCls : "icon-undo",
				handler : function() {
					$("#addtdgh").dialog("close");
				}
			} ]
		});
	}


	/**
	 * 投递信息*/

	function TdghList() {
		$("#tab").datagrid({
			nowrap : false,
			singleSelect : false,
			striped : true,
			fit : true,
			pageNumber : 1,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			url : "search.do?method=getTdghList",
			columns : [ [ {
				field : "ck",
				checkbox : true
			}, {
				field : "billDate",
				title : "处理日期",
				width : fillsize(0.14),
				formatter : formatDate
			}, {
				field : "mailNum",
				title : "邮件号码",
				width : fillsize(0.1)
			},{
				field : "deptName",
				title : "入网企业",
				width : fillsize(0.1)
			}, {
				field : "mailAddress",
				title : "邮件到达地点",
				width : fillsize(0.15)
			} ,
			{
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
	<!-- 
<c:if test="${sessionScope.tdghcreate eq 'create'}">
<button id='createtdghbutton'>添加</button>
</c:if>
 -->
<c:if test="${sessionScope.tdghupdate eq 'update'}">
<button id='updatetdghbutton'>修改</button>
</c:if>
<!--  
<c:if test="${sessionScope.tdghdelsingle eq 'delsingle'}">
<button id='deletetdghbutton'>删除</button>
</c:if>
<c:if test="${sessionScope.tdghcleartab eq 'cleartab'}">
<button id='cleartdghbutton'>清除选择</button>
</c:if>
-->
</div>
<div id="mainPanle" region="center" style="overflow: hidden"
border="false">
	<table id="tab" width="100%" height="100%" border="false"></table>
</div>
<!--投递添加页面-->
<div id="addtdgh" style="display: none; text-align: center;">
<form action="" method="post" id="tdghform" name="tdghform">
	<input type="hidden" name="id" id="id">
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
		<tr>
			<td align="right">处理日期:</td>
			<td>
			<input style="width: 150px;" type="text" name="billDate"
				onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate"
				readonly="readonly" id="billDate" value="" />
			</td>
		</tr>
		<tr>
			<td align="right">邮件到达地点:</td>
			<td><input type="text" name="mailAddress" id="mailAddress"
				style="width: 150px;" class="easyui-validatebox"></td>
	</tr>
	<tr>
			<td align="right">邮件状态:</td>
			<td><input type="text" name="mailState" id="mailState"
				style="width: 150px;" class="easyui-validatebox" ></td>
	</tr>
	
		<tr>
			<td align="right">邮件描述:</td>
			<td><textarea rows="2" cols="22" id="mailDesc"
					name="mailDesc" class="easyui-validatebox"
					style="width: 150px;" ></textarea></td>
			</tr>
			
		</table>
	</form>
</div>
<!--投递添加页面结束-->
</body>
</html>