package com.zyd.statistics.web.action;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.zyd.statistics.logic.IStatisticsFacade;
import com.zyd.xtgl.domain.vo.TbAdmUser;

public abstract class StatisticsAction {
	public static final String EXPORT_FILE_NAME = "ExporDate:"+Calendar.getInstance().getTimeInMillis();

	/**
	 * 得到拥有希望参数的统计分析结果
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public abstract ModelAndView getStatistics(HttpServletRequest request,
			HttpServletResponse response);

	/**
	 * 当前统计分析页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public abstract ModelAndView toStatisticsMain(HttpServletRequest request,
			HttpServletResponse response);

	/**
	 * 返回数据
	 * 
	 * @param page
	 *            获得页面页码数
	 * @param rows
	 *            行数
	 * @param entityImportReportImpl
	 *            实现IImportReportFacade接口的类
	 * @return 查询条件的Map
	 */
	protected Map<String, Object> getMap(HttpServletRequest request,
			IStatisticsFacade entityImportReportImpl,
			Map<String, String> searchCondition) {
		List<?> list = null;
		// 调用查询方法，返回查询List和查询总条数
		list = entityImportReportImpl.Statistics(searchCondition);
		HttpSession session = request.getSession();
		session.setAttribute("statis", list);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("maps", list.get(0));
		return map;
	}

	/**
	 * 返回数据
	 * 
	 * @param page
	 *            获得页面页码数
	 * @param rows
	 *            行数
	 * @param entityImportReportImpl
	 *            实现IImportReportFacade接口的类
	 * @return 查询条件的Map
	 */
	protected List<?> getList(HttpServletRequest request,
			IStatisticsFacade entityImportReportImpl,
			Map<String, String> searchCondition) {
		List<?> list = null;
		// 调用查询方法，返回查询List和查询总条数
		list = entityImportReportImpl.Statistics(searchCondition);
		return list;
	}

	/**
	 * 用户权限
	 * 
	 * @param request
	 * @param map
	 * @return
	 */
	protected Map<String, String> getDeptCode(HttpServletRequest request,
			Map<String, String> map, String entpsCode) {
		HttpSession session = request.getSession();
		TbAdmUser user = (TbAdmUser) session.getAttribute("user");

		// 通用
		/**
		 * companycode作为筛选用户进入系统后，根据所属公司查看己方信息 当用户所属公司类型为0时，取消这一限制
		 */
		String isLimit = user.getTbadmDept().getCompanytypeflag();
		if (isLimit.equalsIgnoreCase("0")) {
			map.put("entpsCode", null);
		} else {
			entpsCode = user.getTbadmDept().getCompanycode();
			map.put("entpsCode", entpsCode);
		}
		return map;
	}

	/**
	 * 用户权限
	 * 
	 * @param request
	 * @param map
	 * @return
	 */
	protected Map<String, String> getDeptCodeNoKey(HttpServletRequest request,
			Map<String, String> map, String entpsCode, String entpsCodeKey) {
		HttpSession session = request.getSession();
		TbAdmUser user = (TbAdmUser) session.getAttribute("user");

		// 通用
		/**
		 * companycode作为筛选用户进入系统后，根据所属公司查看己方信息 当用户所属公司类型为0时，取消这一限制
		 */
		String isLimit = user.getTbadmDept().getCompanytypeflag();
		if (isLimit.equalsIgnoreCase("0")) {
			map.put(entpsCodeKey, null);
		} else {
			entpsCode = user.getTbadmDept().getCompanycode();
			map.put(entpsCodeKey, entpsCode);
		}
		return map;
	}

}