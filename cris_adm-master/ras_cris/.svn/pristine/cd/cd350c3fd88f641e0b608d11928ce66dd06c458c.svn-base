package kr.go.cris.ptl.centerintro.noti.controller;

import java.io.IOException;
import java.io.Writer;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.commons.utils.XmlUtil;
import kr.go.cris.ptl.centerintro.noti.service.IntroNotiService;
import kr.go.cris.ptl.centerintro.noti.vo.IntroNotiVo;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * <pre>
 *  공지사항  controller 구현
 * 
 * </pre>
 * @FileName BoardNotiController.java
 * @package kr.go.cris.ptl.board.noti.controller
 * @author wonki0138
 * @date 2018. 2. 20.
 * 
 */
@Controller
public class IntroNotiController extends BaseController {

    @Resource
    private IntroNotiService introNotiService;
    
    
    /**
     * <pre>
     *  공지사항 -  목록화면이동한다.
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 2. 20. 
     * @param model
     * @param boardNotiVo
     * @param request
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/centerintro/noti/notiList.do")
    public String notiList(Model model, IntroNotiVo introNotiVo, HttpServletRequest request)  throws IOException , SQLException , NullPointerException {
 
    
    	model.addAttribute("introNotiVo", introNotiVo);
    	
    	return "centerintro/noti/notiList.tiles";
    }

   
    /**
     * <pre>
     * 공지사항 - 목록 화면정보를 조회한다.
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 16. 
     * @param request
     * @param introNotiVo
     * @param resp
     * @param out
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/centerintro/noti/notiRead.do")
    public void notiRead(HttpServletRequest request, IntroNotiVo introNotiVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
    	

    	String xml = "";    	
    	List<IntroNotiVo> list = introNotiService.selectNotiList(introNotiVo);
    	
    	int totalCnt = introNotiService.selectNotiTotalCount(introNotiVo);
    	
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
    	    	sb.append("<totalPageCnt>"+Math.ceil((double)totalCnt/(double)10)+"</totalPageCnt>\n");    	 
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
     *  메인화면 공지사항 - 목록을 보여준다
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 2. 20. 
     * @param model
     * @param request
     * @param resp
     * @param out
     * @param boardNotiVo
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/centerintro/noti/mainNotiList.do")
	public void mainListNoti(Model model,HttpServletRequest request,HttpServletResponse resp,Writer out , IntroNotiVo boardNotiVo)  throws IOException , SQLException , NullPointerException {

		String xml = "";
		List<IntroNotiVo> mainNotiList = introNotiService.selectMainNotiList(boardNotiVo);
   	
    	if(mainNotiList != null){
    		if(mainNotiList.size() > 0){
    			
    			xml = XmlUtil.listToXml(mainNotiList);
    			
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
     * 공지사항 상세조회 화면으로 이동한다.
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 2. 
     * @param model
     * @param introNotiVo
     * @param request
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/centerintro/noti/notiView.do")
	public String notiView(Model model, IntroNotiVo introNotiVo, HttpServletRequest request ) throws IOException , SQLException , NullPointerException{
		
    	//검색 PARAM	
		String page = introNotiVo.getPage();
		String searchKeyword = introNotiVo.getSearchKeyword();
		String searchCondition = introNotiVo.getSearchCondition();


		if(StringUtils.equals(introNotiVo.getUpd_yn(), "Y")){
			introNotiService.updateReadCnt(introNotiVo);
		}
		
		IntroNotiVo resultVo = introNotiService.selectNotiInfo(introNotiVo);			   	
		
		if(resultVo != null){	
			if(StringUtils.isNotBlank(resultVo.getAlit_cn())){
				 resultVo.setAlit_cn(resultVo.getAlit_cn().replaceAll("is1.cdc.go.kr", "is.cdc.go.kr"));			
			}
			    resultVo.setPage(page);
			    resultVo.setSearchKeyword(searchKeyword);
			    resultVo.setSearchCondition(searchCondition);
				model.addAttribute("resultVO",resultVo);				
		}  	
		
		return "centerintro/noti/notiView.tiles";
    }
    
    /*
    *//**
     *
     * <pre>
     * 공지사항 - 파일 다운로드
     *
     * </pre>
     * @author : sbkang
     * @date   : 2015. 9. 14.
     * @param noti_sn
     * @param fileSn
     * @param request
     * @param response
     * @return
     * @throws IOException , SQLException , NullPointerException
     *//*
	@RequestMapping(value="/intro/noti/downFile.do", method=RequestMethod.POST)
    public String download(int noti_sn, int noti_file_sn, HttpServletRequest request, HttpServletResponse response) throws IOException , SQLException , NullPointerException {
		BoardNotiVo boardNotiVo = introNotiService.retrieveFile(noti_sn, noti_file_sn);

        if (boardNotiVo != null) {
            File file = new File(Constants.uPLOAD_PATH + boardNotiVo.getNoti_file_path() +"/"+ boardNotiVo.getNoti_file_conv_nm());
            if (file.canRead()) {
                String userAgent = request.getHeader("User-Agent");

                String fileName = null;
                if(userAgent.contains("MSIE") || userAgent.contains("Trident") || userAgent.contains("Chrome")){
                	fileName = URLEncoder.encode(boardNotiVo.getNoti_file_nm(),Constants.ENCODING_TYPE).replaceAll("\\+", "%20");
                } else {
                	fileName = new String(boardNotiVo.getNoti_file_nm().getBytes(Constants.ENCODING_TYPE), "ISO-8859-1");
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
                } catch (IOIOException , SQLException , NullPointerException e) {
                    if (logger.isErrorEnabled()) logger.error(e.getMessage(), e);
                } finally {
                    CloseUtil.closeQuietly(fis);
                }
                return null;    // 파일 전송 완료.
            }
        }

        return "/error/fileNotFound";    // 파일 없음.
    }
	@RequestMapping("intro/noti/notiEdit.do")
	public String editNoti(Model model, BoardNotiVo boardNotiVo, HttpServletRequest request ) throws IOException , SQLException , NullPointerException{
		List<BoardNotiVo> list = introNotiService.selectNotiList(boardNotiVo);
		List<BoardNotiVo> fileList = introNotiService.selectNotiFile(boardNotiVo);
		String uploadPath =  Constants.uPLOAD_PATH;
		if(list.size()>0){
			
			model.addAttribute("dtlList", list.get(0));	
			model.addAttribute("fileList", fileList);
			request.setAttribute("pathUrl", uploadPath);
		}  
		model.addAttribute("boardNotiVo", boardNotiVo);	
		
		return "intro/noti/notiEdit";
	}	
	
	*/
}
