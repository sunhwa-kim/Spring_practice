package com.sh.adm.controller.api;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sh.adm.model.entity.User;
import com.sh.adm.model.enumclass.UserStatus;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.UserApiRequest;
import com.sh.adm.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.util.NestedServletException;

import javax.transaction.Transactional;

import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.LocalDateTime;

import static org.assertj.core.api.Assertions.assertThatExceptionOfType;
import static org.assertj.core.api.BDDAssertions.then;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@Transactional
@SpringBootTest
class UserApiControllerTest {

    @Autowired
    UserApiController userApiController;
    @Autowired
    UserRepository userRepository;

    @Autowired
    ObjectMapper objectMapper;

    private MockMvc mockMvc;

    @BeforeEach
    private void setup() {
        mockMvc = MockMvcBuilders.standaloneSetup(userApiController)
                .addFilter(new CharacterEncodingFilter(StandardCharsets.UTF_8.name(), true))
                .alwaysDo(print())
                .build();
    }

    @Test
    @DisplayName("회원 정보 변경")
    void update() throws Exception {
        UserApiRequest request = UserApiRequest.of(1L, "test01", "1234", UserStatus.UNREGISTERED, "email", "010-1111-1111", LocalDate.of(2000,1,1),null,null);

        mockMvc = MockMvcBuilders.standaloneSetup(userApiController).build();
        mockMvc.perform(MockMvcRequestBuilders.put("/api/user")
                .contentType(MediaType.APPLICATION_JSON)
                .characterEncoding("UTF-8")
                .content(toJsonString(request)))
//                .andDo(print())
                .andExpect(jsonPath("$.data.account").value("test01"))
                .andExpect(jsonPath("$..password").value("1234"))
                .andExpect(jsonPath("$..status").value(UserStatus.UNREGISTERED.getTitle()))
                .andExpect(jsonPath("$..email").value("email"))
                .andExpect(jsonPath("$..phoneNumber").value("010-1111-1111"));
    }

    @Test
    @DisplayName("회원명 변경 예외 확인")
    void update_account_exception() {
        String test = "notChanged";
        UserApiRequest request =  UserApiRequest.of(1L, test, "1234", UserStatus.UNREGISTERED, "email", "010-1111-1111",LocalDate.of(2000,1,1),null,null);

        mockMvc = MockMvcBuilders.standaloneSetup(userApiController).build();
        assertThatExceptionOfType(NestedServletException.class)
                .isThrownBy(
                        () -> {
                            mockMvc.perform(MockMvcRequestBuilders.put("/api/user")
                                    .contentType(MediaType.APPLICATION_JSON)
                                    .characterEncoding("UTF-8")
                                    .content(toJsonString(request)));
                        }).withMessageContaining("You can't change your Account");
    }

    @Test
    @DisplayName("회원 비밀번호 변경")
    void modify() throws Exception {
        // given
        String test = "010-modified";
        User user = User.of("test", "pwd", UserStatus.REGISTERED, "email", "phoneNumber", LocalDate.of(2000, 1, 1));
        userRepository.save(user);
        // when
        mockMvc = MockMvcBuilders.standaloneSetup(userApiController).build();
        mockMvc.perform(MockMvcRequestBuilders.patch("/api/user/change_password/1")
                .param("password", test)
                .contentType(MediaType.APPLICATION_JSON)
                .characterEncoding("UTF-8"))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.data.password").value(test));
//        then(userRepository.findById(1L).get().getPassword()).isEqualTo(test);
    }

    @Test
    @DisplayName("회원 정보 삭제")
    void deletedPerson() throws Exception {
        mockMvc = MockMvcBuilders.standaloneSetup(userApiController).build();
        mockMvc.perform(MockMvcRequestBuilders.delete("/api/user/1"))
                .andDo(print())
                .andExpect(status().isOk());
        then(userRepository.findUserDeleted().stream().anyMatch(user -> user.getId().equals(1L))).isTrue();
//        log.info("id=1 deleted : {}",userRepository.findAll());
    }

    @Test
    @DisplayName("삭제 회원 목록 조회")
    void deletedUsersTest() throws Exception {
        mockMvc = MockMvcBuilders.standaloneSetup(userApiController).build();
//        LongStream.range(0,2).forEach(i->userRepository.findAll().stream().filter(user -> user.getId()==i).map(user -> user.setDeleted(true)) );  // error
        userRepository.findById(1L).ifPresent(user -> {
            user.deledtedAccount(LocalDateTime.now(),UserStatus.UNREGISTERED,true);
        });
        userRepository.findById(2L).ifPresent(user -> {
            user.deledtedAccount(LocalDateTime.now(),UserStatus.UNREGISTERED,true);
        });

        mockMvc.perform(MockMvcRequestBuilders.get("/api/user/deleted_users"))
                .andDo(print())
                .andExpect(content().contentType("application/json"))
                .andExpect(jsonPath("data[0].account").value("test01"))
                .andExpect(jsonPath("data[1].account").value("test02"));
    }

    private String toJsonString(UserApiRequest request) throws JsonProcessingException {
        return objectMapper.writeValueAsString(Header.OK(request));
    }
}