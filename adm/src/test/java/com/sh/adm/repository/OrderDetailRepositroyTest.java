package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.exception.NotEnoughStockException;
import com.sh.adm.model.entity.*;
import com.sh.adm.model.enumclass.ItemStatus;
import com.sh.adm.model.enumclass.OrderType;
import com.sh.adm.model.enumclass.UserStatus;
import org.aspectj.weaver.ast.Or;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Random;

import static org.assertj.core.api.Assertions.assertThatExceptionOfType;
import static org.assertj.core.api.BDDAssertions.then;

@Transactional
public class OrderDetailRepositroyTest extends AdmApplicationTests {
    Random random;

    @Autowired
    OrderDetailRepository orderDetailRepository;
    @Autowired
    OrderGroupRepository orderGroupRepository;
     @Autowired
     UserRepository userRepository;

    @Autowired
    CategoryRepository categoryRepository;
    @Autowired
    PartnerRepository partnerRepository;
    @Autowired
    ItemRepository itemRepository;

    @Test
//    @Rollback(value = false)
    void 로직_테스트() {
        // given
        random = new Random();
        int testPrice = 90000;
        int testPrice2 = 140000;
        int item1Count = 2;
        int item2Count = 1;
        int testResult1 = testPrice * item1Count;
        int testResult2 = testPrice2 * item2Count;

        Item item1 = getItem("LG 노트북", "LG 노트북 A100", testPrice, 10);
        Item item2 = getItem("FC750R", "LEOPOLD", testPrice2, 10);
        int testItemQunatity = item1.getStockQuantity();
        // when
        User user = givenUserInfo();   // 사용자 주문
        userRepository.save(user);

        item1.outStock(item1Count);  // 제고량 update
        item2.outStock(item2Count);
        itemRepository.save(item1);
        itemRepository.save(item2);

        OrderDetail od1 = givenOrderDetail(item1Count, item1);
        od1.detailTotalPrice();       // 주문 상품별 수량별 총합 가격
        OrderDetail od2 = givenOrderDetail(item2Count, item2);
        od2.detailTotalPrice();
        List<OrderDetail> odList = new ArrayList<>();
        odList.add(od1);
        odList.add(od2);

        // -> method 수정
        OrderGroup orderGroup = givenOrderGroup(OrderType.ALL,user,odList);
        orderGroup.orderGroupTotal();
        OrderGroup og = orderGroupRepository.save(orderGroup);
        Optional<OrderGroup> byId = orderGroupRepository.findById(og.getId());
        // exclude detail's DB save

        // then
        then(item1.getStockQuantity()).isEqualTo(testItemQunatity - item1Count);
        then(byId.get().getOrderDetailList().get(0).getTotalPrice()).isEqualTo(BigDecimal.valueOf(testResult1));
        then(byId.get().getOrderDetailList().get(1).getTotalPrice()).isEqualTo(BigDecimal.valueOf(testResult2));
        then(byId.get().getOrderDetailList().get(0).getItem().getName()).isEqualTo(item1.getName());
        then(byId.get().getOrderDetailList().get(1).getItem().getName()).isEqualTo(item2.getName());
    }

    @Test
    @DisplayName("제고 품절 예외 발생")
    void outOfStockExceptionTest() {
        random = new Random();
        int testPrice = 90000;
        int itemStock = 1;
        int itemCount = 2;

        Item item = getItem("LG 노트북", "LG 노트북 A100", testPrice, itemStock);
        // when
        itemRepository.save(item);
        assertThatExceptionOfType(NotEnoughStockException.class).isThrownBy(
                () -> {OrderDetail.createOrderDetail(item,itemCount);})
        .withMessageContaining(item.getName());
    }

    private User givenUserInfo() {
        return new User("test111", "pwd1111", UserStatus.REGISTERED,"email@gmail.com" ,"010-1111-2222",LocalDateTime.now());
    }

    private OrderGroup givenOrderGroup(OrderType ot,User user,List<OrderDetail> odt) {  // odt 안넣어주면 연결X
        return OrderGroup.builder()
                .status("WATING")
                .orderType(ot)
                .revAddress("서울시")
                .revName("홍길동")
                .paymentType("CARD")
                .orderAt(LocalDateTime.now())
                .arrivalDate(LocalDate.now().plusDays(5))
                .orderAt(LocalDateTime.now().minusDays(1))
                .user(user)
                .orderDetailList(odt)
                .build();
    }

    OrderDetail givenOrderDetail(int quantity, Item item ) {
        return OrderDetail.builder()
                .status("ORDERING")  // orderType -> ALL : ORDERING , SPLIT :
                .arrivalDate(LocalDateTime.now().plusDays(2))
                .quantity(quantity)
//                .totalPrice(BigDecimal.valueOf(totalprice))
//                .orderGroup(og)
                .item(item)
                .build();
    }

    private Item getItem(String name, String title, int price, int quantity) {
        random = new Random();
        Category category = givenCategory();
        categoryRepository.save(category);
        Partner partner = givenPartner(category);
        partnerRepository.save(partner);
        return givenItem(partner,name,title,price,quantity);
    }

    private Item givenItem(Partner partner,String name,String title, int price,int quantity) {
        return Item.builder()
                .status(ItemStatus.UNREGISTERED)
                .name(name)
                .title(title)
                .content("2020년형")
                .price(BigDecimal.valueOf(price))
                .stockQuantity(quantity)
                .brandName("LG")
                .registeredAt(LocalDateTime.now())
                .partner(partner)
                .build();
    }

    private Partner givenPartner(Category category) {
//        Category category = givenCategory();
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
                .unregisteredAt(status.equals("UNREGISTERED") ? getRandomDate() : null)  // UNREGISTED -> getRandomDate()
                .category(category)
                .build();
    }

    private Category givenCategory() {
        return Category.builder()
                .type("전자제품")
                .title("컴퓨터")
                .build();
    }

    private LocalDateTime getRandomDate(){
        return LocalDateTime.of(2020,getRandomNumber(),getRandomNumber(),getRandomNumber(),getRandomNumber(),getRandomNumber());
    }
    private int getRandomNumber(){
        return random.nextInt(11)+1;
    }
}
