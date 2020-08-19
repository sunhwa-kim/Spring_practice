package kr.go.cris.ptl.archive.rnd.controller;

import java.io.IOException;
import java.io.Writer;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.commons.code.service.CodeService;
import kr.go.cris.commons.code.vo.CodeVo;
import kr.go.cris.commons.utils.XmlUtil;
import kr.go.cris.ptl.archive.rnd.service.ArchiveRndService;
import kr.go.cris.ptl.archive.rnd.vo.ArchiveRndVo;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


/**
 * <pre>
 * 아카이브 성과논문
 * 
 * </pre>
 * @FileName : ArchiveRndController.java
 * @package  : kr.go.cris.ptl.archive.rnd.controller
 * @author   : wonki0138
 * @date     : 2018. 3. 16.
 * 
 */
@Controller
public class ArchiveRndController extends BaseController {

    @Resource
    private ArchiveRndService archiveRndService;
    
    @Resource
    private CodeService codeService;

    /**
     * <pre>
     * 아카이브 성과논문 - 목록화면 이동
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 16. 
     * @param model
     * @param archiveRndVo
     * @param request
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/archive/rnd/rndList.do")
    public String rndList(Model model, ArchiveRndVo archiveRndVo, HttpServletRequest request)  throws IOException , SQLException , NullPointerException {
 
    
    	model.addAttribute("archiveRndVo", archiveRndVo);
    	
    	return "archive/rnd/rndList.tiles";
    }

  
    /**
     * <pre>
     * 
     * 아카이브 성과논문 - 목록 화면
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 16. 
     * @param request
     * @param archiveRndVo
     * @param resp
     * @param out
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("archive/rnd/rndRead.do")
    public void rndRead(HttpServletRequest request, ArchiveRndVo archiveRndVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
    	

    	String xml = "";    
    	
    	//  ******************************* 필터 검색조건 STR *********************************
    	
    	List<String> fillterYearList  =  null;
    	List<String> fillterLangList  =  null;
  
    	
    	if(StringUtils.isNotBlank(archiveRndVo.getFillterYearList())){
    		
    		fillterYearList =  new ArrayList<String>();		
    		for(String year : archiveRndVo.getFillterYearList().split(",")){
        		fillterYearList.add(year);    		
        	}
    	}

    	archiveRndVo.setFillterYearList_L(fillterYearList);
   
   
    	
    	//  ******************************* 필터 검색조건 END *********************************
    	
    	List<ArchiveRndVo> list = archiveRndService.selectRndList(archiveRndVo);
    	
    	int totalCnt = archiveRndService.selectRndTotalCount(archiveRndVo);
    	
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
    	    	sb.append("<totalPageCnt>"+Math.ceil((double)totalCnt/(double)archiveRndVo.getPageSize())+"</totalPageCnt>\n");    	 
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
     * 아카이브 성과논문 - 상세 조회
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 16. 
     * @param model
     * @param archiveRndVo
     * @param request
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping(value="/archive/rnd/rndView.do", method=RequestMethod.POST)
	public String rndView(Model model, ArchiveRndVo archiveRndVo, HttpServletRequest request ) throws IOException , SQLException , NullPointerException{
		
    	//검색 PARAM	
		String page = archiveRndVo.getPage();
		String searchKeyword = archiveRndVo.getSearchKeyword();
		String searchCondition = archiveRndVo.getSearchCondition();
		
		// return 페이지 구분을 위해
		String returnPageGbn = archiveRndVo.getReturnPageGbn();

		// 열린 필터 갯수
		String yearCnt = archiveRndVo.getFillterYearCnt();

		String fillterYearList = archiveRndVo.getFillterYearList_s();
		
	
		if(StringUtils.equals(archiveRndVo.getUpd_yn(), "Y")){
			archiveRndService.updateReadCnt(archiveRndVo);
		}
		
		ArchiveRndVo resultVo = archiveRndService.selectRndInfo(archiveRndVo);			   	
		//List<ArchiveRndVo>  fileList = archiveRndService.selectRndFileList(archiveRndVo);
		if(resultVo != null){			
			
			    resultVo.setPage(page);
			    resultVo.setSearchKeyword(searchKeyword);
			    resultVo.setSearchCondition(searchCondition);
			    resultVo.setReturnPageGbn(returnPageGbn);
			    
			    resultVo.setFillterYearList_s(fillterYearList);

			    resultVo.setFillterYearCnt(yearCnt);

			  //  if (fileList.size() > 0) {

			//		model.addAttribute("fileList", fileList);
			//	}
			    
				model.addAttribute("resultVO",resultVo);				
		}  	
		
		return "archive/rnd/rndView.tiles";
    }
    /**
     * <pre>
     *
     * 아카이브 성과논문 - 상세 조회
     * </pre> 
     * @author : wonki0138
     * @date   : 2018. 3. 16. 
     * @param model
     * @param archiveRndVo
     * @param request
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/search/rnd/rndView.do")
    public String rndView2(Model model, ArchiveRndVo archiveRndVo, HttpServletRequest request ) throws IOException , SQLException , NullPointerException{
    	
    	//검색 PARAM	
    	String page = archiveRndVo.getPage();
    	String searchKeyword = archiveRndVo.getSearchKeyword();
    	String searchCondition = archiveRndVo.getSearchCondition();
    	
    	// return 페이지 구분을 위해
    	String returnPageGbn = archiveRndVo.getReturnPageGbn();
    	
    	// 열린 필터 갯수
    	String yearCnt = archiveRndVo.getFillterYearCnt();
    	
    	String fillterYearList = archiveRndVo.getFillterYearList_s();
    	
    	
    	if(StringUtils.equals(archiveRndVo.getUpd_yn(), "Y")){
    		archiveRndService.updateReadCnt(archiveRndVo);
    	}
    	
    	ArchiveRndVo resultVo = archiveRndService.selectRndInfo(archiveRndVo);			   	
    	//List<ArchiveRndVo>  fileList = archiveRndService.selectRndFileList(archiveRndVo);
    	if(resultVo != null){			
    		
    		resultVo.setPage(page);
    		resultVo.setSearchKeyword(searchKeyword);
    		resultVo.setSearchCondition(searchCondition);
    		resultVo.setReturnPageGbn(returnPageGbn);
    		
    		resultVo.setFillterYearList_s(fillterYearList);
    		
    		resultVo.setFillterYearCnt(yearCnt);
    		
    		model.addAttribute("resultVO",resultVo);				
    	}  	
    	
    	model.addAttribute("returnSearchPage","T");	
    	
    	return "archive/rnd/rndView.tiles";
    }
    
   
    
    /**
     * <pre>
     *
     * 우측 영역 검색 결과 제한 (메뉴)를 호출한다.
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 21. 
     * @param request
     * @param archiveRndVo
     * @param resp
     * @param out
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("archive/rnd/rndRightMenuRead.do")
    public void rndRightMenuRead(HttpServletRequest request, ArchiveRndVo archiveRndVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
    	

    	String xml = "";    	
    	List<ArchiveRndVo> list = archiveRndService.selectRndFillterList(archiveRndVo);
    	
    
    	
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
     * 아카이브 성과논문 등록페이지로 이동 
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 28. 
     * @param model
     * @param archiveRndVo
     * @param request
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/archive/rnd/rndWrite.do")
    public String rndWrite(Model model, ArchiveRndVo archiveRndVo, HttpServletRequest request)  throws IOException , SQLException , NullPointerException {
     	
    
    	model.addAttribute("archiveRndVo", archiveRndVo);
    	
    	return "archive/rnd/rndWrite.tiles";
    }
    
    
    /**
     * <pre>
     * 아카이브 성과논문을 등록한다
     * 
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 27. 
     * @param model
     * @param archiveRndVo
     * @param request
     * @param redirectAttr
     * @param Multirequest
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/archive/rnd/insertArchiveRnd.do")
    public String insertArchiveRnd(Model model, ArchiveRndVo archiveRndVo, HttpServletRequest request ,RedirectAttributes redirectAttr, MultipartHttpServletRequest multiRequest)  throws IOException , SQLException , NullPointerException {
    	String file_id = "";
    	String message = "";
    	if(getUser() != null){
 
    		archiveRndVo.setFrst_register_id(getUser().getEmplyrkey());
    		
	    	if(!archiveRndService.insertArchiveRnd(archiveRndVo)){
	    		message = "fail";
	        	redirectAttr.addFlashAttribute("message", message);
	        	
	        	return "redirect:/archive/rnd/rndWrite.do";
	    	}
	    	 /*List<NcmikFileVo> filses =  saveFiles(multiRequest,"uploadFile");
	            if(filses.size() > 0){	   
	            	file_id = archiveRndService.selectRndMaxId();
	                for(int i=0; i < filses.size() ; i++ ){
	                    String filePath = "";
	                    String fileNm = filses.get(i).getFileNm();
	                    String fileConvNm = filses.get(i).getFileConvNm();
	                    int lastIdx = fileConvNm.lastIndexOf("/");
	                    int typeIndx = fileNm.lastIndexOf(".");

	                    filePath = fileConvNm.substring(0,lastIdx);
	       
	                    fileConvNm = fileConvNm.substring(lastIdx+1);

	                    archiveRndVo.setFile_id(file_id);
	                    archiveRndVo.setFrst_register_id(getUser().getEmplyrkey());
	                    archiveRndVo.setFile_nm(fileNm);
	                    archiveRndVo.setFile_conv_nm(fileConvNm);
	                    archiveRndVo.setFile_path(filePath);
	                    archiveRndVo.setFile_size(filses.get(i).getFileSize());
	                    archiveRndService.insertRndFile(archiveRndVo);
	               
	                }
	            }*/
    	}else{
           	message = "login";
        	redirectAttr.addFlashAttribute("message", message);
        	
        	return "redirect:/archive/rnd/rndWrite.do";
    	
    	}
    	
    	 message ="success";
	     redirectAttr.addFlashAttribute("message", message);    	
	     return "redirect:/archive/rnd/rndWrite.do";

    }
    
    /**
     * <pre>
     * 아카이브 성과논문 수정 페이지 이동
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 28. 
     * @param model
     * @param archiveRndVo
     * @param request
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/archive/rnd/rndEdit.do")
    public String rndEdit(Model model, ArchiveRndVo archiveRndVo, HttpServletRequest request)  throws IOException , SQLException , NullPointerException {
    	
    	//검색 PARAM	
		String page = archiveRndVo.getPage();
		String searchKeyword = archiveRndVo.getSearchKeyword();
		String searchCondition = archiveRndVo.getSearchCondition();
		
		// return 페이지 구분을 위해
		String returnPageGbn = archiveRndVo.getReturnPageGbn();
		
		// 열린 필터 갯수
		String yearCnt = archiveRndVo.getFillterYearCnt();

		String fillterYearList = archiveRndVo.getFillterYearList_s();
		
		ArchiveRndVo resultVo = archiveRndService.selectRndInfo(archiveRndVo);			   	
	//	List<ArchiveRndVo>  fileList = archiveRndService.selectRndFileList(archiveRndVo);
		if(resultVo != null){			
			
			    resultVo.setPage(page);
			    resultVo.setSearchKeyword(searchKeyword);
			    resultVo.setSearchCondition(searchCondition);
			    resultVo.setReturnPageGbn(returnPageGbn);
			    
			    resultVo.setFillterYearList_s(fillterYearList);
			    
			    resultVo.setFillterYearCnt(yearCnt);

			
		    	
		    	//if(fileList.size() > 0){
		    	//	model.addAttribute("fileList", fileList);
		    	//}
				
		       	
				model.addAttribute("resultVO",resultVo);				
		}  	
		
		return "archive/rnd/rndEdit.tiles";
    }
    
    
    /**
     * <pre>
     * 아카이브 성과논문 정보를 수정한다.
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 28. 
     * @param model
     * @param archiveRndVo
     * @param request
     * @param redirectAttr
     * @param Multirequest
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/archive/rnd/updateArchiveRnd.do")
    public String updateArchiveRnd(Model model, ArchiveRndVo archiveRndVo, HttpServletRequest request ,RedirectAttributes redirectAttr, MultipartHttpServletRequest multirequest)  throws IOException , SQLException , NullPointerException {
    	
    	String file_id = "";
    	String message = "";
    	if(getUser() != null){

    		archiveRndVo.setLast_updusr_id(getUser().getEmplyrkey());
    		/*
    		if(String.valueOf(request.getParameter("del_file_list")).length() > 0){
           	 List<String> del_file_list = Arrays.asList(request.getParameter("del_file_list").split(","));
        			Map<String, Object> map = new HashMap<String, Object>();
        			 map.put("file_id", archiveRndVo.getRnd_id());
        			 map.put("del_file_list", del_file_list);
	            	 if(!archiveRndService.deleteRndFile(map)){
		              
	                    	message = "파일 삭제에 실패하였습니다.";
	                    	redirectAttr.addFlashAttribute("archiveRndVo", archiveRndVo);
	                    	redirectAttr.addFlashAttribute("message", message);
	                        return "redirect:/archive/rnd/rndEdit.do";
	                  }    
             }
             
               List<NcmikFileVo> filses =  saveFiles(request,"uploadFile");
	            if(filses.size() > 0){    
	            	//file_id = archiveRndService.selectRndMaxId();
	                for(int i=0; i < filses.size() ; i++ ){
	                	
		            	String filePath = "";
		        		String fileNm = filses.get(i).getFileNm();
		        		String fileConvNm = filses.get(i).getFileConvNm();
	                    int lastIdx = fileConvNm.lastIndexOf("/");
	                  

	                    filePath = fileConvNm.substring(0,lastIdx);
	       
	                    fileConvNm = fileConvNm.substring(lastIdx+1);

	                    archiveRndVo.setFile_id(archiveRndVo.getRnd_id());
	                    archiveRndVo.setFrst_register_id(getUser().getEmplyrkey());
	                    archiveRndVo.setFile_nm(fileNm);
	                    archiveRndVo.setFile_conv_nm(fileConvNm);
	                    archiveRndVo.setFile_path(filePath);
	                    archiveRndVo.setFile_size(filses.get(i).getFileSize());
	                    archiveRndService.insertRndFile(archiveRndVo);	

	                }
	            }
    */
	        	if(!archiveRndService.updateArchiveRnd(archiveRndVo)){
		    		message = "fail";
		        	redirectAttr.addFlashAttribute("message", message);
	        	    redirectAttr.addFlashAttribute("archiveRndVo", archiveRndVo);   
		        	return "redirect:/archive/rnd/rndView.do?rnd_id="+archiveRndVo.getRnd_id();
		    	}
	        	
    	}else{
           	message = "login";
        	redirectAttr.addFlashAttribute("message", message);
        	
        	return "redirect:/archive/rnd/rndList.do";
    	
    	}
    	
    	 message ="success";
	     redirectAttr.addFlashAttribute("message", message);    	
	     redirectAttr.addFlashAttribute("archiveRndVo", archiveRndVo);    
	 	return "redirect:/archive/rnd/rndView.do?rnd_id="+archiveRndVo.getRnd_id();

    }
    
    
    
    /**
     * <pre>
     * 아카이브 성과논문 목록을 삭제한다.
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 28. 
     * @param model
     * @param archiveRndVo
     * @param request
     * @param redirectAttr
     * @param Multirequest
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/archive/rnd/deleteArchiveRnd.do")
    public String deleteArchiveRnd(Model model, ArchiveRndVo archiveRndVo, HttpServletRequest request ,RedirectAttributes redirectAttr, MultipartHttpServletRequest multirequest)  throws IOException , SQLException , NullPointerException {
    
    	String isErr = "N";
    	String message = "";
    	if(getUser() != null){

    		archiveRndVo.setLast_updusr_id(getUser().getEmplyrkey());
    		
			if(!archiveRndService.deleteArchiveRnd(archiveRndVo)){
	    		message = "fail";
	        	redirectAttr.addFlashAttribute("message", message);
        	    redirectAttr.addFlashAttribute("archiveRndVo", archiveRndVo);   
	        	return "redirect:/archive/rnd/reportList.do";
	    	}

    		
    	}else{
           	message = "login";
        	redirectAttr.addFlashAttribute("message", message);
    	  
        	return "redirect:/archive/rnd/rndList.do";
    	
    	}
    	
    	 message ="success";
	     redirectAttr.addFlashAttribute("message", message);    	
	     redirectAttr.addFlashAttribute("archiveRndVo", archiveRndVo);    
	     return "redirect:/archive/rnd/rndList.do";

    }
    
    
    @RequestMapping(value="/archive/rnd/downFile.do", method=RequestMethod.POST)
    public String rndFileDownload(String down_file_sn,String down_file_id, HttpServletRequest request, HttpServletResponse response) throws IOException , SQLException , NullPointerException {
		return down_file_id;
/*
    	ArchiveRndVo archiveRndVo = archiveRndService.retrieveFile(down_file_sn, down_file_id);


			String path = Constants.uPLOAD_PATH;
		
			if (archiveRndVo != null) {
            File file = new File(path+"/"+ archiveRndVo.getFile_conv_nm());

            if (file.canRead()) {
                String userAgent = request.getHeader("User-Agent");
                


                String fileName = null;
                if(userAgent.contains("MSIE") || userAgent.contains("Trident") || userAgent.contains("Chrome")){
                	fileName = URLEncoder.encode(archiveRndVo.getFile_nm(),Constants.ENCODING_TYPE).replaceAll("\\+", "%20");
                } else {
                	fileName = new String(archiveRndVo.getFile_nm().getBytes(Constants.ENCODING_TYPE), "ISO-8859-1");
                }
                response.reset();

                response.setContentType("application/octet-stream; " + Constants.ENCODING_TYPE);
                response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
                response.setHeader( "Content-Transfer-Encoding", "binary;" );
                response.setHeader( "Content-Length", "" + file.length() );
                response.setHeader( "Pragma", "no-cache;" );
                response.setHeader( "Expires", "-1;" );

                FileInputStream fis = null;
                OutputStream out = null;
                try {
                    fis = new FileInputStream(file);
                    out = response.getOutputStream();
                    FileCopyUtils.copy(fis, out);
                    out.flush();
                } catch (IOIOException , SQLException , NullPointerException e) {
                    if (logger.isErrorEnabled()) {logger.debug("err rndFileDownload");}
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
    * 
    * 아카이브 성과논문 - 첨부파일 다운로드 
    * </pre>
    * @author : wonki0138
    * @date   : 2018. 3. 16. 
    * @param request
    * @param archiveReportVo
    * @throws IOException , SQLException , NullPointerException
    */
   @RequestMapping("/archive/rnd/rndDownUpdate.do")
   public void rndDownUpdate(HttpServletRequest request, ArchiveRndVo archiveRndVo)  throws IOException , SQLException , NullPointerException {
   
	   	ArchiveRndVo downVo = null;
	   	String idVal = archiveRndVo.getRnd_id();
		String upd_yn = request.getParameter("upd_yn");
		
		if(StringUtils.equals(upd_yn, "Y")){
			downVo = new ArchiveRndVo();
			downVo.setRnd_id(idVal);
			archiveRndService.updateDownCnt(downVo);
		}

   }
   
   
   
   /**
    * <pre>
    * 
    * 아카이브 성과논문 - 목록 화면
    * </pre>
    * @author : wonki0138
    * @date   : 2018. 3. 16. 
    * @param request
    * @param archiveRndVo
    * @param resp
    * @param out
    * @throws IOException , SQLException , NullPointerException
    */
   @RequestMapping("archive/rnd/rndLinkCnt.do")
   public void rndLinkCnt(HttpServletRequest request, ArchiveRndVo archiveRndVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
   	

   	String xml = "";    
  
   	
   	//  ******************************* 필터 검색조건 END *********************************
   	
  
   	int totalCnt = archiveRndService.selectRndLinkCnt(archiveRndVo);
   	

   		if(totalCnt > 0){
   			
   			xml = XmlUtil.objToXml(totalCnt);
   		
   			/*
   			 * 총카운터 세팅
   			 */
   	    	StringBuffer sb = new StringBuffer();
   	    /*	String[] str = xml.split("<items>");
   	    	
   	    	sb.append(str[0]);
   	    	sb.append("<items>");   	  
   	    	sb.append(str[1]);*/
   	    	
   	    	//xml = sb.toString();
/*   	 	System.out.println("xml = " +xml);*/
   		}
   	
   	resp.setContentType("text/xml");
   	resp.setCharacterEncoding("UTF-8");
   	resp.setHeader("Cache-Control", "no-cache");
   	resp.setHeader("Pragma", "no-cache");
   	resp.setDateHeader("Expires", -1);
   
   	out.write(xml);
  	
   	out.flush();
   	
     
   }
}
