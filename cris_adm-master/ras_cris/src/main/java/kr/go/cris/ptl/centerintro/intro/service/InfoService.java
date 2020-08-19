package kr.go.cris.ptl.centerintro.intro.service;

import java.io.IOException;
import java.sql.SQLException;

import kr.go.cris.ptl.centerintro.intro.vo.InfoVo;

/**
 * <pre>
 * 센터 소개  Service Interface  구현 
 * 
 * </pre>
 * @FileName : InfoDao.java
 * @package  : kr.go.cris.ptl.centerintro.intro.dao
 * @author   : wonki0138
 * @date     : 2018. 6. 28.
 * 
 */
public interface InfoService {


	/**
	 * <pre>
	 *센터소개 정보를 반환한다.
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
	public InfoVo selectPTLInfo(InfoVo infoVo)throws IOException , SQLException , NullPointerException;




}
