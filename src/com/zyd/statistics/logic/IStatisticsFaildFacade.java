package com.zyd.statistics.logic;

import java.util.List;
import java.util.Map;
/**
 * 未妥投service接口
 * @author liu_gl
 *
 */
public interface IStatisticsFaildFacade {
	/**
	 * 针对装载数据的统计方法
	 * @param map
	 * @return
	 */
	public String Statistics(Map<String, String> map);
	public List<Object[]> getFaildList(String sql);
}
