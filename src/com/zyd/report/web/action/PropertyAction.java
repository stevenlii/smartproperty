package com.zyd.report.web.action;

import java.io.IOException;
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

import com.zyd.report.domain.vo.TbProperty;
import com.zyd.report.logic.IPropertyFacade;

/**
 * 物业信息管理
 * 
 * @author li_zq
 * 
 */
@Controller
@RequestMapping(value = "/property")
public class PropertyAction extends InputSingleAction {
	@Resource(name = "propertyFacadeImpl")
	private IPropertyFacade propertyFacadeImpl;// 物业信息管理
	/**
	 *物业信息管理添加、删除、修改
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
			HttpServletResponse response, @Valid TbProperty tb,
			BindingResult result) throws IOException {
		if (tb.getPropertyType().equals("property")) {
			
			super.createProperty(request, response, result, tb, propertyFacadeImpl);
		}else {
			
			super.create(request, response, result, tb, propertyFacadeImpl);
		}
		return null;
	}

	@RequestMapping(params = "method=deleteNoticeById")
	public String deleteNoticeById(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		super.deleteById(request, response, propertyFacadeImpl);
		return null;
	}

	@RequestMapping(params = "method=updateNotice")
	public String updateNotice(HttpServletRequest request,
			HttpServletResponse response, @Valid TbProperty tb,
			BindingResult result) throws IOException {
		if (tb.getPropertyType().equals("property")) {
			super.updateProperty(request, response, tb, propertyFacadeImpl,
					result);
		} else {

			super.update(request, response, tb, propertyFacadeImpl, result);
		}

		return null;
	}

	@RequestMapping(params = "method=getHouseList")
	@ResponseBody
	public Map<String, Object> getNoticeList(HttpServletRequest request,
			HttpServletResponse response, @RequestParam int page,
			@RequestParam int rows) {
		Map<String, Object> map = super.getList(request, response, page, rows, propertyFacadeImpl,
				getSearchCondition(request));
		return map;

	}

	@RequestMapping(params = "method=getHouseOnlyList")
	@ResponseBody
	public List<TbProperty> getDeptList(HttpServletRequest request,
			HttpServletResponse response) {
		List<TbProperty> list = propertyFacadeImpl.getAllList();
		return list;
	}

	/**
	 * 公告主页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toMain")
	public ModelAndView toNoticeExcelMain(HttpServletRequest request,
			HttpServletResponse response) {
		 hasOperatePermission("property", request, response);
		return new ModelAndView("smartproperty/propertymain");
	}
	@RequestMapping(params = "method=toWaterMain")
	public ModelAndView toWaterMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("property", request, response);
		return new ModelAndView("smartproperty/watermain");
	}
	@RequestMapping(params = "method=toElectMain")
	public ModelAndView toElectMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("property", request, response);
		return new ModelAndView("smartproperty/electmain");
	}
	@RequestMapping(params = "method=toCarsMain")
	public ModelAndView toCarsMain(HttpServletRequest request,
			HttpServletResponse response) {
		hasOperatePermission("property", request, response);
		return new ModelAndView("smartproperty/carsmain");
	}

	// 获得查询条件的Map
	public Map<String, String> getSearchCondition(HttpServletRequest request) {
		String tbtype = request.getParameter("tbtype");// 表型
		String propertyType = request.getParameter("propertyType");// 表型
		Map<String, String> mapSearchCondition = new HashMap<String, String>();
		mapSearchCondition.put("tbtype", tbtype);
		mapSearchCondition.put("propertyType", propertyType);
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
		return new ModelAndView("smartproperty/test");
	}
}
