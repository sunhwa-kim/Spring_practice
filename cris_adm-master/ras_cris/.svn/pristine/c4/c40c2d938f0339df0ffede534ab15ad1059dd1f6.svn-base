/******************************************************************
 * Copyright RASTECH 2015
 ******************************************************************/
package kr.go.cris.base.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.GatheringByteChannel;
import java.nio.channels.ScatteringByteChannel;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import kr.go.cris.base.BaseObj;
import kr.go.cris.commons.constants.Constants;
import kr.go.cris.commons.file.service.FileService;
import kr.go.cris.commons.file.vo.FileVo;
import kr.go.cris.commons.login.vo.UserVo;
import kr.go.cris.ptl.mng.code.service.MngCodeService;
import kr.go.cris.ptl.mng.code.vo.MngCodeVo;

import org.apache.commons.lang3.time.FastDateFormat;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
 
/**
 * <pre>
 * FileName: BaseController.java
 * Package : kr.go.cris.base.controller
 *
 * 프로젝트 최상위 Controller.
 * 
 * </pre>   
 * @author : rastech
 * @date   : 2015. 3. 9.
 */
public class BaseController extends BaseObj implements ServletContextAware{

    // 팝업용경로  첨부파일 경로 + 파일명 생성용 pattern
    private FastDateFormat saveFilePattern = FastDateFormat.getInstance("/yyyyMMddHHmmssSS");
    
    // 공통 Logger.
    protected transient Logger logger = LoggerFactory.getLogger(this.getClass());
    
    // 공지사항, FAQ
    private FastDateFormat saveBoardFilePattern = FastDateFormat.getInstance("/yyyy/MM/dd/yyyyMMddHHmmssSS");
    // Spring Message Source
    @Resource
    protected MessageSource messageSource;

    @Resource
    protected FileService fileService;

	protected  ServletContext servletContext;

	@Resource
	private MngCodeService mngCodeService;
	
    /**
     *
     * <pre>
     * 모바일 접근인지 확인하여 true/false 반환.
     *
     * </pre>
     * @author : rastech
     * @date   : 2015. 3. 11.
     * @return
     */
    public boolean isMobile(HttpServletRequest request) {
        String ua = request.getHeader("User-Agent").toLowerCase();
        boolean isMobile = false;

        if (ua.matches(".*(android|avantgo|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\\/|plucker|pocket|psp|symbian|treo|up\\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino).*")||ua.substring(0,4).matches("1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\\-(n|u)|c55\\/|capi|ccwa|cdm\\-|cell|chtm|cldc|cmd\\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\\-s|devi|dica|dmob|do(c|p)o|ds(12|\\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\\-|_)|g1 u|g560|gene|gf\\-5|g\\-mo|go(\\.w|od)|gr(ad|un)|haie|hcit|hd\\-(m|p|t)|hei\\-|hi(pt|ta)|hp( i|ip)|hs\\-c|ht(c(\\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\\-(20|go|ma)|i230|iac( |\\-|\\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\\/)|klon|kpt |kwc\\-|kyo(c|k)|le(no|xi)|lg( g|\\/(k|l|u)|50|54|e\\-|e\\/|\\-[a-w])|libw|lynx|m1\\-w|m3ga|m50\\/|ma(te|ui|xo)|mc(01|21|ca)|m\\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\\-2|po(ck|rt|se)|prox|psio|pt\\-g|qa\\-a|qc(07|12|21|32|60|\\-[2-7]|i\\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\\-|oo|p\\-)|sdk\\/|se(c(\\-|0|1)|47|mc|nd|ri)|sgh\\-|shar|sie(\\-|m)|sk\\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\\-|v\\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\\-|tdg\\-|tel(i|m)|tim\\-|t\\-mo|to(pl|sh)|ts(70|m\\-|m3|m5)|tx\\-9|up(\\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|xda(\\-|2|g)|yas\\-|your|zeto|zte\\-")) {
            isMobile = true;
        }

        return isMobile;
    }

    /**
     *
     * <pre>
     * 메시지 프로퍼티에서 값을 가져온다.
     *
     * </pre>
     *
     * @author : rastech
     * @date : 2015. 3. 9.
     * @param code
     * @return
     */
    protected String getMessage(String code) {
        return getMessage(code, null);
    }

    /**
     *
     * <pre>
     * 메시지 프로퍼티에서 값을 가져온다.
     * 아큐먼트에 값을 세팅한다.
     *
     * ex) {0}은 {1}입니다. => getMessage('code', {'라면', '삼양'}) => 라면은 삼양입니다.
     * </pre>
     *
     * @author : rastech
     * @date : 2015. 3. 9.
     * @param code
     * @param args
     * @return
     */
    protected String getMessage(String code, String[] args) {
        return messageSource.getMessage(code, args, LocaleContextHolder.getLocale());
    }

   /**
    *
    * <pre>
    * 사용자를 세션에 저장한다.
    *
    * </pre>
    * @author : rastech
    * @date   : 2015. 3. 9.
    * @param userVo
    * @return
    */
   protected void setUser(UserVo userVo) {
       ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
       HttpServletRequest request = sra.getRequest();
       request.getSession().setAttribute("userVo", userVo);
   }

   /**
    *
    * <pre>
    * 로그인한 사용자를 가져온다.
    *
    * </pre>
    * @author : rastech
    * @date   : 2015. 3. 9.
    * @return
    */
   protected UserVo getUser() {
       ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
       HttpServletRequest request = sra.getRequest();
       return (UserVo) request.getSession().getAttribute("userVo");
   }



  

	/**
	 * <pre>
	 * 파일저장
	 *
	 * </pre>
	 * @author : sejin
	 * @date   : 2016. 1. 22.
	 * @param srcFile
	 * @throws IOException, SQLException , NullPointerException
	 */
	public void scatterGather(String srcFile) throws IOException, SQLException , NullPointerException {  
		
		   FileInputStream fis = null;
		   FileOutputStream fos = null;
		try{
			String savePath = saveFilePattern.format(Calendar.getInstance().getTime());
			
		    fis = new FileInputStream(srcFile);  
		    fos = new FileOutputStream(Constants.UPLOAD_PATH + savePath);  
		      
		    ScatteringByteChannel sbc = fis.getChannel();  
		    GatheringByteChannel gbc = fos.getChannel();  
		      
		    ByteBuffer bb = ByteBuffer.allocateDirect(2048);  
		    while (sbc.read(bb) != -1) {  
		        bb.flip();  
		        gbc.write(bb);  
		        bb.clear();  
		    }  
		}catch(IOException ex){
			
			logger.debug("ERROR scatterGather");
		}finally{
			try{
				if(fos != null){
					fos.close();	
				}
			
			}catch(IOException x){
				logger.debug("ERROR scatterGather");
			}
			
			try{
				if(fos != null){
				   fis.close(); 
				}				  
			}catch(IOException x){
				logger.debug("ERROR scatterGather");
			}
		    
		}
		
	      
	  
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		
	}
   
	
	public List<MngCodeVo> getCodeList(String code) throws IOException, SQLException , NullPointerException {
		return mngCodeService.getCodeList(code);
	}
	
	 /**
    *
    * <pre>
    * 첨부파일 저장.
    * 순수하게 첨부 파일만 저장하는 경우 사용한다.
    * 팝업관리용 .... getRealPath 사용..
    * </pre>
    * @author : rastech
    * @date   : 2015. 3. 9.
    * @param request multipart request
    * @param fileField input테그의 file name 속성 값.
    * @return
	 * @throws  
    */
   protected List<FileVo> saveFiles( MultipartHttpServletRequest multipartRequest, String fileField  )   {
       //MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
       List<MultipartFile> files = multipartRequest.getFiles(fileField);
     
       int i = 1;
       List<FileVo> list = new ArrayList<FileVo>();
       if (files != null && !files.isEmpty()) {
           File newFile = null;
           String savePath = null;
           FileVo fileVo = null;
           for (MultipartFile file: files) {
               if (file.getSize() > 0) {

                   String ncmikFileType = "";
                   String ncmikFileNm = file.getOriginalFilename();
                   int typeIndx = ncmikFileNm.lastIndexOf(".");

                   ncmikFileType = ncmikFileNm.substring(typeIndx+1);

                   savePath = saveFilePattern.format(Calendar.getInstance().getTime())+"."+ncmikFileType;
                   fileVo = new FileVo();
                   fileVo.setFileNm(file.getOriginalFilename());
                 
                   fileVo.setFileSize(file.getSize());
                   fileVo.setFileOrd(i);
                   try {
                	   String path = Constants.UPLOAD_PATH;
                	   fileVo.setFileConvNm(path+savePath);
                       newFile = new File( path+ savePath);
                      // newFile = new File(Constants.UPLOAD_PATH + savePath);
                       newFile.getParentFile().mkdirs();
                     
						file.transferTo(newFile);
				

                       Thread.sleep(1);    // 변환 파일명이 겹치지 않게 delay를 준다.

                       //fileService.insertFile(fileVo);

                       list.add(fileVo);
                       i++;
                    } catch (InterruptedException e) {
                       logger.debug("error  saveFiles");
                       if (newFile.canRead()){ newFile.delete(); } 
                  	} catch (IllegalStateException e) {
                  	  logger.debug("error  IllegalStateException saveFiles transferTo");
					} catch (IOException e) {
						  logger.debug("error IOException saveFiles transferTo");
					}
               }
           }
       }

       return list;
   }
	
   protected List<FileVo> saveExcelUploadFiles(MultipartFile file) {
    /*   MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
       List<MultipartFile> files = multipartRequest.getFiles(fileField);
       System.out.println("files == " + files);*/
       int i = 1;
       List<FileVo> list = new ArrayList<FileVo>();
       if (file != null && !file.isEmpty()) {
           File newFile = null;
           String savePath = null;
           FileVo fileVo = null;
  
               if (file.getSize() > 0) {

                   String ncmikFileType = "";
                   String ncmikFileNm = file.getOriginalFilename();
                   int typeIndx = ncmikFileNm.lastIndexOf(".");

                   ncmikFileType = ncmikFileNm.substring(typeIndx+1);

                   savePath = saveFilePattern.format(Calendar.getInstance().getTime())+"."+ncmikFileType;
                   fileVo = new FileVo();
                   fileVo.setFileNm(file.getOriginalFilename());
                 
                   fileVo.setFileSize(file.getSize());
                   fileVo.setFileOrd(i);
                   try {
                	   String path = Constants.UPLOAD_PATH;
                	   fileVo.setFileConvNm(path+savePath);
                       newFile = new File( path+ savePath);
                      // newFile = new File(Constants.UPLOAD_PATH + savePath);
                       newFile.getParentFile().mkdirs();
                       file.transferTo(newFile);

                       Thread.sleep(1);    // 변환 파일명이 겹치지 않게 delay를 준다.

                       //fileService.insertFile(fileVo);

                       list.add(fileVo);
                       i++;
                   } catch (InterruptedException e) {
                       logger.debug("err=saveExcelUploadFiles" );
                       if (newFile.canRead()){newFile.delete();}
                   }catch (IOException e) {
                       logger.debug("err=saveExcelUploadFiles" );
                       if (newFile.canRead()){newFile.delete();}
                   }
               }
       
       }

       return list;
   }
	
   
   
   /**
 * <pre>
 *  숫자 확인
 *
 * </pre>
 * @author : wonki0138
 * @date   : 2018. 4. 4. 
 * @param str
 * @return
 */
public boolean isNumber(String str){
	   
	   return str.matches("^[0-9]*$");
   }
}
