package kr.go.cris.ptl.stats.service;
  
import java.io.IOException;
import java.sql.SQLException;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.ptl.stats.dao.StatsDao;
import kr.go.cris.ptl.stats.vo.PTLStatAccessVo;
import kr.go.cris.ptl.stats.vo.StatsMenuVo;

import org.springframework.stereotype.Service;

/**
 * <pre>
 * FileName: StatsServiceImpl.java
 * Package : kr.go.cris.ptl.stats.service
 *
 * 통계 ServiceImpl
 *
 * </pre>
 * @author : wonki0138
 * @date   : 2018. 04. 03.
 */
@Service
public class StatsServiceImpl extends BaseServiceImpl implements StatsService {
	
	@Resource(name="statsDao")
	private StatsDao statsDao;
	
	
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
	@Override
	public void insertStatsMenu(StatsMenuVo statsMenuVo) throws IOException, SQLException , NullPointerException {
		statsDao.insertStatsMenu(statsMenuVo);
	}


	@Override
	public void insertStatsAccess(PTLStatAccessVo vo) throws IOException,
			SQLException, NullPointerException {
		statsDao.insertStatsAccess(vo);
		
	}
	
	
	
	
}
