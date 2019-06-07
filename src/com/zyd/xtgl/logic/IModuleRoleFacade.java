package com.zyd.xtgl.logic;

import java.util.List;

import com.zyd.xtgl.domain.vo.SysModuleRole;

public interface IModuleRoleFacade {
	/**
	 * 添加模块对角色对应关系
	 * 
	 * @param moduleRole
	 */
	public void saveModuleRole(SysModuleRole moduleRole);

	/**
	 * 删除一个 删除模块对角色对应关系
	 * 
	 * @param moduleRole
	 */

	public void deleteModuleRole(SysModuleRole moduleRole);

	/**
	 * 通过hibernate批量删除功能 根据ID删除一条记录
	 * 
	 * @param moduleRoleId
	 */
	public void deleteModuleRoleById(String moduleRoleId);

	/**
	 * 根据模块角色ID获取模块
	 * 
	 * @param moduleRoleId
	 * @return
	 */
	public SysModuleRole getModuleRoleById(String moduleRoleId);

	/**
	 * 根据模块id获取对于的角色信息
	 * 
	 * @param moduleId
	 * @return
	 */
	public List<SysModuleRole> getModuleRoleByIds(String moduleId);

	/**
	 * 
	 * @param moduleId
	 * @return
	 */
	public String getRoleIdsByModuleId(String moduleId);

	/**
	 * 检查模块下是否存在对应角色
	 * 
	 * @param object
	 * @return
	 */
	public boolean checkModuleToRole(String rid, String mid);

	/**
	 * 通过角色id找到模块对象
	 * 
	 * @param nodeId
	 * @return
	 */
	public List<SysModuleRole> getModuleRoleByRoleId(String nodeId);
}
