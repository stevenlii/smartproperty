package com.zyd.xtgl.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.zyd.common.GenericHibernateDao;
import com.zyd.xtgl.dao.IRoleUserDAO;
import com.zyd.xtgl.domain.vo.SysRoleUser;

@Repository("roleUserDAOImpl")
public class RoleUserDAOImpl extends GenericHibernateDao<SysRoleUser> implements
		IRoleUserDAO {

	@Override
	public void saveRoleUser(SysRoleUser roleUser) {
		this.create(roleUser);
	}

	@Override
	public void updateRoleUser(SysRoleUser roleUser) {

	}

	@Override
	public List<SysRoleUser> getRoleUserByRoleId(String roleId) {
		List<SysRoleUser> list = this.find(
				"from SysRoleUser s where s.sysRole.roleId=?", roleId);
		return list;
	}

	@Override
	public String getUserIdsByRoleId(String roleId) {
		List<SysRoleUser> list = this.find(
				"from SysRoleUser s where s.sysRole.roleId=?", roleId);
		String userIds = "";
		for (SysRoleUser roleUser : list) {
			userIds += roleUser.getTbAdmUser().getUserid() + ",";
		}
		return userIds;
	}

	@Override
	public void deleteRoleUser(SysRoleUser roleUser) {
		this.deleteObject(roleUser);
	}

	@Override
	public String getRoleIdsByUserId(String userId) {
		@SuppressWarnings("unchecked")
		List<String> list = this.getHibernateTemplate()
				.find("select distinct(s.sysRole.roleId) from SysRoleUser s where s.tbAdmUser.userid=?",
						userId);
		String roleIds = "";
		for (String roleid : list) {
			roleIds += roleid + ",";
		}
		return roleIds;
	}

	@Override
	public List<SysRoleUser> getRoleUserByUserId(String userId) {
		List<SysRoleUser> list = this.find("from SysRoleUser s where s.tbAdmUser.userid=?",userId);
		return list;
	}

	@Override
	public List<SysRoleUser> checkUserToRole(String roleId, String userid) {
		List<SysRoleUser> list = this.find("from SysRoleUser s where s.sysRole.roleId = ? and s.tbAdmUser.userid=?",new Object[]{roleId,userid});
		return list;
	}

	@Override
	public void deleteRoleUserById(String roleUserId) {
		this.bulkUpdate("delete from SysRoleUser sru where sru.roleUserId=?", new Object[]{roleUserId});
	}
}