package com.zyd.xtgl.logic.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zyd.xtgl.dao.ISjzdDAO;
import com.zyd.xtgl.domain.vo.TbSjzd;
import com.zyd.xtgl.logic.ISjzdFacade;

@Service("sjzdImpl")
public class SjzdFacadeImpl implements ISjzdFacade {
	private ISjzdDAO sjzdDAOImpl;

	@Resource(name = "sjzdDAOImpl")
	public void setSjzdDAOImpl(ISjzdDAO sjzdDAOImpl) {
		this.sjzdDAOImpl = sjzdDAOImpl;
	}

	@Override
	public void addSjzd(TbSjzd sjzd) {
		// TODO Auto-generated method stub
		sjzdDAOImpl.addSjzd(sjzd);
	}

	@Override
	public void deleteSjzd(TbSjzd sjzd) {
		// TODO Auto-generated method stub
		sjzdDAOImpl.deleteSjzd(sjzd);
	}

	@Override
	public void deleteSjzd(String id) {
		// TODO Auto-generated method stub
		sjzdDAOImpl.deleteSjzd(id);
	}

	@Override
	public void updateSjzd(TbSjzd sjzd) {
		// TODO Auto-generated method stub
		sjzdDAOImpl.updateSjzd(sjzd);
	}

	@Override
	public List<TbSjzd> getAllList() {
		// TODO Auto-generated method stub
		return sjzdDAOImpl.getAllList();
	}

	@Override
	public List<TbSjzd> getListByZdtype(Long zdtype) {
		// TODO Auto-generated method stub
		return sjzdDAOImpl.getListByZdtype(zdtype);
	}

	@Override
	public List<TbSjzd> getPageList(int rowStartIdx, int rowCount, Long zdtype) {
		// TODO Auto-generated method stub
		return sjzdDAOImpl.getPageList(rowStartIdx, rowCount, zdtype);
	}

	@Override
	public long getPageCount(Long zdtype) {
		// TODO Auto-generated method stub
		return sjzdDAOImpl.getPageCount(zdtype);
	}

}
