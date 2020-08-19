package kr.go.cris.ptl.archive.intro.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.ptl.archive.intro.dao.ArchiveIntroDao;
import kr.go.cris.ptl.archive.intro.vo.ArchiveIntroVo;

import org.springframework.stereotype.Service;

/**
 * <pre>
 * 
 * 아카이브 소개 ServiceImpl 구현
 * </pre>
 * @FileName : ArchiveArchiveIntroServiceImpl.java
 * @package  : kr.go.cris.ptl.archive.report.service
 * @author   : wonki0138
 * @date     : 2018. 3. 16.
 * 
 */
@Service
public class ArchiveIntroServiceImpl extends BaseServiceImpl implements ArchiveIntroService {

	@Resource(name="archiveIntroDao")
	private ArchiveIntroDao archiveIntroDao;
	

	/**
	 * <pre>
	 * 아카이브 소개 - 게시물 목록
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveIntroVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveIntroVo> selectArchiveIntroList(ArchiveIntroVo archiveIntroVo)  throws IOException , SQLException , NullPointerException{

		return archiveIntroDao.selectArchiveIntroList(archiveIntroVo);
	}
	
	/**
	 * <pre>
	 * 아카이브 성과논문 - 게시물 목록(발행년도별)
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveIntroVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveIntroVo> selectArchiveIntroRndList(ArchiveIntroVo archiveIntroVo)  throws IOException , SQLException , NullPointerException{

		return archiveIntroDao.selectArchiveIntroRndList(archiveIntroVo);
	}
	



	/**
	 * <pre>
	 *
	 * 아카이브 소개 -  Recently / TopDownloads 게시물 총개수
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveIntroVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public int selectArchiveIntroTotalCount(ArchiveIntroVo archiveIntroVo) throws IOException , SQLException , NullPointerException {
		return archiveIntroDao.selectArchiveIntroTotalCount(archiveIntroVo);
	}

	/**
	 * <pre>
	 *
	 *  아카이브 소개 -우측 영역 최근 등록 자료 목록 조회
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 19. 
	 * @param archiveIntroVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public List<ArchiveIntroVo> selectArchiveIntroRecentlyList(ArchiveIntroVo archiveIntroVo) throws IOException , SQLException , NullPointerException {
		
		return archiveIntroDao.selectArchiveIntroRecentlyList(archiveIntroVo);
	}

	/**
	 * <pre>
	 *
	 * 아카이브 소개 -우측 영역 Top 다운로드 목록 조회
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 22. 
	 * @param archiveIntroVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public List<ArchiveIntroVo> selectArchiveIntroTopDownList(ArchiveIntroVo archiveIntroVo) throws IOException , SQLException , NullPointerException {
		return archiveIntroDao.selectArchiveIntroTopDownList(archiveIntroVo);
	}

	
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
	@Override
	public List<ArchiveIntroVo> selectRecentlyAddItemsList(ArchiveIntroVo archiveIntroVo) throws IOException , SQLException , NullPointerException {
		return archiveIntroDao.selectRecentlyAddItemsList(archiveIntroVo);
	}

	
	/**
	 * <pre>
	 * 아카이브 소개 -  Top Downloads 목록 조회
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 26. 
	 * @param archiveIntroVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public List<ArchiveIntroVo> selectTopDownloadList(ArchiveIntroVo archiveIntroVo) throws IOException , SQLException , NullPointerException {
		
		return archiveIntroDao.selectTopDownloadList(archiveIntroVo);
	}
	
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
	@Override
	public List<ArchiveIntroVo> selectArchiveIntroAsubList(ArchiveIntroVo archiveIntroVo) throws IOException , SQLException , NullPointerException {
		return archiveIntroDao.selectArchiveIntroAsubList(archiveIntroVo);
	}


}
