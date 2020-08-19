package kr.go.cris.commons.init;



import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

@Component
public class CORSFilter implements Filter  {

	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {

		HttpServletResponse response = (HttpServletResponse) res;
    
		response.setHeader("X-Frame-Options", "ALLOW-FROM http://www.cdc.go.kr");
        //response.setHeader("Content-Type","application/json;charset=UTF-8");
        //response.setHeader("Access-Control-Allow-Origin","*");
        //response.setHeader("Access-Control-Allow-Methods","DELETE, HEAD, GET, OPTIONS, POST, PUT");
        //response.setHeader("Access-Control-Allow-Headers","Origin,Accept,X-Requested-With,Content-Type,Access-Control-Request-Method,Access-Control-Request-Headers,Authorization");
        response.setHeader("Access-Control-Max-Age","1728000");
        
        chain.doFilter(req, res);

    }

    public void init(FilterConfig filterConfig) {
    	if(Logger.getLogger(CORSFilter.class).isDebugEnabled()){
    		Logger.getLogger(CORSFilter.class).debug("IGNORED: init");	
    	}
    	
    }

    public void destroy() {
    	if(Logger.getLogger(CORSFilter.class).isDebugEnabled()){
    		Logger.getLogger(CORSFilter.class).debug("IGNORED: destroy");
    	}
    }





}