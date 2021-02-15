package me.sunhwa.demorestapi.events;

import com.fasterxml.jackson.databind.ObjectMapper;
import jdk.jfr.Description;
import me.sunhwa.demorestapi.common.TestDescription;
import org.hamcrest.Matchers;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.hateoas.MediaTypes;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.time.LocalDateTime;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest  //  SpringBootTest.WebEnvironment.MOCK
@AutoConfigureMockMvc
public class EventControllerTest {

    @Autowired
    MockMvc mockMvc;   // mocking된 dispatcher servlet으로 가짜 요청/응답 확인 테스트
                       // web server 띄우지 않아서 그 경우보단 빠르지만, dispatcher servlet 까지 만들어야 하기 때문에 단위테스트보다는 느리다.
    @Autowired
    ObjectMapper objectMapper;

    @Test
    @Description("정상 이벤트 생성 테스트")
    void createEvent() throws Exception {
        // 요청
        EventDto event = EventDto.builder()
                .name("Spring")
                .description("REST API")
                .beginEnrollmentDateTime(LocalDateTime.of(2020, 12, 1, 9, 00, 00))
                .closeEnrollmentDateTime(LocalDateTime.of(2020, 12, 2, 23, 00, 00))
                .beginEventDateTime(LocalDateTime.of(2020, 12, 3, 20, 30, 00))
                .endEventDateTime(LocalDateTime.of(2020, 12, 4, 23, 00, 00))
                .basePrice(1000)
                .maxPrice(5000)
                .limitOfEnrollment(200)
                .location("study space")
                .build();

        mockMvc.perform(post("/api/events")
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaTypes.HAL_JSON)
                .content(objectMapper.writeValueAsString(event)))  // json 변경 -> Controller @RequestBody
                .andDo(print())
                .andExpect(status().isCreated())  // 201 상태안정
                .andExpect(jsonPath("id").exists())
                .andExpect(header().exists(HttpHeaders.LOCATION))
                .andExpect(header().string(HttpHeaders.CONTENT_TYPE, MediaTypes.HAL_JSON_VALUE))
                .andExpect(jsonPath("id").value(Matchers.not(100)))
                .andExpect(jsonPath("free").value(Matchers.not(true)))
                .andExpect(jsonPath("eventStatus").value(EventStatus.DRAFT.name()))
                ;
    }

    @Test
    @TestDescription("입력 받을수 없는 값 입력시 에러 발생 테스트")
    void createEvent_Bad_Request() throws Exception {
        // 요청
        Event event = Event.builder()
                .id(100)
                .name("Spring")
                .description("REST API")
                .beginEnrollmentDateTime(LocalDateTime.of(2020, 12, 1, 9, 00, 00))
                .closeEnrollmentDateTime(LocalDateTime.of(2020, 12, 2, 23, 00, 00))
                .beginEventDateTime(LocalDateTime.of(2020, 12, 3, 20, 30, 00))
                .endEventDateTime(LocalDateTime.of(2020, 12, 4, 23, 00, 00))
                .basePrice(1000)
                .maxPrice(5000)
                .limitOfEnrollment(200)
                .location("study space")
                .free(true)
                .offline(false)
                .eventStatus(EventStatus.PUBLISHED)
                .build();

        mockMvc.perform(post("/api/events")
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaTypes.HAL_JSON)
                .content(objectMapper.writeValueAsString(event)))  // json 변경 -> Controller @RequestBody
                .andDo(print())
                .andExpect(status().isBadRequest())  // 201 상태안정
        ;
    }

    @Test
    @TestDescription("입력값이 빈 경우 에러 발생 테스트")
    void createEvent_Bad_Request_Empty_Input() throws Exception {
        EventDto eventDto = EventDto.builder().build();

        this.mockMvc.perform(post("/api/events")
                .contentType(MediaType.APPLICATION_JSON)
                .content(this.objectMapper.writeValueAsString(eventDto)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @TestDescription("잘못된 입력값 입력시 에러 발생 테스트")
    void createEvent_Bad_Request_Wrong_Input() throws Exception {
        // 날짜 역순, 가격 범위 에러
        EventDto eventDto = EventDto.builder()
                .name("Spring")
                .description("REST API")
                .beginEnrollmentDateTime(LocalDateTime.of(2020, 12, 4, 9, 00, 00))
                .closeEnrollmentDateTime(LocalDateTime.of(2020, 12, 3, 23, 00, 00))
                .beginEventDateTime(LocalDateTime.of(2020, 12, 2, 20, 30, 00))
                .endEventDateTime(LocalDateTime.of(2020, 12, 1, 23, 00, 00))
                .basePrice(10000)
                .maxPrice(5000)
                .limitOfEnrollment(200)
                .location("study space")
                .build();

        this.mockMvc.perform(post("/api/events")
                .contentType(MediaType.APPLICATION_JSON)
                .content(this.objectMapper.writeValueAsString(eventDto)))
                .andDo(print())
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$[0].objectName").exists())
                .andExpect(jsonPath("$[0].defaultMessage").exists())
                .andExpect(jsonPath("$[0].code").exists())
        ;

    }
}
