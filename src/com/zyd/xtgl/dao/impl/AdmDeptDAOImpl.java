package com.zyd.xtgl.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.zyd.common.GenericHibernateDao;
import com.zyd.xtgl.dao.IAdmDeptDAO;
import com.zyd.xtgl.domain.vo.TbAdmDept;

@Repository("admDeptDAOImpl")
public class AdmDeptDAOImpl extends GenericHibernateDao<TbAdmDept> implements IAdmDeptDAO {
	@Override
	public List<TbAdmDept> getAllDeptList() {
		List<TbAdmDept> list = this
				.find(" from TbAdmDept t order by t.serialno");
		return list;
	}

	@Override
	public List<TbAdmDept> getListByDeptname(String deptname) {
		List<TbAdmDept> list = (List<TbAdmDept>) this.find(" from TbAdmDept where deptname=?",
				deptname.trim());
		return list;
	}

	@Override
	public void addDept(TbAdmDept deptInfo) {
		this.create(deptInfo);
	}

	@Override
	public void deleteDept(String deptid) {
		this.bulkUpdate("delete from TbAdmDept t where t.deptid=?",new Object[]{deptid});
	}

	@Override
	public void updateDept(TbAdmDept deptInfo) {
		this.update(deptInfo);
	}

	@Override
	public TbAdmDept getDeptById(String deptid) {
		return (TbAdmDept) this.findById(new TbAdmDept(), deptid);
	}

	@Override
	public List<TbAdmDept> getDeptPageList(int rowStartIdx, int rowCount,String codeIds) {
		
		StringBuffer str = new StringBuffer(" where 1=1 ");
		
		if(!codeIds.equals("")&&codeIds!=null){
			str.append("and t.companycode in ("+codeIds+") and t.companytypeflag = '1' order by t.serialno");
		}
		
		String hql = "from TbAdmDept t "+str.toString();
		
		return this.findPaged(hql,
				rowStartIdx, rowCount);
	}
	
	@Override
	public List<TbAdmDept> getDeptPageAllList(int rowStartIdx, int rowCount,String codeIds) {
		
		StringBuffer str = new StringBuffer(" where 1=1 and t.companytypeflag = '1' ");
		
		if(!codeIds.equals("")&&codeIds!=null){
			str.append("and t.companycode  not in ("+codeIds+")  order by t.serialno");
		}
		
		String hql = "from TbAdmDept t "+str.toString();
		
		return this.findPaged(hql,
				rowStartIdx, rowCount);
	}

	@Override
	public long getDeptPageCount(String codeIds) {
		
		StringBuffer str = new StringBuffer(" where 1=1 ");
		
		if(!codeIds.equals("")&&codeIds!=null){
			str.append("and t.companycode in ("+codeIds+") and t.companytypeflag = '1' order by t.serialno" );
		}
		
		String hql = "select count(*) from TbAdmDept t "+str.toString();
		
		
		
		return this
				.findPagedConut(hql);
	}

	
	@Override
	public long getDeptPageAllCount(String codeIds) {
		
		StringBuffer str = new StringBuffer(" where 1=1 and t.companytypeflag = '1' ");
		
		if(!codeIds.equals("")&&codeIds!=null){
			str.append("and t.companycode  not in ("+codeIds+")  order by t.serialno" );
		}
		
		String hql = "select count(*) from TbAdmDept t "+str.toString();
		
		
		
		return this
				.findPagedConut(hql);
	}
	
	@Override
	public List<TbAdmDept> getList(String companycode) {
		// TODO Auto-generated method stub
		return this.find("from TbAdmDept t where 1=1 "+ companycode);
	}
 
}