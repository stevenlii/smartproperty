package com.zyd.xtgl.logic.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zyd.xtgl.dao.IModuleDAO;
import com.zyd.xtgl.domain.vo.SysModule;
import com.zyd.xtgl.logic.IModuleFacade;

@Service("moduleImpl")
public class ModuleImpl implements IModuleFacade {
	@Resource(name = "moduleDAOImpl")
	private IModuleDAO moduleDAOImpl;

	@Override
	public List<SysModule> getNodeList(String nodeid) {
		return moduleDAOImpl.getNodeList(nodeid);
	}

	@Override
	public List<Map<String, Object>> createTree(String parentid,
			List<SysModule> list) {
		List<Map<String, Object>> items = new ArrayList<Map<String, Object>>();
		for (SysModule sysmodule : list) {
			Map<String, Object> item = new HashMap<String, Object>();
			item.put("id", sysmodule.getModuleId());
			item.put("text", sysmodule.getModuleName());
			if (getNodeList(sysmodule.getModuleId()).size() > 0) {
				item.put("state", "closed");
			}
			items.add(item);
		}
		return items;

	}

	@Override
	public void deleteModule(SysModule module) {
		moduleDAOImpl.deleteModule(module);
	}

	@Override
	public void saveModule(SysModule module) {
		moduleDAOImpl.saveModule(module);
	}

	@Override
	public void updateModule(SysModule module) {
		moduleDAOImpl.updateModule(module);
	}

	@Override
	public SysModule getModuleById(String moduleId) {
		return moduleDAOImpl.getModuleById(moduleId);
	}

	@Override
	public void deleteModuleById(String id) {
		moduleDAOImpl.deleteModuleById(id);

	}


	@Override
	public List<SysModule> getPageList(int rowStartIdx, int rowCount) {
		// TODO Auto-generated method stub
		List<SysModule> list = moduleDAOImpl.getPageList(rowStartIdx, rowCount);
		for(SysModule s:list){
			if (s.getModulePid().equals("-1") ) {
				s.setModulePName("顶级");
			}else{
				s.setModulePName(getModuleById(s.getModulePid()).getModuleName());
			}
			
		}
		return list;
	}

	@Override
	public long getPageCount() {
		// TODO Auto-generated method stub
		return moduleDAOImpl.getPageCount();
	}


}