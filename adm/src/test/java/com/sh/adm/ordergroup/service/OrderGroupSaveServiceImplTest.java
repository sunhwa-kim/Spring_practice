package com.sh.adm.ordergroup.service;

import com.sh.adm.FindSlowTestExtension;
import com.sh.adm.deliverry.entity.Delivery;
import com.sh.adm.deliverry.enumclass.DeliveryStatus;
import com.sh.adm.deliverry.repository.DeliveryRepository;
import com.sh.adm.ordergroup.exception.OrderGroupNotFoundException;
import com.sh.adm.item.entity.Item;
import com.sh.adm.item.enumclass.ItemStatus;
import com.sh.adm.orderdetail.entity.OrderDetail;
import com.sh.adm.orderdetail.repository.OrderDetailRepository;
import com.sh.adm.ordergroup.model.entity.OrderGroup;
import com.sh.adm.ordergroup.enumclass.OrderStatus;
import com.sh.adm.ordergroup.enumclass.OrderType;
import com.sh.adm.ordergroup.enumclass.PaymentType;
import com.sh.adm.ordergroup.repository.OrderGroupRepository;
import com.sh.adm.partner.entity.Partner;
import com.sh.adm.ifs.discount.DiscountPolicy;
import com.sh.adm.user.vo.Address;
import com.sh.adm.ordergroup.model.dto.OrderGroupApiRequest;
import com.sh.adm.ordergroup.model.dto.OrderGroupApiResponse;
import com.sh.adm.user.service.UserService;
import com.sh.adm.user.model.entity.User;
import lombok.extern.slf4j.Slf4j;
import org.assertj.core.util.Lists;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.api.extension.RegisterExtension;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Stream;

import static org.assertj.core.api.Assertions.assertThatExceptionOfType;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.*;

@Slf4j
@ExtendWith({MockitoExtension.class})
class OrderGroupSaveServiceImplTest {

    @InjectMocks
    OrderGroupSaveServiceImpl orderGroupSaveService;
    @Mock
    OrderGroupRepository orderGroupRepository;
    @Mock
    OrderDetailRepository orderDetailRepository;

    @Mock
    DeliveryRepository deliveryRepository;
    @Mock
    UserService userService;

    @Mock
    DiscountPolicy discountPolicy;

    @Captor
    ArgumentCaptor<Delivery> deliveryArgumentCaptor;

    @RegisterExtension
    static FindSlowTestExtension findSlowTestExtension = new FindSlowTestExtension(1000L);

    private BigDecimal itemPrice = BigDecimal.valueOf(10000);


    @Test
    @DisplayName("주문 테스트")
    void orderTest() {
        // given
        int orderCount = 5;
        OrderDetail orderDetail = givenOrderDetail(orderCount);
        OrderGroup orderGroup = givenOrderGroup(null, orderDetail);
        OrderGroupApiRequest request = givenOrderGroupRequest(orderCount);
        BigDecimal orderTotalPrice = orderDetail.getTotalPrice().divide(BigDecimal.TEN);
        BigDecimal discountedTotalPrice = orderDetail.getTotalPrice().subtract(orderTotalPrice);

        // when
        when(orderGroupRepository.findById(any()))
                .thenReturn(Optional.of(orderGroup))
                .thenThrow(new OrderGroupNotFoundException());
        when(orderDetailRepository.findByOrderGroupId(anyLong())).thenReturn(Lists.newArrayList(orderDetail));
        when(discountPolicy.discount(orderGroup.getUser(), orderDetail.getTotalPrice()))
                .thenReturn(orderTotalPrice);

        // then
        OrderGroupApiResponse response = orderGroupSaveService.order(request);
        Address address = Address.of(request.getCity(), request.getStreet(), request.getZipcode());
        verify(userService, times(1)).point(any(User.class), eq(discountedTotalPrice));
        verify(deliveryRepository, times(1)).save(deliveryArgumentCaptor.capture());
        assertAll(
                () -> assertEquals(deliveryArgumentCaptor.getValue().getReceiveAddress(), address,"배송지 확인"),
                () -> assertEquals(deliveryArgumentCaptor.getValue().getDeliveryStatus(), DeliveryStatus.READY,"주문 신청 직후 배송 상태 확인"),
                () -> assertEquals(orderGroup.getTotalPrice(), response.getTotalPrice(),"주문 가격 총합 확인"),
                () -> assertEquals(orderGroup.getTotalQuantity(), response.getTotalQuantity(),"주문 총량 확인"),
                () -> assertTrue(response.getOrderDetailListName().contains(orderDetail.getItem().getName()),"주문목록 제목 확인")
        );
        assertThrows(OrderGroupNotFoundException.class, () ->
            orderGroupRepository.findById(any()),
                "주문시 장바구니 정보 없어 예외 발생, orderGroupRepository.find >> empty"
        );
    }

    @Test
    @DisplayName("주문시 장바구니 정보 없을시 예외 발생 테스트")
    void orderGroupNotFoundExceptionWhenOrderTest() {
        // given
        int orderCount = 5;
        OrderGroupApiRequest request = givenOrderGroupRequest(orderCount);
        // when
        when(orderGroupRepository.findById(1L)).thenReturn(Optional.empty());
        // then
        assertThatExceptionOfType(OrderGroupNotFoundException.class)
                .isThrownBy(() -> {
                    orderGroupSaveService.order(request);
                })
                .withMessage("장바구니에 상품이 없습니다.");
    }

    @Test
    @DisplayName("주문시 잘못된 요청 데이터 예외 발생 테스트")
    void runtimeExceptionWhenOrderTest() {
        // given
        int orderCount = 5;
        OrderDetail orderDetail = givenOrderDetail(orderCount);
        OrderGroup orderGroup = givenOrderGroup(null, orderDetail);
        OrderGroupApiRequest request = OrderGroupApiRequest.builder()
                .id(1L)
                .totalPrice(itemPrice)
                .totalQuantity(1)
                .build();
        // when
        when(orderGroupRepository.findById(1L)).thenReturn(Optional.of(orderGroup));
        when(orderDetailRepository.findByOrderGroupId(1L)).thenReturn(Lists.newArrayList(orderDetail));
        // then
        assertThatExceptionOfType(RuntimeException.class)
                .isThrownBy(() -> {
                    orderGroupSaveService.order(request);
                });
    }

    @ParameterizedTest(name="{index}")
    @DisplayName("주문 후 주소/수신자명 변경 테스트")
    @MethodSource("paramsProvider")
    void modifyOrderTest(String city, String street, String zipcode, String changeReceiveName) {
        // given
        String beforeAddress = "서울시" + ", " + "100" + ", " + "12345";
        String beforeReceiveName = "sunhwa";
        String afterAddress = city+", "+street+", "+zipcode;

        OrderDetail orderDetail = givenOrderDetail(5);
        OrderGroup orderGroup = givenOrderGroup(null, orderDetail);
        // 주문
        when(discountPolicy.discount(orderGroup.getUser(), orderDetail.getTotalPrice()))
                .thenReturn(BigDecimal.ZERO);  // User.Grade = BRONZE, rate of discount = 0;
        orderGroup.createOrder(Delivery.of(givenOrderGroupRequest(5)), OrderType.ALL, PaymentType.BANK_TRANSFER); // 서울시, 100, 12345
            // 주소 변경 요청
        OrderGroupApiRequest request = OrderGroupApiRequest.builder()
                .id(1L)
                .receiveName(changeReceiveName)
                .city(city)
                .street(street)
                .zipcode(zipcode)
                .build();
        // when
        when(orderGroupRepository.findById(any()))
                .thenReturn(Optional.of(orderGroup))
                .thenThrow(new OrderGroupNotFoundException());
        OrderGroupApiResponse response = orderGroupSaveService.modifyOrder(request).get();
        // then
        assertAll(
                () -> assertNotEquals(beforeAddress, response.getRevAddress(), "변경 후 주소는 달라야 합니다."),
                () -> assertNotEquals(beforeReceiveName, response.getReceiveName(), "변경 후 수신자명이 달라야 합니다."),
                () -> assertEquals(afterAddress, response.getRevAddress(), "변경 후 주소 확인"),
                () -> assertEquals(changeReceiveName, response.getReceiveName(), "변경 후 수신자명 확인")
        );
        assertThrows(OrderGroupNotFoundException.class, () ->
            orderGroupRepository.findById(any()),
                "주문 후 주소/수신자명 변경 위해 주문했던 장바구니 정보 없어 예외 발생, orderGroupRepository.find >> empty"
        );
    }

    @Test
    @DisplayName("주문 취소/예외 테스트")
    void cancelOrderTest() {
        OrderDetail orderDetail = givenOrderDetail(5);
        OrderGroup orderGroup = givenOrderGroup(null,orderDetail);
        when(discountPolicy.discount(orderGroup.getUser(), orderDetail.getTotalPrice()))
                .thenReturn(BigDecimal.ZERO);
        orderGroup.createOrder(Delivery.of(givenOrderGroupRequest(5)), OrderType.ALL, PaymentType.BANK_TRANSFER); // 서울시, 100, 12345
        when(orderGroupRepository.findById(any()))
                .thenReturn(Optional.of(orderGroup))
                .thenThrow(new OrderGroupNotFoundException());

        orderGroupSaveService.cancelOrder(any());

        verify(orderGroupRepository, times(1)).deleteById(any());
        assertThrows(OrderGroupNotFoundException.class, () ->{
            orderGroupRepository.findById(any());
        });
    }


    // Request data


    private OrderGroupApiRequest givenOrderGroupRequest(int count) {
        return OrderGroupApiRequest.builder()
                .id(1L)
                .status(OrderStatus.ORDERING)
                .orderType(OrderType.ALL)
                .paymentType(PaymentType.CARD)
                .totalPrice(itemPrice.multiply(BigDecimal.valueOf(count)))
                .totalQuantity(count)
                .city("서울시")
                .street("100")
                .zipcode("12345")
                .receiveName("sunhwa")
                .build();
    }

    // Entity
    private Item givenItem(int quantity, Partner partner) {
        return Item.builder()
                .id(1L)
                .status(ItemStatus.REGISTERED)
                .name("LG 노트북")
                .title("LG 노트북 A100")
                .content("2020년형 노트북")
                .price(itemPrice)
                .stockQuantity(quantity)
                .brandName("LG")
                .registeredAt(LocalDateTime.now())
                .partner(partner)
                .build();
    }

    private OrderDetail givenOrderDetail(int orderItemCount) {
        Partner mockPartner = mock(Partner.class);
        return  OrderDetail.createOrderDetail(givenItem(100, mockPartner), orderItemCount);
    }

    private OrderGroup givenOrderGroup(User user, OrderDetail orderDetail) {
        if(user==null) user = mock(User.class);
        OrderGroup orderGroup = OrderGroup.createOrderGroup(user, orderDetail);
        return orderGroup;
    }

    private static Stream<Arguments> paramsProvider() {
        return Stream.of(
                Arguments.arguments("경기도","200","11111","testName"),
                Arguments.arguments("제주시","700","22222","testJeju")
        );
    }
}