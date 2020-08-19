/******************************************************************
 * Copyright RASTECH 2016
 ******************************************************************/
package kr.go.cris.ptl.stats.controller;
   
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.commons.login.vo.UserVo;
import kr.go.cris.ptl.mng.code.service.MngCodeService;
import kr.go.cris.ptl.mng.code.vo.MngCodeVo;
import kr.go.cris.ptl.mng.sys.service.SysMntrService;
import kr.go.cris.ptl.mng.sys.vo.SysMntrVo;
import kr.go.cris.ptl.stats.service.StatsService;
import kr.go.cris.ptl.stats.vo.PTLStatAccessVo;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;



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
public class StatController extends BaseController {

	
	@Resource
	StatsService statsService;

	/**
	 * <pre>
	 * 자료 접속로그
	 * 
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 1. 18.
	 * @param sendCd
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	@RequestMapping("/srv/addptlStatsAccess.do")
	public void addptlStatsAccess(	HttpServletRequest request, HttpServletResponse response, PTLStatAccessVo ptlStatAccessVo)  throws IOException, SQLException , NullPointerException {

		
    	//로그인 인증		
  		UserVo loginVO = (UserVo) request.getSession().getAttribute("userVo");
    	
  		if(loginVO != null){
  			ptlStatAccessVo.setUserId(loginVO.getLoginid()); 
  		}
  		
     	ptlStatAccessVo.setUserIp(request.getRemoteAddr());
     	
     	//ptlStatAccessVo.setWkid("");
     	//ptlStatAccessVo.setMbid("");
     	//ptlStatAccessVo.setTitle("");
     	
	     	
	     	//statMenuService.insertStatAccess(ptlStatAccessVo);
	     	// 화면통계를 위한 정보 입력 - end
//	     	System.out.println("ptlStatAccessVo : "+ ptlStatAccessVo);
//	     	System.out.println("ptlStatAccessVo UserIp : "+ ptlStatAccessVo.getUserIp());
//	     	System.out.println("ptlStatAccessVo Title : "+ ptlStatAccessVo.getTitle());
//	     	System.out.println("request.getRequestURI() : "+ request.getRequestURI());
	         
	     	
     	    statsService.insertStatsAccess(ptlStatAccessVo);
	     	
	    	response.setContentType("text/html;charset=utf-8");
	   		PrintWriter out = response.getWriter();
	   		out.print("");
	   		request.setCharacterEncoding("UTF-8");
	}
	

}
