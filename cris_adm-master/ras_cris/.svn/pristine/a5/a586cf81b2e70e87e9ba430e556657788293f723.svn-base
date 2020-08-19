package kr.go.cris.ptl.archive.report.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import kr.go.cris.ptl.archive.report.vo.ArchiveAnnualInfoVo;
import kr.go.cris.ptl.archive.report.vo.ArchiveReportVo;

import org.springframework.web.multipart.MultipartFile;


/**
 * <pre>
 * 
 * 아카이브 보고서 Service interface 구현
 * </pre>
 * @FileName : ArchiveReportService.java
 * @package  : kr.go.cris.ptl.archive.report.service
 * @author   : wonki0138
 * @date     : 2018. 3. 16.
 * 
 */
public interface ArchiveReportService {

	/**
	 * <pre>
	 * 아카이브 보고서 - 게시물 목록을 조회한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveReportVo> selectReportList(ArchiveReportVo archiveReportVo)  throws IOException , SQLException , NullPointerException ;

	/**
	 * <pre>
	 * 아카이브 보고서 - 게시물 상세 정보를 조회한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public ArchiveReportVo selectReportInfo(ArchiveReportVo archiveReportVo)   throws IOException , SQLException , NullPointerException;

	/**
	 * <pre>
	 *
	 * 아카이브 보고서 - 게시물 조회수를 업데이트한다.
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveReportVo
	 * @throws IOException , SQLException , NullPointerException
	 */
	public void updateReadCnt(ArchiveReportVo archiveReportVo)   throws IOException , SQLException , NullPointerException;

	/**
	 * <pre>
	 *
	 * 아카이브 보고서 -  게시물 총개수를 조회한다.
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public int selectReportTotalCount( ArchiveReportVo archiveReportVo) throws IOException , SQLException , NullPointerException;

	
	
	/**
	 * <pre>
	 *
	 * 아카이브 보고서 - 검색결과 제한 목록 조회
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 19. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveReportVo> selectReportFillterList(ArchiveReportVo archiveReportVo)  throws IOException , SQLException , NullPointerException ;

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
	public Boolean insertArchiveReport(ArchiveReportVo archiveReportVo) throws IOException , SQLException , NullPointerException ;
	
	/**
	 * <pre>
	 * 아카이브 보고서 연차정보를 등록한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 27. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public Boolean insertArchiveAnnualInfo(ArchiveAnnualInfoVo archiveAnnualInfoVo) throws IOException , SQLException , NullPointerException ;
	
	
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
	public Boolean updateArchiveReport(ArchiveReportVo archiveReportVo) throws IOException , SQLException , NullPointerException ;
	
	

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
	public Boolean deleteArchiveReport(ArchiveReportVo archiveReportVo) throws IOException , SQLException , NullPointerException ;
	
	
	
	/**
	 * <pre>
	 * 아카이브 보고서ID MAX
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 27. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public String  selectReportMaxId() throws IOException , SQLException , NullPointerException ;
	
	


	/**
	 * <pre>
	 * 엑셀 파일을 업로드한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 4. 2. 
	 * @param file
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveReportVo> reportExcelUpload(MultipartFile file) throws IOException , SQLException , NullPointerException;
	
	
	
	
	/**
	 * <pre>
	 *
	 * 아카이브 보고서 - 게시물 첨부파일 다운로드 증가
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveReportVo
	 * @throws IOException , SQLException , NullPointerException
	 */
	public void updateDownCnt(ArchiveReportVo archiveReportVo)   throws IOException , SQLException , NullPointerException;
	
	
	/**
	 * <pre>
	 * 아카이브 보고서 연차정보 - 게시물 상세 정보
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveAnnualInfoVo> selectAnnualInfo(ArchiveReportVo archiveReportVo)   throws IOException , SQLException , NullPointerException;

	
	
	/**
	 * <pre>
	 * 아카이브 보고서 연차정보를 삭제한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 27. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public Boolean deleteArchiveAnnualInfo(ArchiveReportVo archiveReportVo) throws IOException , SQLException , NullPointerException ;
	
	
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
	public void updateArchiveLinkRnd(ArchiveReportVo archiveReportVo) throws IOException , SQLException , NullPointerException ;
}  
