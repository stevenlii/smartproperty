package com.zyd.report.dao;

import java.util.List;

import com.zyd.report.domain.vo.TbIndemnify;
public interface IIndemnifyDAO extends IImportDAO<TbIndemnify> {
	
	public List<TbIndemnify> getAllIndemnify(String searchCondition);

}
