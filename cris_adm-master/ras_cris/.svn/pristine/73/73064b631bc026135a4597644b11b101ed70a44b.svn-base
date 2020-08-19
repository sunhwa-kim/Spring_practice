package kr.go.cris.commons.utils;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;

/**
 * <pre>
 *  엑셀파일을 생성하여 결과를 저장한다. 
 * 
 * </pre>
 * @FileName : ExcelDownUtil.java
 * @package  : kr.go.cris.commons.utils
 * @author   : wonki0138
 * @date     : 2018. 4. 3.
 * 
 */
public class ExcelDownUtil {


	/**
	 * <pre>
	 *  Query 질의 결과를 엑셀파일로 저장함. 
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 4. 3. 
	 * @param response
	 * @param dataList
	 * @param colinfoList
	 * @param filename
	 * @param title
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	@SuppressWarnings("unchecked")
	public boolean excelWrite(HttpServletResponse response, List dataList, ArrayList colinfoList, String filename, String title) throws IOException, SQLException , NullPointerException
	{
 	
 		//String colnames, String colinfos,
 		
 		//String[] col_names = colnames.toLowerCase().split(";");
 		//String[] col_info = colinfos.split(";");
 		
 		String tm = getStringFromDate(new Date(), "yyyy년 MM월 dd일 - HH시 mm분");
 		
 		HSSFWorkbook wb = new HSSFWorkbook();  
		// 「sheet1」라는 이름의 워크시트를 표시하는 오브젝트 생성 
		HSSFSheet sheet1 = wb.createSheet("sheet1");  
				
		// 행의 작성  
		/************************엑셀 스타일 지정****************************/
		HSSFCellStyle style_title = wb.createCellStyle();
		HSSFCellStyle style_data = wb.createCellStyle();
		HSSFCellStyle style_header = wb.createCellStyle();
		
		HSSFFont font = wb.createFont();
		HSSFFont font_title = wb.createFont();
		
		font_title.setFontHeightInPoints((short)12);
		font_title.setBoldweight((short)700);
		 
		font.setBoldweight((short)700);
		
		style_title.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style_title.setFont(font_title);		
		style_title.setFillForegroundColor(HSSFColor.LIGHT_ORANGE.index);
		style_title.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style_title.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		
		
		style_data.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style_data.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style_data.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style_data.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style_data.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
						
		style_header.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style_header.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style_header.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style_header.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style_header.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
		style_header.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style_header.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		
		style_header.setFillBackgroundColor(HSSFColor.AQUA.index);
		style_header.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style_header.setFont(font);		
		/************************엑셀 스타일 지정****************************/
		
		
		
		
		/************************엑셀 정보 출력****************************/
		HSSFRow row_title = sheet1.createRow(2);
		row_title.setHeight((short)600);
		HSSFCell cell_title= row_title.createCell(0);
		cell_title.setCellValue(title);
		cell_title.setCellStyle(style_title);
		sheet1.addMergedRegion(new CellRangeAddress(2,2,0,(colinfoList.size() - 1)));
		
		
		HSSFRow row_date = sheet1.createRow(3);
		HSSFCell cell_date= row_date.createCell(0);
		
		cell_date = row_date.createCell(0);
		cell_date.setCellValue("출력일자");
		cell_date = row_date.createCell(1);
		cell_date.setCellValue(tm);
		/************************엑셀 정보 출력****************************/
		
		
		HSSFRow row0 = sheet1.createRow(5);
		HSSFCell cell = null;
		
		for(int k=0; k < colinfoList.size(); k++)
		{
			HashMap colmap = (HashMap)colinfoList.get(k);
			row0.setHeight((short)500);
			cell = row0.createCell(k);
			sheet1.setColumnWidth(k, (short)4000);
			cell.setCellValue((String)colmap.get("COL_INFO"));
			cell.setCellStyle(style_header);
		}			
		
		for(int i=0; i < dataList.size(); i++)
		{
			row0 = sheet1.createRow(i + 6);
			row0.setHeight((short)400);
			Map article = (HashMap)dataList.get(i);
			
			for(int j=0; j < colinfoList.size(); j++)
			{
				HashMap colmap = (HashMap)colinfoList.get(j);
				cell =  row0.createCell(j);
				Object obj = article.get(((String)colmap.get("COL_NAME")).toUpperCase());
				if(obj == null){
					cell.setCellValue("");
				}else {
					cell.setCellValue(obj.toString());
				}
				cell.setCellStyle(style_data);
			}				
			
		}

		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-disposition", "attachment;filename="+java.net.URLEncoder.encode(filename + "_" + tm + ".xls","UTF-8"));
		response.addHeader("Content-description", "EventAttendees");
		response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
		ServletOutputStream stream = response.getOutputStream();
		wb.write(stream);
		stream.close();
		
		return true;
	}
	

	
	/**
	 * @method : ExcelStatWrite
	 * @DoWhat : 검색통계 Query 질의 결과를 엑셀파일로 저장함. 
	 * 			2011.08.03 ByunghanHan
	 * @param response : 응답 개체
	 * @param dataList : 질의 결과
	 * @param colnames : 저장할 컬럼 목록
	 * @param colinfos : 저장할 컬럼 정의
	 * @param filename : 저장할 파일명
	 * @return : boolean
	 */
	@SuppressWarnings("unchecked")
	public boolean excelStatWrite(HttpServletResponse response, List dataList, ArrayList colinfoList, String filename, String title) throws IOException, SQLException , NullPointerException
	{
		try {
			
		
	 		//String colnames, String colinfos,
	 		
	 		//String[] col_names = colnames.toLowerCase().split(";");
	 		//String[] col_info = colinfos.split(";");
	 		
	 		String tm = getStringFromDate(new Date(), "yyyy년 MM월 dd일 - HH시 mm분");
	 		
	 		HSSFWorkbook wb = new HSSFWorkbook();  
			// 「sheet1」라는 이름의 워크시트를 표시하는 오브젝트 생성 
			HSSFSheet sheet1 = wb.createSheet("sheet1");  
			 		
			// 행의 작성  
			/************************엑셀 스타일 지정****************************/
			HSSFCellStyle style_title = wb.createCellStyle();
			HSSFCellStyle style_data = wb.createCellStyle();
			HSSFCellStyle style_header = wb.createCellStyle();
			
			HSSFFont font = wb.createFont();
			HSSFFont font_title = wb.createFont();
			
			font_title.setFontHeightInPoints((short)12);
			font_title.setBoldweight((short)700);
			 
			font.setBoldweight((short)700);
			
			style_title.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			style_title.setFont(font_title);		
			style_title.setFillForegroundColor(HSSFColor.LIGHT_ORANGE.index);
			style_title.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
			style_title.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			
			
			style_data.setBorderRight(HSSFCellStyle.BORDER_THIN);
			style_data.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			style_data.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style_data.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style_data.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
							
			style_header.setBorderRight(HSSFCellStyle.BORDER_THIN);
			style_header.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			style_header.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style_header.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style_header.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
			style_header.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
			style_header.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			
			style_header.setFillBackgroundColor(HSSFColor.AQUA.index);
			style_header.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			style_header.setFont(font);		
			/************************엑셀 스타일 지정****************************/
			
			
			
			
			/************************엑셀 정보 출력****************************/
			HSSFRow row_title = sheet1.createRow(2);
			row_title.setHeight((short)600);
			HSSFCell cell_title= row_title.createCell(0);
			cell_title.setCellValue(title);
			cell_title.setCellStyle(style_title);
			sheet1.addMergedRegion(new CellRangeAddress(2,2,0,(colinfoList.size() *3 )));
			
			
			HSSFRow row_date = sheet1.createRow(3);
			HSSFCell cell_date= row_date.createCell(0);
			
			cell_date = row_date.createCell(0);
			cell_date.setCellValue("출력일자");
			cell_date = row_date.createCell(1);
			cell_date.setCellValue(tm);
			
			
			
			//row 5 , 6 생성
			HSSFRow row0 = sheet1.createRow(5); 
			HSSFRow rowCol = sheet1.createRow(6);
			HSSFCell cell = null;	
			
			//기관 로우 병합 
			cell = row0.createCell(0);
			sheet1.setColumnWidth(0, (short)4000);
			rowCol.createCell(0);
			cell.setCellValue("기관");
			cell.setCellStyle(style_header);
			sheet1.addMergedRegion(new CellRangeAddress(5,6,0,0));	
			
		
			int num = 1;
			int val = 0;
			
			for(int i=1; i <= colinfoList.size()*3 ; i++)
			{		
				// 메뉴 명 리스트 만들기
				row0.setHeight((short)500);
				cell = row0.createCell(i);
				sheet1.setColumnWidth(i, (short)4000);
				if(i%3==1){
					HashMap colmap = (HashMap)colinfoList.get(val);
					cell.setCellValue((String)colmap.get("COL_INFO"));
					val++;
				}
				cell.setCellStyle(style_header);
				if(i <= colinfoList.size()){  //메뉴 사이즈 까지만 만들자~ 
					sheet1.addMergedRegion(new CellRangeAddress(5,5,num,2+num));			
					num+=3;		
				}
				
				// 목록 , 상세 , 총뷰 만들기
				cell = rowCol.createCell(i);			
				if(i%3==1){
					cell.setCellValue("목록");			
				}else if(i%3 == 0){
					cell.setCellValue("총뷰");	
				}else{
					cell.setCellValue("상세");
				}
				cell.setCellStyle(style_header);
			}				
	
			// 데이터 row 생성부분 
			for(int i=0; i < dataList.size(); i++)
			{
				row0 = sheet1.createRow(i + 7);
				row0.setHeight((short)400);
				Map article = (HashMap)dataList.get(i);
				
				//기관명을 나열한다.
				for(int j=0; j < colinfoList.size(); j++){
					cell =  row0.createCell(0);
					cell.setCellValue(article.get("INST_KOR_NM").toString().equals("nimdasys") ? "시스템 관리자" : article.get("INST_KOR_NM").toString());	
					cell.setCellStyle(style_data);
				}
				
				// 메뉴별 목록, 상세 , 총뷰 데이터를 나열한다.
				int cnt = 0;
				for(int j=1; j <= colinfoList.size()*3; j++)
				{
					//HashMap colmap = (HashMap)colinfoList.get(j);
				
					cell =  row0.createCell(j);
					if (colinfoList.size() > cnt) {
						 if(j%3==1 ){ //목록
							cell.setCellValue(Integer.parseInt(article.get("LIST_CNT_"+cnt).toString()));
						}else if(j%3 == 0 ){//총뷰
							cell.setCellValue( Integer.parseInt((String) article.get("LIST_CNT_"+cnt).toString()) + Integer.parseInt((String) article.get("VIEW_CNT_"+cnt).toString()));
							cnt++; // 총뷰 까지 나오면 cnt를 ++ 한다. 메뉴별로 동적으로 할당되어 있기때문에
						}else{//상세
							cell.setCellValue(Integer.parseInt(article.get("VIEW_CNT_"+cnt).toString()));
						}
						
					}
					
					cell.setCellStyle(style_data);
				}				
			
			}
	
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-disposition", "attachment;filename="+java.net.URLEncoder.encode(filename + "_" + tm + ".xls","UTF-8"));
			response.addHeader("Content-description", "EventAttendees");
			response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
			
			ServletOutputStream stream = response.getOutputStream();
			
			wb.write(stream);
		
		
			stream.close();
		} catch (IOException e) {
			Logger.getLogger(ExcelDownUtil.class).debug("err excelStatWrite");
		}
		return true;
	}
	
	

	/**
	 * <pre>
	 * 질의 결과를 엑셀파일로 저장함. 
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 4. 3. 
	 * @param response
	 * @param colinfoReportList
	 * @param dataList
	 * @param colinfoList
	 * @param dataList3
	 * @param colinfoList3
	 * @param filename
	 * @param title
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	@SuppressWarnings("unchecked")
	public boolean excelReportWrite(HttpServletResponse response , ArrayList colinfoReportList ,  List dataList, ArrayList colinfoList,String filename, String title) throws IOException , SQLException , NullPointerException 
	{
 	
 		//String colnames, String colinfos,
 		
 		//String[] col_names = colnames.toLowerCase().split(";");
 		//String[] col_info = colinfos.split(";");
 		
 		String tm = getStringFromDate(new Date(), "yyyy년MM월dd일-HH시mm분");
 		
 		HSSFWorkbook wb = new HSSFWorkbook();  
		// 「sheet2」라는 이름의 워크시트를 표시하는 오브젝트 생성 
		HSSFSheet sheet1 = wb.createSheet("보고서 정보 양식");  
		HSSFSheet sheet2 = wb.createSheet("주제 코드 정보");  
		
		// 행의 작성  
		/************************엑셀 스타일 지정****************************/
		HSSFCellStyle style_title = wb.createCellStyle();
		HSSFCellStyle style_data = wb.createCellStyle();
		HSSFCellStyle style_header = wb.createCellStyle();
		
		HSSFFont font = wb.createFont();
		HSSFFont font_title = wb.createFont();
		
		font_title.setFontHeightInPoints((short)12);
		font_title.setBoldweight((short)700);
		 
		font.setBoldweight((short)700);
		
		style_title.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style_title.setFont(font_title);		
		style_title.setFillForegroundColor(HSSFColor.LIGHT_ORANGE.index);
		style_title.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style_title.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		
		
		style_data.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style_data.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style_data.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style_data.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style_data.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
						
		style_header.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style_header.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style_header.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style_header.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style_header.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
		style_header.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style_header.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		
		style_header.setFillBackgroundColor(HSSFColor.AQUA.index);
		style_header.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style_header.setFont(font);		
		/************************엑셀 스타일 지정****************************/
		
		
		
		
		/************************Sheet1 엑셀 정보 출력****************************/
		
		HSSFRow row_report = sheet1.createRow(0);
		HSSFCell cell_report = null;
		
		for(int k=0; k < colinfoReportList.size(); k++)
		{
			HashMap colmap_report = (HashMap)colinfoReportList.get(k);
			row_report.setHeight((short)500);
			cell_report = row_report.createCell(k);
			if( k == 1  ||  k == 2  ){
				sheet1.setColumnWidth(k, (short)14000);
			}else if( k == 4 ){
				sheet1.setColumnWidth(k, (short)10000);
			}else{
				sheet1.setColumnWidth(k, (short)6000);
			}
			
			cell_report.setCellValue((String)colmap_report.get("COL_INFO_REPORT"));
			cell_report.setCellStyle(style_header);
		}			
		
		
		/************************Sheet2 엑셀 정보 출력 str ****************************/

		HSSFRow row0 = sheet2.createRow(0);
		HSSFCell cell = null;
		
		for(int k=0; k < colinfoList.size(); k++)
		{
			HashMap colmap = (HashMap)colinfoList.get(k);
			row0.setHeight((short)500);
			cell = row0.createCell(k);
			sheet2.setColumnWidth(k, (short)8000);
			cell.setCellValue((String)colmap.get("COL_INFO"));
			cell.setCellStyle(style_header);
		}			
		
		for(int i=0; i < dataList.size(); i++)
		{
			row0 = sheet2.createRow(i + 1);
			row0.setHeight((short)400);
			Map article = (HashMap)dataList.get(i);
			
			for(int j=0; j < colinfoList.size(); j++)
			{
				HashMap colmap = (HashMap)colinfoList.get(j);
				cell =  row0.createCell(j);
				Object obj = article.get(((String)colmap.get("COL_NAME")).toUpperCase());
				if(obj == null){
					cell.setCellValue("");
				}else{ 
					cell.setCellValue(obj.toString());
				}
				cell.setCellStyle(style_data);
			}				
			
		}
		/************************Sheet2 엑셀 정보 출력 end ****************************/
		
	
		
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-disposition", "attachment;filename="+java.net.URLEncoder.encode(filename + "_" + tm + ".xls","UTF-8"));
		response.addHeader("Content-description", "EventAttendees");
		response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
		ServletOutputStream stream = response.getOutputStream();
		wb.write(stream);
		stream.close();
		
		return true;
	}
	
	

	/**
	 * <pre>
	 * 질의 결과를 엑셀파일로 저장함. 
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 4. 3. 
	 * @param response
	 * @param colinfoReportList
	 * @param dataList
	 * @param colinfoList
	 * @param dataList3
	 * @param colinfoList3
	 * @param filename
	 * @param title
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	@SuppressWarnings("unchecked")
	public void excelEdsWrite(HttpServletResponse response , ArrayList colinfoList ,  List dataList ,String filename, String title) throws IOException , SQLException , NullPointerException 
	{
 	
 		//String colnames, String colinfos,
 		
 		//String[] col_names = colnames.toLowerCase().split(";");
 		//String[] col_info = colinfos.split(";");
 		
 		String tm = getStringFromDate(new Date(), "yyyy년MM월dd일_HH시mm분");
 		
 		HSSFWorkbook wb = new HSSFWorkbook();  
		// 「sheet2」라는 이름의 워크시트를 표시하는 오브젝트 생성 
		HSSFSheet sheet1 = wb.createSheet("전자자원");  
		//HSSFSheet sheet2 = wb.createSheet("주제 코드 정보");  
		
		// 행의 작성  
		/************************엑셀 스타일 지정****************************/
		HSSFCellStyle style_title = wb.createCellStyle();
		HSSFCellStyle style_data = wb.createCellStyle();
		HSSFCellStyle style_header = wb.createCellStyle();
		
		HSSFFont font = wb.createFont();
		HSSFFont font_title = wb.createFont();
		
		font_title.setFontHeightInPoints((short)12);
		font_title.setBoldweight((short)700);
		 
		font.setBoldweight((short)700);
		
		style_title.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style_title.setFont(font_title);		
		style_title.setFillForegroundColor(HSSFColor.LIGHT_ORANGE.index);
		style_title.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style_title.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		
		
		style_data.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style_data.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style_data.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style_data.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style_data.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
						
		style_header.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style_header.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style_header.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style_header.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style_header.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
		style_header.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style_header.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		
		style_header.setFillBackgroundColor(HSSFColor.AQUA.index);
		style_header.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style_header.setFont(font);		
		/************************엑셀 스타일 지정****************************/
		
		
		
		
		/************************Sheet1 엑셀 정보 출력****************************/
		
		HSSFRow row = sheet1.createRow(0);
		HSSFCell cell = null;
		
		for(int k=0; k < colinfoList.size(); k++)
		{
			HashMap colmap= (HashMap)colinfoList.get(k);
			row.setHeight((short)500);
			cell = row.createCell(k);
			
			if( k == 3  ||  k == 5  ){ 
				sheet1.setColumnWidth(k, (short)6000);
			}else if( k == 10 ){  
				sheet1.setColumnWidth(k, (short)6000);
			}else if( k == 13){ 
				sheet1.setColumnWidth(k, (short)6000);
			}else{
				sheet1.setColumnWidth(k, (short)6000);
			}
			
			cell.setCellValue((String)colmap.get("COL_INFO"));
			cell.setCellStyle(style_header);
		}			
		for(int i=0; i < dataList.size(); i++)
		{
			row = sheet1.createRow(i + 1);
			row.setHeight((short)400);
			Map article = (HashMap)dataList.get(i);
			
			for(int j=0; j < colinfoList.size(); j++)
			{

				HashMap colmap = (HashMap)colinfoList.get(j);
				cell =  row.createCell(j);
				Object obj = article.get(((String)colmap.get("COL_NAME")).toUpperCase());
				if(obj == null){
					cell.setCellValue("");
				}else{ 
					cell.setCellValue(obj.toString());
				}
				cell.setCellStyle(style_data);
			}				
			
		}
			
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-disposition", "attachment;filename="+java.net.URLEncoder.encode(filename + "_" + tm + ".xls","UTF-8"));
		response.addHeader("Content-description", "EventAttendees");
		response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
		ServletOutputStream stream = response.getOutputStream();
		wb.write(stream);

		stream.close();

	}
	
	
	/**
	 * <pre>
	 * 질의 결과를 엑셀파일로 저장함. 
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 4. 3. 
	 * @param response
	 * @param dataList
	 * @param colinfoList
	 * @param filename
	 * @param title
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	@SuppressWarnings("unchecked")
	public boolean excelManlogWrite(HttpServletResponse response, List dataList, ArrayList colinfoList, String filename, String title) throws IOException, SQLException , NullPointerException
	{
 	
//String colnames, String colinfos,
 		
 		//String[] col_names = colnames.toLowerCase().split(";");
 		//String[] col_info = colinfos.split(";");
 		
 		String tm = getStringFromDate(new Date(), "yyyy년MM월dd일-HH시mm분");
 		
 		HSSFWorkbook wb = new HSSFWorkbook();  
		// 「sheet1」라는 이름의 워크시트를 표시하는 오브젝트 생성 
		HSSFSheet sheet1 = wb.createSheet("sheet1");  
		 		
		// 행의 작성  
		/************************엑셀 스타일 지정****************************/
		HSSFCellStyle style_title = wb.createCellStyle();
		HSSFCellStyle style_data = wb.createCellStyle();
		HSSFCellStyle style_header = wb.createCellStyle();
		
		
		HSSFFont font = wb.createFont();
		HSSFFont font_title = wb.createFont();
		
		font_title.setFontHeightInPoints((short)12);
		font_title.setBoldweight((short)700);
		 
		font.setBoldweight((short)700);
		
		style_title.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style_title.setFont(font_title);			
		style_title.setFillForegroundColor(HSSFColor.LIGHT_ORANGE.index);
		style_title.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style_title.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		
		
		style_data.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style_data.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style_data.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style_data.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style_data.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
						
		style_header.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style_header.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style_header.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style_header.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style_header.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
		style_header.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style_header.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		
		style_header.setFillBackgroundColor(HSSFColor.AQUA.index);
		style_header.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style_header.setFont(font);		
		/************************엑셀 스타일 지정****************************/
		
		
		
		
		/************************엑셀 정보 출력****************************/
		HSSFRow row_title = sheet1.createRow(2);
		row_title.setHeight((short)600);
		HSSFCell cell_title= row_title.createCell(0);
		cell_title.setCellValue(title);
		cell_title.setCellStyle(style_title);
		sheet1.addMergedRegion(new CellRangeAddress(2,2,0,(colinfoList.size() - 1)));
		
		
		HSSFRow row_date = sheet1.createRow(3);
		HSSFCell cell_date= row_date.createCell(0);
		
		cell_date = row_date.createCell(0);
		cell_date.setCellValue("출력일자");
		cell_date = row_date.createCell(1);
		cell_date.setCellValue(tm);
		/************************엑셀 정보 출력****************************/
		
		
		HSSFRow row0 = sheet1.createRow(5);
		HSSFCell cell = null;
		
		for(int k=0; k < colinfoList.size(); k++)
		{
			HashMap colmap = (HashMap)colinfoList.get(k);
			row0.setHeight((short)500);
			cell = row0.createCell(k);
			sheet1.setColumnWidth(k, (short)4000);
			cell.setCellValue((String)colmap.get("COL_INFO"));
			cell.setCellStyle(style_header);
		
		}			
		
		for(int i=0; i < dataList.size(); i++)
		{
			row0 = sheet1.createRow(i + 6);
			row0.setHeight((short)400);
			Map article = (HashMap)dataList.get(i);
		
			for(int j=0; j < colinfoList.size(); j++)
			{
				
				HashMap colmap = (HashMap)colinfoList.get(j);
				cell =  row0.createCell(j);
				Object obj  = article.get(((String)colmap.get("COL_NAME")).toUpperCase());
				if(obj == null){
					cell.setCellValue("");
				}else{ 				
					if( colmap.get("COL_NAME").equals("INST_KOR_NM") || colmap.get("COL_NAME").equals("RN")){
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue(obj.toString());
					}else{
						cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
						cell.setCellValue(Integer.parseInt(String.valueOf(obj)));	
					}
					
				}
		
				cell.setCellStyle(style_data);
			}				
			
		}

		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-disposition", "attachment;filename="+java.net.URLEncoder.encode(filename + "_" + tm + ".xls","UTF-8"));
		response.addHeader("Content-description", "EventAttendees");
		response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
		ServletOutputStream stream = response.getOutputStream();
		wb.write(stream);
		stream.close();
		
		return true;
	}
	
	
	
	/**
	 *  Date 를 String으로 변경...
	 *  @param dt : Date 
	 *  @param format : ex) "yyyy-MM-dd HH:mm:SS"
	 */
	public String getStringFromDate(Date dt, String format)
	{
		SimpleDateFormat smp = new SimpleDateFormat(format);
		return smp.format(dt);
	}
	
	
}
