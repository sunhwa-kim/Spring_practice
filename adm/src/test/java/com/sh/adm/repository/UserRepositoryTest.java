package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.model.entity.User;
import com.sh.adm.model.enumclass.UserStatus;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

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
    @Rollback(value = false)
    public void create(){
        // given
        User user = givenUserInfo();
        // when
        User result = userRepository.save(user);
        Optional<User> findUser = userRepository.findById(result.getId());
        // then
        assertThat(findUser.isPresent()).isTrue();
        findUser.stream().forEach(System.out::println);
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
        test.ifPresent(user -> userRepository.delete(user));
        System.out.println(userRepository.findById(8L));  // Optional.empty -> isEmpty()로 확인 가능.
    }

    private User givenUserInfo() {
        return User.builder()
                .account("test01")
                .password("20202021")
                .status(UserStatus.UNREGISTERED)
                .email("gmail@gmail.com")
                .phoneNumber("010-2021-2021")
                .registeredAt(LocalDateTime.now().minusMonths(1L))
                .build();
    }
}
