package com.zyd.xtgl.logic;

import java.util.List;

import com.zyd.xtgl.domain.vo.SysOperateRole;

public interface IOperateRoleFacade {
	/**
	 * 添加操作对角色对应关系
	 * 
	 * @param OperateRole
	 */
	public void saveOperateRole(SysOperateRole OperateRole);

	/**
	 * 删除一个 删除操作对角色对应关系
	 * 
	 * @param OperateRole
	 */

	public void deleteOperateRole(SysOperateRole OperateRole);

	/**
	 * 通过hibernate批量删除功能
	 * 
	 * @param OperateRoleId
	 */
	public void deleteOperateRoleById(String OperateRoleId);

	/**
	 * 根据操作角色ID获取操作
	 * 
	 * @param OperateRoleId
	 * @return
	 */
	public SysOperateRole getOperateRoleById(String OperateRoleId);

	/**
	 * 根据操作id获取对于的角色信息
	 * 
	 * @param OperateId
	 * @return
	 */
	public List<SysOperateRole> getOperateRoleByIds(String OperateId);

	/**
	 * 
	 * @param OperateId
	 * @return
	 */
	public String getRoleIdsByOperateId(String OperateId);

	/**
	 * 检查操作下是否存在对应角色
	 * 
	 * @param object
	 * @return
	 */
	public boolean checkOperateToRole(String rid, String mid);

	/**
	 * 通过角色id找到操作对象
	 * 
	 * @param nodeId
	 * @return
	 */
	public List<SysOperateRole> getOperateRoleByRoleId(String nodeId);
}
