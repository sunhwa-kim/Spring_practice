package kr.go.cris.ptl.mng.sys.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.go.cris.ptl.mng.sys.vo.SysMntrVo;

import org.springframework.stereotype.Repository;

/**
 * <pre>
 * FileName: SysDao.java
 * Package : kr.go.cris.ptl.mng.sys.dao
 * 
 * 시스템 관리 DAO
 *
 * </pre>
 * @author : sejin
 * @date   : 2016. 3. 22.
 */
@Repository
public interface SysMntrDao {

	/**
	 * <pre>
	 * 모니터링 저장
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 23.
	 * @param sysVo
	 */
	void insertSysMntr(SysMntrVo sysVo) throws IOException, SQLException , NullPointerException;

	/**
	 * <pre>
	 * 모니터링 조회
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 23.
	 * @param sysVo
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	List<SysMntrVo> selectSysMntrList(SysMntrVo sysVo) throws IOException, SQLException , NullPointerException;

	/**
	 * <pre>
	 * 모니터링 수정 
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 24.
	 * @param sysMntrVo
	 * @throws IOException, SQLException , NullPointerException
	 */
	void updateSysMntr(SysMntrVo sysMntrVo)throws IOException, SQLException , NullPointerException;

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
	List<Map<String, String>> selectTabList(Map<String, String> map)throws IOException, SQLException , NullPointerException;

	/**
	 * <pre>
	 *  테이블컬럼 조회
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 28.
	 * @param map
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	List<Map<String, String>> selectColList(Map<String, String> map)throws IOException, SQLException , NullPointerException;

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
	void deleteColInfo(Map<String, String> map)throws IOException, SQLException , NullPointerException;

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
	void insertTabInfo(Map<String, String> map)throws IOException, SQLException , NullPointerException;

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
	List<Map<String, String>> selectColInfo(Map<String, String> map)throws IOException, SQLException , NullPointerException;

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
	void insertColInfo(Map<String, String> map)throws IOException, SQLException , NullPointerException;

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
	List<Map<String, String>> selectKeyWord(Map<String, String> map)throws IOException, SQLException , NullPointerException;

	/**
	 * <pre>
	 * 
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 28.
	 * @param saveMap
	 * @throws IOException, SQLException , NullPointerException
	 */
	void insertKeyWord(Map<String, String> saveMap) throws IOException, SQLException , NullPointerException;

	/**
	 * <pre>
	 * 
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 28.
	 * @param saveMap
	 * @throws IOException, SQLException , NullPointerException
	 */
	void insertKeyWordTab(Map<String, String> saveMap)throws IOException, SQLException , NullPointerException;

	/**
	 * <pre>
	 * 
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 28.
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	int selectKeywordSeq()throws IOException, SQLException , NullPointerException;

	

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
	void insertKeyWordMng(Map<String, String> mngMap)throws IOException, SQLException , NullPointerException;

	/**
	 * <pre>
	 * 
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 29.
	 * @param map
	 * @return
	 */
	List<Map<String, String>> selectKeyWordTab(Map<String, String> map)throws IOException, SQLException , NullPointerException;

	/**
	 * <pre>
	 * 
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 29.
	 * @param map
	 * @throws IOException, SQLException , NullPointerException
	 */
	void updateKeyWordMng(Map<String, String> map)throws IOException, SQLException , NullPointerException;

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
	List<Map<String, String>> selectExistTabList(Map<String, String> map)throws IOException, SQLException , NullPointerException;

	/**
	 * <pre>
	 *  스켸쥴러 조회 
	 *
	 * </pre>
	 * @author : Administrator
	 * @date   : 2016. 6. 7.
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	List<SysMntrVo> selectListSch(SysMntrVo sysVo)throws IOException, SQLException , NullPointerException;

	/**
	 * <pre>
	 * 
	 *
	 * </pre>
	 * @author : Administrator
	 * @date   : 2016. 6. 7.
	 * @param sysMntrVo
	 * @throws IOException, SQLException , NullPointerException
	 */
	void saveSch(SysMntrVo sysMntrVo)throws IOException, SQLException , NullPointerException;
		
}
