package com.zyd.report.dao.impl;

import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Repository;

import com.zyd.report.dao.IOwnerDAO;
import com.zyd.report.domain.vo.TbOwner;

@Scope("prototype")
@Repository("ownerDAOImpl")
public class OwnerDAOImpl extends InputDAOImpl<TbOwner> implements
		IOwnerDAO {

	@Override
	public List<TbOwner> getList(int rowStartIdx, int rowTotal) {
		// TODO Auto-generated method stub
		return this.findPaged("from TbOwner t where 1=1 ", rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal() {
		// TODO Auto-generated method stub
		return this
				.findPagedConut("select count(*) from TbOwner t where 1=1 "
						);
	}
	@Override
	public List<TbOwner> getList(String searchCondition, int rowStartIdx,
			int rowTotal) {
		// TODO Auto-generated method stub
		return this.findPaged("from TbOwner t where 1=1 " + searchCondition, rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal(String searchCondition) {
		// TODO Auto-generated method stub
		return this
				.findPagedConut("select count(*) from TbOwner t where 1=1 "
						+ searchCondition);
	}

	@Override
	public List<TbOwner> getAllList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TbOwner getEntityById(String entityId) {
		// TODO Auto-generated method stub
		return this.findUnique("from TbOwner t where t.id ='" + entityId
				+ "'");
	}

	@Override
	public TbOwner avertRedund(String original) {
		// TODO Auto-generated method stub
		return this.findUnique("from TbOwner t where t.id ='" + original
				+ "'");
	}

	@Override
	public void deleteById(String id) {
		// TODO Auto-generated method stub
		this.bulkUpdate("delete from TbOwner t where t.id = ?",
				new Object[] { id });
	}
}
