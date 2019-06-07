package com.zyd.report.dao;

import java.util.List;

/**
 * 导入报表的总DAO接口 封装导入报表的常用方法 这个接口应该由抽象类ImportDAOImpl实现，并且被实体DAO继承
 * 
 * @author lzq
 * 
 * @param <T>
 */
public interface IImportDAO<T> {
	// 增加相关方法 ////////////////////////////////////////////////////////
	/**
	 * 向数据库表中存单个对象
	 * 
	 * @param tb
	 *            T类型参数
	 */
	public void create(T tb);

	/**
	 * 添加或者更新对象
	 * 
	 * @param entity
	 */
	public void saveOrUpdate(T entity);

	/**
	 * 以List为单位，向数据库表中存T对象
	 * 
	 * @param list
	 *            类型为T的List集合
	 */
	public void addList(List<T> list);

	/**
	 * 批量存储list方法
	 * 
	 * @param T实体的list
	 * @param size
	 *            一次存储条数
	 */
	public void batchSave(List<T> entityList);

	// 删除相关方法 ////////////////////////////////////////////////////////
	/**
	 * 删除实体通过ID deleteById
	 * 
	 * @param queryString
	 *            HQL语句 例如:"update test t set t.id=? and t.name=?"
	 * @param values
	 *            参数 values[id,name]
	 * @return 无返回类型
	 */
	public void deleteById(String id);

	/**
	 * 按照delete语句删除
	 * 
	 * @param deleCondition
	 */
	public void delete(String deleCondition);

	/**
	 * 删除对象
	 * 
	 * @param entity
	 */
	public void deleteObject(T entity);

	/**
	 * 批量删除
	 * 
	 * @param list
	 */
	public void deleteAll(List<?> list);

	/**
	 * 
	 * @param hql
	 *            分页hql
	 * @param rowStartIdx
	 *            开始记录
	 * @param rowCount
	 *            每页记录数
	 * @return
	 */
	// 查找相关方法 ////////////////////////////////////////////////////////
	public List<T> getList(int rowStartIdx, int rowTotal);

	/**
	 * 分页总记录数
	 * 
	 * @return
	 */
	public long getPageTotal();

	/**
	 * 有条件的查询
	 * 
	 * @param searchCondition
	 *            查询条件
	 * @param rowStartIdx
	 * @param rowTotal
	 * @return
	 */
	public List<T> getList(String searchCondition, int rowStartIdx, int rowTotal);

	/**
	 * 有条件的获得记录总数
	 * 
	 * @param searchCondition
	 *            查询条件
	 * @return
	 */
	public long getPageTotal(String searchCondition);

	/**
	 * 得到所有的实体
	 * 
	 * @return T类型的所有实体，封装到List里面
	 */
	List<T> getAllList();

	/**
	 * 根据Id查找实体
	 * 
	 * @param entityId
	 * @return
	 */
	public T getEntityById(String entityId);

	// 更新方法 ////////////////////////////////////////////////////////
	/**
	 * 更新对象
	 * 
	 * @param entity
	 */

	public void update(T entity);

	// 其它辅助方法 ////////////////////////////////////////////////////////
	/**
	 * 防止重复数据
	 * 
	 * @param original重复数据依据
	 * @return 实体类引用
	 */
	public T avertRedund(String original);

	/**
	 * 防止重复数据
	 * 
	 * @param original重复数据依据
	 * @return 实体类引用
	 */
	public List<T> avertRedundList(String original);
}
