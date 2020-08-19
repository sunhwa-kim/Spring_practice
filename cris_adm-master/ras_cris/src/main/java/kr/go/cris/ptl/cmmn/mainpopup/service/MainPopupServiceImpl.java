package kr.go.cris.ptl.cmmn.mainpopup.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.ptl.cmmn.mainpopup.dao.MainPopupDao;
import kr.go.cris.ptl.cmmn.mainpopup.vo.MainPopupVo;

import org.springframework.stereotype.Service;

/**
 * <pre>
 * 
 * 메인팝업존 ServiceImpl 구현
 * </pre>
 * @FileName : MainPopupServiceImpl.java
 * @package  : kr.go.cris.ptl.cmmn.mainpopup.service
 * @author   : wonki0138
 * @date     : 2018. 6. 28.
 * 
 */
@Service
public class MainPopupServiceImpl extends BaseServiceImpl implements MainPopupService {

	@Resource
	private MainPopupDao mainPopupDao;

	
	/**
	 * <pre>
	 * 메인화면 팝업 리스트
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 2. 23. 
	 * @param mainPopVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public List<MainPopupVo> selectMainPopupList(MainPopupVo mainPopupVo) throws IOException , SQLException , NullPointerException {
		return mainPopupDao.selectMainPopupList(mainPopupVo);
	}


	/**
	 * <pre>
	 * 메인화면 팝업 첨부파일 정보
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 2. 23. 
	 * @param mainPopVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public List<MainPopupVo> selectMainPopupAtchFileInfo(MainPopupVo mainPopupVo)
			throws IOException , SQLException , NullPointerException {
		
		return mainPopupDao.selectMainPopupAtchFileInfo(mainPopupVo);
	}


	/**
	 * <pre>
	 * 메인화면 팝업 첨부파일 경로
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 2. 23. 
	 * @param mainPopVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public MainPopupVo selectMainPopupAtchFileSrc(MainPopupVo mainPopupVo)
			throws IOException , SQLException , NullPointerException {
		return mainPopupDao.selectMainPopupAtchFileSrc(mainPopupVo);
	}


}
