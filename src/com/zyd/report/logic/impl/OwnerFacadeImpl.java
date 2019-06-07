package com.zyd.report.logic.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.zyd.report.dao.IOwnerDAO;
import com.zyd.report.domain.vo.TbOwner;
import com.zyd.report.logic.IImportSearchFacade;
import com.zyd.report.logic.IOwnerFacade;

@Scope("prototype")
@Service("ownerFacadeImpl")
public class OwnerFacadeImpl extends InputReportImpl<TbOwner> implements
		IOwnerFacade {
	@Resource(name = "ownerDAOImpl")
	private IOwnerDAO ownerDAOImpl;
	@Resource(name = "noticeSearch")
	private IImportSearchFacade noticeSearch;
	@Override
	public TbOwner avertRedund(String original) {
		// TODO Auto-generated method stub
		return ownerDAOImpl.avertRedund(original);
	}

	@Override
	public void create(Object tb) {
		// TODO Auto-generated method stub
		ownerDAOImpl.create((TbOwner)tb);
	}

	@Override
	public void saveOrUpdate(TbOwner entity) {
		// TODO Auto-generated method stub
		ownerDAOImpl.saveOrUpdate(entity);
	}

	@Override
	public void addList(List<TbOwner> list) {
		// TODO Auto-generated method stub
		ownerDAOImpl.addList(list);
	}

	@Override
	public void deleteById(String id) {
		// TODO Auto-generated method stub
		ownerDAOImpl.deleteById(id);
	}

	@Override
	public void deleteObject(TbOwner entity) {
		// TODO Auto-generated method stub
		ownerDAOImpl.deleteObject(entity);
	}

	@Override
	public void deleteAll(List<?> list) {
		// TODO Auto-generated method stub
		ownerDAOImpl.deleteAll(list);
	}

	@Override
	public void batchSave(List<TbOwner> entityList) {
		// TODO Auto-generated method stub
		ownerDAOImpl.batchSave(entityList);
	}

	@Override
	public List<TbOwner> getList(int rowStartIdx, int rowTotal) {
		// TODO Auto-generated method stub
		return ownerDAOImpl.getList(rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal() {
		// TODO Auto-generated method stub
		return ownerDAOImpl.getPageTotal();
	}

	@Override
	public List<TbOwner> getList(Map<String, String> map, int rowStartIdx,
			int rowTotal) {
		// TODO Auto-generated method stub
		return ownerDAOImpl.getList(noticeSearch.search(map),rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal(Map<String, String> searchCondition) {
		// TODO Auto-generated method stub
		return ownerDAOImpl.getPageTotal(noticeSearch.search(searchCondition));
	}

	@Override
	public List<TbOwner> getAllList() {
		// TODO Auto-generated method stub
		return ownerDAOImpl.getAllList();
	}

	@Override
	public TbOwner getEntityById(String entityId) {
		// TODO Auto-generated method stub
		return ownerDAOImpl.getEntityById(entityId);
	}

	@Override
	public void update(Object tb) {
		ownerDAOImpl.update((TbOwner)tb);
	}

}
