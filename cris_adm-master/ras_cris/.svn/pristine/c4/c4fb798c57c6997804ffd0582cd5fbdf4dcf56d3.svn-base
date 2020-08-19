package kr.go.cris.commons.login.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Map;

import kr.go.cris.commons.login.vo.UserVo;
import kr.go.cris.ptl.mng.user.vo.PTLLoginVo;

import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.util.matcher.RequestMatcher;

/**
 *
 * <pre>
 * FileName: LoginService.java
 * Package : kr.go.cris.commons.login.service
 *
 * 로그인 Service interface.
 *
 * </pre>
 * @author : rastech
 * @date   : 2015. 1. 23.
 */
public interface LoginService {

	/**
	 *
	 * <pre>
	 * 사용자 관리 - 아이디 체크
	 *
	 * </pre>
	 * @author : sbkang
	 * @date   : 2015. 8. 31.
	 * @param loginid
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public int selectIdCheck(String loginid) throws IOException, SQLException , NullPointerException ;


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
	public UserVo selectUser(String loginid)  throws IOException, SQLException , NullPointerException ;

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
	public Map<RequestMatcher, Collection<ConfigAttribute>> listUrlAuth() throws IOException, SQLException , NullPointerException;

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
	 * <pre>
	 * 사용자관리 - 사용자 등록
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 2. 23.
	 * @param PTLLoginVo
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public boolean insertUser(PTLLoginVo pTLLoginVo) throws IOException, SQLException , NullPointerException;
	
	/**
	 * 로그인 정보를 등록한다.
	 * 
	 * @param vo
	 * @exception Exception
	 */
	public void insertStatLogin(String user_id) throws IOException, SQLException , NullPointerException;	
	
	
	
	/**
	 * <pre>
	 *
	 * 핸드폰 중복 체크 
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 2. 
	 * @param vo
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public UserVo selectMbtl(String mbtlNum) throws IOException, SQLException , NullPointerException;

}
