/**
 * 用与添加，修改，删除 邮局公司用户所能查看的入网公司
 */
//查看所选企业对应用户
	function getCompany(userid) { 
		$("#usertorole").datagrid({
			singleSelect : false,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			queryParams:{"userid":userid},
			url : "AdmDept.do?method=getComList",
			
			columns : [ [{
				field : "serialno",
				title : "顺序号",
				width : fillsize(0.05)
			}, {
				field : "companycode",
				title : "公司代码",
				width : fillsize(0.1)
			},{
				field : "deptname",
				title : "公司名称",
				width : fillsize(0.2)
			}, {
				field : "companytypeflag",
				title : "类型",
				width : fillsize(0.1),
				formatter : function(value, rec) {
					if(value==1){
						return "入网公司";
					}else{
						return "邮政公司";
					}
				}
			}, {
				field : "remark",
				title : "备注",
				width : fillsize(0.2)
			} ] ],
			pagination : true
		});
		$("#selectUser").show();
		$("#selectUser")
				.dialog(
						{
							title : "所能查看的入网公司",
							modal : true,
							width : 580,
							height : 400,
							collapsible : true,
							minimizable : false,
							maximizable : false,
							buttons : [
									 {
										text : '关闭',
										handler : function() {
											$("#selectUser").dialog("close");
										}
									} ]
						});
	}
	//添加公司对应信息
	function addCompany(userid){
	
		$("#usertorole").datagrid({
			singleSelect : false,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			queryParams:{"userid":userid},
			url : "AdmDept.do?method=getComAllList",
			
			columns : [ [{
			       field : "ck",
				checkbox : true 
			},{
				field : "serialno",
				title : "顺序号",
				width : fillsize(0.05)
			}, {
				field : "companycode",
				title : "公司代码",
				width : fillsize(0.1)
			},{
				field : "deptname",
				title : "公司名称",
				width : fillsize(0.2)
			}, {
				field : "companytypeflag",
				title : "类型",
				width : fillsize(0.1),
				formatter : function(value, rec) {
					if(value==1){
						return "入网公司";
					}else{
						return "邮政公司";
					}
				}
			}, {
				field : "remark",
				title : "备注",
				width : fillsize(0.2)
			} ] ],
			pagination : true
		});
		$("#selectUser").show();
		$("#selectUser")
				.dialog(
						{
							title : "所有入网公司",
							modal : true,
							width : 580,
							height : 400,
							collapsible : true,
							minimizable : false,
							maximizable : false,
							buttons : [
									 {
										text : "提交",
										iconCls : "icon-ok",
										handler : function() {
											var ids = [];
											var rows = $("#usertorole")
													.datagrid("getSelections");
											for ( var i = 0; i < rows.length; i++) {
												ids.push(rows[i].companycode);
											}
											if (ids.length > 0) {
												$
														.ajax({
															type : "POST",
															dataType : "text",
															url : "AdmDept.do?method=addComToUser&nowdate="
																	+ new Date(),
															data : {
																"comIds" : ids
																		.join(),
																"userId" : userid
															},
															success : function(
																	data) {
																$.messager
																		.show({
																			title : "提示信息",
																			msg : data,
																			showType : "show",
																			timeout : 3000
																		});
																//showRoleToUserTab(userid);
															}
														});
												$("#selectUser")
														.dialog("close");
											} else {
												$.messager.alert("提示信息",
														"没有选择角色！", "warning");
											}

										}
									},{
										text : '关闭',
										handler : function() {
											$("#selectUser").dialog("close");
										}
									} ]
						});
	}
	//删除用户对应企业
	function deleteCompany(userid){
		
		$("#usertorole").datagrid({
			singleSelect : false,
			pageSize : 20,
			pageList : [ 20, 30, 50 ],
			queryParams:{"userid":userid},
			url : "AdmDept.do?method=getComList",
			
			columns : [ [{
			       field : "ck",
				checkbox : true 
			},{
				field : "serialno",
				title : "顺序号",
				width : fillsize(0.05)
			}, {
				field : "companycode",
				title : "公司代码",
				width : fillsize(0.1)
			},{
				field : "deptname",
				title : "公司名称",
				width : fillsize(0.2)
			}, {
				field : "companytypeflag",
				title : "类型",
				width : fillsize(0.1),
				formatter : function(value, rec) {
					if(value==1){
						return "入网公司";
					}else{
						return "邮政公司";
					}
				}
			}, {
				field : "remark",
				title : "备注",
				width : fillsize(0.2)
			} ] ],
			pagination : true
		});
		$("#selectUser").show();
		$("#selectUser")
				.dialog(
						{
							title : "入网公司修改",
							modal : true,
							width : 580,
							height : 400,
							collapsible : true,
							minimizable : false,
							maximizable : false,
							buttons : [
									 {
										text : "确定删除",
										iconCls : "icon-ok",
										handler : function() {
											var ids = [];
											var rows = $("#usertorole")
													.datagrid("getSelections");
											for ( var i = 0; i < rows.length; i++) {
												ids.push(rows[i].companycode);
											}
											if (ids.length > 0) {
												$
														.ajax({
															type : "POST",
															dataType : "text",
															url : "AdmDept.do?method=deleteComFromUser&nowdate="
																	+ new Date(),
															data : {
																"comIds" : ids
																		.join(),
																"userId" : userid
															},
															success : function(
																	data) {
																$.messager
																		.show({
																			title : "提示信息",
																			msg : data,
																			showType : "show",
																			timeout : 3000
																		});
																//showRoleToUserTab(userid);
															}
														});
												$("#selectUser")
														.dialog("close");
											} else {
												$.messager.alert("提示信息",
														"没有选择角色！", "warning");
											}

										}
									},{
										text : '关闭',
										handler : function() {
											$("#selectUser").dialog("close");
										}
									} ]
						});
	}