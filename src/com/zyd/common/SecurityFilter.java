package com.zyd.common;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 登录过滤
 * 
 * @author liu_gl
 * @date 2012-4-18
 */
public class SecurityFilter implements Filter {

	private final static String[] eixt_url = { "login.jsp", "/js", "/css",
			"/images", "/help", "/uploadify","/My97DatePicker", "/jeasyui", "login.do" }; // 不用做权限判断的URL

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws ServletException, IOException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		boolean haveFind = true;
		// 判断URL中包含.jsp和.do的都需要过滤
		if (req.getRequestURI().indexOf(".jsp") >= 0
				|| req.getRequestURI().indexOf(".do") >= 0)
			haveFind = false;
		// 循环判断不需要过滤的资源
		for (int i = 0; i < eixt_url.length; i++) {
			if (req.getRequestURI().indexOf(eixt_url[i]) >= 0) {
				haveFind = true;
				break;
			}
		}
		/**
		 *  需要过滤的资源和用户为空同时满足转向到登录页面
		 *  这里使用script方式转向，为了防止Iframe嵌套问题。
		 */
		if (!haveFind && req.getSession().getAttribute("user") == null) {
			res.setContentType("text/html;charset=UTF-8");
			PrintWriter	out = res.getWriter();
			StringBuffer strb = new StringBuffer();
			strb.append("<script type='text/javascript'>");
			strb.append("alert('没有登录系统或者是会话过期，请从新登录系统！');");
			strb.append("top.location.href='"+req.getContextPath()+"/login.jsp'");
			strb.append("</script>");
			out.print(strb.toString());
			out.close();
			return;
		}
		chain.doFilter(req, res);
	}

	public void init(FilterConfig filterConfig) throws ServletException {
	}

	public void destroy() {
	}

}
