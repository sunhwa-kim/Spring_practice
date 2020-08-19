package kr.go.cris.ptl.archive.report.controller;

import java.io.File;
import java.io.IOException;
import java.io.Writer;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.commons.code.service.CodeService;
import kr.go.cris.commons.login.vo.UserVo;
import kr.go.cris.commons.utils.ExcelDownUtil;
import kr.go.cris.commons.utils.XmlUtil;
import kr.go.cris.ptl.archive.report.service.ArchiveReportService;
import kr.go.cris.ptl.archive.report.vo.ArchiveAnnualInfoVo;
import kr.go.cris.ptl.archive.report.vo.ArchiveReportVo;
import kr.go.cris.ptl.archive.rnd.service.ArchiveRndService;
import kr.go.cris.ptl.archive.rnd.vo.ArchiveRndVo;
import kr.go.cris.ptl.mng.code.service.MngCodeService;
import kr.go.cris.ptl.mng.code.vo.MngCodeVo;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
 

/**
 * <pre>
 * 아카이브 보고서 Controller 구현
 * 
 * </pre>
 * @FileName : ArchiveReportController.java
 * @package  : kr.go.cris.ptl.archive.report.controller
 * @author   : wonki0138
 * @date     : 2018. 3. 16.
 * 
 */

@Controller
public class ArchiveReportController extends BaseController {

    @Resource
    private ArchiveReportService archiveReportService;
    
    @Resource
    private ArchiveRndService archiveRndService;
    
    @Resource
    private CodeService codeService;
    
    
    @Resource
    private MngCodeService mngCodeService;
    
    private SimpleDateFormat saveFilePattern = new SimpleDateFormat("yyyyMMddHHmmssSS");

  
    
    /**
     * <pre>
     * 아카이브 보고서 - 목록화면 이동
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 16. 
     * @param model
     * @param archiveReportVo
     * @param request
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/archive/report/reportList.do")
    public String reportList(Model model, ArchiveReportVo archiveReportVo, HttpServletRequest request , HttpServletResponse response)  throws IOException , SQLException , NullPointerException {
    	
    
    	model.addAttribute("archiveReportVo", archiveReportVo);
    	
    	return "archive/report/reportList.tiles";
    }

  
    @RequestMapping("/archive/report/testList.do")
    public void testList(HttpServletResponse resp, Writer out,HttpServletRequest request)  throws IOException , SQLException , NullPointerException , JSONException {
    	
    
    	JSONObject json = new JSONObject();
    	
    	json.put("result", true); //중복
		
		
		
		resp.setContentType("text/xml");
 	    resp.setCharacterEncoding("UTF-8");
 	    resp.setHeader("Cache-Control", "no-cache");
 	    resp.setHeader("Pragma", "no-cache");
 	    resp.setDateHeader("Expires", -1);

 	   // out.write("true");
 	    out.write(json.toString());
 		
 	   out.flush();
    }

    /**
     * <pre>
     * 
     * 아카이브 보고서 - 목록 화면의 게시물을 조회한다.
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 16. 
     * @param request
     * @param archiveReportVo
     * @param resp
     * @param out
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("archive/report/reportRead.do")
    public void reportRead(HttpServletRequest request, ArchiveReportVo archiveReportVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
    	

    	String xml = "";    
    	
    	//  ******************************* 필터 검색조건 STR *********************************
    	
    	List<String> fillterYearList  =  null;
    
    	List<String> fillterDeptList  = null;
    	
     	List<String> fillterSubjectList  = null;
    	
    	if(StringUtils.isNotBlank(archiveReportVo.getFillterYearList())){
    		
    		fillterYearList =  new ArrayList<String>();		
    		for(String year : archiveReportVo.getFillterYearList().split(",")){
        		fillterYearList.add(year);    		
        	}
    	}    	
    	
    	if(StringUtils.isNotBlank(archiveReportVo.getFillterDeptList())){
    	
    		fillterDeptList =  new ArrayList<String>();
    		for(String dept : archiveReportVo.getFillterDeptList().split(",")){
    			fillterDeptList.add(dept);    		
        	}
    	}
    	
    	if(StringUtils.isNotBlank(archiveReportVo.getFillterSubjectList())){
        	
    		fillterSubjectList =  new ArrayList<String>();
    		for(String subject : archiveReportVo.getFillterSubjectList().split(",")){
    			fillterSubjectList.add(subject);    		
        	}
    	}
    	archiveReportVo.setFillterYearList_L(fillterYearList);

    	archiveReportVo.setFillterDeptList_L(fillterDeptList);
    	
    	archiveReportVo.setFillterSubjectList_L(fillterSubjectList);
    	//  ******************************* 필터 검색조건 END *********************************
    	
    	// 권한에 따른 공개 비공개 처리 STR
		String roleListVal = "";
		String archiveRole = "notView";
		UserVo usrVo =  (UserVo) request.getSession().getAttribute("userVo");
		if(usrVo != null){
			if(usrVo.getRoleList().size() > 0){
			
				for (int i = 0 ; i < usrVo.getRoleList().size(); i++ ){
					roleListVal = usrVo.getRoleList().get(i);    			
					if(StringUtils.equals(roleListVal , "ROLE_ARCHIVE")  || StringUtils.equals(roleListVal , "ROLE_ADMIN")){
						archiveRole = "view";
					}
				}
			} 
		}
		archiveReportVo.setConParam(archiveRole);			
    	// 권한에 따른 공개 비공개 처리 END
    	
    	List<ArchiveReportVo> list = archiveReportService.selectReportList(archiveReportVo);
    	
    	int totalCnt = archiveReportService.selectReportTotalCount(archiveReportVo);
    	
    	if(list != null){
    		if(list.size() > 0){
    			
    			xml = XmlUtil.listToXml(list);
    			/*
    			 * 총카운터 세팅
    			 */
    	    	StringBuffer sb = new StringBuffer();
    	    	String[] str = xml.split("<items>");
    	    	
    	    	sb.append(str[0]);
    	    	sb.append("<items>");
    	    	sb.append("<totalPageCnt>"+Math.ceil((double)totalCnt/(double)archiveReportVo.getPageSize())+"</totalPageCnt>\n");    	 
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
     * 아카이브 보고서 - 상세 조회
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 16. 
     * @param model
     * @param archiveReportVo
     * @param request
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/archive/report/reportView.do")
	public String reportView(Model model, ArchiveReportVo archiveReportVo, HttpServletRequest request ) throws IOException , SQLException , NullPointerException{

    	//검색 PARAM	
		String page = archiveReportVo.getPage();
		String searchKeyword = archiveReportVo.getSearchKeyword();
		String searchCondition = archiveReportVo.getSearchCondition();
		
		// return 페이지 구분을 위해
		String returnPageGbn = archiveReportVo.getReturnPageGbn();
		
		// 열린 필터 갯수
		String yearCnt = archiveReportVo.getFillterYearCnt();
		String deptCnt = archiveReportVo.getFillterDeptCnt();
		String subjectCnt = archiveReportVo.getFillterSubjectCnt();

		String fillterYearList = archiveReportVo.getFillterYearList_s();
		String fillterDeptList = archiveReportVo.getFillterDeptList_s();
		String fillterSubjectList = archiveReportVo.getFillterSubjectList_s();
		
		if(StringUtils.equals(archiveReportVo.getUpd_yn(), "Y")){
			archiveReportService.updateReadCnt(archiveReportVo);
		}

		//기본정보
		ArchiveReportVo resultVo = archiveReportService.selectReportInfo(archiveReportVo);		
		
		//연자정보
		List<ArchiveAnnualInfoVo> resultAnnualVo = archiveReportService.selectAnnualInfo(archiveReportVo);
		
		//주제분류 코드 
		MngCodeVo	codeSubject = null;
		if(StringUtils.isNotBlank(resultVo.getSubject()) ){
				codeSubject = mngCodeService.getCode("ACHIVE_CD", resultVo.getSubject());
		}
		
		//파일 리스트
	//	List<ArchiveReportVo>  fileList = archiveReportService.selectReportFileList(archiveReportVo);	
		if(resultVo != null){	
			
				ArchiveRndVo  rndVo = new ArchiveRndVo();
				rndVo.setRep_id(archiveReportVo.getRep_id());
			    List<ArchiveRndVo> resultRnd = archiveRndService.selectLinkRnd(rndVo);
			    
			    resultVo.setPage(page);
			    resultVo.setSearchKeyword(searchKeyword);
			    resultVo.setSearchCondition(searchCondition);
			    resultVo.setReturnPageGbn(returnPageGbn);
			    if(codeSubject != null){
			    	resultVo.setSubject(codeSubject.getCd_nm());
			    }else{
			    	resultVo.setSubject("");
			    }
			    resultVo.setFillterYearList_s(fillterYearList);
	
			    resultVo.setFillterDeptList_s(fillterDeptList);
			    
			    resultVo.setFillterSubjectList_s(fillterSubjectList);

			    resultVo.setFillterYearCnt(yearCnt);
		
			    resultVo.setFillterDeptCnt(deptCnt);

			    resultVo.setFillterSubjectCnt(subjectCnt);
				
			   /* if (fileList.size() > 0) {

					model.addAttribute("fileList", fileList);
				}*/
			    model.addAttribute("resultVO",resultVo);	
			    model.addAttribute("resultRnd",resultRnd);	
			 //   model.addAttribute("codeSubjectList",codeSubjectList);	
			    if(resultAnnualVo != null){
			    	   model.addAttribute("resultAnnualVO",resultAnnualVo);	
			    }
		}  	
		
		return "archive/report/reportView.tiles";
    }
    
    /**
     * <pre> 
     *
     * 아카이브 보고서 - 상세 조회
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 16. 
     * @param model
     * @param archiveReportVo
     * @param request
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/search/report/reportView.do")
    public String reportView2(Model model, ArchiveReportVo archiveReportVo, HttpServletRequest request ) throws IOException , SQLException , NullPointerException{
    	
    	//검색 PARAM	
    	String page = archiveReportVo.getPage();
    	String searchKeyword = archiveReportVo.getSearchKeyword();
    	String searchCondition = archiveReportVo.getSearchCondition();
    	
    	// return 페이지 구분을 위해
    	String returnPageGbn = archiveReportVo.getReturnPageGbn();
    	
    	// 열린 필터 갯수
    	String yearCnt = archiveReportVo.getFillterYearCnt();
    	String deptCnt = archiveReportVo.getFillterDeptCnt();
    	String subjectCnt = archiveReportVo.getFillterSubjectCnt();
    	
    	String fillterYearList = archiveReportVo.getFillterYearList_s();
    	String fillterDeptList = archiveReportVo.getFillterDeptList_s();
    	String fillterSubjectList = archiveReportVo.getFillterSubjectList_s();
    	
    	if(StringUtils.equals(archiveReportVo.getUpd_yn(), "Y")){
    		archiveReportService.updateReadCnt(archiveReportVo);
    	}
    	
    	//기본정보
    	ArchiveReportVo resultVo = archiveReportService.selectReportInfo(archiveReportVo);		
    	
    	//연자정보
    	List<ArchiveAnnualInfoVo> resultAnnualVo = archiveReportService.selectAnnualInfo(archiveReportVo);
    	
    	//주제분류 코드 
    	MngCodeVo	codeSubject = null;
    	if(StringUtils.isNotBlank(resultVo.getSubject()) ){
    		codeSubject = mngCodeService.getCode("ACHIVE_CD", resultVo.getSubject());
    	}
    	
    	//파일 리스트
    	//	List<ArchiveReportVo>  fileList = archiveReportService.selectReportFileList(archiveReportVo);	
    	if(resultVo != null){	
    		
    		ArchiveRndVo  rndVo = new ArchiveRndVo();
    		rndVo.setRep_id(archiveReportVo.getRep_id());
    		List<ArchiveRndVo> resultRnd = archiveRndService.selectLinkRnd(rndVo);
    		
    		resultVo.setPage(page);
    		resultVo.setSearchKeyword(searchKeyword);
    		resultVo.setSearchCondition(searchCondition);
    		resultVo.setReturnPageGbn(returnPageGbn);
    		if(codeSubject != null){
    			resultVo.setSubject(codeSubject.getCd_nm());
    		}else{
    			resultVo.setSubject("");
    		}
    		resultVo.setFillterYearList_s(fillterYearList);
    		
    		resultVo.setFillterDeptList_s(fillterDeptList);
    		
    		resultVo.setFillterSubjectList_s(fillterSubjectList);
    		
    		resultVo.setFillterYearCnt(yearCnt);
    		
    		resultVo.setFillterDeptCnt(deptCnt);
    		
    		resultVo.setFillterSubjectCnt(subjectCnt);
    		
    		/* if (fileList.size() > 0) {

					model.addAttribute("fileList", fileList);
				}*/
    		model.addAttribute("resultVO",resultVo);	
    		model.addAttribute("resultRnd",resultRnd);	
    		//   model.addAttribute("codeSubjectList",codeSubjectList);	
    		if(resultAnnualVo != null){
    			model.addAttribute("resultAnnualVO",resultAnnualVo);	
    		}
    	}  	
    	model.addAttribute("returnSearchPageGbn","T");	
    	
    	return "archive/report/reportView.tiles";
    }
    
   
    
    /**
     * <pre>
     *
     * 검색 결과 제한 (메뉴)를 호출.
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 21. 
     * @param request
     * @param archiveReportVo
     * @param resp
     * @param out
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("archive/report/reportRightMenuRead.do")
    public void reportRightMenuRead(HttpServletRequest request, ArchiveReportVo archiveReportVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
    	
    	// 권한에 따른 공개 비공개 처리 STR
		String roleListVal = "";
		String archiveRole = "notView";
		UserVo usrVo =  (UserVo) request.getSession().getAttribute("userVo");
		if(usrVo != null){
			if(usrVo.getRoleList().size() > 0){
			
				for (int i = 0 ; i < usrVo.getRoleList().size(); i++ ){
					roleListVal = usrVo.getRoleList().get(i);    			
					if(StringUtils.equals(roleListVal , "ROLE_ARCHIVE")  || StringUtils.equals(roleListVal , "ROLE_ADMIN")){
						archiveRole = "view";
					}
				}
			} 
		}
		archiveReportVo.setConParam(archiveRole);			
    	// 권한에 따른 공개 비공개 처리 END
    	String xml = "";    	
    	List<ArchiveReportVo> list = archiveReportService.selectReportFillterList(archiveReportVo);
    	
    
    	
    	if(list != null){
    		if(list.size() > 0){
    			
    			xml = XmlUtil.listToXml(list);
    			/*
    			 * 총카운터 세팅
    			 */
    	    	StringBuffer sb = new StringBuffer();
    	    	String[] str = xml.split("<items>");
    	    	
    	    	sb.append(str[0]);
    	    	sb.append("<items>");  	
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
     * 아카이브 보고서 등록페이지로 이동 
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 27. 
     * @param model
     * @param archiveReportVo
     * @param request
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/archive/report/reportWrite.do")
    public String reportWrite(Model model, ArchiveReportVo archiveReportVo, HttpServletRequest request)  throws IOException , SQLException , NullPointerException {
     	
    	
    	List<MngCodeVo>	codeSubjectList = mngCodeService.getCodeList("ACHIVE_CD");

    	//model.addAttribute("codeDeptList", codeDeptList);
    	model.addAttribute("codeSubjectList", codeSubjectList);
    	model.addAttribute("archiveReportVo", archiveReportVo);
    	
    	return "archive/report/reportWrite.tiles";
    }
    
    /**
     * <pre>
     * 아카이브 보고서를 등록한다
     * 
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 27. 
     * @param model
     * @param archiveReportVo
     * @param request
     * @param redirectAttr
     * @param Multirequest
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/archive/report/insertArchiveReport.do")
    public String insertArchiveReport(Model model, ArchiveReportVo archiveReportVo, HttpServletRequest request ,RedirectAttributes redirectAttr, MultipartHttpServletRequest multiRequest)  throws IOException , SQLException , NullPointerException {
    	
    	String file_id = "";
       
        
    	String message = "";
    	
    	if(getUser() != null){
    	
    		archiveReportVo.setFrst_register_id(getUser().getEmplyrkey());
    		//System.out.println(" getUser().getEmplyrkey()= "+getUser().getEmplyrkey());
    		if(archiveReportVo.getCon_type().equals("1")){
    			archiveReportVo.setPrivate_str_dt("");
    			archiveReportVo.setPrivate_end_dt("");
    			archiveReportVo.setPrivate_rs("");
    		}
    		/*if(archiveReportVo.getSecurity_level().equals("1")){
    			archiveReportVo.setSecurity_rs("");
    		}*/
    		
	    	if(!archiveReportService.insertArchiveReport(archiveReportVo)){
	    		message = "등록이 실패하였습니다.";
	        	redirectAttr.addFlashAttribute("message", message);
	        	
	        	return "redirect:/archive/report/reportWrite.do";
	    	}
	    	
	    	/* List<NcmikFileVo> filses =  saveFiles(multiRequest,"uploadFile");
	            if(filses.size() > 0){	   
	            	file_id = archiveReportService.selectReportMaxId();
	                for(int i=0; i < filses.size() ; i++ ){
	                    String filePath = "";
	                    String fileNm = filses.get(i).getFileNm();
	                    String fileConvNm = filses.get(i).getFileConvNm();
	                    int lastIdx = fileConvNm.lastIndexOf("/");
	                    int typeIndx = fileNm.lastIndexOf(".");

	                    filePath = fileConvNm.substring(0,lastIdx);
	       
	                    fileConvNm = fileConvNm.substring(lastIdx+1);

	                    archiveReportVo.setFile_id(file_id);
	                    archiveReportVo.setFrst_register_id(getUser().getEmplyrkey());
	                    archiveReportVo.setFile_nm(fileNm);
	                    archiveReportVo.setFile_conv_nm(fileConvNm);
	                    archiveReportVo.setFile_path(filePath);
	                    archiveReportVo.setFile_size(filses.get(i).getFileSize());
	                    archiveReportService.insertReportFile(archiveReportVo);
	               
	                }
	            }*/
    	
    	}else{
           	message = "로그인이 필요합니다.";
        	redirectAttr.addFlashAttribute("message", message);
        	
        	return "redirect:/archive/report/reportWrite.do";
    	
    	}
    	
    	 message ="정상적으로 등록되었습니다.";
	     redirectAttr.addFlashAttribute("message", message);    	
	     return "redirect:/archive/report/reportWrite.do";

    }
    
    
    /**
     * <pre>
     *  아카이브 보고서 수정 페이지 이동
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 28. 
     * @param model
     * @param archiveReportVo
     * @param request
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/archive/report/reportEdit.do")
    public String reportEdit(Model model, ArchiveReportVo archiveReportVo, HttpServletRequest request)  throws IOException , SQLException , NullPointerException {
    	
    	//검색 PARAM	
		String page = archiveReportVo.getPage();
		String searchKeyword = archiveReportVo.getSearchKeyword();
		String searchCondition = archiveReportVo.getSearchCondition();
		
		// return 페이지 구분을 위해
		String returnPageGbn = archiveReportVo.getReturnPageGbn();
		
		// 열린 필터 갯수
		String yearCnt = archiveReportVo.getFillterYearCnt();
	
		String deptCnt = archiveReportVo.getFillterDeptCnt();		

		String subjectCnt = archiveReportVo.getFillterSubjectCnt();

		String fillterYearList = archiveReportVo.getFillterYearList_s();

		String fillterDeptList = archiveReportVo.getFillterDeptList_s();
		
		String fillterSubjectList = archiveReportVo.getFillterSubjectList_s();
		
		ArchiveReportVo resultVo = archiveReportService.selectReportInfo(archiveReportVo);		
		
		//연자정보
		List<ArchiveAnnualInfoVo> resultAnnualVo = archiveReportService.selectAnnualInfo(archiveReportVo);
		//주제분류 코드 
		List<MngCodeVo>	codeSubjectList = mngCodeService.getCodeList("ACHIVE_CD");
		//List<ArchiveReportVo>  fileList = archiveReportService.selectReportFileList(archiveReportVo);		
		
		if(resultVo != null){			
			
			    resultVo.setPage(page);
			    resultVo.setSearchKeyword(searchKeyword);
			    resultVo.setSearchCondition(searchCondition);
			    resultVo.setReturnPageGbn(returnPageGbn);
			    
			    resultVo.setFillterYearList_s(fillterYearList);

			    resultVo.setFillterDeptList_s(fillterDeptList);
			    
			    resultVo.setFillterSubjectList_s(fillterSubjectList);

			    resultVo.setFillterYearCnt(yearCnt);

			    resultVo.setFillterDeptCnt(deptCnt);
			    
			    resultVo.setFillterSubjectCnt(subjectCnt);
			    
			
		    	
		    	/*if(fileList.size() > 0){
		    		model.addAttribute("fileList", fileList);
		    	}*/
				
		    	model.addAttribute("resultVO",resultVo);
		    	model.addAttribute("codeSubjectList",codeSubjectList);	
		    	
		    	if(resultAnnualVo != null){
			    	   model.addAttribute("resultAnnualVO",resultAnnualVo);	
			    }
		}  	
		
		return "archive/report/reportEdit.tiles";
    }
    
    
    /**
     * <pre>
     * 아카이브 보고서 정보를 수정한다.
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 28. 
     * @param model
     * @param archiveReportVo
     * @param request
     * @param redirectAttr
     * @param Multirequest
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/archive/report/updateArchiveReport.do")
    public String updateArchiveReport(Model model, ArchiveReportVo archiveReportVo, HttpServletRequest request ,RedirectAttributes redirectAttr, MultipartHttpServletRequest multirequest)  throws IOException , SQLException , NullPointerException {
    
    	String file_id = "";
    	String message = "";
    	
    	if(getUser() != null){
//System.out.println("getUser().getEmplyrkey() = "+getUser().getEmplyrkey());
    		archiveReportVo.setLast_updusr_id(getUser().getEmplyrkey());
  
                 /*if(String.valueOf(request.getParameter("del_file_list")).length() > 0){
                	 List<String> del_file_list = Arrays.asList(request.getParameter("del_file_list").split(","));
	         			Map<String, Object> map = new HashMap<String, Object>();
	         			 map.put("file_id", archiveReportVo.getRep_id());
	         			 map.put("del_file_list", del_file_list);
		            	 if(!archiveReportService.deleteReportFile(map)){
			              
		                    	message = "파일 삭제에 실패하였습니다.";
		                    	redirectAttr.addFlashAttribute("archiveReportVo", archiveReportVo);
		                    	redirectAttr.addFlashAttribute("message", message);
		                        return "redirect:/archive/report/reportEdit.do";
		                  }    
                  }
                  
	                List<NcmikFileVo> filses =  saveFiles(request,"uploadFile");
		            if(filses.size() > 0){    
		            	//file_id = archiveReportService.selectReportMaxId();
		                for(int i=0; i < filses.size() ; i++ ){
		                	
			            	String filePath = "";
			        		String fileNm = filses.get(i).getFileNm();
			        		String fileConvNm = filses.get(i).getFileConvNm();
		                    int lastIdx = fileConvNm.lastIndexOf("/");
		                  

		                    filePath = fileConvNm.substring(0,lastIdx);
		       
		                    fileConvNm = fileConvNm.substring(lastIdx+1);

		                	archiveReportVo.setFile_id(archiveReportVo.getRep_id());
		            		archiveReportVo.setFrst_register_id(getUser().getEmplyrkey());
		            		archiveReportVo.setFile_nm(fileNm);
		            		archiveReportVo.setFile_conv_nm(fileConvNm);
		            		archiveReportVo.setFile_path(filePath);
		            		archiveReportVo.setFile_size(filses.get(i).getFileSize());
		            		archiveReportService.insertReportFile(archiveReportVo);	

		                }
		            }*/
	        
            if(archiveReportVo.getCon_type().equals("1")){
    			archiveReportVo.setPrivate_str_dt("");
    			archiveReportVo.setPrivate_end_dt("");
    			archiveReportVo.setPrivate_rs("");
    		}
    		/*if(archiveReportVo.getSecurity_level().equals("1")){
    			archiveReportVo.setSecurity_rs("");
    		}*/
    		
	    	if(!archiveReportService.updateArchiveReport(archiveReportVo)){
	    		message = "수정이 실패하였습니다.";
	        	redirectAttr.addFlashAttribute("message", message);
        	    redirectAttr.addFlashAttribute("archiveReportVo", archiveReportVo);   
	        	return "redirect:/archive/report/reportView.do?rep_id="+archiveReportVo.getRep_id();
	    	}
    	
    	}else{
           	message = "로그인이 필요합니다.";
        	redirectAttr.addFlashAttribute("message", message);
        	
        	return "redirect:/archive/report/reportList.do";
    	
    	}
    	
    	 message ="정상적으로 등록되었습니다.";
	     redirectAttr.addFlashAttribute("message", message);    	
	  
	     redirectAttr.addFlashAttribute("archiveReportVo", archiveReportVo);    
	     return "redirect:/archive/report/reportView.do?rep_id="+archiveReportVo.getRep_id();

    }
    
    
    
    /**
     * <pre>
     * 아카이브 보고서 목록을 삭제한다.
     * 
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 28. 
     * @param model
     * @param archiveReportVo
     * @param request
     * @param redirectAttr
     * @param Multirequest
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/archive/report/deleteArchiveReport.do")
    public String deleteArchiveReport(Model model, ArchiveReportVo archiveReportVo, HttpServletRequest request ,RedirectAttributes redirectAttr, MultipartHttpServletRequest multirequest)  throws IOException , SQLException , NullPointerException  {
    	
    	String message = "";
    	if(getUser() != null){

    		archiveReportVo.setLast_updusr_id(getUser().getEmplyrkey());
    		
	    	if(!archiveReportService.deleteArchiveReport(archiveReportVo)){
	    		message = "삭제에 실패하였습니다.";
	        	redirectAttr.addFlashAttribute("message", message);
        	    redirectAttr.addFlashAttribute("archiveReportVo", archiveReportVo);   
	        	return "redirect:/archive/report/reportList.do";
	    	}
    	
    	}else{
           	message = "로그인이 필요합니다.";
        	redirectAttr.addFlashAttribute("message", message);
    	  
        	return "redirect:/archive/report/reportList.do";
    	
    	}
    	
    	 message ="삭제되었습니다.";
	     redirectAttr.addFlashAttribute("message", message);    	
	     redirectAttr.addFlashAttribute("archiveReportVo", archiveReportVo);    
	     return "redirect:/archive/report/reportList.do";

    }
   
    @RequestMapping(value="/archive/report/downFile.do", method=RequestMethod.POST)
    public String download(String down_file_sn,String down_file_id, HttpServletRequest request, HttpServletResponse response) throws IOException , SQLException , NullPointerException {
		return down_file_id;
/*
    		ArchiveReportVo downVo = null;
    		ArchiveReportVo archiveReportVo = archiveReportService.retrieveFile(down_file_sn, down_file_id);
    		String upd_yn = request.getParameter("upd_yn");

    		if(StringUtils.equals(upd_yn, "Y")){

    			downVo = new ArchiveReportVo();
    			downVo.setRep_id(down_file_id);
    			archiveReportService.updateDownCnt(downVo);
    		}
    		
			String path = Constants.uPLOAD_PATH;
		
			if (archiveReportVo != null) {
            File file = new File(path+"/"+ archiveReportVo.getFile_conv_nm());

            if (file.canRead()) {
                String userAgent = request.getHeader("User-Agent");
                


                String fileName = null;
                if(userAgent.contains("MSIE") || userAgent.contains("Trident") || userAgent.contains("Chrome")){
                	fileName = URLEncoder.encode(archiveReportVo.getFile_nm(),Constants.ENCODING_TYPE).replaceAll("\\+", "%20");
                } else {
                	fileName = new String(archiveReportVo.getFile_nm().getBytes(Constants.ENCODING_TYPE), "ISO-8859-1");
                }
                
                response.reset();

                response.setContentType("application/octet-stream; " + Constants.ENCODING_TYPE);
                response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
                response.setHeader( "Content-Transfer-Encoding", "binary;" );
                response.setHeader( "Content-Length", "" + file.length() );
                response.setHeader( "Pragma", "no-cache;" );
                response.setHeader( "Expires", "-1;" );

                FileInputStream fis = null;
                OutputStream out  = null;
                try {
                    fis = new FileInputStream(file);
                    out = response.getOutputStream();
                    FileCopyUtils.copy(fis, out);
                    out.flush();
                } catch (IOIOException , SQLException , NullPointerException e) {
                    if (logger.isErrorEnabled()) {logger.debug("err download");}
                } finally {
                    CloseUtil.closeQuietly(fis);
                    CloseUtil.closeQuietly(out);
                }
                return null;    // 파일 전송 완료.
            }
        }

        return "/error/fileNotFound";    // 파일 없음.
*/    }    
    
    
    
    /**
     * <pre>
     * 아카이브 보고서 파일 일괄 업로드 화면으로 이동 
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 4. 3. 
     * @param model
     * @param archiveReportVo
     * @param request
     * @param response
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/archive/report/reportUpload.do")
    public String reportUpload(Model model, ArchiveReportVo archiveReportVo, HttpServletRequest request , HttpServletResponse response)  throws IOException , SQLException , NullPointerException {
    	
    
    	model.addAttribute("archiveReportVo", archiveReportVo);
    	
    	return "archive/report/reportUpload.tiles";
    }
    
   
   
    /**
     * <pre>
     * 아카이브 보고서 파일을 업로드한다.
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 4. 3. 
     * @param model
     * @param archiveReportVo
     * @param request
     * @param redirectAttr
     * @param resp
     * @param out
     * @param Multirequest
     * @throws IOException , SQLException , NullPointerException
     */
   
    @RequestMapping("/archive/report/reportExcelUpload.do")
    public void reportExcelUpload(Model model, ArchiveReportVo archiveReportVo, HttpServletRequest request ,RedirectAttributes redirectAttr,  HttpServletResponse resp, Writer out ,MultipartHttpServletRequest multirequest)  throws IOException , SQLException , NullPointerException {
    
    	String message = "";
    	String savePath = "";
    	String path = 	"";
    	
    	File zipFile = null;
    	File dir = null;
    	File[] fileList = null;
    	
    	MultipartFile file =  multirequest.getFile("uploadFile");
        	
    	// ******** 압축 파일 해당 경로에 넣기 STR *********
    	
    	/*
    	MultipartFile files =  Multirequest.getFile("uploadZipFile");
    	ZipUtil zi = new ZipUtil();
    	FileConvUtil filecv = new FileConvUtil();
    	if( files  != null){
	    
	    	zipFile= filecv.multipartToFile(files);
	    	savePath = saveFilePattern.format(Calendar.getInstance().getTime());
	    	path =  Constants.uPLOAD_PATH_ZIP;
	 
	    	dir = new File(path+savePath);
	    	if (!dir.canRead()){ 
	    		
	    		dir.mkdirs();    	 
	    	}
	    	zi.unzip(zipFile , new File(path+savePath) , "EUC-KR");	    		    	
    	}*/
    	
    	// ******** 압축 파일 해당 경로에 넣기 END *********    
    
    	List<ArchiveReportVo> result =null;
        List<ArchiveReportVo> outResult =null;
     
        
        MngCodeVo	codeSubject  = null;
        
        String subject_cd = "";            	
        String subject_cd_nm ="";

        String xml = "";
       
        
        boolean insertFlag = true; 
        
        try {
        	

            //파일업로드 키 : 자료순번 + 기관코드 + 사용자
      
            //엑셀 처리
            result = archiveReportService.reportExcelUpload(file);
         	outResult = new ArrayList<ArchiveReportVo>();
            if(result.size() > 0){
	            for(int  i = 0 ; i < result.size() ; i++ ){

	            	String errorData = "";
	            	boolean errState = false;	    
	            	
	            	// ********* 발주부서명 체크 위해(명칭 화면에 보여주기) STR *********
	            	subject_cd_nm ="";
	            	subject_cd = result.get(i).getSubject().trim();	            	            	
	            	if(!subject_cd.equals("")){	            		            	    
	            	
	            		//주제분류 코드 
        				codeSubject = mngCodeService.getCode("ACHIVE_CD", subject_cd);
					
		                if(codeSubject != null ){							
		                	subject_cd_nm = String.valueOf(codeSubject.getCd_nm());
							
							if(!subject_cd_nm.equals("") && subject_cd_nm != null){
								result.get(i).setSubject_nm(subject_cd_nm);
							}else{
								result.get(i).setSubject_nm("codeErr");
								errState = true;
			            		errorData += "[주제분류 코드에러],";
							}
						}else{
							result.get(i).setSubject_nm("codeErr");
							errState = true;
		            		errorData += "[주제분류 코드에러],";
						}											
	            	}
	            	// ********* 발주부서명 체크 위해(명칭 화면에 보여주기) END *********

	                    	
	            	
	            	/*
	            	 * 기존거 ~ zip 파일 포함해서 하던것 ... 아까워서 남겨둠
	            	*/
	            	
	            	/*
	            	/// 검증 STR
	            	// 센터명
	            	if(StringUtils.isBlank(result.get(i).getCenter_nm())){
	            		errState = true;	
	            		errorData += "[센터명 Null], ";
	            	}
	            	// 발주부서 
	            	if(StringUtils.isBlank(result.get(i).getOrder_dept())){
	            		errState = true;	
	            		errorData += "[발주부서 Null], ";
	            	}
	            	// 담당자 
	            	if(StringUtils.isBlank(result.get(i).getCharger_nm())){
	            		errState = true;	
	            		errorData += "[담당자 Null], ";
	            	}
	            	// 발행년도
	            	if(StringUtils.isBlank(result.get(i).getPubyear())){
	            		errState = true;
	            		errorData += "[발행년도 Null], ";
	            	}else{
	            		if(!isNumber(result.get(i).getPubyear()) ){
		            		errState = true;
		            		errorData += "[발행년도 숫자타입오류], ";
		            	}
	            		if(result.get(i).getPubyear().length() != 4  ){
	            			errState = true;
	            			errorData += "[발행년도 길이입력 오류("+result.get(i).getPubyear().length()+")], ";
	            		}
	            	}
	            	
	            	// 연차구분
	            	if(StringUtils.isBlank(result.get(i).getAnnual_gbn())){
	            		errState = true;
	            		errorData += "[연차구분 Null], ";
	            	}else{
	            		if(!isNumber(result.get(i).getAnnual_gbn())){
		            		errState = true;
		            		errorData += "[연차구분 숫자타입오류], ";
		            	}
	            		if(result.get(i).getAnnual_gbn().length() != 1){
	            			errState = true;
		            		errorData += "[연차구분 길이입력 오류("+result.get(i).getAnnual_gbn().length()+")], ";
	            		}
	            		if( Integer.parseInt(result.get(i).getAnnual_gbn()) < 0 && Integer.parseInt(result.get(i).getAnnual_gbn()) > 2 ){
	            			errState = true;
		            		errorData += "[연차구분 값 입력 오류( 1 :단년도 2:다년도)], ";
	            		}
	            	}
	            	
	            	// 연차 
	            	if(StringUtils.isBlank(result.get(i).getAnnual_num())){
	            		errState = true;	            	
	            		errorData += "[연차 Null], ";	            		
	            	}else{
	            		 if(!isNumber(result.get(i).getAnnual_num())){
	            			 errState = true;
	            			 errorData += "[연차 숫자타입오류], ";
	            		 }
	            	}
	            	// 사업명 
	            	if(StringUtils.isBlank(result.get(i).getBusi_nm())){
	            		errState = true;	
	            		errorData += "[사업명 Null], ";	  
	            	}
	            	// 세부사업명 
	            	if(StringUtils.isBlank(result.get(i).getDetail_busi_nm())){
	            		errState = true;
	            		errorData += "[세부사업명 Null], ";	  
	            	}
	            	// 보안등급
	            
	            	if(StringUtils.isBlank(result.get(i).getSecurity_level())){
	            		errState = true;	           
	            		errorData += "[보안등급 Null], ";
	            	}else{
	            		if(!isNumber(result.get(i).getSecurity_level())){
		            		errState = true;
		            		errorData += "[보안등급 코드숫자타입오류], ";
		            	}
	            		if(result.get(i).getSecurity_level().length() != 1){
	            			errState = true;
	            		
		            		errorData += "[보안등급 길이입력 오류("+result.get(i).getAnnual_gbn().length()+")], ";
	            		}
	            		if(Integer.parseInt(result.get(i).getAnnual_gbn()) > 1 || Integer.parseInt(result.get(i).getAnnual_gbn()) < 0){
	            			errState = true;
		            		errorData += "[보안등급 값 입력 오류( 1 : 일반과제 0 : 보안과제)], ";
	            		}
	            		// 보안과제 사유
            			if(StringUtils.isBlank(result.get(i).getSecurity_rs())){
		            		errState = true;
		            		errorData += "[보안과제 사유를 입력해주십시오], ";
		            	}
	            	
	            	}
	            		            	
	            	// 공개여부
	            	
	            	if( StringUtils.isBlank(result.get(i).getCon_type())){
	            		errState = true;
	            		errorData += "[공개여부 Null], ";
	            	}else{
	            		if(!isNumber(result.get(i).getCon_type())){
		            		errState = true;
		            	
		            		errorData += "[공개여부 코드 숫자타입오류], ";
		            	}
	            		if( result.get(i).getCon_type().length() != 1){
	            			errState = true;	            		
		            		errorData += "[공개여부 길이입력 오류("+result.get(i).getCon_type().length()+")], ";
	            		}
	            		if(Integer.parseInt(result.get(i).getCon_type()) > 1 || Integer.parseInt(result.get(i).getCon_type()) < 0){
	            			errState = true;		
		            		errorData += "[공개여부 값 입력 오류( 1 : 공개 0 : 비공개)], ";
	            		}
	            		
	            		
	            		// 비공개 사유
	            		if(StringUtils.isBlank(result.get(i).getPrivate_rs())){
		            		errState = true;
		            		errorData += "[비공개 사유를 입력해주십시오], ";
		            	}
	            		// 비공개 시작일자 , 종료일자
	            		if(StringUtils.isBlank(result.get(i).getPrivate_str_dt()) ){
		            		errState = true;  
		            		errorData += "[비공개시작일자 Null], ";
		            	}else{
		            		if(!isNumber(result.get(i).getPrivate_str_dt())){
		            			errState = true;  
		            			errorData += "[비공개시작일자 숫자타입오류], ";
		            		} 
		            		if( result.get(i).getPrivate_str_dt().length() !=  8){
		            			errState = true;  
		            			errorData += "[비공개시작일자 길이입력 오류("+result.get(i).getPrivate_str_dt().length()+")], ";
		            		}
		            	}
	            		
	            		// 비공개 시작일자 , 종료일자
	            		if(StringUtils.isBlank(result.get(i).getPrivate_end_dt()) ){
		            		errState = true;  
		            		errorData += "[비공개종료일자 Null], ";
		            	}else{
		            		if(!isNumber(result.get(i).getPrivate_end_dt())){
		            			errState = true;  
		            			errorData += "[비공개종료일자 숫자타입오류], ";
		            		} 
		            		if( result.get(i).getPrivate_end_dt().length() !=  8){
		            			errState = true;  
		            			errorData += "[비공개종료일자 길이입력 오류("+result.get(i).getPrivate_end_dt().length()+")], ";
		            		}
		            	}
	            		
	            	
	            	}

	            	// 연구과제명_한글
	            	if(StringUtils.isBlank(result.get(i).getProj_tit_kor())){
	            		errState = true;
	            		errorData += "[연구과제명_한글 Null], ";
	            	}
	            	// 연구과제명_영문
	            	if(StringUtils.isBlank(result.get(i).getProj_tit_eng())){
	            		errState = true;
	            		errorData += "[연구과제명_영문 Null], ";
	            	}
	            	// 책임연구원
	            	if(StringUtils.isBlank(result.get(i).getPi())){
	            		errState = true;
	            		errorData += "[책임연구원 Null], ";
	            	}
	            	// 책임연구원_소속
	            	if(StringUtils.isBlank(result.get(i).getPi_dept())){
	            		errState = true;
	            		errorData += "[책임연구원_소속 Null], ";
	            	}
	            	// 참여연구원
	            	if(StringUtils.isBlank(result.get(i).getRp())){
	            		errState = true;
	            		errorData += "[참여연구원 Null], ";
	            	}
	             	// 참여연구원_소속
	            	if(StringUtils.isBlank(result.get(i).getRp_dept())){
	            		errState = true;
	            		errorData += "[참여연구원_소속 Null], ";
	            	}
	            	// 주관연구기관
	            	if(StringUtils.isBlank(result.get(i).getOrg_name())  ){
	            		errState = true;
	            		errorData += "[주관연구기관 Null], ";
	            	}
	            	// 색인단어_한글
	            	if(StringUtils.isBlank(result.get(i).getKeyword_kor())){
	            		errState = true;   
	            		errorData += "[색인단어_한글 Null], ";
	            	}
	            	// 색인단어_영문
	            	if(StringUtils.isBlank(result.get(i).getKeyword_eng())){
	            		errState = true;      
	            		errorData += "[색인단어_영문 Null], ";
	            	}
	            	// 보고서_초록
	            	if(StringUtils.isBlank(result.get(i).getRep_abs())){
	            		errState = true;   
	            		errorData += "[보고서_초록 Null], ";
	            	}
	            	// 과제번호
	            	if(StringUtils.isBlank(result.get(i).getBusino())){
	            		errState = true;  
	            		errorData += "[과제번호 Null], ";
	            	}
	            	   	
	            	// 파일 확인
	            	if(StringUtils.isNotBlank(result.get(i).getExcel_upload()) && !result.get(i).getExcel_upload().equals("false")){
	            		
	            		int idx = -1;
	            		String type = "";
	            		idx = result.get(i).getExcel_upload().lastIndexOf(".");
	            		
	            		if(idx != -1){  // 확장자
	            			type  = StringUtils.lowerCase(result.get(i).getExcel_upload().substring(idx+1, result.get(i).getExcel_upload().length()));
	            		}else{
	            			type = "";
	            		}
	            		//  아래 확장자로 안끝나면 에러  
	            		// else = > 파일명이 들어있고  확장자가 맞으면	            	
	            		System.out.println("type===" + type);
	            	 	if(!type.equals("jpg")  && !type.equals("gif")  && !type.equals("png")  && !type.equals("jpeg") && !type.equals("pdf") && !type.equals("hwp") && !type.equals("txt")   ){
	            	 	    // 확장자 에러 
	            	 		errState = true;  
	            	 		result.get(i).setExcel_upload_err("typeErr ,");
	            	 		
	            	 	}else{
	            	 		// 엑셀에 파일명이 명시가 되어있는데 zip 파일안에 없으면 에러
	            	 		fileList=dir.listFiles();
		            		if(fileList != null){
			                	for(File tempFile : fileList) {
			                	  if(tempFile.isFile()) {
			                	    //String tempPath=tempFile.getParent();
			                	    String tempFileName=tempFile.getName();  	
			                	 
			                	    String tempFn = StringUtils.replace(StringUtils.lowerCase(tempFileName) , " " , "");
			                	    String excelUp = StringUtils.replace(StringUtils.lowerCase(result.get(i).getExcel_upload())  , " " , "");
			                	    
			                	    if(!tempFn.equals(excelUp) ){  // 파일이없을때
			                	    	errState = true;
			                	    	result.get(i).setExcel_upload_err("NotFile ,");
			                	    }
			                	  }
			                	}
		            		}
	            	 	}
	            	 	
	            	}*/
	            	
	            	/*
	            	 * 검증 STR ***********************************************
	            	*/
	            	
	            	
	            	// 과제번호
	            	if(StringUtils.isBlank(result.get(i).getBusino())){
	            		errState = true;  
	            		errorData += "[과제번호 Null]<br/>,";
	            	}

	            	// 연구과제명_한글
	            	if(StringUtils.isBlank(result.get(i).getProj_tit_kor()) && StringUtils.isBlank(result.get(i).getProj_tit_eng()) ){
		            	errState = true;
		            	errorData += "[연구과제명(국문 OR 영문 입력) Null]<br/>,";
	            	}
	            	// 연구과제명_영문
	            	/*if(StringUtils.isBlank(result.get(i).getProj_tit_eng())){
		            	errState = true;
		            	errorData += "[연구과제명_영문 Null], ";
	            	}*/
	            	// 책임연구원
	            	if(StringUtils.isBlank(result.get(i).getPi())){
		            	errState = true;
		            	errorData += "[책임연구원 Null]<br/>,";
	            	}
	            	// 주관연구기관
	            	if(StringUtils.isBlank(result.get(i).getOrg_name())  ){
		            	errState = true;
		            	errorData += "[주관연구기관 Null]<br/>,";
	            	}

	            	// 발행년도
	            	if(StringUtils.isBlank(result.get(i).getPubyear())){
		            	errState = true;
		            	errorData += "[발행년도 Null]<br/>,";
	            	}else{
		            	if(!isNumber(result.get(i).getPubyear()) ){
			            	errState = true;
			            	errorData += "[발행년도 숫자타입오류]<br/>,";
		            	}
		            	if(result.get(i).getPubyear().length() != 4  ){
			            	errState = true;
			            	errorData += "[발행년도 길이입력 오류("+result.get(i).getPubyear().length()+")]<br/>,";
		            	}
	            	}

	            		// 첨부파일키  
	            	if(StringUtils.isBlank(result.get(i).getAtch_link_id())){
	            		errState = true;	
	            		errorData += "[첨부파일키 Null]<br/>,";	  
	            	}
	            	/*
	            	 * 검증 END ***********************************************
	            	*/
	            	
	            	if(errState == true){  // row에 에러가 한번이라도 발생하면 
	            		result.get(i).setError_cn(errorData);
	            		outResult.add(result.get(i));
	            		insertFlag = false;
	            	}
	            }
	          // 에러가 발생하지 않으면 파일과 목록을 등록한다.
	            if(insertFlag == true){  
		           try{
		        	   if(result.size() > 0){
		        		   if(getUser() != null){
				            	for(int  j = 0 ; j < result.size() ; j++ ){
				            		result.get(j).setFrst_register_id(getUser().getEmplyrkey());
				            		result.get(j).setCon_type("1");
				            		archiveReportService.insertArchiveReport(result.get(j));
				            		
				            		/*
				            		 * 기존거 .. zip파일 
				            		*/
				            		/* if(dir!= null){
				            	 		fileList=dir.listFiles();
					            		if(fileList != null){
						                	for(File tempFile : fileList) {
						                		if(tempFile.isFile()) {
						                		 
						                		  String tempFileName=tempFile.getName();  
						                		 
						                		  String tempFn = StringUtils.replace(StringUtils.lowerCase(tempFileName) , " " , "");
							                	  String excelUp = StringUtils.replace(StringUtils.lowerCase(result.get(j).getExcel_upload())  , " " , "");
						                		 
							                	  if(tempFn.equals(excelUp) ){
								                	  
						                			   MultipartFile resultFile =  filecv.fileToMultipartFile(tempFile);
								                	   List<NcmikFileVo> filses =  saveExcelUploadFiles(resultFile);
					                	  						                	   
								                	   if(filses.size() > 0){	   
									       	            	
								                		   String file_id = archiveReportService.selectReportMaxId();
									       	               
									       	            	for(int i=0; i < filses.size() ; i++ ){
									       	                    String filePath = "";
									       	                    String fileNm = filses.get(i).getFileNm();
									       	                    String fileConvNm = filses.get(i).getFileConvNm();
									       	                    int lastIdx = fileConvNm.lastIndexOf("/");
		
									       	                    filePath = fileConvNm.substring(0,lastIdx);
									       	       
									       	                    fileConvNm = fileConvNm.substring(lastIdx+1);
		
									       	                    archiveReportVo.setFile_id(file_id);
									       	                    archiveReportVo.setFrst_register_id(getUser().getEmplyrkey());
									       	                    archiveReportVo.setFile_nm(fileNm);
									       	                    archiveReportVo.setFile_conv_nm(fileConvNm);
									       	                    archiveReportVo.setFile_path(filePath);
									       	                    archiveReportVo.setFile_size(filses.get(i).getFileSize());
									       	                    archiveReportService.insertReportFile(archiveReportVo);
									       	                }  
								       	            	}
							                	    }
						                		}
						                	}
					            		}
				            		}
				            		*/
				            		
				            	
				            	}
				            	message = "success";
		        		   }else{
		        			   message = "login";
		        		   }
		        	    }else{
		        	    	message = "not";
		        	    }
	        			
		            }catch(IOException ex ){
		            	message = "fail";
					}catch(SQLException ex){
						message = "fail";
					}
					
	            }
	            
        		
            }
              StringBuffer sb = new StringBuffer();
            if(outResult != null && outResult.size() > 0){
				xml = XmlUtil.listToXml(outResult);
				//System.out.println("xml= " + xml);
		    	
		    	String[] str = xml.split("<items>");	    	    	
		    	sb.append(str[0]);
		    	sb.append("<items>");  
		     	sb.append("<resultVal>"+message+"</resultVal>\n");
		    	sb.append(str[1]);  	    	
		    	    	
            }else{

               	
               	sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n");
               	sb.append("<items>\n");
               	sb.append("<item><resultVal>"+message+"</resultVal></item>\n");
            	sb.append("</items>\n");		    	
            }
            
        	xml = sb.toString();
    
	    	resp.setContentType("text/xml");
	    	resp.setCharacterEncoding("UTF-8");
	    	resp.setHeader("Cache-Control", "no-cache");
	    	resp.setHeader("Pragma", "no-cache");
	    	resp.setDateHeader("Expires", -1);
	    	out.write(xml);
	   	
	    	out.flush();
    
           


        }catch(IOException ex ){
    		logger.debug("err reportExcelUpload IOException");
		}catch(SQLException ex){
			logger.debug("err reportExcelUpload SQLException");
		}
    	
    }
   
    
    
    
	@RequestMapping("/archive/report/xlsReportDownLoad.do")
	public void xlsReportDownLoad(Model model, ArchiveReportVo archiveReportVo, HttpServletRequest request ,RedirectAttributes redirectAttr,  HttpServletResponse response) throws IOException , SQLException , NullPointerException {
		
		try {
			
	
				
		ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
		
		/************************Sheet1 엑셀 정보 출력****************************/
		ArrayList colinfoReportList = new ArrayList();
		String[][] col_name_report = {
				
				{"BUSINO","과제번호"},
				{"PROJ_TIT_KOR","연구과제명_국문"},
				{"PROJ_TIT_ENG","연구과제명_영문"},
				{"PI","책임연구원"},
				{"ORG_NAME","발행자"},
				{"PUBYEAR","발행년도(숫자 4자리)"},
				{"SUBJECT","주제(코드 입력)"},
				{"ATCH_LINK_ID","첨부파일키"}

		};
		
		for(int i = 0; i < col_name_report.length; i++)
		{
			HashMap ifReportmap = new HashMap();
			ifReportmap.put("COL_NAME", col_name_report[i][0]);
			ifReportmap.put("COL_INFO_REPORT", col_name_report[i][1]);
			colinfoReportList.add(ifReportmap);
		}
		
		/************************Sheet2 엑셀 정보 출력 str****************************/
		ArrayList colinfoList = new ArrayList();
		
		String[][] col_name = {
				{"CD",	 "코드"},
				{"CDNM",	"코드명"}					
		};
		
		
		for(int i = 0; i < col_name.length; i++)
		{
			HashMap ifmap = new HashMap();
			ifmap.put("COL_NAME", col_name[i][0]);
			ifmap.put("COL_INFO", col_name[i][1]);
			colinfoList.add(ifmap);
		}
		List<MngCodeVo>	codeSubjectList  = null;	
	    codeSubjectList = mngCodeService.getCodeList("ACHIVE_CD");
		
		/*
		 * 질의 결과를 그대로 엑셀에 저장할 수 없으므로 데이터를 가공한다.
		 * 그대로 저장해도 되는 경우(가공이 필요없는 경우) 이부분은 생략한다....
		 * @return 
		*/ 
		
		List reportXlsList = new ArrayList();
		if(codeSubjectList != null){
			for(int i = 0; i < codeSubjectList.size(); i++)
			{
				MngCodeVo vo = (MngCodeVo) codeSubjectList.get(i);
			
				HashMap rsmap = new HashMap();
				//rsmap.put("RN", vo.getRn());
				rsmap.put("CD", vo.getCd());
				rsmap.put("CDNM", vo.getCd_nm());
				
	
				reportXlsList.add(rsmap);
			}
		}
		/************************Sheet2 엑셀 정보 출력 end****************************/
		
		
		
		String fileName = "아카이브_보고서";
		String title = "아카이브_보고서";
		xlsDownUtil.excelReportWrite(response, colinfoReportList,  reportXlsList ,colinfoList ,  fileName, title);
		}catch(IOException ex ){
			logger.debug("Excel error xlsReportDownLoad IOException");
		}catch(SQLException ex){
			logger.debug("Excel error xlsReportDownLoad SQLException");
		}
	}

	
	
	
	 /**
     * <pre>
     * 
     * 아카이브 보고서 - 첨부파일 다운로드 
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 16. 
     * @param request
     * @param archiveReportVo
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/archive/report/reportDownUpdate.do")
    public void reportDownUpdate(HttpServletRequest request, ArchiveReportVo archiveReportVo)  throws IOException , SQLException , NullPointerException {
    
    	ArchiveReportVo downVo = null;
    	String idVal = archiveReportVo.getRep_id();
		String upd_yn = request.getParameter("upd_yn");
		
		if(StringUtils.equals(upd_yn, "Y")){
			downVo = new ArchiveReportVo();
			downVo.setRep_id(idVal);
			archiveReportService.updateDownCnt(downVo);
		}

    }
	
}
