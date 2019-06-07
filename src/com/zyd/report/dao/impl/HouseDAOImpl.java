package com.zyd.report.dao.impl;

import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Repository;

import com.zyd.report.dao.IHouseDAO;
import com.zyd.report.domain.vo.TbHouse;
import com.zyd.xtgl.domain.vo.TbAdmDept;

@Scope("prototype")
@Repository("houseDAOImpl")
public class HouseDAOImpl extends InputDAOImpl<TbHouse> implements
		IHouseDAO {

	@Override
	public List<TbHouse> getList(int rowStartIdx, int rowTotal) {
		// TODO Auto-generated method stub
		return this.findPaged("from TbHouse t where 1=1 ", rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal() {
		// TODO Auto-generated method stub
		return this
				.findPagedConut("select count(*) from TbHouse t where 1=1 "
						);
	}
	@Override
	public List<TbHouse> getList(String searchCondition, int rowStartIdx,
			int rowTotal) {
		// TODO Auto-generated method stub
		return this.findPaged("from TbHouse t where 1=1 " + searchCondition, rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal(String searchCondition) {
		// TODO Auto-generated method stub
		return this
				.findPagedConut("select count(*) from TbHouse t where 1=1 "
						+ searchCondition);
	}

	@Override
	public List<TbHouse> getAllList() {
		List<TbHouse> list = this
				.find(" from TbHouse t ");
		return list;
	}

	@Override
	public TbHouse getEntityById(String entityId) {
		// TODO Auto-generated method stub
		return this.findUnique("from TbHouse t where t.id ='" + entityId
				+ "'");
	}

	@Override
	public TbHouse avertRedund(String original) {
		// TODO Auto-generated method stub
		return this.findUnique("from TbHouse t where t.id ='" + original
				+ "'");
	}

	@Override
	public void deleteById(String id) {
		// TODO Auto-generated method stub
		this.bulkUpdate("delete from TbHouse t where t.id = ?",
				new Object[] { id });
	}
}
