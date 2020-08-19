package kr.go.cris.ptl.cmmn.mainpopup.controller;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.Writer;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.commons.utils.XmlUtil;
import kr.go.cris.ptl.cmmn.mainpopup.service.MainPopupService;
import kr.go.cris.ptl.cmmn.mainpopup.vo.MainPopupVo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * <pre>
 *  메인 팝업존 controller
 * 
 * </pre>
 * @FileName MainPopupController.java
 * @package kr.go.cris.ptl.board.noti.controller
 * @author wonki0138
 * @date 2018. 2. 20.
 * 
 */
@Controller
public class MainPopupController extends BaseController {

    @Resource
    private MainPopupService mainPopupService;
    
  
    /**
     * <pre>
     *
     *  메인화면 메인 팝업 리스트
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 2. 23. 
     * @param model
     * @param request
     * @param resp
     * @param out
     * @param mainPopupVo
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("cmmn/mainPopup/mainPopupList.do")
	public void mainPopupList(Model model,HttpServletRequest request,HttpServletResponse resp,Writer out , MainPopupVo mainPopupVo)  throws IOException , SQLException , NullPointerException {

		String xml = "";
		List<MainPopupVo> mainPopupList = mainPopupService.selectMainPopupList(mainPopupVo);
		
		List<MainPopupVo> infoResult = null;
		MainPopupVo srcResult = null;
		List<MainPopupVo> resultList = new ArrayList<MainPopupVo>();
		
		MainPopupVo popInfo = null;
		MainPopupVo popSrc = null;

    	if(mainPopupList != null){
    		if(mainPopupList.size() > 0){
    			
    			for(int i = 0 ; i < mainPopupList.size() ; i++){

    				popInfo = new MainPopupVo();
    				popInfo.setAtch_file_id(mainPopupList.get(i).getAtch_file_id());
    				infoResult =  mainPopupService.selectMainPopupAtchFileInfo(popInfo);    				    				

    				if(infoResult != null){
    					if(infoResult.size() > 0){
    						
    						int size = infoResult.size()-1;     				
    	    				
    						for(int z = 0 ; z < size; z++ ){
    	    					infoResult.remove(0);
    						}
    						
    				
    						    						
    						popSrc = new MainPopupVo();    					    						
    						popSrc.setAtch_file_id(infoResult.get(0).getAtch_file_id());
    						popSrc.setFile_sn( infoResult.get(0).getFile_sn());  						
    						
    						srcResult = mainPopupService.selectMainPopupAtchFileSrc(popSrc);  // 업로드된 파일의 경로를 조회
    						
    						 
    						
    						if(srcResult != null){   							
    							
    							srcResult.setPop_link(mainPopupList.get(i).getPop_link());  // 팝업 링크
    							resultList.add(srcResult);
    							
    						}
    						
    					}		
    				}
    			
    			}
    			
    			xml = XmlUtil.listToXml(resultList);
    			
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
     * 파일 이미지를 불러온다.
     *
     * </pre>
     * @author : user
     * @date   : 2018. 7. 4. 
     * @param model
     * @param request
     * @param response
     * @param mainPopupVo
     * @throws IOException
     * @throws SQLException
     * @throws NullPointerException
     */
    @RequestMapping("cmmn/mainPopup/getImage.do")
  	public void getImageInf(Model model,HttpServletRequest request,HttpServletResponse response  , MainPopupVo mainPopupVo)  throws IOException, NullPointerException, SQLException{
    
    	MainPopupVo popVo = mainPopupService.selectMainPopupAtchFileSrc(mainPopupVo);
    	
    	
    	BufferedInputStream in = null;
		ByteArrayInputStream bis = null;
		ByteArrayOutputStream bStream = null;
        if(popVo != null){
		try {
			bis = new ByteArrayInputStream( popVo.getFile_byte() );
	
		    in = new BufferedInputStream(bis);
		    bStream = new ByteArrayOutputStream();
	
		    int imgByte;
		    while ((imgByte = in.read()) != -1) {
			bStream.write(imgByte);
		    }
	
			String type = "";
		
			if (popVo.getFile_extsn() != null && !"".equals(popVo.getFile_extsn())) {
			    if ("jpg".equals(popVo.getFile_extsn().toLowerCase())) {
				type = "image/jpeg";
			    } else {
				type = "image/" + popVo.getFile_extsn().toLowerCase();
			    }
			    //type = "image/" + popVo.getFile_extsn().toLowerCase();
		
			} else {
			    logger.debug("Image fileType is null.");
			}
		
			response.setHeader("Content-Type", type);
			response.setContentLength(bStream.size());
		
			bStream.writeTo(response.getOutputStream());
			
		
		}catch(IOException ex){
		
			logger.debug("ex getImageInf");
			// 2011.10.10 보안점검 후속조치 끝
		} finally {
			if(response != null){
				try{			
					response.getOutputStream().flush();
					response.getOutputStream().close();					
				}catch(IOException ex){
					logger.debug("1ex = getImageInf");
				}
            	
			}
			if (bStream != null) {
				try {
					bStream.close();
				}catch(IOException ex ){
					logger.debug("ERROR ByteArrayOutputStream bStream IOException");
				}
			}
			if (in != null) {
				try {
					in.close();
				}catch(IOException ex ){
					logger.debug("ERROR ByteArrayOutputStream in IOException");
				}
			}
			if (bis != null) {
				try {
					bis.close();
				}catch(IOException ex ){
					logger.debug("ERROR ByteArrayOutputStream bis IOException");
				}
			}
	
		}
        }
  	
  	}
    
    
  
}
