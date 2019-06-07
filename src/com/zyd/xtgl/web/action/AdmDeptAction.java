package com.zyd.xtgl.web.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zyd.common.CommonController;
import com.zyd.xtgl.domain.vo.TbAdmDept;
import com.zyd.xtgl.domain.vo.TbAdmUser;
import com.zyd.xtgl.logic.IAdmDeptFacade;
import com.zyd.xtgl.logic.IAdmUserFacade;

@Controller
@RequestMapping("/AdmDept")
public class AdmDeptAction extends CommonController {
	private IAdmUserFacade admUserImpl; 
	private IAdmDeptFacade admDeptImpl;

	@Resource(name = "admDeptImpl")
	public void setAdmDeptImpl(IAdmDeptFacade admDeptImpl) {
		this.admDeptImpl = admDeptImpl;
	}

	@Resource(name = "admUserImpl")
	public void setAdmUserImpl(IAdmUserFacade admUserImpl) {
		this.admUserImpl = admUserImpl;
	}

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
		List<TbAdmDept> deptlist = admDeptImpl.getDeptPageList((page - 1)
				* rows, rows,"");
		long total = admDeptImpl.getDeptPageCount("");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", deptlist);
		return map;
	}
	/**
	 * 获取能查看的入网公司
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getComList")
	@ResponseBody
	public Map<String,Object> getComList(HttpServletRequest request,
			HttpServletResponse response,@RequestParam int page,
			@RequestParam int rows){
		String userid = request.getParameter("userid");
		TbAdmUser user = admUserImpl.getByUserid(userid);
		Map<String, Object> map = new HashMap<String, Object>();
		long total = 0;
		String codeIds = "";
		List<TbAdmDept> deptlist = new ArrayList<TbAdmDept> () ;
		if(user.getAccessCompany() != null && !user.getAccessCompany().equals("")){
			String[] s = user.getAccessCompany().split(",");
			StringBuffer str = new StringBuffer("'") ;
			for (int i = 0; i < s.length; i++) {
				str.append(s[i]+"','");
			}
		codeIds = str.toString().substring(0, str.length()-2);
		deptlist = admDeptImpl.getDeptPageList((page - 1)
				* rows, rows , codeIds);
		total = admDeptImpl.getDeptPageCount(codeIds);
		map.put("total", total);
		map.put("rows", deptlist);
		return map;
		}else{
			map.put("total", total);
			map.put("rows", deptlist);
			return map;
		}
		
		
	}
	/**
	 * 查看所有入网公司
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getComAllList")
	@ResponseBody
	public Map<String,Object> getAllComList(HttpServletRequest request,
			HttpServletResponse response,@RequestParam int page,
			@RequestParam int rows){
		String userid = request.getParameter("userid");
		TbAdmUser user = admUserImpl.getByUserid(userid);
		Map<String, Object> map = new HashMap<String, Object>();
		String codeIds = "";
		if(user.getAccessCompany() != null && !user.getAccessCompany().equals("")){
			String[] s = user.getAccessCompany().split(",");
			StringBuffer str = new StringBuffer("'") ;
			for (int i = 0; i < s.length; i++) {
				str.append(s[i]+"','");
			}
		codeIds = str.toString().substring(0, str.length()-2);
		}
		List<TbAdmDept> deptlist = admDeptImpl.getDeptPageAllList((page - 1)
				* rows, rows , codeIds);
		long total = admDeptImpl.getDeptPageAllCount(codeIds);
		map.put("total", total);
		map.put("rows", deptlist);
		return map;

	}
	/**
	 * 添加公司到用户
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=addComToUser")
	public String addComToUser(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String userId = request.getParameter("userId");
		String comIds = request.getParameter("comIds");
		TbAdmUser user = admUserImpl.getByUserid(userId);
		if(user.getAccessCompany() != null && !user.getAccessCompany().equals("")){
			String company = comIds+","+user.getAccessCompany();
			user.setAccessCompany(company);
		}else{
			user.setAccessCompany(comIds);
		}
		try {
			admUserImpl.updateUser(user);
		} catch (Exception e) {
			out.print("添加失败");
			e.printStackTrace();
		}
		out.print("添加成功~~");
		out.flush();
		out.close();
		return null;
	}
	/**
	 * 删除所查看的公司从用户中
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(params = "method=deleteComFromUser")
	@ResponseBody
	public String deleteComFromUser(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String userId = request.getParameter("userId");
		String comIds = request.getParameter("comIds");
		TbAdmUser user = admUserImpl.getByUserid(userId);
		String com = user.getAccessCompany()+","+comIds;
		String[] users =com.split(",");
		List<String> list=new ArrayList<String>();
		for(int i=0;i<users.length;i++){
			boolean b=false;
			for(int j=0;j<users.length;j++){
				if(i!=j){
					if(users[i].equals(users[j])){
						b=true;
					}
				}
			}
			if(!b){
				list.add(users[i]);
			}
		}
		String[] str=new String[list.size()];
		int n=0;
		StringBuffer sb = new StringBuffer();
		for (Object st : list) {
			str[n]=st.toString();
			n++;
			sb.append(st+",");
		}
	    user.setAccessCompany(sb.toString().substring(0, sb.toString().length()-1));
	    admUserImpl.updateUser(user);
		out.print("删除成功~~");
		out.flush();
		out.close();
		return null;
	}
	/**
	 * 获取所有公司信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getDeptList")
	@ResponseBody
	public List<TbAdmDept> getDeptList(HttpServletRequest request,
			HttpServletResponse response) {
		List<TbAdmDept> list = admDeptImpl.getAllDeptList();
		return list;
	}

	/**
	 * 公司列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getListbyAdmDept")
	@ResponseBody
	public List<TbAdmDept> getListbyZdtype(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, String> searchCondition = new HashMap<String, String>();
		searchCondition.put("companytypeflag", request.getParameter("companytypeflag"));
		List<TbAdmDept> list = admDeptImpl.getList(searchCondition);
		return list;
	}
	
	
	/**
	 * 公司管理列表页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "method=getDeptMain")
	public ModelAndView getDeptMain(HttpServletRequest request,
			HttpServletResponse response) {
		return new ModelAndView("xtgl/deptlist");
	}

	/**
	 * 添加公司
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(params = "method=addDept", method = RequestMethod.POST)
	public String addDept(HttpServletRequest request,
			HttpServletResponse response,
			@ModelAttribute("deptform") @Valid TbAdmDept deptBean,
			BindingResult result) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String msg = "";
		if (result.hasErrors()) {
			msg = "输入有误,添加公司失败~~~~";
		} else if (admDeptImpl.checkDeptName(deptBean)) {
			msg = "添加失败，公司名称重复~~";
		} else {
			admDeptImpl.addDept(deptBean);
			msg = "添加成功~~";
		}
		out.print(msg);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 删除公司
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(params = "method=deleteDept")
	public String deleteDept(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String deptid = request.getParameter("deptid");
		List<TbAdmUser> list = admUserImpl.getUserListOfDept(deptid);
		String msg = "";
		if (list.size() > 0) {
			msg = "部门正在被使用，不能删除~~";
		} else {
			admDeptImpl.delDept(deptid);
			msg = "删除成功~~";
		}
		out.print(msg);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 更新公司信息
	 * 
	 * @param request
	 * @param response
	 * @param deptBean
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(params = "method=updateDept")
	public String updateDept(HttpServletRequest request,
			HttpServletResponse response,
			@ModelAttribute("deptform") @Valid TbAdmDept deptBean,
			BindingResult result) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		admDeptImpl.updateDept(deptBean);
		out.print("更新成功~~");
		out.flush();
		out.close();
		return null;
	}
}
