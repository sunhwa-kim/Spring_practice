package com.sh.adm.service;

import com.sh.adm.model.entity.User;
import com.sh.adm.model.enumclass.UserStatus;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.UserApiRequest;
import com.sh.adm.model.network.response.UserApiResponse;
import com.sh.adm.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.assertj.core.util.Lists;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.Optional;

import static org.assertj.core.api.Assertions.*;
import static org.assertj.core.api.BDDAssertions.then;
import static org.junit.jupiter.api.Assertions.assertAll;
import static org.mockito.Mockito.*;

@Slf4j
@ExtendWith(MockitoExtension.class)
class UserApiLogicServiceTest {

    @InjectMocks
    UserApiLogicService userApiLogicService;
    @Mock
    UserRepository userRepository;

    private String test = "test01";
    private String password = "test1122";
    private UserStatus testStatus = UserStatus.REGISTERED;
    private String phontNumber = "010-1111-2222";
    private String email = "email@gmail.com";


    @Test
    @DisplayName("서비스 사용자 등록")
    void create() {
        // given
        when(userRepository.save(any(User.class))).thenReturn(testUser());
        // when
        Header<UserApiResponse> userApiResponse = userApiLogicService.create(givenUserInfo(null, test, UserStatus.REGISTERED));
        LocalDateTime testTime = userApiResponse.getData().getRegisteredAt();
        assertAll(
                () -> then(userApiResponse.getData().getAccount()).isEqualTo(test),
                () -> then(userApiResponse.getData().getPassword()).isEqualTo(password),
                () -> then(userApiResponse.getData().getStatus()).isEqualTo(testStatus.getTitle()),
                () -> then(userApiResponse.getData().getEmail()).isEqualTo(email),
                () -> then(userApiResponse.getData().getPhoneNumber()).isEqualTo(phontNumber),
                () -> then(userApiResponse.getData().getRegisteredAt()).isEqualTo(testTime)
        );

    }

    @Test
    @DisplayName("사용자 조회")
    void read() {
        when(userRepository.findById(1L)).thenReturn(Optional.of(testUser()));
        Header<UserApiResponse> userApiResponse = userApiLogicService.read(1L);
        assertAll(
                () -> then(userApiResponse.getData().getAccount()).isEqualTo(test),
                () -> then(userApiResponse.getData().getPassword()).isEqualTo(password),
                () -> then(userApiResponse.getData().getStatus()).isEqualTo(testStatus.getTitle()),
                () -> then(userApiResponse.getData().getEmail()).isEqualTo(email),
                () -> then(userApiResponse.getData().getPhoneNumber()).isEqualTo(phontNumber)
        );
    }

    @Test
    void 중복_계정_예외_발생() {

        String message = "이미 존재하는 계정입니다.";
        when(userRepository.findByAccount(test)).thenReturn(Lists.newArrayList(testUser()));
        assertThatIllegalStateException().isThrownBy(() -> {
            userApiLogicService.create(givenUserInfo(null, test, UserStatus.REGISTERED));
        }).withMessageContaining(message);
    }

    @Test
    @DisplayName("서비스 수정 테스트")
    void update_test() {
        when(userRepository.findById(1L)).thenReturn(Optional.of(testUser()));
        UserStatus changed = UserStatus.UNREGISTERED;
        Header<UserApiResponse> userApiResponse = userApiLogicService.update(givenUserInfo(1L, test, changed));
        assertAll(
                () -> then(userApiResponse.getData().getAccount()).isEqualTo(test),
                () -> then(userApiResponse.getData().getPassword()).isEqualTo(password),
                () -> then(userApiResponse.getData().getStatus()).isEqualTo(changed.getTitle()),
                () -> then(userApiResponse.getData().getEmail()).isEqualTo(email),
                () -> then(userApiResponse.getData().getPhoneNumber()).isEqualTo(phontNumber)
        );
    }

    @Test
    @DisplayName("서비스 계정명 변경 불가 예외처리")
    void update_exception_test() {
        // given
        String testAccount = "cannotChange";
        when(userRepository.findById(1L)).thenReturn(Optional.of(testUser()));

        assertThatExceptionOfType(RuntimeException.class).isThrownBy(
                () -> {
                    userApiLogicService.update(givenUserInfo(1L, testAccount, UserStatus.REGISTERED));
                }).withMessageContaining("You can't change your Account");
    }

    private User testUser() {
        return new User(test, password, testStatus, email, phontNumber);
    }

    private Header<UserApiRequest> givenUserInfo(Long id, String account, UserStatus status) {
        UserApiRequest.UserApiRequestBuilder builder = UserApiRequest.builder()
                .account(account)
                .password(password)
                .status(status)
                .email(email)
                .phoneNumber(phontNumber);

        if (id != null) builder.id(id).registeredAt(LocalDateTime.now());
        return Header.OK(builder.build());
    }

}