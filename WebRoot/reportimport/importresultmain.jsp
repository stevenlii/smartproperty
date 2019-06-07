<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>装载页面详细</title>
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
		<script type="text/javascript" src="js/jquery.autocomplete.js"></script>
		<script type="text/javascript">
	$(function() {
	});
</script>
	</head>
	<body>

		<div id="mainPanle" region="center" style="overflow: auto;"
			border="false">

			装载详细页面！
			<br>
			<c:choose>
				<c:when test="${importMap['importSuccess'] eq 'true'}">装载成功！
				<table width="800" border="0" align="center">
						<tr>
							<td width="200">
								装载条数
							</td>
							<td width="140">
								重复条数
							</td>

						</tr>
						<tr>
							<td height="43">
								${importMap['importSuccessNum']}
							</td>
							<td>
								${importMap['importDuplicateNum']}
							</td>
						</tr>
					</table>
					<c:if test="${importMap['importDuplicateNum'] > 0}">
						<table width="800" border="0" align="center">
							<tr>
								<td width="200">
									重复邮件号
								</td>

							</tr>
							<c:forEach items="${duplicateMap}" var="item">
								<tr>
									<td height="43">
										${item.value}
									</td>
								</tr>
							</c:forEach>
						</table>
					</c:if>
				</c:when>
				<c:otherwise>装载失败！请您确保：<br />
				1、装载文件与装载模板规范一致<br />
				2、装载过程中服务器稳定运行<br />
				》》更多</c:otherwise>
			</c:choose>


		</div>
	</body>

</html>
