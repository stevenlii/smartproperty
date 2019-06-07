package com.zyd.report.logic.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.zyd.report.dao.IHouseDAO;
import com.zyd.report.domain.vo.TbHouse;
import com.zyd.report.logic.IHouseFacade;
import com.zyd.report.logic.IImportSearchFacade;

@Scope("prototype")
@Service("houseFacadeImpl")
public class HouseFacadeImpl extends InputReportImpl<TbHouse> implements
		IHouseFacade {
	@Resource(name = "houseDAOImpl")
	private IHouseDAO houseDAOImpl;
	@Resource(name = "noticeSearch")
	private IImportSearchFacade noticeSearch;
	@Override
	public TbHouse avertRedund(String original) {
		// TODO Auto-generated method stub
		return houseDAOImpl.avertRedund(original);
	}

	@Override
	public void create(Object tb) {
		// TODO Auto-generated method stub
		houseDAOImpl.create((TbHouse)tb);
	}

	@Override
	public void saveOrUpdate(TbHouse entity) {
		// TODO Auto-generated method stub
		houseDAOImpl.saveOrUpdate(entity);
	}

	@Override
	public void addList(List<TbHouse> list) {
		// TODO Auto-generated method stub
		houseDAOImpl.addList(list);
	}

	@Override
	public void deleteById(String id) {
		// TODO Auto-generated method stub
		houseDAOImpl.deleteById(id);
	}

	@Override
	public void deleteObject(TbHouse entity) {
		// TODO Auto-generated method stub
		houseDAOImpl.deleteObject(entity);
	}

	@Override
	public void deleteAll(List<?> list) {
		// TODO Auto-generated method stub
		houseDAOImpl.deleteAll(list);
	}

	@Override
	public void batchSave(List<TbHouse> entityList) {
		// TODO Auto-generated method stub
		houseDAOImpl.batchSave(entityList);
	}

	@Override
	public List<TbHouse> getList(int rowStartIdx, int rowTotal) {
		// TODO Auto-generated method stub
		return houseDAOImpl.getList(rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal() {
		// TODO Auto-generated method stub
		return houseDAOImpl.getPageTotal();
	}

	@Override
	public List<TbHouse> getList(Map<String, String> map, int rowStartIdx,
			int rowTotal) {
		// TODO Auto-generated method stub
		return houseDAOImpl.getList(noticeSearch.search(map),rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal(Map<String, String> searchCondition) {
		// TODO Auto-generated method stub
		return houseDAOImpl.getPageTotal(noticeSearch.search(searchCondition));
	}

	@Override
	public List<TbHouse> getAllList() {
		// TODO Auto-generated method stub
		return houseDAOImpl.getAllList();
	}

	@Override
	public TbHouse getEntityById(String entityId) {
		// TODO Auto-generated method stub
		return houseDAOImpl.getEntityById(entityId);
	}

	@Override
	public void update(Object tb) {
		houseDAOImpl.update((TbHouse)tb);
	}

}
