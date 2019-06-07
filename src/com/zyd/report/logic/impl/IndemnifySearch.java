package com.zyd.report.logic.impl;

import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.zyd.report.logic.IImportSearchFacade;
/**
 * 理赔查询
 * @author li_zq
 *
 */
@Scope("prototype")
@Service("searchIndemnify")
public class IndemnifySearch extends ImportSearchImpl implements
		IImportSearchFacade {

	@Override
	public String search(Map<String, String> map) {
		StringBuffer search = new StringBuffer();
		String mailNum = map.get("mailNum");
		String StartDate = map.get("StartDate");
		String EndDate = map.get("EndDate");
		String idmniCompany = map.get("idmniCompany");
		String indemnifysinglemailmum = map.get("indemnifysinglemailmum");
		String indemnifysinglemailmum2 = map.get("indemnifysinglemailmum2");
		String chakan_company = map.get("chakan_company");
		if (mailNum != null && !(mailNum.isEmpty())) {
			search.append(" and idmniMail like  '%" + mailNum + "%'");
		}
		if (idmniCompany != null && !(idmniCompany.isEmpty())) {
			search.append(" and idmniCompany = '" + idmniCompany + "'");
		}
		
		
		if (indemnifysinglemailmum != null && !(indemnifysinglemailmum.isEmpty())) {
			String[] indemnifymailmum = indemnifysinglemailmum.split("\n|\r\n|\r");
			StringBuffer searchmulmailmum = new StringBuffer();
			for (String singlemailmum : indemnifymailmum) {
				if (singlemailmum
						.equalsIgnoreCase(indemnifymailmum[indemnifymailmum.length - 1])) {
					searchmulmailmum.append("'"+singlemailmum.trim()+ "'");
				} else {
					searchmulmailmum.append("'"+singlemailmum.trim() + "',");
				}
			}
			search.append(" and idmniMail IN (" + searchmulmailmum.toString() + ")");
		}
		
		if (indemnifysinglemailmum2 != null && !(indemnifysinglemailmum2.isEmpty())) {
			String[] indemnifymailmum2 = indemnifysinglemailmum2.split("\n|\r\n|\r");
			StringBuffer searchmulmailmum = new StringBuffer();
			for (String singlemailmum : indemnifymailmum2) {
				if (singlemailmum
						.equalsIgnoreCase(indemnifymailmum2[indemnifymailmum2.length - 1])) {
					searchmulmailmum.append("'"+singlemailmum.trim()+ "'");
				} else {
					searchmulmailmum.append("'"+singlemailmum.trim() + "',");
				}
			}
			search.append(" and idmniMail IN (" + searchmulmailmum.toString() + ")");
		}
		search = search_companycode(map, search, "idmniCompany");
		search = search_YYMM_String(search, "idmniDate", StartDate, EndDate);
		if(chakan_company!=null&&!"".equals(chakan_company)){
			if(chakan_company.equals("no_company")){
				search.append(" and idmniCompany IN('"+chakan_company+"')");
			}else{
				search.append(" and idmniCompany IN("+chakan_company+")");
			}
		}
		return search.toString();
	}

}
