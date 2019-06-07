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
		showimportreport(1);
		FinanceList('');

		//交寄信息
		$("#importbutton").click(function() {
			importfinance("装载交寄", "allreportimport")
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
			columns : [ [ {
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
</script>
</head>
<body class="easyui-layout" scroll="no">
	<div region="north" split="true" border="false"
		style="height: 25px;padding: 2px 0 0 2px;">
		<c:if test="${sessionScope.mailpostadd eq 'add'}">
			<button id='importbutton'>装载</button>
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
					id="uploadify1" /> <a id="uploadify1chaining"
					href="javascript:$('#uploadify1').uploadifyUpload();">上传</a>| <a
					href="javascript:$('#uploadify1').uploadifyClearQueue();"> 取消上传</a>
				<div id="fileQueue1"></div>
			</div>
		</div>
	</div>
</body>

</html>
