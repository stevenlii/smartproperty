package com.zyd.statistics.logic.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.zyd.statistics.dao.IStaticsDAO;
import com.zyd.statistics.logic.IStatisticsFacade;
import com.zyd.statistics.logic.IStatisticsStrategyFacade;

@Scope("prototype")
@Service("mailSuccessStaticsImpl")
public class MailSuccessStaticsImpl implements IStatisticsFacade {

	@Resource(name = "mailPostStaticsDAOImpl")
	private IStaticsDAO<?> mailPostStaticsDAOImpl;
	@Resource(name = "mailSuccessStatisticsStrategyImpl")
	private IStatisticsStrategyFacade mailSuccessStatisticsStrategyImpl;

	@Override
	public List<?> Statistics(Map<String, String> map) {
		return mailPostStaticsDAOImpl.getStaticsList(map,
				mailSuccessStatisticsStrategyImpl.Statistics(map));
	}

}
