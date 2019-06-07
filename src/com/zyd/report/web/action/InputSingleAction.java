package com.zyd.report.web.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestParam;

import com.ibm.icu.math.BigDecimal;
import com.zyd.report.domain.vo.TbProperty;
import com.zyd.report.logic.IInputReportFacade;
import com.zyd.xtgl.domain.vo.SysDd;
import com.zyd.xtgl.domain.vo.SysOperateRole;
import com.zyd.xtgl.domain.vo.SysRoleUser;
import com.zyd.xtgl.domain.vo.TbAdmUser;
import com.zyd.xtgl.logic.IOperateRoleFacade;
import com.zyd.xtgl.logic.IRoleUserFacade;
/**
 * 本类提供只有录入功能的基础类
 * @author lzq
 *
 */
public class InputSingleAction {
	protected static final String OPERATE_ADD = "add";
	protected static final String OPERATE_DEL = "del";
	protected static final String OPERATE_UPDATE = "update";
	protected static final String OPERATE_SEARCH = "search";
	protected static final String OPERATE_CREATE = "create";
	protected static final String OPERATE_DELSINGLE = "delsingle";
	protected static final String OPERATE_REPLY = "reply";
	protected static final String OPERATE_CLEARTAB = "cleartab";

	@Resource(name = "roleUserImpl")
	private IRoleUserFacade roleUserImpl;
	@Resource(name = "operateRoleImpl")
	private IOperateRoleFacade operateRoleImpl;

	public InputSingleAction() {
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
			IInputReportFacade<?> InputReportImpl) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String msg = "";
		if (result.hasErrors()) {
			msg = "输入字段有误,添加失败!";
			return null;
		}
		InputReportImpl.create(tb);
		msg = "添加成功~~~~";
		out.print(msg);
		out.flush();
		out.close();
		return null;
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
	public String createProperty(HttpServletRequest request,
			HttpServletResponse response, BindingResult result, Object tb,
			IInputReportFacade<?> InputReportImpl) {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = null;
		String msg = "添加成功~~~~";
		int msg_code_trace = 10;

		try {
			out = response.getWriter();
		if (result.hasErrors()) {
			msg = "输入字段有误,添加失败!";
			out.print(msg);
			out.flush();
			out.close();
			return null;
		}
		TbProperty p = (TbProperty)tb;
		 msg_code_trace = 0;
		Double feeIso = Double.parseDouble(p.getFeeIso());
		msg_code_trace = 1;
		Double houseArea = Double.parseDouble(p.getHouseArea());
		 msg_code_trace = 2;
		Double feeTotal = feeIso * houseArea;
		p.setFeeTotal(String.valueOf(feeTotal));
		
		InputReportImpl.create(p);
		out.print(msg);
		out.flush();
		out.close();
		} catch (java.lang.NumberFormatException e) {
			msg = "输入字段有误,更新失败!" + e.getMessage();
			if (msg_code_trace == 0) {
				msg = " 更新失败! 原因：<font color='red'>费用标准(元/月)</font>请输入数字！";
			}else if (msg_code_trace == 1) {
				msg = " 更新失败! 原因：<font color='red'>房产面积</font>请输入数字！";
			}else if (msg_code_trace == 2) {
				msg = " 更新失败! 原因：<font color='red'>合计费用 </font>非法！";
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			msg = "输入字段有误,更新失败!" + e.getMessage();
		}finally{
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
			HttpServletResponse response, IInputReportFacade<?> InputReportImpl)
			throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String msg = "";
	    String entityids = request.getParameter("entityid");
		String[] entityid = entityids.split(",");
		
		for (int j = 0; j < entityid.length; j++) {
			InputReportImpl.deleteById(entityid[j]);
			msg = "删除成功~~~~";
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
	public String updateProperty(HttpServletRequest request,
			HttpServletResponse response, Object tb,
			IInputReportFacade<?> InputReportImpl, BindingResult result) {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = null;
		String msg = "更新成功~~~~";
		int msg_code_trace = 10;
		try {
			out = response.getWriter();
		if (result.hasErrors()) {
			msg = "输入字段有误,更新失败!";
			out.print(msg);
			out.flush();
			out.close();
			return null;
		}
		TbProperty p = (TbProperty)tb;
		 msg_code_trace = 0;
		Double feeIso = Double.parseDouble(p.getFeeIso());
		msg_code_trace = 1;
		Double houseArea = Double.parseDouble(p.getHouseArea());
		msg_code_trace = 2;
		Double feeTotal = feeIso * houseArea;
		p.setFeeTotal(String.valueOf(feeTotal));
			InputReportImpl.update(p);
			out.print(msg);
			out.flush();
			out.close();
			} catch (java.lang.NumberFormatException e) {
				msg = "输入字段有误,更新失败!";
				if (msg_code_trace == 0) {
					msg = " 更新失败! 原因：<font color='red'>费用标准(元/月)</font>请输入数字！";
				}else if (msg_code_trace == 1) {
					msg = " 更新失败! 原因：<font color='red'>房产面积</font>请输入数字！";
				}else if (msg_code_trace == 2) {
					msg = " 更新失败! 原因：<font color='red'>合计费用 </font>非法！";
				}
			}catch (IOException e) {
				msg = "输入字段有误,更新失败!";
			}finally{
				out.print(msg);
				out.flush();
				out.close();
			}
			return null;
	}
	public String update(HttpServletRequest request,
			HttpServletResponse response, Object tb,
			IInputReportFacade<?> InputReportImpl, BindingResult result)
					throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String msg = "";
		if (result.hasErrors()) {
			msg = "输入有误,添加失败~~~~";
		} else {
			InputReportImpl.update(tb);
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
			@RequestParam int rows, IInputReportFacade<?> InputReportImpl,
			Map<String, String> searchCondition) {
		List<?> list = InputReportImpl.getList(searchCondition, (page - 1)
				* rows, rows);
		long total = InputReportImpl.getPageTotal(searchCondition);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", list);
		return map;
	}

	/**
	 * 根据用户获得角色，角色查找到是否持有当前模块(一般都持有，否则进不来，略)，然后判断用户对此操作持有度
	 * 
	 * @param modelpermiss 
	 * 如notise 则在页面上体现为：noticedelsingle
	 * <c:if test="${sessionScope.noticedelsingle eq 'delsingle'}">删除</c>
	 * @param request
	 * @param response
	 */
	protected void hasOperatePermission(String modelpermiss,
			HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		// String mid = request.getParameter("mid");
		TbAdmUser user = (TbAdmUser) session.getAttribute("user");
		String userid = user.getUserid();
		List<SysRoleUser> roleUsers = roleUserImpl.getRoleUserByUserId(userid);// 获得用户对应的角色
		for (SysRoleUser sysRoleUser : roleUsers) {
			String roleid = sysRoleUser.getSysRole().getRoleId();// 用户对应的角色(一个用户多个角色，这里取到多个角色id)
			List<SysOperateRole> operateRoles = operateRoleImpl
					.getOperateRoleByRoleId(roleid);
			for (SysOperateRole sysOperateRole : operateRoles) {
				SysDd operate = sysOperateRole.getSysOperate().getSysssDd();
				if (operate.getEnname().equalsIgnoreCase(OPERATE_ADD)
						|| (operate.getEnname() == OPERATE_ADD)) {
					session.setAttribute(modelpermiss + OPERATE_ADD,
							OPERATE_ADD);
				}
				if (operate.getEnname().equalsIgnoreCase(OPERATE_UPDATE)) {
					session.setAttribute(modelpermiss + OPERATE_UPDATE,
							OPERATE_UPDATE);
				}
				if (operate.getEnname().equalsIgnoreCase(OPERATE_SEARCH)) {
					session.setAttribute(modelpermiss + OPERATE_SEARCH,
							OPERATE_SEARCH);
				}
				if (operate.getEnname().equalsIgnoreCase(OPERATE_DEL)) {
					session.setAttribute(modelpermiss + OPERATE_DEL,
							OPERATE_DEL);
				}
				if (operate.getEnname().equalsIgnoreCase(OPERATE_CREATE)) {
					session.setAttribute(modelpermiss + OPERATE_CREATE,
							OPERATE_CREATE);
				}
				if (operate.getEnname().equalsIgnoreCase(OPERATE_DELSINGLE)) {
					session.setAttribute(modelpermiss + OPERATE_DELSINGLE,
							OPERATE_DELSINGLE);
				}
				if (operate.getEnname().equalsIgnoreCase(OPERATE_REPLY)) {
					session.setAttribute(modelpermiss + OPERATE_REPLY,
							OPERATE_REPLY);
				}
				if (operate.getEnname().equalsIgnoreCase(OPERATE_CLEARTAB)) {
					session.setAttribute(modelpermiss + OPERATE_CLEARTAB,
							OPERATE_CLEARTAB);
				}
			}
		}

	}
}
