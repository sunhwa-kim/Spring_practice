package kr.go.cris.ptl.centerintro.intro.service;

import java.io.IOException;
import java.sql.SQLException;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.ptl.centerintro.intro.dao.InfoDao;
import kr.go.cris.ptl.centerintro.intro.vo.InfoVo;

import org.springframework.stereotype.Service;


/**
 * <pre>
 * 센터 소개 ServiceImpl 구현
 * 
 * </pre>
 * @FileName : InfoDao.java
 * @package  : kr.go.cris.ptl.centerintro.intro.dao
 * @author   : wonki0138
 * @date     : 2018. 6. 28.
 * 
 */
@Service
public class InfoServiceImpl extends BaseServiceImpl implements InfoService {

	@Resource(name="infoDao")
	private InfoDao infoDao;

	
	/**
	 * <pre>
	 * 센터소개 정보를 반환한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 6. 28. 
	 * @param infoVo
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	@Override
	public InfoVo selectPTLInfo(InfoVo infoVo) throws IOException , SQLException , NullPointerException {
		return infoDao.selectPTLInfo(infoVo);
	}
}
