package kr.go.cris.ptl.member.regi.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.go.cris.ptl.member.regi.vo.PtlEmplyrVo;

import org.springframework.stereotype.Repository;

/**
 * <pre>
 * PTL_EMPLYR Dao interface 구현
 * 
 * </pre>
 * @FileName : PtlEmplyrDao.java
 * @package  : kr.go.cris.ptl.member.regi.dao
 * @author   : user
 * @date     : 2018. 7. 4.
 * 
 */
@Repository
public interface PtlEmplyrDao {


	/**
	 * <pre>
	 *
	 * PTL_EMPLYR을 등록한다.
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 2. 
	 * @param PtlEmplyrVo
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void insertPtlEmplyr(PtlEmplyrVo ptlEmplyrVo) throws IOException, SQLException , NullPointerException;
	
	
	/**
	 * <pre>
	 *
	 * 기관정보 목록을 조회한다.
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 5. 
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public List<Map<String, Object>> selectInsttsnTblList(Map<String, Object> paramMap) throws IOException, SQLException , NullPointerException;
	
	/**
	 * <pre>
	 *
	 * 기관정보 총 갯수를 조회한다.
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 5. 
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public int selectInsttsnTblListTotCnt(Map<String, Object> paramMap) throws IOException, SQLException , NullPointerException;
	
	
	
	/**
	 * <pre>
	 * PTL_EMPLYR PW를 수정한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 12. 
	 * @param ptlEmplyrVo
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void updatePtlEmplyrPW(PtlEmplyrVo ptlEmplyrVo) throws IOException, SQLException , NullPointerException;

	
	/**
	  * <pre>
	  * 
	  * PTL_EMPLYR을 수정한다.
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 3. 22.
	  * @param ptlEmplyrVo
	  * @throws IOException, SQLException , NullPointerException
	  */
	public void updatePtlEmplyr(PtlEmplyrVo ptlEmplyrVo) throws IOException, SQLException , NullPointerException;

	
	/**
	  * <pre>
	  * 
	  * PTL_EMPLYR을 수정한다.(초기화)
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 3. 23.
	  * @param ptlEmplyrVo
	  * @throws IOException, SQLException , NullPointerException
	  */
	public void deletePtlEmplyr(PtlEmplyrVo ptlEmplyrVo) throws IOException, SQLException , NullPointerException;

	/**
	  * <pre>
	  * 
	  * PtlUser을 수정한다.
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 3. 22.
	  * @param ptlEmplyrVo
	  * @throws IOException, SQLException , NullPointerException
	  */
	public void updatePtlUserPW(PtlEmplyrVo ptlEmplyrVo)throws IOException, SQLException , NullPointerException;
	
	
	
}
