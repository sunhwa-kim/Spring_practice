package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.model.entity.*;
import com.sh.adm.model.enumclass.ItemStatus;
import com.sh.adm.model.enumclass.UserStatus;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Random;


@Slf4j
public class OrderGroupRepositoryTest extends AdmApplicationTests {
    private Random random;

    @Autowired
    OrderGroupRepository orderGroupRepository;

    @Autowired
    UserRepository userRepository;

    @Test
    @Transactional
    @DisplayName("사장자 장바구니 생성")
    void createWhenInitializeOrderGroup() {
        /*
        사용자 가입 후 장바구니 등록 위한 첫 OrderGroup
         OrderDetail에 order_group_id
         */
        // given
        User user = userRepository.save(givenUser());
        Category category = givenCategory();
        Partner partner = givenPartner(category);
        Item item = givenItem(100, partner);
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
