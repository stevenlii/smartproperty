package com.zyd.common;

import java.io.BufferedInputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

/**
 * 导出公用类
 * 
 * 
 */
public class ExportUtils {

	/**
	 * 统计导出TXT文件
	 * 
	 * @param list
	 */
	public static void ExportTXT(List<?> list, HttpServletRequest request) {
		StringBuffer buffer = new StringBuffer();
		File file = new File(request.getSession().getServletContext()
				.getRealPath("\\")
				+ "backfile\\" + request.getSession().getId() + "export.txt");
		for (Iterator<?> iterator = list.iterator(); iterator.hasNext();) {
			Object[] objects = (Object[]) iterator.next();
			for (int i = 0; i < objects.length; i++) {
				buffer.append(objects[i] + "|");
			}
			buffer.append("\r\n");
		}
		try {
			bufferedWriteFile(buffer.toString(), file);
		} catch (IOException e) {
			// logger.info("写入下载文件IO异常");
			e.printStackTrace();
		}
	}

	/**
	 * 统计导出EXCEL文件
	 * 
	 * @param list
	 * @param request
	 */
	public static void ExportEXCEL(List<?> list, HttpServletRequest request) {
		File path = new File(request.getSession().getServletContext()
				.getRealPath("\\")
				+ "backfile\\"
				+ request.getSession().getId()
				+ "exportEXCEL.xls");
		HSSFWorkbook workbook = new HSSFWorkbook();// 创建个空白的workbook
		HSSFSheet sheet = workbook.createSheet();// 创建个空白的sheet
		int rownum = 0;
		for (Iterator<?> iterator = list.iterator(); iterator.hasNext();) {
			Object[] objects = (Object[]) iterator.next();
			if (rownum == 60000) {
				sheet = workbook.createSheet();// 创建个空白的sheet
				rownum = 0;
			}
			HSSFRow row = sheet.createRow(rownum++);// 创建行
			for (int i = 0; i < objects.length; i++) {
				HSSFCell cell = row.createCell(i);// 创建上面行的第一个单元格
				if (objects[i] != null) {
					cell.setCellValue(objects[i].toString());
				} else {
					cell.setCellValue("");
				}
			}
		}
		FileOutputStream out = null;
		try {
			out = new FileOutputStream(path.getAbsolutePath());
			workbook.write(out);// 调用HSSFWorkbook类的write方法写入到输出流
		} catch (IOException e) {
			System.out.println(e.toString());
		} finally {
			try {
				out.close();
			} catch (IOException e) {
				System.out.println(e.toString());
			}
		}
	}

	/**
	 * 以字符流写入
	 * 
	 * @param str
	 *            写入字符串
	 * @throws IOException
	 */
	public static void bufferedWriteFile(String str, File file)
			throws IOException {
		FileWriter fw = null;
		BufferedWriter bw = null;
		fw = new FileWriter(file);
		bw = new BufferedWriter(fw);
		bw.write(str);
		bw.flush();
		bw.close();

	}

	/**
	 * 下载文件
	 * 
	 * @param response
	 * @param file
	 * @param filename
	 * @throws IOException
	 */
	public static void downFile(HttpServletResponse response, File file,
			String filename) throws IOException {
		BufferedInputStream br = new BufferedInputStream(new FileInputStream(
				file));
		byte[] buf = new byte[1024];
		int len = 0;
		response.reset();
		response.setContentType("text/plain");
		response.setHeader("Content-Disposition", "attachment; filename="
				+ filename + file.getName());
		OutputStream out = response.getOutputStream();
		while ((len = br.read(buf)) > 0)
			out.write(buf, 0, len);
		br.close();
		out.close();
	}

}
