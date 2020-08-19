package kr.go.cris.ptl.centerintro.intro.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.ptl.centerintro.intro.service.InfoService;
import kr.go.cris.ptl.centerintro.intro.vo.InfoVo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * <pre>
 *  센터소개 controller 구현
 * 
 * </pre>
 * @FileName InfoController.java
 * @package kr.go.cris.ptl.centerintro.intro.InfoController
 * @author wonki0138
 * @date 2018. 4. 12.
 * 
 */
@Controller
public class InfoController  extends BaseController {
	
	@Resource
    private InfoService infoService;
	
	/**
	  * <pre>
	  * 
	  * 센터소개 목록을 반환한다.
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 4. 12.
	  * @param model
	  * @param request
	  * @return
	  * @throws IOException , SQLException , NullPointerException
	  */
	@RequestMapping(value="/centerintro/info/centerInfo.do")
	public String infoList(Model model, HttpServletRequest request, InfoVo infoVo)  throws IOException , SQLException , NullPointerException {
		
		String info_code = "centerinfo01";
		infoVo.setInfo_code(info_code);
		
		infoVo = infoService.selectPTLInfo(infoVo);
		
		model.addAttribute("infoVo",infoVo);
		
		return "centerintro/info/centerInfo.tiles";
	}
	
	
	/**
	  * <pre>
	  * 
	  * 연혁(센터소개)
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 4. 12.
	  * @param model
	  * @param request
	  * @return
	  * @throws IOException , SQLException , NullPointerException
	  */
	@RequestMapping(value="/centerintro/info/centerHistory.do")
	public String centerHistory(Model model, HttpServletRequest request)  throws IOException , SQLException , NullPointerException {
		
		return "centerintro/info/centerHistory.tiles";
	}
	
	/**
	  * <pre>
	  * 
	  * 찾아오시는길(센터소개)
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 4. 12.
	  * @param model
	  * @param request
	  * @return
	  * @throws IOException , SQLException , NullPointerException
	  */
	@RequestMapping(value="/centerintro/info/centerMap.do")
	public String centerMap(Model model, HttpServletRequest request)  throws IOException , SQLException , NullPointerException {
		
		return "centerintro/info/centerMap.tiles";
	}
	
	/**
	  * <pre>
	  * 
	  * 담당업무(센터소개)
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 4. 12.
	  * @param model
	  * @param request
	  * @return
	  * @throws IOException , SQLException , NullPointerException
	  */
	@RequestMapping(value="/centerintro/info/centerWork.do")
	public String centerWork(Model model, HttpServletRequest request)  throws IOException , SQLException , NullPointerException {
		
		return "centerintro/info/centerWork.tiles";
	}
	
	
	
	/**
	  * <pre>
	  * 
	  * 이용안내
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 4. 12.
	  * @param model
	  * @param request
	  * @return
	  * @throws IOException , SQLException , NullPointerException
	  */
	@RequestMapping(value="/centerintro/info/centerGuide.do")
	public String centerGuide(Model model, HttpServletRequest request,InfoVo infoVo)  throws IOException , SQLException , NullPointerException {
		
		String info_code = "centerguide01";
		infoVo.setInfo_code(info_code);
		
		infoVo = infoService.selectPTLInfo(infoVo);
		
		model.addAttribute("infoVo",infoVo);
		
		
		return "centerintro/info/centerGuide.tiles";
	}
	
	
	/**
	  * <pre>
	  * 
	  * 자료실(이용안내)
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 4. 12.
	  * @param model
	  * @param request
	  * @return
	  * @throws IOException , SQLException , NullPointerException
	  */
	@RequestMapping(value="/centerintro/info/centerReference.do")
	public String centerReference(Model model, HttpServletRequest request)  throws IOException , SQLException , NullPointerException {
		
		return "centerintro/info/centerReference.tiles";
	}
	
	
	/**
	  * <pre>
	  * 
	  * 시설예약(이용안내)
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 4. 12.
	  * @param model
	  * @param request
	  * @return
	  * @throws IOException , SQLException , NullPointerException
	  */
	@RequestMapping(value="/centerintro/info/centerReservation.do")
	public String centerReservation(Model model, HttpServletRequest request)  throws IOException , SQLException , NullPointerException {
		
		return "centerintro/info/centerReservation.tiles";
	}
	
	
	/**
	 * <pre>
	 * 모바일서비스 화면으로 이동한다.
	 *
	 * </pre>
	 * @author : user
	 * @date   : 2018. 7. 4. 
	 * @param model
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	@RequestMapping(value="/centerintro/mobile/mobileService.do")
	public String mobileService(Model model, HttpServletRequest request) throws IOException , SQLException , NullPointerException{
		
		return "centerintro/info/mobileService.tiles";
	}

}
