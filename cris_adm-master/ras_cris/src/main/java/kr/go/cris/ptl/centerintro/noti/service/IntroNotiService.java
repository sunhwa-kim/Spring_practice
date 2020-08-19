package kr.go.cris.ptl.centerintro.noti.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import kr.go.cris.ptl.centerintro.noti.vo.IntroNotiVo;

/**
 *
 * <pre>
 * FileName: BoardNotiService.java
 * Package : kr.go.cris.ptl.board.noti.service
 *
 * 알림마당 Service Interface 구현
 *
 * </pre>
 * @author : sbkang
 * @date   : 2015. 9. 14.
 */
public interface IntroNotiService {



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
	public List<IntroNotiVo> selectNotiList(IntroNotiVo introNotiVo)  throws IOException , SQLException , NullPointerException ;


	/**
	 * <pre>
	 *알림마당 - 게시물 상세 정보를 반환한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param introNotiVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public IntroNotiVo selectNotiInfo(IntroNotiVo introNotiVo)   throws IOException , SQLException , NullPointerException;

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
	public void updateReadCnt(IntroNotiVo introNotiVo)   throws IOException , SQLException , NullPointerException;

	

	
	
	/**
	 * <pre>
	 *
	 *  알림마당  - 총 게시물 갯수를 반환한다.
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 16. 
	 * @param introNotiVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public int selectNotiTotalCount( IntroNotiVo introNotiVo) throws IOException , SQLException , NullPointerException;


	/**
	 * <pre>
	 * 메인화면 알림마당 리스트 목록을 반환한다
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 6. 28. 
	 * @param introNotiVo
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	public List<IntroNotiVo> selectMainNotiList(IntroNotiVo introNotiVo) throws IOException , SQLException , NullPointerException;

}
