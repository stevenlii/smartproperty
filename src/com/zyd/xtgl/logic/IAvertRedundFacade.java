package com.zyd.xtgl.logic;

public interface IAvertRedundFacade<T> {
	/**
	 * 防止数据重复
	 * @param original重复依据参数
	 * @return 实体类
	 */
	public T avertRedund(String original);
}
