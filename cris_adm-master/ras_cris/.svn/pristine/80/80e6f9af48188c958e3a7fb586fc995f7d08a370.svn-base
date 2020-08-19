package kr.go.cris.ptl.archive.report.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import kr.go.cris.ptl.archive.report.vo.ArchiveAnnualInfoVo;
import kr.go.cris.ptl.archive.report.vo.ArchiveReportVo;

import org.springframework.stereotype.Repository;

/**
 * <pre>
 * 
 * 아카이브 보고서 Dao interface 구현
 * </pre>
 * @FileName : ArchiveReportDao.java
 * @package  : kr.go.cris.ptl.archive.report.dao
 * @author   : wonki0138
 * @date     : 2018. 3. 16.
 * 
 */
@Repository
public interface ArchiveReportDao {


	/**
	 * <pre>
	 * 아카이브(보고서) - 게시물 목록
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 21. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveReportVo> selectReportList(ArchiveReportVo archiveReportVo)throws IOException , SQLException , NullPointerException;


	/**
	 * <pre>
	 *아카이브(보고서) - 게시물 상세
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 21. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public ArchiveReportVo selectReportInfo(ArchiveReportVo archiveReportVo)throws IOException , SQLException , NullPointerException;


	/**
	 * <pre>
	 *아카이브(보고서) - 게시물 조회 증가
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 21. 
	 * @param archiveReportVo
	 * @throws IOException , SQLException , NullPointerException
	 */
	public void updateReadCnt(ArchiveReportVo archiveReportVo)throws IOException , SQLException , NullPointerException;

	
	/**
	 * <pre>
	 *
	 * 아카이브(보고서) -  게시물 총개수
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 19. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public int selectReportTotalCount(ArchiveReportVo archiveReportVo) throws IOException , SQLException , NullPointerException;
	


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
	public List<ArchiveReportVo> selectReportFillterList(ArchiveReportVo archiveReportVo)throws IOException , SQLException , NullPointerException;
	
	
	
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
	 * 아카이브 보고서를 수정한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 28. 
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
	 * @date   : 2018. 3. 28. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public Boolean deleteArchiveReport(ArchiveReportVo archiveReportVo) throws IOException , SQLException , NullPointerException ;
	
	
	/**
	 * <pre>
	 * 아카이브 보고서 MAX ID
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 28. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public String selectReportMaxId() throws IOException , SQLException , NullPointerException ;
	
	
	
	
	

	
	/**
	 * <pre>
	 *아카이브(보고서) - 게시물 다운로드 증가
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 21. 
	 * @param archiveReportVo
	 * @throws IOException , SQLException , NullPointerException
	 */
	public void updateDownCnt(ArchiveReportVo archiveReportVo)throws IOException , SQLException , NullPointerException;
	
	/**
	 * <pre>
	 * 아카이브 연차정보를 등록한다.
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
	 * 보고서 연차정보 상세 조회
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 21. 
	 * @param archiveReportVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveAnnualInfoVo> selectAnnualInfo(ArchiveReportVo archiveReportVo)throws IOException , SQLException , NullPointerException;
	

	/**
	 * <pre>
	 * 보고서 연차정보를 삭제 한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 4. 27. 
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
