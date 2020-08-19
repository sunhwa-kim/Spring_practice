package kr.go.cris.ptl.scheduler.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.go.cris.ptl.scheduler.vo.SchedulerVo;

import org.springframework.stereotype.Repository;

/**
 * <pre>
 * 
 * 스케쥴러 Dao interface 구현
 * </pre>
 * @FileName : SchedulerDao.java
 * @package  :  kr.go.cris.commons.scheduler.dao
 * @author   : wonki0138
 * @date     : 2018. 3. 16.
 * 
 */
@Repository
public interface SchedulerDao {
	
	/**
	 * <pre>
	 * 장서관리의 보고서  / 소장파일이 있는 자료를 아카이브 보고서 테이블에 insert 한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 10. 02. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
	public int selectBooksCopy() throws IOException , SQLException , NullPointerException ;
	
	
	
	/**
	 * <pre>
	 * 장서관리의 보고서  / 소장파일이 있는 자료를 아카이브 보고서 테이블에 insert 한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 10. 02. 
	 * @param archiveRndVo
	 * @return
	 * @throws IOException , SQLException , NullPointerException
	 */
    public int insertSchedule(SchedulerVo vo) throws IOException , SQLException, NullPointerException;
    
    /**
   	 * <pre>
   	 * COMTECOPSEQ 테이블의 PTL_REPORT 아이디 MAX값을 증가시킨다.
   	 *
   	 * </pre>
   	 * @author : wonki0138
   	 * @date   : 2018. 10. 02. 
   	 * @param archiveRndVo
   	 * @return
   	 * @throws IOException , SQLException , NullPointerException
   	 */
    public int updateArchiveReportSeq() throws IOException , SQLException, NullPointerException ;



	public List<Map<String, Object>> selectProcEtl() throws SQLException;
}
