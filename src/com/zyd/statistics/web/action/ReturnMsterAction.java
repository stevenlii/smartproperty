package com.zyd.statistics.web.action;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.zyd.common.ExportUtils;
import com.zyd.common.GeneralTools;
import com.zyd.statistics.logic.IStatisticsFacade;
import com.zyd.xtgl.domain.vo.TbAdmUser;

/**
 * 退回寄件人统计
 * 
 * @author li_zq
 * 
 */
@Controller
@RequestMapping(value = "/returnMster")
public class ReturnMsterAction extends StatisticsAction {
	/**
	 * 分析信息
	 */
	@Resource(name = "tdghImpl")
	private IStatisticsFacade tdghImpl;
	@Resource(name = "relationTdghstatisticsImpl")
	private IStatisticsFacade relationTdghstatisticsImpl;

	/**
	 * 退回寄件人统计
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getStatistics")
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
		map = getDeptCode(request, map, entpsCode);
		map.put("MailState", "离开处理中心,发往济南市");
		map.put("groupbycondition", null);
		map.put("statisticscondition",
				"t.Mail_Num,t.Entps_Code,t.Bill_Date,t.Mail_Desc");
		map.put("table", "tb_tdgh");
		List<?> list = getList(request, tdghImpl, map);
		if (list.size() > 0) {
			map.put("MailState", null);
			map.put("MailFailedState", "T除tb_relation_tdgh邮件");
			for (Iterator<?> iterator = list.iterator(); iterator.hasNext();) {
				Object[] objects = (Object[]) iterator.next();
				String mailnum = (String) objects[0];// 邮件号
				map.put("MailNum", mailnum);
				map.put("statisticscondition", "t.mailnum");
				map.put("table", "tb_relation_tdgh");
				List<?> listmul = getList(request, relationTdghstatisticsImpl,
						map);
				if (listmul.size() > 0) {
					iterator.remove();
				}
			}
		}
		request.setAttribute("statis", list);
		request.setAttribute("listsize", list.size());
		ExportUtils.ExportTXT(list, request);
		ExportUtils.ExportEXCEL(list, request);
		list = null;
		return new ModelAndView("reportstatistics/returnmstermain");
	}

	/**
	 * 下载文件方法
	 * 
	 * @param response
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping(params = "method=downfile")
	public void down(HttpServletResponse response, HttpServletRequest request)
			throws Exception {
		String fileallname = request.getSession().getServletContext()
				.getRealPath("\\")
				+ "backfile\\"+request.getSession().getId()+"export.txt";
		File file = new File(fileallname);
		ExportUtils.downFile(response, file, EXPORT_FILE_NAME);
	}

	/**
	 * 导出Excel表
	 * 
	 * @param response
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping(params = "method=downEXCEL")
	public void downEXCEL(HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		String fileallname = request.getSession().getServletContext()
				.getRealPath("\\")
				+ "backfile\\"+request.getSession().getId()+"exportEXCEL.xls";
		File file = new File(fileallname);
		ExportUtils.downFile(response, file, EXPORT_FILE_NAME);
	}

	/**
	 * 统计
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toMain")
	public ModelAndView toStatisticsMain(HttpServletRequest request,
			HttpServletResponse response) {
		return new ModelAndView("reportstatistics/returnmstermain");
	}

}
