package com.zyd.xtgl.logic;

import java.util.List;

import com.zyd.xtgl.domain.vo.SysModule;
import com.zyd.xtgl.domain.vo.TbAdmUser;

public interface IAdmUserFacade {
	/**
	 * 获取所有用户信息
	 * 
	 * @return
	 */
	public List<TbAdmUser> getUserList();

	/**
	 * 添加用户
	 * 
	 * @param roleValue
	 */
	public void addUser(TbAdmUser roleValue);


	/**
	 * 更新用户
	 * 
	 * @param userBean
	 */
	public void updateUser(TbAdmUser userBean);

	/**
	 * 删除用户
	 * 
	 * @param userid
	 */
	public void delUser(String userid);

	/**
	 * 用户登陆校验
	 * 
	 * @param userName
	 * @param pwd
	 * @return
	 */
	public boolean checkUser(String userName, String pwd);
	/**
	 * 
	 * @param userBean
	 * @return
	 */
	public boolean checkUserName(String userName);
	/**
	 * 更新用户密码
	 * 
	 * @param userId
	 * @param newUserPass11
	 */
	public void updateUserPass(String userId, String newUserPass11);

	/**
	 * 根据登陆用户获取要显示的权限菜单Menu
	 * (用来获得父ID)
	 * @param userPriveleges
	 * @param userId
	 * @return
	 */
	public List<SysModule> getMainMenu(String userId);
	/**
	 * 根据登陆用户获取要显示的权限菜单Menu
	 * (用来获得子ID)
	 * @param userPriveleges
	 * @param userId
	 * @return
	 */
	public List<SysModule> getMainMenuChildren(String userId);

	/**
	 * 根据部门ID查询出部门下的用户
	 * 
	 * @param deptid
	 * @return
	 */
	public List<TbAdmUser> getUserListOfDept(String deptid);

	/**
	 * 根据用户姓名查询出用户信息
	 * 
	 * @param userName
	 * @return
	 */
	public TbAdmUser getCuruserinfo(String userName);


	/**
	 * 
	 * @param userid
	 * @param roleId
	 * @return
	 */
	public boolean getIsManagerType(String userid, String roleId);

	/**
	 * 根据用户ID查询出用户的信息
	 * 
	 * @param userid
	 * @return
	 */
	public TbAdmUser getByUserid(String userid);

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
	public List<TbAdmUser> getUserPageList(int rowStartIdx, int rowCount);

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
	public long getUserPageCount();
}
