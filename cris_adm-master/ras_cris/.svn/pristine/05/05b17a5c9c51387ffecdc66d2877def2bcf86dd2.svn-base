package kr.go.cris.ptl.archive.statistics.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import kr.go.cris.ptl.archive.statistics.vo.StatisticsVo;

import org.springframework.stereotype.Repository;

/**
 * <pre>
 * 
 * 아카이브 통계 Dao
 * </pre>
 * @FileName : StatisticsDao.java
 * @package  : kr.go.cris.ptl.archive.statistics.dao
 * @author   : wonki0138
 * @date     : 2018. 5. 15.
 * 
 */
@Repository
public interface StatisticsDao {
	
	
	/**
	 * <pre>
	 * 아카이브 통계 -  연도별 구축현황(소장통계)
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 5. 15. 
	 * @param statisticsVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<StatisticsVo> selectStatsPossession(StatisticsVo statisticsVo)  throws IOException , SQLException , NullPointerException;
	
	
	/**
	 * <pre>
	 * 아카이브 통계 - 다운로드수
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 5. 15. 
	 * @param statisticsVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<StatisticsVo> selectStatsDownload(StatisticsVo statisticsVo) throws IOException , SQLException , NullPointerException;
	
	
	/**
	 * <pre>
	 * 아카이브 통계 - 조회수
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 5. 15. 
	 * @param statisticsVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<StatisticsVo> selectStatsView(StatisticsVo statisticsVo) throws IOException , SQLException , NullPointerException;
	
	
	/**
	 * <pre>
	 * 아카이브 통계 - 발주부서
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 5. 15. 
	 * @param statisticsVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<StatisticsVo> selectStatsOrderDept(StatisticsVo statisticsVo) throws IOException , SQLException , NullPointerException;
	
	
	/**
	 * <pre>
	 * 아카이브 통계 - SCI논문
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 5. 15. 
	 * @param statisticsVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<StatisticsVo> selectStatsRndSCI(StatisticsVo statisticsVo) throws IOException , SQLException , NullPointerException;
	
	
	/**
	 * <pre>
	 * 아카이브 통계 - 첨부파일
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 5. 16. 
	 * @param statisticsVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public List<StatisticsVo> selectStatsFile(StatisticsVo statisticsVo) throws IOException , SQLException , NullPointerException;
	
	
	
	
}
