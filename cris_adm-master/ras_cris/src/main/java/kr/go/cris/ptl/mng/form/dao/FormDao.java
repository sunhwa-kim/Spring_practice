package kr.go.cris.ptl.mng.form.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.go.cris.ptl.mng.form.vo.FormVo;
import kr.go.cris.ptl.mng.form.vo.WFormVo;

import org.springframework.stereotype.Repository;

@Repository
public interface FormDao
{
	
	/**
	 * <pre>
	 *  리스트 조회
	 *
	 * </pre>
	 * @author : Administrator
	 * @date   : 2020. 1. 22.
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectFormList(Map<String, Object> params) throws SQLException;

	public void insertForm(Map<String, Object> param) throws SQLException;

	public void updateForm(Map<String, Object> param) throws SQLException;

	public void deleteEtlDtl(Map<String, Object> param) throws SQLException;

	public void insertWrkForm(Map<String, Object> param) throws SQLException;

	public void updateWrkForm(Map<String, Object> param) throws SQLException;

	public List<Map<String, Object>> selectWrkFormList(Map<String, Object> params) throws SQLException;

	public List<Map<String, Object>> selectWrkFormDtlList(Map<String, Object> params) throws SQLException;

	public WFormVo selectSubListBoardCnt(WFormVo wformVo) throws SQLException;
	
	public void insertFormBoard(Map<String, Object> param) throws SQLException;
	
	public void updatdBoardDetail(Map<String, Object> param) throws SQLException;

	public List<Map<String, Object>> selectSubListBdDtail(Map<String, Object> params) throws SQLException;
	
	public List<Map<String, Object>> selecTheadFormList(Map<String, Object> params) throws SQLException;
	
	public List<Map<String, Object>> selectSubListBoard(Map<String, Object> params) throws SQLException;
	
	public List<Map<String, Object>> selectUptListBoard(Map<String, Object> params) throws SQLException;
	
	public void insertSubWrkForm(Map<String, Object> param) throws SQLException;

	public void updateSubWrkForm(Map<String, Object> param) throws SQLException;
}