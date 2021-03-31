package com.sh.adm.controller.api;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sh.adm.model.entity.*;
import com.sh.adm.model.enumclass.*;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.repository.*;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.hateoas.MediaTypes;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.filter.CharacterEncodingFilter;

import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@Slf4j
@SpringBootTest
//@AutoConfigureMockMvc
class OrderGroupApiControllerTest {


    @Autowired
    ObjectMapper objectMapper;

    @Autowired
    OrderGroupApiController orderGroupApiController;

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

    private MockMvc mockMvc;
    private BigDecimal itemPrice = new BigDecimal(900000);
    private String testCity = "서울시";

    @BeforeEach
    private void setup() {
//        mockMvc = MockMvcBuilders.standaloneSetup(userApiController).build();
        mockMvc = MockMvcBuilders.standaloneSetup(orderGroupApiController)
                .addFilter(new CharacterEncodingFilter(StandardCharsets.UTF_8.name(), true))
                .alwaysDo(print())
                .build();
    }

    @DisplayName("주문 확인 조회")
    @ParameterizedTest(name="{index} {displayName}")
    @CsvSource(
            ",5,서울시,100,12345,test"
    )
    void readOrderTest(Item item, int orderCount, String city, String street, String zipcode, String receiveName) throws Exception {

        log.info("BigDecimal >> {} ",BigDecimal.valueOf(900000).multiply(BigDecimal.valueOf(5)));
        OrderGroup orderGroup = givenOrder(item,orderCount,city,street,zipcode,receiveName);
        mockMvc.perform(get("/api/cart/order/{id}", orderGroup.getId())
                .contentType(MediaType.APPLICATION_JSON)
                .characterEncoding("UTF-8"))
                .andExpect(status().isOk())  // 200
//                .andExpect(header().string(HttpHeaders.CONTENT_TYPE, String.valueOf(MediaTypes.HAL_JSON_VALUE)))
                .andExpect(content().contentType(MediaTypes.HAL_JSON_VALUE))  // 200
                .andExpect(jsonPath("$.id").exists())
                .andExpect(jsonPath("$.status").value(OrderStatus.CONFIRM.getTitle()))
                .andExpect(jsonPath("$.orderType").value(OrderType.ALL.getTitle()))
                .andExpect(jsonPath("$.receiveName").value(receiveName))
                .andExpect(jsonPath("$.revAddress").value(city+", "+street+", "+zipcode))
                .andExpect(jsonPath("$.paymentType").value(PaymentType.CARD.getTitle()))
                .andExpect(jsonPath("$.totalPrice").value(itemPrice.multiply(BigDecimal.valueOf(5)).setScale(1)))
                .andExpect(jsonPath("$.totalQuantity").value(orderCount))
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

    private OrderGroup givenOrder(Item item, int itemOrderCount, String city, String street, String zipcode, String receiveName) {
        OrderGroupApiRequest request = requestOrderGroup(null, city, OrderType.ALL, PaymentType.CARD);
        OrderGroup orderGroup = OrderGroup.createOrderGroup(givenUser(), newOrderDetail(item, itemOrderCount));
        orderGroup.createOrder(Delivery.of(request), request.getOrderType(), request.getPaymentType());
        orderGroup.updateOrder(requestOrderGroup(1L,testCity, OrderType.ALL, PaymentType.CARD));
        return orderGroupRepository.save(orderGroup);
    }

    private OrderGroupApiRequest requestOrderGroup(Long id, String city , OrderType orderType, PaymentType paymentType) {
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
        return builder.build();
    }
}