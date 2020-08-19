package kr.go.cris.ptl.board.myClinicalResearch.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.cris.commons.utils.ReqUtils;
import kr.go.cris.ptl.board.myClinicalResearch.service.MyCR_Service;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import freemarker.core.ReturnInstruction.Return;

@Controller
public class MyClinicRsController {
	@Resource
	MyCR_Service myCRservice;
	
	@RequestMapping("/board/myClinicalResearch/myClRsrch.do")
	public String fristView(HttpServletRequest request, HttpServletResponse response, Model mdl)
	throws  IOException, SQLException , NullPointerException{
		
//		return "board/myCR/myClRsrch.tiles";
		return "board/myCR/myCR.tiles";
	}
	
	@RequestMapping("/board/myClinicalResearch/registration_mng.do")
	@ResponseBody
	public List<Map<String, Object>> registration_mng(HttpServletRequest request, HttpServletResponse response, Model mdl)
	throws  IOException, SQLException , NullPointerException, java.text.ParseException {
		
		Map<String, Object> params = ReqUtils.getParameterMap(request);  
		List<Map<String, Object>> slctRgstrMng = myCRservice.selectMyRegistration_mng(params);
		
		return slctRgstrMng;
	}
	
	@RequestMapping("/board/myClinicalResearch/regSubView.do")
	public String regSubView(HttpServletRequest request, HttpServletResponse response, Model mdl)
	throws  IOException, SQLException , NullPointerException{
		String separator = request.getParameter("reg_btnVal");
		String returnStr = "";
		
		if(separator.equals("regSubmission")){
			mdl.addAttribute("title", request.getParameter("reg_title"));
			
			returnStr = "board/myCR/regSubmission";
		} else if(separator.equals("regRsInfo")){
			returnStr = "board/myCR/regRsInfo";
		}
		
		mdl.addAttribute("seq", request.getParameter("reg_seq"));
		mdl.addAttribute("separator", separator);
		
		return returnStr;
	}
	
	@RequestMapping("/board/myClinicalResearch/regSubData.do")
	@ResponseBody
	public List<Map<String, Object>> regSubData(HttpServletRequest request, HttpServletResponse response, Model mdl)
	throws  IOException, SQLException , NullPointerException{
		
		String separator = request.getParameter("separator");
		Map<String, Object> params = ReqUtils.getParameterMap(request);  
		List<Map<String, Object>> sendList = new ArrayList<Map<String,Object>>();
		
		if(separator.equals("regSubmission")){
			sendList = myCRservice.selectRegSubmission(params);
		}  else if(separator.equals("regRsInfo")){
			sendList = myCRservice.selectRegRsInfo(params);
		
			// 1.연구개요- 타등록 정보
			Map<String, Object> systemMap = myCRservice.selectRsSystem(params);
			
			sendList.add(systemMap);
			
			// 등록된 메모 ( step 별 분배 data )
			params.put("gubun", "CRIS");
			List<Map<String, Object>> step_list = myCRservice.selectStep(params);
			Map<String, Object> step_map = new HashMap<String, Object>();
			for(int i=0; i<step_list.size(); i++){
				String stp_str = "stp"+i;
				step_map.put(stp_str, step_list.get(i));
			}
			sendList.add(step_map);
			
			System.out.println("******************************************************");
			for(Map<String, Object> key : step_list){
				for(String keyyy : key.keySet()){
					System.out.println(keyyy+"\t:\t"+key.get(keyyy));
				}
			}
			
			
			//  3.연구자 - CHARGE, WORK, RIGEST
			List<Map<String, Object>> role_gb_List = myCRservice.selectRoleGubun(params);		
			Map<String, Object> role_gbMap = new HashMap<String, Object>();
			int siteInList= sendList.size();
			int role_gbSize = role_gb_List.size();

			String role_gbInfo = String.valueOf(siteInList)+","+String.valueOf(role_gbSize);
			role_gbMap.put("role_gbInfo", role_gbInfo);
			for(int i=0; i<role_gbSize; i++){
				String role_gb = "gb"+i;
				role_gbMap.put(role_gb, role_gb_List.get(i));
			}
			sendList.add(role_gbMap);
			
			//	4. 연구기관
			List<Map<String,Object>> institute_list = myCRservice.selectRsrchInstitute(params);
			Map<String, Object> institute_map = new HashMap<String, Object>();
			for(int i=0; i<institute_list.size();i++){
				String ist_gb = "ist_gb"+i ;
				institute_map.put(ist_gb, institute_list.get(i));
			}
			sendList.add(institute_map);
			
			//  8. 연구 설계 ( 중재/관찰 )
			List<Map<String,Object>> rsrchKind_list = myCRservice.selectRsrchKind(params);
			Map<String, Object> rsrchKind_map = new HashMap<String, Object>();
			for(int i=0; i<rsrchKind_list.size();i++){
				String knd_gb = "knd_gb"+i ;
				rsrchKind_map.put(knd_gb, rsrchKind_list.get(i));
			}
			sendList.add(rsrchKind_map);

			//  9. 대상자 선정 기준 - 질환 분류
			List<Map<String, Object>> tgStandard_list = myCRservice.selectIcd10List(params);
			Map<String, Object> tgStandard_map = new HashMap<String, Object>();
			for(int j=0; j<tgStandard_list.size() ; j++){
				String tgStndrd = "tg_icd"+j;
				tgStandard_map.put(tgStndrd, tgStandard_list.get(j));
			}
			sendList.add(tgStandard_map);  //  res[6]
			
			//	 10. 결과 변수 - 주요결과변수 P, 보조결과변수S  => seq에 따라  P->S 순 확인
			List<Map<String, Object>> rsltVariable_list = myCRservice.selectOutcomeList(params);
			Map<String, Object> rsltVariable_map = new HashMap<String, Object>();
			
			for( int i=0; i<rsltVariable_list.size() ; i++){
				String rtVar = "var_gb"+i;
				rsltVariable_map.put(rtVar, rsltVariable_list.get(i));
			}
			sendList.add(rsltVariable_map);		//		res[7]

			//		11. 연구 결과 및 발표 - 논문			
			List<Map<String, Object>> thesis_list = myCRservice.selectThesisList(params);
			Map<String, Object> thesis_map = new HashMap<String, Object>();
			
			for( int i=0; i<thesis_list.size() ; i++){
				String thesis = "thesis"+i ;
				thesis_map.put(thesis, thesis_list.get(i));
			}
			sendList.add(thesis_map);		//		res[8]
			
		}  //  end of regRsInfo
		
		
//		for(Map<String, Object> map2 : sendList ){
//			for(String key : map2.keySet()){
//				System.out.println(key +"\t:\t"+map2.get(key));
//			}
//		}
		
		return sendList;
	}
	
}
