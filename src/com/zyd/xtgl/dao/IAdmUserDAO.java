package com.zyd.xtgl.dao;

import java.util.List;

import com.zyd.xtgl.domain.vo.TbAdmUser;

public interface IAdmUserDAO {
	/**
	 * 获取说有用户信息
	 * 
	 * @return
	 */
	public List<TbAdmUser> getUserList();

	/**
	 * 根据用户登录ID查询，返回用户列表
	 * 
	 * @param userName
	 * @return
	 */
	public List<TbAdmUser> getListByUsername(String userName);

	/**
	 * 添加用户
	 * 
	 * @param userBean
	 */
	public void addUser(TbAdmUser userBean);

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
	 * 修改用户密码
	 * 
	 * @param userId
	 * @param newUserPass11
	 */
	public void changeUserPass(String userId, String newUserPass11);

	/**
	 * 根据部门ID查询出部门下的用户
	 * 
	 * @param deptid
	 * @return
	 */
	public List<TbAdmUser> getUserListOfDept(String deptid);

	/**
	 * 根据用户id获取用户信息
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
	 * 分页总记录数
	 * 
	 * @return
	 */
	public long getUserPageCount();

}
