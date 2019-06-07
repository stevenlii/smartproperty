//提示信息
function showmsg(data) {
	$.messager.show({
		title : "提示信息",
		msg : data,
		showType : "show",
		timeout : 6000
	});
}
// 返回格式为yyyy-MM-dd的当前日期
function nowDate() {
	var md = new Date();
	var year = md.getFullYear();
	var month = md.getMonth() + 1;
	var day = md.getDate();
	var _date = year + "-" + month + "-" + day;
	return _date;
}
// 返回格式为yyyy-MM的当前月
function nowMonth() {
	var md = new Date();
	var year = md.getFullYear();
	var month = md.getMonth() + 1;
	var _month = year + "-" + month;
	return _month;
}
// easyui datagrid dateFormatter
function formatterdate(val, row) {
	if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
				+ date.getDate();
	}
}
// easyui datagrid dateFormatter
function formatterdatetime(val, row) {
	if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
				+ date.getDate() + ' ' + date.getHours() + ':'
				+ date.getMinutes() + ':' + date.getSeconds();
	}
}
function fulldate(id,starttime,endtime) {
	$("#"+id).click(function() {
		var fdate = $("#"+starttime).val();
		var edate = $("#"+endtime).val();
		if(fdate==""||edate==""){
			showmsg("日期不能为空！");
			return false;
		}else if (fdate > edate) {
			showmsg("开始日期不能大于结束日期！");
			return false;
		}

	});
}
/**
 * 清空指定表单中的内容,参数为目标form的id 注：在使用Jquery EasyUI的弹出窗口录入新增内容时，每次打开必须清空上次输入的历史
 * 数据，此时通常采用的方法是对每个输入组件进行置空操作:$("#name").val(""),这样做，
 * 当输入组件比较多时会很繁琐，产生的js代码很长，这时可以将所有的输入组件放入个form表单 中，然后调用以下方法即可。
 * 
 * @param formId
 *            将要清空内容的form表单的id
 */
function resetContent(formId) {
	var clearForm = document.getElementById(formId);
	if (null != clearForm && typeof (clearForm) != "undefined") {
		clearForm.reset();
	}
}
/**
 * 清空指定表单中的内容,参数为目标form的id 注：在使用Jquery EasyUI的弹出窗口更新内容时，更新完数据需要清空Form
 * 数据，此时通常采用的方法是对每个输入组件进行置空操作:$("#name").val(""),这样做，
 * 当输入组件比较多时会很繁琐，产生的js代码很长，这时可以将所有的输入组件放入个form表单 中，然后调用以下方法即可。
 * 
 * @param formId
 *            将要清空内容的form表单的id
 */
function clearContent(formId) {
	$('#' + formId).form("clear");
}
/**
 * 刷新DataGrid列表(适用于Jquery Easy Ui中的dataGrid)
 * 注：建议采用此方法来刷新DataGrid列表数据(也即重新加载数据)，不建议直接使用语句
 * $('#dataTableId').datagrid('reload');来刷新列表数据，因为采用后者，如果日后
 * 在修改项目时，要在系统中的所有刷新处进行其他一些操作，那么你将要修改系统中所有涉及刷新
 * 的代码，这个工作量非常大，而且容易遗漏；但是如果使用本方法来刷新列表，那么对于这种修 该需求将很容易做到，而去不会出错，不遗漏。
 * 
 * @param dataTableId
 *            将要刷新数据的DataGrid依赖的table列表id
 */
function flashTable(dataTableId) {
	$('#' + dataTableId).datagrid('reload');
}
/**
 * 取消DataGrid中的行选择(适用于Jquery Easy Ui中的dataGrid)
 * 注意：解决了无法取消"全选checkbox"的选择,不过，前提是必须将列表展示
 * 数据的DataGrid所依赖的Table放入html文档的最全面，至少该table前没有 其他checkbox组件。
 * 
 * @param dataTableId
 *            将要取消所选数据记录的目标table列表id
 */
function clearSelect(dataTableId) {
	$('#' + dataTableId).datagrid('clearSelections');
	// 取消选择DataGrid中的全选
	$("input[type='checkbox']").eq(0).attr("checked", false);
}
/**
 * 获取当前datagrid当前页的所有行信息
 */
function getRows(dataTableId){
	var rows = $('#' + dataTableId).datagrid('getRows');
	return rows;
}
/**
 * 自适应表格的宽度处理(适用于Jquery Easy Ui中的dataGrid的列宽),
 * 注：可以实现列表的各列宽度跟着浏览宽度的变化而变化，即采用该方法来设置DataGrid
 * 的列宽可以在不同分辨率的浏览器下自动伸缩从而满足不同分辨率浏览器的要求
 * 使用方法：(如:{field:'ymName',title:'编号',width:fillsize(0.08),align:'center'},)
 * 
 * @param percent
 *            当前列的列宽所占整个窗口宽度的百分比(以小数形式出现，如0.3代表30%)
 * 
 * @return 通过当前窗口和对应的百分比计算出来的具体宽度
 */
function fillsize(percent) {
	var bodyWidth = document.body.clientWidth;
	return (bodyWidth - 90) * percent;
}
/**
 * 自动提示方法 id代表input的id url代表后台处理地址 后台返回的数据是以“\n”分割的字符串
 */
function toautocomplete(id, url) {
	$("#" + id).autocomplete({
		url : url,
		showResult : function(value, data) {
			return '<span style="color:green">' + value + '</span>';
		},
		selectFirst : true,
		autoWidth : 'width',
		maxItemsToShow : 15
	});
}

/**
 * 
 * @param {}
 *            zdtype 数据字典的类型
 * @param {}
 *            selectId 选择框的ID
 */
function zdtypeselect(zdtype, selectId) {
	$.ajax({
		type : "POST",
		dataType : "json",
		url : "dd.do?method=getListbyZdtype&zdtype=" + zdtype + "&nowdate="
				+ new Date(),
		success : function(data) {
			$.each(data, function(i, n) {
				var opt = "<option value='" + n.name + "'>" + n.name
						+ "</option>";
				$("#" + selectId).append(opt);
			});
		}
	});
}

/**
 * 
 * @param companytypeflag
 * @param selectId
 */
function compayCodeselect(companytypeflag, selectId) {
	$.ajax({
		type : "POST",
		dataType : "json",
		url : "AdmDept.do?method=getListbyAdmDept&companytypeflag=" + companytypeflag + "&nowdate="
				+ new Date(),
		success : function(data) {
			$.each(data, function(i, n) {
				var opt = "<option value='" + n.companycode + "'>" + n.deptname
						+ "</option>";
				$("#" + selectId).append(opt);
			});
		}
	});
}

/**
 * 投诉选择
 * 
 * @param {}
 *            zdtype 数据字典的类型
 * @param {}
 *            selectId 选择框的ID
 */
function complaintselect(tbtype, typeCode, selectId) {
	$.ajax({
		type : "POST",
		dataType : "json",
		url : "dd.do?method=getListbyZdtype&tbtype=" + tbtype + "&typeCode="
				+ typeCode + "&nowdate=" + new Date(),
		success : function(data) {
			$.each(data, function(i, n) {
				var opt = "<option value='" + n.cnname + "'>" + n.cnname
						+ "</option>";
				$("#" + selectId).append(opt);
			});
		}
	});
}
/**
 * 打开操作选择下拉菜单
 * 
 * @param selectId
 */
function operateselect(tbtype, selectId) {
	$.ajax({
		type : "POST",
		dataType : "json",
		url : "dd.do?method=getoperateselect&tbtype=" + tbtype + "&nowdate="
				+ new Date(),
		success : function(data) {
			$.each(data, function(i, n) {
				var opt = "<option value='" + n.ddid + "'>" + n.cnname
						+ "</option>";
				$("#" + selectId).append(opt);
			});
		}
	});
}
function getinteruname(selectId) {
	$.ajax({
		type : "POST",
		dataType : "json",
		url : "dd.do?method=getInteruname" + "&nowdate=" + new Date(),
		success : function(data) {
			$.each(data, function(i, n) {
				var opt = "<option value='" + n.organizationname + "'>"
						+ n.organizationname + "</option>";
				$("#" + selectId).append(opt);
			});
		}
	});
}
/*
 * 打开模块父类
 */
function showModuleParent(selectId) {
	$.ajax({
		type : "POST",
		dataType : "json",
		url : "module.do?method=showModuleParent" + "&nowdate=" + new Date(),
		success : function(data) {
			$("#" + selectId).find("option").remove();
			var optfirst = "<option value='-1'>新建顶级目录</option>";
			$("#" + selectId).append(optfirst);
			$.each(data, function(i, n) {
				var opt = "<option value='" + n.moduleId + "'>" + n.moduleName
						+ "</option>";
				$("#" + selectId).append(opt);
			});
		}
	});
}
/**
 * 打开模块树
 */
function showModuleTree(selectId) {
	$.ajax({
		type : "POST",
		dataType : "json",
		url : "module.do?method=showModuleTree" + "&nowdate=" + new Date(),
		success : function(data) {
			$.each(data, function(i, n) {

				var opt = "<option value='" + n.moduleId + "'>" + n.moduleName
						+ "</option>";
				$("#" + selectId).append(opt);
			});
		}
	});
}

// validator for mail
$.extend($.fn.validatebox.defaults.rules, {
	mailcheck : {
		validator : function(value) {
			return /^EC\d{9}CN$/.test(value);
		},
		message : "邮件号输入有误"
	}

});
/**
 * 添加信息
 * 
 * @param addTitle
 *            头部信息，以字符串传入(例："邮航N79")
 * @param addForm
 *            表单的id
 * @param addId
 *            div的id(表单父目录)
 * @param addMethod
 *            Action层注解的方法（格式："XX.do?method=addXX"）
 */
function add(addTitle, addForm, addId, addMethod) {
	resetContent(addForm);
	$("#" + addId).show();
	$("#" + addId).dialog({
		title : "添加" + addTitle + "信息",
		modal : true,
		width : 400,
		height : 260,
		minimizable : false,
		maximizable : false,
		buttons : [ {
			text : "添加",
			iconCls : "icon-ok",
			handler : function() {
				$("#" + addForm).form("submit", {
					url : addMethod,
					onSubmit : function() {
						return $(this).form("validate");
					},
					success : function(data) {
						$("#" + addId).dialog("close");
						flashTable("tab");
						showmsg(data);
					}
				});
			}
		}, {
			text : "取消",
			iconCls : "icon-undo",
			handler : function() {
				$("#" + addId).dialog("close");
			}
		} ]
	});
}
/**
 * 删除信息
 * 
 * @param rowId
 *            所选行的id
 * @param delemethod
 *            删除方法（格式："XX.do?method=deleteXX"）
 */
function dele(rowId, delemethod) {
	$.ajax({
		type : "POST",
		dataType : "text",
		url : delemethod + "&nowdate=" + new Date(),
		data : {
			"id" : rowId
		},
		success : function(data) {
			flashTable("tab");
			showmsg(data);
		}
	});
}
/**
 * 支持多选删除，注：表id应该为id
 * @param delemethod
 */
function deleall(delemethod) {
	var ids = [];
	var rows = $("#tab").datagrid("getSelections");
	for ( var i = 0; i < rows.length; i++) {
		ids.push(rows[i].id);
	} 
	$.ajax({
		type : "POST",
		dataType : "text",
		url : delemethod + "&nowdate=" + new Date(),
		data : {
			"entityid" : ids.join(",")
		},
		success : function(data) {
			$.messager.show({
				title : "提示信息",
				msg : data,
				showType : "show",
				timeout : 3000
			});
			flashTable("tab");
		}
	});

}
/**
 * 修改示范
 */
function updateN70(updattitle, updatform, row, updatId, updatMethod) {
	resetContent(updatform);
	$("#N70id").attr("value", row.id);
	$("#N70month").attr("value", row.month);
	$("#N70num").attr("value", row.num);
	$("#N70amount").attr("value", row.amount);
	updat(updattitle, updatform, updatId, updatMethod);
}
/**
 * 修改信息
 * 
 * @param updattitle
 *            修改头部信息，以字符串传入(例："邮航N79")
 * @param updatform
 *            表单的id
 * @param updatId
 *            div的id(表单父目录)
 * @param updatMethod
 *            Action注解的方法（格式："XX.do?method=updateXX"）
 */
function updat(updattitle, updatform, updatId, updatMethod) {
	$("#" + updatId).show();
	$("#" + updatId).dialog({
		title : "修改" + updattitle + "信息",
		modal : true,
		width : 400,
		height : 400,
		minimizable : false,
		maximizable : false,
		buttons : [ {
			text : "修改",
			iconCls : "icon-ok",
			handler : function() {
				$("#" + updatform).form("submit", {
					url : updatMethod,
					onSubmit : function() {
						return $(this).form("validate");
					},
					success : function(data) {
						$("#" + updatId).dialog("close");
						flashTable("tab");
						showmsg(data);
					}
				});
			}
		}, {
			text : "取消",
			iconCls : "icon-undo",
			handler : function() {
				$("#" + updatId).dialog("close");
			}
		} ]
	});
}