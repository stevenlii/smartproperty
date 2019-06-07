package com.zyd.xtgl.dao;

import java.util.List;

import com.zyd.xtgl.domain.vo.SysRole;

public interface IRoleDAO {
	/***
	 * 返回所有此节点下的子节点信息
	 * 
	 * @param nodeid
	 * @return
	 */
	public List<SysRole> getNodeList(String nodeid);

	/**
	 * 保存角色信息
	 * 
	 * @param role角色持久化对象
	 */
	public void saveRole(SysRole role);

	/**
	 * 更新角色信息
	 * 
	 * @param role角色持久化对象
	 */
	public void updateRole(SysRole role);

	/**
	 * 删除角色信息 删除前需要做角色是否被使用的判断
	 * 
	 * @param role角色持久化对象
	 */
	public void deleteRole(SysRole role);

	/**
	 * 根据角色id返回角色对象信息
	 * 
	 * @param roleId
	 * @return
	 */
	public SysRole getRoleById(String roleId);
}