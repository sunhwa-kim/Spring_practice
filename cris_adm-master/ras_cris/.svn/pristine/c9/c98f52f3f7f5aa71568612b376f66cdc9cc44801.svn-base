/******************************************************************
 * Copyright RASTECH 2016
 ******************************************************************/
package kr.go.cris.ptl.mng.sys.controller;

import java.io.IOException;
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
import kr.go.cris.ptl.mng.code.service.MngCodeService;
import kr.go.cris.ptl.mng.code.vo.MngCodeVo;
import kr.go.cris.ptl.mng.sys.service.SysMntrService;
import kr.go.cris.ptl.mng.sys.vo.SysMntrVo;

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
public class SysMntrController extends BaseController {

	@Resource
	private MngCodeService mngCodeService;
	
	@Resource
	SysMntrService sysMntrService;
	
	/*@Resource
	Scheduler scheduler;*/

	/**
	 * <pre>
	 * 시스템관리 - 모니터링 이동
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
	@RequestMapping("/mng/sys/sysMntr.do")
	public String sysMntr(SysMntrVo sysMntrVo, Model model, HttpServletRequest request)  throws IOException, SQLException , NullPointerException {

		List<SysMntrVo> sysMntrList = sysMntrService.selectSysMntrList(sysMntrVo);
		
		List<MngCodeVo> err_list = mngCodeService.getCodeList("SYS_CD");
		
		model.addAttribute("sysMntrList", sysMntrList);
		model.addAttribute("err_list", err_list);
		
		return "/mng/sys/sysMntr.tiles";    
	}
	
	/**
	 * <pre>
	 * 시스템관리 - 모니터링 이동
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
	@RequestMapping("/mng/sys/selectMntrErr.do")
	@ResponseBody
	public String selectMntrErr(SysMntrVo sysMntrVo, Model model, HttpServletRequest request,String mntr_seq)  throws IOException, SQLException , NullPointerException {

		sysMntrVo.setMntr_seq(Integer.parseInt(mntr_seq));
		List<SysMntrVo> sysMntrList = sysMntrService.selectSysMntrList(sysMntrVo);
		
		String result ="";
		if(sysMntrList.size() > 0 ){
			result = sysMntrList.get(0).getErr_desc();
		}
		return result;    
	}
	

	/**
	 * <pre>
	 * 모니터링 에러처리 수정
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 24.
	 * @param sysMntrVo
	 * @param model
	 * @param request
	 * @param mntr_seq
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	@RequestMapping("/mng/sys/procErr.do")
	public String procErr(SysMntrVo sysMntrVo, Model model, HttpServletRequest request)  throws IOException, SQLException , NullPointerException {

		sysMntrVo.setErr_prc_yn("Y");
		sysMntrVo.setModifiy_id();
		
		
		sysMntrService.updateSysMntr(sysMntrVo);
		
		return "redirect:/mng/sys/sysMntr.do";
		
	}

   /* *//**
     * <pre>
     * 스켸쥴링 실행
     *
     * </pre>
     * @author : sejin
     * @date   : 2016. 3. 24.
     * @throws IOException, SQLException , NullPointerException
     *//*
    @RequestMapping(value="/mng/sys/procSC.do")
    @ResponseBody
    public void procSC()  throws IOException, SQLException , NullPointerException {
    	//스켸쥴링 실행
    	scheduler.procRssReader();
    }
    */

	/**
	 * <pre>
	 * 시스템관리 - 모니터링 이동
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
	@RequestMapping("/mng/sys/searchEngine.do")
	public String searchEngine(SysMntrVo sysMntrVo, Model model, HttpServletRequest request)  throws IOException, SQLException , NullPointerException {

		Map<String,String> map = new HashMap<String,String>(); 
		
		List<MngCodeVo> table_gp = mngCodeService.getCodeList("TB_GP");
		
		List<Map<String,String>> tabList = sysMntrService.selectTabList(map);
				
		model.addAttribute("tabList", tabList);
		model.addAttribute("table_gp", table_gp);
		
		return "/mng/sys/searchEngine";
		
	}
	


	/**
	 * <pre>
	 * 
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 3. 28.
	 * @param resp
	 * @param out
	 * @param menu_id
	 * @throws IOException, SQLException , NullPointerException
	 */
	@RequestMapping("/mng/sys/selectColList.do")
	@ResponseBody
	public List<Map<String,String>> selectColList(HttpServletResponse resp, Writer out,String table_name)  throws IOException, SQLException , NullPointerException {
		
		String xml = "";
		Map<String,String> map = new HashMap<String,String>(); 
		map.put("table_name", table_name);
		List<Map<String,String>> colList  = sysMntrService.selectColList(map);
				
		return colList;
	}
	
	@RequestMapping("mng/sys/insertTabInfo.do")
	public String insertTabInfo(Model model, HttpServletRequest request,String table_name)  throws IOException, SQLException , NullPointerException, ParseException {
		
		// 01. Request >> Map 객체로 전환
		Enumeration em = request.getParameterNames();
	
	    String parameterName = (String)em.nextElement();
	
	    JSONParser jsonParser = new JSONParser();
	    // JSON데이터를 넣어 JSON Object 로 만들어 준다.
	
	    JSONObject jsonObject = (JSONObject) jsonParser.parse(parameterName);
	    // books의 배열을 추출
	    JSONArray tabInfoArray = (JSONArray) jsonObject.get("list");
	
	    Map<String,String> map = null;
	    for (int i = 0; i < tabInfoArray.size(); i++) {

	    	// 배열 안에 있는것도 JSON형식 이기 때문에 JSON Object 로 추출
	    	JSONObject cdObject = (JSONObject) tabInfoArray.get(i);
	       	// JSON name으로 추출
	       	map = new HashMap<String, String>();

	       	map.put("table_name", String.valueOf(cdObject.get("table_name")));
	       	map.put("column_name", String.valueOf(cdObject.get("column_name")));
	      	map.put("pk_yn", String.valueOf(cdObject.get("pk_yn")));
	       	map.put("content_yn", String.valueOf(cdObject.get("content_yn")));
	       	map.put("table_gp", String.valueOf(cdObject.get("table_gp")));
	       	map.put("use_yn", String.valueOf(cdObject.get("use_yn")));
	       	map.put("table_url", String.valueOf(cdObject.get("table_url")));
	       	map.put("title_yn", String.valueOf(cdObject.get("title_yn")));
	       	map.put("table_where", String.valueOf(cdObject.get("table_where")));
	       	
	    	if(i == 0){
	    		sysMntrService.deleteColInfo(map);
	    		sysMntrService.insertTabInfo(map);
	    	}
	    	
	       	
	    	sysMntrService.insertColInfo(map);
	    	
	    }// end for
		
		return "redirect:/mng/sys/sysMntr.do";
	}

	
	

	/**
	 * <pre>
	 * 시간정보 저장 
	 *
	 * </pre>
	 * @author : Administrator
	 * @date   : 2016. 6. 7.
	 * @param sysMntrVo
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	@RequestMapping("/mng/sys/saveSch.do")
	@ResponseBody
	public void saveSch(SysMntrVo sysMntrVo)  throws IOException, SQLException , NullPointerException {
		
	//	System.out.println(sysMntrVo);
		
		sysMntrService.saveSch(sysMntrVo);
		

	}
		
	
	/**
	 * <pre>
	 * 시스템관리 - 스켸쥴관리 이동
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
	@RequestMapping("/mng/sys/listSch.do")
	public String listSch(SysMntrVo sysMntrVo, Model model, HttpServletRequest request)  throws IOException, SQLException , NullPointerException {

		List<SysMntrVo> schList = sysMntrService.selectListSch(sysMntrVo);
				
		model.addAttribute("schList", schList);
		
		return "/mng/sys/listSch";
		
	}

}
