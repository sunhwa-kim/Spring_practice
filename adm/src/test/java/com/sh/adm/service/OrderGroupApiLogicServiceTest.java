package com.sh.adm.service;

import com.sh.adm.model.entity.*;
import com.sh.adm.model.enumclass.ItemStatus;
import com.sh.adm.model.enumclass.OrderStatus;
import com.sh.adm.model.enumclass.OrderType;
import com.sh.adm.model.enumclass.UserStatus;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.request.UserApiRequest;
import com.sh.adm.repository.OrderDetailRepository;
import com.sh.adm.repository.OrderGroupRepository;
import com.sh.adm.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Slf4j
@SpringBootTest
class OrderGroupApiLogicServiceTest {

    @Autowired
    OrderGroupRepository ogRepository;
    @Autowired
    OrderDetailRepository odRepository;
    @Autowired
    UserRepository userRepository;

    @Test
    @Transactional
    void creat() {
        User user = userRepository.save(givenUser());
        Item item = givenItem(100, givenPartner(givenCategory()));
        odRepository.save(OrderDetail.createOrderDetail(item, 2));
        OrderGroupApiRequest request = givenUserInfo(null).getData();
//        OrderGroup orderGroup = OrderGroup.createOrderGroup(userRepository.getOne(request.getUserId()), odRepository.getOne(request.getOrderDetailId()));
//        log.info("장바구니 담기 >> {}",orderGroup);

    }


    private Header<OrderGroupApiRequest> givenUserInfo(Long id) {
        OrderGroupApiRequest.OrderGroupApiRequestBuilder builder = OrderGroupApiRequest.builder()
                .status(OrderStatus.ORDERING)
                .city("서울시")
                .street("100")
                .zipcode("12345")
                .receiveName("")
                .userId(1L);

        if (id != null) {
            builder.id(id);
        }
        return Header.OK(builder.build());
    }

    private User givenUser() {
        return User.of("test01", "pwd01", UserStatus.REGISTERED,"email@gmail.com" ,"010-1111-2222",null, LocalDateTime.now());
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
        String status = "REGISTERED";
        return Partner.builder()
                .name(category.getTitle())
                .status(status)
                .address("서울시 강남구 1번길 1000-100")
                .callCenter("070-1111-1111")
                .partnerNumber("010-1111-1111")
                .businessNumber("123456 2")
                .ceoName("1 대표")
                .registeredAt(LocalDateTime.now().minusMonths(2L))
                .category(category)
                .build();
    }

    private Category givenCategory() {
        return new Category("전자제품", "컴퓨터");
    }
}