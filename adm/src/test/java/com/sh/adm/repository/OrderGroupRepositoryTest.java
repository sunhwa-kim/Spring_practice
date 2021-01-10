package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.model.entity.OrderGroup;
import com.sh.adm.model.entity.User;
import com.sh.adm.model.enumclass.OrderType;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

public class OrderGroupRepositoryTest extends AdmApplicationTests {
    @Autowired
    OrderGroupRepository orderGroupRepository;

    @Autowired
    UserRepository userRepository;

    @Test
    public void create() {
        // given
        OrderGroup orderGroup = givenInfo();
        // when
        OrderGroup newOrderGroup = orderGroupRepository.save(orderGroup);
        //then
        assertThat(newOrderGroup.getUser().getId()).isEqualTo(orderGroup.getUser().getId());
        orderGroupRepository.findById(newOrderGroup.getId()).stream().forEach(System.out::println); // left outer join user -> inner join user
    }

    // user 별  주문 조회
    // 주문 전체 조회

    private OrderGroup givenInfo() {
        Optional<User> user = userRepository.findById(1L);
        return OrderGroup.builder()
                .status("ORDERED")
                .orderType(OrderType.ALL)
                .revAddress("서울시 강남구")
                .revName("홍길동")
                .paymentType("CARD")
                .totalPrice(BigDecimal.valueOf(2000000))
                .totalQuantity(1)
                .orderAt(LocalDateTime.now().minusDays(4))
                .arrivalDate(LocalDateTime.now().plusDays(1))
                .user(user.get())
                .build();
    }
}
