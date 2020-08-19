package kr.go.cris.ptl.archive.intro.controller;

import java.io.IOException;
import java.io.Writer;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.commons.login.vo.UserVo;
import kr.go.cris.commons.utils.XmlUtil;
import kr.go.cris.ptl.archive.intro.service.ArchiveIntroService;
import kr.go.cris.ptl.archive.intro.vo.ArchiveIntroVo;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * <pre>
 * 아카이브  소개 Controller
 * 
 * </pre>
 * @FileName : ArchiveIntroController.java
 * @package  : kr.go.cris.ptl.archive.report.controller
 * @author   : wonki0138
 * @date     : 2018. 3. 16.
 * 
 */
@Controller
public class ArchiveIntroController extends BaseController {

    @Resource
    private ArchiveIntroService archiveIntroService;
    

    /**
     * <pre>
     * 아카이브 소개 - 아카이브 소개 최초화면 이동
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 22. 
     * @param model
     * @param archiveIntroVo
     * @param request
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/archive/intro/archiveIntro.do")
    public String archiveIntro(Model model, ArchiveIntroVo archiveIntroVo, HttpServletRequest request)  throws  IOException , SQLException , NullPointerException  {
 
    
    	model.addAttribute("archiveIntroVo", archiveIntroVo);
    	
    	return "archive/intro/archiveIntroList.tiles";
    }

    
 
    
    /**
     * <pre>
     * 아카이브 소개 -게시물 목록(발행년도별)
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 22. 
     * @param request
     * @param archiveIntroVo
     * @param resp
     * @param out
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("archive/intro/archiveIntroRead.do")
    public void archiveIntroRead(HttpServletRequest request, ArchiveIntroVo archiveIntroVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
    	

    	String xml = "";    
    	
    	
    	List<ArchiveIntroVo> list = archiveIntroService.selectArchiveIntroList(archiveIntroVo);
    	
    //	int totalCnt = archiveIntroService.selectArchiveIntroTotalCount(archiveIntroVo);
    	
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
    	    //	sb.append("<totalPageCnt>"+Math.ceil((double)totalCnt/(double)archiveIntroVo.getPageSize())+"</totalPageCnt>\n");    	 
    	    //	sb.append("<totalDataCnt>"+totalCnt+"</totalDataCnt>\n");
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
     * 아카이브 성과논문 - 게시물 목록(발행년도별)
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 22. 
     * @param request
     * @param archiveIntroVo
     * @param resp
     * @param out
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("archive/intro/archiveIntroReadRnd.do")
    public void archiveIntroReadRnd(HttpServletRequest request, ArchiveIntroVo archiveIntroVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
    	String xml = "";    
    	List<ArchiveIntroVo> list = archiveIntroService.selectArchiveIntroRndList(archiveIntroVo);
    	
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
     * 아카이브 소개 -우측 영역 최근 등록 자료 목록 조회
     *  
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 22. 
     * @param request
     * @param archiveIntroVo
     * @param resp
     * @param out
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("archive/intro/archiveIntroRecentlyRead.do")
    public void archiveIntroRecentlyRead(HttpServletRequest request, ArchiveIntroVo archiveIntroVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
    	

    	String xml = "";   
    	
    	
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
		archiveIntroVo.setConParam(archiveRole);			
    	// 권한에 따른 공개 비공개 처리 END
    	
    	List<ArchiveIntroVo> list = archiveIntroService.selectArchiveIntroRecentlyList(archiveIntroVo);
    	
    
    	
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
     * 아카이브 소개 -우측 영역 인기자료 조회
     *  
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 22. 
     * @param request
     * @param archiveIntroVo
     * @param resp
     * @param out
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("archive/intro/archiveIntroTopDownRead.do")
    public void archiveIntroTopDownRead(HttpServletRequest request, ArchiveIntroVo archiveIntroVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
    	

    	String xml = "";    
    	

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
		archiveIntroVo.setConParam(archiveRole);			
    	// 권한에 따른 공개 비공개 처리 END
    	
    	List<ArchiveIntroVo> list = archiveIntroService.selectArchiveIntroTopDownList(archiveIntroVo);
    	
    
    	
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
     *  아카이브 Recently Added Items 목록 조회 화면 이동
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 23. 
     * @param model
     * @param archiveIntroVo
     * @param request
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/archive/intro/archiveRecentlyList.do")
    public String archiveRecentLyList(Model model, ArchiveIntroVo archiveIntroVo, HttpServletRequest request)  throws IOException , SQLException , NullPointerException {
  
    	model.addAttribute("archiveIntroVo", archiveIntroVo);
    	
    	return "archive/intro/archiveRecentlyList.tiles";
    }

    /**
     * <pre>
     *
     * 아카이브 Recently Added Items 목록 조회
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 23. 
     * @param request
     * @param archiveIntroVo
     * @param resp
     * @param out
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("archive/intro/archiveRecentlyListRead.do")
    public void archiveRecentlyListRead(HttpServletRequest request, ArchiveIntroVo archiveIntroVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
    	

    	String xml = "";    
    	
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
		archiveIntroVo.setConParam(archiveRole);			
    	// 권한에 따른 공개 비공개 처리 END
    	
    	List<ArchiveIntroVo> list = archiveIntroService.selectRecentlyAddItemsList(archiveIntroVo);
    	
    	int totalCnt = archiveIntroService.selectArchiveIntroTotalCount(archiveIntroVo);
    	
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
    	    	sb.append("<totalPageCnt>"+Math.ceil((double)totalCnt/(double)archiveIntroVo.getPageSize())+"</totalPageCnt>\n");    	 
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
     *  아카이브 Top Downloads 목록 조회 화면 이동
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 23. 
     * @param model
     * @param archiveIntroVo
     * @param request
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("/archive/intro/archiveTopDownloadList.do")
    public String archiveTopDownloadList(Model model, ArchiveIntroVo archiveIntroVo, HttpServletRequest request)  throws IOException , SQLException , NullPointerException {
  
    	model.addAttribute("archiveIntroVo", archiveIntroVo);
    	
    	return "archive/intro/archiveTopDownloadList.tiles";
    }

    /**
     * <pre>
     *
     * 아카이브 Top Downloads 목록 조회
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 23. 
     * @param request
     * @param archiveIntroVo
     * @param resp
     * @param out
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("archive/intro/archiveTopDownloadListRead.do")
    public void archiveTopDownloadListRead(HttpServletRequest request, ArchiveIntroVo archiveIntroVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
    	

    	String xml = "";    
    	
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
		archiveIntroVo.setConParam(archiveRole);			
    	// 권한에 따른 공개 비공개 처리 END
    	
    	List<ArchiveIntroVo> list = archiveIntroService.selectTopDownloadList(archiveIntroVo);
    	
    	int totalCnt = archiveIntroService.selectArchiveIntroTotalCount(archiveIntroVo);
    	
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
    	    	sb.append("<totalPageCnt>"+Math.ceil((double)totalCnt/(double)archiveIntroVo.getPageSize())+"</totalPageCnt>\n");    	 
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
     * 아카이브 소개 -게시물 목록(발행년도별)
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 3. 22. 
     * @param request
     * @param archiveIntroVo
     * @param resp
     * @param out
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("archive/intro/archiveIntroAsubList.do")
    public void archiveIntroAsubList(HttpServletRequest request, ArchiveIntroVo archiveIntroVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
    	

    	String xml = "";    
    	
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
		archiveIntroVo.setConParam(archiveRole);			
    	// 권한에 따른 공개 비공개 처리 END
    	
    	List<ArchiveIntroVo> list = archiveIntroService.selectArchiveIntroAsubList(archiveIntroVo);
    	
  
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
}
