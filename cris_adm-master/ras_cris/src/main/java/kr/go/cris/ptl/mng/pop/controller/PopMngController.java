package kr.go.cris.ptl.mng.pop.controller;



import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.Writer;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.commons.constants.Constants;
import kr.go.cris.commons.file.vo.FileVo;
import kr.go.cris.commons.utils.CloseUtil;
import kr.go.cris.commons.utils.XmlUtil;
import kr.go.cris.ptl.mng.pop.service.PopMngService;
import kr.go.cris.ptl.mng.pop.vo.PopMngVo;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;






/**
 * <pre>
 * FileName: PopMngController.java
 * Package : kr.go.cris.ptl.mng.pop.controller
 * 
 * 팝업관리 컨트롤러
 *
 * </pre>
 * @author : lwk
 * @date   : 2019. 3. 28.
 */
@Controller
public class PopMngController extends BaseController {

	@Resource
	private PopMngService popMngService;
	
	

	/**
	 * <pre>
	 * 채용정보관리 페이지 이동
	 * 
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param sendCd
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("mng/pop/popList.do")
	public String popList(Model model, PopMngVo popMngVo, HttpServletRequest request ) throws Exception{
		
	
		
		return "mng/pop/popList.tiles";
			
	}
	
	/**
	 * <pre>
	 * 팝업관리 list
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param request
	 * @param popMngVo
	 * @param resp
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="mng/pop/readPopList.do")
	public void readpopList(HttpServletRequest request, PopMngVo popMngVo, HttpServletResponse resp, Writer out)  throws Exception {
		
		String xml = "";
    	
    	List<PopMngVo> list = popMngService.selectPopList(popMngVo);
    
    	int totalCnt = popMngService.selectPopTotalCount(popMngVo);
    	
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
    	    	sb.append("<totalCnt>"+Math.ceil((double)totalCnt/(double)5)+"</totalCnt>\n");
    	       	sb.append("<uploadPath>"+Constants.UPLOAD_PATH_POP+"</uploadPath>");
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
	 * 메인팝업존 list
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param request
	 * @param popMngVo
	 * @param resp
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping("mng/pop/mainPopList.do")
	public void mainpopList(Model model,HttpServletRequest request,HttpServletResponse resp,Writer out,PopMngVo popMngVo)  throws Exception {
		String uploadPath =  Constants.UPLOAD_PATH_POP;
	
		
		
		String xml = "";
    	List<PopMngVo> popMainList = popMngService.selectMainPopList(popMngVo);

   	
    	if(popMainList != null){
    		if(popMainList.size() > 0){
    			
    			xml = XmlUtil.listToXml(popMainList);
    			
    	    	StringBuffer sb = new StringBuffer();
    	    	String[] str = xml.split("<items>");
    	    	
    	    	sb.append(str[0]);
    	    	sb.append("<items>");
    	       	sb.append("<uploadPath>"+uploadPath+"</uploadPath>");
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
	 * 팝업관리 view
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param model
	 * @param popMngVo
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("mng/pop/popView.do")
	public String popView(Model model, PopMngVo popMngVo, HttpServletRequest request ) throws Exception{
		String uploadPath =  Constants.UPLOAD_PATH_POP;

		
		List<PopMngVo> list = popMngService.selectPopList(popMngVo);
		if(list.size()>0){
			model.addAttribute("dtlList", list.get(0));	
		// 로컬일때만 쓸듯 , 실제 운영에는  실경로가 쓰인다. realPath가 아닌
		
			model.addAttribute("pathUrl", uploadPath);
		}  
		
		return "mng/pop/popView.tiles";
			
	}
	
	/**
	 * <pre>
	 * 팝업관리 수정
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param model
	 * @param popMngVo
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("mng/pop/popEdit.do")
	public String popEdit(Model model, PopMngVo popMngVo, HttpServletRequest request ) throws Exception{
		List<PopMngVo> list = popMngService.selectPopList(popMngVo);
		if(list.size()>0){
			
			model.addAttribute("dtlList", list.get(0));	
		}  
		
		return "mng/pop/popEdit.tiles";
			
	}
	
	/**
	 * <pre>
	 * 팝업관리 등록 url이동
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param model
	 * @param popMngVo
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("mng/pop/popWrite.do")
	public String popWrite(Model model, PopMngVo popMngVo, HttpServletRequest request ) throws Exception{
	
		
		return "mng/pop/popWrite.tiles";
			
	}
	
	 /**
	 * <pre>
	 * 팝업관리 수정
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param popMngVo
	 * @param redirectAttr
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("mng/pop/updatePop.do")
	    public String updatePop(PopMngVo popMngVo,  RedirectAttributes redirectAttr, MultipartHttpServletRequest request)  throws Exception {

	        String messege="";
	        String usrId = "";
	        int popSn = popMngVo.getPop_sn();
	        int popFileSn = 0;
	    
	        if(getUser() != null){
	            usrId = getUser().getLoginid();
	            popMngVo.setModifiy_id();
	    
	            //if(usrId.equals(popMngVo.getWrite_id())){
                   
	            	if(popMngVo.getFile_del().equals("del_file")){
		            	 if(!popMngService.deletePopFile(popMngVo)){
			              
		                    	messege = "파일 삭제에 실패하였습니다.";
		                    	redirectAttr.addFlashAttribute("popMngVo", popMngVo);
		                    	redirectAttr.addFlashAttribute("messege", messege);
		                        return "redirect:/board/pop/popEdit.do?pop_sn="+popMngVo.getPop_sn();
		                  }    
                     }
                     
	                List<FileVo> filses =  saveFiles(request,"uploadFile");
		            if(filses.size() > 0){    
		                popFileSn = popMngService.selectPopFileSn(popSn);
		             //   for(int i=0; i < filses.size() ; i++ ){
		                    String popFilePath = "";
		                    String popFileNm = filses.get(0).getFileNm();
		                    String FileConvNm = filses.get(0).getFileConvNm();
		                    int lastIdx = FileConvNm.lastIndexOf("/");
		                    int typeIndx = popFileNm.lastIndexOf(".");

		                    popFilePath = FileConvNm.substring(0,lastIdx);
		       
		                    FileConvNm = FileConvNm.substring(lastIdx+1);

		                    popMngVo.setPop_sn(popSn);
		                    popMngVo.setCreate_id();

		                    popMngVo.setPop_file_sn(popFileSn);
		                    popMngVo.setPop_file_nm(popFileNm);
		                    popMngVo.setPop_file_conv_nm(FileConvNm);
		                    popMngVo.setPop_file_path(popFilePath);
		                    popMngVo.setPop_file_size(filses.get(0).getFileSize());
		                    popMngService.insertPopFile(popMngVo);
		                  //  popFileSn ++;

		               // }
		            }
	             //}
	                if(!popMngService.updatePop(popMngVo)){
	                	messege = "수정에 실패하였습니다.";
	                	redirectAttr.addFlashAttribute("popMngVo", popMngVo);
	                	redirectAttr.addFlashAttribute("messege", messege);
	                    return "redirect:/mng/pop/popView.do?pop_sn="+popSn;
	                }           
	            
	        }else{
	            messege = "수정 권한이 없습니다.";
	            redirectAttr.addFlashAttribute("messege", messege);
	            return "redirect:/mng/pop/popList.do";
	        }

	        messege="저장 되었습니다.";
	        redirectAttr.addFlashAttribute("popMngVo", popMngVo);
	        redirectAttr.addFlashAttribute("messege", messege);
	        return "redirect:/mng/pop/popView.do?pop_sn="+popSn;
	    }
	 
	   /**
	 * <pre>
	 * 팝업관리 등록
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param popMngVo
	 * @param redirectAttr
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("mng/pop/insertPop.do")
	    public String insertPop(PopMngVo popMngVo, RedirectAttributes redirectAttr, MultipartHttpServletRequest request)  throws Exception {

	        int pop_sn = 0;
	        int popFileSn = 0;

	        String messege="";
	       // if(getUser() != null){

	            pop_sn = popMngService.selectPopSn();
	            popMngVo.setPop_sn(pop_sn);
	            popMngVo.setCreate_id();


	            if( !popMngService.insertPop(popMngVo)){
	            	messege = "저장에 실패하였습니다.";
	            	redirectAttr.addFlashAttribute("popMngVo", popMngVo);
	            	redirectAttr.addFlashAttribute("messege", messege);
	                return "redirect:/mng/pop/popList.do";
	            }

	            List<FileVo> filses =  saveFiles(request,"uploadFile");
	            if(filses.size() > 0){
	                popFileSn = popMngService.selectPopFileSn(pop_sn);
	             //   for(int i=0; i < filses.size() ; i++ ){
	                    String popFilePath = "";
	                    String popFileNm = filses.get(0).getFileNm();
	                    String FileConvNm = filses.get(0).getFileConvNm();
	                    int lastIdx = FileConvNm.lastIndexOf("/");
	                    int typeIndx = popFileNm.lastIndexOf(".");

	                    popFilePath = FileConvNm.substring(0,lastIdx);
	       
	                    FileConvNm = FileConvNm.substring(lastIdx+1);

	                    popMngVo.setPop_sn(pop_sn);
	                    popMngVo.setCreate_id();

	                    popMngVo.setPop_file_sn(popFileSn);
	                    popMngVo.setPop_file_nm(popFileNm);
	                    popMngVo.setPop_file_conv_nm(FileConvNm);
	                    popMngVo.setPop_file_path(popFilePath);
	                    popMngVo.setPop_file_size(filses.get(0).getFileSize());
	                    popMngService.insertPopFile(popMngVo);
	                  //  popFileSn ++;
	               // }
	            }

	        /*
	         * }else{
	        	messege = "로그인 후 이용 하여 주십시요";
	        	redirectAttr.addFlashAttribute("messege", messege);
	        	return "redirect:/mng/pop/popList.do";
	        }
	        */

	        messege="저장 되었습니다.";
	        redirectAttr.addFlashAttribute("popMngVo", popMngVo);
	        redirectAttr.addFlashAttribute("messege", messege);
	        return "redirect:/mng/pop/popView.do?pop_sn="+pop_sn;

	    }
	 
	 
	   
	   
	   /**
	 * <pre>
	 * 팝업관리 삭제
	 *
	 * </pre>
	 * @author : lwk
	 * @date   :  2019. 12. 11.
	 * @param popMngVo
	 * @param redirectAttr
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("mng/pop/deletePop.do")
	    public String deletePop(PopMngVo popMngVo , RedirectAttributes redirectAttr, MultipartHttpServletRequest request) {

	        String messege="";
	        String usrId = "";
	        String isErr = "N";
	       if(getUser() != null){
	            usrId = getUser().getLoginid();
	            popMngVo.setModifiy_id();

	            if(usrId.equals(popMngVo.getWrite_id())){
	            	 try {
			            		//첨부파일 삭제
	            		 int str =popMngVo.getPop_file_sn();
	            		
	            		  if(String.valueOf(str) != null){
								popMngService.deletePopFile(popMngVo);	
	            		   } 
			            	  //게시글 삭제
		            		   popMngService.deletePop(popMngVo);
			            			
	            	 } catch (Exception e) {
	            	 		isErr="Y";
	            	 		TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
					 }finally{
							if(StringUtils.equals(isErr, "Y")){
		                    	messege = "파일 삭제에 실패하였습니다.";
		                    	redirectAttr.addFlashAttribute("popMngVo", popMngVo);
		                    	redirectAttr.addFlashAttribute("messege", messege);
		                        return "redirect:/board/pop/popList.do";
							}
					 }
		                    
		               
	                 }     
	        }else{
	            messege = "삭제 권한이 없습니다.";
	            redirectAttr.addFlashAttribute("messege", messege);
	            return "redirect:/mng/pop/popEdit.do?pop_sn="+popMngVo.getPop_sn();
	        }
	       
	      
	    	    messege="삭제 되었습니다.";
		        redirectAttr.addFlashAttribute("popMngVo", popMngVo);
		        redirectAttr.addFlashAttribute("messege", messege);
		        return "redirect:/mng/pop/popList.do";
	       
	       
	       
	    }
	
		/**
		 * <pre>
		 * 팝업관리 - 첨부파일 다운로드
		 *
		 * </pre>
		 * @author : lwk
		 * @date   : 2019. 12. 11.
		 * @param notiSn
		 * @param fileSn
		 * @param request
		 * @param response
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value="/mng/pop/downFile.do", method=RequestMethod.POST)
	    public String download(int pop_sn,int pop_file_sn, HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			PopMngVo popMngVo = popMngService.retrieveFile(pop_sn, pop_file_sn);


				String path = servletContext.getRealPath(Constants.UPLOAD_PATH_POP);
			
				if (popMngVo != null) {
	            File file = new File(path+"/"+ popMngVo.getPop_file_conv_nm());

	            if (file.canRead()) {
	                String userAgent = request.getHeader("User-Agent");
	                


	                String fileName = null;
	                if(userAgent.contains("MSIE") || userAgent.contains("Trident") || userAgent.contains("Chrome")){
	                	fileName = URLEncoder.encode(popMngVo.getPop_file_nm(),Constants.ENCODING_TYPE).replaceAll("\\+", "%20");
	                } else {
	                	fileName = new String(popMngVo.getPop_file_nm().getBytes(Constants.ENCODING_TYPE), "ISO-8859-1");
	                }
	                response.reset();

	                response.setContentType("application/octet-stream; " + Constants.ENCODING_TYPE);
	                response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
	                response.setHeader( "Content-Transfer-Encoding", "binary;" );
	                response.setHeader( "Content-Length", "" + file.length() );
	                response.setHeader( "Pragma", "no-cache;" );
	                response.setHeader( "Expires", "-1;" );

	                FileInputStream fis = null;
	                try {
	                    fis = new FileInputStream(file);
	                    OutputStream out = response.getOutputStream();
	                    FileCopyUtils.copy(fis, out);
	                    out.flush();
	                } catch (IOException e) {
	                    if (logger.isErrorEnabled()) logger.error(e.getMessage(), e);
	                } finally {
	                    CloseUtil.closeQuietly(fis);
	                }
	                return null;    // 파일 전송 완료.
	            }
	        }

	        return "/error/fileNotFound.tiles";    // 파일 없음.
	    }
}