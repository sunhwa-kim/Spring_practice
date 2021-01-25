package com.sh.adm.controller.api;

import com.sh.adm.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import javax.transaction.Transactional;

import static org.assertj.core.api.BDDAssertions.then;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@Slf4j
@Transactional
@SpringBootTest
class UserApiControllerTest {

    @Autowired
    UserApiController userApiController;
    @Autowired
    UserRepository userRepository;

    private MockMvc mockMvc;

    @Test
    @DisplayName("회원 비밀번호 변경")
    void modify() throws Exception {
        String test = "010-modified";
        mockMvc = MockMvcBuilders.standaloneSetup(userApiController).build();
        mockMvc.perform(MockMvcRequestBuilders.patch("/api/user/1")
                .param("password", test))
                .andDo(print())
                .andExpect(status().isOk());
        then(userRepository.findById(1L).get().getPassword()).isEqualTo(test);
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
            user.setDeleted(true);
        });
        userRepository.findById(2L).ifPresent(user -> {
            user.setDeleted(true);
        });

        mockMvc.perform(MockMvcRequestBuilders.get("/api/user/deleted_users"))
                .andDo(print())
                .andExpect(content().contentType("application/json"))
                .andExpect(jsonPath("data[0].account").value("test01"))
                .andExpect(jsonPath("data[1].account").value("test02"));
    }


}