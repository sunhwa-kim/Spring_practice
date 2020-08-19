/******************************************************************
 * Copyright RASTECH 2020
 ******************************************************************/
package kr.go.cris.ptl.mng.form.controller;
   
import java.io.IOException;
import java.io.Writer;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.commons.login.service.LoginService;
import kr.go.cris.commons.login.vo.UserVo;
import kr.go.cris.commons.utils.ReqUtils;
import kr.go.cris.commons.utils.XmlUtil;
import kr.go.cris.ptl.mng.code.vo.MngCodeVo;
import kr.go.cris.ptl.mng.form.service.FormService;
import kr.go.cris.ptl.mng.form.vo.FormVo;
import kr.go.cris.ptl.mng.form.vo.WFormVo;
import kr.go.cris.ptl.mng.sch.vo.EtlMngVo;
import kr.go.cris.ptl.stats.vo.PTLStatAccessVo;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.util.condition.string.IsEmptyStringCondition;
import org.stringtemplate.v4.compiler.STParser.mapExpr_return;

import com.diquest.ir.common.setting.affilter.impl.runtime.Util;
import com.diquest.ir.util.common.StringUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.mustachejava.PragmaHandler;
import com.sshtools.j2ssh.util.Hash;



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
public class FormController extends BaseController {

	@Resource
	FormService formService;

	/**
	 * 
	 * @param request
	 * @param response
	 * @param ptlStatAccessVo
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	@RequestMapping("/mng/form/listForm.do")
	public String agree(HttpServletRequest request, HttpServletResponse response, Model model)  throws IOException, SQLException , NullPointerException {
		
		model.addAttribute("form_cd",getCodeList("FORM_CD"));
		model.addAttribute("data_type",getCodeList("DATA_TYPE"));
		model.addAttribute("form_type",getCodeList("FORM_TYPE"));
		model.addAttribute("use_yn",getCodeList("USE_YN"));
		
		return "mng/form/listForm.tiles";
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
	@RequestMapping("/mng/form/selectFormList.do")
	public void selectFormList(HttpServletRequest request, HttpServletResponse response, Writer out)  throws IOException, SQLException , NullPointerException {
		
		Map<String, Object> params = ReqUtils.getParameterMap(request);
		
//		for(String key: params.keySet()){
////			String value = (String) params.get(key);
////			System.out.println("ket\t:\t"+key+", value\t:\t"+value);
//			System.out.println("ket\t:\t"+key);
//		}
		
		List<Map<String, Object>> list = formService.selectFormList(params);  // DATA_TYPE만...?
//		출력테스트
//		Iterator<Map<String, Object>> iterator = list.iterator();
//		while ( iterator.hasNext()) {
//			Map<String, Object> map = iterator.next();
//			Set<String> set = map.keySet();
//			Iterator<String> keyIterator  = set.iterator();
//			while(keyIterator.hasNext()){
//				String key = keyIterator.next();
//				System.out.println(map.get(key));
//			}
//			System.out.println();
//		}
		
		String xml = "";
    	if(list != null){
    		xml = XmlUtil.listMapToXml(list);
    	}
 	    
 	    response.setContentType("text/xml");
 	    response.setCharacterEncoding("UTF-8");
 	    response.setHeader("Cache-Control", "no-cache");
 	    response.setHeader("Pragma", "no-cache");
 	    response.setDateHeader("Expires", -1);

 	    out.write(xml);
 	    
 	    out.flush();
	}
	
	   
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
@RequestMapping(value="/mng/form/saveFormList.do")
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

    FormVo formVo = null;
      
    List<FormVo> list = new ArrayList<FormVo>();
    for (int i = 0; i < cdInfoArray.size(); i++) {

       // 배열 안에 있는것도 JSON형식 이기 때문에 JSON Object 로 추출
       JSONObject cdObject = (JSONObject) cdInfoArray.get(i);
       // JSON name으로 추출
       formVo = new FormVo();
       formVo.setElmnt_id(String.valueOf(cdObject.get("elmnt_id")));
       formVo.setElmnt_nm(String.valueOf(cdObject.get("elmnt_nm")));
       formVo.setData_type(String.valueOf(cdObject.get("data_type")));
       formVo.setCd(String.valueOf(cdObject.get("cd")));
       formVo.setLbl_kor(String.valueOf(cdObject.get("lbl_kor")));
       formVo.setLbl_eng(String.valueOf(cdObject.get("lbl_eng")));
       formVo.setSave_type(String.valueOf(cdObject.get("save_type")));
       list.add(formVo);
    }// end for
    
    formService.saveFormList(list);
    
		return "redirect:/mng/sch/listSch.do";
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
@RequestMapping("/mng/form/selectWrkFormList.do")
public void selectWrkFormList(HttpServletRequest request, HttpServletResponse response, Writer out)  throws IOException, SQLException , NullPointerException {
	
	Map<String, Object> params = ReqUtils.getParameterMap(request);
	List<Map<String, Object>> list = formService.selectWrkFormList(params);
	
	
	String xml = "";
	if(list != null){
		xml = XmlUtil.listMapToXml(list);
	}
	    
	    response.setContentType("text/xml");
	    response.setCharacterEncoding("UTF-8");
	    response.setHeader("Cache-Control", "no-cache");
	    response.setHeader("Pragma", "no-cache");
	    response.setDateHeader("Expires", -1);

	    out.write(xml);
	    
	    out.flush();
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

	@RequestMapping("/board/writeBoard.do")
	public String writeBoard(HttpServletRequest request, HttpServletResponse response, Model model)  throws IOException, SQLException , NullPointerException {
		String frm_id = request.getParameter("frm_id");
		String brd_seq = request.getParameter("no");
		String currPg = request.getParameter("pg");
		
		if(brd_seq != "" && brd_seq != null ){
			model.addAttribute("req","update");
			model.addAttribute("brd_seq",brd_seq);
		} else {
			model.addAttribute("req","insert");
			model.addAttribute("brd_seq",request.getParameter("lastBrd_Seq"));
		}
		model.addAttribute("frm_id",frm_id);
		model.addAttribute("currPg",currPg);
		return "mng/form/uptInsert_form.tiles";
	}
	
	public Map<String, Object> makeSendMap(List<Map<String, Object>>sendList , List<MngCodeVo> getCdList, List<Map<String, Object>> dataList) throws NullPointerException, IOException, SQLException{
		Map<String, Object> sendMap = new HashMap<String, Object>();
		String html = "";
		for(int i=0 ; i < sendList.size() ; i++){
			String dataType = sendList.get(i).get("dataType").toString();
			String colNm = sendList.get(i).get("frmCol").toString();
			String upperColKey = colNm.toUpperCase();
			
			String elmntNm = sendList.get(i).get("elmntNm").toString();
			html = "";
			if("S".equals(dataType)){
				String cd = sendList.get(i).get("cd").toString();
				
				String getCd = "";
				String getCdNm = "";
				getCdList = getCodeList(cd);
				html += "<label>"+elmntNm+"</label>&nbsp;&nbsp;";
				html += "<select id=\""+colNm +"\" name=\""+colNm+"\">";
				for(MngCodeVo getCdInfo : getCdList){
					getCd = getCdInfo.getCd();
					getCdNm = getCdInfo.getCd_nm();
					html += "<option value=\""+getCd+"\"";
					if(dataList!=null){ 
						String colData = (String) dataList.get(0).get(upperColKey);
						if(colData != null && colData != "") {
							if(colData.equals(getCd)) html += "selected";	
						}
					}
				html += ">"+getCdNm+"</option>";
				}
				html += "</select><br>";
				
				sendMap.put(colNm, html);
			} else if ("T".equals(dataType)) {
				html += "<label>"+elmntNm+"</label>&nbsp;&nbsp;";
				html += "<input type=\"text\" id=\""+colNm+"\" name=\""+colNm+"\"";
				if(dataList!=null){ 
					String colData = (String) dataList.get(0).get(upperColKey);
					if(colData !=null && colData != "") html+="value=\""+colData+"\"";
				}
				html+="><br>";
				sendMap.put(colNm, html);
			} else {
				html += "<label>"+elmntNm+"</label>&nbsp;&nbsp;";
				html += "<textarea id=\""+colNm+"\" name=\""+colNm+"\" >";
				if(dataList!=null){ 
					String colData = (String) dataList.get(0).get(upperColKey);
					if(colData !=null && colData != "") html+=colData;
				}
				html+="</textarea><br>";
				sendMap.put(colNm, html);
			}
		}
		return sendMap;
	}
	
	@RequestMapping("/mng/form/preUptInsert_form.do")
	@ResponseBody
	public Map<String, Object> preUptInsert_form(Model model, HttpServletRequest request) 
	throws IOException , SQLException , NullPointerException, NumberFormatException, java.text.ParseException {
		Map<String, Object> params = ReqUtils.getParameterMap(request); 
		
		List<Map<String, Object>> colTypeList = formService.selecTheadFormList(params);  //insert는 애만
		List<Map<String, Object>> sendList = new ArrayList<Map<String,Object>>(); 
		Map<String, Object> sendMap = new HashMap<String, Object>();

		String colOrder = "";
		for(Map<String, Object> formInfo : colTypeList){
			Map<String, Object> tmpMap = new HashMap<String, Object>();
			tmpMap.put("dataType", formInfo.get("DATA_TYPE"));
			tmpMap.put("cd", formInfo.get("CD"));
			tmpMap.put("frmCol", formInfo.get("FRM_COL"));
			tmpMap.put("elmntId", formInfo.get("ELMNT_ID"));
			tmpMap.put("elmntNm", formInfo.get("ELMNT_NM"));
			sendList.add(tmpMap);
			colOrder+= ","+formInfo.get("FRM_COL");
		}
		
		List<MngCodeVo> getCdList = null;
		String html = "";
		colOrder = colOrder.replaceFirst(",","");
		if(params.get("req").equals("insert")){
			sendMap = makeSendMap(sendList, getCdList, null);
			sendMap.put("colOrder", colOrder);
			return sendMap;
		} else if(params.get("req").equals("update")){
			List<Map<String, Object>> dataList = formService.selectUptListBoard(params);  // update시 불러올(insert는 null)
			sendMap = makeSendMap(sendList, getCdList, dataList);  
			sendMap.put("colOrder", colOrder);
			return sendMap;
		} else {
			sendMap.put("error", "error");
			return sendMap;
		}
	}
	
	@RequestMapping(value="/mng/form/executeUptInsert_form.do")
	@ResponseBody
	public String  executeUptInsert_form(Model model, HttpServletRequest request)  
			throws IOException , SQLException , NullPointerException, NumberFormatException, java.text.ParseException, ParseException {
			
// 		01. Request >> Map 객체로 전환
				Enumeration em = request.getParameterNames();

			    String prmtName = em.nextElement().toString();
			    
			    JSONParser jsParser = new JSONParser();
			    JSONObject jsObj = null;
			   
			    jsObj = (JSONObject) jsParser.parse(prmtName);  //parseException
			    
			    JSONArray extractJsArr = (JSONArray) jsObj.get("data");
			    Map<String, Object> sendMap = new HashMap<String, Object>();
			    
			    String reqCheck = "";
			    for(int i=0 ; i<extractJsArr.size() ; i++){
// 		배열 안에 있는것도 JSON형식 이기 때문에 JSON Object 로 추출  : System.out.println(test.getClass().getName());
			    	JSONObject secJsObj = (JSONObject) extractJsArr.get(i);
			    	
			    	for(Object key : secJsObj.keySet()){
			    		String keyStr = key.toString();
			    		if(keyStr.equals("req")){
			    			reqCheck = secJsObj.get(keyStr).toString();
			    		}
			    		sendMap.put(keyStr, secJsObj.get(keyStr));
			    	}
			    }
//			    System.out.println("*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*");
			   
			    model.addAttribute("reqCheck", reqCheck);
			    if(reqCheck.equals("insert")){
			    	formService.insertFormBoard(sendMap);
//			    	return "redirect:/board/listBoard.do";
			    	return reqCheck;
			    }else {
			    	formService.updatdBoardDetail(sendMap);
//			    	return "redirect:/mng/form/preUptInsert_form.do";  //redirect안해도 화면에서 reload하면 수정된 결과 그대로 나옴
			    	return reqCheck;
			    }
		
	}
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
		@RequestMapping(value="/mng/form/saveWrkFormList.do")
		public void saveWrkFormList(Model model, HttpServletRequest request)  throws IOException , SQLException , NullPointerException, NumberFormatException, java.text.ParseException {
				
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

		    WFormVo WFormVo = null;
		      
		    List<WFormVo> list = new ArrayList<WFormVo>();
		    for (int i = 0; i < cdInfoArray.size(); i++) {

		       // 배열 안에 있는것도 JSON형식 이기 때문에 JSON Object 로 추출
		       JSONObject cdObject = (JSONObject) cdInfoArray.get(i);
		       // JSON name으로 추출
		       WFormVo = new WFormVo();
		       WFormVo.setFrm_id(String.valueOf(cdObject.get("frm_id")));
		       WFormVo.setFrm_gbn(String.valueOf(cdObject.get("frm_gbn")));
		       WFormVo.setFrm_etc(String.valueOf(cdObject.get("frm_etc")));
		       WFormVo.setUse_yn(String.valueOf(cdObject.get("use_yn")));
		       WFormVo.setSave_type(String.valueOf(cdObject.get("save_type")));

		       list.add(WFormVo);
		    }// end for
		    
		    formService.saveWrkFormList(list);
		    
		}
		
		
		@RequestMapping("/mng/form/selectWrkFormDtlList.do")
		public void selectWrkFormDtlList(HttpServletRequest request, HttpServletResponse response, Writer out)  throws IOException, SQLException , NullPointerException {
			
			Map<String, Object> params = ReqUtils.getParameterMap(request);
			List<Map<String, Object>> list = formService.selectWrkFormDtlList(params);
			String xml = "";
			if(list != null){
				xml = XmlUtil.listMapToXml(list);
			}
			    
			    response.setContentType("text/xml");
			    response.setCharacterEncoding("UTF-8");
			    response.setHeader("Cache-Control", "no-cache");
			    response.setHeader("Pragma", "no-cache");
			    response.setDateHeader("Expires", -1);

			    out.write(xml);
			    
			    out.flush();
		}	
		
		@RequestMapping(value="/mng/form/saveSubWrkFormList.do")
		public void saveSubWrkFormList(Model model, HttpServletRequest request)  throws IOException , SQLException , NullPointerException, NumberFormatException, java.text.ParseException {
				
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

		    WFormVo WFormVo = null;
		      
		    List<WFormVo> list = new ArrayList<WFormVo>();
		    for (int i = 0; i < cdInfoArray.size(); i++) {

		       // 배열 안에 있는것도 JSON형식 이기 때문에 JSON Object 로 추출
		       JSONObject cdObject = (JSONObject) cdInfoArray.get(i);
		       // JSON name으로 추출
		       WFormVo = new WFormVo();
		       
		       WFormVo.setFrm_id(String.valueOf(cdObject.get("frm_id")));
		       WFormVo.setFrm_seq(String.valueOf(cdObject.get("frm_seq")));
		       WFormVo.setFrm_elmnt_id(String.valueOf(cdObject.get("frm_elmnt_id")));
		       WFormVo.setFrm_ord(String.valueOf(cdObject.get("frm_ord")));
		       WFormVo.setFrm_col(String.valueOf(cdObject.get("frm_col")));
		       WFormVo.setUse_yn(String.valueOf(cdObject.get("use_yn")));
		       WFormVo.setLst_yn(String.valueOf(cdObject.get("lst_yn")));
		       WFormVo.setSrch_yn(String.valueOf(cdObject.get("srch_yn")));
		       WFormVo.setSave_type(String.valueOf(cdObject.get("save_type")));
//		       여기서 MAP으로 한번에 하는게 좋음....
		       list.add(WFormVo);
		    }// end for
		    
		    formService.saveSubWrkForm(list);
		    
		}
		
		@RequestMapping("/board/listBoard.do")
		public String listBoard(HttpServletRequest request, HttpServletResponse response, Model model,WFormVo wformVo)  throws IOException, SQLException , NullPointerException {
			
			System.out.println("----------------------------------------------------------------");
			
//			System.out.println(getUser().getLoginid() );   // 이것만으로 로그인 안했을때 error
//			try {
//				String id = getUser().getLoginid();
//				String pw = getUser().getPassword();
//			} catch (Exception e) {
//				System.out.println("null");
//				return "redirect:/login/user/login.do";
//				// TODO: handle exception
//			}
			
			
			String frm_id = request.getParameter("frm_id");
			String currentPg = request.getParameter("pg");
			
			wformVo.setFrm_id(frm_id);
			WFormVo voRowsCnt = formService.selectSubListBoardCnt(wformVo);	
			
			int totalRowsCnt = Integer.parseInt(voRowsCnt.getTotalListCnt()); 
			int last_brd = Integer.parseInt(voRowsCnt.getLast_brd()); 
			
//			20 lines per page
			int linesPerPg = 20;
			int pgList = (int)Math.ceil((double)totalRowsCnt/linesPerPg);
			
			model.addAttribute("frm_id",frm_id);
			model.addAttribute("pgList",pgList);
			model.addAttribute("linesPerPg",linesPerPg);
			model.addAttribute("last_brd",last_brd);
			model.addAttribute("currPg",currentPg);
			
			return "mng/form/listBoard.tiles";
		}


		@RequestMapping("/mng/form/selectTheadBoard.do")
		@ResponseBody
		public List<Map<String, Object>> selectListBoard(HttpServletRequest request, HttpServletResponse response, MngCodeVo mngCodeVo)
				throws IOException, SQLException , NullPointerException,  java.text.ParseException  {
			
			Map<String, Object> params = ReqUtils.getParameterMap(request);  
			params.put("lst_yn", "Y");
			
			List<Map<String, Object>> tHeadList = formService.selecTheadFormList(params);
			List<Map<String, Object>> sendList = new ArrayList<Map<String,Object>>();
			for(int i=0 ; i<tHeadList.size() ; i++){
				Map<String, Object> newMap = new HashMap<String, Object>();
				
				newMap.put("srch_yn", tHeadList.get(i).get("SRCH_YN"));
				newMap.put("lbl_kor", tHeadList.get(i).get("LBL_KOR"));
				newMap.put("frm_col", tHeadList.get(i).get("FRM_COL"));
				newMap.put("data_type", tHeadList.get(i).get("DATA_TYPE"));
				newMap.put("cd", tHeadList.get(i).get("CD"));
				
				sendList.add(newMap);
			}
//		listBoard 순서상 뒤에서 두번째 [cnNm], 가장 맨 뒤 [type=s인 col name] 순서에 들어가 줘야 함.		
			Map<String, Object> sendMap = new HashMap<String, Object>();
			String typeSCol = "";
			for(Map<String, Object> map : sendList){
				String dataType = map.get("data_type").toString();
				String colNm = map.get("frm_col").toString();
				String typeCd = map.get("cd").toString();
				
				if("S".equals(dataType)){
					colNm = colNm.toUpperCase();
					typeSCol += ","+colNm;
					List<MngCodeVo> dataTypeList =   getCodeList(typeCd);
					for(MngCodeVo mngCdVo : dataTypeList){
						String voCd = mngCdVo.getCd();
						String voCdNm = mngCdVo.getCd_nm();
						sendMap.put(voCd, voCdNm);
					}
				}
			}
			sendList.add(sendMap);

//			getUser().getLoginid()   // later for login
//			model.addAttribute("typeSCol", typeSCol);   // @ResponseBody이용시에는 model 안 되는 듯? (중간에 converter랑... model의 dispatchservlet이랑 ??)
			typeSCol = typeSCol.replaceFirst(",", "");
			Map<String, Object> colMap = new HashMap<String, Object>();
			colMap.put("type_s_col", typeSCol);
			sendList.add(colMap);
			return sendList;
		}	
		
		@RequestMapping("/mng/form/selectTbodyBoard.do")
		public void selectSubListBoard(HttpServletRequest request, HttpServletResponse response, Writer out, Model model)  
				throws IOException, SQLException , NullPointerException {
			String srchColumnStr = request.getParameter("srchColumnStr");
			
			Map<String, Object> params = null;
			
			if(srchColumnStr != "" && srchColumnStr != null) {
				String srchStr = request.getParameter("srchTxt");
				String srchStrLowerCase = srchStr.toLowerCase();
				String srchStrUpperCase = srchStr.toUpperCase();
				
				 params = ReqUtils.getParameterMap(request);
				 params.put("srchLower", srchStrLowerCase);
				 params.put("srchUpper", srchStrUpperCase);
			} else {
				params = ReqUtils.getParameterMap(request);
			}
			
			List<Map<String, Object>> sendList = formService.selectSubListBoard(params);
			
			String xml = "";
			if(sendList != null){
				xml = XmlUtil.listMapToXml(sendList);
			}
			    
			    response.setContentType("text/xml");
			    response.setCharacterEncoding("UTF-8");
			    response.setHeader("Cache-Control", "no-cache");
			    response.setHeader("Pragma", "no-cache");
			    response.setDateHeader("Expires", -1);

			    out.write(xml);
			    
			    out.flush();
		}	
		
		
////		sjsj
//		@RequestMapping("/mng/form/listBoard.do")
//		public String listBoard(HttpServletRequest request, HttpServletResponse response, Model model)  throws IOException, SQLException , NullPointerException {
////			String urlParam = request.getParameter("frm_id"); //url?뒤에 붙은 parameter 받는
//			Map<String,Object> params = new HashMap<String, Object>();// 이대로 들어가면 빈 값
//
//			List<Map<String, Object>> list = formService.selectFormList(params);
//			
////		출력테스트_sh
//		System.out.println("#####################");
//		Iterator<Map<String, Object>> iterator = list.iterator();
//		while ( iterator.hasNext()) {
//			Map<String, Object> map = iterator.next();
//			Set<String> set = map.keySet();
//			Iterator<String> keyIterator  = set.iterator();
//			while(keyIterator.hasNext()){
//				String key = keyIterator.next();
//				System.out.println(map.get(key));
//			}
//			System.out.println();
//		}
//			
//			Map<String, Object> map = null;
//			for (int i = 0; i < list.size(); i++) {
//				if("S".equals(list.get(i).get("DATA_TYPE"))){
//					List<MngCodeVo> code =  getCodeList(list.get(i).get("CD").toString());
//					String html = "<select name=\""+list.get(i).get("ELMNT_ID")+"\">";
//					for (MngCodeVo mngCodeVo : code) {
//						html += "<option value=\""+ mngCodeVo.getCd() +"\" >" + mngCodeVo.getCd_nm()+ "</option>";
//					}
//					html += "</select>";
//					list.get(i).put("CD",html);
//				}
//			}
//			model.addAttribute("list", list);
//			return "mng/form/writeBoard.tiles";
//		}
}
