package com.sh.adm.service;

import com.sh.adm.model.enumclass.UserStatus;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.UserApiRequest;
import com.sh.adm.model.network.response.UserApiResponse;
import com.sh.adm.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class UserApiLogicServiceTest {

    @Autowired
    UserRepository userRepository;

    @Autowired
    UserApiLogicService userApiLogicService;

    @Test
//    @Transactional
    void createTest() {
        // given
        Header<UserApiRequest> userApiRequest = givenUserInfo(null);
        // when
        Header<UserApiResponse> result = this.userApiLogicService.create(userApiRequest);
        // then
        assertThat(result.getData().getAccount()).isEqualTo("test01");

    }

    @Test
    void readTest() {
        // when
        Header<UserApiResponse> result = this.userApiLogicService.read(1L);
        // then
        assertThat(result.getData().getAccount()).isEqualTo("test01");
    }

    @Test
    void updateTest() {
        // given
        Header<UserApiRequest> request = givenUserInfo(1L);
        request.getData().setStatus(UserStatus.REGISTERED);
        // when
        Header<UserApiResponse> response = this.userApiLogicService.update(request);
        // then
        assertThat(response.getData().getStatus()).isEqualTo(UserStatus.REGISTERED.getTitle());
    }

    @Test
    void deleteTest() {
        // given
        Long id = 1L;
        // when
        Header<UserApiResponse> response = this.userApiLogicService.delete(id);
        // then
        assertThat(response.getResultCode()).isEqualTo("OK");
    }

    private Header<UserApiRequest> givenUserInfo(Long id) {
        UserApiRequest.UserApiRequestBuilder builder = UserApiRequest.builder()
                .account("test01")
                .password("test111")
                .status(UserStatus.UNREGISTERED)
                .email("goldiy@naver.com")
                .phoneNumber("010-1111-1111")
                .registeredAt(LocalDateTime.now());

        if( id != null ) builder.id(id);

        return Header.OK(builder.build());
    }
}