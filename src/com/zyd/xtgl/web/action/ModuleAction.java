package com.zyd.xtgl.web.action;

import java.io.IOException;
import java.io.PrintWriter;
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

import com.zyd.xtgl.domain.vo.SysModule;
import com.zyd.xtgl.domain.vo.SysModuleRole;
import com.zyd.xtgl.logic.IModuleFacade;
import com.zyd.xtgl.logic.IModuleRoleFacade;

@Controller
@RequestMapping("/module")
public class ModuleAction extends InputAction {
	private IModuleFacade moduleImpl;
	private IModuleRoleFacade moduleRoleImpl;

	@Resource(name = "moduleImpl")
	public void setModuleImpl(IModuleFacade moduleImpl) {
		this.moduleImpl = moduleImpl;
	}

	@Resource(name = "moduleRoleImpl")
	public void setModuleRoleImpl(IModuleRoleFacade moduleRoleImpl) {
		this.moduleRoleImpl = moduleRoleImpl;
	}

	/**
	 * Method toModuleMain 跳转到模块管理主界面
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toModuleMain")
	public ModelAndView toModuleMain(HttpServletRequest request,
			HttpServletResponse response) throws java.lang.Exception {
		return new ModelAndView("xtgl/modulemain");
	}

	/**
	 * Method showModuleTree 显示模块树
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=showModuleTree")
	@ResponseBody
	public List<Map<String, Object>> showModuleTree(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter("id");
		if (id == null || id.equals(""))
			id = "-1";// 我数据库中一级节点的parentid都是-1
		List<SysModule> list = moduleImpl.getNodeList(id);
		List<Map<String, Object>> treelist = moduleImpl.createTree(id, list);
		return treelist;
	}
	/**
	 *显示模块上级目录
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=showModuleParent")
	@ResponseBody
	public List<SysModule> orgCombotree(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter("id");
		if (id == null || id.equals(""))
			id = "-1";// 我数据库中一级节点的parentid都是-1
		List<SysModule> list = moduleImpl.getNodeList(id);
		
		return list;
	}

	/**
	 * Method toModuleMain 跳转到修改页
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toeditModule")
	@ResponseBody
	public SysModule toeditModule(HttpServletRequest request,
			HttpServletResponse response, @RequestParam String moduleId) {
		SysModule module = moduleImpl.getModuleById(moduleId);
		return module;
	}

	/**
	 * Method toModuleMain添加模块
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=addModule")
	public String addModule(HttpServletRequest request,
			HttpServletResponse response, @Valid SysModule module,
			BindingResult result) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String returnStr = "";
		SysModule tempmodule = moduleImpl.getModuleById(module.getModulePid());
		if (result.hasErrors()) {
			returnStr = "输入信息有误~~";
		} else if (tempmodule != null
				&& !"-1".equals(tempmodule.getModulePid())) {
			returnStr = "未级目录不能添加模块~~";
		} else {
			moduleImpl.saveModule(module);
			returnStr = "添加成功~~";
		}
		out.print(returnStr);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * Method toModuleMain修改模块
	 * 
	 * @param mapping
	 * @param form
	 * @param request 
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=updateModule")
	public String updateModule(HttpServletRequest request,
			HttpServletResponse response, @Valid SysModule module,
			BindingResult result) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String returnStr = "";
		if (result.hasErrors()) {
			returnStr = "输入信息有误~~";
		} else {
			moduleImpl.updateModule(module);
			returnStr = "更新成功~~";
		}
		out.print(returnStr);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 删除模块
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=deleteModule")
	public String deleteModule(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String moduleId = request.getParameter("id");
		String returnStr = "";
		// 查询出是否有子模块
		List<SysModule> list = moduleImpl.getNodeList(moduleId);
		// 查询出此模块是不是正有角色对应
		List<SysModuleRole> mrlist = moduleRoleImpl
				.getModuleRoleByIds(moduleId);
		//List<SysOperate> sysOperates = SysOperate.
		if (list.size() > 0 || mrlist.size() > 0) {
			if (list.size() > 0) {
				StringBuilder sb = new StringBuilder();
				for (SysModule m : list) {
					sb.append(m.getModuleName());
					sb.append(" ");
				}
				returnStr = "模块正在被子模块:  <font color=\"red\"> "+sb.toString()+"</font> 使用，不能删除~~";
			}
			if (mrlist.size() > 0) {
				StringBuilder sb = new StringBuilder();
				for (SysModuleRole m : mrlist) {
					sb.append(m.getSysRole().getRoleName());
					sb.append(" ");
				}
				returnStr = "模块正在被角色:  <font color=\"red\"> "+sb.toString()+"</font> 使用，请检查角色对应模块，否则不能删除~~";
			}
		} else {
			moduleImpl.deleteModuleById(moduleId);
			returnStr = "删除成功~~";
		}
		out.print(returnStr);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 添加角色到模块
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	/*@RequestMapping(params = "method=addRoleToModule")
	public String addRoleToModule(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String moduleId = request.getParameter("moduleId");
		String roleIds = request.getParameter("roleIds");
		SysModule module = moduleImpl.getModuleById(moduleId);
		String[] roles = null;
		if (roleIds != null && !"".equals(roleIds)) {
			roles = roleIds.split(",");
			if (roles.length > 0) {
				for (int j = 0; j < roles.length; j++) {
					Object[] obj = new Object[] { moduleId, roles[j] };
					// 判断模块下是否存在传入的角色，如果存在不添加，不存在则添加
					if (!moduleRoleImpl.checkModuleToRole(obj)) {
						SysModuleRole moduleRole = new SysModuleRole();
						SysRole role = roleImpl.getRoleById(roles[j]);
						moduleRole.setSysModule(module);
						moduleRole.setSysRole(role);
						moduleRoleImpl.saveModuleRole(moduleRole);
					}
				}
			}
		}
		out.print("添加成功~~");
		out.flush();
		out.close();
		return null;
	}*/

	/**
	 * 从模块中删除对应角色
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=deleteRoleFromModule")
	public String deleteRoleFromModule(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String ids = request.getParameter("ids");
		String marid[] = ids.split(",");
		if (marid.length > 0) {
			for (int i = 0; i < marid.length; i++) {
				moduleRoleImpl.deleteModuleRoleById(marid[i]);
			}
		}
		out.print("删除成功~~");
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 根据传入的模块ID获取模块下的角色
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getRolesBymoduleId")
	@ResponseBody
	public Map<String, Object> getRolesBymoduleId(HttpServletRequest request,
			HttpServletResponse response, @RequestParam int page,
			@RequestParam int rows) {
		String moduleId = request.getParameter("moduleId");
		List<SysModuleRole> list = moduleRoleImpl.getModuleRoleByIds(moduleId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", list.size());
		map.put("rows", list);
		return map;
	}

	/**
	 * 根据传入的模块ID获取模块下的角色
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getModuleById")
	@ResponseBody
	public Map<String, Object> getModuleById(HttpServletRequest request,
			HttpServletResponse response, @RequestParam int page,
			@RequestParam int rows) {
		List<SysModule> list = moduleImpl.getPageList((page - 1) * rows, rows);
		long total = moduleImpl.getPageCount();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", list);
		return map;
	}
	
}
