package com.zyd.xtgl.logic.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zyd.xtgl.dao.IRoleUserDAO;
import com.zyd.xtgl.domain.vo.SysRoleUser;
import com.zyd.xtgl.logic.IRoleUserFacade;

@Service("roleUserImpl")
public class RoleUserImpl implements IRoleUserFacade {
	private IRoleUserDAO roleUserDAOImpl;

	@Resource(name = "roleUserDAOImpl")
	public void setRoleUserDAOImpl(IRoleUserDAO roleUserDAOImpl) {
		this.roleUserDAOImpl = roleUserDAOImpl;
	}

	@Override
	public void saveRoleUser(SysRoleUser roleUser) {
		roleUserDAOImpl.saveRoleUser(roleUser);
	}

	@Override
	public void updateRoleUser(SysRoleUser roleUser) {

	}

	@Override
	public List<SysRoleUser> getRoleUserByRoleId(String RoleId) {
		return roleUserDAOImpl.getRoleUserByRoleId(RoleId);
	}

	@Override
	public String getUserIdsByRoleId(String roleId) {
		return roleUserDAOImpl.getUserIdsByRoleId(roleId);
	}

	@Override
	public void deleteRoleUser(SysRoleUser roleUser) {
		roleUserDAOImpl.deleteRoleUser(roleUser);
	}

	@Override
	public List<SysRoleUser> getRoleUserByUserId(String userId) {
		return roleUserDAOImpl.getRoleUserByUserId(userId);
	}

	@Override
	public boolean checkUserToRole(String roleId, String userid) {
		List<SysRoleUser> list = roleUserDAOImpl.checkUserToRole(roleId, userid);
		if(list.size()>0){
			return true;
		}
		return false;
	}

	@Override
	public void deleteRoleUserById(String roleUserId) {
		roleUserDAOImpl.deleteRoleUserById(roleUserId);
		
	}

}