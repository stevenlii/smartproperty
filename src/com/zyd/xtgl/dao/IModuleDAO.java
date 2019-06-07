package com.zyd.xtgl.dao;

import java.util.List;

import com.zyd.xtgl.domain.vo.SysModule;

public interface IModuleDAO {
	/**
	 * 获取节点下的模块
	 * 
	 * @param nodeid
	 * @return
	 */
	public List<SysModule> getNodeList(String nodeid);

	/**
	 * 添加模块
	 * 
	 * @param module
	 */
	public void saveModule(SysModule module);

	/**
	 * 更新模块
	 * 
	 * @param module
	 */
	public void updateModule(SysModule module);

	/**
	 * 删除模块
	 * 
	 * @param module
	 */
	public void deleteModule(SysModule module);

	/**
	 * 根据传入的主键ID删除数据（批量删除）
	 * 
	 * @param id
	 */
	public void deleteModuleById(String id);

	/**
	 * 根据模块ID获取模块信息
	 * 
	 * @param moduleId
	 * @return
	 */
	public SysModule getModuleById(String moduleId);
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
	public List<SysModule> getPageList(int rowStartIdx, int rowCount);

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
	public long getPageCount();
}