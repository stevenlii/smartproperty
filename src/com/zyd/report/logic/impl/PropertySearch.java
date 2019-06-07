package com.zyd.report.logic.impl;

import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.zyd.report.logic.IImportSearchFacade;
/**
 * wuye查询
 * @author li_zq
 *
 */
@Scope("prototype")
@Service("propertySearch")
public class PropertySearch extends ImportSearchImpl implements
		IImportSearchFacade {

	@Override
	public String search(Map<String, String> map) {
		StringBuffer search = new StringBuffer();
		String propertyType = map.get("propertyType");
		if (propertyType != null && !(propertyType.isEmpty())) {
			search.append(" and propertyType= '"
					+ propertyType + "'");
		}
		return search.toString();
	}

}
