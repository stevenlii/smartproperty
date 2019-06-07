package com.zyd.statistics.web.action;

import java.io.File;
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

import com.zyd.common.ExportUtils;
import com.zyd.common.GeneralTools;
import com.zyd.statistics.logic.IStatisticsFacade;
import com.zyd.xtgl.domain.vo.TbAdmUser;

/**
 * 首次开拆信息
 * 
 * @author li_zq
 * 
 */
@Controller
@RequestMapping(value = "/statisticsfirstunsolderAction")
public class FirstUnsolderAction extends StatisticsAction {
	@Resource(name = "tdghImpl")
	protected IStatisticsFacade tdghImpl;

	/**
	 * 首次开拆信息统计
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getStatistics")
	public ModelAndView getStatistics(HttpServletRequest request,
			HttpServletResponse response) {
		request.removeAttribute("firstmailfaild");
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
		
		String StartDate = request.getParameter("StartDate");
		String EndDate = request.getParameter("EndDate");
		map.put("StartDate", StartDate);
		map.put("EndDate", EndDate);
		map.put("MailState", "开拆");
		map = getDeptCode(request, map, null);
		map.put("statisticscondition",
				"t.Bill_Date, t.Mail_Num,t.Entps_Code,t.Mail_State,t.Mail_Address");
		map.put("table", "tb_tdgh");
		List<?> list = getList(request, tdghImpl, map);
		request.setAttribute("firstmailfaild", list);
		ExportUtils.ExportTXT(list, request);
		ExportUtils.ExportEXCEL(list, request);
		list = null;
		return new ModelAndView("reportstatistics/firstunsoldermain");
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
		ExportUtils.downFile(response, file,EXPORT_FILE_NAME);
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
	 * 首次开拆信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toMain")
	public ModelAndView toStatisticsMain(HttpServletRequest request,
			HttpServletResponse response) {

		return new ModelAndView("reportstatistics/firstunsoldermain");
	}
}
