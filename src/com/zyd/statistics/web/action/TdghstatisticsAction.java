package com.zyd.statistics.web.action;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.zyd.common.ExportUtils;
import com.zyd.statistics.logic.IStatisticsFacade;

/**
 * 投递邮件统计
 * 
 * @author li_zq
 * 
 */
@Controller
@RequestMapping(value = "/tdghstatisticsAction")
public class TdghstatisticsAction extends StatisticsAction {
	@Resource(name = "relationTdghstatisticsImpl")
	private IStatisticsFacade relationTdghstatisticsImpl;
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
		return new ModelAndView("reportstatistics/tdghstatistics");
	}

	/**
	 * 投递邮件统计
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getStatistics")
	public ModelAndView getStatistics(HttpServletRequest request,
			HttpServletResponse response) {
		request.removeAttribute("listall");
		Map<String, String> map = new HashMap<String, String>();
		String entpsCode = request.getParameter("entpsCode");// 入网企业代码
		String StartDate = request.getParameter("StartDate");
		String EndDate = request.getParameter("EndDate");
		String mailNum = request.getParameter("mailNum");// 邮件号码
		map.put("StartDate", StartDate);
		map.put("EndDate", EndDate);
		map = getDeptCode(request, map, entpsCode);
		map.put("entpsCode", entpsCode);
		map.put("MailNum", mailNum);
		map.put("statisticscondition",
				"t.mailnum, t.Entps_Code,t.tdfinishedtime,t.portrayal,t.tdfinished");
		map.put("table", "tb_relation_tdgh");
		List<?> list = getList(request, relationTdghstatisticsImpl, map);
		request.setAttribute("listall", list);
		request.setAttribute("listsize", list.size());
		ExportUtils.ExportTXT(list, request);
		ExportUtils.ExportEXCEL(list, request);
		list=null;
		return new ModelAndView("reportstatistics/tdghstatistics");
	}
	/**
	 * 下载文件方法
	 * @param response
	 * @param request
	 * @throws Exception785 529 
	 */
	@RequestMapping(params = "method=downfile")
	public void  down(HttpServletResponse response,HttpServletRequest request)throws Exception {
		String fileallname = request.getSession().getServletContext()
				.getRealPath("\\")
				+ "backfile\\"+request.getSession().getId()+"export.txt";
		File file = new File(fileallname);
		ExportUtils.downFile(response, file, EXPORT_FILE_NAME);
	}
	/**
	 * 导出Excel表
	 * @param response
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping(params = "method=downEXCEL")
	public void  downEXCEL(HttpServletResponse response,HttpServletRequest request)throws Exception {
		String fileallname = request.getSession().getServletContext()
				.getRealPath("\\")
				+ "backfile\\"+request.getSession().getId()+"exportEXCEL.xls";
		File file = new File(fileallname);
		ExportUtils.downFile(response, file, EXPORT_FILE_NAME);
	}

}
