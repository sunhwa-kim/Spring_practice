package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.model.entity.OrderGroup;
import com.sh.adm.model.entity.User;
import com.sh.adm.model.enumclass.OrderType;
import com.sh.adm.model.enumclass.UserStatus;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.BDDAssertions.then;

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
        then(newOrderGroup.getUser().getId()).isEqualTo(orderGroup.getUser().getId());
//        orderGroupRepository.findById(newOrderGroup.getId()).stream().forEach(System.out::println); // left outer join user -> inner join user
    }

    private OrderGroup givenInfo() {
        User user = givenUser();
        userRepository.save(user);
        return givenOrderGroup(user);
    }

    private OrderGroup givenOrderGroup(User user) {
        return OrderGroup.builder()
                .status("ORDERED")
                .orderType(OrderType.ALL)
                .revAddress("서울시 강남구")
                .revName("길동아파트")
                .paymentType("CARD")
                .totalPrice(BigDecimal.valueOf(2000000))
                .totalQuantity(1)
                .orderAt(LocalDateTime.now().minusDays(4))
                .arrivalDate(LocalDate.now().plusDays(1))
                .user(user)
                .build();
    }

    private User givenUser() {
        return new User("test01", "pwd01", UserStatus.REGISTERED,"email@gmail.com" ,"010-1111-2222",LocalDateTime.now());
    }
}
