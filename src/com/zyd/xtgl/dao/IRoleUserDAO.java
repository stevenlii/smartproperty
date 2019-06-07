package com.zyd.xtgl.dao;

import java.util.List;

import com.zyd.xtgl.domain.vo.SysRoleUser;

public interface IRoleUserDAO {
	/**
	 * 向角色中添加用户
	 * 
	 * @param roleUser
	 */
	public void saveRoleUser(SysRoleUser roleUser);

	/**
	 * 更新角色中的用户信息
	 * 
	 * @param roleUser
	 */
	public void updateRoleUser(SysRoleUser roleUser);

	/**
	 * 根据角色ID获取角色对应的用户记录
	 * 
	 * @param roleId
	 * @return
	 */
	public List<SysRoleUser> getRoleUserByRoleId(String roleId);

	/**
	 * 根据角色id查询出角色下的用户，然后将用户ID已“,”分割成字符串
	 * 
	 * @param roleId
	 * @return
	 */
	public String getUserIdsByRoleId(String roleId);

	/**
	 * 
	 * @param roleUser
	 */
	public void deleteRoleUser(SysRoleUser roleUser);

	/**
	 * 删除角色对用户
	 * 
	 * @param roleUser
	 */
	public void deleteRoleUserById(String roleUserId);

	/**
	 * 得到用户的角色ID
	 * @param userId
	 * @return
	 */
	public String getRoleIdsByUserId(String userId);

	/**
	 * 根据用户id获取用户对应的角色
	 * 
	 * @param userId
	 * @return
	 */
	public List<SysRoleUser> getRoleUserByUserId(String userId);

	/**
	 * 检查角色下是否已经存在此用户
	 * 
	 * @param roleId
	 * @param userid
	 * @return
	 */
	public List<SysRoleUser> checkUserToRole(String roleId, String userid);
}