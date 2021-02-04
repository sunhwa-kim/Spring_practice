package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.model.entity.*;
import com.sh.adm.model.enumclass.ItemStatus;
import com.sh.adm.model.enumclass.OrderType;
import com.sh.adm.model.enumclass.UserStatus;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

import static org.assertj.core.api.BDDAssertions.then;

@Slf4j
public class OrderGroupRepositoryTest extends AdmApplicationTests {
    private Random random;

    @Autowired
    OrderGroupRepository orderGroupRepository;

    @Autowired
    UserRepository userRepository;

    @Test
    public void create() {
        // given
        User user = userRepository.save(givenUser());
        Category category = givenCategory();
        Partner partner = givenPartner(category);
        Item item = givenItem(100,partner);
        OrderDetail orderDetail = OrderDetail.createOrderDetail(item, 1);
        // when
        OrderGroup orderGroup = OrderGroup.createOrderGroup(user, orderDetail);
        OrderGroup newOrderGroup = orderGroupRepository.save(orderGroup);
//        log.info(" >> {}",newOrderGroup);
        //then
        then(newOrderGroup.getUser().getId()).isEqualTo(1L);
    }

    private User givenUser() {
        return User.of("test01", "pwd01", UserStatus.REGISTERED,"email@gmail.com" ,"010-1111-2222",null,LocalDateTime.now());
    }

    private Item givenItem(int quantity, Partner partner) {
        return Item.builder()
                .status(ItemStatus.UNREGISTERED)
                .name("LG 노트북")
                .title("LG 노트북 A100")
                .content("2020년형 노트북")
                .price(BigDecimal.valueOf(900000))
                .stockQuantity(quantity)
                .brandName("LG")
                .registeredAt(LocalDateTime.now())
                .partner(partner)
                .build();
    }

    private Partner givenPartner(Category category) {
        random = new Random();
        String status = "REGISTERED";
        return Partner.builder()
                .name(category.getTitle())
                .status(status)
                .address("서울시 강남구 1번길 1000-100")
                .callCenter("070-1111-1111")
                .partnerNumber("010-1111-1111")
                .businessNumber("123456 2")
                .ceoName("1 대표")
                .registeredAt(getRandomDate())
                .category(category)
                .build();
    }

    private Category givenCategory() {
        return new Category("전자제품", "컴퓨터");
    }

    private LocalDateTime getRandomDate(){
        return LocalDateTime.of(2020,getRandomNumber(),getRandomNumber(),getRandomNumber(),getRandomNumber(),getRandomNumber());
    }
    private int getRandomNumber(){
        return random.nextInt(11)+1;
    }
}
