package com.zyd.xtgl.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.zyd.common.GenericHibernateDao;
import com.zyd.xtgl.dao.IModuleDAO;
import com.zyd.xtgl.dao.IModuleRoleDAO;
import com.zyd.xtgl.dao.IRoleUserDAO;
import com.zyd.xtgl.domain.vo.SysModule;
import com.zyd.xtgl.domain.vo.SysModuleRole;

@Repository("moduleRoleDAOImpl")
public class ModuleRoleDAOImpl extends GenericHibernateDao<SysModuleRole> implements
		IModuleRoleDAO {
	@Resource(name = "roleUserDAOImpl")
	private IRoleUserDAO roleUserDAOImpl;
	private IModuleDAO moduleDAOImpl;

	@Resource(name = "moduleDAOImpl")
	public void setModuleDAOImpl(ModuleDAOImpl moduleDAOImpl) {
		this.moduleDAOImpl = moduleDAOImpl;
	}

	@Override
	public void deleteModuleRole(SysModuleRole moduleRole) {
		this.deleteObject(moduleRole);
	}

	@Override
	public SysModuleRole getModuleRoleById(String moduleRoleId) {
		return (SysModuleRole) this.findById(new SysModuleRole(), moduleRoleId);
	}

	@Override
	public void saveModuleRole(SysModuleRole moduleRole) {
		this.create(moduleRole);
	}

	@Override
	public List<SysModuleRole> getModuleRoleByIds(String moduleId) {
		List<SysModuleRole> list = this.find(
				"from SysModuleRole smr where smr.sysModule.moduleId=?",
				moduleId);
		return list;
	}

	@Override
	public String getRoleIdsByModuleId(String moduleId) {
		List<SysModuleRole> list = this.find(
				"from SysModuleRole smr where smr.sysModule.moduleId=?",
				moduleId);
		String roleIds = "";
		for (SysModuleRole moduleRole : list) {
			roleIds += moduleRole.getSysRole().getRoleId() + ",";
		}
		return roleIds;
	}

	@Override
	public boolean hasPrivilege(String moduleId, String userId) {
		boolean hasPrivilege = false;
		String roleIdsByUser = roleUserDAOImpl.getRoleIdsByUserId(userId);
		String roleIdsByModule = getRoleIdsByModuleId(moduleId);
		if ((roleIdsByUser != null && !(roleIdsByUser.isEmpty()))
				&& (roleIdsByModule != null && !(roleIdsByModule.isEmpty()))) {
			String[] roleIdsU = roleIdsByUser.split(",");
			String[] roleIdsM = roleIdsByModule.split(",");
			for (int i = 0; i < roleIdsM.length; i++) {
				for (int j = 0; j < roleIdsU.length; j++) {
					if (roleIdsM[i].toString().equals(roleIdsU[j].toString())) {
						hasPrivilege = true;
						break;
					}
				}
				if (hasPrivilege)
					break;
			}
		}
		return hasPrivilege;
	}

	@Override
	public List<SysModule> getNodeList(String nodeid) {
		return moduleDAOImpl.getNodeList(nodeid);
	}

	@Override
	public List<SysModuleRole> checkModuleToRole(String roleId, String mid) {
		List<SysModuleRole> list = this
				.find("from SysModuleRole smr where smr.sysModule.moduleId=? and smr.sysRole.roleId=? ",
						new Object[]{mid,roleId});
		return list;
	}

	@Override
	public void deleteModuleRoleById(String moduleRoleId) {
		this.bulkUpdate(
				"delete from SysModuleRole smr where smr.moduleRoleId = ?",
				new Object[] { moduleRoleId });

	}

	@Override
	public List<SysModuleRole> getModuleRoleByRoleId(String roleId) {
		List<SysModuleRole> list = this.find(
				"from SysModuleRole s where s.sysRole.roleId=?", roleId);
		return list;
	}

}