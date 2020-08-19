package kr.go.cris;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 * <pre>
 * ncmiklib_PTL 
 *    |_ XlsPaser.java
 * 
 * </pre>
 * @date : 2019. 5. 20. 오전 10:19:56
 * @version : 
 * @author : Administrator
 */
public class XlsPaser {

	private Logger log = Logger.getLogger(this.getClass());

	
	@SuppressWarnings("unchecked")
	public boolean excelWrite(List<Map> list) throws IOException, SQLException , NullPointerException
	{
 	
 		//String colnames, String colinfos,
 		
 		//String[] col_names = colnames.toLowerCase().split(";");
 		//String[] col_info = colinfos.split(";");
 		
 		String tm = "등록 데이터";
 		
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
		cell_title.setCellValue("임상연구등록데이터");
		cell_title.setCellStyle(style_title);
		
		
		HSSFRow row_date = sheet1.createRow(3);
		HSSFCell cell_date= row_date.createCell(0);
		
		cell_date = row_date.createCell(0);
		cell_date.setCellValue("출력일자");
		cell_date = row_date.createCell(1);
		cell_date.setCellValue(tm);
		/************************엑셀 정보 출력****************************/
		
		
		HSSFRow row0 = sheet1.createRow(5);
		HSSFCell cell = null;	
		
		for(int i=0; i < list.size(); i++)
		{
			row0 = sheet1.createRow(i + 6);
			row0.setHeight((short)400);
			Map article = (HashMap)list.get(i);
			
			for(int j=0; j < 19; j++)
			{
				cell =  row0.createCell(j);
				Object obj = article.get(j);
				if(obj == null){
					cell.setCellValue("");
				}else {
					cell.setCellValue(obj.toString());
				}
				cell.setCellStyle(style_data);
			}				
			
		}

		
		return true;
	}
	
	public static void main(String[] args) throws Exception {
		reportExcelUpload2();
		//getXmlData();
	}
	 
	public static void reportExcelUpload() throws IOException  , NullPointerException {
		
		String msg ="";     
		HSSFWorkbook workbook = null;
		
		
		File file = new File("C:\\Users\\Administrator\\Desktop\\네이버연동\\cpNcmik_190522.xls");
		FileInputStream fs = new FileInputStream(file);
		List<Map> list = new ArrayList<Map>();
		Map<Object, Object> map = null;
		try {
					
			workbook = new HSSFWorkbook(fs);
		
			// 탐색에 사용할 Sheet, Row, Cell 객체
			HSSFSheet curSheet;
			HSSFRow curRow;
			HSSFCell curCell;
			
			// Sheet 탐색
			// Sheet는 첫번째 시트만 탐색할거다.  0
			String before = "";
			String after = "";
			for (int sheetIndex = 0; sheetIndex < 1; sheetIndex++) {				
				// 현재 sheet 반환
				curSheet = workbook.getSheetAt(sheetIndex);
				// row 탐색 
				for (int rowIndex = 0; rowIndex <= curSheet.getLastRowNum(); rowIndex++) {
					// row 0은 헤더정보이기 때문에 무시
					if (rowIndex != 0) {
						curRow = curSheet.getRow(rowIndex);
						String value;
						// row의 첫번째 cell값이 비어있지 않는 경우만 cell탐색
						if (curRow != null) {
							//if (!"".equals(curRow.getCell(0))) {
								// cell 탐색 for문
								for (int cellIndex = 0; cellIndex <= curRow.getPhysicalNumberOfCells(); cellIndex++) {
									curCell = curRow.getCell(cellIndex);
										value = "";
										if(curCell != null){ // 해당 row의 cell 이 비어있지 않으면
											// cell 스타일이 다르더라도 String으로 반환 받음
											switch (curCell.getCellType()) {
												case HSSFCell.CELL_TYPE_FORMULA:
													value = curCell.getCellFormula();
												break;
												case HSSFCell.CELL_TYPE_NUMERIC:  
													Integer i = (int)curCell.getNumericCellValue();
													value = i.toString();																																						
												break;
												case HSSFCell.CELL_TYPE_STRING:
													value = curCell.getStringCellValue() + "";
												break;
												case HSSFCell.CELL_TYPE_BLANK:
													value = curCell.getBooleanCellValue() + "";
												break;
												case HSSFCell.CELL_TYPE_ERROR:
													value = curCell.getErrorCellValue() + "";
												break;
												default:
													value = new String();
												break;
											} // end switch
										}else{
											value ="";
										}
										value = value.replaceAll("\t", "     ");
										
										if(cellIndex == 0){
											after = value;
											if(!StringUtils.equals(before, after)){
												map = new HashMap<Object, Object>();
											}
										}
										if(StringUtils.equals(before, after)){
											if(map.get(cellIndex) != null){
												if(map.get(cellIndex).toString().indexOf(value) == -1){
													
													String value2 = map.get(cellIndex)+", " + value;
													map.put(cellIndex, value2);	
												}
											}												
											continue;
										}else{
											if(map.get(cellIndex) != null){
												if(map.get(cellIndex).toString().indexOf(value) == -1){
													String value2 = map.get(cellIndex)+", " + value;
													map.put(cellIndex, value2);	
												}
											}else{
												map.put(cellIndex, value==null?" ":value);	
											}
											
											
											if(cellIndex == 19){
												before =after;
												list.add(map);
											}
										}
									} // end for
								// cell 탐색 이후 vo 추가
						//	} // end
						} // end if
					}	
				}
			}
		}catch(IOException ex ){
			ex.printStackTrace();
		}finally{
			File newfile = new File("C:\\Users\\Administrator\\Desktop\\임상연구.xml") ;
	        // true 지정시 파일의 기존 내용에 이어서 작성
	        FileWriter fw = new FileWriter(newfile, true) ;

	        StringBuffer sb = new StringBuffer();
	      		
			for (Map map2 : list) {
				for (int i=0;i<=19; i++ ) {
					
					sb.append(map2.get(i) +"\t");
				}
				sb.append("\n");
			}
			
	        fw.write(sb.toString());
	        fw.flush();
	        fw.close();

		}
}
	
	
	
	
	public static void reportExcelUpload2() throws IOException  , NullPointerException {
		
		String msg ="";     
		HSSFWorkbook workbook = null;
		
		
		File file = new File("C:\\Users\\User\\Downloads\\99 반출\\99 반출\\새 폴더\\naver_file.csv");
		FileInputStream fs = new FileInputStream(file);
		List<Map> list = new ArrayList<Map>();
		Map<Object, Object> map = null;
		try {
					
			workbook = new HSSFWorkbook(fs);
		
			// 탐색에 사용할 Sheet, Row, Cell 객체
			HSSFSheet curSheet;
			HSSFRow curRow;
			HSSFCell curCell;
			
			// Sheet 탐색
			// Sheet는 첫번째 시트만 탐색할거다.  0
			String before = "";
			String after = "";
			for (int sheetIndex = 0; sheetIndex < 1; sheetIndex++) {				
				// 현재 sheet 반환
				curSheet = workbook.getSheetAt(sheetIndex);
				// row 탐색 
				
				for (int rowIndex = 0; rowIndex <= curSheet.getLastRowNum(); rowIndex++) {
					// row 0은 헤더정보이기 때문에 무시
					if (rowIndex != 0) {
						map = new HashMap<Object, Object>();
						curRow = curSheet.getRow(rowIndex);
						String value;
						// row의 첫번째 cell값이 비어있지 않는 경우만 cell탐색
						if (curRow != null) {
							//if (!"".equals(curRow.getCell(0))) {
								// cell 탐색 for문
								for (int cellIndex = 0; cellIndex <= curRow.getPhysicalNumberOfCells(); cellIndex++) {
									curCell = curRow.getCell(cellIndex);
										value = "";
										if(curCell != null){ // 해당 row의 cell 이 비어있지 않으면
											// cell 스타일이 다르더라도 String으로 반환 받음
											switch (curCell.getCellType()) {
												case HSSFCell.CELL_TYPE_FORMULA:
													value = curCell.getCellFormula();
												break;
												case HSSFCell.CELL_TYPE_NUMERIC:  
													Integer i = (int)curCell.getNumericCellValue();
													value = i.toString();																																						
												break;
												case HSSFCell.CELL_TYPE_STRING:
													value = curCell.getStringCellValue() + "";
												break;
												case HSSFCell.CELL_TYPE_BLANK:
													value = curCell.getBooleanCellValue() + "";
												break;
												case HSSFCell.CELL_TYPE_ERROR:
													value = curCell.getErrorCellValue() + "";
												break;
												default:
													value = new String();
												break;
											} // end switch
										}else{
											value ="";
										}
										map.put(cellIndex, value);	

									} // end for
						//	} // end
						} // end if
						
						
					}	
					if (rowIndex != 0) {
						list.add(map);
					}
				}
			}
		}catch(IOException ex ){
			ex.printStackTrace();
		}finally{
			File newfile = new File("C:\\Users\\User\\Downloads\\99 반출\\99 반출\\새 폴더\\네이버학술0.xml") ;
	        // true 지정시 파일의 기존 내용에 이어서 작성
	        FileWriter fw = new FileWriter(newfile, true) ;

	    	StringBuffer xml = new StringBuffer();
		   	xml.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n");
		   	xml.append("<dataList>\n");
		   	
			for (Map map2 : list) {
				xml.append("\t<data>\n");
				xml.append("\t\t<table korName=\"국립의과학지식센터\" name=\"ncmik\" tableType=\"main\">\n");	
				xml.append("\t\t\t<field korName=\"CP아이디\" name=\"cpid\"><![CDATA[").append(map2.get(0)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"서비스노출\" name=\"svcExps\"><![CDATA[").append(map2.get(1).toString().replaceAll(" ", "")).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"아이디\" name=\"id\"><![CDATA[").append(map2.get(2)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"전문정보카테고리ID\" name=\"category_id\"><![CDATA[").append(map2.get(3)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"전문정보문서유형분류\" name=\"doc_type\"><![CDATA[").append(map2.get(4)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"전문정보_링크타입\" name=\"link_type\"><![CDATA[").append(map2.get(5)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"한글제목\" name=\"title_kor\"><![CDATA[").append(map2.get(6)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"영문제목\" name=\"title_eng\"><![CDATA[").append(map2.get(7)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"발행일\" name=\"publish_date\"><![CDATA[").append(map2.get(8)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"저자명\" name=\"author\"><![CDATA[").append(map2.get(9)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"출처\" name=\"source\"><![CDATA[").append(map2.get(10)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"목차\" name=\"toc\"><![CDATA[").append(map2.get(11)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"초록\" name=\"abstract\"><![CDATA[").append(map2.get(12)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"요약\" name=\"summary\"><![CDATA[").append(map2.get(13)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"설명\" name=\"description\"><![CDATA[").append(map2.get(14)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"참고\" name=\"reference\"><![CDATA[").append(map2.get(15)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"발행국가\" name=\"publish_country\"><![CDATA[").append(map2.get(16)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"발행언어\" name=\"publish_language\"><![CDATA[").append(map2.get(17)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"학술지\" name=\"publish_name\"><![CDATA[").append(map2.get(18)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"권호정보\" name=\"volume_issue\"><![CDATA[").append(map2.get(19)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"권\" name=\"volume\"><![CDATA[").append(map2.get(20)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"호\" name=\"issue\"><![CDATA[").append(map2.get(21)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"페이지\" name=\"page\"><![CDATA[").append(map2.get(22)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"시작페이지\" name=\"first_page\"><![CDATA[").append(map2.get(23)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"끝페이지\" name=\"last_page\"><![CDATA[").append(map2.get(24)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"총페이지수\" name=\"page_cnt\"><![CDATA[").append(map2.get(25)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"서지링크\" name=\"url\"><![CDATA[").append(map2.get(26)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"원문링크\" name=\"doclink_url\"><![CDATA[").append(map2.get(27)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"키워드\" name=\"keyword\"><![CDATA[").append(map2.get(28)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"문서가격\" name=\"price\"><![CDATA[").append(map2.get(29)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"학술발표자료\" name=\"conference_name\"><![CDATA[").append(map2.get(30)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"ISSN\" name=\"issn\"><![CDATA[").append(map2.get(31)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"전공\" name=\"major\"><![CDATA[").append(map2.get(32)).append("]]></field>\n");		
	            xml.append("\t\t\t<field korName=\"청구기호\" name=\"request_mark\"><![CDATA[").append(map2.get(33)).append("]]></field>\n");		
				xml.append("\t\t</table>\n");
				xml.append("\t</data>\n");
			}
			xml.append("</dataList>");
	        fw.write(xml.toString());
	        fw.flush();
	        fw.close();

		}
}
	
	static ArrayList<String> list = new ArrayList<String>();
    
    public static void getXmlData() throws Exception {
    	
    	//File xmlFile = new File("C:\\Users\\Administrator\\Desktop\\11\\total_sendXml.xml");
    	File xmlFile = new File("C:\\Users\\Administrator\\Desktop\\임상연구.xml");
    	
        //1.문서를 읽기위한 공장을 만들어야 한다.
           DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            
           //2.빌더 생성
           DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            
           //3.생성된 빌더를 통해서 xml문서를 Document객체로 파싱해서 가져온다
       Document doc = dBuilder.parse(xmlFile);
       doc.getDocumentElement().normalize();//문서 구조 안정화
        
       Element root = doc.getDocumentElement();
        
       NodeList n_list = root.getElementsByTagName("table");
       Element el = null;
       NodeList sub_n_list = null; //sub_n_list
           Element sub_el = null; //sub_el
            
           Node v_txt = null;
           String value="";
            
       // String[] tagList = {"trial_id", "reg_name", "date_registration"};
       String[] tagList = {"field","CP아이디"};
         
       System.out.println("***********************************************");
       System.out.println("노드수" + n_list.getLength());
       
       for(int i=0; i< n_list.getLength(); i++) {
         el = (Element) n_list.item(i);
         for(int k=0; k< tagList.length; k++) {
           sub_n_list = el.getElementsByTagName(tagList[k]);
           for(int j=0; j< sub_n_list.getLength(); j++) {
             sub_el = (Element) sub_n_list.item(j);
             v_txt = sub_el.getFirstChild();
             value = v_txt.getNodeValue();

             if(list.contains(value)){
            	// System.out.println(value);
             }else{
            	 //System.out.println(value);
             }
             System.out.println(value);
             
           }
         }
    
       }

     }
}
