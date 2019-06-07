package com.zyd.xtgl.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.zyd.common.GenericHibernateDao;
import com.zyd.xtgl.dao.ISjzdDAO;
import com.zyd.xtgl.domain.vo.TbSjzd;
@Repository("sjzdDAOImpl")
public class SjzdDAOImpl extends GenericHibernateDao<TbSjzd> implements ISjzdDAO {

	@Override
	public void addSjzd(TbSjzd sjzd) {
		// TODO Auto-generated method stub
		this.create(sjzd);

	}

	@Override
	public void deleteSjzd(TbSjzd sjzd) {
		// TODO Auto-generated method stub
		this.deleteObject(sjzd);

	}

	@Override
	public void deleteSjzd(String id) {
		// TODO Auto-generated method stub
		this.bulkUpdate("delete TbSjzd t where t.id=?", new Object[]{id});

	}

	@Override
	public void updateSjzd(TbSjzd sjzd) {
		// TODO Auto-generated method stub
		this.update(sjzd);

	}

	@Override
	public List<TbSjzd> getAllList() {
		// TODO Auto-generated method stub
		return this.find("from TbSjzd t");
	}

	@Override
	public List<TbSjzd> getListByZdtype(Long zdtype) {
		// TODO Auto-generated method stub
		return this.find("from TbSjzd t where t.zdtype=?", new Object[]{zdtype});
	}

	@Override
	public List<TbSjzd> getPageList(int rowStartIdx, int rowCount, Long zdtype) {
		// TODO Auto-generated method stub
		StringBuffer hsql = new StringBuffer();
		hsql.append("from TbSjzd t");
		hsql.append(" where t.zdtype="+zdtype);
		return this.findPaged(hsql.toString(), rowStartIdx, rowCount);
	}

	@Override
	public long getPageCount(Long zdtype) {
		// TODO Auto-generated method stub
		StringBuffer hsql = new StringBuffer();
		hsql.append("select count(*) from TbSjzd t");
		hsql.append(" where t.zdtype="+zdtype);
		return this.findPagedConut(hsql.toString());
	}

}
