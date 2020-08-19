package kr.go.cris.ptl.member.regi.controller;

import java.io.IOException;
import java.io.Writer;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.commons.login.service.LoginService;
import kr.go.cris.commons.login.vo.UserVo;
import kr.go.cris.commons.utils.XmlUtil;
import kr.go.cris.ptl.member.inform.service.PtlInformService;
import kr.go.cris.ptl.member.inform.vo.PtlInformVo;
import kr.go.cris.ptl.member.regi.service.PtlEmplyrService;
import kr.go.cris.ptl.member.regi.vo.PtlEmplyrVo;
import kr.go.cris.ptl.mng.code.vo.MngCodeVo;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

  
/**
 * <pre>
 * PTL_EMPLYR Controller 구현
 * 
 * </pre>
 * @FileName : PtlEmplyrController.java
 * @package  : kr.go.cris.ptl.member.regi.controller
 * @author   : user
 * @date     : 2018. 7. 4.
 * 
 */
@Controller
public class PtlEmplyrController extends BaseController {

    @Resource
    private PtlEmplyrService ptlEmplyrService;
    
    @Resource
    private PtlInformService ptlInformService;
    
    @Resource
	private LoginService loginService;
   
    /**
     * <pre>
     *
     * 회원가입 화면으로 이동한다.
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 2. 28. 
     * @param model
     * @param MemberRegiVo
     * @param request
     * @return
     * @throws IOException, SQLException , NullPointerException
     */
    @RequestMapping("/login/user/writeMember.do")
    public String writeMember(Model model, PtlEmplyrVo memberRegiVo, HttpServletRequest request)  throws IOException, SQLException , NullPointerException {
 
    	String returnUrl = "member/regi/writeMember.tiles";

    	if(isMobile(request)){
    		returnUrl = "member/regi/mwriteMember.tiles";
    	}
    	
    	return returnUrl;
    }


    /**
     * <pre>
     *  id 중복체크를 수행
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 2. 28. 
     * @param loginVO
     * @param model
     * @return
     * @throws IOException, SQLException , NullPointerException
     */
    @RequestMapping("/member/regi/memChk.do")
    @ResponseBody
    public String duplPtlEmplyr(UserVo loginVO, Model model )  throws IOException, SQLException , NullPointerException {
        
    	//로그인 키
    	String emplyrkey = null;
		UserVo userVo = null;
		String loginid = null;
		String memChk = "";
		
		try {
			
			loginid = loginVO.getLoginid();
			if(StringUtils.isNotBlank(loginid)){
				
				
				userVo = loginService.selectUser(loginid);

				if(userVo != null){
					memChk = "Y";				
				}else{
					memChk = "N";
				}				
			}else{
				
				memChk = "F";
			}
			
		} catch (SQLException e) {
			if (logger.isErrorEnabled()){ logger.debug("err SQLException duplPtlEmplyr");}
			throw new BadCredentialsException("DB 접속에 오류가 있습니다.", e);
		}catch (BadCredentialsException e) {
			if (logger.isErrorEnabled()){ logger.debug("err  BadCredentialsException duplPtlEmplyr");}
			throw new BadCredentialsException("DB 접속에 오류가 있습니다.", e);
		}
		
	
        return memChk;
    	
    }	
	
    
    
   
       /**
     * <pre>
     *
     *  회원등록을 수행한다.
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 2. 
     * @param ptlEmplyrVo
     * @param ptlInformVo
     * @param userVo
     * @return
     * @throws IOException, SQLException , NullPointerException
     */
    @RequestMapping("/member/regi/addPtlEmplyr.do")
    @ResponseBody
   public String addPtlEmplyr( PtlEmplyrVo ptlEmplyrVo, PtlInformVo ptlInformVo, UserVo userVo)  throws IOException, SQLException , NullPointerException {
    
    	String message = null;
    	
    		 message = ptlEmplyrService.addPtlEmplyr(ptlEmplyrVo, ptlInformVo, userVo);
    		 
    		 if(message == null){
    			 message = "F";
    		 }
    	
    	return message;
   }
    
    
   
    /**
     * <pre>
     *
     * 기관조회 - 목록화면이동
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 8. 
     * @param model
     * @param ptlEmplyrVo
     * @param request
     * @return
     * @throws IOException, SQLException , NullPointerException
     */
    @RequestMapping("/member/regi/InsttsnList.do")
    public String insttsnList(Model model, PtlEmplyrVo ptlEmplyrVo, HttpServletRequest request)  throws IOException, SQLException , NullPointerException { 
    	List<MngCodeVo> codeList = getCodeList("ORG_GBN");
		model.addAttribute("org_gbn", codeList);
		
    	return "member/regi/InsttsnList";
    }
    
   
    
    /**
     * <pre>
     *
     * 기관조회 - 목록조회화면
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 5. 
     * @param request
     * @param resp
     * @param out
     * @return
     * @throws IOException, SQLException , NullPointerException
     */
    @RequestMapping("/member/regi/InsttsnRead.do")
    public void insttsnRead(HttpServletRequest request, HttpServletResponse resp, Writer out)  throws IOException, SQLException , NullPointerException {
    	
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	paramMap.put("page", request.getParameter("page"));
    	paramMap.put("searchKeyword", request.getParameter("searchKeyword"));
    	paramMap.put("searchCondition", request.getParameter("searchCondition"));
    	
    	String xml = "";    	
    	
    	int totalCnt = ptlEmplyrService.selectInsttsnTblListTotCnt(paramMap);
    	
    	int nextNum = totalCnt - ((Integer.parseInt(paramMap.get("page").toString()) -1 ) *  10);
    	
    	paramMap.put("nextNum", nextNum);
    	
    	List<Map<String, Object>> list = ptlEmplyrService.selectInsttsnTblList(paramMap);
    	
    	if(list != null){
    		if(list.size() > 0){
    			
    			xml = XmlUtil.listMapToXml(list);
    			/*
    			 * 총카운터 세팅
    			 */
    	    	StringBuffer sb = new StringBuffer();
    	    	String[] str = xml.split("<items>");
    	    	
    	    	sb.append(str[0]);
    	    	sb.append("<items>");
    	    	sb.append("<totalPageCnt>"+Math.ceil((double)totalCnt/(double)10)+"</totalPageCnt>\n");    	 
    	    	sb.append("<totalDataCnt>"+totalCnt+"</totalDataCnt>\n");
    	    	sb.append(str[1]);
    	    	
    	    	xml = sb.toString();
    		}
    	}	
    	resp.setContentType("text/xml");
    	resp.setCharacterEncoding("UTF-8");
    	resp.setHeader("Cache-Control", "no-cache");
    	resp.setHeader("Pragma", "no-cache");
    	resp.setDateHeader("Expires", -1);
    
    	out.write(xml);
   	
    	out.flush();
    	
    }
    
    
    /**
     * <pre>
     *
     * ID/PW - 화면이동
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 14. 
     * @param model
     * @param ptlEmplyrVo
     * @param request
     * @return
     * @throws IOException, SQLException , NullPointerException
     */
    @RequestMapping("/login/user/idpass.do")
    public String selectInsttsnList(Model model, PtlEmplyrVo ptlEmplyrVo, HttpServletRequest request)  throws IOException, SQLException , NullPointerException { 
    	
    	return "member/regi/idpass.tiles";
    }
    
    
    /**
     * <pre>
     *
     * ID/PW 찾기를 수행한다.
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 14. 
     * @param ptlEmplyrVo
     * @param userVo
     * @return
     * @throws IOException, SQLException , NullPointerException
     */
    @RequestMapping("/member/regi/searchEmplyr.do")
    @ResponseBody
    public String searchEmplyr(PtlEmplyrVo ptlEmplyrVo, UserVo userVo)  throws IOException, SQLException , NullPointerException { 
    	
    	String message = null;
    	
    	try{
    		message = ptlEmplyrService.searchEmplyr(ptlEmplyrVo, userVo);
    		if(StringUtils.isBlank(message)){
    			message = "F";
    		}
    	} catch(SQLException e){
    	    message = "F";
    	}
    	
    	return message;
    }
    
    
    /**
     * <pre>
     * 
     * 회원정보변경 화면으로 이동한다.
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 22.
     * @param model
     * @param request
     * @param ptlInformVo
     * @param userVo
     * @return
     * @throws IOException, SQLException , NullPointerException
     */
    @RequestMapping("/member/regi/infoMember.do")
    public String infoMember(Model model, HttpServletRequest request, PtlInformVo ptlInformVo, UserVo userVo)  throws IOException, SQLException , NullPointerException {
    	userVo = getUser();
    	
    	String emplyrkey = userVo.getEmplyrkey();
		ptlInformVo.setUser_id(emplyrkey);
		
		int totalCnt = ptlInformService.selectInformDetailCnt(ptlInformVo);
		if(totalCnt == 0){
			ptlInformService.insertInform(ptlInformVo);
		}
		ptlInformVo = ptlInformService.selectInformDetail(ptlInformVo);
    	
		model.addAttribute("userVo",userVo);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
		model.addAttribute("ptlInformVo",ptlInformVo);
		
    	return "member/regi/infoMember.tiles";
    }
    
    
    /**
     * 
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
    @RequestMapping("/member/regi/infoMemberEdit.do")
    @ResponseBody
    public String infoMemberEdit(PtlInformVo ptlInformVo, PtlEmplyrVo ptlEmplyrVo, UserVo userVo)  throws IOException, SQLException , NullPointerException {
    	userVo = getUser();
    	String message = null;
    	try{
    		message = ptlEmplyrService.infoMemberEdit(ptlInformVo, ptlEmplyrVo, userVo);
    		if(StringUtils.isBlank(message)){
    			message = "F";
    		}
    	} catch(SQLException e){
    	    message = "F";
    	}
    	return message;
    }
    
    
    /**
      * <pre>
      * 
      * 비밀번호 변경화면으로 이동한다.
      * </pre>
      * @author : wonki0138
      * @date   : 2018. 3. 23.
      * @param request
      * @return
      * @throws IOException, SQLException , NullPointerException
      */
    @RequestMapping("/member/regi/memberpw.do")
    public String memberpw(HttpServletRequest request)  throws IOException, SQLException , NullPointerException { 
    	
    	return "member/regi/memberpw.tiles";
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
    @RequestMapping("/member/regi/pwModiPtlEmplyr.do")
    @ResponseBody
    public String pwModiPtlEmplyr(PtlEmplyrVo ptlEmplyrVo, UserVo userVo, @RequestParam("rpassword") String rpassword)  throws IOException, SQLException , NullPointerException { 
    	userVo = getUser();
    	String message = null;
    	try{
    		message = ptlEmplyrService.updatePtlEmplyrPW(ptlEmplyrVo, userVo, rpassword);
    		if(StringUtils.isBlank(message)){
    			message = "F";
    		}
    	} catch(SQLException e){
    	    message = "F";
    	}
    	
    	return message;
    }
    
    /**
      * <pre>
      * 
      * 회원탈퇴화면으로 이동한다.
      * </pre>
      * @author : wonki0138
      * @date   : 2018. 3. 23.
      * @param request
      * @return
      * @throws IOException, SQLException , NullPointerException
      */
    @RequestMapping("/member/regi/memberOut.do")
    public String memberOut(HttpServletRequest request)  throws IOException, SQLException , NullPointerException { 
    	
    	return "member/regi/memberOut.tiles";
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
    @RequestMapping("/member/regi/deleteAccount.do")
    @ResponseBody
    public String deletePtlEmplyr(PtlEmplyrVo ptlEmplyrVo, UserVo userVo, PtlInformVo ptlInformVo)  throws IOException, SQLException , NullPointerException { 
    	userVo = getUser();
    	String message = null;
    		message = ptlEmplyrService.deleteAccount(ptlEmplyrVo, userVo, ptlInformVo);
    		
    		if(message == null){
    			message = "F";
    		}
    		if(StringUtils.isBlank(message)){
    			message = "F";
    		}
    		
    	return message;
    }
    
   
}
