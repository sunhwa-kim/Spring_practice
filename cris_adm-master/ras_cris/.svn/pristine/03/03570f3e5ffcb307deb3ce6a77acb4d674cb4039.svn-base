/******************************************************************
 * Copyright RASTECH 2015
 ******************************************************************/
package kr.go.cris.commons.file.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.commons.file.service.FileService;
import kr.go.cris.commons.file.vo.FileVo;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * FileName: FileController.java
 * Package : kr.go.cris.commons.file.controller
 * <pre>
 *
 * 첨부 파일 다운로드 Controller.
 *
 * </pre>
 * @author : rastech
 * @date   : 2015. 3. 9.
 */
@Controller
public class FileController extends BaseController {
   
	@Resource
    private FileService fileService;


    /**
     * 링크소프트 첨부파일에 대한 목록을 조회한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws IOException, SQLException , NullPointerException
     */
    @RequestMapping("/cmm/fms/selectLinkFileInfs.do")
    public String selectLinkFileInfs(FileVo fileVO,HttpServletRequest request,   Model model) throws IOException, SQLException , NullPointerException {

	
		String atchFileId = request.getParameter("param_atchFileId") ; 
		List<FileVo> result = null;
		
		if(StringUtils.isNotBlank(atchFileId)){
		
			fileVO.setAtch_file_id(atchFileId);
			result = fileService.selectLinkFileInfs(fileVO);
		}	
			model.addAttribute("fileList", result);
			model.addAttribute("updateFlag", "N");
			model.addAttribute("fileListCnt", result.size());
			model.addAttribute("atch_file_id", atchFileId);
		
				
		
		return "cmm/fms/EgovLinkFileList";
		
    }
    
}