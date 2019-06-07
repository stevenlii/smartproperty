package com.zyd.statistics.logic.impl;

import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.zyd.statistics.logic.IStatisticsStrategyFacade;

/**
 * 投递关联(tb_relation_tdgh)
 * 
 * @author li_zq
 * 
 */
@Scope("prototype")
@Service("relationtdghStrategyImpl")
public class RelationtdghStrategyImpl extends ImportStatisticsImpl
		implements IStatisticsStrategyFacade {

	@Override
	public String Statistics(Map<String, String> map) {
		StringBuffer search = new StringBuffer();
		String StartDate = map.get("StartDate");
		String EndDate = map.get("EndDate");
		String entpsCode = map.get("entpsCode");
		String MailState = map.get("MailState");
		String mailNum = map.get("MailNum");//邮件号码
		String MailTimeSny = map.get("MailTimeSny");
		if (entpsCode != null && !(entpsCode.isEmpty())) {
			search.append(" and t.Entps_Code = '" + entpsCode + "'");
		}
		if (MailState != null && !(MailState.isEmpty())) {
			search.append(" and t.tdfinished like '" + MailState + "'");
		}
		if (mailNum != null && !(mailNum.isEmpty())) {
			search.append(" and mailnum like '" + mailNum + "'");
		}
		if (MailTimeSny != null && !(MailTimeSny.isEmpty())) {
			search.append(" and mailnum like '" + MailTimeSny + "'");
			search = search_YYMM_String(search, "Post_Date", StartDate, EndDate);
		}else {
			search = search_YYMM_String(search, "tdfinishedtime", StartDate, EndDate);
		}
		return search.toString();
	}
}
