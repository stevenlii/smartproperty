package com.zyd.report.logic.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.zyd.report.dao.IPropertyDAO;
import com.zyd.report.domain.vo.TbProperty;
import com.zyd.report.logic.IImportSearchFacade;
import com.zyd.report.logic.IPropertyFacade;

@Scope("prototype")
@Service("propertyFacadeImpl")
public class PropertyFacadeImpl extends InputReportImpl<TbProperty> implements
		IPropertyFacade {
	@Resource(name = "propertyDAOImpl")
	private IPropertyDAO propertyDAOImpl;
	@Resource(name = "propertySearch")
	private IImportSearchFacade propertySearch;
	@Override
	public TbProperty avertRedund(String original) {
		// TODO Auto-generated method stub
		return propertyDAOImpl.avertRedund(original);
	}

	@Override
	public void create(Object tb) {
		// TODO Auto-generated method stub
		propertyDAOImpl.create((TbProperty)tb);
	}

	@Override
	public void saveOrUpdate(TbProperty entity) {
		// TODO Auto-generated method stub
		propertyDAOImpl.saveOrUpdate(entity);
	}

	@Override
	public void addList(List<TbProperty> list) {
		// TODO Auto-generated method stub
		propertyDAOImpl.addList(list);
	}

	@Override
	public void deleteById(String id) {
		// TODO Auto-generated method stub
		propertyDAOImpl.deleteById(id);
	}

	@Override
	public void deleteObject(TbProperty entity) {
		// TODO Auto-generated method stub
		propertyDAOImpl.deleteObject(entity);
	}

	@Override
	public void deleteAll(List<?> list) {
		// TODO Auto-generated method stub
		propertyDAOImpl.deleteAll(list);
	}

	@Override
	public void batchSave(List<TbProperty> entityList) {
		// TODO Auto-generated method stub
		propertyDAOImpl.batchSave(entityList);
	}

	@Override
	public List<TbProperty> getList(int rowStartIdx, int rowTotal) {
		// TODO Auto-generated method stub
		return propertyDAOImpl.getList(rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal() {
		// TODO Auto-generated method stub
		return propertyDAOImpl.getPageTotal();
	}

	@Override
	public List<TbProperty> getList(Map<String, String> map, int rowStartIdx,
			int rowTotal) {
		// TODO Auto-generated method stub
		return propertyDAOImpl.getList(propertySearch.search(map),rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal(Map<String, String> searchCondition) {
		// TODO Auto-generated method stub
		return propertyDAOImpl.getPageTotal(propertySearch.search(searchCondition));
	}

	@Override
	public List<TbProperty> getAllList() {
		// TODO Auto-generated method stub
		return propertyDAOImpl.getAllList();
	}

	@Override
	public TbProperty getEntityById(String entityId) {
		// TODO Auto-generated method stub
		return propertyDAOImpl.getEntityById(entityId);
	}

	@Override
	public void update(Object tb) {
		propertyDAOImpl.update((TbProperty)tb);
	}

}
