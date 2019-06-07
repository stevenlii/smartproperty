package com.zyd.report.dao.impl;

import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Repository;

import com.zyd.report.dao.IOwnerHouseDAO;
import com.zyd.report.domain.vo.TbOwnerHouse;

@Scope("prototype")
@Repository("ownerHouseDAOImpl")
public class OwnerHouseDAOImpl extends InputDAOImpl<TbOwnerHouse> implements
		IOwnerHouseDAO {

	@Override
	public List<TbOwnerHouse> getList(int rowStartIdx, int rowTotal) {
		// TODO Auto-generated method stub
		return this.findPaged("from TbOwnerHouse t where 1=1 ", rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal() {
		// TODO Auto-generated method stub
		return this
				.findPagedConut("select count(*) from TbOwnerHouse t where 1=1 "
						);
	}
	@Override
	public List<TbOwnerHouse> getList(String searchCondition, int rowStartIdx,
			int rowTotal) {
		// TODO Auto-generated method stub
		return this.findPaged("from TbOwnerHouse t where 1=1 " + searchCondition, rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal(String searchCondition) {
		// TODO Auto-generated method stub
		return this
				.findPagedConut("select count(*) from TbOwnerHouse t where 1=1 "
						+ searchCondition);
	}

	@Override
	public List<TbOwnerHouse> getAllList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TbOwnerHouse getEntityById(String entityId) {
		// TODO Auto-generated method stub
		return this.findUnique("from TbOwnerHouse t where t.id ='" + entityId
				+ "'");
	}

	@Override
	public TbOwnerHouse avertRedund(String original) {
		// TODO Auto-generated method stub
		return this.findUnique("from TbOwnerHouse t where t.id ='" + original
				+ "'");
	}

	@Override
	public void deleteById(String id) {
		// TODO Auto-generated method stub
		this.bulkUpdate("delete from TbOwnerHouse t where t.id = ?",
				new Object[] { id });
	}
}
