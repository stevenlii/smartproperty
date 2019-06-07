package com.zyd.xtgl.logic.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zyd.xtgl.dao.IModuleRoleDAO;
import com.zyd.xtgl.domain.vo.SysModuleRole;
import com.zyd.xtgl.logic.IModuleRoleFacade;

@Service("moduleRoleImpl")
public class ModuleRoleImpl implements IModuleRoleFacade {
	private IModuleRoleDAO moduleRoleDAOImpl;

	@Resource(name = "moduleRoleDAOImpl")
	public void setModuleRoleDAOImpl(IModuleRoleDAO moduleRoleDAOImpl) {
		this.moduleRoleDAOImpl = moduleRoleDAOImpl;
	}

	@Override
	public void deleteModuleRole(SysModuleRole moduleRole) {
		moduleRoleDAOImpl.deleteModuleRole(moduleRole);
	}

	@Override
	public SysModuleRole getModuleRoleById(String moduleRoleId) {
		return moduleRoleDAOImpl.getModuleRoleById(moduleRoleId);
	}

	@Override
	public void saveModuleRole(SysModuleRole moduleRole) {
		moduleRoleDAOImpl.saveModuleRole(moduleRole);
	}

	@Override
	public List<SysModuleRole> getModuleRoleByIds(String moduleId) {
		return moduleRoleDAOImpl.getModuleRoleByIds(moduleId);
	}

	@Override
	public String getRoleIdsByModuleId(String moduleId) {
		return moduleRoleDAOImpl.getRoleIdsByModuleId(moduleId);
	}

	@Override
	public boolean checkModuleToRole(String rid,String mid) {
		List<SysModuleRole> list = moduleRoleDAOImpl.checkModuleToRole(rid,mid);
		if(list.size()>0){
			return true;
		}
		return false;
	}

	@Override
	public void deleteModuleRoleById(String moduleRoleId) {
		moduleRoleDAOImpl.deleteModuleRoleById(moduleRoleId);

	}

	@Override
	public List<SysModuleRole> getModuleRoleByRoleId(String nodeId) {
		// TODO Auto-generated method stub
		return moduleRoleDAOImpl.getModuleRoleByRoleId(nodeId);
	}

}