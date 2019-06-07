package com.zyd.report.logic.impl;

import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.zyd.report.logic.IImportSearchFacade;
/**
 * 综合查询
 * @author 
 *
 */
@Scope("prototype")
@Service("searchIntegrated")
public class IntegratedSearch extends ImportSearchImpl implements
		IImportSearchFacade {

	@Override
	public String search(Map<String, String> map) {
		StringBuffer search = new StringBuffer();
		String mailNum = map.get("mailNum");//邮件号
		String entpsCode = map.get("entpsCode");//邮购公司
		String aceptDatestartmonth = map.get("aceptDatestartmonth");  //交寄时间
		String aceptDateendmonth = map.get("aceptDateendmonth");
		String pa95startmonth = map.get("pa95startmonth");// 结算周期
		String pa95endmonth = map.get("pa95endmonth");
		String StartDate = map.get("StartDate");//投递日期
		String EndDate = map.get("EndDate");
		String tdfinished=map.get("tdfinished");//投递状态
		String chakan_company = map.get("chakan_company");
		 
		if (mailNum != null && !(mailNum.isEmpty())) {
			search.append(" and t.tbmailPost.mailNum like '%" + mailNum + "%'");
		}
		if (entpsCode != null && !(entpsCode.isEmpty())) {
			search.append(" and t.tbmailPost.entpsCode = '" + entpsCode + "'");
		}
		if (tdfinished != null && !(tdfinished.isEmpty())) {
			search.append(" and t.tbTdgh.tdfinished = '" + tdfinished + "'");
		}
	 
		search = search_companycode(map, search, "t.tbmailPost.entpsCode");
		search = search_YYMMDD_Date(search, "tbmailPost.postDate", aceptDatestartmonth,
				aceptDateendmonth);//
		search = search_YYMMDD_Date(search, "tbFinance.billDate", pa95startmonth,
				pa95endmonth);   //结算日期
		search = search_YYMM_String(search, "tbTdgh.tdfinishedtime", StartDate, EndDate);//投递日期
		if(chakan_company!=null&&!"".equals(chakan_company)){
			if(chakan_company.equals("no_company")){
				search.append(" and t.tbmailPost.entpsCode IN('"+chakan_company+"')");
			}else{
				search.append(" and t.tbmailPost.entpsCode IN("+chakan_company+")");
			}
		}
		return search.toString();
	}
	
	
	 
}
