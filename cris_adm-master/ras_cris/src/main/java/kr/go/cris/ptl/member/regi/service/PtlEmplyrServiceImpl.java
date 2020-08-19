package kr.go.cris.ptl.member.regi.service;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.commons.login.service.LoginService;
import kr.go.cris.commons.login.vo.UserVo;
import kr.go.cris.commons.utils.Utils;
import kr.go.cris.ptl.member.inform.service.PtlInformService;
import kr.go.cris.ptl.member.inform.vo.PtlInformVo;
import kr.go.cris.ptl.member.regi.dao.PtlEmplyrDao;
import kr.go.cris.ptl.member.regi.vo.PtlEmplyrVo;


import kr.go.cris.sms.service.MsgDataService;
import kr.go.cris.sms.vo.MsgDataVO;

import org.springframework.stereotype.Service;

/**
 * <pre>
 * PTL_EMPLYR ServiceImpl 로직 구현
 * 
 * </pre>
 * @FileName : PtlEmplyrServiceImpl.java
 * @package  : kr.go.cris.ptl.member.regi.service
 * @author   : user
 * @date     : 2018. 7. 4.
 * 
 */
@Service
public class PtlEmplyrServiceImpl extends BaseServiceImpl implements PtlEmplyrService {

	@Resource(name="ptlEmplyrDao")
	private PtlEmplyrDao ptlEmplyrDao;
    
    @Resource
    private PtlInformService ptlInformService;
    
    @Resource
	private LoginService loginService;
    
    @Resource
	private MsgDataService msgDataService;

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
	@Override
	public void insertPtlEmplyr(PtlEmplyrVo ptlEmplyrVo) throws IOException, SQLException , NullPointerException {
		// TODO Auto-generated method stub
		ptlEmplyrDao.insertPtlEmplyr(ptlEmplyrVo);
	}



	/**
	 * <pre>
	 *  회원가입 수행한다.
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
	@Override
	public String addPtlEmplyr(PtlEmplyrVo ptlEmplyrVo, PtlInformVo ptlInformVo, UserVo userVo) throws IOException, SQLException , NullPointerException {
	   	
		//로그인 키
	   	String emplyrkey = null;
	   	String message="";
	   	String loginid = null;
	   	String mbtlNum = null;
	   	String tmp =null;
	   	
	   	UserVo chkUser = null;
	   	
	    loginid = ptlEmplyrVo.getUser_id();
	   	//01. 사용자DB에 있는지 확인
	    
	    chkUser = new UserVo();
	    chkUser = loginService.selectUser(loginid);
		
	    //01.1 핸드폰중복 체크
	    mbtlNum = userVo.getMbtlnum();
		
		UserVo resultVO_check = loginService.selectMbtl(mbtlNum);
		
		if(resultVO_check != null){
			 tmp = resultVO_check.getEmplyrkey();		
		}
		
		if (chkUser == null) {
			emplyrkey = tmp;
		}
	   	
	   	if (emplyrkey == null) {  //  회원가입가능
	   		
			 //emplyrkey생성
			long time = System.currentTimeMillis(); 
			SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmssSSS"); 
			String strDT = dayTime.format(new Date(time)); 
			emplyrkey = strDT;
			
			ptlEmplyrVo.setEmplyrkey(emplyrkey);
			ptlInformVo.setUser_id(emplyrkey);
			
			//패스워드암호화
			String sha2 = "Y";
			String password=ptlEmplyrVo.getPassword();
			password = Utils.passwordEncryption(password, emplyrkey, sha2);//패스워드 암호화
			
			ptlEmplyrVo.setPassword(password);
			ptlInformVo.setAcCode(password);
	
			
			//직원인지 구분 - 기관이 질병관리본부이면 직원
			if (ptlEmplyrVo.getInstttyid() != null && ptlEmplyrVo.getInstttyid()== 1) {  //ptlEmplyrVO.getInstttyid().intValue()		
				ptlEmplyrVo.setClassify("03");
			} else {	
				ptlEmplyrVo.setClassify("01");
			}	
			
			//실명인증여부
			ptlEmplyrVo.setMbtlnum_yn("N");  //실명인증모듈탑재시 Y
			//암호화방식
			ptlEmplyrVo.setSha2("Y");
	           //이메일 주소 세팅
			ptlInformVo.setEmail(ptlInformVo.getEmail1()+"@"+ptlInformVo.getEmail2());
			
			//이메일수신여부 세팅
			if (ptlInformVo.getNewDataYn().equals("1")) {
				ptlInformVo.setEmailAgree("1");
			} else {
				ptlInformVo.setEmailAgree("0");
			}	
			
			//Ageagree 2016.10.26 수정 - gjchoi
			Calendar current = Calendar.getInstance();
			int currentYear  = current.get(Calendar.YEAR);
			int currentMonth = current.get(Calendar.MONTH) + 1;
			int currentDay   = current.get(Calendar.DAY_OF_MONTH);
			    
			int birthYear = Integer.parseInt(ptlInformVo.getBrthdy().substring(0, 4));
			int birthMonth = Integer.parseInt(ptlInformVo.getBrthdy().substring(3, 6));
			int birthDay = Integer.parseInt(ptlInformVo.getBrthdy().substring(6, 8));
			int age = currentYear - birthYear;
			// 생일 안 지난 경우 -1
			if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay){
				age--;
			}
			 //만 16세이상 값을 비교하여 이상이면 Y 미만이면 N 이다.
			if(age >= 16) {
				ptlInformVo.setAgeAgree("Y");
			} else {
				ptlInformVo.setAgeAgree("N");
			}
			
				//02. 사용자 DB 등록
			this.insertPtlEmplyr(ptlEmplyrVo);
			
			//03. 사용자 부가정보 DB 등록
			//informService.insertInformDetail(informManageVO); 
			ptlInformService.insertInform(ptlInformVo);		
			
			message="Y";
								    
			
	   	} else { //중복가입회원
	   		
	   		if (tmp != null) {
	   	
	   			message="PHONE";	
	   			
	   		} else {     		

	   			message="ID";
	   			
	   		}		
	   	}
	   	
	   	return message;    
	}



	
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
	@Override
	public List<Map<String, Object>> selectInsttsnTblList(Map<String, Object> paramMap) throws IOException, SQLException , NullPointerException {
		return ptlEmplyrDao.selectInsttsnTblList(paramMap);
	}



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
	@Override
	public int selectInsttsnTblListTotCnt(Map<String, Object> paramMap) throws IOException, SQLException , NullPointerException {
		return ptlEmplyrDao.selectInsttsnTblListTotCnt(paramMap);
	}



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
	@Override
	public String searchEmplyr(PtlEmplyrVo ptlEmplyrVo, UserVo userVo) throws IOException, SQLException , NullPointerException {
		//로그인 키
	   	String emplyrkey = null;
	   	String message="";
	   	String loginid = null;
	   	String mbtlNum = null;
	   	String tmp =null;
	   	UserVo chkUser = null;
		
		// 01. 전화번호로 회원확인
	    mbtlNum = userVo.getMbtlnum();
		UserVo resultVO_check = loginService.selectMbtl(mbtlNum);
		emplyrkey = resultVO_check.getEmplyrkey();
		
		if (emplyrkey == null) {  //  회원정보 없음.
			message="N";
		}else {
			// 02. 회원ID가져오기
			String loginID = resultVO_check.getLoginid();
			
			// 03. 회원 패스워드 초기화
			String sha2 = "Y";
			String pp = randomPW(); 
			String sendPpassword = pp; 
			pp = Utils.passwordEncryption(pp, emplyrkey, sha2);//패스워드 암호화
			
			// 04. 초기화된 패스워드 입력
			ptlEmplyrVo.setEmplyrkey(emplyrkey);
			ptlEmplyrVo.setPassword(pp);
			this.updatePtlEmplyrPW(ptlEmplyrVo);
			
			this.updatePtlUserPW(ptlEmplyrVo);
			
			// 05. SMS발송
			MsgDataVO msgDataVO = new MsgDataVO();
			msgDataVO.setCallTo(userVo.getMbtlnum().replaceAll("-", ""));
			msgDataVO.setSmsTxt("회원님의 library.nih.go.kr ID/PW는 "+loginID+"/"+sendPpassword+" 입니다.");
			msgDataService.insertMsgData(msgDataVO);		
			message="Y";
		}
		
		return message;
	}
	
	private void updatePtlUserPW(PtlEmplyrVo ptlEmplyrVo)  throws IOException, SQLException , NullPointerException {
		ptlEmplyrDao.updatePtlUserPW(ptlEmplyrVo);
	}



	public String randomPW() throws IOException, SQLException , NullPointerException{
		Random rnd =new Random();
		StringBuffer buf = new StringBuffer();
		String password = null;
		for(int i=0;i<4;i++){
		    if(rnd.nextBoolean()){
		        buf.append((char)((int)(rnd.nextInt(26))+97));
		    }else{
		        buf.append((rnd.nextInt(10)));
		    }
		}
		password = String.valueOf(buf);
		return password;
	}


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
	@Override
	public void updatePtlEmplyrPW(PtlEmplyrVo ptlEmplyrVo) throws IOException, SQLException , NullPointerException {
		ptlEmplyrDao.updatePtlEmplyrPW(ptlEmplyrVo);
	}
	
	
	
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
	@Override
	public String infoMemberEdit(PtlInformVo ptlInformVo, PtlEmplyrVo ptlEmplyrVo, UserVo userVo) throws IOException, SQLException , NullPointerException{
		String message="";
		String emplyrkey = userVo.getEmplyrkey();
		ptlInformVo.setUser_id(emplyrkey);
		ptlEmplyrVo.setEmplyrkey(emplyrkey);
		
		 // 설정
		//직원인지 구분 - 기관이 질병관리본부이면 직원
		if (ptlEmplyrVo.getInstttyid() != null && ptlEmplyrVo.getInstttyid()== 1) { //ptlEmplyrVO.getInstttyid().intValue()		
			ptlEmplyrVo.setClassify("03");
		} else {	
			ptlEmplyrVo.setClassify("01");
		}	
		
		//실명인증여부
		//ptlEmplyrVO.setMbtlnumYn("N");  //실명인증모듈탑재시 Y
	
		//이메일 주소 세팅
		ptlInformVo.setEmail(ptlInformVo.getEmail1()+"@"+ptlInformVo.getEmail2());
				
		//이메일수신여부 세팅
		if (ptlInformVo.getNewDataYn().equals("1")) {
			ptlInformVo.setEmailAgree("1");
		} else {
			ptlInformVo.setEmailAgree("0");
		}	
		
		// 사용자 DB 등록
		this.updatePtlEmplyr(ptlEmplyrVo);
		
		// 사용자 부가정보 DB 등록
		ptlInformService.updateInformCn(ptlInformVo);	
		
		message="Y";
		
		return message;
	}
	
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
	@Override
	public void updatePtlEmplyr(PtlEmplyrVo ptlEmplyrVo) throws IOException, SQLException , NullPointerException{
		ptlEmplyrDao.updatePtlEmplyr(ptlEmplyrVo);
	}
	
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
	@Override
	public String updatePtlEmplyrPW(PtlEmplyrVo ptlEmplyrVo, UserVo userVo, String rpassword) throws IOException, SQLException , NullPointerException{
		String message="";
		String emplyrkey = userVo.getEmplyrkey();
		ptlEmplyrVo.setEmplyrkey(emplyrkey);
		
		// 패스워드 확인
		String password = ptlEmplyrVo.getPassword();
		
		String password2 = userVo.getPassword();	
		//비밀번호 검증
		String sha2 = userVo.getSha2();
		rpassword = Utils.passwordEncryption(rpassword, emplyrkey, sha2);//패스워드 암호화
		
		if (rpassword.equals(password2)) {
			// 회원 패스워드 암호화
			password = Utils.passwordEncryption(password, emplyrkey, sha2);
			// 암호화된 패스워드 입력
			ptlEmplyrVo.setEmplyrkey(emplyrkey);
			ptlEmplyrVo.setPassword(password);
			
			ptlEmplyrDao.updatePtlEmplyrPW(ptlEmplyrVo);
			
			message="Y";
		 } else {
			
	        message="N";
		 }
			return message;
	}
	
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
	@Override
	public String deleteAccount(PtlEmplyrVo ptlEmplyrVo, UserVo userVo, PtlInformVo ptlInformVo) throws IOException, SQLException , NullPointerException{
		String message="";
		
		String emplyrkey = userVo.getEmplyrkey();
		
		ptlInformVo.setUser_id(emplyrkey);
		ptlEmplyrVo.setEmplyrkey(emplyrkey);
		
		//패스워드 확인
		String password = ptlEmplyrVo.getPassword();
		String password2 = userVo.getPassword();
		
		//비밀번호 검증
		String sha2 = userVo.getSha2();
		password = Utils.passwordEncryption(password, emplyrkey, sha2);//패스워드 암호화
		
		if (password.equals(password2)) {
		    // 회원정보삭제
			this.deletePtlEmplyr(ptlEmplyrVo);
			// 부가정보 사용자 삭제
    		ptlInformService.updateInformCn(ptlInformVo);
    		message="Y";
        } else {
        	message="N"; 
        }
		return message;
	}
	
	
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
	@Override
	public void deletePtlEmplyr(PtlEmplyrVo ptlEmplyrVo) throws IOException, SQLException , NullPointerException{
		ptlEmplyrDao.deletePtlEmplyr(ptlEmplyrVo);
	}
	
}
