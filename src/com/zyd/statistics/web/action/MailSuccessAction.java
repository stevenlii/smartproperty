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
 * 妥投邮件结算统计
 * 
 * @author li_zq
 * 
 */
@Controller
@RequestMapping(value = "/mailSuccessAction")
public class MailSuccessAction extends StatisticsAction {
	/**
	 * 分析信息
	 */
	@Resource(name = "mailSuccessStaticsImpl")
	protected IStatisticsFacade mailSuccessStaticsImpl;
	/**
	 * 妥投邮件结算统计
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getStatistics")
	public ModelAndView getStatistics(HttpServletRequest request,
			HttpServletResponse response) {
		request.removeAttribute("statis");
		Map<String, String> map = new HashMap<String, String>();
		String Infe_tonet_Code = request.getParameter("Infe_tonet_Code");// 入网企业代码
		String StartDate = request.getParameter("StartDate");
		String EndDate = request.getParameter("EndDate");
		String BillMailTypes = request.getParameter("BillMailTypes");// 结算邮件类型标识
		map.put("StartDate", StartDate);
		map.put("EndDate", EndDate);
		map = getDeptCodeNoKey(request, map,Infe_tonet_Code,"Infe_tonet_Code");
		map.put("BillMailTypes", BillMailTypes);
		map.put("table", "tb_finance");
		map.put("groupbycondition", "Infe_tonet_Code");
		map.put("statisticscondition",
				"count(DISTINCT t.Mail_Num), SUM(t.Svice_Fee), SUM(t.Set_Fee), SUM(t.Return_Fee), SUM(t.Total), SUM(t.Bill_Fee), SUM(t.Bill_blace)");
		List<?> list = getList(request, mailSuccessStaticsImpl, map);
		request.setAttribute("statis", list);
		ExportUtils.ExportTXT(list, request);
		ExportUtils.ExportEXCEL(list, request);
		map.put("groupbycondition", null);
		List<?> listall = getList(request, mailSuccessStaticsImpl, map);
		request.setAttribute("listall", listall);
		return new ModelAndView("reportstatistics/mailsuccessmain");
	}
	/**
	 * 下载文件方法
	 * @param response
	 * @param request
	 * @throws Exception
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
		return new ModelAndView("reportstatistics/mailsuccessmain");
	}

}
