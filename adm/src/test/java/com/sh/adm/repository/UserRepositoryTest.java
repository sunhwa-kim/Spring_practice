package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.user.vo.Birthday;
import com.sh.adm.user.entity.User;
import com.sh.adm.user.enumclass.UserStatus;
import com.sh.adm.user.dto.UserApiRequest;
import com.sh.adm.user.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import javax.transaction.Transactional;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import static org.assertj.core.api.Assertions.*;
import static org.assertj.core.api.BDDAssertions.then;
import static org.junit.jupiter.api.Assertions.assertAll;

@Slf4j
@Transactional
class UserRepositoryTest extends AdmApplicationTests {
    //    UserRepository userRepository = new UserRepository(); // interface는 객체 생성 X, TDD로서 No, DI개념이 중요
    //DI userRepository는 다른 클래스에서도 사용 - 컨테이너에 담아 공유
    @Autowired
    UserRepository userRepository;

    private String account = "test100";
    private String password = "pwd1111";
    private UserStatus status = UserStatus.REGISTERED;
    private String email = "email@gmail.com";
    private String phoneNumber = "010-1000-1000";

    @Test
    void read(){
        // given
        userRepository.save(createUser());

        // when
        List<User> findUser = userRepository.findByAccount(account);
        log.info("user test >> {}",findUser);
        // then
        assertAll(
                () -> then(findUser.size()).isEqualTo(1),
                () -> then(findUser.get(0).getAccount()).isEqualTo(account),
                () -> then(findUser.get(0).getPassword()).isEqualTo(password),
                () -> then(findUser.get(0).getStatus()).isEqualTo(status),
                () -> then(findUser.get(0).getEmail()).isEqualTo(email),
                () -> then(findUser.get(0).getPhoneNumber()).isEqualTo(phoneNumber),
                () -> then(findUser.get(0).isDeleted()).isFalse()
        );
    }

    @Test
    void 사용자_계정_중복_확인() {
        // given
        String message = "이미 존재하는 계정입니다.";
        // when
        long userCount = userRepository.findByAccount(account).size();

        //then
        if (userCount > 0) {
            assertThatThrownBy(() -> {
                throw new IllegalStateException(message);
            }).isInstanceOf(IllegalStateException.class)
                    .hasMessageContaining(message);
        };
    }

    @Test
    void update(){
        // given
        userRepository.save(createUser());
        // when
        /*
          never changed info : account (Same as Login ID)
          recognizing individual information can't update normally : password, email, phoneNumber
         */
        userRepository.findById(1L).ifPresent(modUser -> {
            modUser.personalInfoUpdate(
                    UserApiRequest.of(null,null,"notChanged",null,"Don'tChange@gmail.com","can'tChange", LocalDate.of(2000,1,1),null,null));
        });

        userRepository.findById(1L).ifPresent(user -> {
            assertAll(
                    () -> then(user.getAccount()).isNotEmpty(),
                    () -> then(user.getAccount()).isEqualTo(account),
                    () -> then(user.getPassword()).isEqualTo(password),
                    () -> then(user.getStatus()).isEqualTo(status),
                    () -> then(user.getEmail()).isEqualTo(email),
                    () -> then(user.getPhoneNumber()).isEqualTo(phoneNumber),
                    () -> then(user.getBirthday()).isEqualTo(Birthday.of(LocalDate.of(2000,1,1))),
                    () -> then(user.isDeleted()).isFalse()
            );
        });

//        log.info(" user >> {}", createUser());
//        log.info("update user >> {}",getUser);

    }

    @Test
    @DisplayName("삭제 및 삭제목록 확인")
    @Transactional
    void delete(){
        userRepository.save(createUser());

        LocalDateTime testTime = LocalDateTime.now();
        userRepository.findById(1L)
                .map(user -> {
                    user.deledtedAccount();
                    return user;
                }).orElseThrow(()-> new RuntimeException("UserRepositoryTest - delete test 중 에러"));
        then(userRepository.findByAccount(account).size()).isEqualTo(0);

        List<User> userDeleted = userRepository.findUserDeleted();
        assertAll(
                () -> then(userDeleted.size()).withFailMessage("조회 결과 1").isEqualTo(1),
                () -> then(userDeleted.get(0).getId()).withFailMessage("id=1 삭제목록 확인 합니다.").isEqualTo(1L),
                () -> then(userDeleted.get(0).getAccount()).withFailMessage("test01 확인 합니다.").isEqualTo(account),
                () -> then(userDeleted.get(0).getAccount()).withFailMessage("다른 이름 확인").isNotEqualTo("NoThisName"),
                () -> then(userDeleted.get(0).getUnregisteredAt()).withFailMessage("해지 날짜, 시간 확인합니다.").isEqualTo(testTime),
                () -> then(userDeleted.get(0).getStatus()).withFailMessage("UNREGISTERD 확인 합니다.").isEqualTo(UserStatus.UNREGISTERED)
        );
    }

    @Test
    @Transactional
    @DisplayName("생일 월별 조회")
    void findMonthOfBithday() {
        User user1 = User.of("test2", "1234pwd", UserStatus.REGISTERED, "email", "phone", LocalDate.of(1900, 8, 8));
        User user2 = User.of("test3", "1234pwd", UserStatus.REGISTERED, "email", "phone", LocalDate.of(1800, 1, 20));

        userRepository.save(createUser());
        userRepository.save(user1);
        userRepository.save(user2);

        then(userRepository.findByMonthOfBirthday(2)).isEmpty();
        then(userRepository.findByMonthOfBirthday(1).size()).isEqualTo(2);
    }

    private User createUser() {
        return User.of(account, password, status, email, phoneNumber,LocalDate.of(2000,1,1));
    }
}
