package com.zyd.report.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.context.annotation.Scope;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.zyd.common.GenericHibernateDao;

/**
 * 封装报表的常用方法的抽象DAO
 * 
 * @author lzq
 * 
 * @param <T>
 */
@Scope("prototype")
public abstract class ImportDAOImpl<T> extends GenericHibernateDao<T> {
	/**
	 * 通过SQL语句查询出结果
	 * 
	 * @param queryString
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<T> findBySql(final String queryString, final int rowStartIdx,
			final int rowCount) {
		return this.getHibernateTemplate().executeFind(
				new HibernateCallback<T>() {
					public T doInHibernate(Session s)
							throws HibernateException, SQLException {
						Query query = s.createSQLQuery(queryString);
						if (rowStartIdx != -1 && rowCount != -1) {
							query.setFirstResult(rowStartIdx);
							query.setMaxResults(rowCount);
						}
						List<T> list = query.list();
						return (T) list;
					}
				});
	}
}
