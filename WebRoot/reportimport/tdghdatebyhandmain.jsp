<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>投递信息采集按照日期</title>
		<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript" src="jeasyui/jquery.easyui.min.js"></script>
		<script type="text/javascript"
			src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="js/common.js"></script>
		<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css" href="css/sys.css">
		<link rel="stylesheet" type="text/css"
			href="jeasyui/themes/default/easyui.css" />
		<link rel="stylesheet" type="text/css" href="jeasyui/themes/icon.css" />
		<script type="text/javascript" src="js/import.js"></script>
		<script type="text/javascript" src="js/mask.js"></script>
		<script type="text/javascript">
		function tdsubmit(){
			var starttime = $("#starttime").val();
			var endtime = $("#endtime").val();
			var t_day = compareDate(starttime,endtime);
			if(starttime>'2012-03-01'&&endtime<'2012-07-01'){
					if(t_day<=4){
						tdjg();
					}else{
						$.messager.show({
							title : "提示信息",
							msg : "日期间隔太大，只能采集间隔为四天的数据。",
							showType : "show",
							timeout : 3000
						});
					}
			}else{
				$.messager.show({
					title : "提示信息",
					msg : "请选择2012-03-01到2012-07-01的日期",
					showType : "show",
					timeout : 3000
				});
			}
		}
		function  tdjg(){
		$("#tishi").show();
		$.ajax({
			type : "POST",
			dataType : "text",
			url : "input.do?method=getTdByHand" + "&nowdate=" + new Date(),
			data : {
				"starttime" : $("#starttime").val(),
				"endtime" : $("#endtime").val()
			},
			success : function(data) {
			}
		});
		}
		
		//判断年份是否是闰年

		function isLeapYear(year){
		if(year % 4 == 0 && ((year % 100 != 0) || (year % 400 == 0)))
		{
		     return true;
		}
		return false;
		}
		//判断前后两个日期
		function validatePeriod(fyear,fmonth,fday,byear,bmonth,bday){
		if(fyear < byear){
		return true;
		}else if(fyear == byear){
		if(fmonth < bmonth){
		   return true;
		} else if (fmonth == bmonth){
		   if(fday <= bday){
		    return true;
		   }else {
		    return false;
		   }
		} else {
		   return false;
		}
		}else {
		return false;
		}
		}
		function compareDate(starttime,endtime)
		{
		    var regexp=/^(\d{1,4})[-|\.]{1}(\d{1,2})[-|\.]{1}(\d{1,2})$/;
		    var monthDays=[0,3,0,1,0,1,0,0,1,0,0,1];
		    regexp.test(starttime);
		    var date1Year=RegExp.$1;
		    var date1Month=RegExp.$2;
		    var date1Day=RegExp.$3;

		    regexp.test(endtime);
		    var date2Year=RegExp.$1;
		    var date2Month=RegExp.$2;
		    var date2Day=RegExp.$3;

		if(validatePeriod(date1Year,date1Month,date1Day,date2Year,date2Month,date2Day)){
		firstDate=new Date(date1Year,date1Month,date1Day);
		     secondDate=new Date(date2Year,date2Month,date2Day);

		     result=Math.floor((secondDate.getTime()-firstDate.getTime())/(1000*3600*24));
		     for(j=date1Year;j<=date2Year;j++){
		         if(isLeapYear(j)){
		             monthDays[1]=2;
		         }else{
		             monthDays[1]=3;  
		         }
		         for(i=date1Month-1;i<date2Month;i++){
		             result=result-monthDays[i];
		         }
		     }
		     return result;
		}else{
		return 'the first field must before the second date.';
		}
		}

		</script>
	</head>

	<body style="background-color: #D8E8F8;">
		<div align="center" style="margin-top: 100px;">
			<form action="" method="post" id="tdghform" name="tdghform">
				<div align="center">
					按照日期采集投递结果
				</div>
				<table style="text-align: center;">
					<tr>
						<td align="right">
							日期:
						</td>
						<td>
							<input style="width: 150px;" type="text" name="starttime"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
								readonly="readonly" id="starttime" value="" />
							--
							<input style="width: 150px;" type="text" name="endtime"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"
								readonly="readonly" id="endtime" value="" />
						</td>
					<tr>
						<td></td>
						<td>
							<input id="tdbyhand_date" type="button" value="开始采集"
								onclick="tdsubmit();" />
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div align="center" style="display: none; color: red;" id="tishi">
		网络获取数据需要一段时间，建议你提交后去完成其他工作。等待一段时间后，去综合查询中获取查询结果。
		</div>
	</body>
</html>