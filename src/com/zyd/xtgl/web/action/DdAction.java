package com.zyd.xtgl.web.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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

import com.zyd.xtgl.domain.vo.SysDd;
import com.zyd.xtgl.logic.IDdFacade;

@Controller
@RequestMapping("/dd")
public class DdAction extends InputAction {
	@Resource(name = "ddImpl")
	private IDdFacade ddImpl;

	/**
	 * 数据字典列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getListbyZdtype")
	@ResponseBody
	public List<SysDd> getListbyZdtype(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, String> searchCondition = new HashMap<String, String>();
		searchCondition.put("tbtype", request.getParameter("tbtype"));
		searchCondition.put("typeCode", request.getParameter("typeCode"));
		List<SysDd> list = ddImpl.getList(searchCondition);
		return list;
	}

	/**
	 * method:增加 数据字典
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=addDd")
	public String addDd(HttpServletRequest request,
			HttpServletResponse response, @Valid SysDd tb, BindingResult result)
			throws IOException {
		create(request, response, result, tb, ddImpl);
		return null;
	}

	/**
	 * 通过id删除操作管理名的一条记录
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=delDdById")
	public String delDdById(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		deleteById(request, response, ddImpl);
		return null;
	}

	/**
	 * Method:修改 数据字典
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=updateDd")
	public String updateDd(HttpServletRequest request,
			HttpServletResponse response, @Valid SysDd tb, BindingResult result)
			throws IOException {
		return update(request, response, tb, ddImpl, result);
	}

	/**
	 * (查找)数据字典列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getDdList")
	@ResponseBody
	public Map<String, Object> getDdList(HttpServletRequest request,
			HttpServletResponse response, @RequestParam int page,
			@RequestParam int rows) {
		Map<String, String> searchCondition = new HashMap<String, String>();
		searchCondition.put("tbtype", request.getParameter("tbtype"));
		searchCondition.put("typeCode", request.getParameter("typeCode"));
		return getList(request, response, page, rows, ddImpl, searchCondition);
	}

	/**
	 * 得到Sysdd的所有实体类，以List返回
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getoperateselect")
	@ResponseBody
	public List<SysDd> getoperateselect(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, String> searchCondition = new HashMap<String, String>();
		searchCondition.put("tbtype", request.getParameter("tbtype"));
		return ddImpl.getList(searchCondition);
	}
/**
 * 得到Sysdd的所有实体类，以List<Map<String, Object>>返回(combo tree)
 * @param request
 * @param response
 * @return
 */
	@RequestMapping(params = "method=getoperatetree")
	@ResponseBody
	public List<Map<String, Object>> getoperatetree(HttpServletRequest request,
			HttpServletResponse response) {
		List<Map<String, Object>> items = new ArrayList<Map<String, Object>>();
		Map<String, String> searchCondition = new HashMap<String, String>();
		searchCondition.put("tbtype", request.getParameter("tbtype"));
		List<SysDd> list = ddImpl.getList(searchCondition);
		for (SysDd sysdd : list) {
			Map<String, Object> item = new HashMap<String, Object>();
			item.put("id", sysdd.getDdid());
			item.put("text", sysdd.getCnname());
			item.put("state", "open");
			items.add(item);
		}
		return items;
	}

	/**
	 * Method toDdMain 跳转到数据字典主界面
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toDdMain")
	public ModelAndView toDdMain(HttpServletRequest request,
			HttpServletResponse response) {
		return new ModelAndView("xtgl/ddmain");
	}

}
