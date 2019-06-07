package com.zyd.statistics.web.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.zyd.common.GeneralTools;
import com.zyd.statistics.logic.IStatisticsFacade;
import com.zyd.xtgl.domain.vo.TbAdmUser;

/**
 * 交寄统计
 * 
 * @author li_zq
 * 
 */
@Controller
@RequestMapping(value = "/statistics")
public class MailPostAction extends StatisticsAction {
	/**
	 * 分析信息
	 */
	@Resource(name = "mailPostStaticsImpl")
	protected IStatisticsFacade mailPostStaticsImpl;

	/**
	 * 交寄统计[交寄邮件统计
	 * 
	 * 按邮购公司统计 ]
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getMailPostList")
	public ModelAndView getStatistics(HttpServletRequest request,
			HttpServletResponse response) {
		request.removeAttribute("statis");
		HttpSession session = request.getSession();
		TbAdmUser user = (TbAdmUser) session.getAttribute("user");
		Map<String, String> map = new HashMap<String, String>();
		/**
		 * companycode作为筛选用户进入系统后，根据所属公司查看己方信息 当用户所属公司类型为0时，取消这一限制
		 */
		String isLimit = user.getTbadmDept().getCompanytypeflag();
		if (isLimit.equalsIgnoreCase("0")) {
			//邮局用户具体能查看哪些入网公司信息
			map.put("chakan_company", GeneralTools.getUserToComCode(user.getAccessCompany()));
		} else {
			String companyCode = user.getTbadmDept().getCompanycode();
			map.put("entpsCode", companyCode);
		}
		String entpsCode = request.getParameter("entpsCode");// 邮件号
		String StartDate = request.getParameter("StartDate");
		String EndDate = request.getParameter("EndDate");
		map.put("StartDate", StartDate);
		map.put("EndDate", EndDate);
		map = getDeptCode(request, map,entpsCode);
		map.put("groupbycondition", "Entps_Code");
		map.put("statisticscondition",
				"count(DISTINCT t.Mail_Num), SUM(t.In_Amount),t.Weight,t.Fee");
		map.put("table", "tb_mail_post");
		List<?> list = getList(request, mailPostStaticsImpl, map);
		request.setAttribute("statis", list);
		map.clear();
		map.put("groupbycondition", null);
		map.put("StartDate", StartDate);
		map.put("EndDate", EndDate);
		map.put("entpsCode", entpsCode);
		map.put("statisticscondition", "count(DISTINCT t.Mail_Num), SUM(t.In_Amount)");
		map.put("table", "tb_mail_post");
		List<?> listall = getList(request, mailPostStaticsImpl, map);
		request.setAttribute("listall", listall);
		return new ModelAndView("reportstatistics/mailpoststatistics");
	}

	/**
	 * 交寄
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=tomailpoststatisticsMain")
	public ModelAndView toStatisticsMain(HttpServletRequest request,
			HttpServletResponse response) {

		return new ModelAndView("reportstatistics/mailpoststatistics");
	}
}
