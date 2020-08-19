package kr.go.cris.ptl.policy.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.cris.base.controller.BaseController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



/**
 * <pre>
 * 
 * 
 * </pre>
 * @FileName : PolicyController.java
 * @package  : kr.go.cris.ptl.policy.controller
 * @author   : user
 * @date     : 2018. 7. 4.
 * 
 */
@Controller
public class PolicyController extends BaseController {
	 
     /**
     * <pre>
     * 개인정보처리방침 화면으로 이동한다.
     *
     * </pre>
     * @author : user
     * @date   : 2018. 7. 4. 
     * @param request
     * @param response
     * @return
     * @throws IOException
     * @throws SQLException
     * @throws NullPointerException
     */
    @RequestMapping(value="/policy/policy.do")
	  public String policy(HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException , NullPointerException {
		 return "policy/policy.tiles";
	  }
    
     /**
     * <pre>
     * 저작권 정책 화면으로 이동한다.
     *
     * </pre>
     * @author : user
     * @date   : 2018. 7. 4. 
     * @param request
     * @param response
     * @return
     * @throws IOException
     * @throws SQLException
     * @throws NullPointerException
     */
    @RequestMapping(value="/policy/copy.do")
	  public String copy(HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException , NullPointerException {
		 return "policy/copy.tiles";
	  }
     
     /**
     * <pre>
     * 뷰어 다운로드 화면으로 이동한다.
     *
     * </pre>
     * @author : user
     * @date   : 2018. 7. 4. 
     * @param request
     * @param response
     * @return
     * @throws IOException
     * @throws SQLException
     * @throws NullPointerException
     */
    @RequestMapping(value="/policy/viewer.do")
	  public String viewer(HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException , NullPointerException {
		 return "policy/viewer.tiles";
	  }
	
    
}
