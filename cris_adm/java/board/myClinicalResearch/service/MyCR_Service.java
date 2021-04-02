package kr.go.cris.ptl.board.myClinicalResearch.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface MyCR_Service {

	public List<Map<String, Object>> selectMyRegistration_mng(Map<String, Object>param) throws SQLException;
	
	public List<Map<String, Object>> selectRegSubmission(Map<String, Object> param) throws SQLException, NullPointerException;
	
	public List<Map<String, Object>> selectRegRsInfo(Map<String, Object> param) throws SQLException, NullPointerException;

	public Map<String, Object> selectRsSystem(Map<String, Object> param) throws SQLException;

	public List<Map<String, Object>> selectStep(Map<String, Object> param) throws SQLException, NullPointerException;
	
	public List<Map<String, Object>> selectRoleGubun(Map<String, Object> param) throws SQLException, NullPointerException;

	public List<Map<String, Object>> selectRsrchInstitute(Map<String, Object> param) throws SQLException, NullPointerException;

	public List<Map<String, Object>> selectRsrchKind(Map<String, Object> param) throws SQLException, NullPointerException;

	public List<Map<String, Object>> selectIcd10List(Map<String, Object> param) throws SQLException, NullPointerException;

	public List<Map<String, Object>> selectOutcomeList(Map<String, Object> param) throws SQLException, NullPointerException;

	public List<Map<String, Object>> selectThesisList(Map<String, Object> param) throws SQLException, NullPointerException;
}
