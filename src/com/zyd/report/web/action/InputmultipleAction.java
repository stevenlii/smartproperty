package com.zyd.report.web.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestParam;

import com.zyd.report.logic.IImportReportFacade;
/**
 * 同时具有装载和录入功能的表，在相关实现的inputAction里面的父类应该继承此类
 * @author lzq
 *
 */
public class InputmultipleAction {
	public static final String MSG_CREATE_SUCCESS = "添加成功~~";
	public static final String MSG_INPUT_VALIDATOR = "输入字段有误";
	public static final String MSG_CREATE_FAILED = "添加失败!";
	public static final String MSG_DELETE_SUCCESS = "删除成功~~";
	public static final String MSG_DELETE_FAILED = "删除失败~~";
	public static final String MSG_UPDATE_SUCCESS = "更新成功~~";
	public static final String MSG_UPDATE_FAILED = "更新失败~~";
	public static final String MSG_SELECT_SUCCESS = "查询结果~~";
	public static final String MSG_SELECT_FAILED = "未知原因，查询失败";
	public static final String MSG_SELECT_NODATE = "查询结果为空";

	public InputmultipleAction() {
		// TODO Auto-generated constructor stub
		super();
	}

	/**
	 * 页面传过来的String转换成Date类型
	 * 
	 * @param binder
	 */
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,
				true));
	}

	/**
	 * 增加信息
	 * 
	 * @param request
	 * @param response
	 * @param result
	 * @param tb
	 * @param InputReportImpl
	 * @return
	 * @throws IOException
	 */
	public String create(HttpServletRequest request,
			HttpServletResponse response, BindingResult result, Object tb,
			IImportReportFacade<?> InputReportImpl) {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = null;
		String msg = "";
		try {
			out = response.getWriter();
			if (result.hasErrors()) {
				msg = MSG_INPUT_VALIDATOR + MSG_CREATE_FAILED;
				return null;
			}
			InputReportImpl.create(tb);
			msg = MSG_CREATE_SUCCESS;
		} catch (IOException e) {
			msg = MSG_CREATE_FAILED;
			e.printStackTrace();
		} finally {
			out.print(msg);
			out.flush();
			out.close();
		}
		return null;

	}

	/**
	 * 根据id删除信息
	 * 
	 * @param request
	 * @param response
	 * @param ImportReportImpl
	 * @return
	 * @throws IOException
	 */
	protected String deleteById(HttpServletRequest request,
			HttpServletResponse response, IImportReportFacade<?> InputReportImpl)
			throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String msg = "";
		String entityids = request.getParameter("entityid");
		String[] entityid = entityids.split(",");
		for (int j = 0; j < entityid.length; j++) {
			InputReportImpl.deleteById(entityid[j]);
			msg = MSG_DELETE_SUCCESS;
		}
		out.print(msg);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 修改信息
	 * 
	 * @param request
	 * @param response
	 * @param tb
	 * @param InputReportImpl
	 * @param result
	 * @return
	 * @throws IOException
	 */
	public String update(HttpServletRequest request,
			HttpServletResponse response, Object tb,
			IImportReportFacade<?> InputReportImpl, BindingResult result)
			throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String msg = "";
		if (result.hasErrors()) {
			msg = MSG_INPUT_VALIDATOR + MSG_UPDATE_FAILED;
		} else {
			InputReportImpl.update(tb);
			msg = MSG_UPDATE_SUCCESS;
		}
		out.print(msg);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 查找列表信息
	 * 
	 * @param request
	 * @param response
	 * @param page
	 * @param rows
	 * @param ImportReportImpl
	 * @return
	 * @throws IOException
	 */
	protected Map<String, Object> getList(HttpServletRequest request,
			HttpServletResponse response, @RequestParam int page,
			@RequestParam int rows, IImportReportFacade<?> InputReportImpl,
			Map<String, String> searchCondition) {
		List<?> list = null;
		long total = 0;
		// 调用查询方法，返回查询List和查询总条数
		list = InputReportImpl
				.getList(searchCondition, (page - 1) * rows, rows);
		total = InputReportImpl.getPageTotal(searchCondition);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", list);
		return map;
	}

}
