package me.sunhwa.demorestapi.events;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.hateoas.MediaTypes;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.time.LocalDateTime;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

//@SpringBootTest
@WebMvcTest(EventController.class)   // slicing test : web 관련 빈들만 등록해서 만들어 계층별로 분리 != 단위 테스트
public class EventControllerTest {

    @Autowired
    MockMvc mockMvc;   // mocking된 dispatcher servlet으로 가짜 요청/응답 확인 테스트
                       // web server 띄우지 않아서 그 경우보단 빠르지만, dispatcher servlet 까지 만들어야 하기 때문에 단위테스트보다는 느리다.
    @Autowired
    ObjectMapper objectMapper;

    @MockBean
    EventRepository eventRepository;

    @Test
    void createEvent() throws Exception {
        // 요청
        Event event = Event.builder()
                .name("Spring")
                .description("REST API")
                .beginEnrollmentDateTime(LocalDateTime.of(2020, 12, 1, 9, 00, 00))
                .closeEnrollmentDateTime(LocalDateTime.of(2020, 12, 2, 23, 00, 00))
                .beginEventDateTime(LocalDateTime.of(2020, 12, 3, 20, 30, 00))
                .endEventDateTime(LocalDateTime.of(2020, 12, 4, 23, 00, 00))
                .basePrice(1000)
                .maxPrice(5000)
                .limitOfEnrollment(50)
                .location("study")
                .build();

        event.setId(10);
        when(eventRepository.save(event)).thenReturn(event);

        mockMvc.perform(post("/api/events")
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaTypes.HAL_JSON)
                .content(objectMapper.writeValueAsString(event)))  // json 변경 -> Controller @RequestBody
                .andDo(print())
                .andExpect(status().isCreated())  // 201 상태안정
                .andExpect(jsonPath("id").exists());
    }
}
