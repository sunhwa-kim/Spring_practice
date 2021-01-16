package com.sh.adm.service;

import com.sh.adm.model.entity.User;
import com.sh.adm.model.enumclass.UserStatus;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.UserApiRequest;
import com.sh.adm.model.network.response.UserApiResponse;
import com.sh.adm.repository.UserRepository;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.stream.Stream;

import static org.assertj.core.api.Assertions.*;
import static org.assertj.core.api.BDDAssertions.then;

@Transactional(readOnly = true)
@SpringBootTest
class UserApiLogicServiceTest {

    @Autowired
    UserRepository userRepository;

    @Autowired
    UserApiLogicService userApiLogicService;

    Long testId = 1016L;

    @Test
    @Transactional
    @Rollback(value = false)
    void ceatAndReadTest() {
        String test = "test01";
        // given
        Header<UserApiRequest> userApiRequest = givenUserInfo(null);
        // when
        this.userApiLogicService.create(userApiRequest);
        // then
        Header<UserApiResponse> result = this.userApiLogicService.read(1L);
        then(result.getData().getAccount()).isEqualTo(test);
    }

    @Test
    @Transactional
    @Rollback(value = false)
    void 중복_계정_예외_발생() {
        Header<UserApiRequest> userApiRequest = givenUserInfo(null);
        String message = "이미 존재하는 계정입니다.";
//            userApiLogicService.create(userApiRequest);
        assertThatIllegalStateException().isThrownBy(() -> {
            userApiLogicService.create(userApiRequest);
        }).withMessage(message).withNoCause();
//        try {
//            userApiLogicService.create(userApiRequest);
//        } catch (IllegalStateException e) {
//            return;
//        }
//        assertThatExceptionOfType()
//        assertThatIllegalStateException()
    }

    @Test
    void updateTest() {
        // given
        Header<UserApiRequest> request = givenUserInfo(testId);
        request.getData().setStatus(UserStatus.REGISTERED);
        // when
        this.userApiLogicService.update(request);
        // then
        Header<UserApiResponse> getTest = this.userApiLogicService.read(testId);
        then(getTest.getData().getStatus()).isEqualTo(UserStatus.REGISTERED.getTitle());
    }

    @Test
    void deleteTest() {
        // given
        then(userRepository.findById(testId).isPresent()).isTrue();
        // when
        Header<UserApiResponse> response = this.userApiLogicService.delete(testId);
        // then
        then(userRepository.findById(testId).isPresent()).isFalse();
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