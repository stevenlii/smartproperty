package com.zyd.report.logic.impl;

import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.zyd.report.logic.IImportSearchFacade;
/**
 * 交寄查询
 * @author li_zq
 *
 */
@Scope("prototype")
@Service("noticeSearch")
public class NoticeSearch extends ImportSearchImpl implements
		IImportSearchFacade {

	@Override
	public String search(Map<String, String> map) {
		StringBuffer search = new StringBuffer();
		String notiedate = map.get("notiedate");
		if (notiedate != null && !(notiedate.isEmpty())) {
			search.append(" order by  notice_date ");
		}
		return search.toString();
	}

}
