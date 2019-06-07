package com.zyd.common;

import java.math.BigDecimal;
import java.util.Date;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.DateUtil;

/**
 * 使Excel表数据类型兼容的工具类 Excel表里面的数字数据，用户可能会存储为String类型，也可能会存储为Numeric类型，使用工具类使数据兼容
 * 
 * @author zhiqiang
 * 
 */
public class CellParseTools {

	/**
	 * 把单元格里面Numeric与String可能会变化的值统一成String返回
	 * 如果原数据为Double，此数据会先把Double转换为Integer，然后再转换为String
	 * 
	 * @param cell
	 *            HSSFCell类型，要统一的值
	 * @return Java.lang.String类型
	 */
	public static String parseString(HSSFCell cell) {
		if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {// 数字类型0

			Double double1 = new Double(cell.getNumericCellValue());
			Integer integer = new Integer(double1.intValue());
			return integer.toString().trim();

		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {// String
																		// 类型1
			return cell.getStringCellValue().trim();
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_FORMULA) {// Formula
																		// Cell
																		// type
																		// (2)
			return new Integer((int) cell.getNumericCellValue()).toString().trim();
		} else if (cell == null
				|| cell.getCellType() == HSSFCell.CELL_TYPE_BLANK) {// Blank
																	// Cell type
																	// (3)即表中的这个单元格里面没有数据
			return "";
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_BOOLEAN) {// Boolean
																		// Cell
																		// type
																		// (4)
			Boolean boolean1 = new Boolean(cell.getBooleanCellValue());
			return boolean1.toString().trim();
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_ERROR) {// Error
																	// Cell type
																	// (5)
			Byte byte1 = new Byte(cell.getErrorCellValue());
			return byte1.toString().trim();
		}
		return null;
	}

	/**
	 * 把单元格表里面Numeric与String可能会变化的值统一成Double返回
	 * 
	 * @param cell
	 *            HSSFCell类型，要统一的值
	 * @return Java.lang.Double类型
	 */
	public static Double parseNumeric(HSSFCell cell) {
		if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {// 数字类型0

			return cell.getNumericCellValue();
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {// String
																		// 类型1
			Double double1 = new Double(cell.getStringCellValue());
			return double1;
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_FORMULA) {// Formula
																		// Cell
																		// type
																		// (2)
			Double double1 = new Double(cell.getNumericCellValue());
			return double1;
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_BLANK
				|| cell == null) {// Blank Cell type (3)即表中的这个单元格里面没有数据
			Double double1 = new Double(0);
			return double1;
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_BOOLEAN) {// Boolean
																		// Cell
																		// type
																		// (4)
			// Boolean不应该也不能被转换成Integer或者Double类型，应该返回0（false）,1(true)
			if (cell.getBooleanCellValue()) {
				return new Double(1);
			} else {
				return new Double(0);
			}
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_ERROR) {// Error
																	// Cell type
																	// (5)
			Double double1 = new Double(
					new Byte(cell.getErrorCellValue()).toString());
			return double1;
		}
		return null;
	}

	// BigDecimal
	public static BigDecimal parseBigDecimal(HSSFCell cell) {
		if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {// 数字类型0

			return new BigDecimal(cell.getNumericCellValue());
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {// String
																		// 类型1
			Double double1 = new Double(cell.getStringCellValue());
			return new BigDecimal(double1);
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_FORMULA) {// Formula
																		// Cell
																		// type
																		// (2)
			Double double1 = new Double(cell.getNumericCellValue());
			return new BigDecimal(double1);
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_BLANK
				|| cell == null) {// Blank Cell type (3)即表中的这个单元格里面没有数据
			Double double1 = new Double(0);
			return new BigDecimal(double1);
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_BOOLEAN) {// Boolean
																		// Cell
																		// type
																		// (4)
			// Boolean不应该也不能被转换成Integer或者Double类型，应该返回0（false）,1(true)
			if (cell.getBooleanCellValue()) {
				return new BigDecimal(1);
			} else {
				return new BigDecimal(0);
			}
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_ERROR) {// Error
																	// Cell type
																	// (5)
			Double double1 = new Double(
					new Byte(cell.getErrorCellValue()).toString());
			return new BigDecimal(double1);
		}
		return null;
	}

	/**
	 * 把单元格表里面Numeric与String可能会变化的值统一成Double返回
	 * 
	 * @param cell
	 *            HSSFCell类型，要统一的值
	 * @return Java.lang.Double类型
	 */
	public static Integer parseNumericInteger(HSSFCell cell) {
		if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {// 数字类型0

			return (int) cell.getNumericCellValue();
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {// String
																		// 类型1
			return Integer.parseInt(cell.getStringCellValue());
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_FORMULA) {// Formula
																		// Cell
																		// type
																		// (2)

			return (int) cell.getNumericCellValue();// Excel表里的公式，请用POI:cell.getnumeric方法即可，不用此封装方法
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_BLANK
				|| cell == null) {// Blank Cell type (3)即表中的这个单元格里面没有数据
			Integer integer = new Integer(0);
			return integer;
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_BOOLEAN) {// Boolean
																		// Cell
																		// type
																		// (4)
			// Boolean不应该也不能被转换成Integer或者Double类型，应该返回0（false）,1(true)
			if (cell.getBooleanCellValue()) {
				return new Integer(1);
			} else {
				return new Integer(0);
			}
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_ERROR) {// Error
																	// Cell type
																	// (5)

			return (int) (cell.getErrorCellValue());
		}
		return null;
	}

	/**
	 * 把读取的数据（Numeric或者String类型)转换为Date类型
	 * 
	 * @param numericCell
	 * @return
	 */
	public static Date parseToDate(HSSFCell cell) {
		if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
			if (DateUtil.isCellDateFormatted(cell)) {
				return cell.getDateCellValue();
			}
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
			return DateTools.stringToDate(cell.getStringCellValue());
		}
		return null;
	}
	/**
	 * 把读取的数据（Numeric或者String类型)转换为Datetime类型
	 * 
	 * @param numericCell
	 * @return
	 */
	public static Date parseToDatetime(HSSFCell cell) {
		if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
			if (DateUtil.isCellDateFormatted(cell)) {
				return cell.getDateCellValue();
			}
		} else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
			return DateTools.stringToDatetime(cell.getStringCellValue());
		}
		return null;
	}

}