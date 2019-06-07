package com.zyd.xtgl.logic;

import java.util.List;

import com.zyd.xtgl.domain.vo.SysRoleUser;

public interface IRoleUserFacade {
	/**
	 * 添加角色对应用户
	 * @param roleUser
	 */
	public void saveRoleUser(SysRoleUser roleUser);

	/**
	 * 更新角色对应用户
	 * @param roleUser
	 */
	public void updateRoleUser(SysRoleUser roleUser);

	/**
	 * 根据角色ID获取角色下的对应用户
	 * @param RoleId
	 * @return
	 */
	public List<SysRoleUser> getRoleUserByRoleId(String roleId);

	/**
	 * 根据角色id，获取用户字符串，用","分割的用户id
	 * @param roleId
	 * @return
	 */
	public String getUserIdsByRoleId(String roleId);

	/**
	 * 删除角色对用户
	 * @param roleUser
	 */
	public void deleteRoleUser(SysRoleUser roleUser);
	/**
	 * 删除角色对用户
	 * @param roleUser
	 */
	public void deleteRoleUserById(String roleUserId);
	/**
	 *根据用户id获取用户对应的角色
	 * @param userId
	 * @return
	 */
	public List<SysRoleUser> getRoleUserByUserId(String userId);
	/**
	 * 检查角色下是否已经存在此用户
	 * @param roleId
	 * @param userid
	 * @return
	 */
	public boolean checkUserToRole(String roleId,String userid);
}
