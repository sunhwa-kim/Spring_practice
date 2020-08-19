package kr.go.cris.ptl.mng.pop.service;



import java.util.List;

import kr.go.cris.ptl.mng.pop.vo.PopMngVo;


/**
 * <pre>
 * FileName: PopMngService.java
 * Package : kr.go.rastech.ptl.mng.pop.service
 * 
 * 
 *
 * </pre>
 * @author : lwk
 * @date   : 2019. 12. 11.
 */
public interface PopMngService {
	
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
	public int selectPopTotalCount(PopMngVo popMngVo) throws Exception ;
	
	/**
	 * <pre>
	 * 게시물 max순번
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public int selectPopSn() throws Exception ;
	
	
	
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
	public List<PopMngVo> selectPopList(PopMngVo popMngVo) throws Exception ;
	
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
	public List<PopMngVo> selectMainPopList(PopMngVo popMngVo) throws Exception ;
	
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
	public Boolean updatePop(PopMngVo popMngVo) throws Exception ;
	
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
	public Boolean insertPop(PopMngVo popMngVo) throws Exception ;
	
	

	/**
	 * <pre>
	 * 첨부파일 삭제 
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param  popMngVo
	 * @return
	 * @throws Exception
	 */
	public Boolean deletePopFile(PopMngVo popMngVo) throws Exception ;
	
	/**
	 * <pre>
	 * 팝업관리 삭제
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param  popMngVo
	 * @return
	 * @throws Exception
	 */
	public Boolean deletePop(PopMngVo popMngVo) throws Exception ;
	
	/**
	 * <pre>
	 * 게시물 파일 등록
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param popMngVo
	 * @return
	 * @throws Exception
	 */
	public Boolean insertPopFile(PopMngVo popMngVo) throws Exception ;
	
	
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
	public int selectPopFileSn(int pop_sn) throws Exception ;
	

	/**
	 * <pre>
	 * 첨부파일 다운로드
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param down_pop_sn
	 * @param down_file_sn
	 * @return
	 * @throws Exception
	 */
	public PopMngVo retrieveFile(int pop_sn, int pop_file_sn ) throws Exception;
}
