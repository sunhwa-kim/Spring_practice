package com.sh.adm.service;

import com.sh.adm.model.entity.User;
import com.sh.adm.model.enumclass.UserStatus;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.UserApiRequest;
import com.sh.adm.model.network.response.UserApiResponse;
import com.sh.adm.repository.UserRepository;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.swing.text.html.parser.Entity;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Stream;

import static org.assertj.core.api.Assertions.*;
import static org.assertj.core.api.BDDAssertions.then;
import static org.junit.jupiter.api.Assertions.assertAll;

@Transactional
@SpringBootTest
class UserApiLogicServiceTest {

    @Autowired
    UserRepository userRepository;

    @Autowired
    UserApiLogicService userApiLogicService;

    Header<UserApiRequest> userApiRequest;
    @BeforeEach
    public void beforeAll() {
        userApiRequest = givenUserInfo(null);
        userApiLogicService.create(userApiRequest);
    }

    @Test
    void crud() {
        String test = "test02";
        // given
        Long userId;
        UserStatus testStatus = UserStatus.REGISTERED;
        // when
        List<User> byAccount = userRepository.findByAccount(userApiRequest.getData().getAccount());
        userId = byAccount.get(0).getId();
        Header<UserApiResponse> getUserRead = userApiLogicService.read(userId);
        userApiRequest.getData().setId(userId);
        userApiRequest.getData().setStatus(testStatus);
        Header<UserApiResponse> getUserUpdate = userApiLogicService.update(userApiRequest);
        Header deleteOk = userApiLogicService.delete(userId);
        // then
        assertAll(
                () -> then(getUserRead.getData().getStatus()).withFailMessage("변경 전 해지 상태 확인합니다.").isEqualTo(UserStatus.UNREGISTERED.getTitle()),
                () -> then(getUserRead.getData().getAccount()).isEqualTo(test),
                () -> then(getUserUpdate.getData().getStatus()).withFailMessage("변경 결과는 등록 입니다.").isEqualTo(testStatus.getTitle()),
                () -> then(deleteOk.getResultCode()).withFailMessage("삭제 성공시 헤더 메세지는 OK 입니다.").isEqualTo("OK")
        );
    }

    @Test
    void 중복_계정_예외_발생() {
//        Header<UserApiRequest> userApiRequest = givenUserInfo(null);
        String message = "이미 존재하는 계정입니다.";
//            userApiLogicService.create(userApiRequest);
        assertThatIllegalStateException().isThrownBy(() -> {
            userApiLogicService.create(userApiRequest);
        }).withMessageContaining(message);
//        try {
//            userApiLogicService.create(userApiRequest);
//        } catch (IllegalStateException e) {
//            return;
//        }
//        assertThatExceptionOfType()
//        assertThatIllegalStateException()
    }

    private Header<UserApiRequest> givenUserInfo(Long id) {
        UserApiRequest.UserApiRequestBuilder builder = UserApiRequest.builder()
                .account("test02")
                .password("test111")
                .status(UserStatus.UNREGISTERED)
                .email("goldiy@naver.com")
                .phoneNumber("010-1111-1111")
                .registeredAt(LocalDateTime.now());

        if( id != null ) builder.id(id);

        return Header.OK(builder.build());
    }
}