package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.model.entity.OrderGroup;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class OrderGroupRepositoryTest extends AdmApplicationTests {
    @Autowired
    OrderGroupRepository orderGroupRepository;

    @Test
    public void create() {
        OrderGroup orderGroup = new OrderGroup();
        orderGroup.setStatus("COMPLETED");
        orderGroup.setOrderType("ALL");   // enum타입으로 관리
        orderGroup.setRevAddress("서울시 강남구");
        orderGroup.setPaymentType("서복");
        orderGroup.setTotalPrice(BigDecimal.valueOf(900000));
        orderGroup.setTotalQuantity(1);
        orderGroup.setOrderAt(LocalDateTime.now().minusDays(2));
        orderGroup.setArrivalDate(LocalDateTime.now());   // 도착일시는 LocalDate가 적절..
        orderGroup.setCreatedAt(LocalDateTime.now());
        orderGroup.setCreatedBy("AdminServer");

        orderGroup.setUserId(2L);

        OrderGroup newOg = orderGroupRepository.save(orderGroup);
        Assertions.assertNotNull(newOg);
    }
}
