package kr.go.cris;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;


public class ReadXmlPaser {

    
    public static void createFile() throws IOException{
    	//파일 객체 생성
        File file = new File("C:\\Users\\User\\Desktop\\upd\\sendXml_upd.xml");
        //입력 스트림 생성
        FileReader filereader = new FileReader(file);
        //입력 버퍼 생성
        BufferedReader bufReader = new BufferedReader(filereader);
        String line = "";
        String result = "";
        
        //path = path.replace(".xml", "Result.xml");
        
        File newfile = new File("C:\\Users\\User\\Desktop\\upd\\Result_"+file.getName()) ;
        
        // true 지정시 파일의 기존 내용에 이어서 작성
        FileWriter fw = new FileWriter(newfile, true) ;
        boolean isphase = false;
        while((line = bufReader.readLine()) != null){
        	if(line.indexOf("<results_date_completed>") != -1){
        		line = line.replaceAll("(<results_date_completed>[0-9]{4}-[0-9]{2}-[0-9]{2})", "");
        		line = line.replaceAll("</results_date_completed>", "<results_date_completed/>");
        		result = line +"\n";
        	}else{
            	if(line.indexOf("<study_type>") != -1){
            		if(line.toUpperCase().indexOf("OBSERVATIONAL STUDY") != -1){
            			isphase = true;
            		}else{
            			isphase = false;
            		}
            	}
            	if(line.indexOf("<phase>") != -1){
            		if(isphase == true){
            			line = "			<phase>NA</phase>";
            		}
            	}
        		result = line +"\n";
        	}
        	

        	
        	fw.write(result);
            fw.flush();
        }

        fw.close();
        bufReader.close();
    }
    
    public static void createFile2() throws IOException{
    	//파일 객체 생성
        File file = new File("C:\\Users\\Administrator\\Desktop\\ttt\\Result_sendXml(3526).xml");
        //입력 스트림 생성
        FileReader filereader = new FileReader(file);
        //입력 버퍼 생성
        BufferedReader bufReader = new BufferedReader(filereader);
        String line = "";
        String result = "";
        
        File newfile = new File("C:\\Users\\Administrator\\Desktop\\ttt\\11_"+file.getName()+".xml") ;
        
        // true 지정시 파일의 기존 내용에 이어서 작성
        FileWriter fw = new FileWriter(newfile, true) ;
        boolean isphase = false;
        boolean istrial = false;
        
        String str = "";
        
        int cnt = 0 ;
        
        

        
        result += "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+"\n\n";
        result += "<trials>";
        
        while((line = bufReader.readLine()) != null ){
        	
        	if(line.indexOf("<trial>") != -1){
        		str = "";
        		istrial = true;
        	}
	
        	if(istrial == true){
        		if(line.indexOf("<study_type>") != -1){
            		if(line.toUpperCase().indexOf("OBSERVATIONAL STUDY") != -1){
            			isphase = true;
            		}
            	}
        		str += line +"\n";
        	}
        	if(line.indexOf("</trial>") != -1){
        		istrial = false;
        		if(isphase == true){
            		result += str;
            		cnt ++;
        		}
        		isphase = false;
        	}
        	
        }
        result += "</trials>";
        fw.write(result);
        fw.flush();
        
        System.out.println(" cnt : " + cnt);

        //fw.close();
        bufReader.close();
    }
    
    static ArrayList<String> list = new ArrayList<String>();
    
    static{
    	list.add("KCT0003805");
    	list.add("KCT0003709");
    	list.add("KCT0002732");
    	list.add("KCT0003068");
    	list.add("KCT0004323");
    	list.add("KCT0003626");
    	list.add("KCT0004623");
    	list.add("KCT0004034");
    	list.add("KCT0003783");
    	list.add("KCT0004017");
    	list.add("KCT0003283");
    	list.add("KCT0003145");
    	list.add("KCT0003446");
    	list.add("KCT0002681");
    	list.add("KCT0004246");
    	list.add("KCT0003665");
    	list.add("KCT0002461");
    	list.add("KCT0002373");
    	list.add("KCT0002825");
    	list.add("KCT0003699");
    	list.add("KCT0004067");
    	list.add("KCT0003673");
    	list.add("KCT0004324");
    	list.add("KCT0003561");
    	list.add("KCT0002148");
    	list.add("KCT0004622");
    	list.add("KCT0003057");
    	list.add("KCT0002892");
    	list.add("KCT0003976");
    	list.add("KCT0003770");
    	list.add("KCT0004045");
    	list.add("KCT0004272");
    	list.add("KCT0004599");
    	list.add("KCT0004619");
    	list.add("KCT0004567");
    	list.add("KCT0004620");
    	list.add("KCT0004618");
    	list.add("KCT0004614");
    	list.add("KCT0004617");
    	list.add("KCT0004612");
    	list.add("KCT0004582");
    	list.add("KCT0004621");
    	list.add("KCT0004611");
    	list.add("KCT0004615");
    	list.add("KCT0004610");
    	list.add("KCT0004609");
    	list.add("KCT0004607");
    	list.add("KCT0004602");
    	list.add("KCT0004601");
    	list.add("KCT0004604");
    	list.add("KCT0004597");
    	list.add("KCT0004603");
    	list.add("KCT0004616");
    	list.add("KCT0004577");
    	list.add("KCT0004593");
    	list.add("KCT0004594");
    	list.add("KCT0004606");
    	list.add("KCT0004613");
    	list.add("KCT0004587");
    	list.add("KCT0004589");
    	list.add("KCT0004592");
    	list.add("KCT0004595");
    	list.add("KCT0004590");
    	list.add("KCT0004600");
    	list.add("KCT0004588");
    	list.add("KCT0004586");
    	list.add("KCT0004596");
    	list.add("KCT0004605");
    	list.add("KCT0004598");
    	list.add("KCT0004579");
    	list.add("KCT0004580");
    	list.add("KCT0004578");
    	list.add("KCT0004581");
    	list.add("KCT0004573");
    	list.add("KCT0004575");
    	list.add("KCT0004583");
    	list.add("KCT0004572");
    	list.add("KCT0004576");
    }


    
    public static void getXmlData() throws Exception {
    	
    	//File xmlFile = new File("C:\\Users\\Administrator\\Desktop\\11\\total_sendXml.xml");
    	File xmlFile = new File("C:\\Users\\User\\Desktop\\upd\\Result_sendXml_upd111.xml");
    	
        //1.문서를 읽기위한 공장을 만들어야 한다.
           DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            
           //2.빌더 생성
           DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            
           //3.생성된 빌더를 통해서 xml문서를 Document객체로 파싱해서 가져온다
       Document doc = dBuilder.parse(xmlFile);
       doc.getDocumentElement().normalize();//문서 구조 안정화
        
       Element root = doc.getDocumentElement();
        
       NodeList n_list = root.getElementsByTagName("trial");
       Element el = null;
       NodeList sub_n_list = null; //sub_n_list
           Element sub_el = null; //sub_el
            
           Node v_txt = null;
           String value="";
            
       // String[] tagList = {"trial_id", "reg_name", "date_registration"};
       String[] tagList = {"trial_id"};
         
       System.out.println("***********************************************");
       System.out.println("노드수" + n_list.getLength());
       
       for(int i=0; i<n_list.getLength(); i++) {
         el = (Element) n_list.item(i);
         for(int k=0; k< tagList.length; k++) {
           sub_n_list = el.getElementsByTagName(tagList[k]);
           for(int j=0; j<sub_n_list.getLength(); j++) {
             sub_el = (Element) sub_n_list.item(j);
             v_txt = sub_el.getFirstChild();
             value = v_txt.getNodeValue();

             if(list.contains(value)){
             	// System.out.println(value);
             }else{
            	 System.out.println(value);
             }
             //System.out.println(value);
             
           }
         }
    
       }

     }
    
    public static void main(String[] args) throws IOException{

        try{
        	
        	getXmlData();	
        	
        	//createFile();
   
        	//createFile2();
        	
	        }catch (Exception e) {
	            // TODO: handle exception
	        	e.printStackTrace();
	        }
    }

}

