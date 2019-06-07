package com.zyd.xtgl.logic.impl;

import java.util.List;
import java.util.Map;

import com.zyd.xtgl.logic.IInputFacade;

public abstract class InputImpl<T> implements IInputFacade<T> {

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
	public List<T> getList(int rowStartIdx, int rowTotal) {
		return null;
	};

	@Override
	public long getPageTotal() {
		return 0;
	};

	@Override
	public abstract void update(Object entity);

	protected String search_TbtypeCondition(Map<String, String> map) {
		StringBuffer search = new StringBuffer();
		String tbtype = map.get("tbtype");// 表型
		String typeCode = map.get("typeCode");// 种类加强
		search.append("");
		if (tbtype != null && !(tbtype.equals(""))) {
			search.append(" and type = '" + tbtype + "'");
		}
		if (typeCode != null && !(typeCode.equals(""))) {
			search.append(" and typeCode = '" + typeCode + "'");
		}
		return search.toString();
	}
}
