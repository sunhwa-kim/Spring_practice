package kr.go.cris.ptl.mng.pop.dao;


import java.util.HashMap;
import java.util.List;

import kr.go.cris.ptl.mng.pop.vo.PopMngVo;

import org.springframework.stereotype.Repository;



/**
 * <pre>
 * FileName: PopMngDao.java
 * Package : kr.go.rastech.ptl.mng.pop.dao;
 * 
 * 팝업관리 dao
 *
 * </pre>
 * @author : lwk
 * @date   : 2019. 12. 11.
 */
@Repository
public interface PopMngDao {
	/**
	 * <pre>
	 * 게시물 순번
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public int selectPopSn() throws Exception;
	
	/**
	 * <pre>
	 * 파일순번
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public int selectPopFileSn(int pop_sn) throws Exception;
	
	/**
	 * <pre>
	 * 게시물 전체 count
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param popMngVo
	 * @return
	 * @throws Exception
	 */
	public int selectPopTotalCount(PopMngVo popMngVo) throws Exception;
	
	/**
	 * <pre>
	 * 게시물 전체 조회
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param popMngVo
	 * @return
	 * @throws Exception
	 */
	public List<PopMngVo> selectPopList(PopMngVo popMngVo)throws Exception;
	
	
	/**
	 * <pre>
	 * 메인팝업존 게시물 조회
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param popMngVo
	 * @return
	 * @throws Exception
	 */
	public List<PopMngVo> selectMainPopList(PopMngVo popMngVo)throws Exception;
	/**
	 * <pre>
	 * 게시물 수정
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param popMngVo
	 * @return
	 * @throws Exception
	 */
	public Boolean updatePop(PopMngVo popMngVo);
	
	
	/**
	 * <pre>
	 * 게시물 등록
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param popMngVo
	 * @return
	 * @throws Exception
	 */
	public Boolean insertPop(PopMngVo popMngVo);
	
	/**
	 * <pre>
	 * 파일 등록
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param popMngVo
	 * @return
	 * @throws Exception
	 */
	public Boolean insertPopFile(PopMngVo popMngVo);
	
	
	/**
	 * <pre>
	 * 첨부파일 다운로드
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param hashMap
	 * @return
	 */

	public PopMngVo retrieveFile(HashMap<String, Object> hashMap);
	
	
	
	
	/**
	 * <pre>
	 * 첨부파일삭제
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param popMngVo
	 * @return
	 */
	public Boolean deletePopFile(PopMngVo popMngVo);
	
	
	/**
	 * <pre>
	 * 팝업관리 삭제
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param popMngVo
	 * @return
	 */
	public Boolean deletePop(PopMngVo popMngVo);
}
