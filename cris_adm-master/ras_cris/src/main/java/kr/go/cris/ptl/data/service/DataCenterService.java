package kr.go.cris.ptl.data.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import kr.go.cris.ptl.data.vo.DataCenterVo;
import kr.go.cris.ptl.data.vo.HealthCareVo;
import kr.go.cris.ptl.data.vo.RelatedInsVo;


/**
 * <pre>
 * 데이터 센터 service interface 구현
 * 
 * </pre>
 * @FileName : DataCenterService.java
 * @package  : kr.go.cris.ptl.data.service
 * @author   : wonki0138
 * @date     : 2018. 6. 28.
 * 
 */
public interface DataCenterService {

	/**
	 * <pre>
	 * 데이터분석실 - 데이터 목록을 조회한다.
	 *
	 * </pre>
	 * @author : user
	 * @date   : 2018. 6. 28. 
	 * @param dataCenterVo
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	List<DataCenterVo> selectDataAdminList(DataCenterVo dataCenterVo) throws IOException, SQLException , NullPointerException;

	/**
	 * <pre>
	 * 데이터분석실 - 데이터 목록 건수를 조회한다.
	 *
	 * </pre>
	 * @author : user
	 * @date   : 2018. 6. 28. 
	 * @param dataCenterVo
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	int selectDataCenterTotalCount(DataCenterVo dataCenterVo) throws IOException, SQLException , NullPointerException;

	/**
	 * <pre>
	 * 데이터분석실 - 데이터 상세정보를 조회한다.
	 *
	 * </pre>
	 * @author : user
	 * @date   : 2018. 6. 28. 
	 * @param dataCenterVo
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	DataCenterVo selectDataView(DataCenterVo dataCenterVo) throws IOException, SQLException , NullPointerException;

	/**
	 * <pre>
	 * 데이터분석실 - 데이터 목록 조회수를 업데이트한다.
	 *
	 * </pre>
	 * @author : user
	 * @date   : 2018. 6. 28. 
	 * @param dataCenterVo
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	int updateDataRdcnt(DataCenterVo dataCenterVo) throws IOException, SQLException , NullPointerException;
	
	/**
	 * <pre>
	 * 유관기관 데이터 - 유관기관 목록을 조회한다.
	 *
	 * </pre>
	 * @author : user
	 * @date   : 2018. 6. 28. 
	 * @param relatedInsVo
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	List<RelatedInsVo> selectRelatedInsList(RelatedInsVo relatedInsVo) throws IOException,SQLException , NullPointerException;

	/**
	 * <pre>
	 * 유관기관 데이터 - 유관기관 목록건수를 조회한다.
	 *
	 * </pre>
	 * @author : user
	 * @date   : 2018. 6. 28. 
	 * @param relatedInsVo
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	int selectRelatedInsTotalCount(RelatedInsVo relatedInsVo) throws IOException, SQLException , NullPointerException;
	
	/**
	 * <pre>
	 * 보건의료 데이터 - 보건의료 목록을 조회한다.
	 *
	 * </pre>
	 * @author : user
	 * @date   : 2018. 6. 28. 
	 * @param healthCareVo
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	List<HealthCareVo> selectHealthCareList(HealthCareVo healthCareVo) throws IOException, SQLException , NullPointerException;
	
	/**
	 * <pre>
	 * 보건의료 데이터 - 보건의료 목록 건수를 조회한다.
	 *
	 * </pre>
	 * @author : user
	 * @date   : 2018. 6. 28. 
	 * @param healthCareVo
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	int selectHealthCareTotalCount(HealthCareVo healthCareVo) throws IOException, SQLException , NullPointerException;
}

