package kr.go.cris.ptl.mng.form.service;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.ptl.mng.form.dao.FormDao;
import kr.go.cris.ptl.mng.form.vo.FormVo;
import kr.go.cris.ptl.mng.form.vo.WFormVo;
import kr.go.cris.ptl.mng.sch.vo.EtlMngVo;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

@Service
public class FormServiceImpl extends BaseServiceImpl  implements FormService 
{

	@Resource
	FormDao formDao;
	
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
	public List<Map<String, Object>> selectFormList(Map<String, Object> params) throws SQLException
    {
		List<Map<String, Object>> list = formDao.selectFormList(params);
		
	    return list;
    }

	
	@Override
	public void saveFormList(List<FormVo> params) throws SQLException {
		FormVo formVo = null;
		Map<String, Object> param;

	
		for(int rowStatus = 0; rowStatus < params.size(); rowStatus++)
        {
			formVo = null;
			formVo = (FormVo) params.get(rowStatus);
			//TODO				
			if(!StringUtils.equals("D", formVo.getSave_type())){
			
				param = new HashMap<>();

				param.put("elmnt_id", formVo.getElmnt_id());
				param.put("elmnt_nm", formVo.getElmnt_nm());
				param.put("data_type", formVo.getData_type());
				param.put("cd", formVo.getCd());
				param.put("lbl_kor", formVo.getLbl_kor());
				param.put("lbl_eng", formVo.getLbl_eng());
				//TODO               
	            if(StringUtils.equals("I", formVo.getSave_type())){    
	            	formDao.insertForm(param);
				    
	            }else{
	            	formDao.updateForm(param);
	            }
	
			}else{
				//삭제 순번 존재시
				if(StringUtils.isNotBlank(formVo.getElmnt_id())){
         
					param = new HashMap<>();
					param.put("elmnt_id", formVo.getElmnt_id());
					formDao.deleteEtlDtl(param);
					
				}
				
			}
        }
	}


	@Override
	public void saveWrkFormList(List<WFormVo> params) throws SQLException {
		WFormVo formVo = null;
		Map<String, Object> param;

	
		for(int rowStatus = 0; rowStatus < params.size(); rowStatus++)
        {
			formVo = null;
			formVo = (WFormVo) params.get(rowStatus);
			//TODO				
			if(!StringUtils.equals("D", formVo.getSave_type())){
			
				param = new HashMap<>();

				param.put("frm_id", formVo.getFrm_id());
				param.put("frm_gbn", formVo.getFrm_gbn());
				param.put("frm_etc", formVo.getFrm_etc());
				param.put("use_yn", formVo.getUse_yn());
				
				//TODO               
	            if(StringUtils.equals("I", formVo.getSave_type())){    
	            	formDao.insertWrkForm(param);
				    
	            }else{
	            	formDao.updateWrkForm(param);
	            }
	
			}else{
				//삭제 순번 존재시
				if(StringUtils.isNotBlank(formVo.getFrm_id())){
         
					param = new HashMap<>();
					param.put("elmnt_id", formVo.getFrm_id());
					formDao.deleteEtlDtl(param);
					
				}
				
			}
        }
	}

	public WFormVo selectSubListBoardCnt(WFormVo wformVo) throws IOException , SQLException , NullPointerException
    {
	    return formDao.selectSubListBoardCnt(wformVo);
    }

	@Override
	public void insertFormBoard(Map<String, Object> params) throws SQLException {
	            	formDao.insertFormBoard(params);
	}
	
	@Override
	public void updatdBoardDetail(Map<String, Object> params) throws SQLException {
	            	formDao.updatdBoardDetail(params);
	}
	
	public List<Map<String, Object>> selectSubListBdDtail(Map<String, Object> params) throws SQLException
    {
		List<Map<String, Object>> list = formDao.selectSubListBdDtail(params);
		
	    return list;
    }
	
	public List<Map<String, Object>> selecTheadFormList(Map<String, Object> params) throws SQLException
    {
		List<Map<String, Object>> list = formDao.selecTheadFormList(params);
		
	    return list;
    }
	
	public List<Map<String, Object>> selectSubListBoard(Map<String, Object> params) throws SQLException
    {
		List<Map<String, Object>> list = formDao.selectSubListBoard(params);
		
	    return list;
    }
	
	public List<Map<String, Object>> selectUptListBoard(Map<String, Object> params) throws SQLException
    {
		List<Map<String, Object>> list = formDao.selectUptListBoard(params);
		
	    return list;
    }
	
	
	@Override
	public void saveSubWrkForm(List<WFormVo> params) throws SQLException {
		WFormVo formVo = null;
		Map<String, Object> param;

	
		for(int rowStatus = 0; rowStatus < params.size(); rowStatus++)
        {
			formVo = null;
			formVo = (WFormVo) params.get(rowStatus);
			//TODO				
			if(!StringUtils.equals("D", formVo.getSave_type())){
			
				param = new HashMap<>();

				param.put("frm_id", formVo.getFrm_id());
				param.put("frm_elmnt_id", formVo.getFrm_elmnt_id());
				param.put("frm_ord", formVo.getFrm_ord());
				param.put("frm_col", formVo.getFrm_col());
				param.put("use_yn", formVo.getUse_yn());
				param.put("lst_yn", formVo.getLst_yn());
				param.put("srch_yn", formVo.getSrch_yn());
				
				//TODO               
	            if(StringUtils.equals("I", formVo.getSave_type())){    
	            	formDao.insertSubWrkForm(param);
				    
	            }else{
	            	formDao.updateSubWrkForm(param);
	            }
	
			}else{
				//삭제 순번 존재시
				if(StringUtils.isNotBlank(formVo.getFrm_id())){
         
					param = new HashMap<>();
					param.put("elmnt_id", formVo.getFrm_id());
					formDao.deleteEtlDtl(param);
					
				}
				
			}
        }
	}
	
	
	@Override
	public List<Map<String, Object>> selectWrkFormList(Map<String, Object> params) throws SQLException {
		List<Map<String, Object>> list = formDao.selectWrkFormList(params);
	    return list;
	}


	@Override
	public List<Map<String, Object>> selectWrkFormDtlList(Map<String, Object> params) throws SQLException {
		List<Map<String, Object>> list = formDao.selectWrkFormDtlList(params);
	    return list;
	}

}
