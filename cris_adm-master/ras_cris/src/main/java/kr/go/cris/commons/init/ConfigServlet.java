/******************************************************************
 * Copyright RASTECH 2015
 ******************************************************************/
package kr.go.cris.commons.init;

import java.io.File;
import java.io.Serializable;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.commons.lang3.BooleanUtils;

/**
 * <pre>
 * FileName: ConfigServlet.java
 * Package : kr.go.cris.commons.init
 *
 * 환경설정 서블렛.
 *
 * </pre>
 * @author : rastech
 * @date   : 2015. 3. 9.
 */

public class ConfigServlet extends HttpServlet implements Serializable {
    /** serialVersionUID */
    private static final long serialVersionUID = -1621378941747673748L;
    
    /**
     *
     * <pre>
     * 환경 설정.
     *
     * </pre>
     *
     * @author : rastech
     * @date : 2015. 3. 9.
     * @param config
     * @throws ServletException
     */
    public void init(ServletConfig config) throws ServletException {
        super.init(config);

        ServletContext sc = config.getServletContext();

        String ctxt = sc.getContextPath();

        sc.setAttribute("ctxt", ctxt);

        String uploadPath = config.getInitParameter("uploadPath");
        String uploadPath_pop = config.getInitParameter("uploadPath_pop");
        String uploadPath_zip = config.getInitParameter("uploadPath_zip");
        String mailSender = config.getInitParameter("mailSender");
        String domain = config.getInitParameter("domain");
        String contextPath = config.getInitParameter("contextPath");
        boolean isDev = BooleanUtils.toBoolean(config.getInitParameter("devMode"));
        
    
        File dir = new File(uploadPath);
        if (!dir.canRead()) {
        	dir.setExecutable(false);
        	dir.setReadable(true);
        	dir.setWritable(false);
        	dir.mkdirs();	
        }
   
    }
   
}
