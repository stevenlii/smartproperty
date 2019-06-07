$(function() {
	var _menus;
	 $.ajax({
						    type: "POST",
						    dataType: "json",
						    url: "login.do?method=getMenu&nowdate=" + new Date(),
						    success: function(data){
						    	_menus = data;
						    	InitLeftMenu(_menus);
							}
							});
			tabClose();
			tabCloseEven();
		});
// 初始化左侧
function InitLeftMenu(_menus) {
	$("#nav").accordion({
				animate : false
			});
	$.each(_menus.menus, function(i, n) {
		var menulist = '';
		menulist += '<ul>';
		$.each(n.menus, function(j, o) {
			menulist += '<li><div><a ref="'
					+ o.moduleId
					+ '" href="#" rel="'
					+ o.moduleUrl
					+ '" ><span class="icon icon-nav" >&nbsp;</span><span class="nav">'
					+ o.moduleName + '</span></a></div></li> ';
		});
		menulist += '</ul>';
		$('#nav').accordion('add', {
					title : n.moduleName,
					content : menulist,
					iconCls : 'icon icon-nav'
				});

	});

	$('.easyui-accordion li a').click(function() {
				var tabTitle = $(this).children('.nav').text();

				var url = $(this).attr("rel");
				var moduleId = $(this).attr("ref");

				addTab(tabTitle, url);
				$('.easyui-accordion li div').removeClass("selected");
				$(this).parent().addClass("selected");
			}).hover(function() {
				$(this).parent().addClass("hover");
			}, function() {
				$(this).parent().removeClass("hover");
			});

	// 选中第一个
	var panels = $('#nav').accordion('panels');
	var t = panels[0].panel('options').title;
	$('#nav').accordion('select', t);
}

function addTab(subtitle, url) {
		var alltab = $('.tabs-inner');//判断tab多少，>10提示用户
			if (!$('#tabs').tabs('exists', subtitle)) {
				if(alltab.length<9){
					$('#tabs').tabs('add', {
								title : subtitle,
								content : createFrame(url),
								closable : true,
								icon : 'icon icon-nav'
							});
					}else{
						$.messager.alert('提示', '打开标签太多，请关闭不使用的标签~~', 'info');
					}
			} else {
				$('#tabs').tabs('select', subtitle);
				$('#mm-tabupdate').click();
			}
			tabClose();
}

function createFrame(url) {
	var s = '<iframe scrolling="auto" frameborder="0"  src="' + url
			+ '" style="width:100%;height:100%;"></iframe>';
	return s;
}

function tabClose() {
	/* 双击关闭TAB选项卡 */
	$(".tabs-inner").dblclick(function() {
				var subtitle = $(this).children(".tabs-closable").text();
				$('#tabs').tabs('close', subtitle);
			});
	/* 为选项卡绑定右键 */
	$(".tabs-inner").bind('contextmenu', function(e) {
				$('#mm').menu('show', {
							left : e.pageX,
							top : e.pageY
						});

				var subtitle = $(this).children(".tabs-closable").text();

				$('#mm').data("currtab", subtitle);
				$('#tabs').tabs('select', subtitle);
				return false;
			});
}
// 绑定右键菜单事件
function tabCloseEven() {
	// 刷新
	$('#mm-tabupdate').click(function() {
				var currTab = $('#tabs').tabs('getSelected');
				var url = $(currTab.panel('options').content).attr('src');
				$('#tabs').tabs('update', {
							tab : currTab,
							options : {
								content : createFrame(url)
							}
						});
			});
	// 关闭当前
	$('#mm-tabclose').click(function() {
				var currtab_title = $('#mm').data("currtab");
				$('#tabs').tabs('close', currtab_title);
			});
	// 全部关闭
	$('#mm-tabcloseall').click(function() {
				$('.tabs-inner span').each(function(i, n) {
							var t = $(n).text();
							$('#tabs').tabs('close', t);
						});
			});
	// 关闭除当前之外的TAB
	$('#mm-tabcloseother').click(function() {
				var nextall = $('.tabs-selected').nextAll();
				var prevall = $('.tabs-selected').prevAll();
				if (nextall.length == 0) {
					$('#mm-tabcloseleft').click();
				} else if (prevall.length == 0) {
					$('#mm-tabcloseright').click();
				} else {
					$('#mm-tabcloseright').click();
					$('#mm-tabcloseleft').click();
				}
			});
	// 关闭当前右侧的TAB
	$('#mm-tabcloseright').click(function() {
				var nextall = $('.tabs-selected').nextAll();
				if (nextall.length == 0) {
					$.messager.alert('提示', '到头了，后边没有啦~~', 'info');
					return false;
				}
				nextall.each(function(i, n) {
							var t = $('a:eq(0) span', $(n)).text();
							$('#tabs').tabs('close', t);
						});
				return false;
			});
	// 关闭当前左侧的TAB
	$('#mm-tabcloseleft').click(function() {
				var prevall = $('.tabs-selected').prevAll();
				if (prevall.length == 0) {
					$.messager.alert('提示', '到头了，前边没有啦~~', 'info');
					return false;
				}
				prevall.each(function(i, n) {
							var t = $('a:eq(0) span', $(n)).text();
							$('#tabs').tabs('close', t);
						});
				return false;
			});

	// 退出
	$("#mm-exit").click(function() {
				$('#mm').menu('hide');
			});
}
