package com.zyd.report.logic;

import java.util.Map;
/**
 * 针对装载数据的查询接口
 * @author lzq
 *
 */
public interface IImportSearchFacade {
	/**
	 * 针对装载数据的查询方法
	 * @param map
	 * @return
	 */
	public String search(Map<String, String> map);

	 
}
