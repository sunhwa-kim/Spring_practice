package kr.go.cris.ptl.mng.form.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.go.cris.ptl.mng.form.vo.FormVo;
import kr.go.cris.ptl.mng.form.vo.WFormVo;

public interface FormService
{

	/**
	 * <pre>
	 * 
	 *
	 * </pre>
	 * @author : Administrator
	 * @date   : 2017. 7. 13.
	 * @param params
	 * @return
	 * @throws SQLException 
	 */
	public List<Map<String, Object>> selectFormList(Map<String, Object> params) throws SQLException;

	
	/**
	 * @param list
	 */
	public void saveFormList(List<FormVo> list) throws SQLException;

	public WFormVo selectSubListBoardCnt(WFormVo wformVo) throws IOException , SQLException , NullPointerException;

	public void insertFormBoard(Map<String, Object> params) throws SQLException;

	public void updatdBoardDetail(Map<String, Object> params) throws SQLException;
	
	public List<Map<String, Object>> selectSubListBdDtail(Map<String, Object> params) throws SQLException;

	public List<Map<String, Object>> selecTheadFormList(Map<String, Object> params) throws SQLException;
	
	public List<Map<String, Object>> selectSubListBoard(Map<String, Object> params) throws SQLException;
	
	public List<Map<String, Object>> selectUptListBoard(Map<String, Object> params) throws SQLException;
	

	
	/**
	 * @param list
	 * @throws SQLException
	 */
	public void saveWrkFormList(List<WFormVo> list) throws SQLException;

	
	public void saveSubWrkForm(List<WFormVo> list) throws SQLException;

	
	/**
	 * @param params
	 * @return
	 * @throws SQLException
	 */
	public List<Map<String, Object>> selectWrkFormList(Map<String, Object> params) throws SQLException;

	/**
	 * @param params
	 * @return
	 * @throws SQLException
	 */
	public List<Map<String, Object>> selectWrkFormDtlList(Map<String, Object> params)throws SQLException;

}
