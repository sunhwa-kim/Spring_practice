package kr.go.cris.ptl.centerintro.edu.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import kr.go.cris.ptl.centerintro.edu.vo.EduVo;

import org.springframework.stereotype.Repository;


/**
 * <pre>
 * 교육관리 DAO interface 구현
 * 
 * </pre>
 * @FileName : EduDao.java
 * @package  : kr.go.cris.ptl.centerintro.edu.dao
 * @author   : wonki0138
 * @date     : 2018. 6. 28.
 * 
 */
@Repository
public interface EduDao {
	
	
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
	public int selectEduTotalCount(EduVo eduVo) throws IOException , SQLException , NullPointerException;

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
	public List<EduVo> selectEduList(EduVo eduVo) throws IOException , SQLException , NullPointerException;

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
	public EduVo selectEduView(EduVo eduVo) throws IOException , SQLException , NullPointerException;

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
	public int updateEduRdcnt(EduVo eduVo) throws IOException , SQLException , NullPointerException;


}
