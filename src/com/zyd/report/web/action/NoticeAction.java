package com.zyd.report.web.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zyd.report.domain.vo.SysNotice;
import com.zyd.report.logic.INoticeFacade;

/**
 * 公告信息
 * 
 * @author li_zq
 * 
 */
@Controller
@RequestMapping(value = "/notice")
public class NoticeAction extends InputSingleAction {
	@Resource(name = "noticeInputImpl")
	private INoticeFacade noticeInputImpl;// 公告信息
	/**
	 * 公告信息的添加、删除、修改
	 * 
	 * @param request
	 * @param response
	 * @param tb
	 * @param result
	 * @param
	 * @return
	 * @throws IOException
	 */

	@RequestMapping(params = "method=addNotice")
	public String addNotice(HttpServletRequest request,
			HttpServletResponse response, @Valid SysNotice tb,
			BindingResult result) throws IOException {
		super.create(request, response, result, tb, noticeInputImpl);
		return null;
	}

	@RequestMapping(params = "method=deleteNoticeById")
	public String deleteNoticeById(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		super.deleteById(request, response, noticeInputImpl);
		return null;
	}

	@RequestMapping(params = "method=updateNotice")
	public String updateNotice(HttpServletRequest request,
			HttpServletResponse response, @Valid SysNotice tb,
			BindingResult result) throws IOException {

		super.update(request, response, tb, noticeInputImpl, result);
		return null;
	}

	@RequestMapping(params = "method=getNoticeList")
	@ResponseBody
	public Map<String, Object> getNoticeList(HttpServletRequest request,
			HttpServletResponse response, @RequestParam int page,
			@RequestParam int rows) {
		Map<String, Object> map = super.getList(request, response, page, rows, noticeInputImpl,
				getSearchCondition(request));
		return map;

	}

	/**
	 * 公告主页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toNoticeMain")
	public ModelAndView toNoticeExcelMain(HttpServletRequest request,
			HttpServletResponse response) {
		 hasOperatePermission("notice", request, response);
		return new ModelAndView("reportimport/noticemain");
	}

	// 获得查询条件的Map
	public Map<String, String> getSearchCondition(HttpServletRequest request) {
		String tbtype = request.getParameter("tbtype");// 表型
		Map<String, String> mapSearchCondition = new HashMap<String, String>();
		mapSearchCondition.put("tbtype", tbtype);
		return mapSearchCondition;
	}
	/**
	 * 公告主页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toCheshi")
	public ModelAndView toCheshi(HttpServletRequest request,
			HttpServletResponse response) {
		return new ModelAndView("reportstatistics/test");
	}
}
