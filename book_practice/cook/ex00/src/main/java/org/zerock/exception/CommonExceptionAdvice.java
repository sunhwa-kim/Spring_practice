package org.zerock.exception;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {

//	http://localhost:8080/sample/ex04?name=111&age=abc&page=7
	// url에 파라미터와 맞지 않는 age에 int아닌거 넣어서 error 발생
		@ExceptionHandler(Exception.class)
		public String except(Exception ex, Model model) {
			log.error("Exception (CommonExceptionAdvice.java)\t:\t"+ex.getMessage());
			model.addAttribute("exception",ex);
			log.error(model);
			return "error_page";    // 문자열로 리턴 = jsp 파일경로의미~
		}
		
//		404 에러 페이지 위한  throwExceptionIfNoHandlerFound 추가 in web.xml
		@ExceptionHandler(NoHandlerFoundException.class)
		@ResponseStatus(HttpStatus.NOT_FOUND)
		public String handle404(NoHandlerFoundException ex) {

			return "custom404";
		}
}