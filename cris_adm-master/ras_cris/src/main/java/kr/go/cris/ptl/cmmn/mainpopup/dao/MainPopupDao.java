package kr.go.cris.ptl.cmmn.mainpopup.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import kr.go.cris.ptl.cmmn.mainpopup.vo.MainPopupVo;

import org.springframework.stereotype.Repository;

/**
 * <pre>
 *  메인팝업존 DAO interface 구현
 * 
 * </pre>
 * @FileName : MainPopupDao.java
 * @package  : kr.go.cris.ptl.cmmn.mainpopup.dao
 * @author   : wonki0138
 * @date     : 2018. 2. 23.
 * 
 */
@Repository
public interface MainPopupDao {


	
	
	
	/**
	 * <pre>
	 * 메인화면 공지사항 리스트
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 2. 23. 
	 * @param mainPopupVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<MainPopupVo> selectMainPopupList(MainPopupVo mainPopupVo)  throws IOException , SQLException , NullPointerException;

	
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
	public List<MainPopupVo> selectMainPopupAtchFileInfo(MainPopupVo mainPopupVo)  throws IOException , SQLException , NullPointerException;
	
	
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
	public MainPopupVo selectMainPopupAtchFileSrc(MainPopupVo mainPopupVo)  throws IOException , SQLException , NullPointerException;
}
