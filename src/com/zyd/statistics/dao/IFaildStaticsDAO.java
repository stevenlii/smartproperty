package com.zyd.statistics.dao;

import java.util.List;
/**
 * 未妥投dao接口
 * @author liu_gl
 *
 * @param <T>
 */
public interface IFaildStaticsDAO<T>{
	public List<T> getList(String sql);
}
