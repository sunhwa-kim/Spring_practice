package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.model.entity.User;
import com.sh.adm.model.enumclass.UserStatus;
import com.sh.adm.model.network.request.UserApiRequest;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.*;
import static org.assertj.core.api.BDDAssertions.then;
import static org.junit.jupiter.api.Assertions.assertAll;

@Slf4j
@Transactional
class UserRepositoryTest extends AdmApplicationTests {
//    UserRepository userRepository = new UserRepository(); // interface는 객체 생성 X, TDD로서 No, DI개념이 중요
    //DI userRepository는 다른 클래스에서도 사용 - 컨테이너에 담아 공유 하는게 용이
    @Autowired
    UserRepository userRepository;
    @Autowired
    EntityManager em;

    @Test
//    @Rollback(value = false)
    void create(){
        // given
        LocalDateTime rigisterTime = LocalDateTime.now();
        User user = new User("test100", "010-1111-1111", UserStatus.REGISTERED, "email@gmail.com", "010-1000-1000", rigisterTime);
        // when
        User result = userRepository.save(user);
        List<User> findUser = userRepository.findByAccount(user.getAccount());
        log.info("user test >> {}",findUser);
        // then
        em.flush();
        then(findUser.size()).isEqualTo(1);

//        assertThat(findUser.stream().count())
//        findUser.stream().forEach(System.out::println);
    }



    @Test
    void 사용자_계정_중복_확인() {
        String account = "test01";
        String message = "이미 존재하는 계정입니다.";
        long userCount = userRepository.findByAccount(account).size();
        if (userCount > 0) {
            assertThatThrownBy(() -> {
                throw new IllegalStateException(message);
            }).isInstanceOf(IllegalStateException.class)
                    .hasMessageContaining(message);
        };
    }

    @Test
    void update(){
        User user = new User("test100", "010-1111-1111", UserStatus.REGISTERED, "email@gmail.com", "010-1000-1000", LocalDateTime.now());
        // when
        User result = userRepository.save(user);
        userRepository.findById(4L).ifPresent(modUser -> {

            modUser.userUpdate(request());
//            modUser.updatedDateAndBy(LocalDateTime.now(), test);
//            then(modUser.getUpdatedBy()).isEqualTo(test);
        });

        Optional<User> byId = userRepository.findById(4L);
        log.info(" user >> {}", user);
        log.info("update user >> {}",byId);
    }

    @Test
    @Transactional
    void delete(){
        LocalDateTime testTime = LocalDateTime.now();
        userRepository.findById(3L)
                .map(user -> {
                    user.deledtedAccount(LocalDateTime.now(), UserStatus.UNREGISTERED, true);
                    return user;
                }).orElseThrow(()-> new RuntimeException("test 중 에러"));
        then(userRepository.findByAccount("test03").size()).isEqualTo(0);
    }

    @Test
    void findUsersDeleted() {
        LocalDateTime testTime = LocalDateTime.now();
        userRepository.findById(1L).ifPresent(user -> user.deledtedAccount(testTime,UserStatus.UNREGISTERED,true));
        List<User> userDeleted = userRepository.findUserDeleted();   // where ( user0_.deleted = 0) and user0_.deleted=1 -> nativeQuery
//        log.info("deleted -> {} ", userDeleted);
        assertAll(
                () -> then(userDeleted.size()).withFailMessage("조회 결과 1").isEqualTo(1),
                () -> then(userDeleted.get(0).getId()).withFailMessage("id=1 삭제목록 확인 합니다.").isEqualTo(1L),
                () -> then(userDeleted.get(0).getAccount()).withFailMessage("test01 확인 합니다.").isEqualTo("test01"),
                () -> then(userDeleted.get(0).getAccount()).withFailMessage("다른 이름 확인").isNotEqualTo("NoThisName"),
                () -> then(userDeleted.get(0).getUnregisteredAt()).withFailMessage("해지 날짜, 시간 확인합니다.").isEqualTo(testTime),
                () -> then(userDeleted.get(0).getStatus()).withFailMessage("UNREGISTERD 확인 합니다.").isEqualTo(UserStatus.UNREGISTERED)
        );
    }


    void ex(){
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

    private UserApiRequest request() {
        return UserApiRequest.of(null, "test01", "change test", null, "email@gmail.com", null, null, null, null);
    }
}
