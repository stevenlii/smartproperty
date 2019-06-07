package com.zyd.xtgl.logic;

import java.util.List;

import com.zyd.xtgl.domain.vo.TbSjzd;

public interface ISjzdFacade {
	/**
	 * 添加
	 * @param sjzd
	 */
	public void addSjzd(TbSjzd sjzd);

	/**
	 * 实体对象删除
	 * @param sjzd
	 */
	public void deleteSjzd(TbSjzd sjzd);

	/**
	 * 根据id删除字典
	 * @param id
	 */
	public void deleteSjzd(String id);

	/**
	 * 更新字典
	 * @param sjzd
	 */
	public void updateSjzd(TbSjzd sjzd);

	/**
	 * 所有记录
	 * @return
	 */
	public List<TbSjzd> getAllList();

	/**
	 * 根据类型查询出此类型下的list
	 * @param zdtype
	 * @return
	 */
	public List<TbSjzd> getListByZdtype(Long zdtype);

	/**
	 * 分页记录数
	 * @param rowStartIdx
	 * @param rowCount
	 * @return
	 */
	public List<TbSjzd> getPageList(int rowStartIdx, int rowCount,Long zdtype);

	/**
	 * 分页总数
	 * 
	 * @return
	 */
	public long getPageCount(Long zdtype);


}
