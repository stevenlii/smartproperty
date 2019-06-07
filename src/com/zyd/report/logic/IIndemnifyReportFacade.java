package com.zyd.report.logic;

import java.util.List;
import java.util.Map;

import com.zyd.report.domain.vo.TbIndemnify;
/**
 * 财务信息
 * @author lzq
 *
 */
public interface IIndemnifyReportFacade extends IImportReportFacade<TbIndemnify> {
	public List<TbIndemnify> getAllIndemnify(Map<String, String>map);
}
