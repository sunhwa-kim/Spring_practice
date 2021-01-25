package com.sh.adm.service;

import com.sh.adm.model.entity.User;
import com.sh.adm.model.enumclass.UserStatus;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.UserApiRequest;
import com.sh.adm.model.network.response.UserApiResponse;
import com.sh.adm.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
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

@Slf4j
@Transactional
@SpringBootTest
class UserApiLogicServiceTest {

    @Autowired
    UserRepository userRepository;

    @Autowired
    UserApiLogicService userApiLogicService;

    @Test
    @DisplayName("서비스 CRUD 테스트")
    void crud() {
        // given
        String test = "test100";
        Long userId;
        Header<UserApiRequest> userApiRequest = givenUserInfo(null, test,UserStatus.REGISTERED);
        // when
        Header<UserApiResponse> getUser = userApiLogicService.create(userApiRequest);

        List<User> byAccount = userRepository.findByAccount(getUser.getData().getAccount());
        
        userId = byAccount.get(0).getId();
        Header<UserApiResponse> getUserRead = userApiLogicService.read(userId);

        Header deleteOk = userApiLogicService.delete(userId);

        List<User> all = userRepository.findAll();
//        all.stream().mapToLong(User::getId).forEach(System.out::println);
        // then
        assertAll(
                () -> then(getUserRead.getData().getAccount()).isEqualTo(test),
                () -> then(deleteOk.getResultCode()).withFailMessage("삭제 성공시 헤더 메세지는 OK 입니다.").isEqualTo("OK"),
                () -> then(userRepository.findUserDeleted().stream().anyMatch(user -> user.getAccount().equals(test))).isTrue(),
                () -> then(all.get(0).getAccount()).isNotEqualTo(test)
        );
    }

    @Test
    @DisplayName("서비스 수정 테스트")
    void update_test() {
        String testAccount = "test01";
        UserStatus changed = UserStatus.UNREGISTERED;
        Header<UserApiRequest> userApiRequest = givenUserInfo(1L, testAccount, changed);
        userApiLogicService.update(userApiRequest);
        User user = userRepository.findById(1L).get();
        then(user.getAccount()).isEqualTo(testAccount);
        then(user.getStatus()).withFailMessage("변경 결과는 등록 입니다.").isEqualTo(changed);

    }

    @Test
    void 중복_계정_예외_발생() {
        Header<UserApiRequest> test01 = givenUserInfo(null, "test01", UserStatus.REGISTERED);
        String message = "이미 존재하는 계정입니다.";
        assertThatIllegalStateException().isThrownBy(() -> {
            userApiLogicService.create(test01);
        }).withMessageContaining(message);
//        try {
//            userApiLogicService.create(userApiRequest);
//        } catch (IllegalStateException e) {
//            return;
//        }
//        assertThatExceptionOfType()
//        assertThatIllegalStateException()
    }

    private Header<UserApiRequest> givenUserInfo(Long id, String account, UserStatus status) {
        UserApiRequest.UserApiRequestBuilder builder = UserApiRequest.builder()
                .account(account)
                .password("test111")
                .status(status)
                .email("goldiy@naver.com")
                .phoneNumber("010-1111-1111")
                .registeredAt(LocalDateTime.now());

        if( id != null ) builder.id(id);
        return Header.OK(builder.build());
    }
}