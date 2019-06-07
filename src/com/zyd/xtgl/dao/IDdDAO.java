package com.zyd.xtgl.dao;

import java.util.List;

import com.zyd.xtgl.domain.vo.SysDd;

public interface IDdDAO extends IInputDAO<SysDd>{
	public List<SysDd> getList(String search);
}
