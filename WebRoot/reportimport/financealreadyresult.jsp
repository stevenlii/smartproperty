<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>已结账汇总结果显示页面</title>
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
		<script type="text/javascript"
			src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="js/common.js"></script>
		<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript"
			src="uploadify/jquery.uploadify.v2.1.4.min.js"></script>
		<script type="text/javascript" src="js/import.js"></script>
		<script type="text/javascript" src="js/mask.js"></script>
		
	</head>
	<body class="easyui-layout" scroll="no">
		<div region="center">
			<div id="allreportsearch" style="height: 35%; display: block;">
				<table align="center" width="1100">
					<tr>
						<td width="100">
							邮件号
						</td>
						<td>
							入网公司
						</td>
						<td>
							交寄日期
						</td>
						<td>
							结算日期
						</td>
						<td>
							实收费用
						</td>
						<td>
							服务费
						</td>
						<td>
							结算费
						</td>
						<td>
							退回邮费
						</td>
						<td>
							合计费用
						</td>
						<td>
							应收贷款
						</td>
						<td>
							结算货款
						</td>
						<td>
							结算余额
						</td>
					</tr>
					<c:forEach items="${Listfinance}" var="list">
						<tr>
							<td>
								${list[0] }
							</td>
							<td>
								${list[1] }
							</td>
							<td>
								${list[2] }
							</td>
							<td>
								${list[3] }
							</td>
							<td>
								${list[4] }
							</td>
							<td>
								${list[5] }
							</td>
							<td>
								${list[6] }
							</td>
							<td>
								${list[7] }
							</td>
							<td>
								${list[8] }
							</td>
							<td>
								${list[9] }
							</td>
							<td>
								${list[10] }
							</td>
							<td>
								${list[11] }
							</td>
						</tr>
					</c:forEach>
					<c:forEach items="${ListfinanceCount}" var="lc">
						<tr>
							<td width="80">
								数量：${lc[0] }
							</td>
							<td width="80"></td>
							<td width="80"></td>
							<td width="80"></td>
							<td width="80">
								${lc[1] }
							</td>
							<td width="80">
								${lc[2] }
							</td>
							<td width="80">
								${lc[3] }
							</td>
							<td width="80">
								${lc[4] }
							</td>
							<td width="80">
								${lc[5] }
							</td>
							<td width="80">
								${lc[6] }
							</td>
							<td width="80">
								${lc[7] }
							</td>
							<td width="80">
								${lc[8] }
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</body>
</html>
