package com.zyd.report.web.action;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 此类中的方法 主要是与录入有关的相关操作（包括对单个表的CRUD）
 * 
 * @author li_zq
 * 
 */
@Controller
@RequestMapping(value = "/input")
public class AllInputAction extends InputmultipleAction {
	static final Logger logger = LoggerFactory
			.getLogger(AllInputAction.class);
}
