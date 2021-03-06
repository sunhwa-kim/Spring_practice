package me.sunhwa.demorestapi.events;

import com.fasterxml.jackson.databind.ObjectMapper;
import jdk.jfr.Description;
import me.sunhwa.demorestapi.common.RestDocsConfiguration;
import me.sunhwa.demorestapi.common.TestDescription;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.restdocs.AutoConfigureRestDocs;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.hateoas.MediaTypes;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.time.LocalDateTime;

import static org.springframework.restdocs.headers.HeaderDocumentation.*;
import static org.springframework.restdocs.hypermedia.HypermediaDocumentation.linkWithRel;
import static org.springframework.restdocs.hypermedia.HypermediaDocumentation.links;
import static org.springframework.restdocs.mockmvc.MockMvcRestDocumentation.document;
import static org.springframework.restdocs.payload.PayloadDocumentation.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest  //  SpringBootTest.WebEnvironment.MOCK
@AutoConfigureMockMvc
@AutoConfigureRestDocs
@Import(RestDocsConfiguration.class)
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
                .andExpect(jsonPath("free").value(false))
                .andExpect(jsonPath("offline").value(true))
                .andExpect(jsonPath("eventStatus").value(EventStatus.DRAFT.name()))
//                .andExpect(jsonPath("_links.self").exists())  // HATEOAS link
//                .andExpect(jsonPath("_links.query-events").exists())
//                .andExpect(jsonPath("_links.update-events").exists())
                .andDo(document("create-event",
                        links(
                                linkWithRel("self").description("link to self"),
                                linkWithRel("query-events").description("link to query events"),
                                linkWithRel("update-events").description("link to update an existing"),
                                linkWithRel("profile").description("link to update an existing")
                        ),
                        requestHeaders(
                                headerWithName(HttpHeaders.ACCEPT).description("accept header"),
                                headerWithName(HttpHeaders.CONTENT_TYPE).description("content type header")
                        ),
                        requestFields(
                                fieldWithPath("name").description("Name of new event"),
                                fieldWithPath("description").description("description of new evnet"),
                                fieldWithPath("beginEnrollmentDateTime").description("date time of begin of new evnet"),
                                fieldWithPath("closeEnrollmentDateTime").description("date time of end of new evnet"),
                                fieldWithPath("beginEventDateTime").description("date time of begin of new evnet"),
                                fieldWithPath("endEventDateTime").description("date time of end of new evnet"),
                                fieldWithPath("location").description("locaiton of new evnet"),
                                fieldWithPath("basePrice").description("base price of new evnet"),
                                fieldWithPath("maxPrice").description("max price of new evnet"),
                                fieldWithPath("limitOfEnrollment").description("limit of enrollments")
                        ),
                        responseHeaders(
                                headerWithName(HttpHeaders.LOCATION).description("Location header"),
                                headerWithName(HttpHeaders.CONTENT_TYPE).description("Content type")
                        ),
//                        relaxedResponseFields(  // 문서의 일부분만 -  HAL 포맷과 links 추가 중복
                        responseFields(  // 문서의 일부분만 -  HAL 포맷과 links 추가 중복
                                fieldWithPath("id").description("identifier of new event"),
                                fieldWithPath("name").description("Name of new event"),
                                fieldWithPath("description").description("description of new evnet"),
                                fieldWithPath("beginEnrollmentDateTime").description("date time of begin of new evnet"),
                                fieldWithPath("closeEnrollmentDateTime").description("date time of end of new evnet"),
                                fieldWithPath("beginEventDateTime").description("date time of begin of new evnet"),
                                fieldWithPath("endEventDateTime").description("date time of end of new evnet"),
                                fieldWithPath("location").description("locaiton of new evnet"),
                                fieldWithPath("basePrice").description("base price of new evnet"),
                                fieldWithPath("maxPrice").description("max price of new evnet"),
                                fieldWithPath("limitOfEnrollment").description("limit of enrollments"),
                                fieldWithPath("free").description("It tells if this event is free or not"),
                                fieldWithPath("offline").description("It tells if this event is offline or not"),
                                fieldWithPath("eventStatus").description("event status"),
                                fieldWithPath("_links.self.href").description("link to self"),
                                fieldWithPath("_links.query-events.href").description("link to query event list"),
                                fieldWithPath("_links.update-events.href").description("link to update existing list"),
                                fieldWithPath("_links.profile.href").description("link to profile")
                        )
                ))
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
