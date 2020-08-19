package kr.go.cris.ptl.centerintro.noti.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.ptl.centerintro.noti.dao.IntroNotiDao;
import kr.go.cris.ptl.centerintro.noti.vo.IntroNotiVo;

import org.springframework.stereotype.Service;


/**
 * <pre>
 * 
 * 알림마당 ServiceImpl 로직 구현
 * </pre>
 * @FileName : IntroNotiServiceImpl.java
 * @package  : kr.go.cris.ptl.intro.noti.service
 * @author   : wonki0138
 * @date     : 2018. 3. 16.
 * 
 */
@Service
public class IntroNotiServiceImpl extends BaseServiceImpl implements IntroNotiService {

	@Resource(name="introNotiDao")
	private IntroNotiDao introNotiDao;
	

	
	
	/**
	 * <pre>
	 *알림마당 - 게시물 목록을 반환한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param introNotiVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<IntroNotiVo> selectNotiList(IntroNotiVo introNotiVo)  throws IOException , SQLException , NullPointerException{

		return introNotiDao.selectNotiList(introNotiVo);
	}


	

	/**
	 * <pre>
	 *
	 * 알림마당 - 조회수 증가
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param introNotiVo
	 * @throws IOException , SQLException , NullPointerException
	 */
	public void updateReadCnt(IntroNotiVo introNotiVo)   throws IOException , SQLException , NullPointerException{

		introNotiDao.updateReadCnt(introNotiVo);

	}

	/**
	 * <pre>
	 *
	 *  알림마당  - 개시물 총갯수를 반환한다.
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param introNotiVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public int selectNotiTotalCount(IntroNotiVo introNotiVo) throws IOException , SQLException , NullPointerException {
		return introNotiDao.selectNotiTotalCount(introNotiVo);
	}


	/**
	 * <pre>
	 * 메인화면 알림마당 리스트목록을 반환한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param introNotiVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public List<IntroNotiVo> selectMainNotiList(IntroNotiVo introNotiVo) throws IOException , SQLException , NullPointerException {
		return introNotiDao.selectMainNotiList(introNotiVo);
	}


	/**
	 * <pre>
	 * 알림마당 - 게시물 상세 정보를 반환한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param introNotiVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	@Override
	public IntroNotiVo selectNotiInfo(IntroNotiVo introNotiVo) throws IOException , SQLException , NullPointerException {
		return introNotiDao.selectNotiInfo(introNotiVo);
	}



}
