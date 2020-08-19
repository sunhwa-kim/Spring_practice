package kr.go.cris.sms.service;

import java.io.IOException;
import java.sql.SQLException;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;


import kr.go.cris.sms.dao.MsgDataDao;
import kr.go.cris.sms.vo.MsgDataVO;

import org.springframework.stereotype.Service;

/**
 * <pre>
 * SMS  ServiceImpl
 * 
 * </pre>
 * @FileName : MsgDataServiceImpl.java
 * @package  : kr.go.cris.ptl.sms.service
 * @author   : wonki0138
 * @date     : 2018. 3. 12.
 * 
 */
@Service
public class MsgDataServiceImpl extends BaseServiceImpl implements MsgDataService {
	
	@Resource(name="msgDataDao")
	private MsgDataDao msgDataDao;
	
	
	/**
	 * <pre>
	 * SMS 데이터를 입력한다.
	 *
	 * </pre>
	 * @author : user
	 * @date   : 2018. 7. 4. 
	 * @param msgDataVO
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	@Override
	public void insertMsgData(MsgDataVO msgDataVO) throws IOException, SQLException , NullPointerException {
		
		msgDataDao.insertMsgData(msgDataVO);
	}

}
