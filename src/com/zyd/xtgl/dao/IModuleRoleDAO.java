package com.zyd.xtgl.dao;

import java.util.List;

import com.zyd.xtgl.domain.vo.SysModule;
import com.zyd.xtgl.domain.vo.SysModuleRole;

public interface IModuleRoleDAO {
	/**
	 * 添加模块下对应角色信息
	 * 
	 * @param moduleRole
	 */
	public void saveModuleRole(SysModuleRole moduleRole);

	/**
	 * 删除模块下对应的角色信息 根据实体对象删除一条记录
	 * 
	 * @param moduleRole
	 */
	public void deleteModuleRole(SysModuleRole moduleRole);

	/**
	 * 根据主键删除模块下对应的角色信息
	 * 
	 * @param moduleRole
	 */
	public void deleteModuleRoleById(String moduleRoleId);

	/**
	 * 根据主键获取模块对角色信息
	 * 
	 * @param moduleRoleId
	 * @return
	 */
	public SysModuleRole getModuleRoleById(String moduleRoleId);

	/**
	 * 根据模块ID获取模块先对应的角色列表
	 * 
	 * @param moduleId
	 * @return
	 */
	public List<SysModuleRole> getModuleRoleByIds(String moduleId);
	/**
	 * 根据角色ID获取模块对应的用户记录
	 * 
	 * @param roleId
	 * @return
	 */
	public List<SysModuleRole> getModuleRoleByRoleId(String roleId);

	/**
	 * 根据模块ID获取角色id字符串，用","分割的字符串
	 * 
	 * @param moduleId
	 * @return
	 */
	public String getRoleIdsByModuleId(String moduleId);

	/**
	 * 根据用户ID和模块id获取对应的模块权限
	 * 
	 * @param moduleId
	 * @param userId
	 * @return
	 */
	public boolean hasPrivilege(String moduleId, String userId);

	/**
	 * 获取父模块下子模块的列表信息
	 * 
	 * @param nodeid
	 * @return
	 */
	public List<SysModule> getNodeList(String nodeid);

	/**
	 * 检查模块下是否存在对应模块
	 * 
	 * @param object
	 * @return
	 */
	public List<SysModuleRole> checkModuleToRole(String roleId, String mid);
	

}