package com.zyd.statistics.logic;

import java.util.Map;
/**
 * 针对装载数据的统计接口
 * @author lzq
 *
 */
public interface IStatisticsStrategyFacade {
	/**
	 * 针对装载数据的统计方法
	 * @param map
	 * @return
	 */
	public String Statistics(Map<String, String> map);
}
