package com.zyd.xtgl.logic.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zyd.xtgl.dao.IRoleDAO;
import com.zyd.xtgl.domain.vo.SysRole;
import com.zyd.xtgl.logic.IRoleFacade;

@Service("roleImpl")
public class RoleImpl implements IRoleFacade {
	private IRoleDAO roleDAOImpl;

	@Resource(name = "roleDAOImpl")
	public void setRoleDAOImpl(IRoleDAO roleDAOImpl) {
		this.roleDAOImpl = roleDAOImpl;
	}

	@Override
	public List<SysRole> getNodeList(String nodeid) {
		return roleDAOImpl.getNodeList(nodeid);
	}

	@Override
	public List<Map<String, Object>> createTree(String parentid,
			List<SysRole> list) {
		List<Map<String, Object>> items = new ArrayList<Map<String, Object>>();
		for (SysRole sysrole : list) {
			Map<String, Object> item = new HashMap<String, Object>();
			item.put("id", sysrole.getRoleId());
			item.put("text", sysrole.getRoleName());
			if (getNodeList(sysrole.getRoleId()).size() > 0) {
				item.put("state", "closed");
			}
			items.add(item);
		}
		return items;
	}

	@Override
	public void saveRole(SysRole role) {
		roleDAOImpl.saveRole(role);
	}

	@Override
	public void updateRole(SysRole role) {
		roleDAOImpl.updateRole(role);
	}

	@Override
	public SysRole getRoleById(String roleId) {
		return roleDAOImpl.getRoleById(roleId);
	}

	@Override
	public void deleteRole(SysRole role) {
		roleDAOImpl.deleteRole(role);
	}
}