package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.model.entity.OrderGroup;
import com.sh.adm.model.entity.User;
import com.sh.adm.model.enumclass.OrderType;
import com.sh.adm.model.enumclass.UserStatus;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.BDDAssertions.then;

@Slf4j
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
        User userId = userRepository.findById(1L).get();
        List<OrderGroup> userBasket = orderGroupRepository.findByUser(userId);
        log.info("order_group user >> {} ",userBasket);
        //then
        then(newOrderGroup.getUser().getId()).isEqualTo(orderGroup.getUser().getId());
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
        return User.of("test01", "pwd01", UserStatus.REGISTERED,"email@gmail.com" ,"010-1111-2222",null,LocalDateTime.now());
    }
}
