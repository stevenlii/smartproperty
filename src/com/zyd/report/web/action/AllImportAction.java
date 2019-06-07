package com.zyd.report.web.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * 此类主要是各个模块的导入操作
 * 
 * @author li_zq
 * 
 */
@Controller
@RequestMapping(value = "/import")
public class AllImportAction extends ImportAction {

	/**
	 * 一、财务装载 终端页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=tofinanceImportMain")
	public ModelAndView getTerminalimportmain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("finance", request, response);
		return new ModelAndView("reportimport/financeimport");
	}

	@RequestMapping(params = "method=tofinanceDeleteMain")
	public ModelAndView tofinanceDeleteMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("finance", request, response);
		return new ModelAndView("reportimport/financeimportdelete");
	}


	/**
	 * 结账信息查询
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toSearchfinance")
	public ModelAndView toSearchfinance(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("finance", request, response);
		return new ModelAndView("reportimport/financesearchmain");
	}

	/**
	 * 二、投诉信息装载
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=tocomplaintMain")
	public ModelAndView tocomplaintMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("complaint", request, response);// 投诉
		return new ModelAndView("reportimport/complaintmain");
	}
/**
 * 投诉信息添加
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=tocomplaintAddMain")
	public ModelAndView tocomplaintAddMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("complaint", request, response);// 投诉
		return new ModelAndView("reportimport/complaintaddmain");
	}
/**
 * 投诉信息修改
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=tocomplaintUpdateMain")
	public ModelAndView tocomplaintUpdateMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("complaint", request, response);// 投诉
		return new ModelAndView("reportimport/complaintupdatemain");
	}
/**
 * 投诉信息删除
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=tocomplaintDeleteMain")
	public ModelAndView tocomplaintDeleteMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("complaint", request, response);// 投诉
		return new ModelAndView("reportimport/complaintdeletemain");
	}

	/**
	 * 投诉邮件查询
	 * 
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(params = "method=toSearchcomplaintMain")
	public ModelAndView toSearchcomplaintMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("complaint", request, response);
		return new ModelAndView("reportimport/complaintsearchmain");
	}

	/**
	 * 二、1 投诉信息回复
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toreplycomplaintMain")
	public ModelAndView toreplycomplaintMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("reply", request, response);// 回复投诉
		return new ModelAndView("reportimport/replycomplaintmain");
	}

	/**
	 * 三、赔偿信息装载
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toindemnifyMain")
	public ModelAndView toindemnifyMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("indemnify", request, response);
		return new ModelAndView("reportimport/indemnifymain");
	}
/**
 * 赔偿信息添加
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=toindemnifyAddMain")
	public ModelAndView toindemnifyAddMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("indemnify", request, response);
		return new ModelAndView("reportimport/indemnifyaddmain");
	}
/**
 * 赔偿信息修改
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=toindemnifyUpdateMain")
	public ModelAndView toindemnifyUpdateMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("indemnify", request, response);
		return new ModelAndView("reportimport/indemnifyupdatemain");
	}
/**
 * 赔偿信息删除
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=toindemnifyDeleteMain")
	public ModelAndView toindemnifyDeleteMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("indemnify", request, response);
		return new ModelAndView("reportimport/indemnifydeletemain");
	}

	/**
	 * 赔偿邮件查询
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toSearchIndemnifyMain")
	public ModelAndView toSearchIndemnifyMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("indemnify", request, response);
		return new ModelAndView("reportimport/indemnifysearchmain");
	}

	/**
	 * 四、交寄信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	// 装载
	@RequestMapping(params = "method=tomailPostMain")
	public ModelAndView tomailPostMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("mailpost", request, response);
		return new ModelAndView("reportimport/mailpostmain");
	}

	// 添加
	@RequestMapping(params = "method=tomailPostAddMain")
	public ModelAndView tomailPostAddMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("mailpost", request, response);
		return new ModelAndView("reportimport/mailpostaddmain");
	}

	// 修改
	@RequestMapping(params = "method=tomailPostUpdateMain")
	public ModelAndView tomailPostUpdateMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("mailpost", request, response);
		return new ModelAndView("reportimport/mailpostupdatemain");
	}

	// 删除
	@RequestMapping(params = "method=tomailPostDeleteMain")
	public ModelAndView tomailPostDeleteMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("mailpost", request, response);
		return new ModelAndView("reportimport/mailpostdeletemain");
	}

	/**
	 * 交寄邮件查询
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toSearchmailPostMain")
	public ModelAndView toSearchmailPostMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("mailpost", request, response);
		return new ModelAndView("reportimport/mailpostsearchmain");
	}

	/**
	 * 五、退回信息(Excel)装载
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toreturnExcelMain")
	public ModelAndView toreturnExcelMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("return", request, response);
		return new ModelAndView("reportimport/returnmain");
	}
/***
 * 退回添加
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=toreturnAddMain")
	public ModelAndView toreturnAddMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("return", request, response);
		return new ModelAndView("reportimport/returnaddmain");
	}
/**
 * 退回修改
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=toreturnUpdateMain")
	public ModelAndView toreturnUpdateMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("return", request, response);
		return new ModelAndView("reportimport/returnupdatemain");
	}
/**
 * 退回删除
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=toreturnDeleteMain")
	public ModelAndView toreturnDeleteMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("return", request, response);
		return new ModelAndView("reportimport/returndeletemain");
	}

	/**
	 * 退回邮件查询
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toSearchReturnMain")
	public ModelAndView toSearchReturnMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("return", request, response);
		return new ModelAndView("reportimport/returnmainsearch");
	}

	/**
	 * 六、异常邮件
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toexceptionMain")
	public ModelAndView toexceptionMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("exception", request, response);
		return new ModelAndView("reportimport/exceptionmain");
	}
/**
 * 异常添加
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=toexceptionAddMain")
	public ModelAndView toexceptionAddMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("exception", request, response);
		return new ModelAndView("reportimport/exceptionaddmain");
	}
/**
 * 异常查询
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=toexceptionSearchMain")
	public ModelAndView toexceptionSearchMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("exception", request, response);
		return new ModelAndView("reportimport/exceptionsearchmain");
	}
/**
 * 异常修改
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=toexceptionUpdateMain")
	public ModelAndView toexceptionUpdateMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("exception", request, response);
		return new ModelAndView("reportimport/exceptionupdatemain");
	}
/**
 * 异常删除
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=toexceptionDeleteMain")
	public ModelAndView toexceptionDeleteMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("exception", request, response);
		return new ModelAndView("reportimport/exceptiondeletemain");
	}

	/**
	 * 七、投递录入信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toInputeTdghMain")
	public ModelAndView toInputeTdghMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("tdgh", request, response);
		return new ModelAndView("reportimport/tdghinputmain");
	}
/**
 * 投递修改
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=toTdghUpdateMain")
	public ModelAndView toTdghUpdateMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("tdgh", request, response);
		return new ModelAndView("reportimport/tdghupdatemain");
	}
/**
 * 投递删除
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=toTdghDeleteMain")
	public ModelAndView toTdghDeleteMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("tdgh", request, response);
		return new ModelAndView("reportimport/tdghdeletemain");
	}
/**
 * 投递采集
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=toCollectTdghMain")
	public ModelAndView toCollectTdghMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("tdgh", request, response);
		return new ModelAndView("reportimport/tdghcollectmain");
	}
/**
 * 妥投邮件查询
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=toSearchTdghMain")
	public ModelAndView toSearchTdghMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("tdgh", request, response);
		return new ModelAndView("reportimport/tdghsearchmain");
	}
/**
 * 综合查询
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=toSearchIntegratedMain")
	public ModelAndView toSearchIntegratedMain(HttpServletRequest request,
			HttpServletResponse response) {
		//hasOperatePermission("mailpost", request, response);
		return new ModelAndView("reportimport/Integratedmain");
	}
	/**
	 * 装载成功的转向页面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toimportresultmain")
	public ModelAndView toimportresultmain(HttpServletRequest request,
			HttpServletResponse response) {
		//hasOperatePermission("mailpost", request, response);
		return new ModelAndView("reportimport/importresultmain");
	}
	
	

	// 获得查询条件的Map
	public Map<String, String> getSearchCondition(HttpServletRequest request) {
		String tbName = request.getParameter("tbName");// 表型
		Map<String, String> mapSearchCondition = new HashMap<String, String>();
		mapSearchCondition.put("tbName", tbName);
		return mapSearchCondition;
	}


}
