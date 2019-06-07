package com.zyd.statistics.logic.impl;

import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.zyd.statistics.logic.IStatisticsStrategyFacade;

/**
 * 在途查询
 * 
 * @author li_zq
 * 
 */
@Scope("prototype")
@Service("onWayStatisticsStrategyImpl")
public class OnWayStatisticsStrategyImpl extends ImportStatisticsImpl
		implements IStatisticsStrategyFacade {

	@Override
	public String Statistics(Map<String, String> map) {
		StringBuffer search = new StringBuffer();
		String StartDate = map.get("StartDate");
		String EndDate = map.get("EndDate");
		String entpsCode = map.get("entpsCode");//入网企业代码[tdgh][mailpost]
		String mailNum = map.get("mailNum");//邮件号码
		String chakan_company = map.get("chakan_company");
		search.append(" and t.finish_td = 0");
		if (entpsCode != null && !(entpsCode.isEmpty())) {
			search.append(" and t.Entps_Code = '" + entpsCode + "'");
		}
		if (mailNum != null && !(mailNum.isEmpty())) {
			search.append(" and mailNum like '%" + mailNum + "%'");
		}
		search = search_YYMM_String(search, "Post_Date", StartDate, EndDate);
		if(chakan_company!=null&&!"".equals(chakan_company)){
			if(chakan_company.equals("no_company")){
				search.append(" and t.Entps_Code IN('"+chakan_company+"')");
			}else{
				search.append(" and t.Entps_Code IN("+chakan_company+")");
			}
		}
		return search.toString();
	}
}
