package com.zyd.xtgl.logic.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zyd.xtgl.dao.IDdDAO;
import com.zyd.xtgl.domain.vo.SysDd;
import com.zyd.xtgl.logic.IDdFacade;

@Service("ddImpl")
public class DdImpl extends InputImpl<SysDd> implements IDdFacade {
	@Resource(name = "ddDAOImpl")
	private IDdDAO ddDAOImpl;

	@Override
	public SysDd avertRedund(String original) {
		// TODO Auto-generated method stub
		return ddDAOImpl.avertRedund(original);
	}

	@Override
	public void create(Object tb) {
		// TODO Auto-generated method stub
		ddDAOImpl.create((SysDd)tb);
	}

	@Override
	public void deleteById(String id) {
		// TODO Auto-generated method stub
		ddDAOImpl.deleteById(id);
	}

	@Override
	public List<SysDd> getList(Map<String, String> map, int rowStartIdx,
			int rowTotal) {
		// TODO Auto-generated method stub
		return ddDAOImpl.getList(search_TbtypeCondition(map),rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal(Map<String, String> searchCondition) {
		// TODO Auto-generated method stub
		return ddDAOImpl.getPageTotal(search_TbtypeCondition(searchCondition));
	}

	@Override
	public void update(Object entity) {
		// TODO Auto-generated method stub
		ddDAOImpl.update((SysDd)entity);
	}

	@Override
	public List<SysDd> getAllList() {
		return ddDAOImpl.getAllList();
	}

	@Override
	public SysDd getEntityById(String entityId) {
		// TODO Auto-generated method stub
		return ddDAOImpl.getEntityById(entityId);
	}

	@Override
	public List<SysDd> getList(Map<String, String> map) {
		// TODO Auto-generated method stub
		return ddDAOImpl.getList(search_TbtypeCondition(map));
	}
	
}
