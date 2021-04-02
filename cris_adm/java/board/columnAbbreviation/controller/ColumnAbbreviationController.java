package kr.go.cris.ptl.board.columnAbbreviation.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.cris.base.controller.BaseController;
import kr.go.cris.ptl.board.columnAbbreviation.service.ColmnAbbrevtService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ColumnAbbreviationController extends BaseController{

	@Resource
	ColmnAbbrevtService colAbbrvtSrvce;
	
	@RequestMapping("/board/columnAbbreviation/columnAbbreviation.do")
	public String agree(HttpServletRequest request, HttpServletResponse response, Model model)  throws IOException, SQLException , NullPointerException {
		
		
		return "board/columnAbbreviation.tiles";
	}
	
	public String strMethod(String inputStr, String vowel, int intLength){
		if(inputStr.length()<=intLength){
			inputStr = inputStr;
		}else{
			String tmpKey = inputStr;
			String newKey = "";
			for(int i=0 ; i<tmpKey.length() ; i++){
				char keyChar = tmpKey.charAt(i);
				for(int j=0; j< vowel.length(); j++){
					if(keyChar == vowel.charAt(j)){
						String tmp =Character.toString(keyChar);
						inputStr = inputStr.replaceAll(tmp, "");
					} 
				}
			}
		}
		return inputStr;
	}
	
	@RequestMapping(value="/board/columnAbbreviation/colAbbrevtView.do")
	@ResponseBody
	public Map<String, Object>colAbbrevtView(Model model, HttpServletRequest request)  throws IOException , SQLException , NullPointerException, NumberFormatException, java.text.ParseException {
		
		System.out.println("*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*");
		System.out.println(request.getParameter("pg"));
		
		List<Map<String, Object>> selectColumnList = colAbbrvtSrvce.selectColAbbrvt();
		Map<String, Object> sendMap = new HashMap<String, Object>();
		
		String[] colOrgnArr = new String[68];
		String[] colAbbrvtArr = new String[68];
		
//		모음 대문자인 경우만...
//		char[] vowelChar = {'A','E','I','O','U'};
//		System.out.println((int)vowelChar[0]);
		
		String vowel = "A,E,I,O,U";
//		a,e,i,o,u,y
//		이미 약어는 예외 : _IP , _YN , _EN ,_OLD, _UNIT (무조건 맨 뒤는 X)
//		본래 4글자는 놔두기 -> _별 자른 후에는 첫번째 3글자 이하는 그대로 && 맨 뒤 위 예외들은 그대로
//		varchar2 20글자당  40 == char도 동일
		int colSeq = 0;  // input Map
		for(Map<String, Object>mapKey : selectColumnList){
			for(String key : mapKey.keySet()){
				colOrgnArr[colSeq] = key;
				String[] seperationArr = key.split("_");
				int firstIdx = 0;
				int lastIdx = (seperationArr.length-1);
				
				String firstStr = seperationArr[firstIdx];
				String lastStr = seperationArr[lastIdx];
				
				int sortStr = seperationArr.length;
				
				if(sortStr==1){
							char tmpFirstStr = firstStr.charAt(0);
							String newfirstStr = strMethod(firstStr, vowel, 4); 
							for(int i=0; i<vowel.length() ; i++){
							if(newfirstStr.charAt(0)!=tmpFirstStr){  // ENROLLMENT경우 E가 남은게 좋은거 같아
							firstStr = tmpFirstStr + newfirstStr;
							break;
						}else{
							firstStr = strMethod(firstStr, vowel, 4);   // 4에대한 명확한 기준 있으면 더 좋음...
						}
					}
					colAbbrvtArr[colSeq] = firstStr;
					
				} else if (sortStr==2) {
					String resultTwo = "";
					
					firstStr = strMethod(firstStr, vowel,3);
					lastStr = strMethod(lastStr, vowel,3);
					resultTwo = firstStr +"_"+ lastStr;
					
					colAbbrvtArr[colSeq] = resultTwo;
				} else {
					firstStr = strMethod(firstStr, vowel,3);
					lastStr = strMethod(lastStr, vowel,3);
					
//					resultStr = first + mid1 + last
//					resultStr = first + mid1 + mid2 + last
//					resultStr = first + mid1 + mid2  + mid3 + last
						
						int midStart = firstIdx +1;//1
						
						String midStr = "";
						for(int i=midStart ; i<lastIdx ; i++){
							String tmpMid = seperationArr[i];
								midStr += strMethod(tmpMid, vowel, 3)+"_";
						}
								
						String midTotal = midStr;
						firstStr = strMethod(firstStr, vowel,3);
						lastStr = strMethod(lastStr, vowel,3);
						
						String result = firstStr+"_"+midTotal+lastStr;
						colAbbrvtArr[colSeq] = result;
				}
				colSeq++;
			}
			sendMap.put("idx", colSeq);
			sendMap.put("colAbbrvt", colAbbrvtArr);
			sendMap.put("colOrgnArr", colOrgnArr);
		}
//		sendList.add(sendMap);
//		System.out.println(colSeq); //68 =>if list size = (colSeq -1)
		
// for ( String col : colAbbrvtArr){
//	 System.out.println(col);
// }
// for(int i=0 ; i<colAbbrvtArr.length;i++){
//	 System.out.println(colOrgnArr[i]);
//	 System.out.println(colAbbrvtArr[i]);
// }
//	XmlUtil.mapToXml(map)  //xml로 map 보낼때
		return sendMap;
//		return sendList;
	}
	
}
