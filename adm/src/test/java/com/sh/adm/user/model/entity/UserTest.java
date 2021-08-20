package com.sh.adm.user.model.entity;

import com.sh.adm.user.model.dto.UserApiRequest;
import com.sh.adm.user.enumclass.UserStatus;
import com.sh.adm.user.vo.Birthday;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.*;

class UserTest {

    private final String nickname = "test닉넴";
    private final String password = "pwd1234";
    private final UserStatus userStatus = UserStatus.REGISTERED;
    private final String email = "emailSH@email.com";
    private final String phoneNumber = "010-1111-2222";
    private final String birthday = "20200101";

    private User user = User.of(nickname, password, userStatus, email, phoneNumber, birthday);

    @Test
    @DisplayName("비밀번호 변경")
    void updatePasswordTest() {
        assertEquals(user.getPassword(), password);
        String testPassword = "changePasswordTest";
        user.updatePassword(testPassword);
        assertEquals(user.getPassword(),testPassword);
    }

    @Test
    @DisplayName("사용자 정보 변경 테스트")
    void userInformationUpdateTest() {
        String testChangeBirthday = "19990101";
        UserApiRequest request = new UserApiRequest();
        request.setStatus(null);
        request.setBirthday(testChangeBirthday);

        user.personalInfoUpdate(request);

        LocalDate expected = Birthday.of(testChangeBirthday).getLocalDate();
        assertNotNull(user.getStatus());
        assertEquals(user.getBirthday().getLocalDate().toString(), expected.toString());
    }

    @Test
    @DisplayName("사용자 삭제 테스트")
    void userDeletedTest() {
        // 사용자 삭제 요청 후 임시보관 한달 위해 일반 조회 대상 제거위한 필드 deleted 상태 true로 변경한다.
        user.deledtedAccount();

        assertEquals(user.getStatus(), UserStatus.UNREGISTERED);
        assertTrue(user.isDeleted());
    }

}