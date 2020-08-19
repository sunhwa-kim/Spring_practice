package kr.go.cris.commons.utils;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.beanutils.PropertyUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kr.go.cris.base.vo.*;
import kr.go.cris.commons.constants.Constants;

public class JsonUtil {

	public static String listToJsonString(List<? extends BaseVo> objectList, String[] set,int total){
		
        JSONObject jsonObject = new JSONObject();
         
        if(set.length==0) return "";
         
        JSONArray jsonArray = new JSONArray();
        List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();
         
        for (Object object : objectList) {
            Map<String, Object> map = new HashMap<String, Object>();
             
            try {
                for(int i=0; i<set.length; i++){ map.put(set[i], PropertyUtils.getProperty(object, set[i]) == null ? "" : PropertyUtils.getProperty(object, set[i]));}
           
            } catch (IllegalAccessException e) {
            	return "";
			} catch (InvocationTargetException e) {
				return "";
			} catch (NoSuchMethodException e) {
				return "";
			}
            listMap.add(map);
        }   
         
        for (Map<String, Object> jsonItem : listMap) {
            jsonArray.add(jsonItem);
        }
        
        jsonObject.put("page","");
        jsonObject.put("total",Math.ceil((double)total / (double)Constants.RECORDS));
        jsonObject.put("records",Constants.RECORDS);
        jsonObject.put("items", jsonArray);
         
        return jsonObject.toString();
    }
	
	public static Object mapToJson(List<Map<String, Object>> list,int total){
		
		JSONObject jsonObj = new JSONObject();
		JSONObject jsonSubObj = null;
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String,Object> m : list) {
			Set<String> key = m.keySet();
			jsonSubObj = new JSONObject();
			for (Iterator<String> iterator = key.iterator(); iterator.hasNext();) {
	            String k = (String) iterator.next();
	            String value = (String) m.get(k);
	            jsonSubObj.put(k, value);
			}
			jsonArr.add(jsonSubObj);
		}
		jsonObj.put("page","");
		jsonObj.put("total",Math.ceil((double)total / (double)Constants.RECORDS));
		jsonObj.put("records",Constants.RECORDS);
		jsonObj.put("items",jsonArr);
		
		return jsonObj;
	}
	
	
	@SuppressWarnings("unchecked")
	public static String listMapToJsonString(List<Map<String, Object>> list2, String[] set){
		
		if(set.length==0) return "";
		
		JSONArray jsonArray = new JSONArray();
		List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();
		
		for (Map<String, Object> object : list2) {
			Map<String, Object> map = new HashMap<String, Object>();
			
				for(int i=0; i<set.length; i++) {
					map.put(set[i], object.get(set[i]));
				}
				
			listMap.add(map);
		}   
		
		for (Map<String, Object> jsonItem : listMap) {
			jsonArray.add(jsonItem);
		}
		return jsonArray.toString();
	}	
}
