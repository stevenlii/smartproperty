package com.zyd.common;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

public class AjaxUtils {
	// 对象转换成Json
	@SuppressWarnings("deprecation")
	public static String ajaxList(HttpServletRequest request,
			HttpServletResponse response, Object obj) {
		response.setContentType("text/html;charset=UTF-8");
		ObjectMapper objmap = new ObjectMapper();
		objmap.getSerializationConfig().setDateFormat(
				new SimpleDateFormat("yyyy-MM-dd"));
		try {
			objmap.writeValue(response.getWriter(), obj);
			// String x = objmap.writeValueAsString(obj);
			// System.out.print(x);
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}
