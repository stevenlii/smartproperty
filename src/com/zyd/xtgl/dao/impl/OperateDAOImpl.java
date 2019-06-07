package com.zyd.xtgl.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.zyd.common.GenericHibernateDao;
import com.zyd.xtgl.dao.IOperateDAO;
import com.zyd.xtgl.domain.vo.SysOperate;

@Repository("operateDAOImpl")
public class OperateDAOImpl extends GenericHibernateDao<SysOperate> implements
		IOperateDAO {

	@Override
	public List<SysOperate> getAllActionList() {
		// TODO Auto-generated method stub
		String sql = " from SysOperate s ";
		return this.find(sql);

	}

	@Override
	public void addSysAction(SysOperate sysaction) {
		// TODO Auto-generated method stub
		this.create(sysaction);
	}

	@Override
	public void updateSysAction(SysOperate sysaction) {
		// TODO Auto-generated method stub
		this.update(sysaction);
	}

	@Override
	public void deleteSysAction(String operateid) {
		// TODO Auto-generated method stub
		this.bulkUpdate("delete from SysOperate s where s.operateid =?",
				new Object[] { operateid });
	}

	@Override
	public List<SysOperate> getListByModleid(String modleid) {
		// TODO Auto-generated method stub
		List<SysOperate> list = this.find(
				" from SysOperate s where s.sysModule.moduleId=? ", modleid);
		return list;
	}

	@Override
	public List<SysOperate> getListByddid(String ddid) {
		// TODO Auto-generated method stub
		List<SysOperate> list = this.find(
				" from SysOperate s where s.sysDd.ddid=? ", ddid);
		return list;
	}

	@Override
	public List<SysOperate> getOperatePageList(int rowStartIdx, int rowCount) {
		// TODO Auto-generated method stub
		return this.findPaged("from SysOperate s", rowStartIdx, rowCount);
	}

	@Override
	public long getOperatePageCount() {
		// TODO Auto-generated method stub
		return this.findPagedConut("select count(*) from SysOperate s ");
	}

	@Override
	public SysOperate getOperateById(String operateid) {
		// TODO Auto-generated method stub
		SysOperate sysOperate = (SysOperate) this.findById(new SysOperate(),
				operateid);
		return sysOperate;
	}

}
