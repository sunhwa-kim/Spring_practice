/******************************************************************
 * Copyright RASTECH 2016
 ******************************************************************/
package kr.go.cris.ptl.write.controller;
   
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.commons.login.vo.UserVo;
import kr.go.cris.ptl.stats.service.StatsService;
import kr.go.cris.ptl.stats.vo.PTLStatAccessVo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



/**
 * <pre>
 * FileName: sysController.java
 * Package : kr.go.cris.ptl.mng.sys.controller
 * 
 * 시스템관리 컨트롤러
 *
 * </pre>
 * @author : sejin
 * @date   : 2016. 3. 22.
 */
@Controller
public class WriteController extends BaseController {

	
	@Resource
	StatsService statsService;

	/**
	 * 
	 * @param request
	 * @param response
	 * @param ptlStatAccessVo
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	@RequestMapping("/write/agree.do")
	public String agree(	HttpServletRequest request, HttpServletResponse response, PTLStatAccessVo ptlStatAccessVo)  throws IOException, SQLException , NullPointerException {
		
		return "write/agree.tiles";
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @param ptlStatAccessVo
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	@RequestMapping("/write/cris_write.do")
	public String cris_write(HttpServletRequest request, HttpServletResponse response, PTLStatAccessVo ptlStatAccessVo)  throws IOException, SQLException , NullPointerException {
		
		return "write/cris_write.tiles";
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @param ptlStatAccessVo
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	@RequestMapping("/write/step/step1.do")
	public String step1(HttpServletRequest request, HttpServletResponse response, PTLStatAccessVo ptlStatAccessVo)  throws IOException, SQLException , NullPointerException {
		
		return "write/step/step1";
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @param ptlStatAccessVo
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	@RequestMapping("/write/step/step2.do")
	public String step2(HttpServletRequest request, HttpServletResponse response, PTLStatAccessVo ptlStatAccessVo)  throws IOException, SQLException , NullPointerException {
		
		return "write/step/step2";
	}  
	

}
