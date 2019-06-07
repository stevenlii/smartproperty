package com.zyd.xtgl.logic;

import java.util.List;
import java.util.Map;


import com.zyd.xtgl.domain.vo.TbAdmDept;

public interface IAdmDeptFacade {
	/**
	 * 获取所有公司信息
	 * 
	 * @return
	 */
	public List<TbAdmDept> getAllDeptList();

	/**
	 * 添加公司
	 * 
	 * @param
	 */

	public void addDept(TbAdmDept tbAdmDept);

	/**
	 * 删除公司
	 * 
	 * @param deptid
	 */
	public void delDept(String deptid);

	/**
	 * 更新公司信息
	 * 
	 * @param tbAdmDept
	 */
	public void updateDept(TbAdmDept tbAdmDept);

	/**
	 * 验证公公司姓名是否重复
	 * 
	 * @param deptBean
	 * @param operType
	 * @param errorInfoList
	 * @return
	 */
	public boolean checkDeptName(TbAdmDept deptBean);

	/**
	 * 根据部门ID获取公司名称
	 * 
	 * @param deptid
	 * @return
	 */
	public String getDeptnameById(String deptid);

	/**
	 * 根据主键获取公司信息
	 * @param deptid
	 * @return
	 */
	public TbAdmDept getDeptById(String deptid);

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
	 * 
	 * @param hql
	 *            分页hql
	 * @param rowStartIdx
	 *            开始记录
	 * @param rowCount
	 *            每页记录数
	 * @return
	 */
	public long getDeptPageCount(String codeIds);
	
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
	public long getDeptPageAllCount(String codeIds);
	
	
	public List<TbAdmDept> getList(Map<String, String> map);
}
