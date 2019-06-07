package com.zyd.report.logic.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.zyd.report.dao.IOwnerHouseDAO;
import com.zyd.report.domain.vo.TbOwnerHouse;
import com.zyd.report.logic.IImportSearchFacade;
import com.zyd.report.logic.IOwnerHouseFacade;

@Scope("prototype")
@Service("ownerHouseFacadeImpl")
public class OwnerHouseFacadeImpl extends InputReportImpl<TbOwnerHouse> implements
		IOwnerHouseFacade {
	@Resource(name = "ownerHouseDAOImpl")
	private IOwnerHouseDAO ownerHouseDAOImpl;
	@Resource(name = "noticeSearch")
	private IImportSearchFacade noticeSearch;
	@Override
	public TbOwnerHouse avertRedund(String original) {
		// TODO Auto-generated method stub
		return ownerHouseDAOImpl.avertRedund(original);
	}

	@Override
	public void create(Object tb) {
		// TODO Auto-generated method stub
		ownerHouseDAOImpl.create((TbOwnerHouse)tb);
	}

	@Override
	public void saveOrUpdate(TbOwnerHouse entity) {
		// TODO Auto-generated method stub
		ownerHouseDAOImpl.saveOrUpdate(entity);
	}

	@Override
	public void addList(List<TbOwnerHouse> list) {
		// TODO Auto-generated method stub
		ownerHouseDAOImpl.addList(list);
	}

	@Override
	public void deleteById(String id) {
		// TODO Auto-generated method stub
		ownerHouseDAOImpl.deleteById(id);
	}

	@Override
	public void deleteObject(TbOwnerHouse entity) {
		// TODO Auto-generated method stub
		ownerHouseDAOImpl.deleteObject(entity);
	}

	@Override
	public void deleteAll(List<?> list) {
		// TODO Auto-generated method stub
		ownerHouseDAOImpl.deleteAll(list);
	}

	@Override
	public void batchSave(List<TbOwnerHouse> entityList) {
		// TODO Auto-generated method stub
		ownerHouseDAOImpl.batchSave(entityList);
	}

	@Override
	public List<TbOwnerHouse> getList(int rowStartIdx, int rowTotal) {
		// TODO Auto-generated method stub
		return ownerHouseDAOImpl.getList(rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal() {
		// TODO Auto-generated method stub
		return ownerHouseDAOImpl.getPageTotal();
	}

	@Override
	public List<TbOwnerHouse> getList(Map<String, String> map, int rowStartIdx,
			int rowTotal) {
		// TODO Auto-generated method stub
		return ownerHouseDAOImpl.getList(noticeSearch.search(map),rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal(Map<String, String> searchCondition) {
		// TODO Auto-generated method stub
		return ownerHouseDAOImpl.getPageTotal(noticeSearch.search(searchCondition));
	}

	@Override
	public List<TbOwnerHouse> getAllList() {
		// TODO Auto-generated method stub
		return ownerHouseDAOImpl.getAllList();
	}

	@Override
	public TbOwnerHouse getEntityById(String entityId) {
		// TODO Auto-generated method stub
		return ownerHouseDAOImpl.getEntityById(entityId);
	}

	@Override
	public void update(Object tb) {
		ownerHouseDAOImpl.update((TbOwnerHouse)tb);
	}

}
