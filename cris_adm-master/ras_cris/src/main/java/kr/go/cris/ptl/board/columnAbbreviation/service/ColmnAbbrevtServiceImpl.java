package kr.go.cris.ptl.board.columnAbbreviation.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.ptl.board.columnAbbreviation.dao.ColmnAbbrevtDao;

import org.springframework.stereotype.Service;


@Service
public class ColmnAbbrevtServiceImpl extends BaseServiceImpl  implements ColmnAbbrevtService{

	@Resource
	ColmnAbbrevtDao colAbbrvtDao;
	
	
	public List<Map<String, Object>> selectColAbbrvt() throws SQLException
    {
		List<Map<String, Object>> list = colAbbrvtDao.selectColAbbrvt();
		
	    return list;
    }
	
}
