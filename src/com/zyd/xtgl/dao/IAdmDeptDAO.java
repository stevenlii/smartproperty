package com.zyd.xtgl.dao;

import java.util.List;

import com.zyd.xtgl.domain.vo.TbAdmDept;

public interface IAdmDeptDAO {
	/**
	 * 获取所有公司信息
	 * 
	 * @return
	 */
	public List<TbAdmDept> getAllDeptList();

	/**
	 * 添加公司
	 * 
	 * @param tbAdmDept
	 */
	public void addDept(TbAdmDept tbAdmDept);

	/***
	 * 删除公司
	 * 
	 * @param deptid
	 */
	public void deleteDept(String deptid);

	/**
	 * 更新公司
	 * 
	 * @param deptBean
	 */
	public void updateDept(TbAdmDept deptBean);

	/**
	 * 根据姓名查询公司
	 * 
	 * @param deptname
	 * @return 公司信息列表
	 */
	public List<TbAdmDept> getListByDeptname(String deptname);

	/**
	 * 根据公司id获取公司
	 * 
	 * @param deptid
	 * @return
	 */
	public TbAdmDept getDeptById(String deptid);
	
	//根据公司代码获取公司
	public  List<TbAdmDept> getList(String companycode);



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
	public List<TbAdmDept> getDeptPageList(int rowStartIdx, int rowCount,String codeId);
	
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
	public List<TbAdmDept> getDeptPageAllList(int rowStartIdx, int rowCount,String codeId);

	/**
	 * 分页总记录数
	 * 
	 * @return
	 */
	public long getDeptPageCount(String codeIds);
	
	/**
	 * 分页总记录数
	 * 
	 * @return
	 */
	public long getDeptPageAllCount(String codeIds);
}
