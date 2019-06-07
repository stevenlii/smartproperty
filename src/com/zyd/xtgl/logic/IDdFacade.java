package com.zyd.xtgl.logic;

import java.util.List;
import java.util.Map;

import com.zyd.xtgl.domain.vo.SysDd;


public interface IDdFacade extends IInputFacade<SysDd>{
	public List<SysDd> getList(Map<String, String> map);
}
