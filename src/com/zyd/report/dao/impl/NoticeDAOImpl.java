package com.zyd.report.dao.impl;

import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Repository;

import com.zyd.report.dao.INoticeDAO;
import com.zyd.report.domain.vo.SysNotice;

@Scope("prototype")
@Repository("noticeDAOImpl")
public class NoticeDAOImpl extends InputDAOImpl<SysNotice> implements
		INoticeDAO {

	@Override
	public List<SysNotice> getList(int rowStartIdx, int rowTotal) {
		// TODO Auto-generated method stub
		return this.findPaged("from SysNotice t where 1=1 ", rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal() {
		// TODO Auto-generated method stub
		return this
				.findPagedConut("select count(*) from SysNotice t where 1=1 "
						);
	}
	@Override
	public List<SysNotice> getList(String searchCondition, int rowStartIdx,
			int rowTotal) {
		// TODO Auto-generated method stub
		return this.findPaged("from SysNotice t where 1=1 " + searchCondition, rowStartIdx, rowTotal);
	}

	@Override
	public long getPageTotal(String searchCondition) {
		// TODO Auto-generated method stub
		return this
				.findPagedConut("select count(*) from SysNotice t where 1=1 "
						+ searchCondition);
	}

	@Override
	public List<SysNotice> getAllList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public SysNotice getEntityById(String entityId) {
		// TODO Auto-generated method stub
		return this.findUnique("from SysNotice t where t.id ='" + entityId
				+ "'");
	}

	@Override
	public SysNotice avertRedund(String original) {
		// TODO Auto-generated method stub
		return this.findUnique("from SysNotice t where t.id ='" + original
				+ "'");
	}

	@Override
	public void deleteById(String id) {
		// TODO Auto-generated method stub
		this.bulkUpdate("delete from SysNotice t where t.id = ?",
				new Object[] { id });
	}
}
