package com.zyd.report.web.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.ConstraintViolationException;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.zyd.exception.FieldNullException;
import com.zyd.report.logic.IImportReportFacade;
import com.zyd.xtgl.domain.vo.SysDd;
import com.zyd.xtgl.domain.vo.SysOperateRole;
import com.zyd.xtgl.domain.vo.SysRoleUser;
import com.zyd.xtgl.domain.vo.TbAdmUser;
import com.zyd.xtgl.logic.IOperateRoleFacade;
import com.zyd.xtgl.logic.IRoleUserFacade;

/**
 * 此类是导入功能的父类
 * 
 * @author li_zq
 * 
 */
public class ImportAction {
	protected static final String MSG_UPLOAD_NO_MONTH = "请选择结算日期后上传";
	protected static final String MSG_UPLOAD_NO_TBTYPE = "文件类型为空，请联系管理员";
	protected static final String MSG_UPLOAD_NO_AGENT = "请选择代理商后上传";
	protected static final String MSG_DEL_NO_TBNAME = "表来源名不能为空!";
	protected static final String MSG_DEL_NO_TBTYPE = "表类型不能为空!";
	protected static final String MSG_DEL_FAIL = "未知原因导致数据删除失败!!!请联系管理员~~~";
	protected static final String MSG_DEL_FAIL_DATE = "未知原因导致数据删除失败!!!请联系管理员~~~";
	protected static final String MSG_DEL_FAIL_FILE = "文件被占用或者其它原因导致数据删除失败!!!请联系管理员~~~";
	protected static final String MSG_DEL_FAIL_DATEUFILE = "未知原因导致数据及文件删除失败!!!请联系管理员~~~";
	protected static final String MSG_DEL_SUCCESS = "删除成功！";
	protected static final String MSG_DEL_SUCCESS_DATE = "关联数据！";
	protected static final String MSG_DEL_SUCCESS_FILE = "成功删除后台备份文件：";
	protected static final String MSG_DEL_SUCCESS_DATEUFILE = "关联数据和后台备份文件！";
	protected static final String MSG_DELMAP_NO_TBTYPE = "NOTBTYPE";

	protected static final String OPERATE_ADD = "add";
	protected static final String OPERATE_DEL = "del";
	protected static final String OPERATE_UPDATE = "update";
	protected static final String OPERATE_SEARCH = "search";
	protected static final String OPERATE_CREATE = "create";
	protected static final String OPERATE_DELSINGLE = "delsingle";
	protected static final String OPERATE_REPLY = "reply";
	protected static final String OPERATE_CLEARTAB = "cleartab";
	protected static final String OPERATE_COLLECT = "collect";
	protected static final String OPERATE_DELETE = "delete";

	@Resource(name = "roleUserImpl")
	private IRoleUserFacade roleUserImpl;
	@Resource(name = "operateRoleImpl")
	private IOperateRoleFacade operateRoleImpl;

	public ImportAction() {
		super();
	}

	/**
	 * 上传方法
	 * 
	 * @param request
	 *            页面请求
	 * @param response
	 *            页面响应
	 * @param importReportFacade
	 *            实现上传接口的参数
	 * @throws IOException
	 *             导入数据失败，将抛出IOExcption
	 */
	protected void uploadfiletools(HttpServletRequest request,
			HttpServletResponse response,
			IImportReportFacade<?> importReportFacade, Map<String, String> map)
			throws IOException {
		String uploadmsg = "上传成功!";
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String savePath = request.getSession().getServletContext()
				.getRealPath("\\")
				+ "uploadfile\\";
		String backPath = request.getSession().getServletContext()
				.getRealPath("\\")
				+ "backfile\\";
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile mfile = multipartRequest.getFile("myfile");// 注意这里要同第3步中fileDataName的值相同
		String originalFilename = mfile.getOriginalFilename();// 获得文件名+后缀名
		File backFile = new File(backPath + originalFilename);
		File file = new File(savePath + mfile.getOriginalFilename());
		String path = savePath + mfile.getOriginalFilename();
		map.put("filename", originalFilename);
		map.put("path", path);

		if (mfile.getSize() == 0) {
			out.print("请您选择上传文件~");
		} else if (backFile.exists() || file.exists()) {
			out.print("数据已经上传，请不要重复上传~~");
		} else {
			mfile.transferTo(file);
			try {
				Map<String, String> afterImportMap = importReportFacade
						.uploadimportReport(map);
				uploadmsg = "上传信息：<br/>成功上传条数："
						+ afterImportMap.get("importSuccessNum")
						+ " 重数条数："
						+ afterImportMap.get("importDuplicateNum")
						+ "<br/> <a href='/tdgh/import.do?method=toimportresultmain' target='_blank'><font color=\"red\">更多细节>></font></a>";
				Map<String, String> ImportMSG = new HashMap<String, String>();
				ImportMSG.put("importDuplicateNum",
						afterImportMap.get("importDuplicateNum"));
				ImportMSG.put("importSuccessNum",
						afterImportMap.get("importSuccessNum"));
				ImportMSG.put("importSuccess",
						afterImportMap.get("importSuccess"));
				request.getSession().setAttribute("importMap", ImportMSG);
				Map<String, String> DuplicateMSG = afterImportMap;
				DuplicateMSG.remove("importDuplicateNum");
				DuplicateMSG.remove("importSuccessNum");
				DuplicateMSG.remove("importSuccess");
				request.getSession().setAttribute("duplicateMap", DuplicateMSG);

				// 备份上传的文件到目录/backFile里面
				FileCopyUtils.copy(file, backFile);
			} catch (FieldNullException e) {
				uploadmsg = e.getMessage();
				e.printStackTrace();
			} catch (ConstraintViolationException e) {
				uploadmsg = "请检查装载表，重要字段不允许为空！";
				e.printStackTrace();
			} catch (IOException e) {
				uploadmsg = "装载发生错误，请检查装载表格式！";
				e.printStackTrace();
			} catch (Exception e) {
				uploadmsg = "上传失败~~~,请检查数据格式是否正确~~~,错误代码:" + e.getMessage();
				e.printStackTrace();
			} finally {
				// 删除上传的文件
				file.delete();
				out.print(uploadmsg);
				if (out != null) {
					out.flush();
					out.close();
				}
			}
		}

	}

	/**
	 * 
	 * 删除方法
	 * 
	 * @param request
	 * @param response
	 * @param importReportFacade
	 * @param map
	 * @return
	 * @throws IOException
	 */
	protected synchronized Map<String, String> delete(
			HttpServletRequest request, HttpServletResponse response,
			IImportReportFacade<?> importReportFacade, Map<String, String> map)
			throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String backPath = request.getSession().getServletContext()
				.getRealPath("\\")
				+ "backfile\\";
		String tbType = request.getParameter("tbType").trim();
		String tbName = request.getParameter("tbName").trim();

		long hasdatelong = 0;// 如果数据为0，则数据库里面没有数据
		File delFile = null;
		boolean hasdate = false;
		if (tbName != null && !(tbName.isEmpty())) {
			delFile = new File(backPath + tbName);
			if (tbType != null && !(tbType.equals(MSG_DELMAP_NO_TBTYPE))) {
				map.put("tbType", tbType);
				map.put("tbName", tbName);
			} else {
				map.put("tbName", tbName);
				map.put("tbType", null);
			}
		} else {
			out.print(MSG_DEL_NO_TBNAME);
			return null;
		}
		hasdatelong = importReportFacade.getPageTotal(map);
		if (0 == hasdatelong && !(delFile.exists())) {
			out.print("对不起，数据库中没有 <font color=\"red\">" + tbName
					+ "</font> 的相关数据或文件!");
			return null;
		} else {
			String confirmOk = request.getParameter("confirmOk").trim();
			if (confirmOk != null && confirmOk.equals("ok")) {
				if (0 != hasdatelong || (delFile.exists())) {// 存在数据或者文件
					if (0 != hasdatelong && (delFile.exists())) {
						hasdate = importReportFacade.delete(map);// hasdate为true为删除失败
						boolean isdelfile = delFile.delete();// isdelfile为true为删除成功
						if (hasdate && !isdelfile) {
							if (hasdate) {
								out.print(MSG_DEL_FAIL);
							} else if (!isdelfile) {
								out.print(MSG_DEL_FAIL_FILE);
							}

						} else if (!hasdate || isdelfile) {
							if (!hasdate && isdelfile) {
								out.print("成功删除  <font color=\"red\">" + tbName
										+ "</font> "
										+ MSG_DEL_SUCCESS_DATEUFILE);
							} else if (!hasdate && !isdelfile) {
								out.print("成功删除  <font color=\"red\">" + tbName
										+ "</font> " + MSG_DEL_SUCCESS_DATE
										+ "<BR/><font color=\"red\">"
										+ MSG_DEL_FAIL_FILE + "</font>");
							} else if (hasdate && isdelfile) {
								out.print("成功删除  <font color=\"red\">" + tbName
										+ "</font> " + MSG_DEL_SUCCESS_DATE
										+ "<BR/><font color=\"red\">"
										+ MSG_DEL_FAIL + "</font>");
							}
						}
					} else if (0 != hasdatelong && !(delFile.exists())) {// 文件为空，数据不为空
						hasdate = importReportFacade.delete(map);// hasdate为true为删除失败
						if (hasdate) {
							out.print(MSG_DEL_FAIL);
						} else {
							out.print("成功删除  <font color=\"red\">" + tbName
									+ "</font> 关联数据!");
						}
					} else if (0 == hasdatelong && (delFile.exists())) {// 文件不为空，数据为空
						boolean isdelfile = delFile.delete();// isdelfile为true为删除成功
						if (!isdelfile) {
							out.print(MSG_DEL_FAIL_FILE);
						} else {
							out.print(MSG_DEL_SUCCESS_FILE
									+ " <font color=\"red\">" + tbName
									+ "</font> !");
						}
					}
				}
			} else {// 删除提示
				if (0 != hasdatelong && (delFile.exists())) {
					out.print("delconfirm");
				} else if (0 != hasdatelong && !(delFile.exists())) {
					out.print("deldate");
				} else if (0 == hasdatelong && (delFile.exists())) {
					out.print("delfile");
				}
			}

		}
		return map;
	}

	/**
	 * 分页方法
	 * 
	 * @param page
	 *            获得页面页码数
	 * @param rows
	 *            行数
	 * @param entityImportReportImpl
	 *            实现IImportReportFacade接口的类
	 * @return 查询条件的Map
	 */
	protected Map<String, Object> getList(int page, int rows,
			IImportReportFacade<?> entityImportReportImpl,
			Map<String, String> searchCondition) {
		List<?> list = null;
		long total = 0;
		// 调用查询方法，返回查询List和查询总条数
		list = entityImportReportImpl.getList(searchCondition, (page - 1)
				* rows, rows);
		total = entityImportReportImpl.getPageTotal(searchCondition);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", list);
		return map;
	}

	/**
	 * 获得页面参数
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	protected Map<String, String> getParam(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		String tbmonth = request.getParameter("tbmonth");
		Map<String, String> map = new HashMap<String, String>();
		if (tbmonth != null && !(tbmonth.isEmpty())) {
			map.put("tbmonth", tbmonth);
		} else {
			response.getWriter().print(MSG_UPLOAD_NO_MONTH);
			return null;
		}
		return map;
	}

	/**
	 * 根据用户获得角色，角色查找到是否持有当前模块(一般都持有，否则进不来，略)，然后判断用户对此操作持有度
	 * 
	 * @param modelpermiss
	 * @param request
	 * @param response
	 */
	protected void hasOperatePermission(String modelpermiss,
			HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
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
				if (operate.getEnname().equalsIgnoreCase(OPERATE_COLLECT)) {
					session.setAttribute(modelpermiss + OPERATE_COLLECT,
							OPERATE_COLLECT);
				}
				if (operate.getEnname().equalsIgnoreCase(OPERATE_DELETE)) {
					session.setAttribute(modelpermiss + OPERATE_DELETE,
							OPERATE_DELETE);
				}

			}
		}

	}
}