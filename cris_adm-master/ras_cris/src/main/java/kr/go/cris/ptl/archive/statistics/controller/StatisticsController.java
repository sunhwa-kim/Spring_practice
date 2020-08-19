package kr.go.cris.ptl.archive.statistics.controller;

import java.io.IOException;
import java.io.Writer;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.commons.utils.XmlUtil;
import kr.go.cris.ptl.archive.statistics.service.StatisticsService;
import kr.go.cris.ptl.archive.statistics.vo.StatisticsVo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * <pre>
 * 아카이브 통계
 * 
 * </pre>
 * @FileName : StatisticsController.java
 * @package  : kr.go.cris.ptl.archive.statistics.controller
 * @author   : wonki0138
 * @date     : 2018. 5. 15.
 * 
 */
@Controller
public class StatisticsController extends BaseController {

    @Resource
    private StatisticsService statisticsService; 
    
    
    /**
     * <pre>
     * 아카이브 통계 - 목록화면 이동
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 5. 15. 
     * @param model
     * @param statisticsVo
     * @param request
     * @return
     * @throws IOException , SQLException , NullPointerException
     */
    @RequestMapping("archive/statistics/statisticsList.do")
    public String reportList(Model model, StatisticsVo statisticsVo, HttpServletRequest request , HttpServletResponse response)  throws IOException , SQLException , NullPointerException {
   
    	model.addAttribute("statisticsVo", statisticsVo);
    	
    	return "archive/statistics/statisticsList.tiles";
    }
    
    
    /**
     * <pre>
     * 아카이브 통계 - 연도별 구축현황(소장통계)
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 5. 15. 
     * @param request
     * @param statisticsVo
     * @param resp
     * @param out
     * @throws IOException , SQLException , NullPointerException
     */
    
    @RequestMapping("archive/statistics/statsPossession.do")
    public void statsPossession(HttpServletRequest request, StatisticsVo statisticsVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
   
    	String xml = "";    
    	
    	List<StatisticsVo> list = statisticsService.selectStatsPossession(statisticsVo);
    	
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
     * 아카이브 통계 - 다운로드수
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 5. 15. 
     * @param request
     * @param statisticsVo
     * @param resp
     * @param out
     * @throws IOException , SQLException , NullPointerException
     */
    
    @RequestMapping("archive/statistics/statsDownload.do")
    public void statsDownload(HttpServletRequest request, StatisticsVo statisticsVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
   
    	String xml = "";    
    	
    	List<StatisticsVo> list = statisticsService.selectStatsDownload(statisticsVo);
    	
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
     * 아카이브 통계 - 조회수
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 5. 15. 
     * @param request
     * @param statisticsVo
     * @param resp
     * @param out
     * @throws IOException , SQLException , NullPointerException
     */
    
    @RequestMapping("archive/statistics/statsView.do")
    public void statsView(HttpServletRequest request, StatisticsVo statisticsVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
   
    	String xml = "";    
    	
    	List<StatisticsVo> list = statisticsService.selectStatsView(statisticsVo);
    	
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
     * 아카이브 통계 - 주제분류
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 5. 15. 
     * @param request
     * @param statisticsVo
     * @param resp
     * @param out
     * @throws IOException , SQLException , NullPointerException
     */
    
    @RequestMapping("archive/statistics/statsOrderDept.do")
    public void statsOrderDept(HttpServletRequest request, StatisticsVo statisticsVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
   
    	String xml = "";    
    	
    	List<StatisticsVo> list = statisticsService.selectStatsOrderDept(statisticsVo);
    	
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
     * 아카이브 통계 - SCI논문
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 5. 15. 
     * @param request
     * @param statisticsVo
     * @param resp
     * @param out
     * @throws IOException , SQLException , NullPointerException
     */
    
    @RequestMapping("archive/statistics/statsRndSCI.do")
    public void statsRndSCI(HttpServletRequest request, StatisticsVo statisticsVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
   
    	String xml = "";    
    	
    	List<StatisticsVo> list = statisticsService.selectStatsRndSCI(statisticsVo);
    	
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
     * 아카이브 통계 - 첨부파일
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 5. 16. 
     * @param request
     * @param statisticsVo
     * @param resp
     * @param out
     * @throws IOException , SQLException , NullPointerException
     */
    
    @RequestMapping("archive/statistics/statsFile.do")
    public void statsFile(HttpServletRequest request, StatisticsVo statisticsVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {
   
    	String xml = "";    
    	
    	List<StatisticsVo> list = statisticsService.selectStatsFile(statisticsVo);
    	
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
