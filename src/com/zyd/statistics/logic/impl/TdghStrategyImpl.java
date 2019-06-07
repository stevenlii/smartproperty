package com.zyd.statistics.logic.impl;

import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.zyd.statistics.logic.IStatisticsStrategyFacade;

/**
 * 投递关怀tdgh
 * 
 * @author li_zq
 * 
 */
@Scope("prototype")
@Service("tdghStrategyImpl")
public class TdghStrategyImpl extends ImportStatisticsImpl
		implements IStatisticsStrategyFacade {

	@Override
	public String Statistics(Map<String, String> map) {
		StringBuffer search = new StringBuffer();
		String StartDate = map.get("StartDate");
		String EndDate = map.get("EndDate");
		String entpsCode = map.get("entpsCode");
		String MailState = map.get("MailState");
		String mailNum = map.get("MailNum");//邮件号码
		String MailFailedState = map.get("MailFailedState");
		String chakan_company = map.get("chakan_company");
		if (entpsCode != null && !(entpsCode.isEmpty())) {
			search.append(" and t.Entps_Code = '" + entpsCode + "'");
		}
		if (MailState != null && !(MailState.isEmpty())) {
			search.append(" and t.Mail_State like '%" + MailState + "%'");
		}
		if (mailNum != null && !(mailNum.isEmpty())) {
			search.append(" and Mail_Num = '" + mailNum + "'");
		}
		if (MailFailedState != null) {
			search.append(" and t.Mail_State in ('投递并签收') ");
		}
		search = search_YYMM_String(search, "Bill_Date", StartDate, EndDate);
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
