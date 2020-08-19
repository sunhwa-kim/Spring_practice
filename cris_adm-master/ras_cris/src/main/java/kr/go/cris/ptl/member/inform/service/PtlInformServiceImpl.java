package kr.go.cris.ptl.member.inform.service;

import java.io.IOException;
import java.sql.SQLException;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.ptl.member.inform.dao.PtlInformDao;
import kr.go.cris.ptl.member.inform.vo.PtlInformVo;

import org.springframework.stereotype.Service;


/**
 * <pre>
 * 회원정보 Impl
 * 
 * </pre>
 * @FileName : PtlInformServiceImpl.java
 * @package  : kr.go.cris.ptl.member.inform.service
 * @author   : wonki0138
 * @date     : 2018. 3. 2.
 * 
 */
@Service
public class PtlInformServiceImpl extends BaseServiceImpl implements PtlInformService {

	@Resource(name="ptlInformDao")
	private PtlInformDao ptlInformDao;

	/**
	 * <pre>
	 *
	 * 회원정보를 등록한다.
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 3. 2. 
	 * @param vo
	 * @return
	 * @throws IOException, SQLException , NullPointerException
	 */
	@Override
	public void insertInform(PtlInformVo ptlInformVo) throws IOException, SQLException , NullPointerException {
		ptlInformDao.insertInform(ptlInformVo);
	}
	
	/**
	  * <pre>
	  * 
	  * 회원정보Cnt를 조회한다.
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 3. 21.
	  * @param ptlInformVo
	  * @return
	  * @throws IOException, SQLException , NullPointerException
	  */
	@Override
	public int selectInformDetailCnt(PtlInformVo ptlInformVo) throws IOException, SQLException , NullPointerException{
		return ptlInformDao.selectInformDetailCnt(ptlInformVo);
	}
	
	/**
	  * <pre>
	  * 
	  * 회원정보를 조회한다.
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 3. 22.
	  * @param ptlInformVo
	  * @return
	  * @throws IOException, SQLException , NullPointerException
	  */
	@Override
	public PtlInformVo selectInformDetail(PtlInformVo ptlInformVo) throws IOException, SQLException , NullPointerException{
		return ptlInformDao.selectInformDetail(ptlInformVo);
	}
	
	/**
	  * <pre>
	  * 
	  * 회원정보를 수정한다.
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 3. 22.
	  * @param ptlInformVo
	  * @param userVo
	  * @throws IOException, SQLException , NullPointerException
	  */
	@Override
	public void updateInformCn(PtlInformVo ptlInformVo) throws IOException, SQLException , NullPointerException{
		 ptlInformDao.updateInformCn(ptlInformVo);
	}
	
	

}
