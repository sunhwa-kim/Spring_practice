package kr.go.cris.ptl.member.regi.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.go.cris.commons.login.vo.UserVo;
import kr.go.cris.ptl.member.inform.vo.PtlInformVo;
import kr.go.cris.ptl.member.regi.vo.PtlEmplyrVo;

/**
 * <pre>
 * PTL_EMPLYR Service interface 구현
 * 
 * </pre>
 * @FileName : PtlEmplyrService.java
 * @package  : kr.go.cris.ptl.member.regi.service
 * @author   : user
 * @date     : 2018. 7. 4.
 * 
 */
public interface PtlEmplyrService {



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
	 * 회원가입을 수행한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 2. 
	 * @param ptlEmplyrVo
	 * @param ptlInformVo
	 * @param userVo
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public String addPtlEmplyr(PtlEmplyrVo ptlEmplyrVo, PtlInformVo ptlInformVo, UserVo userVo) throws IOException, SQLException , NullPointerException;
	
	
	/**
	 * <pre>
	 * 기관정보 목록을 조회한다
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 5. 
	 * @param paramMap
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public List<Map<String, Object>> selectInsttsnTblList(Map<String, Object> paramMap) throws IOException, SQLException , NullPointerException;
	
	
	/**
	 * <pre>
	 * 기관정보 총 갯수를 조회한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 5. 
	 * @param paramMap
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public int selectInsttsnTblListTotCnt(Map<String, Object> paramMap) throws IOException, SQLException , NullPointerException;
	
	
	
	
	/**
	 * <pre>
	 * ID/PW찾기
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 12. 
	 * @param ptlEmplyrVo
	 * @param userVo
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public String searchEmplyr(PtlEmplyrVo ptlEmplyrVo, UserVo userVo) throws IOException, SQLException , NullPointerException;
	
	
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
	  * 회원정보를 수정한다.
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 3. 22.
	  * @param ptlInformVo
	  * @param ptlEmplyrVo
	  * @param userVo
	  * @return
	  * @throws IOException, SQLException , NullPointerException
	  */
	public String infoMemberEdit(PtlInformVo ptlInformVo, PtlEmplyrVo ptlEmplyrVo, UserVo userVo) throws IOException, SQLException , NullPointerException;
	
	
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
	  * 비밀번호 변경을 수행한다.
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 3. 23.
	  * @param ptlEmplyrVo
	  * @param userVo
	  * @param rpassword
	  * @return
	  * @throws IOException, SQLException , NullPointerException
	  */
	public String updatePtlEmplyrPW(PtlEmplyrVo ptlEmplyrVo, UserVo userVo, String rpassword) throws IOException, SQLException , NullPointerException;
	
	
	/**
	  * <pre>
	  * 
	  * 회원탈퇴를 수행한다.
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 3. 23.
	  * @param ptlEmplyrVo
	  * @param userVo
	  * @param ptlInformVo
	  * @return
	  * @throws IOException, SQLException , NullPointerException
	  */
	public String deleteAccount(PtlEmplyrVo ptlEmplyrVo, UserVo userVo, PtlInformVo ptlInformVo) throws IOException, SQLException , NullPointerException;
	
	
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

}
