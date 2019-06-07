package com.zyd.report.dao.impl;

import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Repository;

import com.zyd.report.dao.ISyszhdmgndmDAO;
import com.zyd.report.domain.vo.Syszhdmgndm;
@Scope("prototype")
@Repository("syszhdmgndmDAOImpl")
public class SyszhdmgndmDAOImpl extends ImportDAOImpl<Syszhdmgndm>implements ISyszhdmgndmDAO {

	 
	@Override
	public void create(Syszhdmgndm tb) {
		// TODO Auto-generated method stub

	}

	@Override
	public void saveOrUpdate(Syszhdmgndm entity) {
		// TODO Auto-generated method stub

	}

	@Override
	public void addList(List<Syszhdmgndm> list) {
		// TODO Auto-generated method stub

	}

	@Override
	public void batchSave(List<Syszhdmgndm> entityList) {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteById(String id) {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(String deleCondition) {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteObject(Syszhdmgndm entity) {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteAll(List<?> list) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<Syszhdmgndm> getList(int rowStartIdx, int rowTotal) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public long getPageTotal() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Syszhdmgndm> getList(String searchCondition, int rowStartIdx,
			int rowTotal) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public long getPageTotal(String searchCondition) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Syszhdmgndm> getAllList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Syszhdmgndm getEntityById(String entityId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void update(Syszhdmgndm entity) {
		// TODO Auto-generated method stub

	}

	@Override
	public Syszhdmgndm avertRedund(String original) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Syszhdmgndm> avertRedundList(String original) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Syszhdmgndm> getListByName(String dmmc) {
		// TODO Auto-generated method stub
		 String sql="from Syszhdmgndm t where t.dmmc like '%"+dmmc+"%' ";
		 return this.find(sql);
	}

}
