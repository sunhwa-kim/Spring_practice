package kr.go.cris.ptl.index.controller;

import java.io.IOException;
import java.io.Writer;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.commons.login.intercept.DefaultFilterInvocationSecurityMetadataSource;
import kr.go.cris.commons.menu.service.MenuService;
import kr.go.cris.commons.utils.XmlUtil;
import kr.go.cris.ptl.centerintro.noti.service.IntroNotiService;
import kr.go.cris.ptl.mng.auth.vo.MngAuthVo;
import kr.go.cris.ptl.mng.code.service.MngCodeService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
/*import kr.go.cris.commons.scheduler.Scheduler;*/

/**
 * <pre>
 * FileName: IndexController.java
 * Package : kr.go.cris.ptl.index.controller
 * 
 * 메인페이지 - Controller
 *
 * </pre>
 * @author : sejin
 * @date   : 2016. 2. 17.
 */
@Controller("indexController")
public class IndexController  extends BaseController {

  

	@Resource
	private MngCodeService mngCodeService;

    @Resource
    private IntroNotiService boardNotiService;
    
    @Resource
	private MenuService menuService;
  
	// 사용자별 권한 정의 객체
    @Autowired
    private DefaultFilterInvocationSecurityMetadataSource databaseSecurityMetadataSource;

   /**
 * <pre>
 * 초기화면을 호출한다.
 *
 * </pre>
 * @author : user
 * @date   : 2018. 7. 4. 
 * @param request
 * @return
 * @throws IOException
 * @throws SQLException
 * @throws NullPointerException
 */
@RequestMapping(value="/")
   public String index(HttpServletRequest request) throws IOException, SQLException , NullPointerException {
	    
       return "redirect:index/index.do";
   }
   
   /**
 * <pre>
 * 초기화면을 호출한다.
 *
 * </pre>
 * @author : user
 * @date   : 2018. 7. 4. 
 * @param request
 * @param response
 * @param model
 * @return
 * @throws IOException
 * @throws SQLException
 * @throws NullPointerException
 */
@RequestMapping(value="/index/index.do")
   public String intro(HttpServletRequest request,HttpServletResponse response,Model model) throws IOException, SQLException , NullPointerException {
	 
	  
 	  return "index/index.main";
   }

	/**
	* <pre>
	* 영문초기화면을 호출한다.
	*
	* </pre>
	* @author : user
	* @date   : 2018. 7. 4. 
	* @param request
	* @param response
	* @param model
	* @return
	* @throws IOException
	* @throws SQLException
	* @throws NullPointerException
	*/
	@RequestMapping(value="/index/engindex.do")
	public String engIntro(HttpServletRequest request,HttpServletResponse response,Model model) throws IOException, SQLException , NullPointerException {
		  return "index/engIndex.engMain";
	}
	
	/**
	 * <pre>
	 * 권한관리 - 메뉴별 권한조회
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 2. 15.
	 * @param resp
	 * @param out
	 * @throws IOException, SQLException , NullPointerException
	 */
	@RequestMapping("/index/auth/readMenuAuth.do")
	public void readMenuAuth(HttpServletRequest request, HttpServletResponse resp, Writer out,String menu_url)  throws IOException, SQLException , NullPointerException {
		
		String xml="";
		List<MngAuthVo> mngAuthVoList = databaseSecurityMetadataSource.getMenuAuth(menu_url, request);
		
		if(mngAuthVoList.size() > 0){
			xml = XmlUtil.listToXml(mngAuthVoList);
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
	 * 팝업 레이어 호출
	 * @param request
	 * @param model
	 * @param paramOrgList
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	@RequestMapping(value="/indexPop.do")
    public String indexPop(HttpServletRequest request, Model model,String paramOrgList) throws IOException, SQLException , NullPointerException{
	   String reParam1 = request.getParameter("rasParameter1");
	   String reParam2= request.getParameter("rasParameter2");
	   model.addAttribute("reParam1" , reParam1);
	   model.addAttribute("reParam2" , reParam2);
	   return "index/indexPop.notiles";
    }
}
