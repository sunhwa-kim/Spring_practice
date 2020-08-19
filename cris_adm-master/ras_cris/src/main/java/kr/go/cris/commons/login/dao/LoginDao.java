package kr.go.cris.commons.login.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.go.cris.commons.login.vo.UserVo;
import kr.go.cris.ptl.mng.user.vo.PTLLoginVo;

import org.springframework.stereotype.Repository;

/**
 *
 * <pre>
 * FileName: LoginDao.java
 * Package : kr.go.cris.commons.login.dao
 *
 * 로그인 DAO interface.
 *
 * </pre>
 * @author : rastech
 * @date   : 2015. 1. 23.
 */
@Repository
public interface LoginDao {

    /**
     *
     * <pre>
     * 사용자 관리 - 사용자 아이디 체크
     *
     * </pre>
     * @author : sbkang
     * @date   : 2015. 8. 31.
     * @param loginid
     * @return
     */
	public int selectIdCheck(String loginid) throws IOException, SQLException , NullPointerException;


	/**
	 * <pre>
	 * 사용자 관리 - 사용자 가입
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 2. 23.
	 * @param PTLLoginVo
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public Boolean insertUser(PTLLoginVo pTLLoginVo) throws IOException, SQLException , NullPointerException;


	/**
	 *
	 * <pre>
	 * 사용자 로그인 id 체크
	 *
	 * </pre>
	 * @author : sbkang
	 * @date   : 2015. 8. 31.
	 * @param loginid
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public UserVo selectUser(String loginid) throws IOException, SQLException , NullPointerException;


	/**
	 *
	 * <pre>
	 * 사용자 권한 조회.
	 *
	 * </pre>
	 * @author : rastech
	 * @date   : 2015. 9. 22.
	 * @param loginid
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public List<String> selectUserAuthList(String loginid) throws IOException, SQLException , NullPointerException;

	/**
	 *
	 * <pre>
	 * 사용자 URL 접속 권한 목록.
	 *
	 * </pre>
	 * @author : rastech
	 * @date   : 2015. 9. 30.
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public List<Map<String, String>> selectUrlAuthList() throws IOException, SQLException , NullPointerException;

	/**
	 *
	 * <pre>
	 * 사용자 상태를 이메일 승인 상태로 변경한다.
	 *
	 * </pre>
	 * @author : rastech
	 * @date   : 2015. 10. 16.
	 * @param loginid
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void updateConfirmEmail(String loginid) throws IOException, SQLException , NullPointerException;


	/**
	 *
	 * <pre>
	 * 사용자 로그인정보 등록
	 *
	 * </pre>
	 * @author : rastech
	 * @date   : 2015. 10. 16.
	 * @param loginid
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void insertStatLogin(String user_id) throws IOException, SQLException , NullPointerException;

	
	
	/**
	 * <pre>
	 * 핸드폰 중복 체크 
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 2. 
	 * @param vo
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public UserVo selectMbtl(String mbtlNum) throws IOException, SQLException , NullPointerException;
	
}
