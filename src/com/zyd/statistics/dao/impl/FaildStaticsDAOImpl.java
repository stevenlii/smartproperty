package com.zyd.statistics.dao.impl;

import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Repository;

import com.zyd.report.dao.impl.ImportDAOImpl;
import com.zyd.statistics.dao.IFaildStaticsDAO;
/**
 * 未妥投dao实现类
 * @author li_zq
 *
 * @param <T>
 */
@SuppressWarnings("rawtypes")
@Scope("prototype")
@Repository("faildStaticsDAOImpl")
public class FaildStaticsDAOImpl extends ImportDAOImpl implements
	IFaildStaticsDAO<Object[]> {

	@Override
	public List<Object[]> getList(String sql) {
		// TODO Auto-generated method stub
		List<Object[]> list = this.findBySql(sql);
		return list;
	}



}
