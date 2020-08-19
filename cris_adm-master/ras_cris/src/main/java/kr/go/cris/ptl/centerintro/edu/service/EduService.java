package kr.go.cris.ptl.centerintro.edu.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import kr.go.cris.ptl.centerintro.edu.vo.EduVo;


/**
 * <pre>
 * 교육관리 Service interface 구현
 * 
 * </pre>
 * @FileName : EduService.java
 * @package  : kr.go.cris.ptl.centerintro.edu.service
 * @author   : wonki0138
 * @date     : 2018. 6. 28.
 * 
 */
public interface EduService {

	
	/**
	 * <pre>
	 * 교육 목록 리스트를 반환한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 6. 28. 
	 * @param eduVo
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 */

	List<EduVo> selectEduList(EduVo eduVo) throws IOException , SQLException , NullPointerException;

	
	
	/**
	 * <pre>
	 *  교육 총 게시물 수를 반환한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 6. 28. 
	 * @param eduVo
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 */
	int selectEduTotalCount(EduVo eduVo) throws IOException , SQLException , NullPointerException;

	
	/**
	 * <pre>
	 * 교육 상세 정보를 반환한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 6. 28. 
	 * @param eduVo
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 */
	EduVo selectEduView(EduVo eduVo) throws IOException , SQLException , NullPointerException;

	
	/**
	 * <pre>
	 * 교육 정보를 게시물 조회수를 update 한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 6. 28. 
	 * @param eduVo
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 */
	int updateEduRdcnt(EduVo eduVo) throws IOException , SQLException , NullPointerException;

   
}
