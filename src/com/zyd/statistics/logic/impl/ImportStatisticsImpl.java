package com.zyd.statistics.logic.impl;

import java.util.Map;

import com.zyd.statistics.logic.IStatisticsStrategyFacade;

/**
 * 查询抽象类，所有涉及装载数据查询业务的实现类，应该是此抽象类的子类
 * @author li_zq
 * 
 */
public abstract class ImportStatisticsImpl implements IStatisticsStrategyFacade {

	/**
	 * 根据用户查询入网公司条件
	 * 
	 * @param map
	 * @param search
	 * @param companyName
	 * @return
	 */
	protected StringBuffer search_companycode(Map<String, String> map,
			StringBuffer search, String companyName) {
		String companyCode = map.get(companyName);
		if (companyCode != null && !(companyCode.isEmpty())) {
			search.append(" and Entps_Code = '" + companyCode + "'");
		}
		return search;
	}

	/**
	 * billDate 根据结算周期(tbMouth[java.lang.String]:YYMM)查询公共方法
	 * 
	 * @param map
	 * @return
	 */
	protected static StringBuffer search_YYMM_String(StringBuffer search,
			Map<String, String> map) {
		String StartDate = map.get("StartDate");// 日期
		String EndDate = map.get("EndDate");
		if ((StartDate != null && !(StartDate.equals("")))
				|| (EndDate != null && !(EndDate.equals("")))) {
			// 两个 都不为空
			if ((StartDate != null && !(StartDate.equals("")))
					&& (EndDate != null && !(EndDate.equals("")))) {
				search.append(" and t.tbMouth  >= '" + StartDate
						+ "'  AND t.tbMouth <= '" + EndDate + "'");
				// 首日期为空且末端日期不为空
			} else if ((StartDate == null || (StartDate.equals("")))
					&& (EndDate != null && !(EndDate.equals("")))) {
				search.append(" and  <= '" + EndDate + "'");
				// 首日期不为空且末端日期为空
			} else if ((StartDate != null && !(StartDate.equals("")))
					&& (EndDate == null || (EndDate.equals("")))) {
				search.append(" and t.tbMouth >= '" + StartDate + "'");
			}
		}
		return search;
	}

	/**
	 * billDate 根据结算周期(tbMouth[java.lang.String]:YYMM)查询公共方法
	 * 
	 * @param map
	 * @return
	 */
	protected static StringBuffer search_YYMM_String(StringBuffer search,
			String yymmdd, String StartDate, String EndDate) {
		if ((StartDate != null && !(StartDate.equals("")))
				|| (EndDate != null && !(EndDate.equals("")))) {
			// 两个 都不为空
			if ((StartDate != null && !(StartDate.equals("")))
					&& (EndDate != null && !(EndDate.equals("")))) {
				search.append(" and t." + yymmdd + "  >= '" + StartDate
						+ "'  AND t." + yymmdd + "  <= '" + EndDate + "'");
				// 首日期为空且末端日期不为空
			} else if ((StartDate == null || (StartDate.equals("")))
					&& (EndDate != null && !(EndDate.equals("")))) {
				search.append(" and t." + yymmdd + "  <= '" + EndDate + "'");
				// 首日期不为空且末端日期为空
			} else if ((StartDate != null && !(StartDate.equals("")))
					&& (EndDate == null || (EndDate.equals("")))) {
				search.append(" and t." + yymmdd + "  >= '" + StartDate + "'");
			}
		}
		return search;
	}

	/**
	 * 根据结算周期(billDate[java.util.Date:YY-MM-dd])查询公共方法 日期字段手动传递
	 * 
	 * @param map
	 * @return
	 */
	protected static StringBuffer search_YYMMDD_Date(StringBuffer search,
			String yymmdd, Map<String, String> map) {
		String StartDate = map.get("StartDate");// 日期
		String EndDate = map.get("EndDate");
		search.append("");
		if ((StartDate != null && !(StartDate.equals("")))
				|| (EndDate != null && !(EndDate.equals("")))) {
			// 两个 都不为空
			if ((StartDate != null && !(StartDate.equals("")))
					&& (EndDate != null && !(EndDate.equals("")))) {
				search.append(" and DATE_FORMAT(t." + yymmdd
						+ ",'%Y-%m-%d')  >= '" + StartDate
						+ "'  AND DATE_FORMAT(t." + yymmdd + ",'%Y-%m-%d')<='"
						+ EndDate + "'");
				// 首日期为空且末端日期不为空
			} else if ((StartDate == null || (StartDate.equals("")))
					&& (EndDate != null && !(EndDate.equals("")))) {
				search.append(" and DATE_FORMAT(t." + yymmdd
						+ ",'%Y-%m-%d')<='" + EndDate + "'");
				// 首日期不为空且末端日期为空
			} else if ((StartDate != null && !(StartDate.equals("")))
					&& (EndDate == null || (EndDate.equals("")))) {
				search.append(" and DATE_FORMAT(t." + yymmdd
						+ ",'%Y-%m-%d')  >= '" + StartDate + "'");
			}
		}

		return search;
	}

	/**
	 * 根据结算周期(billDate[java.util.Date:YY-MM-dd])查询公共方法 日期字段默认为：billDate
	 * 
	 * @param map
	 * @return
	 */
	protected static StringBuffer search_YYMMDD_Date(StringBuffer search,
			Map<String, String> map) {
		String StartDate = map.get("StartDate");// 日期
		String EndDate = map.get("EndDate");
		search.append("");
		if ((StartDate != null && !(StartDate.equals("")))
				|| (EndDate != null && !(EndDate.equals("")))) {
			// 两个 都不为空
			if ((StartDate != null && !(StartDate.equals("")))
					&& (EndDate != null && !(EndDate.equals("")))) {
				search.append(" and DATE_FORMAT(t.billDate,'%Y-%m-%d')  >= '"
						+ StartDate
						+ "'  AND DATE_FORMAT(t.billDate,'%Y-%m-%d')<='"
						+ EndDate + "'");
				// 首日期为空且末端日期不为空
			} else if ((StartDate == null || (StartDate.equals("")))
					&& (EndDate != null && !(EndDate.equals("")))) {
				search.append(" and DATE_FORMAT(t.billDate,'%Y-%m-%d')<='"
						+ EndDate + "'");
				// 首日期不为空且末端日期为空
			} else if ((StartDate != null && !(StartDate.equals("")))
					&& (EndDate == null || (EndDate.equals("")))) {
				search.append(" and DATE_FORMAT(t.billDate,'%Y-%m-%d')  >= '"
						+ StartDate + "'");
			}
		}

		return search;
	}

	/**
	 * 根据结算周期(billDate[java.util.Date:YY-MM-dd])查询公共方法
	 * 
	 * @param yymmdd
	 *            日期字段手动传递
	 * @param StartDate
	 *            开始时候
	 * @param EndDate
	 *            结束时间
	 * @return
	 */
	protected static StringBuffer search_YYMMDD_Date(StringBuffer search,
			String yymmdd, String StartDate, String EndDate) {
		search.append("");
		if ((StartDate != null && !(StartDate.equals("")))
				|| (EndDate != null && !(EndDate.equals("")))) {
			// 两个 都不为空
			if ((StartDate != null && !(StartDate.equals("")))
					&& (EndDate != null && !(EndDate.equals("")))) {
				search.append(" and DATE_FORMAT(t." + yymmdd
						+ ",'%Y-%m-%d')  >= '" + StartDate
						+ "'  AND DATE_FORMAT(t." + yymmdd + ",'%Y-%m-%d')<='"
						+ EndDate + "'");
				// 首日期为空且末端日期不为空
			} else if ((StartDate == null || (StartDate.equals("")))
					&& (EndDate != null && !(EndDate.equals("")))) {
				search.append(" and DATE_FORMAT(t." + yymmdd
						+ ",'%Y-%m-%d')<='" + EndDate + "'");
				// 首日期不为空且末端日期为空
			} else if ((StartDate != null && !(StartDate.equals("")))
					&& (EndDate == null || (EndDate.equals("")))) {
				search.append(" and DATE_FORMAT(t." + yymmdd
						+ ",'%Y-%m-%d')  >= '" + StartDate + "'");
			}
		}

		return search;
	}

	/**
	 * 根据表类名和表类型返回相关查询对象
	 * 
	 * @param map
	 * @return
	 */
	protected static StringBuffer search_TbName_TbType(Map<String, String> map) {
		StringBuffer search = new StringBuffer();
		search.append("");
		String tbType = map.get("tbType");// 表型
		String tbName = map.get("tbName");// 表来源名
		if (tbType != null && !(tbType.equals(""))) {
			search.append(" and tbType = '" + tbType + "'");
		}
		if (tbName != null && !(tbName.isEmpty())) {
			search.append(" and tbName= '" + tbName + "'");
		}
		return search;
	}

	

}
