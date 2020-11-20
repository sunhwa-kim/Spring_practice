package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.entity.Users;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

class UserRepositoryTest extends AdmApplicationTests {
//    UserRepository userRepository = new UserRepository(); // interface는 객체 생성 X, TDD로서 No, DI개념이 중요
    //DI userRepository는 다른 클래스에서도 사용 - 컨테이너에 담아 공유 하는게 용이
    @Autowired
    UserRepository userRepository;

/*    @AfterEach
    public void afterEach(){
        // 콜랙 메서드 ; 각 테스트 끝날 때마다 작동  (@Transactional 로 롤백처리해서 사용X
    }*/
    
    
    @Test
    @Transactional
    public void create(){
        // given
        Users user = new Users();
//        user.setId(); // Not null 이지만  Auto Increment 주의
        user.setAccount("TestUser02");
        user.setEmail("Test02@gmail.com");
        user.setPhoneNumber("010-2222-2222");
        user.setCreatedAt(LocalDateTime.now());  // NN
        user.setCreatedBy("TestUser02");  // NN
        // when
        Users rst = userRepository.save(user);
        // then
        System.out.println(user.getId());  // 8L
        org.junit.jupiter.api.Assertions.assertEquals(user, rst);
        // static : mport static org.assertj.core.api.Assertions.assertThat;
//        assertThat(user.getId()).isEqualTo(6L);  // test 번복시 +1
    }

    @Test
    public void read(){
        assertThat(userRepository.existsById(3L));
    }

    @Test
    @Transactional
    public void update(){
        // Optional<Users> user = userRepository.findById(id);
        userRepository.findById(3L).ifPresent(modUser -> {
            // Id로 찾아가므로 수정은 X
            String test = "sh-test";
            modUser.setUpdatedAt(LocalDateTime.now());
            modUser.setUpdatedBy(test);
//            System.out.println(modUser.getId());
            userRepository.save(modUser);
            org.junit.jupiter.api.Assertions.assertEquals(modUser.getUpdatedBy(), test);
        });

    }

    @Test
    @Transactional
    public void delete(){
        Optional<Users> test = userRepository.findById(8L);
        Assertions.assertThat(test.isPresent());
        test.ifPresent(users -> userRepository.delete(users));
//        org.junit.jupiter.api.Assertions.assertFalse(userRepository.existsById(3L));
//        org.junit.jupiter.api.Assertions.assertFalse(test.isPresent());
        System.out.println(userRepository.findById(8L));  // Optional.empty -> isEmpty()로 확인 가능.
//        Assertions.assertThat(!test.isPresent());
        Assertions.assertThat(test.isEmpty());
    }
}
