package com.zyd.report.dao.impl;

import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Repository;

import com.zyd.report.dao.IIndemnifyDAO;
import com.zyd.report.domain.vo.TbIndemnify;

@Scope("prototype")
@Repository("indemnifyDAOImpl")
public class IndemnifyDAOImpl extends ImportDAOImpl<TbIndemnify> implements
		IIndemnifyDAO {

	@Override
	public void delete(String deleCondition) {
		// TODO Auto-generated method stub
		bulkUpdate("delete TbIndemnify t where 1=1 " + deleCondition);
	}

	@Override
	public List<TbIndemnify> getList(int rowStartIdx, int rowTotal) {
		// TODO Auto-generated method stub
		return this.findPaged("from TbIndemnify t ", rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal() {
		// TODO Auto-generated method stub
		return this.findPagedConut("select count(*) from TbIndemnify t ");
	}

	@Override
	public List<TbIndemnify> getList(String searchCondition, int rowStartIdx,
			int rowTotal) {
		// TODO Auto-generated method stub
		return this.findPaged("from TbIndemnify t where 1=1  " + searchCondition,
				rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal(String searchCondition) {
		// TODO Auto-generated method stub
		return this
				.findPagedConut("select count(*) from TbIndemnify t where 1=1  "
						+ searchCondition);
	}

	@Override
	public TbIndemnify avertRedund(String original) {
		// TODO Auto-generated method stub
		return this.findUnique("from TbIndemnify t where t.id ='" + original
				+ "'");
	}

	@Override
	public List<TbIndemnify> avertRedundList(String original) {
		String sql = "from TbIndemnify t where t.id='" + original + "'";
		return this.find(sql);
	}

	@Override
	public void deleteById(String id) {
		// TODO Auto-generated method stub
		this.bulkUpdate("delete from TbIndemnify t where t.id = ?",new Object[] {id});
	}

	@Override
	public List<TbIndemnify> getAllList() {
		// TODO Auto-generated method stub
		return this.find("from TbIndemnify t");
	}

	@Override
	public TbIndemnify getEntityById(String entityId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TbIndemnify> getAllIndemnify(String searchCondition) {
		// TODO Auto-generated method stub
		return this.find("from TbIndemnify t  where 1=1"+searchCondition);
	}
}
