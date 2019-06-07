package com.zyd.xtgl.logic.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zyd.xtgl.dao.IModuleDAO;
import com.zyd.xtgl.dao.IOperateDAO;
import com.zyd.xtgl.domain.vo.SysOperate;
import com.zyd.xtgl.logic.IOperateFacade;

@Service("operateImpl")
public class OperateImpl implements IOperateFacade {
	@Resource(name = "operateDAOImpl")
	private IOperateDAO operateDAOImpl;
	@Resource(name = "moduleDAOImpl")
	private IModuleDAO moduleDAOImpl;

	@Override
	public List<SysOperate> getOperateList() {
		// TODO Auto-generated method stub
		return operateDAOImpl.getAllActionList();
	}

	@Override
	public void addOperate(SysOperate operatebean) {
		// TODO Auto-generated method stub
		operateDAOImpl.addSysAction(operatebean);
	}

	@Override
	public void updateOperate(SysOperate operatebean) {
		// TODO Auto-generated method stub
		operateDAOImpl.updateSysAction(operatebean);
	}

	@Override
	public void deleteOperate(String operateid) {
		// TODO Auto-generated method stub
		operateDAOImpl.deleteSysAction(operateid);
	}

	@Override
	public List<SysOperate> getOperatePageList(int rowStartIdx, int rowCount) {
		List<SysOperate> list = operateDAOImpl.getOperatePageList(rowStartIdx,
				rowCount);
		for (SysOperate s : list) {
			if (s.getSysModule().getModulePid().equals("-1")) {
				s.getSysModule().setModulePName("顶级");
			} else {
				s.getSysModule().setModulePName(moduleDAOImpl.getModuleById(s.getSysModule().getModulePid())
						.getModuleName());
			}

		}
		return list;
	}

	@Override
	public long getOperatePageCount() {
		// TODO Auto-generated method stub
		return operateDAOImpl.getOperatePageCount();
	}

	@Override
	public List<SysOperate> getListByModleid(String modleid) {
		// TODO Auto-generated method stub
		return operateDAOImpl.getListByModleid(modleid);
	}
	@Override
	public List<SysOperate> getListByddid(String ddid) {
		// TODO Auto-generated method stub
		return operateDAOImpl.getListByddid(ddid);
	}

	@Override
	public SysOperate getOperateById(String operateid) {
		// TODO Auto-generated method stub
		return operateDAOImpl.getOperateById(operateid);
	}

}
