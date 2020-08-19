package kr.go.cris.ptl.mng.sys.service;


import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.ptl.mng.sys.dao.SysMntrDao;
import kr.go.cris.ptl.mng.sys.vo.SysMntrVo;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;




/**
 * <pre>
 * FileName: sysServiceImpl.java
 * Package : kr.go.cris.ptl.mng.sys.service
 * 
 * 시스템관리 서비스 구현
 *
 * </pre>
 * @author : sejin
 * @date   : 2016. 3. 22.
 */
@Service
public class SysMntrServiceImpl extends BaseServiceImpl implements SysMntrService {

	@Resource
	SysMntrDao sysMntrDao;
	
	/* (비Javadoc)
	 * @see kr.go.cris.ptl.mng.sys.service.SysService#insertSysMntr(kr.go.cris.ptl.mng.sys.vo.SysVo)
	 */
	@Override
	public void insertSysMntr(SysMntrVo sysVo) throws IOException, SQLException , NullPointerException {
		sysMntrDao.insertSysMntr(sysVo);
	}

	/* (비Javadoc)
	 * @see kr.go.cris.ptl.mng.sys.service.SysService#selectSysMntrList(kr.go.cris.ptl.mng.sys.vo.SysVo)
	 */
	@Override
	public List<SysMntrVo> selectSysMntrList(SysMntrVo sysVo) throws IOException, SQLException , NullPointerException {
		return sysMntrDao.selectSysMntrList(sysVo);
	}

	/* (비Javadoc)
	 * @see kr.go.cris.ptl.mng.sys.service.SysMntrService#updateSysMntr(kr.go.cris.ptl.mng.sys.vo.SysMntrVo)
	 */
	@Override
	public void updateSysMntr(SysMntrVo sysMntrVo) throws IOException, SQLException , NullPointerException {
		sysMntrDao.updateSysMntr(sysMntrVo);
	}

	/* (비Javadoc)
	 * @see kr.go.cris.ptl.mng.sys.service.SysMntrService#selectTabList(java.util.Map)
	 */
	@Override
	public List<Map<String, String>> selectTabList(Map<String, String> map) throws IOException, SQLException , NullPointerException {
		return sysMntrDao.selectTabList(map);
	}

	/* (비Javadoc)
	 * @see kr.go.cris.ptl.mng.sys.service.SysMntrService#selectColList(java.util.Map)
	 */
	@Override
	public List<Map<String,String>> selectColList(Map<String, String> map) throws IOException, SQLException , NullPointerException {
		return sysMntrDao.selectColList(map);
	}

	/* (비Javadoc)
	 * @see kr.go.cris.ptl.mng.sys.service.SysMntrService#deleteTabInfo(java.util.Map)
	 */
	@Override
	public void deleteColInfo(Map<String, String> map) throws IOException, SQLException , NullPointerException {
		sysMntrDao.deleteColInfo(map);
	}

	/* (비Javadoc)
	 * @see kr.go.cris.ptl.mng.sys.service.SysMntrService#insertTabInfo(java.util.Map)
	 */
	@Override
	public void insertTabInfo(Map<String, String> map) throws IOException, SQLException , NullPointerException {
		sysMntrDao.insertTabInfo(map);
	}

	/* (비Javadoc)
	 * @see kr.go.cris.ptl.mng.sys.service.SysMntrService#selectColInfo(java.util.Map)
	 */
	@Override
	public List<Map<String, String>> selectColInfo(Map<String, String> map) throws IOException, SQLException , NullPointerException {
		return sysMntrDao.selectColInfo(map);
	}

	/* (비Javadoc)
	 * @see kr.go.cris.ptl.mng.sys.service.SysMntrService#insertColInfo(java.util.Map)
	 */
	/* (비Javadoc)
	 * @see kr.go.cris.ptl.mng.sys.service.SysMntrService#insertColInfo(java.util.Map)
	 */
	@Override
	public void insertColInfo(Map<String, String> map) throws IOException, SQLException , NullPointerException {
		sysMntrDao.insertColInfo(map);
	}

	/* (비Javadoc)
	 * @see kr.go.cris.ptl.mng.sys.service.SysMntrService#selectKeyWord(java.util.Map)
	 */
	@Override
	public List<Map<String, String>> selectKeyWord(Map<String, String> map) throws IOException, SQLException , NullPointerException {
		return sysMntrDao.selectKeyWord(map);
	}

	/* (비Javadoc)
	 * @see kr.go.cris.ptl.mng.sys.service.SysMntrService#insertKeyWord(java.util.Map)
	 */
	@Override
	public void insertKeyWord(Map<String, String> saveMap) throws IOException, SQLException , NullPointerException {
		sysMntrDao.insertKeyWord(saveMap);
	}

	/* (비Javadoc)
	 * @see kr.go.cris.ptl.mng.sys.service.SysMntrService#insertKeyWordTab(java.util.Map)
	 */
	@Override
	public void insertKeyWordTab(Map<String, String> saveMap) throws IOException, SQLException , NullPointerException {
		sysMntrDao.insertKeyWordTab(saveMap);
	}

	/* (비Javadoc)
	 * @see kr.go.cris.ptl.mng.sys.service.SysMntrService#selectKeywordSeq()
	 */
	@Override
	public int selectKeywordSeq() throws IOException, SQLException , NullPointerException {
		return sysMntrDao.selectKeywordSeq();
	}



	/* (비Javadoc)
	 * @see kr.go.cris.ptl.mng.sys.service.SysMntrService#insertKeyWordMng(java.util.Map)
	 */
	@Override
	public void insertKeyWordMng(Map<String, String> mngMap) throws IOException, SQLException , NullPointerException {
		sysMntrDao.insertKeyWordMng(mngMap);
	}
	
	/* (비Javadoc)
	 * @see kr.go.cris.ptl.mng.sys.service.SysMntrService#selectKeyWordTab(java.util.Map)
	 */
	@Override
	public List<Map<String, String>> selectKeyWordTab(Map<String, String> map) throws IOException, SQLException , NullPointerException {
		return sysMntrDao.selectKeyWordTab(map);
	}

	/* (비Javadoc)
	 * @see kr.go.cris.ptl.mng.sys.service.SysMntrService#updateKeyWordMng(java.util.Map)
	 */
	@Override
	public void updateKeyWordMng(Map<String, String> map) throws IOException, SQLException , NullPointerException {
		sysMntrDao.updateKeyWordMng(map);
	}
	
	@Override
	public List<Map<String, String>> selectExistTabList(Map<String, String> map) throws IOException, SQLException , NullPointerException {
		return sysMntrDao.selectExistTabList(map);
	}
	
	

	@Override
	public List<SysMntrVo> selectListSch(SysMntrVo sysVo) throws IOException, SQLException , NullPointerException {
		return sysMntrDao.selectListSch(sysVo);
	}

	@Override
	public void saveSch(SysMntrVo sysMntrVo) throws IOException, SQLException , NullPointerException {
		 sysMntrDao.saveSch(sysMntrVo);
	}

	
}
