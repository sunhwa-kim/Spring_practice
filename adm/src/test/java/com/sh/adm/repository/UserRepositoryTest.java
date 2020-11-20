package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.entity.Users;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import javax.transaction.Transactional;
import java.time.LocalDateTime;

import static org.assertj.core.api.Assertions.assertThat;

class UserRepositoryTest extends AdmApplicationTests {
//    UserRepository userRepository = new UserRepository(); // interface는 객체 생성 X, TDD로서 No, DI개념이 중요
    //DI userRepository는 다른 클래스에서도 사용 - 컨테이너에 담아 공유 하는게 용이
    @Autowired
    UserRepository userRepository;

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
        userRepository.save(user);
        // then
        System.out.println(user.getId());  // 4L
        assertThat(user.getId()).isEqualTo(4L);  // test 번복시 +1
    }

    @Test
    public void read(){
        assertThat(userRepository.existsById(3L));
    }

    @Test
    @Transactional
    public void update(){
        userRepository.findById(3L).ifPresent(modUser -> {
            modUser.setUpdatedAt(LocalDateTime.now());
            modUser.setUpdatedBy("sh_test");
            System.out.println(modUser.getId());
            userRepository.save(modUser);
        });

    }

    @Test
    @Transactional
    public void delete(){
        Assertions.assertThat(userRepository.findById(3L));
        userRepository.findById(3L).ifPresent(users -> userRepository.delete(users));
        org.junit.jupiter.api.Assertions.assertFalse(userRepository.existsById(3L));
    }
}
