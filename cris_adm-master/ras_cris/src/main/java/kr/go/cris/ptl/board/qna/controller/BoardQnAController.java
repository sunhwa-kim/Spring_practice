package kr.go.cris.ptl.board.qna.controller;

import java.io.IOException;
import java.io.Writer;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.commons.login.intercept.DefaultFilterInvocationSecurityMetadataSource;
import kr.go.cris.commons.utils.XmlUtil;
import kr.go.cris.ptl.board.qna.service.BoardQnAService;
import kr.go.cris.ptl.board.qna.vo.BoardQnAVo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class BoardQnAController extends BaseController{
	
	@Resource
	private BoardQnAService boardQnAService;
	
	// 사용자별 권한 정의 객체
    @Autowired
    private DefaultFilterInvocationSecurityMetadataSource databaseSecurityMetadataSource;
    
    
	@RequestMapping("board/qna/board.do")
	public String board(Model model, HttpServletRequest request,BoardQnAVo boardQnAVo) throws IOException, SQLException, NullPointerException {
		
//		String searchClassification = boardQnAVo.getSearchClassification();
		
		//String searchKeyword = request.getParameter("searchKeyword");
		//String searchClassification = request.getParameter("searchClassification");
		//String searchCustomHeader = request.getParameter("searchCustomHeader");
		//String searchSituation = request.getParameter("searchSituation");
		
		model.addAttribute("boardQnAVo", boardQnAVo);
		//model.addAttribute("searchKeyword", searchKeyword);
		//model.addAttribute("searchClassification", searchClassification);
		//model.addAttribute("searchCustomHeader", searchCustomHeader);
		//model.addAttribute("searchSituation", searchSituation);
		model.addAttribute("list",getCodeList("DATA_TYPE"));
		model.addAttribute("QnA_CLASSIFICATION",getCodeList("QnA_CLASSIFICATION"));
		model.addAttribute("QnA_CustomHeader",getCodeList("QnA_CustomHeader"));
		model.addAttribute("QnA_SITUATION",getCodeList("QnA_SITUATION"));
		return "board/board_list.tiles";
	}
	
	@RequestMapping("board/qna/boardQnaList.do")
    public void boardQnaList(HttpServletRequest request, BoardQnAVo boardQnaVo, HttpServletResponse resp, Writer out)  throws IOException , SQLException , NullPointerException {

    	String xml = "";    	
    	
    	List<BoardQnAVo> list = boardQnAService.selectBoardQnAList(boardQnaVo);
    	int page_list = boardQnAService.selectBQnAT_Rows(boardQnaVo);
    	
    	
    	if(list != null){
    		xml = XmlUtil.listToXml(list);

    		if(list.size() > 0){
    			
    			/*
    			 * 총카운터 세팅
    			 */
    	    	StringBuffer sb = new StringBuffer();
    	    	String[] str = xml.split("<items>");
    	    	
    	    	sb.append(str[0]);
    	    	sb.append("<items>");
    	    	sb.append("<totalPageCnt>"+Math.ceil((double)page_list/(double)10)+"</totalPageCnt>\n");    	 
    	    	sb.append("<totalDataCnt>"+page_list+"</totalDataCnt>\n");
    	    	sb.append(str[1]);
    	    	
    	    	xml = sb.toString();
    		}
    	}	else {
    		System.out.println("########################################");
    		System.out.println("                                        list is null ...");
    	}
    	resp.setContentType("text/xml");
    	resp.setCharacterEncoding("UTF-8");
    	resp.setHeader("Cache-Control", "no-cache");
    	resp.setHeader("Pragma", "no-cache");
    	resp.setDateHeader("Expires", -1);
    
    	out.write(xml);
   	
    	out.flush();
    }
	
//	상세
	@RequestMapping("board/qna/boardQnaListDetailed.do")
	public String boardQnaListDetailed(Model model, HttpServletRequest request,BoardQnAVo boardQnaVo) throws IOException, SQLException, NullPointerException {
		
		String page = boardQnaVo.getPage();
		String searchKeyword = boardQnaVo.getSearchKeyword();
		String searchClassification = request.getParameter("searchClassification");
		String searchCustomHeader = request.getParameter("searchCustomHeader");
		String searchSituation = request.getParameter("searchSituation");
				
		BoardQnAVo resultDetailedVo = boardQnAService.selectBoardQnaDetailed(boardQnaVo);
		
		resultDetailedVo.setPage(page);
		model.addAttribute("searchKeyword", searchKeyword);

		model.addAttribute("resultDetailedVo", resultDetailedVo);
		model.addAttribute("searchClassification", searchClassification);
		model.addAttribute("searchCustomHeader", searchCustomHeader);
		model.addAttribute("searchSituation", searchSituation);

		return "board/board_listDetailed.tiles";
	}
	
}
