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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zyd.common.CommonController;
import com.zyd.xtgl.domain.vo.SysRoleUser;
import com.zyd.xtgl.domain.vo.TbAdmDept;
import com.zyd.xtgl.domain.vo.TbAdmUser;
import com.zyd.xtgl.logic.IAdmDeptFacade;
import com.zyd.xtgl.logic.IAdmUserFacade;
import com.zyd.xtgl.logic.IRoleUserFacade;

@Controller
@RequestMapping("/AdmUser")
public class AdmUserAction extends CommonController {
	private IAdmUserFacade admUserImpl;
	private IAdmDeptFacade admDeptImpl;
	private IRoleUserFacade roleUserImpl;

	@Resource(name = "admDeptImpl")
	public void setAdmDeptImpl(IAdmDeptFacade admDeptImpl) {
		this.admDeptImpl = admDeptImpl;
	}

	@Resource(name = "admUserImpl")
	public void setAdmUserImpl(IAdmUserFacade admUserImpl) {
		this.admUserImpl = admUserImpl;
	}

	@Resource(name = "roleUserImpl")
	public void setRoleUserImpl(IRoleUserFacade roleUserImpl) {
		this.roleUserImpl = roleUserImpl;
	}

	/**
	 * 转向到用户管理主页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getUserMain")
	public ModelAndView getUserMain(HttpServletRequest request,
			HttpServletResponse response) {
		return new ModelAndView("xtgl/userlist");
	}

	/**
	 * 转换为json数据
	 * 
	 * @param request
	 * @param response
	 * @return 返回Json数据
	 */
	@RequestMapping(params = "method=getList")
	@ResponseBody
	public Map<String, Object> getList(HttpServletRequest request,
			HttpServletResponse response, @RequestParam int page,
			@RequestParam int rows) {
		List<TbAdmUser> userlist = admUserImpl.getUserPageList((page - 1)
				* rows, rows);
		long total = admUserImpl.getUserPageCount();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", userlist);
		return map;
	}

	/**
	 * 添加用户
	 * 
	 * @param request
	 * @param response
	 * @param userBean
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(params = "method=addUser")
	@ResponseBody
	public String addUser(HttpServletRequest request,
			HttpServletResponse response,
			@ModelAttribute("userform") @Valid TbAdmUser userBean,
			BindingResult result) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String msg = "";
		if (result.hasErrors()) {
			msg = "输入有误,添加用户失败~~~~";
		} else if (admUserImpl.checkUserName(userBean.getUsername())) {
			msg = "登陆名重复~~";
		} else {
			String deptid = request.getParameter("deptid");
			TbAdmDept tbAdmDept = admDeptImpl.getDeptById(deptid);
			userBean.setTbadmDept(tbAdmDept);
			admUserImpl.addUser(userBean);
			msg = "添加成功~~";
		}
		out.print(msg);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 更新用户信息
	 * 
	 * @param request
	 * @param response
	 * @param userBean
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(params = "method=updateUser")
	@ResponseBody
	public String updateUser(HttpServletRequest request,
			HttpServletResponse response,
			@ModelAttribute("userform") @Valid TbAdmUser userBean,
			BindingResult result) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String deptid = request.getParameter("deptid");
		TbAdmDept tbAdmDept = admDeptImpl.getDeptById(deptid);
		userBean.setTbadmDept(tbAdmDept);
		admUserImpl.updateUser(userBean);
		out.print("更新成功~~");
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
	@RequestMapping(params = "method=delUser")
	public String delUser(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String returnStr = "";
		String userid = request.getParameter("userid");
		List<SysRoleUser> list = roleUserImpl.getRoleUserByUserId(userid);
		if (list.size() > 0) {
			returnStr = "用户正在被角色关联~~~,无法删除~~";
		} else {
			admUserImpl.delUser(userid);
			returnStr = "删除成功~~";
		}
		out.print(returnStr);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 角色添加用户的时候用的列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getSelectList")
	@ResponseBody
	public Map<String, Object> getSelectList(HttpServletRequest request,
			HttpServletResponse response, @RequestParam int page,
			@RequestParam int rows) {
		List<TbAdmUser> userlist = admUserImpl.getUserPageList((page - 1)
				* rows, rows);
		long total = admUserImpl.getUserPageCount();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", userlist);
		return map;
	}

	/**
	 * 检查用户名
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(params = "method=checkName")
	@ResponseBody
	public String checkName(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String username = request.getParameter("username");
		boolean isuse = admUserImpl.checkUserName(username);
		String returnStr = "";
		if (isuse) {
			returnStr = "用户名重复请重新输入！";
		}
		out.print(returnStr);
		out.flush();
		out.close();
		return null;
	}
}
