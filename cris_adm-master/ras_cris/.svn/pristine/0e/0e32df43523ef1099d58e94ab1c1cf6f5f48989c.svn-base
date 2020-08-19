package kr.go.cris.ptl.data.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.ptl.data.dao.DataCenterDao;
import kr.go.cris.ptl.data.vo.DataCenterVo;
import kr.go.cris.ptl.data.vo.HealthCareVo;
import kr.go.cris.ptl.data.vo.RelatedInsVo;

import org.springframework.stereotype.Service;

/**
 * <pre>
 * 데이터센서 ServiceImpl 로직 구현
 * 
 * </pre>
 * @FileName : DataCenterServiceImpl.java
 * @package  : kr.go.cris.ptl.data.service
 * @author   : wonki0138
 * @date     : 2018. 6. 28.
 * 
 */
@Service
public class DataCenterServiceImpl extends BaseServiceImpl implements DataCenterService {

    @Resource
    private DataCenterDao dataCenterDao;

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
	@Override
	public List<DataCenterVo> selectDataAdminList(DataCenterVo dataCenterVo) throws IOException,	SQLException , NullPointerException{
				
		return dataCenterDao.selectDataAdminList(dataCenterVo);
				
	}

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
	@Override
	public int selectDataCenterTotalCount(DataCenterVo dataCenterVo) throws IOException, SQLException , NullPointerException {
		
		return dataCenterDao.selectDataCenterTotalCount(dataCenterVo);
	}

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
	@Override
	public DataCenterVo selectDataView(DataCenterVo dataCenterVo) throws IOException, SQLException , NullPointerException{
		
		return dataCenterDao.selectDataView(dataCenterVo);
	}

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
	@Override
	public int updateDataRdcnt(DataCenterVo dataCenterVo) throws IOException, SQLException , NullPointerException{
		
		return dataCenterDao.updateDataRdcnt(dataCenterVo);
		
	}

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
	@Override
	public List<RelatedInsVo> selectRelatedInsList(RelatedInsVo relatedInsVo)
			throws IOException, SQLException , NullPointerException{
		return dataCenterDao.selectRelatedInsList(relatedInsVo);
	}

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
	@Override
	public int selectRelatedInsTotalCount(RelatedInsVo relatedInsVo)
			throws IOException, SQLException , NullPointerException {
		return dataCenterDao.selectRelatedInsTotalCount(relatedInsVo);
	}

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
	@Override
	public List<HealthCareVo> selectHealthCareList(HealthCareVo healthCareVo)
			throws IOException, SQLException , NullPointerException{
		return dataCenterDao.selectHealthCareList(healthCareVo);
	}

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
	@Override
	public int selectHealthCareTotalCount(HealthCareVo healthCareVo)
			throws IOException, SQLException ,NullPointerException {
		return dataCenterDao.selectHealthCareTotalCount(healthCareVo);
	}

}
