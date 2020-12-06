package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.model.entity.User;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.Optional;

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
//    @Transactional
    public void create(){
        // given
        String account = "Test02";
        String pwd = "1234567890";
        String status = "UNREGISTERED";
        String email = "Test02@gmail.com";
        String phoneNumber = "010-2222-2222";
        LocalDateTime registeredAt = LocalDateTime.now();
        LocalDateTime createdAt = LocalDateTime.now();
        String createdBy = "SunHwaKim";

        User user = new User();
        user.setAccount(account);
        user.setPassword(pwd);
        user.setStatus(status);
        user.setEmail(email);
        user.setPhoneNumber(phoneNumber);
        user.setRegisteredAt(registeredAt);
//        user.setCreatedAt(createdAt);
//        user.setCreatedBy(createdBy);

        // when
        User rst = userRepository.save(user);
        // then
        Assertions.assertNotNull(rst);

        // static : mport static org.assertj.core.api.Assertions.assertThat;
//        assertThat(user.getId()).isEqualTo(6L);  // test 번복시 +1
    }

    @Test
    @Transactional   //could not initialize proxy - no Session 에러 처리
    public void read(){
        String phoneNumber = "010-2222-2222";
        userRepository.findFirstByPhoneNumberOrderByIdDesc(phoneNumber)
                .ifPresent(user -> {
                    System.out.println("---- 사용자 주문 내역 ----");
                    user.getOrderGroupList().forEach(orderGroup -> {
                        System.out.println("수령인(주문타입) : "+orderGroup.getRevName()+"("+orderGroup.getOrderType()+")");
                        System.out.println("주문날짜/도착예정일 :"+"["+orderGroup.getOrderAt()+"/"+orderGroup.getArrivalDate()+"]");
                        System.out.println("수령지 : "+orderGroup.getRevAddress());
                        System.out.println("총금액 : "+orderGroup.getTotalPrice());
                        System.out.println("총수량 : "+orderGroup.getTotalQuantity());

                        System.out.println("---- 주문 상세 ----");
                        orderGroup.getOrderDetailList().forEach(orderDetail -> {
                            System.out.println("주문 상태 : "+orderDetail.getStatus());
                            System.out.println("도착예상일자 : "+ orderDetail.getArrivalDate());

                            System.out.println("주문 아이템 : "+orderDetail.getItem().getName());
                            
                            System.out.println("파트너사 : "+orderDetail.getItem().getPartner().getName());
                            System.out.println("파트너사 카테고리 : "+orderDetail.getItem().getPartner().getCategory().getTitle());

                        });
                    });
                });




//        String status = "UNREGISTERED";
//        User user = userRepository.findFirstByStatusOrderByIdDesc(status);
//        Assertions.assertEquals(user.getStatus(), status);

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
        Optional<User> test = userRepository.findById(8L);
//        Assertions.assertThat(test.isPresent());
        test.ifPresent(user -> userRepository.delete(user));
//        org.junit.jupiter.api.Assertions.assertFalse(userRepository.existsById(3L));
//        org.junit.jupiter.api.Assertions.assertFalse(test.isPresent());
        System.out.println(userRepository.findById(8L));  // Optional.empty -> isEmpty()로 확인 가능.
//        Assertions.assertThat(!test.isPresent());
//        Assertions.assertThat(test.isEmpty());
    }
}
