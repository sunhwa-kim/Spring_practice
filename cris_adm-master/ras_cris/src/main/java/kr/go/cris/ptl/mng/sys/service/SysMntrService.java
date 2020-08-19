package kr.go.cris.ptl.mng.sys.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.go.cris.ptl.mng.sys.vo.SysMntrVo;





/**
 * <pre>
 * FileName: sysService.java
 * Package : kr.go.cris.ptl.mng.sys.service
 * 
 * 시스템관리 서비스 구현
 *
 * </pre>
 * @author : sejin
 * @date   : 2016. 3. 22.
 */
public interface SysMntrService {
	
	/**
	 * <pre>
	 * 모니터링 등록
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 23.
	 * @param sysVo
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void insertSysMntr(SysMntrVo sysMntrVo) throws IOException, SQLException , NullPointerException;

	
	/**
	 * <pre>
	 * 모니터링 조회
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 23.
	 * @param sysVo
	 * @throws IOException, SQLException , NullPointerException
	 */
	public List<SysMntrVo> selectSysMntrList(SysMntrVo sysMntrVo)throws IOException, SQLException , NullPointerException;


	/**
	 * <pre>
	 * 모니터링 정보 수정 
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 24.
	 * @param sysMntrVo
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void updateSysMntr(SysMntrVo sysMntrVo)throws IOException, SQLException , NullPointerException;


	/**
	 * <pre>
	 * 테이블정보 조회
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 28.
	 * @param map
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public List<Map<String, String>> selectTabList(Map<String, String> map)throws IOException, SQLException , NullPointerException;


	/**
	 * <pre>
	 * 테이블컬럼 조회
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 28.
	 * @param map
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public List<Map<String,String>> selectColList(Map<String, String> map)throws IOException, SQLException , NullPointerException;


	/**
	 * <pre>
	 * 테이블컬럼정보 삭제
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 28.
	 * @param map
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void deleteColInfo(Map<String, String> map)throws IOException, SQLException , NullPointerException;


	/**
	 * <pre>
	 * 테이블컬럼정보 등록
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 28.
	 * @param map
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void insertTabInfo(Map<String, String> map)throws IOException, SQLException , NullPointerException;


	/**
	 * <pre>
	 * 테이블정보 조회 
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 28.
	 * @param tab
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public List<Map<String, String>> selectColInfo(Map<String, String> tab)throws IOException, SQLException , NullPointerException;


	/**
	 * <pre>
	 * 
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 28.
	 * @param map
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void insertColInfo(Map<String, String> map)throws IOException, SQLException , NullPointerException;


	/**
	 * <pre>
	 * 
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 28.
	 * @param map
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public List<Map<String, String>> selectKeyWord(Map<String, String> map)throws IOException, SQLException , NullPointerException;
	
	/**
	 * <pre>
	 * 
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 29.
	 * @param saveMap
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void insertKeyWord(Map<String, String> saveMap) throws IOException, SQLException , NullPointerException;

	/**
	 * <pre>
	 * 
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 29.
	 * @param saveMap
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void insertKeyWordTab(Map<String, String> saveMap)throws IOException, SQLException , NullPointerException;

	/**
	 * <pre>
	 * 
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 29.
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public int selectKeywordSeq()throws IOException, SQLException , NullPointerException;


	
	/**
	 * <pre>
	 * 
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 29.
	 * @param mngMap
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void insertKeyWordMng(Map<String, String> mngMap)throws IOException, SQLException , NullPointerException;

	/**
	 * <pre>
	 * 
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 29.
	 * @param map
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public List<Map<String, String>> selectKeyWordTab(Map<String, String> map)throws IOException, SQLException , NullPointerException;
	
	/**
	 * <pre>
	 * 
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 29.
	 * @param mngMap
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void updateKeyWordMng(Map<String, String> map)throws IOException, SQLException , NullPointerException;


	/**
	 * <pre>
	 * 
	 *
	 * </pre>
	 * @author : sejin
	 * @return 
	 * @date   : 2016. 3. 29.
	 * @throws IOException, SQLException , NullPointerException
	 */
	public List<Map<String, String>> selectExistTabList(Map<String, String> map)throws IOException, SQLException , NullPointerException;


	/**
	 * <pre>
	 *  스켸줄러 조회
	 *
	 * </pre>
	 * @author : Administrator
	 * @date   : 2016. 6. 7.
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public List<SysMntrVo> selectListSch(SysMntrVo sysVo) throws IOException, SQLException , NullPointerException;


	/**
	 * <pre>
	 * 스켸쥴시간 저장
	 *
	 * </pre>
	 * @author : Administrator
	 * @date   : 2016. 6. 7.
	 * @param sysMntrVo
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void saveSch(SysMntrVo sysMntrVo)throws IOException, SQLException , NullPointerException;
	
}
