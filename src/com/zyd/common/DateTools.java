package com.zyd.common;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * 功能描述：日期相关的转换和计�?
 * 
 * @author
 * @since
 */
public class DateTools {

	/**
	 * 获得两时间相差的天数
	 * 
	 * @param g1
	 *            时间1
	 * @param g2
	 *            时间2
	 * @return 时间1与时�?2相差的天�?
	 */
	public int getDays(GregorianCalendar g1, GregorianCalendar g2) {
		int elapsed = 0;
		GregorianCalendar gc1, gc2;

		if (g2.after(g1)) {
			gc2 = (GregorianCalendar) g2.clone();
			gc1 = (GregorianCalendar) g1.clone();
		} else {
			gc2 = (GregorianCalendar) g1.clone();
			gc1 = (GregorianCalendar) g2.clone();
		}

		gc1.clear(Calendar.MILLISECOND);
		gc1.clear(Calendar.SECOND);
		gc1.clear(Calendar.MINUTE);
		gc1.clear(Calendar.HOUR_OF_DAY);

		gc2.clear(Calendar.MILLISECOND);
		gc2.clear(Calendar.SECOND);
		gc2.clear(Calendar.MINUTE);
		gc2.clear(Calendar.HOUR_OF_DAY);

		while (gc1.before(gc2)) {
			gc1.add(Calendar.DATE, 1);
			elapsed++;
		}
		return elapsed - 1;
	}

	/**
	 * 计算与一个日期相差若干天的日�?
	 * 
	 * @param inputDate
	 *            要计算日�?
	 * @param dayNumber
	 *            相差的天数，可以 <0
	 * @return 计算后的日期
	 */
	public static Date intervalDays(Date inputDate, long dayNumber) {
		Date returnDate = new Date();
		long dayMS = 86400000;// һ��ĺ�����?
		long tempMS = 0;

		tempMS = inputDate.getTime();
		tempMS = tempMS + dayNumber * dayMS;

		returnDate.setTime(tempMS);

		return returnDate;
	}

	/**
	 * 把日期字符串转换为具体日�?
	 * 
	 * @param dateString
	 *            要转换的日期字符串，格式：yyyy-MM-dd,如果字符串为""，返回null
	 * @return 转换后的日期
	 */
	public static Date stringToDate(String dateString) {
		Date tempDate = null;

		if (dateString == null)
			return tempDate;
		if (dateString.equals(""))
			return tempDate;

		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			tempDate = dateformat.parse(dateString);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return tempDate;
	}

	/**
	 * 把日期字符串转换为具体日�?
	 * 
	 * @param dateString
	 *            要转换的日期字符串，格式：yyyy-MM-dd,如果字符串为""，返回null
	 * @return 转换后的日期
	 */
	public static Date stringToMonth(String dateString) {
		Date tempDate = null;

		if (dateString == null)
			return tempDate;
		if (dateString.equals(""))
			return tempDate;

		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM");
		try {
			tempDate = dateformat.parse(dateString);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return tempDate;
	}

	/**
	 * 把日期转换为字符�?
	 * 
	 * @param date
	 *            要转换的日期
	 * @return 转换后的字符串，格式"yyyy-MM-dd"
	 */
	public static String dateToString(Date date) {
		String string = "";

		if (date == null)
			return string;

		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		string = dateformat.format(date);

		return string;
	}

	/**
	 * 把日期字符串转换为具体日�?
	 * 
	 * @param dateString
	 *            要转换的日期字符串，格式：yyyy-MM-dd HH:mm:ss,如果字符串为""，返回null
	 * @return 转换后的日期
	 */
	public static Date stringToDatetime(String dateString) {
		Date tempDate = null;

		if (dateString == null)
			return tempDate;
		if (dateString.equals(""))
			return tempDate;

		SimpleDateFormat dateformat = new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		try {
			tempDate = dateformat.parse(dateString);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return tempDate;
	}

	/**
	 * 把日期转换为字符�?
	 * 
	 * @param date
	 *            要转换的日期
	 * @return 转换后的字符串，格式"yyyy-MM-dd HH:mm:ss"
	 */
	public static String datetimeToString(Date date) {
		String string = "";

		if (date == null)
			return string;

		SimpleDateFormat dateformat = new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		string = dateformat.format(date);

		return string;
	}

	/**
	 * 取得当前时间的字符串
	 * 
	 * @return 当前时间的字符串，格�?"yyyy-MM-dd"
	 */

	public static String getToday() {
		String tempString = "";
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			tempString = dateformat.format(new Date());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tempString;
	}

	/**
	 * 取得当前时间的字符串
	 * 
	 * @return 当前时间的字符串，格�?"yyyy-MM-dd"
	 */
	public static String getDay(Date date) {
		String tempString = "";
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			tempString = dateformat.format(date);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tempString;
	}

	/**
	 * 计算指定年月的天数
	 * 传入年份，传入月份-1，即可算出此月有多少天
	 */
	public static int getMonthDays(int year, int month) {
		Calendar c = Calendar.getInstance();
		c.set(Calendar.YEAR, year); // 年
		c.set(Calendar.MONTH, month); // 月
		return c.getActualMaximum(Calendar.DAY_OF_MONTH);
	}
	/**
	 * 获取几天前的时间
	 * 时间格式yyyy-MM-dd
	 * @param beforeDay
	 * @return
	 */
	public static String getByBeforeDay(int beforeDay){
		Calendar   cal1   =   Calendar.getInstance();
        cal1.add(Calendar.DATE,-beforeDay);
        //cal1.set(2000,1,29);
        SimpleDateFormat   sdf   =   new SimpleDateFormat("yyyy-MM-dd");  
        String towDaysBefore = sdf.format(cal1.getTime());
        return towDaysBefore;
	}
}
