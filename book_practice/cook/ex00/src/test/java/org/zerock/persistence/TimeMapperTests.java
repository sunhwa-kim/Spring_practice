package org.zerock.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.mapper.TimeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
// Java 설정의 경우
// @ContextConfiguration(classes = { org.zerock.config.RootConfig.class })
@Log4j
public class TimeMapperTests {
	@Setter(onMethod_ = @Autowired)
	private TimeMapper timeMapper;  //  테스트로 확인 할 객체

	@Test
	public void testGetTime() {
		log.info(timeMapper.getClass().getName());   // 실제 동작하는 클래스 이름 확인 (interface만으로 클래스가 확인되는....나중에 spring AOP 참고, p97)
		log.info(timeMapper.getTime());
	}

	@Test
	public void testGetTime2() {

		log.info("getTime2");
		log.info(timeMapper.getTime2());

	}
}
