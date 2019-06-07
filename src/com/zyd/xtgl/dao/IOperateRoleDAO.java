package com.zyd.xtgl.dao;

import java.util.List;

import com.zyd.xtgl.domain.vo.SysOperate;
import com.zyd.xtgl.domain.vo.SysOperateRole;

public interface IOperateRoleDAO extends IInputDAO<SysOperateRole>{

	/**
	 * 添加操作下对应角色信息
	 * 
	 * @param OperateRole
	 */
	public void saveOperateRole(SysOperateRole OperateRole);

	/**
	 * 删除操作下对应的角色信息 根据实体对象删除一条记录
	 * 
	 * @param OperateRole
	 */
	public void deleteOperateRole(SysOperateRole OperateRole);

	/**
	 * 根据主键删除操作下对应的角色信息
	 * 
	 * @param OperateRole
	 */
	public void deleteOperateRoleById(String OperateRoleId);

	/**
	 * 根据主键获取操作对角色信息
	 * 
	 * @param OperateRoleId
	 * @return
	 */
	public SysOperateRole getOperateRoleById(String OperateRoleId);

	/**
	 * 根据操作ID获取操作对应的角色列表
	 * 
	 * @param OperateId
	 * @return
	 */
	public List<SysOperateRole> getOperateRoleByIds(String OperateId);

	/**
	 * 根据操作ID获取角色id字符串，用","分割的字符串
	 * 
	 * @param OperateId
	 * @return
	 */
	public String getRoleIdsByOperateId(String OperateId);

	/**
	 * 获取模块下操作的列表信息
	 * 
	 * @param nodeid
	 * @return
	 */
	public List<SysOperate> getNodeList(String nodeid);

	/**
	 * 检查操作重复
	 * 
	 * @param object
	 * @return
	 */
	public List<SysOperateRole> checkOperateToRole(String rid,String oid);
	/**
	 * 根据roleid获取对象id
	 * @param nodeId
	 * @return
	 */
	public List<SysOperateRole> getOperateRoleByRoleId(String nodeId);
}
