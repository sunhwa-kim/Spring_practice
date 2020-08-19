/******************************************************************
 * Copyright RASTECH 2015
 ******************************************************************/
package kr.go.cris.commons.file.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.commons.file.dao.FileDao;
import kr.go.cris.commons.file.vo.FileVo;

import org.springframework.stereotype.Service;

import egovframework.cmmn.service.FileVO;

/**
 * FileName: FileServiceImpl.java
 * Package : kr.go.cris.commons.file.service
 * <pre>
 *
 * 첨부 파일 처리 Service implements.
 *
 * </pre>
 * @author : rastech
 * @data   : 2015. 3. 6.
 */
@Service
public class FileServiceImpl extends BaseServiceImpl implements FileService {
    @Resource
    private FileDao fileDao;
  
	/**
	 * <pre>
	 *
	 * 파일 다운로드 dao
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 2. 26. 
	 * @param fvo
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	@Override
	public List<FileVo> selectLinkFileInfs(FileVo fvo) throws IOException, SQLException , NullPointerException {
		return fileDao.selectLinkFileInfs(fvo);
	}

	@Override
	public FileVO selectFileInf(FileVO vo) throws IOException, SQLException,
			NullPointerException {
		// TODO Auto-generated method stub
		return null;
	}

}
