package kr.go.cris.ptl.centerintro.noti.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import kr.go.cris.ptl.centerintro.noti.vo.IntroNotiVo;

import org.springframework.stereotype.Repository;

/**
 * <pre>
 *  알림마당 - DAO interface 구현
 * 
 * </pre>
 * @FileName : IntroNotiDao.java
 * @package  : kr.go.cris.ptl.intro.noti.dao
 * @author   : wonki0138
 * @date     : 2018. 3. 16.
 * 
 */
@Repository
public interface IntroNotiDao {


	/**
	 * <pre>
	 * 알림마당 - 게시물 목록을 반환한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param introNotiVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<IntroNotiVo> selectNotiList(IntroNotiVo introNotiVo)throws IOException , SQLException , NullPointerException;


	/**
	 * <pre>
	 * 알림마당 - 게시물 상세정보를 반환한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param introNotiVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public IntroNotiVo selectNotiInfo(IntroNotiVo introNotiVo)throws IOException , SQLException , NullPointerException;


	/**
	 * <pre>
	 * 알림마당 - 게시물 조회 증가
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param introNotiVo
	 * @throws IOException , SQLException , NullPointerException
	 */
	public void updateReadCnt(IntroNotiVo introNotiVo)throws IOException , SQLException , NullPointerException;


	/**
	 * <pre>
	 *  알림마당 - 데이터 총 갯수를 반환한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param introNotiVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public int selectNotiTotalCount(IntroNotiVo introNotiVo) throws IOException , SQLException , NullPointerException;
	
	
	
	/**
	 * <pre>
	 * 메인화면 공지사항 리스트 목록을 반환한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param introNotiVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<IntroNotiVo> selectMainNotiList(IntroNotiVo introNotiVo)  throws IOException , SQLException , NullPointerException;



}
