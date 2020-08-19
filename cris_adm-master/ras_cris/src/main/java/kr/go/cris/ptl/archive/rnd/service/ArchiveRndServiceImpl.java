package kr.go.cris.ptl.archive.rnd.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.ptl.archive.rnd.dao.ArchiveRndDao;
import kr.go.cris.ptl.archive.rnd.vo.ArchiveRndVo;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.exception.FdlException;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
 
/**
 * <pre>
 * 
 * 아카이브 성과논문 ServiceImpl
 * </pre>
 * @FileName : ArchiveRndServiceImpl.java
 * @package  : kr.go.cris.ptl.archive.rnd.service
 * @author   : wonki0138
 * @date     : 2018. 3. 16.
 * 
 */
@Service
public class ArchiveRndServiceImpl extends BaseServiceImpl implements ArchiveRndService {

	@Resource(name="archiveRndDao")
	private ArchiveRndDao archiveRndDao;

    
	/** ID Generation */    
	@Resource(name="egovRndIdGnrService")
	private EgovIdGnrService idGnrService;

	/**
	 * <pre>
	 * 아카이브 성과논문 - 게시물 목록
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<ArchiveRndVo> selectRndList(ArchiveRndVo archiveRndVo)  throws IOException , SQLException , NullPointerException{

		return archiveRndDao.selectRndList(archiveRndVo);
	}

	/**
	 * <pre>
	 * 아카이브 성과논문 - 게시물 상세 정보
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public ArchiveRndVo selectRndInfo(ArchiveRndVo archiveRndVo) throws IOException , SQLException , NullPointerException {
		return archiveRndDao.selectRndInfo(archiveRndVo);
	}
	
	/**
	 * <pre>
	 *
	 * 아카이브 성과논문 - 게시물 조회수 증가
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveRndVo
	 * @throws IOException , SQLException , NullPointerException
	 */
	public void updateReadCnt(ArchiveRndVo archiveRndVo)   throws IOException , SQLException , NullPointerException{

		archiveRndDao.updateReadCnt(archiveRndVo);

	}

	/**
	 * <pre>
	 *
	 * 아카이브 성과논문 -  게시물 총개수
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public int selectRndTotalCount(ArchiveRndVo archiveRndVo) throws IOException , SQLException , NullPointerException {
		return archiveRndDao.selectRndTotalCount(archiveRndVo);
	}

	/**
	 * <pre>
	 *
	 *  아카이브 성과논문 - 검색결과 제한 목록 조회
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 19. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public List<ArchiveRndVo> selectRndFillterList(ArchiveRndVo archiveRndVo) throws IOException , SQLException , NullPointerException {
		
		return archiveRndDao.selectRndFillterList(archiveRndVo);
	}


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
	@Override
	public Boolean insertArchiveRnd(ArchiveRndVo archiveRndVo)	throws IOException , SQLException , NullPointerException {

		String rnd_id = null;
		try {
			rnd_id = idGnrService.getNextStringId();
		} catch (FdlException e) {
			logger.debug("ERROR insertArchiveRnd FdlException");
		}
		archiveRndVo.setRnd_id(rnd_id);
		
		return archiveRndDao.insertArchiveRnd(archiveRndVo);
		
	}


	/**
	 * <pre>
	 * 아카이브 성과논문를 수정한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 27. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public Boolean updateArchiveRnd(ArchiveRndVo archiveRndVo)	throws IOException , SQLException , NullPointerException {

		return archiveRndDao.updateArchiveRnd(archiveRndVo);
		
	}

	
	/**
	 * <pre>
	 * 아카이브 성과논문를 삭제한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 27. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public Boolean deleteArchiveRnd(ArchiveRndVo archiveRndVo)throws IOException , SQLException , NullPointerException {
		
		boolean resultAll = true;
		Map<String, Object> map = new HashMap<String, Object>();
		
			boolean result1 = archiveRndDao.deleteArchiveRnd(archiveRndVo);
			
			// map.put("file_id", archiveRndVo.getRnd_id());
		//	boolean result2 = this.deleteRndFileAll(map);
			
			if(result1 == true){
				resultAll = true;
			}else{
				resultAll = false;
			}	
		
			
		return  resultAll;
	}

	/**
	 * <pre>
	 * 아카이브 성과논문 MAX ID
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 29. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public String selectRndMaxId()throws IOException , SQLException , NullPointerException {
		return archiveRndDao.selectRndMaxId();
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
	public void updateDownCnt(ArchiveRndVo archiveRndVo) throws IOException , SQLException , NullPointerException {
	
			
			archiveRndDao.updateDownCnt(archiveRndVo);
	
	}


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
	@Override
	public int selectRndLinkCnt(ArchiveRndVo archiveRndVo) throws IOException , SQLException , NullPointerException {
		return archiveRndDao.selectRndLinkCnt(archiveRndVo);
	}

	
	/**
	 * <pre>
	 * 아카이브 보고서 와 연관된 성과논문 리스트 조회
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public List<ArchiveRndVo> selectLinkRnd(ArchiveRndVo archiveRndVo) throws IOException, SQLException, NullPointerException {
		return archiveRndDao.selectLinkRnd(archiveRndVo);
	}

	



}
