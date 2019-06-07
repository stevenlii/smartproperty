package com.zyd.xtgl.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.zyd.common.GenericHibernateDao;
import com.zyd.xtgl.dao.IModuleDAO;
import com.zyd.xtgl.domain.vo.SysModule;

@Repository("moduleDAOImpl")
public class ModuleDAOImpl extends GenericHibernateDao<SysModule> implements IModuleDAO {

	@Override
	public List<SysModule> getNodeList(String nodeid) {
		List<SysModule> list = this
				.find("from SysModule m where m.modulePid ='" + nodeid
						+ "' order by m.modulePxh asc");
		return list;
	}

	@Override
	public void deleteModule(SysModule module) {
		this.deleteObject(module);
	}

	@Override
	public void saveModule(SysModule module) {
		this.create(module);
	}

	@Override
	public void updateModule(SysModule module) {
		this.update(module);
	}

	@Override
	public SysModule getModuleById(String moduleId) {
		SysModule sysModule = (SysModule) this.findById(new SysModule(),moduleId);
		return sysModule;
	}

	@Override
	public void deleteModuleById(String id) {
		this.bulkUpdate("delete from SysModule t where t.moduleId=?",
				new String[] { id });
	}

	@Override
	public List<SysModule> getPageList(int rowStartIdx, int rowCount) {
		// TODO Auto-generated method stub
		return this.findPaged("from SysModule u ",
				rowStartIdx, rowCount);
	}

	@Override
	public long getPageCount() {
		// TODO Auto-generated method stub
		return this
				.findPagedConut("select count(*) from SysModule u ");
	}

}