package com.zyd.xtgl.dao.impl;

import java.util.List;

import org.springframework.context.annotation.Scope;

import com.zyd.common.GenericHibernateDao;
import com.zyd.xtgl.dao.IInputDAO;

@Scope("prototype")
public abstract class InputDAOImpl<T> extends GenericHibernateDao<T> implements
		IInputDAO<T> {

	@Override
	public T avertRedund(String original) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteById(String id) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<T> getList(int rowStartIdx, int rowTotal) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public long getPageTotal() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean hasPrivilege(String OperateId, String userId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<T> avertRedundList(String original) {
		// TODO Auto-generated method stub
		return null;
	}
}
