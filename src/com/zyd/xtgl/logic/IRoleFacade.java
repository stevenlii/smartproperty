package com.zyd.xtgl.logic;

import java.util.List;
import java.util.Map;

import com.zyd.xtgl.domain.vo.SysRole;

public interface IRoleFacade {
	/**
	 * 根据节点id获取节点下的角色信息
	 * 
	 * @param nodeid
	 * @return
	 */
	public List<SysRole> getNodeList(String nodeid);

	/**
	 * 菜单树需要的数据，根据客户端要求返回相应的数据格式，如，json,xml等。
	 * @param parentid
	 * @param list
	 * @return
	 */
	public List<Map<String, Object>> createTree(String parentid,
			List<SysRole> list);

	/**
	 * 保存角色信息
	 * @param role
	 */
	public void saveRole(SysRole role);

	/**
	 * 更新角色信息
	 * @param role
	 */
	public void updateRole(SysRole role);

	/**
	 * 删除角色信息，删除前请判断角色是否被使用
	 * @param role
	 */
	public void deleteRole(SysRole role);

	/**
	 * 根据角色id获取角色信息
	 * @param roleId
	 * @return
	 */
	public SysRole getRoleById(String roleId);

}
