package kr.go.cris.ptl.archive.intro.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import kr.go.cris.ptl.archive.intro.vo.ArchiveIntroVo;

import org.springframework.stereotype.Repository;

/**
 * <pre>
 * 
 * 아카이브 소개 Dao interface 구현
 * </pre>
 * @FileName : ArchiveArchiveIntroDao.java
 * @package  : kr.go.cris.ptl.archive.report.dao
 * @author   : wonki0138
 * @date     : 2018. 3. 16.
 * 
 */
@Repository
public interface ArchiveIntroDao {

	/**
	 * <pre>
	 * 아카이브 소개 - 발행년도별 목록 화면 조회
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 23. 
	 * @param archiveIntroVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveIntroVo> selectArchiveIntroList(ArchiveIntroVo archiveIntroVo)throws IOException , SQLException , NullPointerException;
	
	
	
	/**
	 * <pre>
	 * 아카이브 성과논문 - 게시물 목록(발행년도별)
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 23. 
	 * @param archiveIntroVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveIntroVo> selectArchiveIntroRndList(ArchiveIntroVo archiveIntroVo)throws IOException , SQLException , NullPointerException;

	

	
	/**
	 * <pre>
	 *
	 * 아카이브 소개 -  Recently / TopDownloads 게시물 총개수
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 19. 
	 * @param archiveIntroVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public int selectArchiveIntroTotalCount(ArchiveIntroVo archiveIntroVo) throws IOException , SQLException , NullPointerException;
	

	/**
	 * <pre>
	 * 아카이브 소개 - 최근 등록 자료 목록 조회
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 22. 
	 * @param archiveIntroVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveIntroVo> selectArchiveIntroRecentlyList(ArchiveIntroVo archiveIntroVo)throws IOException , SQLException , NullPointerException;
	
	
	/**
	 * <pre>
	 * 아카이브 소개 - Top 다운로드 목록 조회
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 22. 
	 * @param archiveIntroVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveIntroVo> selectArchiveIntroTopDownList(ArchiveIntroVo archiveIntroVo)throws IOException , SQLException , NullPointerException;
	
	
	
	/**
	 * <pre>
	 * 아카이브 소개 -  최근 등록 자료 목록 조회
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 23. 
	 * @param archiveIntroVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveIntroVo> selectRecentlyAddItemsList(ArchiveIntroVo archiveIntroVo)throws IOException , SQLException , NullPointerException;
	
	
	/**
	 * <pre>
	 * 아카이브 소개 -  Top Downloads 목록 조회
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 23. 
	 * @param archiveIntroVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveIntroVo> selectTopDownloadList(ArchiveIntroVo archiveIntroVo)throws IOException , SQLException , NullPointerException;
	
	/**
	 * <pre>
	 * 아카이브 소개  - 주제분류
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveIntroVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveIntroVo> selectArchiveIntroAsubList(ArchiveIntroVo archiveIntroVo) throws IOException , SQLException , NullPointerException;
}
