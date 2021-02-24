package com.sh.adm.service.ordergroup;

import com.sh.adm.exception.ItemNotFoundException;
import com.sh.adm.exception.OrderGroupNotFoundException;
import com.sh.adm.model.dto.Address;
import com.sh.adm.model.entity.*;
import com.sh.adm.model.enumclass.*;
import com.sh.adm.model.network.request.OrderDetailApiRequest;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.response.OrderDetailApiResponse;
import com.sh.adm.model.network.response.OrderGroupApiResponse;
import com.sh.adm.repository.*;
import lombok.extern.slf4j.Slf4j;
import org.assertj.core.util.Lists;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.CsvSource;
import org.junit.jupiter.params.provider.MethodSource;
import org.junit.jupiter.params.provider.ValueSource;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Stream;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatExceptionOfType;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.*;

@Slf4j
@ExtendWith(MockitoExtension.class)
class OrderGroupSaveServiceImplTest {

    @InjectMocks
    OrderGroupSaveServiceImpl orderGroupSaveService;
    @Mock
    OrderGroupRepository orderGroupRepository;
    @Mock
    OrderDetailRepository orderDetailRepository;
    @Mock
    ItemRepository itemRepository;
    @Mock
    UserRepository userRepository;
    @Mock
    DeliveryRepository deliveryRepository;

    @Captor
    ArgumentCaptor<OrderGroup> orderGroupArgumentCaptor;
    @Captor
    ArgumentCaptor<OrderDetail> orderDetailArgumentCaptor;
    @Captor
    ArgumentCaptor<Delivery> deliveryArgumentCaptor;

    private BigDecimal itemPrice = BigDecimal.valueOf(10000);


    @Test
    @DisplayName("장바구니 담기 상품 예외 발생")
    void addToOrderDetailItemNotFoundExceptionTest() {
        OrderDetailApiRequest request = givenOrderDetailRequest(5);
        when(itemRepository.findById(1L)).thenReturn(Optional.empty());
        assertThatExceptionOfType(ItemNotFoundException.class).isThrownBy(
                () -> {
                    orderGroupSaveService.addToOrderDetail(request);
                }
        ).withMessage("해당 상품이 없습니다.");

    }

    @ParameterizedTest
    @DisplayName("장바구니 생성")
    @ValueSource(ints = 5)
    void addToOrderDetailCreateOrderGroupTest(int orderCount) {
        OrderDetailApiRequest request = OrderDetailApiRequest.builder()
                .id(1)
                .quantity(orderCount)
                .totalPrice(itemPrice)
                .userId(1L)
                .itemId(1L)
                .build();

        Partner mockPartner = mock(Partner.class);
        User mockUser = mock(User.class);
        Item item = givenItem(100, mockPartner);

        when(itemRepository.findById(1L)).thenReturn(Optional.of(item));
        when(userRepository.findById(1L)).thenReturn(Optional.of(mockUser));
        orderGroupSaveService.addToOrderDetail(request);

        verify(orderGroupRepository, times(1)).save(orderGroupArgumentCaptor.capture());
        verify(orderDetailRepository, times(1)).save(orderDetailArgumentCaptor.capture());

        BigDecimal totalItemPriceInCartTest = itemPrice.multiply(BigDecimal.valueOf(orderCount));
        int totalItemQuantityInCartTest = 100-orderCount;
        assertAll(
                () -> assertEquals(orderGroupArgumentCaptor.getValue().getStatus(),OrderStatus.ORDERING,"OrderGroup 생성 확인"),
                () -> assertEquals(orderDetailArgumentCaptor.getValue().getQuantity(),orderCount,"장바구니 상품 수량 확인"),
                () -> assertEquals(orderDetailArgumentCaptor.getValue().getTotalPrice(),totalItemPriceInCartTest,"장바구니 상품 가격 확인"),
                () -> assertEquals(orderDetailArgumentCaptor.getValue().getItem().getStockQuantity(),(totalItemQuantityInCartTest),"변경된 상품 제고 확인")
        );
    }

    @ParameterizedTest
    @DisplayName("장바구니 내 새상품 담기")
    @ValueSource(ints = 5)
    void addToOrderDetailCreateOrderDetailTest(int orderCount) {
        Partner mockPartner = mock(Partner.class);
        Item item = givenItem(100, mockPartner);
        OrderDetailApiRequest request = givenOrderDetailRequest(5);
        OrderGroup mockOrderGroup = mock(OrderGroup.class);

        when(itemRepository.findById(1L)).thenReturn(Optional.of(item));
        when(orderDetailRepository.findByOrderGroupIdAndItemId(1L, 1L)).thenReturn(null);
        when(orderGroupRepository.findById(1L)).thenReturn(Optional.of(mockOrderGroup));
        orderGroupSaveService.addToOrderDetail(request);

        int totalItemQuantityInCartTest = 100-orderCount;
        assertEquals(item.getStockQuantity(),totalItemQuantityInCartTest);
    }

    @Test
    @DisplayName("장바구니 내 새상품 담기시 장바구니 예외 발생")
    void addToOrderDetailCreateOrderDetailOrderGroupNotFoundExceptionTest() {
        Partner mockPartner = mock(Partner.class);
        Item item = givenItem(100, mockPartner);
        OrderDetailApiRequest request = givenOrderDetailRequest(5);

        when(itemRepository.findById(1L)).thenReturn(Optional.of(item));
        when(orderDetailRepository.findByOrderGroupIdAndItemId(1L, 1L)).thenReturn(null);
        when(orderGroupRepository.findById(1L)).thenReturn(Optional.empty());

        assertThatExceptionOfType(OrderGroupNotFoundException.class).isThrownBy(
                () -> {
                    orderGroupSaveService.addToOrderDetail(request);
                }
        ).withMessage("장바구니에 상품이 없습니다.");
    }

    @Test
    @DisplayName("장바구니내 기존 상품 추가")
    void addToOrderDetailModifyOrderDetailTest() {
        Partner mockPartner = mock(Partner.class);
        Item item = givenItem(100, mockPartner);
        OrderDetailApiRequest request = givenOrderDetailRequest(3);
        OrderDetail mockOrderDetail = mock(OrderDetail.class);

        when(itemRepository.findById(1L)).thenReturn(Optional.of(item));
        when(orderDetailRepository.findByOrderGroupIdAndItemId(1L, 1L)).thenReturn(mockOrderDetail);
        orderGroupSaveService.addToOrderDetail(request);

        verify(mockOrderDetail, times(1)).updateOrderDetail(item,request.getQuantity());
    }

    @ParameterizedTest
    @DisplayName("장바구니 수정하기")
    @CsvSource("3,5")
    void updateCartTest(int itemCountInCart, int changeItemCount) {
        // given
        OrderDetail orderDetail = givenOrderDetail(itemCountInCart);  // 변경 전
        // when
        OrderDetailApiRequest request = givenOrderDetailRequest(changeItemCount); // 변경 후
        when(orderDetailRepository.findByOrderGroupIdAndItemId(1L,1L)).thenReturn(orderDetail);
        when(itemRepository.findById(1L)).thenReturn(Optional.of(orderDetail.getItem()));
        
        OrderDetailApiResponse response = orderGroupSaveService.modifyCart(request);
        // then
        assertAll(
                () -> assertEquals(request.getId(), response.getId(),"id 확인"),
                () -> assertEquals(request.getOrderStatus(), response.getOrderStatus(),"주문 상태 주문중 확인"),
                () -> assertEquals(request.getQuantity(), response.getQuantity(),"카트내 상품 수량 확인"),
                () -> assertEquals(request.getTotalPrice(), response.getTotalPrice(),"카트내 상품 총가격 확인"),
                () -> assertEquals(request.getOrderGroupId(), response.getOrderGroupId(),"장바구니 확인"),
                () -> assertEquals(request.getItemId(), response.getItemId(),"상품 확인")
        );
    }

    @Test
    @DisplayName("장바구니 내 상품 없을 때 예외 발생")
    void updateCartOrderGroupNotFoundExceptionTest() {
        // given
        OrderDetail orderDetail = givenOrderDetail(3);  // 변경 전
        // when
        OrderDetailApiRequest request = givenOrderDetailRequest(5); // 변경 후
        when(orderDetailRepository.findByOrderGroupIdAndItemId(1L,1L)).thenReturn(null);

        assertThatExceptionOfType(OrderGroupNotFoundException.class)
                .isThrownBy(() -> orderGroupSaveService.modifyCart(request))
                .withMessage("장바구니에 상품이 없습니다.");
    }

    @Test
    @DisplayName("장바구니 내 상품 없을 때 예외 발생")
    void updateCartItemNotFoundExceptionTest() {
        // given
        OrderDetail orderDetail = givenOrderDetail(3);  // 변경 전
        // when
        OrderDetailApiRequest request = givenOrderDetailRequest(5); // 변경 후
        when(orderDetailRepository.findByOrderGroupIdAndItemId(1L,1L)).thenReturn(orderDetail);
        when(itemRepository.findById(1L)).thenReturn(Optional.empty());
        // then
        assertThatExceptionOfType(ItemNotFoundException.class)
                .isThrownBy(() -> orderGroupSaveService.modifyCart(request))
                .withMessage("해당 상품이 없습니다.");
    }

    @Test
    @DisplayName("장바구니 상품 삭제")
    void deleteCartTest() {
        // given
        OrderDetail orderDetail = givenOrderDetail(5);
        // when
        OrderDetailApiRequest request = givenOrderDetailRequest(0);
        when(orderDetailRepository.findByOrderGroupIdAndItemId(1L,1L)).thenReturn(orderDetail);
        orderGroupSaveService.deleteCart(request);
        // then
        verify(orderDetailRepository, times(1)).delete(orderDetailArgumentCaptor.capture());
        assertAll(
                () -> assertEquals(orderDetailArgumentCaptor.getValue().getItem().getStockQuantity(), 100,"item 제고 원상복구"),
                () -> assertThat(orderDetailArgumentCaptor.getValue().getOrderGroup()).isNull()
        );
    }

    @Test
    @DisplayName("장바구니 상품 삭제시 해당 상품 데이터 없는 예외 발생")
    void deleteCartOrderGroupNotFoundExceptionTest() {
        OrderDetailApiRequest request = givenOrderDetailRequest(5);
        when(orderDetailRepository.findByOrderGroupIdAndItemId(1L,1L)).thenReturn(null);
        assertThatExceptionOfType(OrderGroupNotFoundException.class)
                .isThrownBy(() -> {
                    orderGroupSaveService.deleteCart(request);
                })
                .withMessage("장바구니에 상품이 없습니다.");
    }

    @Test
    @DisplayName("주문 테스트")
    void orderTest() {
        // given
        int orderCount = 5;
        OrderDetail orderDetail = givenOrderDetail(orderCount);
        OrderGroup orderGroup = givenOrderGroup(orderDetail);
        OrderGroupApiRequest request = givenOrderGroupRequest(orderCount);
        // when
        when(orderGroupRepository.findById(1L)).thenReturn(Optional.of(orderGroup));
        when(orderDetailRepository.findByOrderGroupId(1L)).thenReturn(Lists.newArrayList(orderDetail));
        OrderGroupApiResponse response = orderGroupSaveService.order(request);
        // then
        Address address = Address.of(request.getCity(), request.getStreet(), request.getZipcode());
        verify(deliveryRepository, times(1)).save(deliveryArgumentCaptor.capture());
        assertAll(
                () -> assertEquals(deliveryArgumentCaptor.getValue().getReceiveAddress(), address,"배송지 확인"),
                () -> assertEquals(deliveryArgumentCaptor.getValue().getDeliveryStatus(), DeliveryStatus.READY,"주문 신청 직후 배송 상태 확인"),
                () -> assertEquals(orderGroup.getTotalPrice(), response.getTotalPrice(),"주문 가격 총합 확인"),
                () -> assertEquals(orderGroup.getTotalQuantity(), response.getTotalQuantity(),"주문 총량 확인"),
                () -> assertTrue(response.getOrderDetailListName().contains(orderDetail.getItem().getName()),"주문목록 제목 확인")
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
        OrderGroup orderGroup = givenOrderGroup(orderDetail);
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
    @DisplayName("주문 후 주소/수신자면 변경 테스트")
    @MethodSource("paramsProvider")
    void modifyOrderTest(String city, String street, String zipcode, String changeReceiveName) {
        // given
        String beforeAddress = "서울시" + ", " + "100" + ", " + "12345";
        String beforeReceiveName = "sunhwa";
        String afterAddress = city+", "+street+", "+zipcode;
        OrderGroup orderGroup = givenOrderGroup(givenOrderDetail(5));
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
        when(orderGroupRepository.findById(1L)).thenReturn(Optional.of(orderGroup));
        OrderGroupApiResponse response = orderGroupSaveService.modifyOrder(request).get();

        assertAll(
                () -> assertNotEquals(beforeAddress, response.getRevAddress(), "변경 후 주소는 달라야 합니다."),
                () -> assertNotEquals(beforeReceiveName, response.getReceiveName(), "변경 후 수신자명이 달라야 합니다."),
                () -> assertEquals(afterAddress, response.getRevAddress(), "변경 후 주소 확인"),
                () -> assertEquals(changeReceiveName, response.getReceiveName(), "변경 후 수신자명 확인")
        );
    }

    private static Stream<Arguments> paramsProvider() {
        return Stream.of(
                Arguments.arguments("경기도","200","11111","testName"),
                Arguments.arguments("제주시","700","22222","testJeju")
        );
    }

    // Request data
    private OrderDetailApiRequest givenOrderDetailRequest(int quantity) {
        return OrderDetailApiRequest.builder()
                .id(1)
                .orderStatus(OrderStatus.ORDERING)
                .quantity(quantity)
                .totalPrice(itemPrice.multiply(BigDecimal.valueOf(quantity)))
                .userId(1L)
                .orderGroupId(1L)
                .itemId(1L)
                .build();
    }

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

    private OrderGroup givenOrderGroup(OrderDetail orderDetail) {
        User mockUser = mock(User.class);
        OrderGroup orderGroup = OrderGroup.createOrderGroup(mockUser, orderDetail);
        return orderGroup;
    }

}