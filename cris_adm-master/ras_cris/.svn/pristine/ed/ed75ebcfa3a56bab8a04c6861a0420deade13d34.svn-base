package kr.go.cris.ptl.mng.sch.controller;

import java.io.IOException;
import java.io.Writer;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.commons.utils.ReqUtils;
import kr.go.cris.commons.utils.XmlUtil;
import kr.go.cris.ptl.mng.sch.service.SchService;
import kr.go.cris.ptl.mng.sch.vo.EtlMngVo;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SchController extends BaseController {

	@Resource
	SchService schService;
	   
   /**
    * <pre>
    *    etl 설정정보 저장
    * </pre>
    * @author :
    * @date   : 2015. . .
    * @param
    * @param
    * @return
 * @throws java.text.ParseException 
    * @throws ParseException 
    * @throws NumberFormatException 
    * */
   @RequestMapping(value="/mng/sch/saveEtlList.do")
   public String saveEtlList(Model model, HttpServletRequest request)  throws IOException , SQLException , NullPointerException, NumberFormatException, java.text.ParseException {
		
		// 01. Request >> Map 객체로 전환
		Enumeration em = request.getParameterNames();

       String parameterName = (String)em.nextElement();

       JSONParser jsonParser = new JSONParser();
       // JSON데이터를 넣어 JSON Object 로 만들어 준다.
       JSONObject jsonObject = null;
		try {
			jsonObject = (JSONObject) jsonParser.parse(parameterName);
		} catch (ParseException e) {
			logger.debug("ERROR insertCdList ParseException");
		}
       // books의 배열을 추출
       JSONArray cdInfoArray = (JSONArray) jsonObject.get("list");

       EtlMngVo etlMngVo = null;
         
       List<EtlMngVo> list = new ArrayList<EtlMngVo>();
       for (int i = 0; i < cdInfoArray.size(); i++) {

          // 배열 안에 있는것도 JSON형식 이기 때문에 JSON Object 로 추출
          JSONObject cdObject = (JSONObject) cdInfoArray.get(i);
          // JSON name으로 추출
          etlMngVo = new EtlMngVo();
          etlMngVo.setEtlSn(String.valueOf(cdObject.get("etl_sn")));
          etlMngVo.setEtlId(String.valueOf(cdObject.get("etl_id")));
          etlMngVo.setEtlNm(String.valueOf(cdObject.get("etl_nm")));
          etlMngVo.setEtlType(String.valueOf(cdObject.get("etl_type")));
          etlMngVo.setEtlTime(String.valueOf(cdObject.get("etl_time")));
          etlMngVo.setEtlTb(String.valueOf(cdObject.get("etl_tb")));
          etlMngVo.setEtlGbn(String.valueOf(cdObject.get("etl_gbn")));
          etlMngVo.setEtlHh(String.valueOf(cdObject.get("etl_hh")));
          etlMngVo.setEtlSs(String.valueOf(cdObject.get("etl_ss")));
          etlMngVo.setUseYn(String.valueOf(cdObject.get("use_yn")));
          etlMngVo.setSave_type(String.valueOf(cdObject.get("save_type")));
          list.add(etlMngVo);
       }// end for
       
       schService.saveEtlList(list);
       
		return "redirect:/mng/sch/listSch.do";
	}
	

	/**
	 * <pre>
	 * etl 설정정보 조회
	 *
	 * </pre>
	 * @author : Administrator
	 * @date   : 2017. 5. 9.
	 * @param req
	 * @param model
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws NullPointerException 

	 */
	@RequestMapping("/mng/sch/listSch.do")
	public String etlList(HttpServletRequest req, Model model) throws NullPointerException, IOException, SQLException{
		
		model.addAttribute("etl_type", getCodeList("ETL_TYPE"));
		return "mng/sch/listSch.tiles";
	}
	
	/**
	 * <pre>
	 * etl 설정정보 조회
	 *
	 * </pre>
	 * @author : Administrator
	 * @date   : 2017. 5. 9.
	 * @param req
	 * @param model
	 * @throws IOException 

	 */
	@RequestMapping("/mng/sch/selectEtlList.do")
	public void selectETLList(HttpServletRequest req, HttpServletResponse resp, Writer out) throws IOException{
		Map<String, Object> params = ReqUtils.getParameterMap(req);
		List<Map<String, Object>> list = schService.selectEtlList(params);
		String xml = "";
    	if(list != null){
    		xml = XmlUtil.listMapToXml(list);
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
	 * etl 설정상세정보 조회
	 *
	 * </pre>
	 * @author : Administrator
	 * @date   : 2017. 5. 9.
	 * @param req
	 * @param model

	 */
	@RequestMapping("/mng/sch/selectEtlDtlList.do")
	public String selectEtlDtlList(HttpServletRequest req, Model model){
		Map<String, Object> params = ReqUtils.getParameterMap(req);
		List<Map<String, Object>> list = schService.selectEtlDtlList(params);
		String xml = XmlUtil.listMapToXml(list);
		return xml;
	}
	
/*	*//**
	 * <pre>
	 * etl 즉시실행
	 *
	 * </pre>
	 * @author : Administrator
	 * @date   : 2017. 5. 9.
	 * @param req
	 * @param model
	 * @throws ParseException 
	 * @throws NumberFormatException 
	 * @throws IOException 

	 *//*
	@RequestMapping("/mng/procEtl.do")
	public void procEtl(MciRequest req, Model model) throws NumberFormatException, ParseException, IOException{
		Map<String, Object> params = req.getMap("dmaSrcParam");
		mngService.procEtl(params);
	}
	
    *//**
     * <pre>
     * 서버 상태 조회
     *
     * </pre>
     * @author : Administrator
     * @date   : 2017. 7. 6.
     * @param param
     * @throws IOException 
     * @throws Exception
     *//*
	@RequestMapping(value="/birst/gestServerStat.do")
    public void gestServerStat(HttpServletResponse resp, Writer out,HttpServletRequest request) throws IOException{

    	JSONObject obj = new JSONObject();
    	obj.put("server_1", server_01);
    	obj.put("server_2", server_02);
    	resp.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
    	resp.setHeader("Access-Control-Max-Age", "3600");
    	resp.setHeader("Access-Control-Allow-Headers", "x-requested-with");
    	resp.setHeader("Access-Control-Allow-Origin", "*");
    	resp.setContentType("text");
    	resp.setCharacterEncoding("UTF-8");
    	resp.setHeader("Cache-Control", "no-cache");
    	resp.setHeader("Pragma", "no-cache");   		
    	resp.setDateHeader("Expires", -1);
    	
    	out.write(filterXss(obj.toJSONString()));
    	out.flush();
    }
		
	*//**
	 * <pre>
	 * ETL 예약시간 초기화
	 *
	 * </pre>
	 * @author : Administrator
	 * @date   : 2017. 7. 6.
	 * @param param

	 *//*
	@RequestMapping(value="/mng/timeInit.do")
	public void timeInit(MciRequest req, Model model){
		
		mngService.timeInit();
	}
	
	*//**
	 * <pre>
	 * ETL 에이젼트 상태 조회
	 *
	 * </pre>
	 * @author : Administrator
	 * @date   : 2017. 7. 6.
	 * @param param
	 * @throws IOException 

	 *//*
	@SuppressWarnings("unchecked")
    @RequestMapping(value="/birst/getEtlAppStat.do")
	public void getEtlAppStat(HttpServletResponse resp, Writer out,HttpServletRequest request) throws IOException{
		
		JSONObject obj = new JSONObject();
		
		Map<String,Boolean> app = bisrtScheduler.getEtlAppStat();
		
		obj.put("app_1", app.get("app_01"));
		obj.put("app_2", app.get("app_02"));
		resp.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
		resp.setHeader("Access-Control-Max-Age", "3600");
		resp.setHeader("Access-Control-Allow-Headers", "x-requested-with");
		resp.setHeader("Access-Control-Allow-Origin", "*");
		resp.setContentType("text");
		resp.setCharacterEncoding("UTF-8");
		resp.setHeader("Cache-Control", "no-cache");
		resp.setHeader("Pragma", "no-cache");   		
		resp.setDateHeader("Expires", -1);
		
		out.write(filterXss(obj.toJSONString()));
		out.flush();
	}
	
	*//**
	 * <pre>
	 * ETL 에이젼트 상태 초기화
	 *
	 * </pre>
	 * @author : Administrator
	 * @date   : 2017. 7. 6.
	 * @param param

	 *//*
	@RequestMapping(value="/mng/etlInit.do")
	public void etlInit(MciRequest req, Model model){
		bisrtScheduler.etlInit();
		//메인화면 
		mngService.updateEtlStat();
	}*/
	
}
