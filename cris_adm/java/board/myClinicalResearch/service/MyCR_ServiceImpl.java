package kr.go.cris.ptl.board.myClinicalResearch.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.ptl.board.myClinicalResearch.dao.MyCRDao;

import org.springframework.stereotype.Service;

@Service
public class MyCR_ServiceImpl extends BaseServiceImpl implements MyCR_Service {
	
	@Resource
	MyCRDao myCR_dao;	
	
	public List<Map<String, Object>> selectMyRegistration_mng(Map<String, Object> param) throws SQLException
    {
		List<Map<String, Object>> list = myCR_dao.selectMyRegistration_mng(param);
		
	    return list;
    }
	
	public List<Map<String, Object>> selectRegSubmission(Map<String, Object> param) throws SQLException
	{
		List<Map<String, Object>> list = myCR_dao.selectRegSubmission(param);
		
		return list;
	}
	
	public List<Map<String, Object>> selectRegRsInfo(Map<String, Object> param) throws SQLException
	{
		List<Map<String, Object>> list = myCR_dao.selectRegRsInfo(param);
		
		return list;
	}
	
	
	public Map<String, Object> selectRsSystem(Map<String, Object> param) throws SQLException
	{
		Map<String, Object> map = myCR_dao.selectRsSystem(param);
		
		return map;
	}
	
	public List<Map<String, Object>> selectStep(Map<String, Object> param) throws SQLException
	{
		List<Map<String, Object>> list = myCR_dao.selectStep(param);
		
		return list;
	}
	
	public List<Map<String, Object>> selectRoleGubun(Map<String, Object> param) throws SQLException
	{
		List<Map<String, Object>> list = myCR_dao.selectRoleGubun(param);
		
		return list;
	}
	
	public List<Map<String, Object>> selectRsrchInstitute(Map<String, Object> param) throws SQLException
	{
		List<Map<String, Object>> list = myCR_dao.selectRsrchInstitute(param);
		
		return list;
	}
	
	public List<Map<String, Object>> selectRsrchKind(Map<String, Object> param) throws SQLException
	{
		List<Map<String, Object>> list = myCR_dao.selectRsrchKind(param);
		
		return list;
	}
	
	public List<Map<String, Object>> selectIcd10List(Map<String, Object> param) throws SQLException
	{
		List<Map<String, Object>> list = myCR_dao.selectIcd10List(param);
		
		return list;
	}
	
	public List<Map<String, Object>> selectOutcomeList(Map<String, Object> param) throws SQLException
	{
		List<Map<String, Object>> list = myCR_dao.selectOutcomeList(param);
		
		return list;
	}

	public List<Map<String, Object>> selectThesisList(Map<String, Object> param) throws SQLException
	{
		List<Map<String, Object>> list = myCR_dao.selectThesisList(param);
		
		return list;
	}
	
}
