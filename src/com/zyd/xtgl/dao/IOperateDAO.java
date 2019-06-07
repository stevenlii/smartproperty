package com.zyd.xtgl.dao;

import java.util.List;

import com.zyd.xtgl.domain.vo.SysOperate;


public interface IOperateDAO {
	/**
	 * 获取所有操作
	 * @return
	 */
	public List<SysOperate> getAllActionList();
	/**
	 * 添加操作
	 * @param sysaction
	 */
	public void addSysAction(SysOperate sysaction);
	/**
	 * 更新操作
	 * @param sysaction
	 */
	public void updateSysAction(SysOperate sysaction);
	/**
	 * 删除操作
	 * @param sysaction
	 */
	public void deleteSysAction(String operateid);
	/**
	 * 获取模块下的全部操作
	 * @param modleid
	 * @return
	 */
	public List<SysOperate> getListByModleid(String modleid);
	public List<SysOperate> getListByddid(String ddid);
 /**
  * 根据ID查找
  * @param operateid
  * @return
  */
	public  SysOperate  getOperateById(String operateid);
	 
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
	public List<SysOperate> getOperatePageList(int rowStartIdx, int rowCount);
	
	
 

	/**
	 * 分页总记录数
	 * 
	 * @return
	 */
	public long getOperatePageCount();
 
	 
}
