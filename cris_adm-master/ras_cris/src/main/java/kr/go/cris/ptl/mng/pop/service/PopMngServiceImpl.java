package kr.go.cris.ptl.mng.pop.service;


import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.ptl.mng.pop.dao.PopMngDao;
import kr.go.cris.ptl.mng.pop.vo.PopMngVo;

import org.springframework.stereotype.Service;



/**
 * <pre>
 * FileName: PopMngServiceImpl.java
 * Package :  kr.go.rastech.ptl.mng.pop.service
 * 
 * 
 *
 * </pre>
 * @author : lwk
 * @date   : 2019. 12. 11.
 */
@Service
public class PopMngServiceImpl extends BaseServiceImpl implements PopMngService {

	@Resource
	private PopMngDao popDao;
	private HashMap<String, Object> hashMap = new HashMap<String, Object>();
	
	/**
	 * <pre>
	 * 게시물 전체 count
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param popMngVo
	 * @return
	 * @throws Exception
	 */
	@Override
	public int selectPopTotalCount(PopMngVo popMngVo) throws Exception {
		
		return popDao.selectPopTotalCount(popMngVo);
	}

	/**
	 * <pre>
	 * 게시물 전체 조회
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2016. 3. 28.
	 * @param popMngVo
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<PopMngVo> selectPopList(PopMngVo popMngVo) throws Exception {


		return popDao.selectPopList(popMngVo);
	}

	/**
	 * <pre>
	 * 게시물 수정
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param pop_sn
	 * @throws Exception
	 */
	@Override
	public Boolean updatePop(PopMngVo popMngVo) throws Exception {
		 	return popDao.updatePop(popMngVo);
		
		
		
	}
	/**
	 * <pre>
	 * 게시물 등록
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param pop_sn
	 * @throws Exception
	 */
	@Override
	public Boolean insertPop(PopMngVo popMngVo) throws Exception {
	
		return popDao.insertPop(popMngVo);
	}
	
	/**
	 * <pre>
	 * 게시물 순번
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param pop_sn
	 * @throws Exception
	 */
	@Override
	public int selectPopSn() throws Exception {
	
		return popDao.selectPopSn();
	}

	
	
	/**
	 * <pre>
	 * 파일 순번
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @return
	 * @throws Exception
	 */
	@Override
	public int selectPopFileSn(int pop_sn) throws Exception {
		// TODO Auto-generated method stub
		return popDao.selectPopFileSn(pop_sn);
	}

	/**
	 * <pre>
	 * 파일 저장
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param popMngVo
	 * @return
	 * @throws Exception
	 */
	@Override
	public Boolean insertPopFile(PopMngVo popMngVo) throws Exception {
		// TODO Auto-generated method stub
		return popDao.insertPopFile(popMngVo);
	}


	/**
	 * <pre>
	 * 첨부파일 다운로드
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param down_pop_sn
	 * @param down_file_sn
	 * @return
	 * @throws Exception
	 */
	@Override
	public PopMngVo retrieveFile(int pop_sn, int pop_file_sn) throws Exception {
		
		hashMap.put("pop_sn", pop_sn);
		hashMap.put("file_sn", pop_file_sn);
		return popDao.retrieveFile(hashMap);
		
	}

	/**
	 * <pre>
	 * 첨부파일 삭제
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param popMngVo
	 * @return
	 * @throws Exception
	 */
	@Override
	public Boolean deletePopFile(PopMngVo popMngVo) throws Exception {
		
		
		return popDao.deletePopFile(popMngVo);
	}
	
	/**
	 * <pre>
	 * 팝업관리 삭제
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param popMngVo
	 * @return
	 * @throws Exception
	 */
	@Override
	public Boolean deletePop(PopMngVo popMngVo) throws Exception {
		
		
		return popDao.deletePop(popMngVo);
	}

	/**
	 * <pre>
	 * 메인팝업존 게시물 조회
	 *
	 * </pre>
	 * @author : lwk
	 * @date   : 2019. 12. 11.
	 * @param popMngVo
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<PopMngVo> selectMainPopList(PopMngVo popMngVo) throws Exception {
		
		return popDao.selectMainPopList(popMngVo);
	}
}
