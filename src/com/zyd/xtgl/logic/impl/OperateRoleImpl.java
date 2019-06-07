package com.zyd.xtgl.logic.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zyd.xtgl.dao.IModuleDAO;
import com.zyd.xtgl.dao.IOperateRoleDAO;
import com.zyd.xtgl.domain.vo.SysOperateRole;
import com.zyd.xtgl.logic.IOperateRoleFacade;

@Service("operateRoleImpl")
public class OperateRoleImpl implements IOperateRoleFacade {
	@Resource(name = "operateRoleDAOImpl")
	private IOperateRoleDAO operateRoleDAOImpl;
	@Resource(name = "moduleDAOImpl")
	private IModuleDAO moduleDAOImpl;

	@Override
	public void saveOperateRole(SysOperateRole OperateRole) {
		// TODO Auto-generated method stub
		operateRoleDAOImpl.saveOperateRole(OperateRole);
	}

	@Override
	public void deleteOperateRole(SysOperateRole OperateRole) {
		// TODO Auto-generated method stub
		this.operateRoleDAOImpl.deleteOperateRole(OperateRole);
	}

	@Override
	public void deleteOperateRoleById(String OperateRoleId) {
		// TODO Auto-generated method stub
		operateRoleDAOImpl.deleteOperateRoleById(OperateRoleId);
	}

	@Override
	public SysOperateRole getOperateRoleById(String OperateRoleId) {
		// TODO Auto-generated method stub
		return operateRoleDAOImpl.getOperateRoleById(OperateRoleId);
	}

	@Override
	public List<SysOperateRole> getOperateRoleByIds(String OperateId) {
		// TODO Auto-generated method stub
		return operateRoleDAOImpl.getOperateRoleByIds(OperateId);
	}

	@Override
	public String getRoleIdsByOperateId(String OperateId) {
		// TODO Auto-generated method stub
		return operateRoleDAOImpl.getRoleIdsByOperateId(OperateId);
	}

	@Override
	public boolean checkOperateToRole(String rid, String oid) {
		List<SysOperateRole> list = operateRoleDAOImpl.checkOperateToRole(rid,
				oid);
		if (list.size() > 0) {
			return true;
		}
		return false;
	}

	@Override
	public List<SysOperateRole> getOperateRoleByRoleId(String nodeId) {
		List<SysOperateRole> list = operateRoleDAOImpl
				.getOperateRoleByRoleId(nodeId);
		for (SysOperateRole s : list) {
			if (s.getSysOperate().getSysModule().getModulePid().equals("-1")) {
				s.getSysOperate().getSysModule().setModulePName("顶级");
			} else {
				s.getSysOperate()
						.getSysModule()
						.setModulePName(
								moduleDAOImpl.getModuleById(
										s.getSysOperate().getSysModule()
												.getModulePid())
										.getModuleName());
			}
		}
		return list;
	}
}