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
@RequestMapping(value = "/mailPostListByDay")
public class MailPostListByDayAction extends StatisticsAction {
	/**
	 * 分析信息
	 */
	@Resource(name = "mailPostStaticsImpl")
	protected IStatisticsFacade mailPostStaticsImpl;


	/**
	 * 交寄统计[入网企业按天统计]
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getStatistics")
	public ModelAndView getStatistics(HttpServletRequest request,
			HttpServletResponse response) {
		request.removeAttribute("MailPostListByDay");
		Map<String, String> map = new HashMap<String, String>();
		String entpsCode = request.getParameter("entpsCode");// 邮件号
		String StartDate = request.getParameter("StartDate");
		String EndDate = request.getParameter("EndDate");
		map.put("StartDate", StartDate);
		map.put("EndDate", EndDate);
		map = getDeptCode(request, map,entpsCode);
		map.put("groupbycondition", "Post_Date");
		map.put("statisticscondition",
				"count(DISTINCT t.Mail_Num), SUM(t.In_Amount),t.Weight,t.Fee");
		map.put("table", "tb_mail_post");
		List<?> list = getList(request, mailPostStaticsImpl, map);
		request.setAttribute("MailPostListByDay", list);
		map.put("groupbycondition", null);
		map.put("statisticscondition", "count(DISTINCT t.Mail_Num), SUM(t.In_Amount)");
		List<?> listall = getList(request, mailPostStaticsImpl, map);
		request.setAttribute("listall", listall);
		return new ModelAndView("reportstatistics/mailpoststatisticsbyday");
	}

	/**
	 * 交寄
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toMain")
	public ModelAndView toStatisticsMain(HttpServletRequest request,
			HttpServletResponse response) {

		return new ModelAndView("reportstatistics/mailpoststatisticsbyday");
	}
}
