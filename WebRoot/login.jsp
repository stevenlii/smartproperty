<%@ page language="java" pageEncoding="UTF-8"%>
<html>
	<head>
		<title>智能物业管理系统</title>
		<link rel="stylesheet" type="text/css" href="css/login.css">
		<link rel="stylesheet" type="text/css"
			href="jeasyui/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="jeasyui/themes/icon.css">
		<link rel="icon" href="images/favicon.ico" type="image/x-icon" />
		<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
		<script src="js/jquery.js"></script>
		<script type="text/javascript" src="jeasyui/jquery.easyui.min.js"></script>
		<script type="text/javascript"
			src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript">
	$(function() {
		$("#txtUser").focus();
		document.onkeydown = function(e){ 
			var ev = (e)?e:((window.event)?window.event:"");
			keyCode = ev.keyCode?ev.keyCode:(ev.which?ev.which:ev.charCode);//兼容所有浏览器
		    if(keyCode==13) {
		    	login();
		     }
		};
	});
	function login() {
		if ($("#txtUser").val() == "") {
			showmsg("用户名称不能为空~~");
			$("#txtUser").focus();
			return false;
		} else if ($("#txtPass").val() == "") {
			showmsg("密码不能为空~~");
			$("#txtPass").focus();
			return false;
		}else{
			$("#form1").submit();
		}
	}
	function formreset(){
		$("#form1").form("clear");
		$("#txtUser").focus();
	}
	function validateusername() {
		$.ajax({
			type : "POST",
			dataType : "text",
			url : "login.do?method=checkUsername&nowdate=" + new Date(),
			data : {
				username : $("#txtUser").val()
			},
			success : function(msg) {
				showmsg(msg);
			}
		});
	}
	//提示信息
	function showmsg(data){
		$.messager.show({
									title : "提示信息",
									msg : data,
									showType : "show",
									timeout : 3000
								});
	}
</script>
	</head>
	<body>
		<form id="form1" name="form1" method="post" action="login.do?method=login">
			<div class="loginPanel">
				<div class="x-box-tl">
					<div class="x-box-tr">
						<div class="x-box-tc">
						</div>
					</div>
				</div>

				<div class="x-box-ml">
					<div class="x-box-mr">
						<div class="x-box-mc" style="height: 173px;">
							<img id="j_id2:j_id4" src="images/register2.jpg" />
							<table id="j_id2:j_id5" cellspacing="4px" style="width: 100%">
								<tr>
									<td colspan="1" rowspan="1"
										style="padding-right: 3px;text-align: right;">
										<label>
											登录名：
										</label>
									</td>
									<td colspan="2">
										<label>
											<input class="x-form-text" type="text"
												id="txtUser" name="txtUser" value=""
												onblur="validateusername()" />
										</label>
									</td>
								</tr>
								<tr>
									<td colspan="1" rowspan="1"
										style="padding-right: 3px;text-align: right;">
										<label>
											密 码：
										</label>
									</td>
									<td colspan="2">
										<label>
											<input class="x-form-text"
												type="password" name="txtPass" id="txtPass" />
										</label>
									</td>
								</tr>
								<tr>
									<td colspan="4" style="text-align: center;">
										<label>
											<img src="images/ZR05.gif" style="padding-left: 42px;" onclick="login()" id="_login"/>
											<img src="images/ZR06.gif" style="padding-left: 12px;" onclick="formreset()" id="_reset"/>
										</label>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>

				<div class="x-box-bl">
					<div class="x-box-br">
						<div class="x-box-bc">
						</div>
					</div>
				</div>

				<div class="foot">
					CopyRight@<a href="http://www.paymoon.com/" target="_blank">paymoon.com</a>
				</div>
			</div>
		</form>
	</body>
</html>

