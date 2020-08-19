package kr.go.cris.ptl.archive.report.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.ptl.archive.report.dao.ArchiveReportDao;
import kr.go.cris.ptl.archive.report.vo.ArchiveAnnualInfoVo;
import kr.go.cris.ptl.archive.report.vo.ArchiveReportVo;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.rte.fdl.cmmn.exception.FdlException;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * <pre>
 * 
 * 아카이브 보고서 ServiceImpl 구현
 * </pre>
 * @FileName : ArchiveReportServiceImpl.java
 * @package  : kr.go.cris.ptl.archive.report.service
 * @author   : wonki0138
 * @date     : 2018. 3. 16.
 * 
 */
@Service
public class ArchiveReportServiceImpl extends BaseServiceImpl implements ArchiveReportService {

	@Resource(name="archiveReportDao")
	private ArchiveReportDao archiveReportDao;
	
	
	/** ID Generation */    
	@Resource(name="egovReportIdGnrService")
	private EgovIdGnrService idGnrService;	
	
	
	
	
	/**
	 * <pre>
	 * 아카이브 보고서 - 게시물 목록
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveReportVo> selectReportList(ArchiveReportVo archiveReportVo)  throws IOException , SQLException , NullPointerException{

		return archiveReportDao.selectReportList(archiveReportVo);
	}

	/**
	 * <pre>
	 * 아카이브 보고서 - 게시물 상세 정보
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public ArchiveReportVo selectReportInfo(ArchiveReportVo archiveReportVo) throws IOException , SQLException , NullPointerException {
		return archiveReportDao.selectReportInfo(archiveReportVo);
	}
	
	/**
	 * <pre>
	 *
	 * 아카이브 보고서 - 게시물 조회수 증가
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveReportVo
	 * @throws IOException , SQLException , NullPointerException
	 */
	public void updateReadCnt(ArchiveReportVo archiveReportVo)   throws IOException , SQLException , NullPointerException{

		archiveReportDao.updateReadCnt(archiveReportVo);

	}

	/**
	 * <pre>
	 *
	 * 아카이브 보고서 -  게시물 총개수
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public int selectReportTotalCount(ArchiveReportVo archiveReportVo) throws IOException , SQLException , NullPointerException {
		return archiveReportDao.selectReportTotalCount(archiveReportVo);
	}

	/**
	 * <pre>
	 *
	 *  아카이브 보고서 - 검색결과 제한 목록 조회
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 19. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public List<ArchiveReportVo> selectReportFillterList(ArchiveReportVo archiveReportVo) throws IOException , SQLException , NullPointerException {
		
		return archiveReportDao.selectReportFillterList(archiveReportVo);
	}

	/**
	 * <pre>
	 * 아카이브 보고서를 등록한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 27. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public Boolean insertArchiveReport(ArchiveReportVo archiveReportVo)	throws IOException , SQLException , NullPointerException {
		ArchiveAnnualInfoVo archiveAnnualInfoVo = null;

		boolean outResult = true;
		boolean result = true;
		boolean result2 = true;
		boolean result3 = true;
		try {

			String rep_id = null;
			try {
				rep_id = idGnrService.getNextStringId();
			} catch (FdlException e) {
				logger.debug("insertArchiveReport idGnrService.getNextStringId() ERROR");
			}
			archiveReportVo.setRep_id(rep_id);

			result = archiveReportDao.insertArchiveReport(archiveReportVo);

			List<String> list = null;
			list = Arrays.asList(archiveReportVo.getPeriod_gbn().split(","));
		
			List<String> list2 = null;
			list2 = Arrays.asList(archiveReportVo.getResearch_dt().split(","));
		
			List<String> list3 = null;
			list3 = Arrays.asList(archiveReportVo.getResearch_fund().split(","));
		
			if ((list != null && list.size() > 0)) {
				if ((list2 != null && list2.size() > 0)|| (list3 != null && list3.size() > 0)) {
					for (int i = 0; i < list.size(); i++) {
						
						archiveAnnualInfoVo = new ArchiveAnnualInfoVo();
						archiveAnnualInfoVo.setPeriod_gbn(list.get(i));
						if (list2 != null && list2.size() > 0) {
							if(i < list2.size()){
								archiveAnnualInfoVo.setResearch_dt(list2.get(i));
							}
						}
						if (list3 != null && list3.size() > 0) {
							if(i < list3.size()){
								archiveAnnualInfoVo.setResearch_fund(list3.get(i));
							}
						}
						archiveAnnualInfoVo.setRep_id(rep_id);
						//System.out.println("222 = "+archiveReportVo.getFrst_register_id());
						archiveAnnualInfoVo.setFrst_register_id(archiveReportVo.getFrst_register_id());
						result2 = this.insertArchiveAnnualInfo(archiveAnnualInfoVo);

						if (result2 == false) {
							result3 = false;
						}
					}
				}
			}

			if (result == true && result3 == true) {
				outResult = true;
			} else {
				outResult = false;
			}
		} catch (IOException  ex) {
			logger.debug("err insertArchiveReport IOException");
		}catch( SQLException  ex ){
			logger.debug("err insertArchiveReport SQLException");
		}
		return outResult;

	}


	/**
	 * <pre>
	 * 아카이브 보고서를 수정한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 27. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public Boolean updateArchiveReport(ArchiveReportVo archiveReportVo)	throws IOException , SQLException , NullPointerException {

		ArchiveAnnualInfoVo archiveAnnualInfoVo = null;

		boolean outResult = true;
		boolean resultInsert = true;
		boolean resultTotal = true;
		boolean resultUpdate = true;
		boolean resultDelete = true;		
		boolean deleteGbn = true;
		try {

			resultUpdate = archiveReportDao.updateArchiveReport(archiveReportVo);
		

			List<String> list = null;
			list = Arrays.asList(archiveReportVo.getPeriod_gbn().split(","));

			List<String> list2 = null;
			list2 = Arrays.asList(archiveReportVo.getResearch_dt().split(","));

			List<String> list3 = null;
			list3 = Arrays.asList(archiveReportVo.getResearch_fund().split(","));

			if ((list != null && list.size() > 0)) {
				if ((list2 != null && list2.size() > 0)
						|| (list3 != null && list3.size() > 0)) {
					try{
						resultDelete = archiveReportDao.deleteArchiveAnnualInfo(archiveReportVo);
					}catch(IOException ex ){
						deleteGbn = false;
					}catch(SQLException ex){
						deleteGbn = false;
					}finally{
						if(deleteGbn == false){
							resultDelete = false;
						}else{
							resultDelete = true;
						}
					}			
					
					for (int i = 0; i < list.size(); i++) {
						archiveAnnualInfoVo = new ArchiveAnnualInfoVo();
						archiveAnnualInfoVo.setPeriod_gbn(list.get(i));
						if (list2 != null && list2.size() > 0) {
							if(i < list2.size()){
								archiveAnnualInfoVo.setResearch_dt(list2.get(i));
							}
						}
						if (list3 != null && list3.size() > 0) {
							if(i < list3.size()){
								archiveAnnualInfoVo.setResearch_fund(list3.get(i));
							}
						}
						archiveAnnualInfoVo.setRep_id(archiveReportVo.getRep_id());
						
						
						archiveAnnualInfoVo.setLast_updusr_id(archiveReportVo.getLast_updt_pnttm());
						resultInsert = this.insertArchiveAnnualInfo(archiveAnnualInfoVo);

						if (resultInsert == false) {
							resultTotal = false;
						}
					}
				}
			}

			if (resultUpdate == true && resultTotal == true&& resultDelete == true) {
				outResult = true;
			} else {
				outResult = false;
			}

		}catch(IOException ex ){
			logger.debug("err updateArchiveReport IOException");
		}catch(SQLException ex){
			logger.debug("err updateArchiveReport SQLException");
		}

		return outResult;

	}

	
	/**
	 * <pre>
	 * 아카이브 보고서를 삭제한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 27. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public Boolean deleteArchiveReport(ArchiveReportVo archiveReportVo)throws IOException , SQLException , NullPointerException {
		
		boolean resultAll = true;
	
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean result1 = archiveReportDao.deleteArchiveReport(archiveReportVo);
		
		archiveReportDao.deleteArchiveAnnualInfo(archiveReportVo);
		archiveReportDao.updateArchiveLinkRnd(archiveReportVo);
		//map.put("file_id", archiveReportVo.getRep_id());
		//this.deleteReportFileAll(map);
		
		if(result1 == true){
			resultAll = true;
		}else{
			resultAll = false;
		}	
	
		
	return  resultAll;
	}

	/**
	 * <pre>
	 * 아카이브 보고서 MAX ID
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 29. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public String selectReportMaxId()throws IOException , SQLException , NullPointerException {
		return archiveReportDao.selectReportMaxId();
	}

	@Override
	public List<ArchiveReportVo> reportExcelUpload(MultipartFile file) throws IOException  , NullPointerException {
	
				List<ArchiveReportVo> list = new ArrayList<ArchiveReportVo>();
				
				List error_list = new ArrayList();
				String msg ="";     
				HSSFWorkbook workbook = null;
				
				try {
							
					workbook = new HSSFWorkbook(file.getInputStream());
				
					// 탐색에 사용할 Sheet, Row, Cell 객체
					HSSFSheet curSheet;
					HSSFRow curRow;
					HSSFCell curCell;
					ArchiveReportVo vo = null;
				
					// Sheet 탐색
					// Sheet는 첫번째 시트만 탐색할거다.  0
					for (int sheetIndex = 0; sheetIndex < 1; sheetIndex++) {				
						// 현재 sheet 반환
						curSheet = workbook.getSheetAt(sheetIndex);
						//System.out.println("curSheet.getLastRowNum() = " + curSheet.getLastRowNum());
						// row 탐색 
						for (int rowIndex = 0; rowIndex <= curSheet.getLastRowNum(); rowIndex++) {
							// row 0은 헤더정보이기 때문에 무시
							if (rowIndex != 0) {
								curRow = curSheet.getRow(rowIndex);
								vo = new ArchiveReportVo();
								String value;
						
								// row의 첫번째 cell값이 비어있지 않는 경우만 cell탐색
							
								if (curRow != null) {
									
									
									//if (!"".equals(curRow.getCell(0))) {
										// cell 탐색 for문

										for (int cellIndex = 0; cellIndex <= curRow.getPhysicalNumberOfCells(); cellIndex++) {
											curCell = curRow.getCell(cellIndex);
									
											//if (true) {
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
													}
													// 현재 colum index에 따라서 vo입력
													switch (cellIndex) {
													
														case 0: // 과제번호
															vo.setBusino(value);									
														break;
														
														case 1: // 국문
															vo.setProj_tit_kor(value);
														break;
														
														case 2: // 영문
															vo.setProj_tit_eng(value);
														break;
														
														case 3: // 책임연구원														
															vo.setPi(value);
														break;
														
														case 4: //발행자
															vo.setOrg_name(value);
														break;
														
														case 5: // 발행년도
															vo.setPubyear(value);
														break;
														
														case 6: // 주제
															vo.setSubject(value);
														break;
														
														case 7: // 주제
															vo.setAtch_link_id(value);
														break;
													
														default:
														break;
													}
												//} // end if
											} // end for
										// cell 탐색 이후 vo 추가
										vo.setRn(String.valueOf(rowIndex+1));
										list.add(vo);
								//	} // end
								} // end if
							}	
						}
					}
					//System.out.println(list);
					
					
					
				}catch(IOException ex ){
					logger.debug("err reportExcelUpload IOException");
				}
				
				return list;

	}

	/**
	 * <pre>
	 * 다운로드
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 4. 5. 
	 * @param archiveReportVo
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public void updateDownCnt(ArchiveReportVo archiveReportVo) throws IOException , SQLException , NullPointerException {
	
		archiveReportDao.updateDownCnt(archiveReportVo);
	}

	/**
	 * <pre>
	 * 보고서 연차정보 등록
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 4. 24. 
	 * @param archiveAnnualInfoVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public Boolean insertArchiveAnnualInfo(ArchiveAnnualInfoVo archiveAnnualInfoVo) throws IOException , SQLException , NullPointerException {
		return archiveReportDao.insertArchiveAnnualInfo(archiveAnnualInfoVo);
	}

	/**
	 * <pre>
	 *	보고서 연차정보 상세 조회
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 4. 24. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public List<ArchiveAnnualInfoVo> selectAnnualInfo(ArchiveReportVo archiveReportVo)throws IOException , SQLException , NullPointerException {
		return archiveReportDao.selectAnnualInfo(archiveReportVo);
	}

	/**
	 * <pre>
	 * 보고서 연차정보 삭제
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 4. 27. 
	 * @param archiveAnnualInfoVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public Boolean deleteArchiveAnnualInfo(ArchiveReportVo archiveReportVo) throws IOException , SQLException , NullPointerException {
		return archiveReportDao.deleteArchiveAnnualInfo(archiveReportVo);
	}

	
	/**
	 * <pre>
	 * 아카이브 성과논문의 연계과제를 수정한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 28. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public void updateArchiveLinkRnd(ArchiveReportVo archiveReportVo) throws IOException , SQLException , NullPointerException {

		 archiveReportDao.updateArchiveLinkRnd(archiveReportVo);
	}

}
