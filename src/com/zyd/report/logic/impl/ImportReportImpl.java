package com.zyd.report.logic.impl;

import java.util.Map;

import com.zyd.report.logic.IImportReportFacade;

/**
 * 装载的抽象类，所有拥有装载业务的实现类，应该是此抽象类的子类
 * @author lzq
 * 
 * @param <T>
 */
public abstract class ImportReportImpl<T> implements IImportReportFacade<T> {
	protected static final String NOECODE = "(入网企业代码)";

	/**
	 * 根据表来源名和表类型删除数据
	 * 
	 * @param map
	 * @return
	 */
	public String search_Delete(Map<String, String> map) {
		StringBuffer deleteCondition = new StringBuffer();
		deleteCondition.append("");
		String tbType = map.get("tbType");
		String tbName = map.get("tbName");
		if (tbType != null && !(tbType.isEmpty())) {
			deleteCondition.append(" and t.tbType= '" + tbType + "'");
		}
		if (tbName != null && !(tbName.isEmpty())) {
			deleteCondition.append(" and t.tbName= '" + tbName + "'");
		}
		return deleteCondition.toString();

	}
}
