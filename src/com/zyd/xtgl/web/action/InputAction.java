package com.zyd.xtgl.web.action;

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

import com.zyd.xtgl.logic.IInputFacade;

public class InputAction {
	public InputAction() {
		// TODO Auto-generated constructor stub
		super();
	}
/**
 * 增加信息
 * @param request
 * @param response
 * @param result
 * @param tb
 * @param InputImpl
 * @return 增加结果提示信息
 * @throws IOException
 */
	public String create(HttpServletRequest request,
			HttpServletResponse response, BindingResult result,Object tb,
			IInputFacade<?> InputImpl) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String msg = "";
		InputImpl.create(tb);
		msg = "添加成功~~~~";
		out.print(msg);
		out.flush();
		out.close();
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
			HttpServletResponse response, IInputFacade<?> InputImpl)
			throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String msg = "";
		String id = request.getParameter("id");
		if ("".equals(id) || id == null) {
			msg = "删除失败,请刷新页面~~~~";
		} else {
			InputImpl.deleteById(id);
			msg = "删除成功~~~~";
		}
		out.print(msg);
		out.flush();
		out.close();
		return null;
	}
	/**
	 * 修改信息
	 * @param request
	 * @param response
	 * @param tb
	 * @param InputImpl
	 * @param result
	 * @return
	 * @throws IOException
	 */
	public String update(HttpServletRequest request,
			HttpServletResponse response, Object tb, IInputFacade<?> InputImpl,
			BindingResult result) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String msg = "";
		if (result.hasErrors()) {
			msg = "输入有误,添加失败~~~~";
		} else {
			InputImpl.update(tb);
			msg = "修改成功~~~~";
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
	 */
	protected Map<String, Object> getList(HttpServletRequest request,
			HttpServletResponse response, @RequestParam int page,
			@RequestParam int rows, IInputFacade<?> InputImpl,Map<String, String> searchCondition) {
		List<?> list = InputImpl.getList(searchCondition,(page - 1) * rows, rows);
		long total = InputImpl.getPageTotal(searchCondition);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", list);
		return map;
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
}
