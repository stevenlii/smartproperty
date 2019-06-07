package com.zyd.xtgl.logic.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zyd.xtgl.dao.IAdmDeptDAO;
import com.zyd.xtgl.domain.vo.TbAdmDept;
import com.zyd.xtgl.logic.IAdmDeptFacade;

@Service("admDeptImpl")
public class AdmDeptImpl implements IAdmDeptFacade {
	private IAdmDeptDAO admDeptDAOImpl;

	@Resource(name = "admDeptDAOImpl")
	public void setAdmDeptDAOImpl(IAdmDeptDAO admDeptDAOImpl) {
		this.admDeptDAOImpl = admDeptDAOImpl;
	}

	@Override
	public List<TbAdmDept> getAllDeptList() {
		return admDeptDAOImpl.getAllDeptList();
	}

	@Override
	public void addDept(TbAdmDept deptInfo) {
		admDeptDAOImpl.addDept(deptInfo);
	}
	
	@Override
	public boolean checkDeptName(TbAdmDept deptBean) {
		String deptname = deptBean.getDeptname();
		List<TbAdmDept> list = admDeptDAOImpl.getListByDeptname(deptname);
		if(list.size()>0){
			return true;
		}
		return false;
	}

	@Override
	public void delDept(String deptid) {
		admDeptDAOImpl.deleteDept(deptid);
	}

	@Override
	public void updateDept(TbAdmDept deptInfo) {
		admDeptDAOImpl.updateDept(deptInfo);
	}

	@Override
	public String getDeptnameById(String deptid) {
		TbAdmDept deptinfo = admDeptDAOImpl.getDeptById(deptid);
		return deptinfo.getDeptname();
	}

	@Override
	public TbAdmDept getDeptById(String deptid) {
		return admDeptDAOImpl.getDeptById(deptid);
	}

	@Override
	public List<TbAdmDept> getDeptPageList(int rowStartIdx, int rowCount,String codeIds) {
		return admDeptDAOImpl.getDeptPageList(rowStartIdx, rowCount,codeIds);
	}
	
	@Override
	public List<TbAdmDept> getDeptPageAllList(int rowStartIdx, int rowCount,String codeIds) {
		return admDeptDAOImpl.getDeptPageAllList(rowStartIdx, rowCount,codeIds);
	}

	@Override
	public long getDeptPageCount(String codeIds) {
		return admDeptDAOImpl.getDeptPageCount(codeIds);
	}
	
	@Override
	public long getDeptPageAllCount(String codeIds) {
		return admDeptDAOImpl.getDeptPageAllCount(codeIds);
	}

	@Override
	public List<TbAdmDept> getList(Map<String, String> map) {
		// TODO Auto-generated method stub
		return admDeptDAOImpl.getList(search_TbAdmDept(map));
	}
	

	public String search_TbAdmDept(Map<String, String> map) {
		StringBuffer search = new StringBuffer();
		String companytypeflag = map.get("companytypeflag");// 公司类型
		String companycode = map.get("companycode");//
		search.append("");
		if (companytypeflag != null && !(companytypeflag.equals(""))) {
			search.append(" and companytypeflag = '" + companytypeflag + "'");
		}
		if (companycode != null && !(companycode.equals(""))) {
			search.append(" and companycode = '" + companycode + "'");
		}
		search.append(" order by t.serialno");
		 
		return search.toString();
	}
}
