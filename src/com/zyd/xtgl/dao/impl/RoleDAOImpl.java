package com.zyd.xtgl.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.zyd.common.GenericHibernateDao;
import com.zyd.xtgl.dao.IRoleDAO;
import com.zyd.xtgl.domain.vo.SysRole;

@Repository("roleDAOImpl")
public class RoleDAOImpl extends GenericHibernateDao<SysRole> implements IRoleDAO {

	@Override
	public void deleteRole(SysRole role) {
		this.deleteObject(role);
	}

	@Override
	public List<SysRole> getNodeList(String nodeid) {
		List<SysRole> list = this.find(
				"from SysRole m where m.rolePid =? order by m.roleId asc",
				nodeid);
		return list;
	}

	@Override
	public SysRole getRoleById(String roleId) {
		SysRole role = (SysRole) this.findById(new SysRole(), roleId);
		return role;
	}

	@Override
	public void saveRole(SysRole role) {
		this.create(role);
	}

	@Override
	public void updateRole(SysRole role) {
		this.update(role);
	}

}