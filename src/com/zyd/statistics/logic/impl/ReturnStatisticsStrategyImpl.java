package com.zyd.statistics.logic.impl;

import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.zyd.statistics.logic.IStatisticsStrategyFacade;

/**
 * 退回
 * 
 * @author li_zq
 * 
 */
@Scope("prototype")
@Service("returnStatisticsStrategyImpl")
public class ReturnStatisticsStrategyImpl extends ImportStatisticsImpl
		implements IStatisticsStrategyFacade {

	@Override
	public String Statistics(Map<String, String> map) {
		StringBuffer search = new StringBuffer();
		String StartDate = map.get("StartDate");
		String EndDate = map.get("EndDate");
		String entpsCode = map.get("entpsCode");//入网企业代码[tdgh][mailpost]
		String mailNum = map.get("mailNum");//邮件号码
		String Infe_tonet_Code = map.get("Infe_tonet_Code");//下级入网企业代码[tb_finance]
		String chakan_company = map.get("chakan_company");

		if (entpsCode != null && !(entpsCode.isEmpty())) {
			search.append(" and t.Entps_Code = '" + entpsCode + "'");
		}
		if (mailNum != null && !(mailNum.isEmpty())) {
			search.append(" and Mail_Num like '%" + mailNum + "%'");
		}
		if (Infe_tonet_Code != null && !(Infe_tonet_Code.isEmpty())) {
			search.append(" and Infe_tonet_Code = '" + Infe_tonet_Code + "%'");
		}
		search = search_YYMM_String(search, "Return_Date", StartDate, EndDate);
		if(chakan_company!=null&&!"".equals(chakan_company)){
			if(chakan_company.equals("no_company")){
				search.append(" and Infe_tonet_Code IN('"+chakan_company+"')");
			}else{
				search.append(" and Infe_tonet_Code IN("+chakan_company+")");
			}
		}
		return search.toString();
	}
}
