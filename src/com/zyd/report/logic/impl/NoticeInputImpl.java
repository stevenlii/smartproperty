package com.zyd.report.logic.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.zyd.report.dao.INoticeDAO;
import com.zyd.report.domain.vo.SysNotice;
import com.zyd.report.logic.IImportSearchFacade;
import com.zyd.report.logic.INoticeFacade;

@Scope("prototype")
@Service("noticeInputImpl")
public class NoticeInputImpl extends InputReportImpl<SysNotice> implements
		INoticeFacade {
	@Resource(name = "noticeDAOImpl")
	private INoticeDAO noticeDAOImpl;
	@Resource(name = "noticeSearch")
	private IImportSearchFacade noticeSearch;
	@Override
	public SysNotice avertRedund(String original) {
		// TODO Auto-generated method stub
		return noticeDAOImpl.avertRedund(original);
	}

	@Override
	public void create(Object tb) {
		// TODO Auto-generated method stub
		noticeDAOImpl.create((SysNotice)tb);
	}

	@Override
	public void saveOrUpdate(SysNotice entity) {
		// TODO Auto-generated method stub
		noticeDAOImpl.saveOrUpdate(entity);
	}

	@Override
	public void addList(List<SysNotice> list) {
		// TODO Auto-generated method stub
		noticeDAOImpl.addList(list);
	}

	@Override
	public void deleteById(String id) {
		// TODO Auto-generated method stub
		noticeDAOImpl.deleteById(id);
	}

	@Override
	public void deleteObject(SysNotice entity) {
		// TODO Auto-generated method stub
		noticeDAOImpl.deleteObject(entity);
	}

	@Override
	public void deleteAll(List<?> list) {
		// TODO Auto-generated method stub
		noticeDAOImpl.deleteAll(list);
	}

	@Override
	public void batchSave(List<SysNotice> entityList) {
		// TODO Auto-generated method stub
		noticeDAOImpl.batchSave(entityList);
	}

	@Override
	public List<SysNotice> getList(int rowStartIdx, int rowTotal) {
		// TODO Auto-generated method stub
		return noticeDAOImpl.getList(rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal() {
		// TODO Auto-generated method stub
		return noticeDAOImpl.getPageTotal();
	}

	@Override
	public List<SysNotice> getList(Map<String, String> map, int rowStartIdx,
			int rowTotal) {
		// TODO Auto-generated method stub
		return noticeDAOImpl.getList(noticeSearch.search(map),rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal(Map<String, String> searchCondition) {
		// TODO Auto-generated method stub
		return noticeDAOImpl.getPageTotal(noticeSearch.search(searchCondition));
	}

	@Override
	public List<SysNotice> getAllList() {
		// TODO Auto-generated method stub
		return noticeDAOImpl.getAllList();
	}

	@Override
	public SysNotice getEntityById(String entityId) {
		// TODO Auto-generated method stub
		return noticeDAOImpl.getEntityById(entityId);
	}

	@Override
	public void update(Object tb) {
		noticeDAOImpl.update((SysNotice)tb);
	}

}
