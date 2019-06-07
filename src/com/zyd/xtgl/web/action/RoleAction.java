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

import com.zyd.common.CommonController;
import com.zyd.xtgl.domain.vo.SysModule;
import com.zyd.xtgl.domain.vo.SysModuleRole;
import com.zyd.xtgl.domain.vo.SysOperate;
import com.zyd.xtgl.domain.vo.SysOperateRole;
import com.zyd.xtgl.domain.vo.SysRole;
import com.zyd.xtgl.domain.vo.SysRoleUser;
import com.zyd.xtgl.domain.vo.TbAdmUser;
import com.zyd.xtgl.logic.IAdmUserFacade;
import com.zyd.xtgl.logic.IModuleFacade;
import com.zyd.xtgl.logic.IModuleRoleFacade;
import com.zyd.xtgl.logic.IOperateFacade;
import com.zyd.xtgl.logic.IOperateRoleFacade;
import com.zyd.xtgl.logic.IRoleFacade;
import com.zyd.xtgl.logic.IRoleUserFacade;

@Controller
@RequestMapping("/role")
public class RoleAction extends CommonController {
	@Resource(name = "roleImpl")
	private IRoleFacade roleImpl;
	// 角色对用户
	@Resource(name = "admUserImpl")
	private IAdmUserFacade admUserImpl;
	@Resource(name = "roleUserImpl")
	private IRoleUserFacade roleUserImpl;
	// 角色对模块
	@Resource(name = "moduleImpl")
	private IModuleFacade moduleImpl;
	@Resource(name = "moduleRoleImpl")
	private IModuleRoleFacade moduleRoleImpl;
	// 角色对操作
	@Resource(name = "operateImpl")
	private IOperateFacade operateImpl;
	@Resource(name = "operateRoleImpl")
	private IOperateRoleFacade operateRoleImpl;

	/**
	 * 转换为json数据
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getList")
	@ResponseBody
	public Map<String, Object> getList(HttpServletRequest request,
			HttpServletResponse response, @RequestParam int page,
			@RequestParam int rows) {
		List<SysRole> list = roleImpl.getNodeList("-1");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", list.size());
		map.put("rows", list);
		return map;
	}

	/**
	 * Method toRoleMain 跳转到角色管理主界面
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toRoleMain")
	public ModelAndView toRoleMain(HttpServletRequest request,
			HttpServletResponse response) {
		return new ModelAndView("xtgl/rolemain");
	}

	/**
	 * Method showRoleTree 显示角色树
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=showRoleTree")
	@ResponseBody
	public List<Map<String, Object>> showRoleTree(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter("id");
		if (id == null || id.equalsIgnoreCase(""))
			id = "-1";// 我数据库中一级节点的parentid都是-1
		List<SysRole> list = roleImpl.getNodeList(id);
		List<Map<String, Object>> treelist = roleImpl.createTree(id, list);
		return treelist;
	}

	/**
	 * Method toRoleMain 跳转到修改页
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=toeditRole")
	@ResponseBody
	public SysRole toeditRole(HttpServletRequest request,
			HttpServletResponse response) {
		String roleId = request.getParameter("roleId");
		SysRole role = roleImpl.getRoleById(roleId);
		return role;
	}

	/**
	 * 添加角色
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=addRole")
	public String addRole(HttpServletRequest request,
			HttpServletResponse response, @Valid SysRole role,
			BindingResult result) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String returnStr = "";
		if (result.hasErrors()) {
			returnStr = "输入信息有误~~";
		} else {
			role.setRolePid("-1");
			roleImpl.saveRole(role);
			returnStr = "添加成功~~";
		}
		out.print(returnStr);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * Method toRoleMain修改角色
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=updateRole")
	public String updateRole(HttpServletRequest request,
			HttpServletResponse response, @Valid SysRole role,
			BindingResult result) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String returnStr = "";
		if (result.hasErrors()) {
			returnStr = "输入信息有误~~";
		} else {
			roleImpl.updateRole(role);
			returnStr = "更新成功~~";
		}
		out.print(returnStr);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 删除角色信息 删除前请判断角色用户是否被使用
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=deleteRole")
	public String deleteRole(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String returnStr = "";
		String roleId = request.getParameter("roleId");
		List<SysRoleUser> list = roleUserImpl.getRoleUserByRoleId(roleId);
		if (list.size() > 0) {
			returnStr = "角色正在被使用~~,不允许被删除~~";
		} else {
			roleImpl.deleteRole(roleImpl.getRoleById(roleId));
			returnStr = "删除成功~~";
		}
		out.print(returnStr);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 添加用户至角色
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=addUserToRole")
	public String addUserToRole(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String userIds = request.getParameter("userIds");
		String roleId = request.getParameter("roleId");
		String[] users = userIds.split(",");
		for (int j = 0; j < users.length; j++) {
			if (!roleUserImpl.checkUserToRole(roleId, users[j])) {
				SysRoleUser roleUser = new SysRoleUser();
				SysRole role = roleImpl.getRoleById(roleId);
				TbAdmUser user = admUserImpl.getByUserid(users[j]);
				roleUser.setSysRole(role);
				roleUser.setTbAdmUser(user);
				roleUserImpl.saveRoleUser(roleUser);
			}
		}
		out.print("添加成功~~");
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 删除用户从角色中
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=deleteUserFromRole")
	@ResponseBody
	public String deleteUserFromRole(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String roleUserIds = request.getParameter("roleUserIds");
		String[] roleUserId = roleUserIds.split(",");
		for (int j = 0; j < roleUserId.length; j++) {
			roleUserImpl.deleteRoleUserById(roleUserId[j]);
		}
		out.print("删除成功~~");
		out.flush();
		out.close();
		return null;
	}

	/**
	 * Method 查询角色下的用户
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getRoleUserByRoleId")
	@ResponseBody
	public Map<String, Object> getRoleUserByRoleId(HttpServletRequest request,
			HttpServletResponse response, @RequestParam int page,
			@RequestParam int rows, @RequestParam String nodeId) {
		List<SysRoleUser> roleUsers = roleUserImpl.getRoleUserByRoleId(nodeId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", roleUsers.size());
		map.put("rows", roleUsers);
		return map;
	}

	// ////////////////////////////////////////////////////////////////////////////////////////////////
	/**
	 * 添加模块到角色(ModuleToRole)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=addModuleToRole")
	public String addModuleToRole(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String ids = request.getParameter("ids");
		String roleId = request.getParameter("roleId");
		String[] moduleids = ids.split(",");
		for (int j = 0; j < moduleids.length; j++) {
			if (!moduleRoleImpl.checkModuleToRole(roleId, moduleids[j])) {
				SysModuleRole moduleRole = new SysModuleRole();
				SysRole role = roleImpl.getRoleById(roleId);
				SysModule module = moduleImpl.getModuleById(moduleids[j]);
				moduleRole.setSysRole(role);
				moduleRole.setSysModule(module);
				moduleRoleImpl.saveModuleRole(moduleRole);
			}
		}
		out.print("添加成功~~");
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
	@RequestMapping(params = "method=deleteModuleFromRole")
	@ResponseBody
	public String deleteModuleFromRole(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String ids = request.getParameter("ids");
		String[] id = ids.split(",");
		for (int j = 0; j < id.length; j++) {
			moduleRoleImpl.deleteModuleRoleById(id[j]);
		}
		out.print("删除成功~~");
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 查找模块
	 * 
	 * @param request
	 * @param response
	 * @param page
	 * @param rows
	 * @param nodeId
	 * @return
	 */
	@RequestMapping(params = "method=getModuleRoleByRoleId")
	@ResponseBody
	public Map<String, Object> getModuleRoleByRoleId(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam int page, @RequestParam int rows,
			@RequestParam String nodeId) {
		List<SysModuleRole> moduleRole = moduleRoleImpl
				.getModuleRoleByRoleId(nodeId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", moduleRole.size());
		map.put("rows", moduleRole);
		return map;
	}

	// ////////////////////////////////////////////////////////////////////////////////////////////////
	/**
	 * 添加操作到角色(OperateToRole)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=addOperateToRole")
	public String addOperateToRole(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String ids = request.getParameter("ids");
		String roleId = request.getParameter("roleId");
		String[] operateid = ids.split(",");
		for (int j = 0; j < operateid.length; j++) {
			if (!operateRoleImpl.checkOperateToRole(roleId, operateid[j])) {
				SysOperateRole operateRole = new SysOperateRole();
				SysRole role = roleImpl.getRoleById(roleId);
				SysOperate operate = operateImpl.getOperateById(operateid[j]);
				operateRole.setSysRole(role);
				operateRole.setSysOperate(operate);
				operateRoleImpl.saveOperateRole(operateRole);
			}
		}
		out.print("添加成功~~");
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 删除操作
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=deleteOperateFromRole")
	@ResponseBody
	public String deleteOperateFromRole(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String ids = request.getParameter("ids");
		String[] id = ids.split(",");
		for (int j = 0; j < id.length; j++) {
			operateRoleImpl.deleteOperateRoleById(id[j]);
		}
		out.print("删除成功~~");
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 查找操作
	 * 
	 * @param request
	 * @param response
	 * @param page
	 * @param rows
	 * @param nodeId
	 * @return
	 */
	@RequestMapping(params = "method=getOperateRoleByRoleId")
	@ResponseBody
	public Map<String, Object> getOperateRoleByRoleId(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam int page, @RequestParam int rows,
			@RequestParam String nodeId) {
		List<SysOperateRole> operateRole = operateRoleImpl
				.getOperateRoleByRoleId(nodeId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", operateRole.size());
		map.put("rows", operateRole);
		return map;
	}
}
