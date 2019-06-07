package com.zyd.xtgl.logic;

import java.util.List;
import com.zyd.xtgl.domain.vo.SysOperate;

public interface IOperateFacade {
	/**
	 * 获取所有操作管理的信息
	 * 
	 * @return
	 */
	public List<SysOperate> getOperateList();

	/**
	 * 通过Id得到SysOperate实体
	 * 
	 * @return
	 */
	public SysOperate getOperateById(String operateid);

	/**
	 * 添加操作管理
	 * 
	 * @param operatebean
	 */

	public void addOperate(SysOperate operatebean);

	/**
	 * 更新操作管理
	 * 
	 * @param operatebean
	 */
	public void updateOperate(SysOperate operatebean);

	/**
	 * 删除用户
	 * 
	 * @param operateid
	 */
	public void deleteOperate(String operateid);

	/**
	 * 根据模块id查找操作管理
	 * 
	 * @param moduleId
	 * @return
	 */
	public List<SysOperate> getListByModleid(String modleid);
	/**
	 * 根据ddid查找操作管理
	 * @param ddid
	 * @return
	 */
	public List<SysOperate> getListByddid(String ddid);
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
	 * 
	 * @param hql
	 *            分页hql
	 * @param rowStartIdx
	 *            开始记录
	 * @param rowCount
	 *            每页记录数
	 * @return
	 */

	public long getOperatePageCount();

}
