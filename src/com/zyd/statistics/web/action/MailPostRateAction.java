package com.zyd.statistics.web.action;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Iterator;
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
 * 妥投率
 * 
 * @author li_zq
 * 
 */
@Controller
@RequestMapping(value = "/MailPostRate")
public class MailPostRateAction extends StatisticsAction {
	/**
	 * 分析信息
	 */
	@Resource(name = "statisticsMailFaildImpl")
	private IStatisticsFacade statisticsMailFaildImpl;
	@Resource(name = "mailPostStaticsImpl")
	protected IStatisticsFacade mailPostStaticsImpl;
	@Resource(name = "relationTdghstatisticsImpl")
	protected IStatisticsFacade relationTdghstatisticsImpl;

	/**
	 * 妥设率统计[妥设率邮件统计
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getStatistics")
	public ModelAndView getStatistics(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, String> map = new HashMap<String, String>();
		String entpsCode = request.getParameter("entpsCode");// 邮件号

		map = getDeptCode(request, map, entpsCode);

		request.removeAttribute("statis");
		String StartDate = request.getParameter("StartDate");
		String EndDate = request.getParameter("EndDate");
		map.put("StartDate", StartDate);
		map.put("EndDate", EndDate);

		map.put("groupbycondition", " t.tbmailPost.entpsCode ");
		map.put("statisticscondition", " count(t.tbmailPost.mailNum) ");
		map.put("queryCondition", " and t.tbmailPost.postDate > '" + StartDate
				+ "' and t.tbmailPost.postDate < '" + EndDate + "'");
		List<?> MailPostlist = getList(request, statisticsMailFaildImpl, map);

		map.put("MailState", "妥投");
		map.put("statisticscondition", "count( t.tbTdgh.mailnum)");
		map.put("queryCondition", " and t.tbmailPost.postDate > '" + StartDate
				+ "' and t.tbmailPost.postDate < '" + EndDate
				+ "' and t.tbTdgh.tdfinished like '妥投'");
		List<?> RelationtdghSuccess = getList(request, statisticsMailFaildImpl,
				map);

		map.put("MailState", "退回");
		map.put("queryCondition", " and t.tbmailPost.postDate > '" + StartDate
				+ "' and t.tbmailPost.postDate < '" + EndDate
				+ "' and t.tbTdgh.tdfinished like '退回'");
		List<?> RelationtdghFailed = getList(request, statisticsMailFaildImpl,
				map);

		Map<String, Double> rate = new HashMap<String, Double>();
		Map<String, Double> rateFailed = new HashMap<String, Double>();
		DecimalFormat twopoint = new DecimalFormat("######0.00"); // 两位小数转换
		for (Iterator<?> iterator = MailPostlist.iterator(); iterator.hasNext();) {
			Object[] objects = (Object[]) iterator.next();
			String dept = (String) objects[0];// 公司
			double mailcount = new Double((Long) objects[1]);// 邮件数目
			// 妥投
			for (Iterator<?> iteratorRelation = RelationtdghSuccess.iterator(); iteratorRelation
					.hasNext();) {
				Object[] objectsRelation = (Object[]) iteratorRelation.next();
				String deptRelation = (String) objectsRelation[0];// 公司
				double relateioncount = new Double((Long) objectsRelation[1]);// 邮件数目
				if (dept.equalsIgnoreCase(deptRelation)) {
					double rateSuccess = (relateioncount / mailcount) * 100;
					rate.put(dept, new Double(twopoint.format(rateSuccess)));
				}
			}
			// 退回
			for (Iterator<?> iteratorRelationReturn = RelationtdghFailed
					.iterator(); iteratorRelationReturn.hasNext();) {
				Object[] objectsRelation = (Object[]) iteratorRelationReturn
						.next();
				String deptRelation = (String) objectsRelation[0];// 公司
				double relateioncount = new Double((Long) objectsRelation[1]);// 邮件数目
				if (dept.equalsIgnoreCase(deptRelation)) {
					double rateReturn = (relateioncount / mailcount) * 100;
					rateFailed.put(dept,
							new Double(twopoint.format(rateReturn)));
				}
			}

		}
		request.setAttribute("statis", MailPostlist);// 提供公司代码
		request.setAttribute("statis", rate);
		request.setAttribute("statisReturn", rateFailed);
		return new ModelAndView("reportstatistics/mailpostrate");
	}

	/**
	 * 妥设率
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toMain")
	public ModelAndView toStatisticsMain(HttpServletRequest request,
			HttpServletResponse response) {
		return new ModelAndView("reportstatistics/mailpostrate");
	}
}
