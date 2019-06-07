package com.zyd.xtgl.logic;

import java.util.List;
import java.util.Map;

import com.zyd.xtgl.domain.vo.SysModule;

public interface IModuleFacade {
	/**
	 * 
	 * @param nodeid
	 * @return
	 */
	public List<SysModule> getNodeList(String nodeid);

	/**
	 * 
	 * @param parentid
	 * @param list
	 * @return
	 */
	public List<Map<String, Object>> createTree(String parentid,
			List<SysModule> list);

	/**
	 * 
	 * @param module
	 */
	public void saveModule(SysModule module);

	/**
	 * 
	 * @param module
	 */
	public void updateModule(SysModule module);

	/**
	 * 
	 * @param module
	 */
	public void deleteModule(SysModule module);

	/**
	 * 
	 * @param moduleId
	 * @return
	 */
	public SysModule getModuleById(String moduleId);

	/**
	 * 根据传入的id参数删除数据（批量删除）
	 * 
	 * @param id
	 *            对象数组
	 */
	public void deleteModuleById(String id);
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
