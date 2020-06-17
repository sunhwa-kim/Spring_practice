package org.zerock.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class TodoDTO {
	private String title;
	
//	1. Controller에서 @InitiBinder 사용
//	private Date dueDate;
	
//	2.  Controller에서 @InitiBinder 사용 X
	@DateTimeFormat(pattern = "yyy/MM/dd")
	private Date dueDate;
	
}
