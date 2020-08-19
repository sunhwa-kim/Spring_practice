package kr.go.cris.ptl.member.inform.dao;

import java.io.IOException;
import java.sql.SQLException;

import kr.go.cris.ptl.member.inform.vo.PtlInformVo;

import org.springframework.stereotype.Repository;

/**
 * <pre>
 *  회원정보 Dao
 * 
 * </pre>
 * @FileName : PtlInformDao.java
 * @package  : kr.go.cris.ptl.member.inform.dao
 * @author   : wonki0138
 * @date     : 2018. 3. 2.
 * 
 */
@Repository
public interface PtlInformDao {


	/**
	 * <pre>
	 * 회원정보를 등록한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 2. 
	 * @param ptlEmplyrVo
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void insertInform(PtlInformVo ptlInformVo) throws IOException, SQLException , NullPointerException;
	
	/**
	  * <pre>
	  * 
	  * 회원정보Cnt를 조회한다.
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 3. 21.
	  * @param ptlInformVo
	  * @return
	  * @throws IOException, SQLException , NullPointerException
	  */
	public int selectInformDetailCnt(PtlInformVo ptlInformVo) throws IOException, SQLException , NullPointerException;
	
	/**
	  * <pre>
	  * 
	  * 회원정보를 조회한다.
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 3. 22.
	  * @param ptlInformVo
	  * @return
	  * @throws IOException, SQLException , NullPointerException
	  */
	public PtlInformVo selectInformDetail(PtlInformVo ptlInformVo) throws IOException, SQLException , NullPointerException;
	
	/**
	  * <pre>
	  * 
	  * 회원정보를 수정한다.
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 3. 22.
	  * @param ptlInformVo
	  * @param userVo
	  * @throws IOException, SQLException , NullPointerException
	  */
	public void updateInformCn(PtlInformVo ptlInformVo) throws IOException, SQLException , NullPointerException;
	
	
		
	
}
