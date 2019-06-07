package com.zyd.xtgl.web.action;

import java.io.IOException;
import java.io.PrintWriter;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zyd.common.CommonController;
import com.zyd.xtgl.domain.vo.SysDd;
import com.zyd.xtgl.domain.vo.SysModule;
import com.zyd.xtgl.domain.vo.SysOperate;
import com.zyd.xtgl.logic.IDdFacade;
import com.zyd.xtgl.logic.IModuleFacade;
import com.zyd.xtgl.logic.IOperateFacade;

@Controller
@RequestMapping("/operate")
public class OperateAction extends CommonController {

	private IOperateFacade operateImpl;
	private IModuleFacade moduleImpl;

	@Resource(name = "moduleImpl")
	public void setModuleImpl(IModuleFacade moduleImpl) {
		this.moduleImpl = moduleImpl;
	}

	/**
	 * 操作管理
	 * 
	 * @param operateImpl
	 */
	@Resource(name = "operateImpl")
	public void setOperateImpl(IOperateFacade operateImpl) {
		this.operateImpl = operateImpl;
	}

	/**
	 * 数据字典
	 * 
	 * @param ddImpl
	 */
	@Resource(name = "ddImpl")
	private IDdFacade ddImpl;

	/**
	 * Method toModuleMain 跳转到模块管理主界面
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toOperateMain")
	public ModelAndView toOperateMain(HttpServletRequest request,
			HttpServletResponse response) throws java.lang.Exception {
		return new ModelAndView("xtgl/operatelist");
	}

	/**
	 * 转换为json数据
	 * 
	 * @param request
	 * @param response
	 * @param page
	 * @param rows
	 *            返回Json数据
	 * @return
	 */
	@RequestMapping(params = "method=getList")
	@ResponseBody
	public Map<String, Object> getList(HttpServletRequest request,
			HttpServletResponse response, @RequestParam int page,
			@RequestParam int rows) {
		List<SysOperate> operatelist = operateImpl.getOperatePageList(
				(page - 1) * rows, rows);
		long total = operateImpl.getOperatePageCount();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", operatelist);
		return map;
	}

	/**
	 * 添加操作管理
	 * 
	 * @param request
	 * @param response
	 * @param sysOperatebean
	 * @param result
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=addOperate")
	@ResponseBody
	public String addOperate(HttpServletRequest request,
			HttpServletResponse response,
			@ModelAttribute("operatebean") @Valid SysOperate sysOperatebean,
			BindingResult result) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String msg = "";
		if (result.hasErrors()) {
			msg = "输入有误,添加失败~~~~";
		} else {
			String moduleIdAll = request.getParameter("moduleIdall");
			String ddidAll = request.getParameter("ddidall");
			String[] modules = moduleIdAll.split(",");
			String[] ddids = ddidAll.split(",");
			for (int i = 0; i < modules.length; i++) {
				SysModule sysModule = moduleImpl.getModuleById(modules[i]);
				for (int j = 0; j < ddids.length; j++) {
					SysDd sysdd = ddImpl.getEntityById(ddids[j]);
					sysOperatebean.setSysModule(sysModule);
					sysOperatebean.setSysssDd(sysdd);
					operateImpl.addOperate(sysOperatebean);
				}
			}
			msg = "添加成功~~";
		}

		out.print(msg);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 删除用户信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=delOperate")
	@ResponseBody
	public String delUser(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String returnStr = "";
		String operateid = request.getParameter("operateid");
		operateImpl.deleteOperate(operateid);
		returnStr = "删除成功~~";
		out.print(returnStr);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * Method 跳转到修改页
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @RequestMapping(params = "method=toeditOperate")
	 * @ResponseBody public SysOperate toeditOperate(HttpServletRequest request,
	 *               HttpServletResponse response) { String operateid =
	 *               request.getParameter("operateid"); SysOperate operate =
	 *               operateImpl.operateByID(operateid); return operate; }
	 */
	/**
	 * 更新用户信息
	 * 
	 * @param request
	 * @param response
	 * @param userBean
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=updateoperate")
	@ResponseBody
	public String updateUser(HttpServletRequest request,
			HttpServletResponse response,
			@ModelAttribute("operatebean") @Valid SysOperate sysOperatebean,
			BindingResult result) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String moduleId = request.getParameter("moduleId");
		SysModule sysModule = moduleImpl.getModuleById(moduleId);
		sysOperatebean.setSysModule(sysModule);
		String ddid = request.getParameter("ddid");
		SysDd sysdd = ddImpl.getEntityById(ddid);
		sysOperatebean.setSysssDd(sysdd);
		operateImpl.updateOperate(sysOperatebean);
		out.print("更新成功~~");
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 返回模块树
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=orgCombotree")
	@ResponseBody
	public List<Map<String, Object>> orgCombotree(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter("id");
		if (id == null || id.equals(""))
			id = "-1";// 数据库中一级节点的parentid都是-1
		List<SysModule> list = moduleImpl.getNodeList(id);
		List<Map<String, Object>> treelist = moduleImpl.createTree(id, list);
		return treelist;
	}

	/**
	 * 根据模块得到操作
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getOperatebyModule")
	@ResponseBody
	public List<Map<String, Object>> getModulesOperate(
			HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		if (id == null || id.equals(""))
			id = "-1";// 数据库中父结点
		List<SysModule> list = moduleImpl.getNodeList(id);// 从PId里面获得列表
		List<Map<String, Object>> treelist = moduleImpl.createTree(id, list);
		List<Map<String, Object>> operatelists = new ArrayList<Map<String, Object>>();
		for (Map<String, Object> map : treelist) {
			Map<String, Object> operatelist = new HashMap<String, Object>();
			operatelist.put("operateid", map.get("id"));
			operatelist.put("modulename", map.get("text"));
			operatelists.add(operatelist);
		}
		return operatelists;
	}

}
