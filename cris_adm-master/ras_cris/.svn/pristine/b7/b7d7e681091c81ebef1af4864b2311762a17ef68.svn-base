package kr.go.cris.ptl.scheduler.service;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.go.cris.base.service.BaseServiceImpl;
import kr.go.cris.ptl.mng.sch.service.SchService;
import kr.go.cris.ptl.scheduler.dao.SchedulerDao;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

/**
 * <pre>
 * 
 * 스케쥴러 ServiceImpl 구현
 * </pre>
 * @FileName : SchedulerService.java
 * @package  : kr.go.cris.commons.scheduler.service;
 * @author   : wonki0138
 * @date     : 2018. 3. 16.
 * 
 */
@Service
public class SchedulerServiceImpl extends BaseServiceImpl implements SchedulerService {

	@Resource
	private SchedulerDao schedulerDao;
	
	@Resource
	private SchService schService;
	
	@Override
	public void procEtl() throws SQLException {
		
		List<Map<String, Object>> list  = schService.selectProcEtl();
		
		try
		{
		for (Map<String, Object> scMap : list) {
    		
    		scMap.put("TASK", scMap.get("ETL_ID").toString());
    		scMap.put("PROC_TYPE", "a");
    		
    		schService.updNextDt(scMap);
    		
    		switch(scMap.get("ETL_GBN").toString())
    		{
    			case "1"://ETL
    				//자동 호출인경우 이력만 쌓음
    				//schService.getEtlHis(scMap);
    				//this.procBatch(scMap);		
    				break;
    			case "2"://년간교통량
    				break;
    			case "3"://년간강설량
    				break;
    			case "4"://년간강우량
    				break;
    			case "5"://월간교통량
    				break;
    			case "6"://월간기상정보
    				break;
    			case "7"://년간제설재
    				break;
    			case "8"://월간제설재
    				//sectSnowAmnt.insetMonSrmAmnt(scMap);
    				break;
    			default:
    				break;
    		}	
    		
    	}  
		}catch(SQLException e)
		{
			logger.info("Error: " + "SchedulerPro 오류발생! ");
		}
		
	}
    
}
