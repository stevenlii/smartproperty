package com.zyd.statistics.dao.impl;

import java.util.List;
import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Repository;

import com.zyd.report.dao.impl.ImportDAOImpl;
import com.zyd.statistics.dao.IStaticsDAO;
/**
 * 统计的DAO接口实现，所有的统计数据都应该通过此实现调用数据库相关信息
 * @author li_zq
 *
 * @param <T>
 */
@SuppressWarnings("rawtypes")
@Scope("prototype")
@Repository("mailPostStaticsDAOImpl")
public class StaticsDAOImpl extends ImportDAOImpl implements
		IStaticsDAO<Object> {

	@SuppressWarnings("unchecked")
	@Override
	public List<Object> getStaticsList(Map<String, String> columnName,
			String StaticsCondition) {
		if (columnName.get("groupbycondition") == null
				|| columnName.get("groupbycondition").isEmpty()) {
			return this.findBySql("SELECT "
					+ columnName.get("statisticscondition") + " FROM "
					+ columnName.get("table") + " t where 1=1 "
					+ StaticsCondition);
		} else {
			return this.findBySql("SELECT t."
					+ columnName.get("groupbycondition") + ", "
					+ columnName.get("statisticscondition") + " FROM "
					+ columnName.get("table") + " t where 1=1 "
					+ StaticsCondition + " GROUP BY t."
					+ columnName.get("groupbycondition"));
		}

	}

}
