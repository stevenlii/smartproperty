var uploadSizeLimit = 314572800; // 300M
function importreport(inputid, tbtype, method, fileqid, addid) {
	$("#" + inputid).uploadify({
		'uploader' : 'uploadify/uploadify.swf?newdate=' + new Date(),
		'script' : tbtype + '.do?method=' + method + "&nowdate=" + new Date(),// 后台处理的请求
		'cancelImg' : 'uploadify/cancel.png',
		'fileDataName' : 'myfile',// 服务器端根据这个接收文件
		'sizeLimit' : uploadSizeLimit, // 限制上传的大小
		'queueID' : fileqid,// 与下面的id对应
		'queueSizeLimit' : 1,
		'fileExt' : '*.xls;*.xlsx;*.txt;', // '*.*'表示所有类型的文件
		'fileDesc' : '请选择文件(*.xls,*.xlsx,*.txt)', // 控制可上传文件的扩展名，启用本项时需同时声明fileDesc
		'auto' : false,
		'multi' : false,
		'simUploadLimit' : 1,
		'buttonText' : '选择文件',
		onProgress : function(event, queueId, fileObj, data) {
			var msg = '数据上传中...,请耐心等待.....';
			parent.showmask(msg);
		},
		onSelect : function(event, queueID, fileObj) {
			var size = parseInt(fileObj.size);
			if (size > uploadSizeLimit) {
				$.messager.alert("警告信息", "对不起，文件大小超过限制，请重新选择", "info");
				return false;
			} else if (size < 1) {
				$.messager.alert("警告信息", "请选择文件后点击上传按钮", "info");
				return false;
			}
		},
		onError : function(event, queueID, fileObj, errorObj) {
			$("#" + addid).dialog("close");
			parent.hidemask();
			showmsg("上传失败" + errorObj.info + "错误类型" + errorObj.type);
		},
		onComplete : function(event, queueID, fileObj, response, data) {
			$("#" + addid).dialog("close");
			parent.hidemask();
			flashTable("tab");
			showmsg(response);
		}
	});
}
/**
 * 删除方法
 */

function deleTbName(delmethod, tbName, tbType) {
	if (null == tbType) {
		tbType = "";
	}
	$.ajax({
		type : "POST",
		dataType : "text",
		url : delmethod + "&nowdate=" + new Date(),
		data : {
			"confirmOk" : "notok",
			"tbName" : tbName,
			"tbType" : tbType
		},
		success : function(data) {
			if (data == "delconfirm") {
				// where real delete
				$.messager.confirm('删除数据和文件确认', '确定删除表 <font color="red">'
						+ tbName
						+ '</font>  的相关数据和后台备份文件吗?<BR/> 删除的数据和文件不可恢复!!!',
						function(ok) {
							if (ok) {

								$.ajax({
									type : "POST",
									dataType : "text",
									url : delmethod + "&nowdate=" + new Date(),
									data : {
										"confirmOk" : "ok",
										"tbName" : tbName,
										"tbType" : tbType
									},
									success : function(data) {
										flashTable("tab");
										showmsg(data);
									}
								});
							}
						});
			} else if (data == "deldate") {
				// where real delete
				$.messager.confirm('删除数据确认', '确定删除表 <font color="red">'
						+ tbName + '</font>  的相关数据吗?<BR/> 删除的数据不可恢复!!!',
						function(ok) {
							if (ok) {

								$.ajax({
									type : "POST",
									dataType : "text",
									url : delmethod + "&nowdate=" + new Date(),
									data : {
										"confirmOk" : "ok",
										"tbName" : tbName,
										"tbType" : tbType
									},
									success : function(data) {
										flashTable("tab");
										showmsg(data);
									}
								});
							}
						});
			} else if (data == "delfile") {
				// where real delete
				$.messager.confirm('删除文件确认', '确定删除表 <font color="red">'
						+ tbName + '</font>  的后台备份文件吗?<BR/> 删除的文件不可恢复!!!',
						function(ok) {
							if (ok) {

								$.ajax({
									type : "POST",
									dataType : "text",
									url : delmethod + "&nowdate=" + new Date(),
									data : {
										"confirmOk" : "ok",
										"tbName" : tbName,
										"tbType" : tbType
									},
									success : function(data) {
										flashTable("tab");
										showmsg(data);
									}
								});
							}
						});
			} else {
				flashTable("tab");
				showmsg(data);
			}

		}
	});

}
function collecthper(collect, delemethod) {
	$.ajax({
		type : "POST",
		dataType : "text",
		url : delemethod + "&nowdate=" + new Date(),
		data : {
			"collectmailnum" : collect
		},
		success : function(data) {
			$.messager.show({
				title : "提示信息",
				msg : data,
				showType : "show",
				timeout : 3000
			});
			flashTable("tab");
			showmsg(data);
		}
	});
}
// for check date
function _validateFileAndDate(uploaId, filedate) {
	if ($("#" + filedate).val() == "") {
		showmsg("请选择文件时间");
		return false;
	} else if (!$("#" + uploaId).children().size() == 1) {
		showmsg("请选择上传文件");
		return false;
	}
}