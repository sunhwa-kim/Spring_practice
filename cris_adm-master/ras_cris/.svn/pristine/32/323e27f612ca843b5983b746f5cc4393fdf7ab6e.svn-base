package kr.go.cris.commons.utils;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException; 
import java.io.StringReader;
import java.io.StringWriter;
import java.io.Writer;

import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import egovframework.cmmn.service.EgovProperties;


public class XslProc {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	public static final String KDR_CONF_PATH = EgovProperties.getPathProperty("Globals.KDRConfPath");
	public static final String DTDPATH = EgovProperties.getProperty(KDR_CONF_PATH, "dtd.path.po");
	/**
	 * param	String source 	: 대상 파일명
	 *  		String xsl		: 이용할 XSLT 파일명
	 *  		String def		: 완료 파일명
	 * return 	Transformer
	 * @throws TransformerException 
	 *  
	 */
	public String doc2TransWithXSL(String source, String xsl, String dtdRootPath){
		return doc2TransWithXSL(source, xsl, "html", dtdRootPath);
	}
	 
	public String doc2TransWithXSL(String source, String xsl, String method, String dtdRootPath){
log.debug("doc2TransWithXSL // ");
		String retVal = "";
		BufferedReader inFile = null;
		FileReader rd = null;
		try {
			// 파일로 받아올 때 <!--
//			InputStream xmlFileSource = new FileInputStream("D:\\ttest\\JATS\\userguide.xml");
//			InputStream xslFileSource = new FileInputStream("D:\\ttest\\JATS\\xslt\\main\\jats-html.xsl");
			// -->
			StringBuffer sb = new StringBuffer();
			rd = new FileReader(source);
			inFile = new BufferedReader(rd);
			String sLine = null;
			while ((sLine = inFile.readLine()) != null) {
				sb.append(sLine + "\n"); // 버퍼에 String 을 추가한다.
			}
//// 사용금지 System.out.println(sb.toString());

			String loadXml = sb.toString();
			String convXML = "";
			if(loadXml.indexOf("JATS-archivearticle1.dtd") != -1) {
		 		// 이미 변환 된 것인지 체크.
				if(loadXml.indexOf("jats-archiving-dtd-1.0") == -1){ convXML = StringUtils.replace(loadXml, "JATS-archivearticle1.dtd"	  	, dtdRootPath + "jats-archiving-dtd-1.0/JATS-archivearticle1.dtd");
				}else{convXML = loadXml;}
			} else if(loadXml.indexOf("JATS-journalpublishing1.dtd") != -1) {
				// 이미 변환 된 것인지 체크.
				if(loadXml.indexOf("jats-publishing-dtd-1.0") == -1){ convXML = StringUtils.replace(loadXml, "JATS-journalpublishing1.dtd"	, dtdRootPath + "jats-publishing-dtd-1.0/JATS-journalpublishing1.dtd");
				}else{ convXML = loadXml;}
			} else {
				convXML = loadXml;
			}
			
			convXML = sb.toString();
// 사용금지 System.out.println("convXML : " + convXML);
//			StreamSource xmlSource = new StreamSource(source);
			StreamSource xsltSource = new StreamSource(xsl);
			
			Writer outWriter = new StringWriter();
			StreamResult retStream = new StreamResult(outWriter);
			
			TransformerFactory tFactory = TransformerFactory.newInstance();
			Transformer transformer = tFactory.newTransformer(xsltSource);
			transformer.setOutputProperty(OutputKeys.METHOD, method);
			transformer.setOutputProperty(OutputKeys.INDENT, "yes");
			transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
			
			StreamSource aaa = new StreamSource(new StringReader(convXML));
			
			transformer.transform(aaa, retStream);

//			retVal = outWriter.toString();
		} catch(TransformerException e) {
			retVal = "TransformerException error";
		}catch(IOException ex){
			retVal = "IOException error";
		}finally{
			try {
				if(rd != null){rd.close();}
				if(inFile != null){inFile.close();}
			} catch (IOException e) {log.debug("IOException");}	
		}
		log.debug("// doc2TransWithXSL");
		return retVal;
	}
	
	/**
	 * 상세 화면에서는 리턴 받아 화면에 뿌려야 하므로 따로 메소드 생성.
	 * @param source
	 * @param xsl
	 * @param method
	 * @return
	 */
//	public String doc2TransWithXSLReturn(String source, String xsl, String method, String dtdRootPath) {
//		log.debug("doc2TransWithXSL // ");
//				String retVal = "";
//				System.setProperty("javax.xml.transform.TransformerFactory", "net.sf.saxon.TransformerFactoryImpl");
//				try {
//					StringBuffer sb = new StringBuffer();
//					BufferedReader inFile = new BufferedReader(new FileReader(source));
//					String sLine = null;
//					while ((sLine = inFile.readLine()) != null) {
//						sb.append(sLine + "\n"); // 버퍼에 String 을 추가한다.
//					}
//					
//					String loadXml = sb.toString();
//					String convXML = "";
//					/*if(loadXml.indexOf("JATS-archivearticle1.dtd") != -1) {
//						if(loadXml.indexOf("jats-archiving-dtd-1.0/JATS-archivearticle1.dtd") == -1) { 		// 이미 변환 된 것인지 체크.
//							convXML = StringUtils.replace(loadXml, "JATS-archivearticle1.dtd"	  	, dtdRootPath + "jats-archiving-dtd-1.0/JATS-archivearticle1.dtd");
//						}
//					} else if(loadXml.indexOf("JATS-journalpublishing1.dtd") != -1) {
//						if(loadXml.indexOf("jats-publishing-dtd-1.0/JATS-journalpublishing1.dtd") == -1) {
//							convXML = StringUtils.replace(loadXml, "JATS-journalpublishing1.dtd"	, dtdRootPath + "jats-publishing-dtd-1.0/JATS-journalpublishing1.dtd");
//						}
//					}*/
//					
//					convXML = sb.toString();
//					convXML = convXML.replaceFirst("/app/was/uploadfilesComm/ncmik/pmc/converter/jats-publishing-dtd-1.0/", "");
//					StreamSource xsltSource = new StreamSource(new File(xsl));
//					
//					Writer outWriter = new StringWriter();
//					StreamResult retStream = new StreamResult(outWriter);
//					
//					TransformerFactory tFactory = TransformerFactory.newInstance();
//					Transformer transformer = tFactory.newTransformer(xsltSource);
//					
//					XMLReader xmlReader = SAXParserFactory.newInstance().newSAXParser().getXMLReader();
//					xmlReader.setEntityResolver(new EntityResolver() {
//					    public InputSource resolveEntity(String publicId, String systemId)
//					            throws SAXException, IOException {
//					    	
//				    		String dtdPaths[] = {"DTD LIST"
//									,dtdPath+"jats-archiving-dtd-1.0/"
//									,dtdPath+"jats-publishing-dtd-1.0/"
//									,dtdPath+"archive-interchange-dtd-3.0/"
//									,dtdPath+"archive-interchange-dtd-2.3/"
//									,dtdPath+"archive-interchange-dtd-2_2-June/"
//									,dtdPath+"archive-interchange-dtd-2.1/"
//									,dtdPath+"archive-interchange-dtd-2.0/"
//									,dtdPath+"archive-interchange-dtd-1.1/"
//									,dtdPath+"archive-interchange-dtd/"
//									,dtdPath+"journal-publishing-dtd-3.0/"
//									,dtdPath+"journal-publishing-dtd-2.3/"
//									,dtdPath+"journal-publishing-dtd-2_2-June/"
//									,dtdPath+"journal-publishing-dtd-2.1/"
//									,dtdPath+"journal-publishing-dtd-2.0/"
//									,dtdPath+"journal-publishing-dtd-1.1/"
//									,dtdPath+"journal-publishing-dtd/"
//								};
//								String fid = getFileName(systemId);
//								String fname = "";
//								for (int i=1; i < dtdPaths.length; i++) { // dtdPath 디렉토리에서 찾아본다. 하나라도 걸리면 된다.
//									fname = dtdPaths[i] + fid;
//									File f = new File(fname);
//									if (f.exists()) return new InputSource(new FileReader(fname));
//								}
//				            	return null; 
//					    }
//					});
//					Source ssXML = new SAXSource(xmlReader, new InputSource(new StringReader(convXML)) );
//
//					//System.out.println("convXML="+convXML);
//					
//					transformer.transform(ssXML, retStream);
//
//					retVal = outWriter.toString();
//				} catch(Exception e) {
//					String errMsg = e.toString();
//					retVal = errMsg.substring(errMsg.lastIndexOf(":") + 1, errMsg.length());
//					e.printStackTrace();
//				}
//log.debug("// doc2TransWithXSL");
//				return retVal;
//			}
	
	
	public String doc2TransWithXSLReturn(String source, String xsl, String method, String dtdRootPath) {
		log.debug("doc2TransWithXSL // ");
				String retVal = "";
				BufferedReader inFile = null;
				FileReader rd = null;
				try {
					// 파일로 받아올 때 <!--
//					InputStream xmlFileSource = new FileInputStream("D:\\ttest\\JATS\\userguide.xml");
//					InputStream xslFileSource = new FileInputStream("D:\\ttest\\JATS\\xslt\\main\\jats-html.xsl");
					// -->
					StringBuffer sb = new StringBuffer();
					rd = new FileReader(source);
					inFile = new BufferedReader(rd);
					String sLine = null;
					while ((sLine = inFile.readLine()) != null) {
						sb.append(sLine + "\n"); // 버퍼에 String 을 추가한다.
					}
					
					
		//// 사용금지 System.out.println(sb.toString());

					String loadXml = sb.toString();
					String convXML = "";
					/*if(loadXml.indexOf("JATS-archivearticle1.dtd") != -1) {
						if(loadXml.indexOf("jats-archiving-dtd-1.0/JATS-archivearticle1.dtd") == -1) { 		// 이미 변환 된 것인지 체크.
							convXML = StringUtils.replace(loadXml, "JATS-archivearticle1.dtd"	  	, dtdRootPath + "jats-archiving-dtd-1.0/JATS-archivearticle1.dtd");
						}
					} else if(loadXml.indexOf("JATS-journalpublishing1.dtd") != -1) {
						if(loadXml.indexOf("jats-publishing-dtd-1.0/JATS-journalpublishing1.dtd") == -1) {
							convXML = StringUtils.replace(loadXml, "JATS-journalpublishing1.dtd"	, dtdRootPath + "jats-publishing-dtd-1.0/JATS-journalpublishing1.dtd");
						}
					}*/
					
					convXML = sb.toString();
					
//					StreamSource xmlSource = new StreamSource(source);
					StreamSource xsltSource = new StreamSource(xsl);
					
					Writer outWriter = new StringWriter();
					StreamResult retStream = new StreamResult(outWriter);
					
					TransformerFactory tFactory = TransformerFactory.newInstance();
					Transformer transformer = tFactory.newTransformer(xsltSource);
					transformer.setOutputProperty(OutputKeys.METHOD, method);
					transformer.setOutputProperty(OutputKeys.INDENT, "yes");
					transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
					
					StreamSource aaa = new StreamSource(new StringReader(convXML));
					
					transformer.transform(aaa, retStream);

					retVal = outWriter.toString();
				} catch(TransformerException e) {
					retVal = "TransformerException error";
				}catch(IOException ex){
					retVal = "IOException error";
				}finally{
					try {
						if(rd != null){rd.close();}
						if(inFile != null){inFile.close();}
					} catch (IOException e) {log.debug("IOException");}	
				}
log.debug("// doc2TransWithXSL");
				return retVal;
			}
	
	
	
	
	private static String getCurrentDir() throws IOException {

        String currentDir = new java.io.File(".").getCanonicalPath();

        currentDir = currentDir.replace(File.separatorChar, '/');
        String osType = System.getProperty("os.name");
        if (osType.startsWith("Windows")) {
        	currentDir = "file:///" + currentDir + "/";
        } else {
        	currentDir = "file://" + currentDir + "/";
        }

        return currentDir;
    }
    private static String getFileName(String systemId) throws IOException {

        // clean up file name
        String currentDir = getCurrentDir();

        if (systemId.startsWith(currentDir)) {
            return systemId.substring(currentDir.length());
        } else {
            return systemId;
        }
    }

}
