package kr.go.cris.ptl.stats.dao;
   
import java.io.IOException;
import java.sql.SQLException;

import kr.go.cris.ptl.stats.vo.PTLStatAccessVo;
import kr.go.cris.ptl.stats.vo.StatsMenuVo;

import org.springframework.stereotype.Repository;
/**
 *
 * <pre>
 * FileName: StatsDao.java
 * Package : kr.go.cris.ptl.stats.dao
 *
 * 통계 DAO
 *
 * </pre>
 * @author : wonki0138
 * @date   : 2018. 04. 03.
 */

@Repository
public interface StatsDao {
	
	/**
	  * <pre> 
	  *  
	  * 메뉴화면 정보를 등록한다.
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 4. 3.
	  * @param statsMenuVo
	  * @throws IOException, SQLException , NullPointerException
	  */
	public void insertStatsMenu(StatsMenuVo statsMenuVo) throws IOException, SQLException , NullPointerException;
	
	
	/**
	  * <pre> 
	  *  
	  * 접근 정보를 등록한다.
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 4. 3.
	  * @param statsMenuVo
	  * @throws IOException, SQLException , NullPointerException
	  */
	public void insertStatsAccess(PTLStatAccessVo vo) throws IOException, SQLException , NullPointerException;
	
}
