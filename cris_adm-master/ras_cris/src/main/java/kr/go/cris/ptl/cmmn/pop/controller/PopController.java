/******************************************************************
 * Copyright RASTECH 2015
 ******************************************************************/
package kr.go.cris.ptl.cmmn.pop.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.Random;

import javax.annotation.Resource;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.commons.utils.CryptoUtil;
import kr.go.cris.ptl.mng.user.service.MngUserService;
import kr.go.cris.ptl.mng.user.vo.PTLLoginVo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * <pre>
 * FileName: PopController.java
 * Package : kr.go.cris.ptl.cmmn.pop.controller
 *
 * 팝업 관련 Controller.
 *
 * </pre>
 * @author : rastech
 * @date   : 2015. 7. 31.
 */
@Controller
public class PopController extends BaseController {

	@Resource
	MngUserService mngUserService;
	
	/**
	 * <pre>
	 * 
	 *
	 * </pre>
	 * @author : Administrator
	 * @date   : 2016. 4. 29.
	 * @return
	 */
	@RequestMapping("/cmmn/pop/loginPop.do")
	public String loginPop() {
		return "login/loginPop";
	}
	
	/**
	 *
	 * <pre>
	 * 사용자 아이디 체크
	 *
	 * </pre>
	 * @author : hjysyj
	 * @date   : 2015. 8. 31.
	 * @param loginid
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@RequestMapping("/login/selectPwdUser.do")
	@ResponseBody
	public String selectIdCheck(PTLLoginVo pTLLoginVo)  throws IOException , SQLException , NullPointerException {
	
		int check = mngUserService.selectUserCnt(pTLLoginVo);
		
		return String.valueOf(check);
	}
	
  
	
	/**
	 * <pre>
	 * 임시비밀번호 발송
	 *
	 * </pre>
	 * @author : Administrator
	 * @date   : 2016. 4. 29.
	 * @return
	 */
	@RequestMapping("/login/sendMail.do")  
	@ResponseBody
	public void sendMail(PTLLoginVo pTLLoginVo) throws IOException , SQLException , NullPointerException  {

		Random rnd =new Random();
		StringBuffer buf =new StringBuffer();
		
		String[] str = new String[]{"~","!","@","#","$","%","^","&","*","(",")"};
		
		// 추가 str
		Random r = new Random(); // setSeed() 함수로 r을 예측 불가능한 long 타입 설정 
    	r.setSeed(new Date().getTime()); // 난수 생성    	
    	int idx = (r.nextInt(9)%6);
    	int idx2 = (r.nextInt(11)%6);
		// end 
    	
	//	int add_idx = (int)((r.nextInt(9)%6));
    	int add_idx = (int)(idx);
		for(int i=0;i<8;i++){
			if(i == add_idx){
				//buf.append(str[(int)(Math.random()*10)]);
				buf.append(str[(int)(idx2)]);
			}
		    if(rnd.nextBoolean()){
		        buf.append((char)((int)(rnd.nextInt(26))+97));
		    }else{
		        buf.append((rnd.nextInt(10))); 
		    }
		}

		pTLLoginVo.setPassword(CryptoUtil.encrypt(buf.toString()));
		

		//PTLLoginVo.setPassword(Utils.passwordEncryption(buf.toString(), emplyrkey, sha2));
	
			mngUserService.updateChgPwd(pTLLoginVo);
		

	}
	
	/**
	 * <pre>
	 * 인증번호 발송
	 *
	 * </pre>
	 * @author : Administrator
	 * @date   : 2016. 4. 29.
	 * @return
	 */
	@RequestMapping("/login/sendNum.do")
	@ResponseBody
	public String sendNum(PTLLoginVo pTLLoginVo) throws IOException , SQLException , NullPointerException {
		
		Random rnd =new Random();
		StringBuffer buf =new StringBuffer();
		for(int i=0;i<4;i++){
			buf.append((rnd.nextInt(10))); 
		}

		//PTLLoginVo.setPassword(CryptoUtil.encrypt(buf.toString()));
	//	System.out.println(buf.toString());
		
		return buf.toString();
	}

}
