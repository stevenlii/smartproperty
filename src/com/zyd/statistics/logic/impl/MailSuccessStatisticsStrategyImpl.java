package com.zyd.statistics.logic.impl;

import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.zyd.statistics.logic.IStatisticsStrategyFacade;

/**
 * 妥投邮件统计
 * 
 * @author li_zq
 * 
 */
@Scope("prototype")
@Service("mailSuccessStatisticsStrategyImpl")
public class MailSuccessStatisticsStrategyImpl extends ImportStatisticsImpl
		implements IStatisticsStrategyFacade {

	@Override
	public String Statistics(Map<String, String> map) {
		StringBuffer search = new StringBuffer();
		String StartDate = map.get("StartDate");
		String EndDate = map.get("EndDate");
		String mailNum = map.get("mailNum");// 邮件号码
		String BillMailTypes = map.get("BillMailTypes");
		String Infe_tonet_Code = map.get("Infe_tonet_Code");// 下级入网企业代码[tb_finance]

		if (mailNum != null && !(mailNum.isEmpty())) {
			search.append(" and Mail_Num like '%" + mailNum + "%'");
		}
		if (Infe_tonet_Code != null && !(Infe_tonet_Code.isEmpty())) {
			search.append(" and Infe_tonet_Code = '" + Infe_tonet_Code + "'");
		}
		if (BillMailTypes != null && !(BillMailTypes.isEmpty())) {
			search.append(" and BillMail_Types = '" + BillMailTypes + "'");
		}
		search = search_YYMM_String(search, "Bill_Date", StartDate, EndDate);
		return search.toString();
	}
}
