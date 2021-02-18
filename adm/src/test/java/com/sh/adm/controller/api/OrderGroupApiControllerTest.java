package com.sh.adm.controller.api;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sh.adm.model.dto.Address;
import com.sh.adm.model.entity.*;
import com.sh.adm.model.enumclass.*;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.repository.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.hateoas.MediaTypes;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
class OrderGroupApiControllerTest {

    @Autowired
    MockMvc mockMvc;

    @Autowired
    ObjectMapper objectMapper;

    @Autowired
    OrderGroupRepository orderGroupRepository;
    @Autowired
    OrderDetailRepository orderDetailRepository;
    @Autowired
    UserRepository userRepository;
    @Autowired
    ItemRepository itemRepository;
    @Autowired
    PartnerRepository partnerRepository;
    @Autowired
    CategoryRepository categoryRepository;

    private BigDecimal itemPrice = new BigDecimal(900000);
    private String testCity = "서울시";

    @Test
    @DisplayName("주문 확인 조회")
    void readOrderTest() throws Exception {

        OrderGroup orderGroup = givenOrder();
        mockMvc.perform(get("/api/cart/order/{id}", orderGroup.getId())
                .contentType(MediaType.APPLICATION_JSON)
                .characterEncoding("UTF-8"))
                .andDo(print())
                .andExpect(status().isOk())  // 200
                .andExpect(jsonPath("id").exists())
                .andExpect(header().string(HttpHeaders.CONTENT_TYPE, String.valueOf(MediaTypes.HAL_JSON_VALUE)))
//                .andExpect(jsonPath().value())
        ;
    }

    private User givenUser() {
        return userRepository.save(User.of("test01", "pwd01", UserStatus.REGISTERED, "email@gmail.com", "010-1111-2222", null, LocalDateTime.now()));
    }

    private int changeName = 1;
    private Item givenItem(int quantity, Partner partner) {
        Item item = Item.builder()
                .id(1L)
                .status(ItemStatus.UNREGISTERED)
                .name("LG 노트북" + changeName++)
                .title("LG 노트북 A100")
                .content("2020년형 노트북")
                .price(BigDecimal.valueOf(900000))
                .stockQuantity(quantity)
                .brandName("LG")
                .registeredAt(LocalDateTime.now())
                .partner(partner)
                .build();
        return itemRepository.save(item);
    }

    private Partner givenPartner(Category category) {
        String status = "REGISTERED";
        Partner partner = Partner.builder()
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
        return partnerRepository.save(partner);
    }

    private Category givenCategory() {
        return categoryRepository.save(new Category("전자제품", "컴퓨터"));
    }

    private OrderDetail newOrderDetail(Item item, int orderItemCount) {
        if(item==null) return OrderDetail.createOrderDetail(givenItem(100, givenPartner(givenCategory())), orderItemCount);
        return orderDetailRepository.save(OrderDetail.createOrderDetail(item, orderItemCount));
    }

    private OrderGroup givenOrder() {
        OrderGroup orderGroup = OrderGroup.createOrderGroup(givenUser(), newOrderDetail(null, 5));
        orderGroup.setOrder(Delivery.of(Address.of("서울시", "100", "12345"), "test", orderGroup));
        orderGroup.updateOrder(requestOrderGroup(1L,testCity, OrderType.ALL, PaymentType.CARD).getData());
        return orderGroupRepository.save(orderGroup);
    }

    private Header<OrderGroupApiRequest> requestOrderGroup(Long id, String city , OrderType orderType, PaymentType paymentType) {
        OrderGroupApiRequest.OrderGroupApiRequestBuilder builder = OrderGroupApiRequest.builder()
                .status(OrderStatus.ORDERING)
                .orderType(orderType)
                .paymentType(paymentType)
                .city(city)
                .street("100")
                .zipcode("12345")
                .receiveName("test");
        if (id != null) {
            builder.id(id);
        }
        return Header.OK(builder.build());
    }
}