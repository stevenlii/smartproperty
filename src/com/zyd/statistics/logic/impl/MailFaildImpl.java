package com.zyd.statistics.logic.impl;

import java.util.List;
import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.zyd.statistics.logic.IStatisticsFacade;

@Scope("prototype")
@Service("statisticsMailFaildImpl")
public class MailFaildImpl implements IStatisticsFacade {

	@Override
	public List<?> Statistics(Map<String, String> map) {
		return null;
	}

}
