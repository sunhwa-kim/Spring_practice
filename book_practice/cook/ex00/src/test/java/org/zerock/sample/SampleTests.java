package org.zerock.sample;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//  test 실행 방법 :  Rus As> Junit Test 로


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")  // spr 실행시, (classpath: or file:)안 class나 문자열로 bean 등록
@Log4j  // log4j 라이브러리와 설정 존재시 선언없이 사용가능 (src/main/resources, src/test/resources 각각에 로그 설정 별도로 존재)
public class SampleTests {

	
	@Setter(onMethod_ = @Autowired)   // @Autowired : 의존적 , 해당 bean 주입되는
	private Restaurant restaurant;
	
	
	@Test  //  데스트 대상 표시
	public void testExist() {
		
		assertNotNull(restaurant);  //  restaurant 변수 null이 아닐 때 테스트 성공

		log.info("---------------- SampleTests ---------------------");
		
		log.info(restaurant);
		
		log.info("-----------------------------------------");
		
		log.info(restaurant.getChef());
		
	}
}
