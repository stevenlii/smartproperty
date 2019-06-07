package com.zyd.report.dao;

import java.util.List;

import com.zyd.report.domain.vo.Syszhdmgndm;

public interface ISyszhdmgndmDAO extends IImportDAO<Syszhdmgndm> {
	//
	public List<Syszhdmgndm> getListByName(String dmmc);

}
