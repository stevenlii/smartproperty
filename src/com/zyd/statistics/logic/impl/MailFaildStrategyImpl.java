package com.zyd.statistics.logic.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.zyd.statistics.dao.IFaildStaticsDAO;
import com.zyd.statistics.logic.IStatisticsFaildFacade;

/**
 * 未妥投service实现类
 * 
 * @author liu_gl
 * 
 */
@Scope("prototype")
@Service("statisticsMailFaildStrategyImpl")
public class MailFaildStrategyImpl extends ImportStatisticsImpl implements
			IStatisticsFaildFacade {
	@Resource(name="faildStaticsDAOImpl")
	private IFaildStaticsDAO faildStaticsDAOImpl;
	@Override
	public String Statistics(Map<String, String> map) {
		StringBuffer search = new StringBuffer("SELECT t.Bill_Date, t.Mail_Num,t.Entps_Code,t.Mail_State FROM tb_tdgh t where 1=1 and t.Mail_State LIKE '%未妥投%'");
		String StartDate = map.get("StartDate");
		String EndDate = map.get("EndDate");
		String entpsCode = map.get("companyCode");
		String chakan_company = map.get("chakan_company");
		if (entpsCode != null && !(entpsCode.isEmpty())) {
			search.append(" and t.Entps_Code = '" + entpsCode + "'");
		}
		if(chakan_company!=null&&!"".equals(chakan_company)){
			if(chakan_company.equals("no_company")){
				search.append(" and t.Entps_Code IN('"+chakan_company+"')");
			}else{
				search.append(" and t.Entps_Code IN("+chakan_company+")");
			}
		}
		search = search_YYMM_String(search, "Bill_Date", StartDate, EndDate);
		search.append(" and t.Mail_Num NOT IN(SELECT DISTINCT t.Mail_Num FROM tb_tdgh t,tb_relation_tdgh r where t.Mail_Num =r.mailnum and t.Mail_State LIKE '%未妥投%'");
		search = search_YYMM_String(search, "Bill_Date", StartDate, EndDate);
		if(chakan_company!=null&&!"".equals(chakan_company)){
			if(chakan_company.equals("no_company")){
				search.append(" and t.Entps_Code IN('"+chakan_company+"')");
			}else{
				search.append(" and t.Entps_Code IN("+chakan_company+")");
			}
		}
		search.append(")");
		return search.toString();
	}

	@Override
	public List<Object[]> getFaildList(String sql) {
		// TODO Auto-generated method stub
		List<Object[]> list =faildStaticsDAOImpl.getList(sql);
		return list;
	}
	
}
