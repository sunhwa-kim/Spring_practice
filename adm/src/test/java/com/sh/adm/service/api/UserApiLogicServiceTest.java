package com.sh.adm.service.api;

import com.sh.adm.model.entity.User;
import com.sh.adm.model.enumclass.UserStatus;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.UserApiRequest;
import com.sh.adm.model.network.response.UserApiResponse;
import com.sh.adm.repository.UserRepository;
import com.sh.adm.service.api.UserApiLogicService;
import org.assertj.core.util.Lists;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Optional;

import static org.assertj.core.api.Assertions.*;
import static org.assertj.core.api.BDDAssertions.then;
import static org.junit.jupiter.api.Assertions.assertAll;
import static org.mockito.Mockito.*;

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
    private LocalDate birthday = LocalDate.of(2000, 1, 1);


    @Test
    @DisplayName("서비스 사용자 등록")
    void create() {
        // given
        when(userRepository.save(any(User.class))).thenReturn(testUser());
        // when
        Header<UserApiResponse> userApiResponse = userApiLogicService.create(givenUserInfo(null, test, password, testStatus));
        LocalDateTime testTime = userApiResponse.getData().getRegisteredAt();
        verify(userRepository,times(1)).save(any(User.class));
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
    @DisplayName("등록시 중복 계정명 예외 발생")
    void 중복_계정_예외_발생() {
        String message = "The account already exists";
        when(userRepository.findByAccount(test)).thenReturn(Lists.newArrayList(testUser()));
        assertThatIllegalStateException().isThrownBy(() -> {
            userApiLogicService.create(givenUserInfo(null, test, password, UserStatus.REGISTERED));
        }).withMessageContaining(message);
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
    @DisplayName("없는 사용자 조회시")
    void readNotFoundIdUser() {
        when(userRepository.findById(1L)).thenReturn(Optional.empty());
        Header<UserApiResponse> getUserApiRes = userApiLogicService.read(1L);
        assertAll(
                () -> then(getUserApiRes.getResultCode()).isEqualTo("ERROR"),
                () -> then(getUserApiRes.getDescription()).isEqualTo("The id dose not existed")
        );
    }

    @Test
    @DisplayName("수정시 없는 사용자 변경 요청")
    void validateIdNotFound() {
        when(userRepository.findById(1L)).thenReturn(Optional.empty());

        assertThatExceptionOfType(RuntimeException.class).isThrownBy(
                () -> userApiLogicService.update(givenUserInfo(1L, test, password, UserStatus.REGISTERED))
        ).withMessage("No data exist");
    }

    @Test
    @DisplayName("수정시 계정명 변경 불가")
    void validateEqualsOfAccount() {
        String testAccount = "changedAccount";
        when(userRepository.findById(1L)).thenReturn(Optional.of(testUser()));
        assertThatExceptionOfType(RuntimeException.class).isThrownBy(
                () -> userApiLogicService.update(givenUserInfo(1L, testAccount, password, UserStatus.REGISTERED))
        ).withMessage("You can't change your Account");
    }

    @Test
    @DisplayName("수정 테스트")
    void update_test() {
        when(userRepository.findById(1L)).thenReturn(Optional.of(testUser()));
        UserStatus changed = UserStatus.UNREGISTERED;
        Header<UserApiResponse> userApiResponse = userApiLogicService.update(givenUserInfo(1L, test, password, changed));
        assertAll(
                () -> then(userApiResponse.getData().getAccount()).isEqualTo(test),
                () -> then(userApiResponse.getData().getPassword()).isEqualTo(password),
                () -> then(userApiResponse.getData().getStatus()).isEqualTo(changed.getTitle()),
                () -> then(userApiResponse.getData().getEmail()).isEqualTo(email),
                () -> then(userApiResponse.getData().getPhoneNumber()).isEqualTo(phontNumber)
        );
    }

    @Test
    @DisplayName("동일 비밀번호 변경 요청시 예외 발생")
    void updateNotChangedPasswordExceptionTest() {
        when(userRepository.findById(1L)).thenReturn(Optional.of(testUser()));
        assertThatExceptionOfType(RuntimeException.class).isThrownBy(
                () -> userApiLogicService.update(1L, password)
        ).withMessage("Enter a different number");
    }

    @Test
    @DisplayName("비밀번호 변경 테스트")
    void updateChangePasswordTest() {
        String changePwd = "changePwd111";
        when(userRepository.findById(1L)).thenReturn(Optional.of(testUser()));
        Header<UserApiResponse> responseHeader = userApiLogicService.update(1L, changePwd);
        assertAll(
                () -> then(responseHeader.getData().getAccount()).isEqualTo(test),
                () -> then(responseHeader.getData().getPassword()).isEqualTo(changePwd),
                () -> then(responseHeader.getData().getStatus()).isEqualTo(testStatus.getTitle()),
                () -> then(responseHeader.getData().getEmail()).isEqualTo(email),
                () -> then(responseHeader.getData().getPhoneNumber()).isEqualTo(phontNumber)
        );
    }

    @Test
    @DisplayName("사용자 삭제")
    void deletedUser() {
        when(userRepository.findById(2L)).thenReturn(Optional.of(testUser()));
        Header delete = userApiLogicService.delete(2L);
        assertAll(
                () -> then(userRepository.findById(2L).get().getStatus()).isEqualTo(UserStatus.UNREGISTERED),
                () -> then(userRepository.findById(2L).get().isDeleted()).isTrue()
        );
    }

    private User testUser() {
        return User.of(test, password, testStatus, email, phontNumber,null);
    }

    private Header<UserApiRequest> givenUserInfo(Long id, String account, String pwd,UserStatus status) {
        return Header.OK(UserApiRequest.of(id, account, pwd, status, email, phontNumber, birthday,null,null));
    }

}