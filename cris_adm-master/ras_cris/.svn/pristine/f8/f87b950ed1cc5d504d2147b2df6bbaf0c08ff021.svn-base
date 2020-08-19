package kr.go.cris.ptl.stats.service;
  
import java.io.IOException;
import java.sql.SQLException;

import kr.go.cris.ptl.stats.vo.PTLStatAccessVo;
import kr.go.cris.ptl.stats.vo.StatsMenuVo;
 
/**
 * <pre>
 * FileName: StatsService.java
 * Package : kr.go.cris.ptl.stats.service
 *
 * 통계 Service
 *
 * </pre>
 * @author : wonki0138
 * @date   : 2018. 04. 03.
 */
public interface StatsService {
	
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
	public void insertStatsMenu (StatsMenuVo statsMenuVo) throws IOException, SQLException , NullPointerException;
	
	/**
	 * 접근 정보를 등록한다.
	 * 
	 * @param vo
	 * @exception Exception
	 */
	public void insertStatsAccess(PTLStatAccessVo vo) throws IOException, SQLException , NullPointerException;		
	
}
