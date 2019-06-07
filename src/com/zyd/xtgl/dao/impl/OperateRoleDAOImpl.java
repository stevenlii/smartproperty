package com.zyd.xtgl.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.zyd.xtgl.dao.IOperateRoleDAO;
import com.zyd.xtgl.dao.IRoleUserDAO;
import com.zyd.xtgl.domain.vo.SysOperate;
import com.zyd.xtgl.domain.vo.SysOperateRole;

@Repository("operateRoleDAOImpl")
public class OperateRoleDAOImpl extends InputDAOImpl<SysOperateRole> implements
		IOperateRoleDAO {
	@Resource(name = "roleUserDAOImpl")
	private IRoleUserDAO roleUserDAOImpl;

	@Override
	public void deleteOperateRole(SysOperateRole OperateRole) {
		this.deleteObject(OperateRole);
	}

	@Override
	public SysOperateRole getOperateRoleById(String OperateRoleId) {
		return this.findById(new SysOperateRole(), OperateRoleId);
	}

	@Override
	public void saveOperateRole(SysOperateRole OperateRole) {
		this.create(OperateRole);
	}

	@Override
	public List<SysOperateRole> getOperateRoleByIds(String OperateId) {
		List<SysOperateRole> list = this.find(
				"from SysOperateRole smr where smr.sysOperate.operateid=?",
				OperateId);
		return list;
	}

	@Override
	public String getRoleIdsByOperateId(String OperateId) {
		List<SysOperateRole> list = this.find(
				"from SysOperateRole smr where smr.sysOperate.operateid=?",
				OperateId);
		String roleIds = "";
		for (SysOperateRole OperateRole : list) {
			roleIds += OperateRole.getSysRole().getRoleId() + ",";
		}
		return roleIds;
	}

	@Override
	public boolean hasPrivilege(String OperateId, String userId) {
		boolean hasPrivilege = false;
		String roleIdsByUser = roleUserDAOImpl.getRoleIdsByUserId(userId);
		String roleIdsByOperate = getRoleIdsByOperateId(OperateId);
		if ((roleIdsByUser != null && !(roleIdsByUser.isEmpty()))
				&& (roleIdsByOperate != null && !(roleIdsByOperate.isEmpty()))) {
			String[] roleIdsU = roleIdsByUser.split(",");
			String[] roleIdsM = roleIdsByOperate.split(",");
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
	public List<SysOperateRole> checkOperateToRole(String roleId, String oid) {
		List<SysOperateRole> list = this
				.find("from SysOperateRole smr where smr.sysOperate.operateid=? and smr.sysRole.roleId=? ",
						new Object[] { oid, roleId });
		return list;
	}

	@Override
	public void deleteOperateRoleById(String OperateRoleId) {
		this.bulkUpdate(
				"delete from SysOperateRole smr where smr.operateroleid = ?",
				new String[] { OperateRoleId });

	}

	@Override
	public List<SysOperate> getNodeList(String nodeid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SysOperateRole> getOperateRoleByRoleId(String nodeId) {
		List<SysOperateRole> list = this.find(
				"from SysOperateRole s where s.sysRole.roleId=?", nodeId);
		return list;
	}

	@Override
	public List<SysOperateRole> getList(String searchCondition,
			int rowStartIdx, int rowTotal) {
		// TODO Auto-generated method stub
		return getList(rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal(String searchCondition) {
		// TODO Auto-generated method stub
		return getPageTotal();
	}

	@Override
	public List<SysOperateRole> getAllList() {
		// TODO Auto-generated method stub
		return this.find("from SysOperateRole t");
	}

	@Override
	public SysOperateRole getEntityById(String entityId) {
		// TODO Auto-generated method stub
		return findById(new SysOperateRole(), entityId);
	}

}