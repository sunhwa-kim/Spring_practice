/******************************************************************
 * Copyright RASTECH 2015
 ******************************************************************/
package kr.go.cris.commons.file.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import egovframework.cmmn.service.FileVO;
import kr.go.cris.commons.file.vo.FileVo;

/**
 * <pre>
 * FileName: FileBiz.java
 * Package : kr.go.cris.commons.file.service
 *
 * 첨부 파일 처리 Service interface.
 *
 * </pre>
 * @author : rastech
 * @data   : 2015. 3. 6.
 */
public interface FileService {
	
	  /**
	 * <pre>
	 *
	 * 파일 다운로드 service
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 2. 26. 
	 * @param fvo
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	public List<FileVo> selectLinkFileInfs(FileVo fvo) throws IOException, SQLException , NullPointerException;

	public FileVO selectFileInf(FileVO vo) throws IOException, SQLException , NullPointerException;
}
