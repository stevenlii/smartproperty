package com.zyd.common;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.zyd.xtgl.domain.vo.TbAdmUser;

public class GeneralTools {
	//request.getSession().getServletContext().getRealPath("\\")+ "backfile\\"+"export.txt"
	public static final String EXPORT_TEMP_PATH="D://export.txt";//导出文件临时文件
	public static final String EXPORT_TEMP_PATH_EXCEL="D://exportEXCEL.xls";//导出文件临时文件
	private static final String NO_DOUBLE_QUOTES_HEAD = "^\"";
	private static final String NO_DOUBLE_QUOTES_Tail = "\"$";
	private static Pattern pattern1;
	private static Pattern pattern2;
	private static Matcher matcher;
	private static Matcher matcher2;

	/**
	 * 去除字符串首尾的双引号
	 * 
	 * @param doubleQuotes
	 *            有双引号的参数
	 * @return 无双引号的字符串
	 */
	public static String noDoubleQuotes(String doubleQuotes) {
		String result = "";
		pattern1 = Pattern.compile(NO_DOUBLE_QUOTES_HEAD);
		pattern2 = Pattern.compile(NO_DOUBLE_QUOTES_Tail);
		matcher = pattern1.matcher(doubleQuotes);
		result = matcher.replaceAll("");
		matcher2 = pattern2.matcher(result);
		return matcher2.replaceAll("");
	}

	/**
	 * * tomcat项目下临时文件路径
	 * 
	 * @param projectName
	 *            项目名称
	 * @return
	 */
	public static String tomcatTempDir(String projectName) {
		String nowPath;
		String tempPath;
		nowPath = System.getProperty("user.dir");
		tempPath = nowPath.replace("bin", "webapps");
		tempPath += "\\" + projectName;
		return tempPath;
	}

	/**
	 * 正则匹配，验证字符串是否为数字
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNumber(String str) {
		java.util.regex.Pattern pattern = java.util.regex.Pattern
				.compile("[0-9]*");
		java.util.regex.Matcher match = pattern.matcher(str);
		if (match.matches() == false) {
			return false;
		} else {
			return true;
		}
	}
	/**
	 * 正则匹配，获取字符串中的数字，不匹配就返回空字符
	 * 
	 * @param str
	 * @return 
	 */
	public static String getNumber(String stringNum) {
		String str = "";
        if(stringNum != null){
            for (int i = 0; i < stringNum.length(); i++) { 
                 char c = stringNum.charAt(i); 
                 if(c >= '0' && c <= '9' || c == '.'){
                     if(str != null){
                         str = str + Character.toString(c);
                     }else{
                         str = Character.toString(c);
                     }
                     
                 }
             }
        }
        return str;  
	}
	
	/**
	 * 获取user的session中的companyCode数据
	 * 
	 * @author YXM
	 * @param String st
	 * @return String 
	 * 
	 */
	public static String getUserToComCode(String st){
		
		String[] code = null ;
		
		StringBuffer str = new StringBuffer();
		
		if(st !=null&&!st.equals("")){
			
			code = st.split(",");
			
			for (int i = 0; i < code.length; i++) {
				
				str.append("'"+code[i]+"',");
				
			}
			
			return str.toString().substring(0,str.toString().length()-1);
		}else{
			
			return "no_company";
			
		}
		
	}

}