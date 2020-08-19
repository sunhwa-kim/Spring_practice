/******************************************************************
 * Copyright RASTECH 2015
 ******************************************************************/
package kr.go.cris.ptl.cmmn.util.controller;

import java.io.IOException;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.RSAPublicKeySpec;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.commons.constants.Constants;
import kr.go.cris.commons.login.vo.UserVo;
import kr.go.cris.commons.menu.service.MenuService;
import kr.go.cris.commons.menu.vo.MenuVo;
import kr.go.cris.commons.utils.CryptoUtil;
import kr.go.cris.commons.utils.XmlUtil;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * <pre>
 * FileName: UtilController.java
 * Package : kr.go.cris.ptl.cmmn.util.controller
 *
 * 유틸성 컨트롤러 객체.
 *
 * </pre>
 * @author : rastech
 * @date   : 2015. 7. 28.
 */
@Controller
public class UtilController extends BaseController {

	@Resource
	private MenuService menuService;

	/**
	 *
	 * <pre>
	 *    통계지표찾기    자동완성
	 * </pre>
	 *
	 * @author :
	 * @date : 2015. . .
	 * @param
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/cmmn/util/autocomplete.xml", produces="application/xml; charset=utf-8")
	@ResponseBody
	public String autocomplete() throws IOException , SQLException , NullPointerException {
		UserVo userVo = getUser();
		List<MenuVo> list = menuService.listAutocomplete(userVo);
		return XmlUtil.listToXml(list);
	}

	/**
	 *
	 * <pre>
	 * RSA KeyPair를 생성하여 개인키는 세션에 공개키는 XML로 출력한다.
	 *
	 * RSA를 사용한 서버-클라이언트 암복호화 절차
     * 절차 : 1. RSA KeyPair 생성(서버)
     *     -> 2. session에 개인키 저장(서버)
     *     -> 3. XML로 공개키 출력(서버)
     *     -> 4. Web page에서 공개키로 정보 암호화(클라이언트)
     *     -> 5. 저장페이지에서 session의 개인키로 복호화(서버)
	 *
	 * </pre>
	 * @author : rastech
	 * @date   : 2015. 11. 13.
	 * @param sessionKey
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/cmmn/util/getRSAKey.xml", produces="application/xml; charset=utf-8")
	@ResponseBody
	public String getRSAKey(String sessionKey, HttpSession session) {
		
		StringBuffer xml = new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n");
		try {
			KeyPair keyPair = null;
			try {
				keyPair = CryptoUtil.genRASKey();
			} catch (NoSuchAlgorithmException e) {
	         	logger.debug("ERROR getRSAKey NoSuchAlgorithmException");
			}
			KeyFactory keyFactory = null;
			try {
				keyFactory = KeyFactory.getInstance("RSA");
			} catch (NoSuchAlgorithmException e) {
			 	logger.debug("ERROR getRSAKey NoSuchAlgorithmException");
			}

			PublicKey publicKey = keyPair.getPublic();
			PrivateKey privateKey = keyPair.getPrivate();
			if (StringUtils.equals(Constants.RSA_KEY_LGIN, sessionKey)
			 || StringUtils.equals(Constants.RSA_KEY_MODI, sessionKey)
			 || StringUtils.equals(Constants.RSA_KEY_REGI, sessionKey)
			 || StringUtils.equals(Constants.RSA_KEY_UPDT, sessionKey)
			 || StringUtils.equals(Constants.RSA_KEY_DEL, sessionKey)) {
				session.setAttribute(sessionKey, privateKey);
			} else {
				throw new InvalidKeySpecException("세션키 값 오류!!!");
				
			}


			RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);

			String publicKeyModulus = publicSpec.getModulus().toString(16);
			String publicKeyExponent = publicSpec.getPublicExponent().toString(16);

			xml.append("<root>\r\n");
			xml.append("  <msg>success</msg>\r\n");
			xml.append("  <publicKeyModulus><![CDATA[");
			xml.append(publicKeyModulus);
			xml.append("]]></publicKeyModulus>\r\n");
			xml.append("  <publicKeyExponent><![CDATA[");
			xml.append(publicKeyExponent);
			xml.append("]]></publicKeyExponent>\r\n");
			xml.append("</root>");
		} catch(InvalidKeySpecException  e) {
			if (logger.isErrorEnabled()){ logger.debug("err getRSAKey");}
			xml.append("<root>");
			xml.append("  <msg>fault</msg>\r\n");
			xml.append("</root>");
		}

		return xml.toString();
	}
}
