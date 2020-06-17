package org.zerock.sample;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Component
@ToString
@Getter
@AllArgsConstructor  //  객체 변수로 선언된 모두를 parameter로 받는 생성자 작성
//@RequiredArgsConstructor  //  if, 특정 변수만 생성자 작성하고 싶을때  + @NonNull or final 붙은 변수
public class SampleHotel {
//	@NonNull
	private Chef chef;
	
	//  @AllArgsConstructor 작성 후 주석처리
//	public SampleHotel(Chef chef) {
//		this.chef = chef;
//	}
}
