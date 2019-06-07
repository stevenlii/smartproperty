package com.zyd.xtgl.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.zyd.xtgl.dao.IDdDAO;
import com.zyd.xtgl.domain.vo.SysDd;

@Repository("ddDAOImpl")
public class DdDAOImpl extends InputDAOImpl<SysDd> implements IDdDAO {

	@Override
	public SysDd avertRedund(String original) {
		// TODO Auto-generated method stub
		return this.findUnique("from SysDd t where t.id ='" + original + "'");
	}

	@Override
	public void deleteById(String id) {
		// TODO Auto-generated method stub
		this.bulkUpdate("delete from SysDd t where t.id = ?",
				new Object[] { id });
	}

	@Override
	public List<SysDd> getList(int rowStartIdx, int rowTotal) {
		// TODO Auto-generated method stub
		return this.findPaged("from SysDd t", rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal() {
		// TODO Auto-generated method stub
		return this.findPagedConut("select count(*) from SysDd t");
	}

	@Override
	public List<SysDd> getList(String searchCondition, int rowStartIdx,
			int rowTotal) {
		// TODO Auto-generated method stub
		return this.findPaged("from SysDd t where 1=1 " + searchCondition,
				rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal(String searchCondition) {
		// TODO Auto-generated method stub
		return this.findPagedConut("select count(*) from SysDd t where 1=1 "
				+ searchCondition);
	}

	@Override
	public boolean hasPrivilege(String OperateId, String userId) {
		// TODO Auto-generated method stub
		return super.hasPrivilege(OperateId, userId);
	}

	@Override
	public List<SysDd> avertRedundList(String original) {
		// TODO Auto-generated method stub
		return super.avertRedundList(original);
	}

	@Override
	public List<SysDd> getAllList() {
		// TODO Auto-generated method stub
		return this.find("from SysDd t");
	}

	@Override
	public SysDd getEntityById(String entityId) {
		// TODO Auto-generated method stub
		return findById(new SysDd(),entityId);
	}

	@Override
	public List<SysDd> getList(String search) {
		// TODO Auto-generated method stub
		return this.find("from SysDd t where 1=1 "+ search);
	}

}
