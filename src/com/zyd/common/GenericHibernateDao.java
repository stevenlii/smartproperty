package com.zyd.common;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Component;
import org.springframework.util.Assert;

/**
 * @author liu_gl
 * 
 */
@Component
@SuppressWarnings("unchecked")
public class GenericHibernateDao<T> {
	static final Logger logger = LoggerFactory
			.getLogger(GenericHibernateDao.class);
	private HibernateTemplate hibernateTemplate;

	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	/**
	 * 方便继承类获取hibernateTemplate直接操作数据库
	 * 
	 * @return
	 */
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	/**
	 * 获取hibernateSession
	 * 
	 * @return
	 */
	public Session getMysession() {
		Session session = hibernateTemplate.getSessionFactory()
				.getCurrentSession();
		return session;
	}

	/**
	 * 获取单一记录
	 * 
	 * @param results
	 */
	private static Object singleResult(Collection<?> results) {
		if (results == null || results.isEmpty())
			return null;
		if (results.size() > 1)
			throw new IllegalArgumentException("the List size is more than 1");
		return results.iterator().next();
	}

	/**
	 * 无参数的HSQL语句,更新、删除实体
	 * 
	 * @param queryString
	 *            HQL语句 例如:"update test t set t.password=1"
	 * @return 无返回类型
	 */
	public void bulkUpdate(final String queryString) {
		Assert.hasLength(queryString, "sql语句有误");
		hibernateTemplate.bulkUpdate(queryString);
	}

	/**
	 * 带参数的HSQL语句,更新、删除实体
	 * 
	 * @param queryString
	 *            HQL语句 例如:"update test t set t.id=? and t.name=?"
	 * @param values
	 *            参数 values[id,name]
	 * @return 无返回类型
	 */
	public void bulkUpdate(final String queryString, final Object[] values) {
		Assert.hasLength(queryString, "sql语句有误");
		Assert.notEmpty(values, "参数不能为空");
		hibernateTemplate.bulkUpdate(queryString, values);
	}

	/**
	 * 添加对象
	 * 
	 * @param entity
	 */
	public void create(T entity) {
		Assert.notNull(entity, "对象为空");
		logger.info("saving " + entity.getClass().getName() + " instance");
		hibernateTemplate.save(entity);
		logger.info("save successful");
	}

	/**
	 * 添加或者更新对象
	 * 
	 * @param entity
	 */
	public void saveOrUpdate(T entity) {
		Assert.notNull(entity, "对象为空");
		logger.info("saving " + entity.getClass().getName() + " instance");
		hibernateTemplate.saveOrUpdate(entity);
		logger.info("saveorupdate successful");
	}

	/**
	 * 以List为单位，向数据库表中存T对象
	 * 
	 * @param list
	 *            类型为T的List集合
	 */
	public void addList(List<T> list) {
		logger.info("saving list size " + list.size());
		this.getHibernateTemplate().saveOrUpdateAll(list);
		logger.info("saveorupdate successful");
	}

	/**
	 * 删除对象
	 * 
	 * @param entity
	 */
	public void deleteObject(T entity) {
		Assert.notNull(entity, "对象为空");
		logger.info("deleting " + entity.getClass().getName() + " instance");
		hibernateTemplate.delete(entity);
		logger.info("delete successful");
	}

	/**
	 * 批量删除
	 * 
	 * @param list
	 */
	public void deleteAll(List<?> list) {
		logger.info("delete list size " + list.size());
		hibernateTemplate.deleteAll(list);
		logger.info("delete successful");
	}

	/**
	 * 通过查询语句获取记录列表
	 * 
	 * @param queryString
	 *            HQL语句 例如:"from test t"
	 * @return list 返回list列表
	 */
	public List<T> find(final String queryString) {
		Assert.hasLength(queryString, "sql语句有误");
		return hibernateTemplate.find(queryString);
	}

	/**
	 * 通过查询语句获取记录列表
	 * 
	 * @param queryString
	 *            HQL语句 例如:"from test t where t.id = ? and t.name = ?"
	 * @param values
	 *            数组参数:values[id,name]
	 */

	public List<T> find(final String queryString, final Object[] values) {
		Assert.hasLength(queryString, "sql语句有误");
		Assert.notEmpty(values, "参数不能为空");
		return hibernateTemplate.find(queryString, values);
	}

	/**
	 * 通过查询语句获取记录列表
	 * 
	 * @param queryString
	 *            HQL语句 例如:"from test t where t.id = ? "
	 * @param values
	 *            参数:values
	 */

	public List<T> find(final String queryString, final Object values) {
		Assert.hasLength(queryString, "sql语句有误");
		return hibernateTemplate.find(queryString, values);
	}

	/**
	 * 通过主键获得对象
	 * 
	 * @param entity
	 *            实体类
	 * @param id
	 *            实体类id
	 * @return 如果数据库存在返回实体对象，不存在返回null
	 */
	public T findById(T entity, final Serializable id) {
		Assert.notNull(id, "传入的id不能为空");
		logger.info("finding " + entity.getClass().getName()
				+ " instance with id: " + id);
		return (T) hibernateTemplate.get(entity.getClass(), id);
	}

	/**
	 * 通过原始sql获取分页后的记录列表
	 * 
	 * @param "queryString " 查询语句
	 * 
	 * @param rowStartIdx
	 *            开始记录数
	 * @param rowCount
	 *            每页显示的记录数量
	 */
	public List<T> findBySQL(final String sql, final int rowStartIdx,
			final int rowCount) {
		return hibernateTemplate.executeFind(new HibernateCallback<Object>() {
			public Object doInHibernate(Session s) throws HibernateException,
					SQLException {
				SQLQuery query = s.createSQLQuery(sql);
				if (rowStartIdx != -1 && rowCount != -1) {
					query.setFirstResult(rowStartIdx);
					query.setMaxResults(rowCount);
				}
				List<T> list = query.list();
				return list;
			}
		});
	}

	/**
	 * 得到分页时的总数据
	 * 
	 * @param "原生态sql语句(sql语句)"
	 */
	public int findConut(final String queryString) {
		int count = -1;
		count = ((Integer) hibernateTemplate
				.execute(new HibernateCallback<Object>() {
					@Override
					public Object doInHibernate(Session sess)
							throws HibernateException, SQLException {
						try {
							SQLQuery q = sess.createSQLQuery(queryString)
									.addScalar("datacount", Hibernate.INTEGER);
							Integer count = (Integer) q.uniqueResult();
							return count;
						} catch (Exception e) {
							e.printStackTrace();
						}
						return new Integer(-1);
					}
				})).intValue();
		return count;
	}

	/**
	 * 通过查询语句获取分页后的记录列表
	 * 
	 * @param queryString
	 *            hql 查询语句
	 * @param rowStartIdx
	 *            开始记录数
	 * @param rowCount
	 *            每页显示的记录数量
	 */
	public List<T> findPaged(final String queryString, final int rowStartIdx,
			final int rowCount) {
		return hibernateTemplate.executeFind(new HibernateCallback<Object>() {
			@Override
			public Object doInHibernate(Session s) throws HibernateException,
					SQLException {
				Query query = s.createQuery(queryString);
				if (rowStartIdx != -1 && rowCount != -1) {
					query.setFirstResult(rowStartIdx);
					query.setMaxResults(rowCount);
				}
				List<T> list = query.list();
				return list;
			}
		});
	}

	/**
	 * IN 语句查询
	 * 
	 * @param queryString
	 *            select * from t where t.id IN (:inpaparamter);
	 * @param inpaparamter
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List<T> findByInParamter(final String queryString,
			final Collection inpaparamter) {
		return hibernateTemplate.executeFind(new HibernateCallback<Object>() {
			@Override
			public Object doInHibernate(Session s) throws HibernateException,
					SQLException {
				Query query = s.createQuery(queryString);
				query.setParameterList("inpaparamter", inpaparamter);
				List<T> list = query.list();
				return list;
			}
		});
	}

	/**
	 * 通过查询语句获取记录数
	 * 
	 * @param queryString
	 *            hql=select count(*) from Student
	 */

	public long findPagedConut(final String queryString) {
		Object count = hibernateTemplate.executeFind(
				new HibernateCallback<Object>() {
					@Override
					public Object doInHibernate(Session s)
							throws HibernateException, SQLException {
						Query query = s.createQuery(queryString);
						List<?> list = query.list();
						return list;
					}
				}).get(0);
		return (Long) count;
	}

	/**
	 * 通过查询语句获取单一记录
	 * 
	 * @param queryString
	 */
	public T findUnique(final String queryString) {
		Assert.hasLength(queryString, "sql语句有误");
		return (T) singleResult(hibernateTemplate.find(queryString));
	}

	/**
	 * 更新对象
	 * 
	 * @param entity
	 */
	public void update(T entity) {
		Assert.notNull(entity, "对对象为空");
		logger.info("updating " + entity.getClass().getName() + " instance");
		hibernateTemplate.update(entity);
		logger.info("update successful");
	}

	/**
	 * 批量插入
	 * 
	 * @param entityList
	 * @param size
	 * @create_time 2012-01-05
	 */
	public void batchSave(List<T> entityList) {
		Assert.notNull(entityList, "entityList不能为空");
		Session session = hibernateTemplate.getSessionFactory().openSession();
		Transaction transaction = session.beginTransaction();
		for (T entity : entityList) {
			session.save(entity);
		}
		session.flush();
		session.clear();
		transaction.commit();
		session.close();
	}
	/**
	 * 批量更新
	 * 
	 * @param entityList
	 * @param size
	 * @create_time 2012-01-05
	 */
	public void batchUpdate(List<T> entityList) {
		Assert.notNull(entityList, "entityList不能为空");
		Session session = hibernateTemplate.getSessionFactory().openSession();
		Transaction transaction = session.beginTransaction();
		for (T entity : entityList) {
			session.update(entity);
		}
		session.flush();
		session.clear();
		transaction.commit();
		session.close();
	}
	/**
	 * 通过SQL语句查询出结果
	 * 
	 * @param queryString
	 * @return
	 */
	public List<T> findBySql(final String queryString) {
		return hibernateTemplate.executeFind(new HibernateCallback<Object>() {
			@Override
			public Object doInHibernate(Session s) throws HibernateException,
					SQLException {
				Query query = s.createSQLQuery(queryString);
				List<T> list = query.list();
				return list;
			}
		});
	}
}
