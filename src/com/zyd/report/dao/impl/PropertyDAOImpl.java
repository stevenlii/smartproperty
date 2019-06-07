package com.zyd.report.dao.impl;

import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Repository;

import com.zyd.report.dao.IPropertyDAO;
import com.zyd.report.domain.vo.TbProperty;

@Scope("prototype")
@Repository("propertyDAOImpl")
public class PropertyDAOImpl extends InputDAOImpl<TbProperty> implements
		IPropertyDAO {

	@Override
	public List<TbProperty> getList(int rowStartIdx, int rowTotal) {
		// TODO Auto-generated method stub
		return this.findPaged("from TbProperty t where 1=1 ", rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal() {
		// TODO Auto-generated method stub
		return this
				.findPagedConut("select count(*) from TbProperty t where 1=1 "
						);
	}
	@Override
	public List<TbProperty> getList(String searchCondition, int rowStartIdx,
			int rowTotal) {
		// TODO Auto-generated method stub
		return this.findPaged("from TbProperty t where 1=1 " + searchCondition, rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal(String searchCondition) {
		// TODO Auto-generated method stub
		return this
				.findPagedConut("select count(*) from TbProperty t where 1=1 "
						+ searchCondition);
	}

	@Override
	public List<TbProperty> getAllList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TbProperty getEntityById(String entityId) {
		// TODO Auto-generated method stub
		return this.findUnique("from TbProperty t where t.id ='" + entityId
				+ "'");
	}

	@Override
	public TbProperty avertRedund(String original) {
		// TODO Auto-generated method stub
		return this.findUnique("from TbProperty t where t.id ='" + original
				+ "'");
	}

	@Override
	public void deleteById(String id) {
		// TODO Auto-generated method stub
		this.bulkUpdate("delete from TbProperty t where t.id = ?",
				new Object[] { id });
	}
}
