package com.zyd.login.web.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zyd.common.CommonController;
import com.zyd.report.domain.vo.SysNotice;
import com.zyd.report.logic.INoticeFacade;
import com.zyd.xtgl.domain.vo.SysModule;
import com.zyd.xtgl.domain.vo.TbAdmUser;
import com.zyd.xtgl.logic.IAdmUserFacade;

@Controller
@RequestMapping("/login")
public class LoginAction extends CommonController {
	@Resource(name = "admUserImpl")
	private IAdmUserFacade admUserImpl;
	@Resource(name = "noticeInputImpl")
	private INoticeFacade noticeInputImpl;//公告信息


	/**
	 * 登陆
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=login")
	public ModelAndView login(HttpServletRequest request,
			HttpServletResponse response) {

		if (request.getSession().getAttribute("user") != null) {
			HttpSession session = request.getSession();
			TbAdmUser user = (TbAdmUser) session.getAttribute("user");
			getReplyNum(session, user);
			getNotice(session);
			return new ModelAndView("welcome/mainpage");
		} else {
			String userName = request.getParameter("txtUser");
			String password = request.getParameter("txtPass");
			boolean isSuccess = false;
			if (!"".equals(userName) && !"".equals(password)
					&& userName != null && password != null) {
				isSuccess = admUserImpl.checkUser(userName.trim(),
						password.trim());
			}
			if (isSuccess) {
				TbAdmUser user = admUserImpl.getCuruserinfo(userName);
				request.getSession().setAttribute("user", user);
				HttpSession session = request.getSession();
				getReplyNum(session, user);
				getNotice(session);
				return new ModelAndView("welcome/mainpage");
			} else {
				return new ModelAndView("login");
			}
		}
	}

	/**
	 * 获得回复条数
	 * 
	 * @param session
	 * @param user
	 */
	private void getReplyNum(HttpSession session, TbAdmUser user) {
		String companyCode = user.getTbadmDept().getCompanycode();
		Map<String, String> mapSearchCondition = new HashMap<String, String>();
		mapSearchCondition.put("companyCode", companyCode);
		mapSearchCondition.put("replySuccess", "false");
		long complaints = 0L;
//		long complaints = complaintImportImpl.getPageTotal(mapSearchCondition);
		session.setAttribute("replyNum", complaints);
	}
	/**
	 * 获得公告信息
	 * 
	 * @param session
	 * @param user
	 */
	private void getNotice(HttpSession session) {
		Map<String, String> mapSearchCondition = new HashMap<String, String>();
		mapSearchCondition.put("notiedate", "notiedate");
		List<SysNotice> notices = noticeInputImpl.getList(mapSearchCondition, 0, 5);
		SysNotice sysnatice = new SysNotice();
		if(notices.size()>0){
			sysnatice = notices.get(notices.size()-1);
		}
		session.setAttribute("note", sysnatice);
	}

	/**
	 * 根据用户取得用户权限 返回JSON数据，页面上由js解析easyui展示
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getMenu")
	@ResponseBody
	public Map<String, Object> getMenu(HttpServletRequest request,
			HttpServletResponse response) {
		TbAdmUser user = (TbAdmUser) request.getSession().getAttribute("user");
		List<SysModule> menu = admUserImpl.getMainMenu(user.getUserid());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("menus", menu);
		return map;
	}

	/**
	 * 验证用户名
	 * 
	 * @param request
	 * @param response
	 * @return String
	 * @throws IOException
	 */
	@RequestMapping(params = "method=checkUsername")
	public String checkUsername(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String returnStr = "";
		String username = request.getParameter("username");
		// 验证用户名
		boolean isSuccess = admUserImpl.checkUserName(username);
		if (isSuccess) {
			returnStr = "用户可用~~";
		} else {
			returnStr = "用户名不存在~~";
		}
		out.print(returnStr);
		return null;
	}

	@RequestMapping(params = "method=logout")
	public ModelAndView logout(HttpServletRequest request,
			HttpServletResponse response) {
		request.getSession().removeAttribute("user");
		request.getSession().removeAttribute("menu");
		return new ModelAndView("login");
	}

	/**
	 * 修改密码
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=editpass")
	public void editpass(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String modifyMessage = "";
		TbAdmUser user = (TbAdmUser) request.getSession().getAttribute("user");
		String userid = user.getUserid();
		String oldPassword = user.getPassword();
		String oldPasswordUser = request.getParameter("oldpassword").trim();
		String newPassword = request.getParameter("newpassword").trim();
		String confPassword = request.getParameter("confpassword").trim();
		if (!oldPassword.equals(oldPasswordUser)) {
			modifyMessage = "填写的原密码不对！";
			return;
		} else if (!newPassword.equals(confPassword)) {
			modifyMessage = "新密码与确认密码不一致！<BR>请重新填写！";
			return;
		} else {
			admUserImpl.updateUserPass(userid, newPassword);
			modifyMessage = "修改密码成功！<BR>下次登录请使用新密码~";
		}
		out.print(modifyMessage);
	}
}
