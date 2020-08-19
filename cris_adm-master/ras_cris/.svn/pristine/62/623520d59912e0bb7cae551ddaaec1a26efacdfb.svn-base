package kr.go.cris.commons.login.service;


import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.commons.login.dao.LoginDao;
import kr.go.cris.commons.login.vo.UserVo;
import kr.go.cris.commons.utils.CryptoUtil;
import kr.go.cris.ptl.mng.user.vo.PTLLoginVo;

import org.apache.commons.lang3.StringUtils;
import org.bouncycastle.crypto.InvalidCipherTextException;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.stereotype.Service;

/**
 * <pre>
 * FileName: LoginServiceImpl.java
 * Package : kr.go.cris.commons.login.service
 * 로그인 Service impl.
 * 
 *
 * </pre>
 * @author : sejin
 * @date   : 2016. 2. 23.
 */
@Service
public class LoginServiceImpl extends BaseServiceImpl implements LoginService {

    @Resource
    private LoginDao loginDao;

	/* (비Javadoc)
	 * @see kr.go.cris.commons.login.service.LoginService#selectIdCheck(java.lang.String)
	 */
	public int selectIdCheck(String loginid) throws IOException, SQLException , NullPointerException{
		return loginDao.selectIdCheck(loginid);
	}

	/* (비Javadoc)
	 * @see kr.go.cris.commons.login.service.LoginService#selectUser(java.lang.String)
	 */
	public UserVo selectUser(String loginid)  throws IOException, SQLException , NullPointerException {
		UserVo userVo = loginDao.selectUser(loginid);
		if (userVo != null) {
			List<String> list = loginDao.selectUserAuthList(loginid);
			if (list == null || list.isEmpty()) {
				list = new ArrayList<String>();
				list.add("ROLE_GUEST");
				list.add("ROLE_USER");
			}
			userVo.setAuth(list);
		}
		return userVo;
	}


	/* (비Javadoc)
	 * @see kr.go.cris.commons.login.service.LoginService#listUrlAuth()
	 */
	public Map<RequestMatcher, Collection<ConfigAttribute>> listUrlAuth() throws IOException, SQLException , NullPointerException {
		List<Map<String, String>> list = loginDao.selectUrlAuthList();
		
		Map<RequestMatcher, Collection<ConfigAttribute>> requestMap = new LinkedHashMap<RequestMatcher, Collection<ConfigAttribute>>();

		String preUrl = null;
		String url = null;
		Collection<ConfigAttribute> configList = null;
		for(Map<String, String> map: list) {
			url = map.get("URL");
			if (StringUtils.equals(url, preUrl)) {
				configList.add(new SecurityConfig(map.get("ROLE")));
			} else {
				if (configList != null){ requestMap.put(new AntPathRequestMatcher(preUrl), configList);}
				configList = new LinkedList<ConfigAttribute>();
				configList.add(new SecurityConfig(map.get("ROLE")));
			}
			preUrl = url;
		}
		if (list != null && !list.isEmpty()) {requestMap.put(new AntPathRequestMatcher(preUrl), configList);}

		return requestMap;
	}


	/* (비Javadoc)
	 * @see kr.go.cris.commons.login.service.LoginService#updateConfirmEmail(java.lang.String)
	 */
	public void updateConfirmEmail(String loginid) throws IOException, SQLException , NullPointerException {
		loginDao.updateConfirmEmail(loginid);
	}


	/* (비Javadoc)
	 * @see kr.go.cris.commons.login.service.LoginService#insertUser(kr.go.cris.ptl.mng.user.vo.PTLLoginVo)
	 */
	public boolean insertUser(PTLLoginVo pTLLoginVo)  throws IOException, SQLException , NullPointerException {

		String hashPw = CryptoUtil.hashSHA(pTLLoginVo.getPassword());
		if ("encodingFail".equals(hashPw)) {
			try {
				throw new InvalidCipherTextException("비밀번호 해쉬함수 오류!!!");
			} catch (InvalidCipherTextException e) {
				logger.debug("비밀번호 해쉬함수 오류!!!");
			}
		} else {
			pTLLoginVo.setPassword(hashPw);
		}
		// DB에 저장하기 위하여 다시 AES로 암호화 한다.
		pTLLoginVo.encryptAES();
		boolean result = loginDao.insertUser(pTLLoginVo);

		return result;
	}

	/* (non-Javadoc)
	 * @see kr.go.cris.commons.login.service.LoginService#insertStatLogin(java.lang.String)
	 */
	@Override
	public void insertStatLogin(String user_id) throws IOException, SQLException , NullPointerException {
		loginDao.insertStatLogin(user_id);
	}

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
	@Override
	public UserVo selectMbtl(String mbtlNum) throws IOException, SQLException , NullPointerException {

		
			return loginDao.selectMbtl(mbtlNum);

	}
}
