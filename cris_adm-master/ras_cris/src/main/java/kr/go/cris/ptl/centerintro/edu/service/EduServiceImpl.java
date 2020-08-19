package kr.go.cris.ptl.centerintro.edu.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.ptl.centerintro.edu.dao.EduDao;
import kr.go.cris.ptl.centerintro.edu.vo.EduVo;

import org.springframework.stereotype.Service;

/**
 * <pre>
 * 교육관리 ServiceImpl 로직 구현
 * 
 * </pre>
 * @FileName : EduServiceImpl.java
 * @package  : kr.go.cris.ptl.centerintro.edu.service
 * @author   : wonki0138
 * @date     : 2018. 6. 28.
 * 
 */
@Service
public class EduServiceImpl extends BaseServiceImpl implements EduService {

    @Resource
    private EduDao eduDao;

    
    
    /**
	 * <pre>
	 * 교육 목록 리스트를 반환한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 6. 28. 
	 * @param eduVo
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 */
	@Override
	public List<EduVo> selectEduList(EduVo eduVo) throws IOException , SQLException , NullPointerException {
				
		return eduDao.selectEduList(eduVo);
				
	}

	
	 /**
	 * <pre>
	 *  교육 총 게시물 수를 반환한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 6. 28. 
	 * @param eduVo
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 */
	@Override
	public int selectEduTotalCount(EduVo eduVo) throws IOException , SQLException , NullPointerException {
		
		return eduDao.selectEduTotalCount(eduVo);
	}

	/**
	 * <pre>
	 * 교육 상세 정보를 반환한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 6. 28. 
	 * @param eduVo
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 */
	@Override
	public EduVo selectEduView(EduVo eduVo) throws IOException , SQLException , NullPointerException{
		
		return eduDao.selectEduView(eduVo);
	}

	/**
	 * <pre>
	 * 교육 정보를 게시물 조회수를 update 한다.
	 *
	 * </pre>
	 * @author : wonki0138
	 * @date   : 2018. 6. 28. 
	 * @param eduVo
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 */
	@Override
	public int updateEduRdcnt(EduVo eduVo) throws IOException , SQLException , NullPointerException{
		
		return eduDao.updateEduRdcnt(eduVo);
		
	}

   


}
