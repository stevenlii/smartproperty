package com.zyd.statistics.logic;

import java.util.List;
import java.util.Map;
/**
 * 针对装载数据的统计接口
 * @author lzq
 *
 */
public interface IStatisticsFacade {
	/**
	 * 针对装载数据的统计方法
	 * @param map
	 * @return
	 */
	public List<?> Statistics(Map<String, String> map);
}
