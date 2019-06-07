package com.zyd.statistics.dao;

import java.util.List;
import java.util.Map;
/**
 * 统计的DAO接口，所有的统计数据都应该通过此接口调用数据库相关信息
 * @author li_zq
 *
 * @param <T>
 */
public interface IStaticsDAO<T>{
	public List<T> getStaticsList(Map<String, String> columnName,
			String StaticsCondition);
}
