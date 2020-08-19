/******************************************************************
 * Copyright RASTECH 2015
 ******************************************************************/
package kr.go.cris.commons.code.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.go.cris.commons.code.vo.CodeVo;

import org.springframework.stereotype.Repository;

/**
 * <pre>
 * FileName: CodeDao.java
 * Package : kr.go.cris.commons.code.dao
 *
 * 공통 코드 정보 조회 DAO interface.
 *
 * </pre>
 * @author :
 * @date   : 2014. 7. 10.
 */
@Repository
public interface CodeDao {
    /**   
     *
     * <pre>
     * 상위 코드를 파라미터로 코드 목록을 조회한다.
     *
     * </pre>
     * @author :
     * @date   : 2015. 7. 10.
     * @param
     * @return
     * @throws IOException, SQLException , NullPointerException
     */
//	@Cacheable(cacheName="headerSearchKeyword")
    public List<CodeVo> selectReportList(Map<String, Object> map) throws IOException, SQLException , NullPointerException;
    
    
  
    
}
