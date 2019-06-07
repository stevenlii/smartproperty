package com.zyd.statistics.web.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.zyd.statistics.logic.IStatisticsFacade;

/**
 * 交寄统计
 * 
 * @author li_zq
 * 
 */
@Controller
@RequestMapping(value = "/returnstatisticsbyday")
public class ReturnstatisticsbydayAction extends StatisticsAction {
	/**
	 * 分析信息
	 */
	@Resource(name = "returnStaticsImpl")
	protected IStatisticsFacade returnStaticsImpl;

	/**
	 * 退回数据统计
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getStatistics")
	public ModelAndView getStatistics(HttpServletRequest request,
			HttpServletResponse response) {
		request.removeAttribute("ReturnListByDay");
		Map<String, String> map = new HashMap<String, String>();
		String entpsCode = request.getParameter("entpsCode");// 入网企业
		String StartDate = request.getParameter("StartDate");
		String EndDate = request.getParameter("EndDate");
		map.put("StartDate", StartDate);
		map.put("EndDate", EndDate);
		map = getDeptCode(request, map,entpsCode);
		map.put("groupbycondition", "Return_Date");
		map.put("statisticscondition", "count(DISTINCT t.Mail_Num), t.Return_Date");
		map.put("table", "tb_return");
		List<?> list = getList(request, returnStaticsImpl, map);
		request.setAttribute("ReturnListByDay", list);
		return new ModelAndView("reportstatistics/returnstatisticsbyday");
	}

	@RequestMapping(params = "method=toMain")
	public ModelAndView toStatisticsMain(HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		return new ModelAndView("reportstatistics/returnstatisticsbyday");
	}
}
