package com.zyd.report.logic.impl;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.zyd.common.CellParseTools;
import com.zyd.report.dao.IIndemnifyDAO;
import com.zyd.report.domain.vo.TbIndemnify;
import com.zyd.report.logic.IImportSearchFacade;
import com.zyd.report.logic.IIndemnifyReportFacade;
import com.zyd.xtgl.domain.vo.TbAdmDept;
import com.zyd.xtgl.logic.IAdmDeptFacade;

@Scope("prototype")
@Service("indemnifyReportImpl")
public class IndemnifyReportImpl extends ImportReportImpl<TbIndemnify>
		implements IIndemnifyReportFacade {
	@Resource(name = "indemnifyDAOImpl")
	private IIndemnifyDAO daoImpl;
	@Resource(name = "searchIndemnify")
	private IImportSearchFacade searchIndemnify;
	@Resource(name = "admDeptImpl")
	private IAdmDeptFacade admDeptImpl;

	@Override
	public TbIndemnify avertRedund(String original) {
		// TODO Auto-generated method stub
		return daoImpl.avertRedund(original);
	}

	@Override
	public void saveOrUpdate(TbIndemnify entity) {
		// TODO Auto-generated method stub

	}

	@Override
	public void addList(List<TbIndemnify> list) {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteById(String id) {
		// TODO Auto-generated method stub
		daoImpl.deleteById(id);
	}

	@Override
	public void deleteObject(TbIndemnify entity) {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteAll(List<?> list) {
		// TODO Auto-generated method stub

	}

	@Override
	public void batchSave(List<TbIndemnify> entityList) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<TbIndemnify> getList(int rowStartIdx, int rowTotal) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public long getPageTotal() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<TbIndemnify> getList(Map<String, String> map, int rowStartIdx,
			int rowTotal) {
		// TODO Auto-generated method stub
		return parseToDeptName(map, rowStartIdx, rowTotal);
	}

	private List<TbIndemnify> parseToDeptName(Map<String, String> map,
			int rowStartIdx, int rowTotal) {
		List<TbIndemnify> list = daoImpl.getList(searchIndemnify.search(map), rowStartIdx,
				rowTotal);
		Map<String, String> ecodeMap = new HashMap<String, String>();
		List<TbIndemnify> returnlist = new ArrayList<TbIndemnify>();
		for (TbIndemnify tb : list) {
			String ecode = tb.getIdmniCompany();
			ecodeMap.put("companycode", ecode);
			List<TbAdmDept> dept = admDeptImpl.getList(ecodeMap);
			if (dept != null && dept.size() > 0) {
				tb.setDeptName(dept.get(0).getDeptname());
			} else {
				tb.setDeptName(ecode + NOECODE);
			}
			returnlist.add(tb);
		}
		return returnlist;
	}

	@Override
	public long getPageTotal(Map<String, String> searchCondition) {
		// TODO Auto-generated method stub
		return daoImpl.getPageTotal(searchIndemnify.search(searchCondition));
	}

	@Override
	public List<TbIndemnify> getAllList() {
		// TODO Auto-generated method stub
		return daoImpl.getAllList();
	}

	@Override
	public TbIndemnify getEntityById(String entityId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void create(Object tb) {
		// TODO Auto-generated method stub

		daoImpl.create((TbIndemnify) tb);
	}

	@Override
	public void update(Object entity) {
		// TODO Auto-generated method stub

		daoImpl.update((TbIndemnify) entity);
	}

	@Override
	public Map<String, String> uploadimportReport(Map<String, String> map)
			throws Exception {
		Map<String, String> afterImportMap = new HashMap<String, String>();
		boolean importSuccess = false;// 装载失败
		long importSuccessNum = 0;// 装载成功
		long importDuplicateNum = 0;// 装载失败
		
		FileInputStream in = null;
		HSSFWorkbook workbook = null;
		in = new FileInputStream(map.get("path"));
		POIFSFileSystem fs = new POIFSFileSystem(in);
		workbook = new HSSFWorkbook(fs);
		in.close();
		HSSFSheet sheet = workbook.getSheetAt(0);// 取sheet
		int rowAll = sheet.getLastRowNum();// 总共row2行
		List<TbIndemnify> list = new ArrayList<TbIndemnify>();
		for (int i = 1; i <= rowAll; i++) {
			TbIndemnify tb = new TbIndemnify();
			HSSFRow row = sheet.getRow(i);
			if (row != null) {
				// HSSFCell tbMonth = row.getCell(0);// 表日期
				HSSFCell idmniCompany = row.getCell(0);// 涉及赔偿公司
				HSSFCell idmniMail = row.getCell(1);// 涉及赔偿邮件
				HSSFCell idmniAmount = row.getCell(2);// 赔偿金额(两位小数)
				HSSFCell idmniDate = row.getCell(3);// 赔偿日期
				HSSFCell idmniReason = row.getCell(4);// 赔偿原因(中、英、数 200个字)
				HSSFCell remark = row.getCell(5);// 备注(100字)
				if (idmniCompany != null) {
					tb.setIdmniCompany(CellParseTools.parseString(idmniCompany));
				}
				if (idmniMail != null) {
					tb.setIdmniMail(CellParseTools.parseString(idmniMail));
				}
				if (idmniAmount != null) {
					tb.setIdmniAmount(CellParseTools
							.parseBigDecimal(idmniAmount));
				}
				if (idmniDate != null) {
					tb.setIdmniDate(CellParseTools.parseToDatetime(idmniDate));
				}
				if (idmniReason != null) {
					tb.setIdmniReason(CellParseTools.parseString(idmniReason));
				}
				if (remark != null) {
					tb.setRemark(CellParseTools.parseString(remark));
				}
				if (map.get("filename") != null) {
					tb.setTbName(map.get("filename"));
				}
				if (daoImpl.avertRedund(tb.getIdmniMail()) == null) {
					importSuccessNum++;
					list.add(tb);
				} else {
					importDuplicateNum++;
					afterImportMap.put(new Long(importDuplicateNum).toString(),
							tb.getIdmniMail());
				}
				if (list.size() == 3000) {
					daoImpl.batchSave(list);
					list.clear();
				}
			}// end if

		}
		daoImpl.batchSave(list);
		importSuccess = true;
		afterImportMap.put("importSuccess",
				new Boolean(importSuccess).toString());
		afterImportMap.put("importSuccessNum",
				new Long(importSuccessNum).toString());
		afterImportMap.put("importDuplicateNum",
				new Long(importDuplicateNum).toString());
		return afterImportMap;

	}

	@Override
	public boolean delete(Map<String, String> map) {
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
		if (0 == getPageTotal(map)) {
			return true;
		} else {
			daoImpl.delete(search_Delete(map));
			return false;
		}
	}

	@Override
	public List<TbIndemnify> avertRedundList(String original) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TbIndemnify> getAllIndemnify(Map<String, String> map) {
		// TODO Auto-generated method stub
		return daoImpl.getAllIndemnify(searchIndemnify.search(map));
	}

}
