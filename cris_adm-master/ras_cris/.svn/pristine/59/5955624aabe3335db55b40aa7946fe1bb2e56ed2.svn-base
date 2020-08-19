package kr.go.cris.ptl.data.controller;

import java.io.IOException;
import java.io.Writer;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.cris.commons.utils.XmlUtil;
import kr.go.cris.ptl.data.service.DataCenterService;
import kr.go.cris.ptl.data.vo.DataCenterVo;
import kr.go.cris.ptl.data.vo.HealthCareVo;
import kr.go.cris.ptl.data.vo.RelatedInsVo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * <pre>
 * 데이터센터 - Controller 구현
 * 
 * </pre>
 * @FileName : DataCenterController.java
 * @package  : kr.go.cris.ptl.data.controller
 * @author   : Administrator
 * @date     : 2018. 3. 28.
 * 
 */
@Controller("dataCenterController")
public class DataCenterController {

    @Resource
    private DataCenterService dataCenterService;
    

    /**
     * <pre>
     *
     *   * 데이터센터 목록을 조회한다
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 6. 28. 
     * @param dataCenterVo
     * @param model
     * @return
     * @throws IOException
     * @throws SQLException
     * @throws NullPointerException
     */
    @RequestMapping(value="data/listData.do")
    public String selectDataList(DataCenterVo dataCenterVo, ModelMap model) throws IOException, SQLException , NullPointerException {
    	        
        model.addAttribute("dataCenterVo", dataCenterVo);
        
        
    	return "data/listData.tiles";
    } 
    

    /**
     * <pre>
     * 데이터센터 - 상세화면 정보를 조회한다.
     *
     * </pre>
     * @author : wonki0138
     * @date   : 2018. 6. 28. 
     * @param dataCenterVo
     * @param model
     * @param request
     * @return
     * @throws IOException
     * @throws SQLException
     * @throws NullPointerException
     */
    @RequestMapping(value="data/dataView.do")
    public String selectDataView(DataCenterVo dataCenterVo, ModelMap model, HttpServletRequest request) throws IOException, SQLException , NullPointerException {
    	
    	
    	//검색 PARAM	
    	String page = dataCenterVo.getPage();
		String searchKeyword = dataCenterVo.getSearchKeyword();
		String searchCondition = dataCenterVo.getSearchCondition();
		String data_center_gbn = dataCenterVo.getData_center_gbn();
				
    	dataCenterVo.setData_center_id(request.getParameter("data_center_id"));
    	dataCenterVo.setRdcnt(dataCenterService.updateDataRdcnt(dataCenterVo));
       	
        DataCenterVo list = dataCenterService.selectDataView(dataCenterVo);
        
        if(list != null){			
			
        	list.setPage(page);
        	list.setSearchKeyword(searchKeyword);
        	list.setSearchCondition(searchCondition);
        	list.setData_center_gbn(data_center_gbn);
		    
		    model.addAttribute("dataList", list);				
	}  	
        
        
    	return "data/dataView.tiles";
    } 
    

   /**
	 * <pre>
	 * 데이터센서 상세 정보를 조회한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 6. 28. 
	 * @param request
	 * @param dataCenterVo
	 * @param resp
	 * @param out
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
    @RequestMapping("data/dataRead.do")
   public void dataRead(HttpServletRequest request, DataCenterVo dataCenterVo, HttpServletResponse resp, Writer out)  throws IOException, SQLException , NullPointerException {
	   
   	String xml = "";
       
   	List<DataCenterVo> list = dataCenterService.selectDataAdminList(dataCenterVo);
   	
   	int totalCnt = dataCenterService.selectDataCenterTotalCount(dataCenterVo);
   	
   	if(list != null){
   		if(list.size() > 0){
   			
   			xml = XmlUtil.listToXml(list);
   			
   			 /* 총카운터 세팅*/
   			 
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
	 * 데이터분석실-유관기간 화면으로 이동
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 6. 28. 
	 * @param dataCenterVo
	 * @param model
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	@RequestMapping(value="data/related.do")
	   public String related(DataCenterVo dataCenterVo, ModelMap model) throws IOException, SQLException , NullPointerException {
   	        
       model.addAttribute("dataCenterVo", dataCenterVo);
       
       return "data/related.tiles";
   } 
   
   


   /**
	 * <pre>
	 * 데이터분석실-소개 화면으로 이동
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 6. 28. 
	 * @param dataCenterVo
	 * @param model
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	@RequestMapping(value="/data/infoData.do")
   public String infoData(DataCenterVo dataCenterVo, ModelMap model) throws IOException, SQLException , NullPointerException {
   	        
       model.addAttribute("dataCenterVo", dataCenterVo);
       
       return "data/infoData.tiles";
   } 
   
   
 
	/**
	 * <pre>
	 * 데이터분석실-이용안내 화면으로 이동
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 6. 28. 
	 * @param dataCenterVo
	 * @param model
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
   @RequestMapping(value="/data/gurideData.do")
   public String gurideData(DataCenterVo dataCenterVo, ModelMap model) throws IOException, SQLException , NullPointerException {
   	        
       model.addAttribute("dataCenterVo", dataCenterVo);
       
       return "data/guideData.tiles";
   } 
   
   

   /**
	 * <pre>
	 * 데이터분석실-이용안내 화면으로 이동
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 6. 28. 
	 * @param request
	 * @param relatedInsVo
	 * @param resp
	 * @param out
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
@RequestMapping("data/relatedInsRead.do")
   public void relatedInsRead(HttpServletRequest request, RelatedInsVo relatedInsVo, HttpServletResponse resp, Writer out)  throws IOException, SQLException , NullPointerException {
	   
   	String xml = "";
       
   	List<RelatedInsVo> list = dataCenterService.selectRelatedInsList(relatedInsVo);
   	
   	int totalCnt = dataCenterService.selectRelatedInsTotalCount(relatedInsVo);
   	
   	if(list != null){
   		if(list.size() > 0){
   			
   			xml = XmlUtil.listToXml(list);
   			
   			 /* 총카운터 세팅*/
   			 
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
	 * 데이터 분석실 - 보건의료 데이터 화면으로 이동
	 * 
	 * </pre>
	 * @author : 
	 * @date   : 2018. 6. 28.
	 * @param healthCareVo
	 * @param model
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
@RequestMapping(value="data/medical.do")
   public String infoData(HealthCareVo healthCareVo, ModelMap model) throws IOException, SQLException , NullPointerException {
   	        
       model.addAttribute("healthCareVo", healthCareVo);
       
       return "data/medical.tiles";
   } 
   
	 /**
	 * <pre>
	 * 데이터 분석실 - 보건의료 데이터 목록화면을 조회한다.
	 * 
	 * </pre>
	 * @author : 
	 * @date   : 2018. 6. 28.
	 * @param request
	 * @param healthCareVo
	 * @param resp
	 * @param out
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
@RequestMapping("data/healthCareRead.do")
   public void healthCareRead(HttpServletRequest request, HealthCareVo healthCareVo, HttpServletResponse resp, Writer out)  throws IOException, SQLException , NullPointerException {
	   
   	String xml = "";
       
   	List<HealthCareVo> list = dataCenterService.selectHealthCareList(healthCareVo);
   	
   	int totalCnt = dataCenterService.selectHealthCareTotalCount(healthCareVo);
   	
   	if(list != null){
   		if(list.size() > 0){
   			
   			xml = XmlUtil.listToXml(list);
   			
   			 /* 총카운터 세팅*/
   			 
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
   

    
}
