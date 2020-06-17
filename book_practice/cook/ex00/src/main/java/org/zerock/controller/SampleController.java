package org.zerock.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.SampleDTO;
import org.zerock.domain.SampleDTOList;
import org.zerock.domain.TodoDTO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/sample/*")	// @RequestMapping : Ŭ���� ���� or method ���� ���
@Log4j
public class SampleController {

	/*
	 * @RequestMapping("") public void basic() {
	 * log.info("basic....in SampleController class............"); }
	 * 
	 * 
	 * @RequestMapping(value="/basic", method = {RequestMethod.GET,
	 * RequestMethod.POST}) public void basicGet() {
	 * log.info("basic_ GET,POST ��δ� �迭�� ó��"); }
	 * 
	 * @GetMapping("/basicOnlyGet") public void basicGet2() {
	 * log.info("basic get only get...�����ϳ� ��ɿ� ���� ��������"); }
	 */
	
	@GetMapping("/ex01")  // Get�̴ϱ� URL�� parameter Ȯ��
	public String ex01(SampleDTO dto) {
		log.info("SampleDTO @Data�� ����  setter Ȯ�� \t:\t"+dto);
		
		return "ex01";
	}
	
	@GetMapping("/ex02")	// �Ʒ��� ���� ������� parameter��� �ٸ� ��쿡 ����
	public String ex02(@RequestParam("name11") String name22, @RequestParam("age") int age) {
		log.info("name : "+name22);	
		log.info("age : "+age);
		
		
		// return �Ʒ� ���ڿ��� ���� ������ �𸣰���...
		return "ex";
	}
		
	@GetMapping("/ex02List")			// ������ �̸��� parameter ������ ���޽�  ArrayList ó��
	public String exx02List(@RequestParam("ids") ArrayList<String> ids) {
										// URL�� ids�� ������ ������ �ڵ����� ���� �迭�� ���!
//		http://localhost:8080/sample/ex02List?ids=11&idx=222&ids=3333&ids=4444444
		log.info("idx : "+ids);
		
		return "���Ļ�..";
	}
	
	
	
	@GetMapping("/ex02Bean")		//  SampleDTO�� ���� ��ü Ÿ���� ������ ó�� �Ѵٸ�, list�� ��ü ��� SampleDTOListŬ���� �����ؼ�~
	public String ex02Bean(SampleDTOList list) {
//		http://localhost:8080/sample/ex02Bean?list[0].name=aaa&list[2].name=bbb
//		tomcat ������ ���� Ư������ [] ��� ���� ��� =>  [=%5B , ]=%5D
//		http://localhost:8080/sample/ex02Bean?list%5B0%5D.name=aaa&list%5B2%5D.name=bbb
		log.info("list dtos : "+list);
		
		return "ex02Bean";
	}
	
	
	
//	TodoDTO.java
	//	binding = �Ķ���� ���� (��쿡 ���� �Ķ���� ��ȯ ó�� �ؾ� �ϴ� ��쿡 ���� )	=> �Ķ���� ���ε� �� �� �ڵ����� @InitBinder ȣ��
	/*
	 * @InitBinder // �̰� ���ٸ� ex03 �� 400 error(��û ���� syntax)�� �� �� �ƴ� ) public void
	 * initBinder(WebDataBinder binder) { SimpleDateFormat dateFormat = new
	 * SimpleDateFormat("yyyy-MM-dd");
	 * binder.registerCustomEditor(java.util.Date.class, new
	 * CustomDateEditor(dateFormat, false)); }
	 */

//	1.  @InitBinder
//	http://localhost:8080/sample/ex03?title=test&dueDate=2018-01-01
//	2.  no @InitBinder -> @DateTimeFormat() in TodoDTO.java(changed)
//	http://localhost:8080/sample/ex03?title=test&dueDate=2018/05/14
	@GetMapping("/ex03")
	public String ex03(TodoDTO todo) {
		log.info("todo : "+todo);
		return "ex03";
	}
	
	
//	p. 140  Model
//	http://localhost:8080/sample/ex04?name=aaa&page=9
	@GetMapping("/ex04")
//	public String ex04(SampleDTO dto, int page) { // dto에 설정 안 된 추가된 파라미터 page(기본 자료형)는 요청은 받지만 화면에 X
	public String ex04(SampleDTO dto, @ModelAttribute("page") int page) {	
	//  model : Controller에 전달된 데이터 이용한 추가 데이터 화면으로 보낼 때 (모델2에서 request.setAttribute()와 유사)
		//		-	MVC의 Controller는 Java Beans규칙에 맞는 객체를 화면으로 전달 (Java Beans 규칙 : 생성자 없거나, 빈생성자 가지고, getter/setter가진 클래스의 객체들 의미 ex. SampleDTO.java )
		log.info("dto : "+dto);
		log.info("page : "+page);
		
		return "/sample/ex04";
	}
	
	
	
//	p.143  Controller 리턴 타입  : String, void, VO/DTO 타입=객체 타입, ResponseEntity 타입, Model/ModelAndView, HttpHeaders 등
	// String 타입은 HomeController.java에서 (여기선 JSP파일 이름 의미) : 상황에 따라 다른 화면 보여줄 때(if~else 등)
	//			- 키워트 붙여 사용 가능 : redirect, forward (by 처리 방식)
	
//	http://localhost:8080/sample/ex05
	// servlet-context.xml의 prefix, suffix에 의해 URL 경로를 view로 처리
	@GetMapping("/ex05")
	public void ex05() {
		log.info("ex05  void 타입..........");
	}
	
	
	// VO,DTO (객체타입) - pom.xml에 jackson-databind 라이브러리 추가 (없을 시 500error : 리턴 타입에 맞게 데이터 변환 역할) -> content-type:application/json으로 처리 됨
	//  VO = Value Object, DTO = Data Transfer Object
//	http://localhost:8080/sample/ex06
	@GetMapping("/ex06")
	public @ResponseBody SampleDTO ex06() {
		log.info("ex06... JSON 타입 : ");
		SampleDTO dto = new SampleDTO();
		dto.setAge(10);
		dto.setName("KSH");
		dto.setAge(20);
		dto.setName("SH");// 마지막것만 받네... 
		
		return dto;
	}
	
	
	//  ResponseEntity 타입  : HTTP 프로토콜 헤더를 다를 경우.... HttpServletRequest/HttpServletResponse 직접 핸들링 않고 가능하게...
	@GetMapping("/ex07")
	public ResponseEntity<String> ex07(){
		log.info("ex07  ResponseEntity........");
		
		String msg = "{\"name\":\"김선화\"}";
		HttpHeaders header = new HttpHeaders();
		header.add("Content-type", "application/json;charset=UTF-8");
		return new ResponseEntity<>(msg, header, HttpStatus.OK);
	}
	
	
//	p.149 파일업로드
	//  pom.xml : commons-fileupload 추가,  servlet-context.xml : multipartResolver 추가
	@GetMapping("/exUpload")
	public void exUpload() {	// void 타입 -> prefix+exUpload+surfix로 http://localhost:8080/sample/exUpload
		log.info("/exUpload  파일업로드 ............ ");
	}
	
	@PostMapping("/exUploadPost")
	public void exUploadPost(ArrayList<MultipartFile> files) {
		files.forEach(file ->{
			log.info("file--------------------------------------------");
			log.info("name : "+file.getOriginalFilename());
			log.info("size : "+file.getSize());
		});
	}// 최종 업로드는 byte[]처리까지...  later
}
