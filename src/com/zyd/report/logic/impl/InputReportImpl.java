package com.zyd.report.logic.impl;

import java.util.List;
import java.util.Map;

import com.zyd.xtgl.logic.IInputFacade;
/**
 * 封装录入的常用方法
 * @author li_zq
 *
 * @param <T>
 */
public abstract  class InputReportImpl<T> implements IInputFacade<T> {

	
	@Override
	public abstract T avertRedund(String original);

	@Override
	public abstract void create(Object tb);

	@Override
	public void saveOrUpdate(T entity) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addList(List<T> list) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public abstract void deleteById(String id);

	@Override
	public void deleteObject(T entity) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteAll(List<?> list) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void batchSave(List<T> entityList) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public  List<T> getList(int rowStartIdx, int rowTotal) {
		return null;};

	@Override
	public  long getPageTotal(){
		return 0;} ;

	@Override
	public abstract void update(Object entity);
	protected String getSearchInCostsumCondition(Map<String, String> map) {
		StringBuffer search = new StringBuffer();
		String tbtype = map.get("tbtype");// 表型
		search.append("");
		if (tbtype != null && !(tbtype.equals(""))) {
			search.append(" and tbType = '" + tbtype + "'");
		}
		return search.toString();
	}
	}
