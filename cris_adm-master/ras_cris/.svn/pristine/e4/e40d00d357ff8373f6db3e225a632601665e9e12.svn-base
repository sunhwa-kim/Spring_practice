package kr.go.cris.ptl.archive.rnd.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import kr.go.cris.ptl.archive.rnd.vo.ArchiveRndVo;

import org.springframework.stereotype.Repository;
 
/**
 * <pre>
 * 
 * 아카이브 성과논문 Dao
 * </pre>
 * @FileName : ArchiveRndDao.java
 * @package  : kr.go.cris.ptl.archive.rnd.dao
 * @author   : wonki0138
 * @date     : 2018. 3. 16.
 * 
 */
@Repository
public interface ArchiveRndDao {


	/**
	 * <pre>
	 * 아카이브(성과논문) - 게시물 목록
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 21. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveRndVo> selectRndList(ArchiveRndVo archiveRndVo)throws IOException , SQLException , NullPointerException;


	/**
	 * <pre>
	 *아카이브(성과논문) - 게시물 상세
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 21. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public ArchiveRndVo selectRndInfo(ArchiveRndVo archiveRndVo)throws IOException , SQLException , NullPointerException;


	/**
	 * <pre>
	 *아카이브(성과논문) - 게시물 조회 증가
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 21. 
	 * @param archiveRndVo
	 * @throws IOException , SQLException , NullPointerException
	 */
	public void updateReadCnt(ArchiveRndVo archiveRndVo)throws IOException , SQLException , NullPointerException;

	
	/**
	 * <pre>
	 *
	 * 아카이브(성과논문) -  게시물 총개수
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 19. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public int selectRndTotalCount(ArchiveRndVo archiveRndVo) throws IOException , SQLException , NullPointerException;
	


	/**
	 * <pre>
	 *
	 * 아카이브 성과논문 - 검색결과 제한 목록 조회
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 19. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveRndVo> selectRndFillterList(ArchiveRndVo archiveRndVo)throws IOException , SQLException , NullPointerException;
	
	
	/**
	 * <pre>
	 * 아카이브 성과논문를 등록한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 27. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public Boolean insertArchiveRnd(ArchiveRndVo archiveRndVo) throws IOException , SQLException , NullPointerException ;
	
	/**
	 * <pre>
	 * 아카이브 성과논문를 수정한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 28. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public Boolean updateArchiveRnd(ArchiveRndVo archiveRndVo) throws IOException , SQLException , NullPointerException ;
	
	
	/**
	 * <pre>
	 * 아카이브 성과논문를 삭제한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 28. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public Boolean deleteArchiveRnd(ArchiveRndVo archiveRndVo) throws IOException , SQLException , NullPointerException ;
	
	
	/**
	 * <pre>
	 * 아카이브 성과논문 MAX ID
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 28. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public String selectRndMaxId() throws IOException , SQLException , NullPointerException ;
	
	
	/**
	 * <pre>
	 *아카이브(성과논문) - 게시물 다운로드 증가
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 21. 
	 * @param archiveRndVo
	 * @throws IOException , SQLException , NullPointerException
	 */
	public void updateDownCnt(ArchiveRndVo archiveRndVo)throws IOException , SQLException , NullPointerException;
	
	

	/**
	 * <pre>
	 *
	 * 아카이브 성과논문 연계 보고서 -  게시물 총개수
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public int selectRndLinkCnt( ArchiveRndVo archiveRndVo) throws IOException , SQLException , NullPointerException;
	
	/**
	 * <pre>
	 *
	 * 아카이브 성과논문 연계 보고서 -  게시물 총개수
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveRndVo> selectLinkRnd( ArchiveRndVo archiveRndVo) throws IOException , SQLException , NullPointerException;

	
}
