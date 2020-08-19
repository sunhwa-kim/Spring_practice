package kr.go.cris.ptl.member.inform.service;

import java.io.IOException;
import java.sql.SQLException;

import kr.go.cris.ptl.member.inform.vo.PtlInformVo;


/**
 * <pre>
 * 회원정보 Service
 * 
 * </pre>
 * @FileName : PtlInformService.java
 * @package  : kr.go.cris.ptl.member.inform.service
 * @author   : wonki0138
 * @date     : 2018. 3. 2.
 * 
 */
public interface PtlInformService {


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
	public void insertInform(PtlInformVo ptlInformVo) throws IOException, SQLException , NullPointerException;
	
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
	public int selectInformDetailCnt(PtlInformVo ptlInformVo) throws IOException, SQLException , NullPointerException;
	
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
	public PtlInformVo selectInformDetail(PtlInformVo ptlInformVo) throws IOException, SQLException , NullPointerException;
	
	
	/**
	  * <pre>
	  * 
	  * 회원정보를 수정한다.
	  * </pre>
	  * @author : wonki0138
	  * @date   : 2018. 3. 22.
	  * @param ptlInformVo
	  * @throws IOException, SQLException , NullPointerException
	  */
	public void updateInformCn(PtlInformVo ptlInformVo) throws IOException, SQLException , NullPointerException;

}
