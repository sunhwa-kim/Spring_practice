package com.sh.adm.orderdetail.service;

import com.sh.adm.FindSlowTestExtension;
import com.sh.adm.item.entity.Item;
import com.sh.adm.item.enumclass.ItemStatus;
import com.sh.adm.item.exception.ItemNotFoundException;
import com.sh.adm.item.repository.ItemRepository;
import com.sh.adm.orderdetail.dto.OrderDetailApiRequest;
import com.sh.adm.orderdetail.dto.OrderDetailApiResponse;
import com.sh.adm.orderdetail.entity.OrderDetail;
import com.sh.adm.orderdetail.exception.OrderDetailNotFoundException;
import com.sh.adm.orderdetail.repository.OrderDetailRepository;
import com.sh.adm.ordergroup.entity.OrderGroup;
import com.sh.adm.ordergroup.enumclass.OrderStatus;
import com.sh.adm.ordergroup.repository.OrderGroupRepository;
import com.sh.adm.partner.entity.Partner;
import com.sh.adm.user.entity.User;
import com.sh.adm.user.exception.UserNotFoundException;
import com.sh.adm.user.repository.UserRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.RegisterExtension;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.junit.jupiter.params.provider.ValueSource;
import org.mockito.ArgumentCaptor;
import org.mockito.Captor;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatExceptionOfType;
import static org.assertj.core.api.BDDAssertions.then;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

class OrderDetailServiceTest {
    @InjectMocks
    OrderDetailService orderDetailService;
    @Mock
    OrderGroupRepository orderGroupRepository;
    @Mock
    OrderDetailRepository orderDetailRepository;
    @Mock
    ItemRepository itemRepository;
    @Mock
    UserRepository userRepository;

    @Captor
    ArgumentCaptor<OrderGroup> orderGroupArgumentCaptor;
    @Captor
    ArgumentCaptor<OrderDetail> orderDetailArgumentCaptor;
    @Captor

    @RegisterExtension
    static FindSlowTestExtension findSlowTestExtension = new FindSlowTestExtension(1000L);

    private BigDecimal itemPrice = BigDecimal.valueOf(10000);



    @Test
    @DisplayName("장바구니 담기 상품 예외 발생")
    void addToOrderDetailItemNotFoundExceptionTest() {
        OrderDetailApiRequest request = givenOrderDetailRequest(5);
        when(itemRepository.findById(anyLong())).thenReturn(Optional.empty());
        assertThatExceptionOfType(ItemNotFoundException.class).isThrownBy(
                () -> {
                    orderDetailService.addToOrderDetail(request);
                }
        ).withMessage("해당 상품이 없습니다.");
        verify(itemRepository, times(1)).findById(anyLong());
    }

    @Test
    @DisplayName("장바구니 담기시 사용자 에러 발생")
    void addToOrderDetailUserNotFoundExceptionTest() {
        OrderDetailApiRequest request = givenOrderDetailRequest(5);

        when(itemRepository.findById(anyLong())).thenReturn(Optional.of(mock(Item.class)));
        when(userRepository.findById(anyLong())).thenReturn(Optional.empty());

        assertThrows(UserNotFoundException.class, () ->
                        orderDetailService.addToOrderDetail(request),
                "OrderGroup내 주문중인 상태의 OrderGroupId 확인 전 사용자 확인 조회에서 에러 발생"
        );
        verify(userRepository, times(1)).findById(anyLong());
    }

    @ParameterizedTest
    @DisplayName("장바구니 생성/예외 확인")
    @ValueSource(ints = 5)
    void addToOrderDetailCreateOrderGroupTest(int orderCount) throws InterruptedException {
//        Thread.sleep(1005L);
        BigDecimal totalItemPriceInCart = itemPrice.multiply(BigDecimal.valueOf(orderCount));
        Item item = givenItem(100, mock(Partner.class));
        int totalItemQuantityInCart = item.getStockQuantity() - orderCount;
        OrderDetailApiRequest request = OrderDetailApiRequest.builder()
                .id(1)
                .orderStatus(OrderStatus.ORDERING)
                .quantity(orderCount)
                .totalPrice(itemPrice)
                .userId(1L)
                .itemId(1L)
                .build();

        when(itemRepository.findById(anyLong())).thenReturn(Optional.of(item));
        when(userRepository.findById(anyLong())).thenReturn(Optional.of(mock(User.class)));
        when(orderGroupRepository.findByStatusAndUserId(eq(OrderStatus.ORDERING), anyLong())).thenReturn(null);

        orderDetailService.addToOrderDetail(request);

        verify(orderGroupRepository, times(1)).save(orderGroupArgumentCaptor.capture());
        verify(orderDetailRepository, times(1)).save(orderDetailArgumentCaptor.capture());
        OrderDetail orderDetail = orderDetailArgumentCaptor.getValue();

        assertAll(
                () -> assertEquals(orderGroupArgumentCaptor.getValue().getStatus(),OrderStatus.ORDERING,"OrderGroup 생성 확인"),
                () -> assertEquals(orderDetail.getQuantity(),orderCount,"장바구니 상품 수량 확인"),
                () -> assertEquals(orderDetail.getTotalPrice(),totalItemPriceInCart,"장바구니 상품 가격 확인"),
                () -> assertEquals(orderDetail.getItem().getStockQuantity(),(totalItemQuantityInCart),"변경된 상품 제고 확인")
        );
    }

    @ParameterizedTest
    @DisplayName("장바구니 내 새상품 담기")
    @ValueSource(ints = 5)
    void addToOrderDetailCreateOrderDetailTest(int orderCount) {
        Item item = givenItem(100, mock(Partner.class));
        int totalItemQuantityInCartTest = item.getStockQuantity()-orderCount;
        BigDecimal itemPriceInCart = item.getPrice().multiply(BigDecimal.valueOf(orderCount));
        OrderDetailApiRequest request = givenOrderDetailRequest(5);

        when(itemRepository.findById(anyLong())).thenReturn(Optional.of(item));
        when(userRepository.findById(anyLong())).thenReturn(Optional.of(mock(User.class)));
        when(orderGroupRepository.findByStatusAndUserId(eq(OrderStatus.ORDERING),anyLong())).thenReturn(Arrays.asList(mock(OrderGroup.class)));

        orderDetailService.addToOrderDetail(request);

        verify(orderDetailRepository).save(orderDetailArgumentCaptor.capture());
        OrderDetail savedOrderDetail = orderDetailArgumentCaptor.getValue();
        assertAll(
                () -> assertEquals(item.getStockQuantity(), totalItemQuantityInCartTest),
                () -> then(savedOrderDetail.getQuantity()).isEqualTo(orderCount),
                () -> then(savedOrderDetail.getTotalPrice()).isEqualTo(itemPriceInCart)
        );
    }

    @Test
    @DisplayName("장바구니에 기존 상품 추가")
    void addToOrderDetailModifyOrderDetailTest() {
        Partner mockPartner = mock(Partner.class);
        Item item = givenItem(100, mockPartner);
        int quantity = 3;
        OrderDetailApiRequest request = givenOrderDetailRequest(quantity);
        OrderDetail mockOrderDetail = mock(OrderDetail.class);

        when(itemRepository.findById(anyLong())).thenReturn(Optional.of(item));
        when(userRepository.findById(anyLong())).thenReturn(Optional.of(mock(User.class)));
        when(orderGroupRepository.findByStatusAndUserId(eq(OrderStatus.ORDERING), anyLong())).thenReturn(Arrays.asList(mock(OrderGroup.class)));
        when(orderDetailRepository.findByOrderStatusAndItemId(eq(OrderStatus.ORDERING), anyLong())).thenReturn(Optional.of(mockOrderDetail));

        orderDetailService.addToOrderDetail(request);

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
        when(orderDetailRepository.findByOrderGroupIdAndItemId(anyLong(), anyLong()))
                .thenReturn(Optional.of(orderDetail))
                .thenThrow(new OrderDetailNotFoundException());
        when(itemRepository.findById(anyLong()))
                .thenReturn(Optional.of(orderDetail.getItem()))
                .thenThrow(new ItemNotFoundException());

        OrderDetailApiResponse response = orderDetailService.modifyOrderDetail(anyLong(),request);
        // then
        assertAll(
                () -> assertEquals(request.getOrderStatus(), response.getOrderStatus(),"주문 상태 주문중 확인"),
                () -> assertEquals(request.getQuantity(), response.getQuantity(),"카트내 상품 수량 확인"),
                () -> assertEquals(request.getTotalPrice(), response.getTotalPrice(),"카트내 상품 총가격 확인"),
                () -> assertEquals(request.getOrderGroupId(), response.getOrderGroupId(),"장바구니 확인"),
                () -> assertEquals(request.getItemId(), response.getItemId(),"상품 확인")
        );
        assertThrows(OrderDetailNotFoundException.class, () ->
                        orderDetailRepository.findByOrderGroupIdAndItemId(anyLong(), anyLong()),
                "장바구니 내 기존 상품 변경시 해당 상품이 없어 예외 발생, orderDetailRepository.find >> empty"
        );
        assertThrows(ItemNotFoundException.class, () ->
                        itemRepository.findById(anyLong()),
                "장바구니 내 기존 상품 변경시 상품 정보가 없어 예외 발생, itemRepository.find >> empty"
        );
    }

    @Test
    @DisplayName("장바구니 내 상품 없을 때 예외 발생")
    void updateCartOrderGroupNotFoundExceptionTest() {
        // given
        OrderDetail orderDetail = givenOrderDetail(3);  // 변경 전
        // when
        OrderDetailApiRequest request = givenOrderDetailRequest(5); // 변경 후
        when(itemRepository.findById(anyLong())).thenReturn(Optional.of(mock(Item.class)));
        when(orderDetailRepository.findByOrderGroupIdAndItemId(anyLong(),anyLong())).thenReturn(Optional.empty());

        assertThatExceptionOfType(OrderDetailNotFoundException.class)
                .isThrownBy(() -> orderDetailService.modifyOrderDetail(anyLong(),request))
                .withMessage("주문 할 상품 정보가 없습니다.");
    }

    @Test
    @DisplayName("장바구니 담기시 상품 없을 때 예외 발생")
    void updateCartItemNotFoundExceptionTest() {
        // given
        OrderDetail orderDetail = givenOrderDetail(3);  // 변경 전
        // when
        OrderDetailApiRequest request = givenOrderDetailRequest(5); // 변경 후
        when(itemRepository.findById(1L)).thenReturn(Optional.empty());
        // then
        assertThatExceptionOfType(ItemNotFoundException.class)
                .isThrownBy(() -> orderDetailService.modifyOrderDetail(anyLong(),request))
                .withMessage("해당 상품이 없습니다.");
    }

    @Test
    @DisplayName("장바구니 상품 삭제")
    void deleteCartTest() {
        // given
        OrderDetail orderDetail = givenOrderDetail(5);
        // when
        OrderDetailApiRequest request = givenOrderDetailRequest(0);
         when(orderDetailRepository.findByOrderGroupIdAndItemId(anyLong(),anyLong()))
                .thenReturn(Optional.of(orderDetail))
                .thenThrow(new OrderDetailNotFoundException());
        orderDetailService.deleteCart(request);
        // then
        verify(orderDetailRepository, times(1)).delete(orderDetailArgumentCaptor.capture());
        assertAll(
                () -> assertEquals(orderDetailArgumentCaptor.getValue().getItem().getStockQuantity(), 100,"item 제고 원상복구"),
                () -> assertThat(orderDetailArgumentCaptor.getValue().getOrderGroup()).isNull()
        );
        assertThrows(OrderDetailNotFoundException.class, () ->
                        orderDetailRepository.findByOrderGroupIdAndItemId(anyLong(), anyLong()),
                "장바구니 내 상품 삭제 요청시 장부구니 조회 결과 상품이 없어 예외 발생, orderDetailRepository.find >> empty"
        );
    }

    @Test
    @DisplayName("장바구니 상품 삭제시 해당 상품 데이터 없는 예외 발생")
    void deleteCartOrderGroupNotFoundExceptionTest() {
        OrderDetailApiRequest request = givenOrderDetailRequest(5);
        when(orderDetailRepository.findByOrderGroupIdAndItemId(1L,1L)).thenReturn(Optional.empty());
        assertThatExceptionOfType(OrderDetailNotFoundException.class)
                .isThrownBy(() -> {
                    orderDetailService.deleteCart(request);
                })
                .withMessage("주문 할 상품 정보가 없습니다.");
        verify(orderDetailRepository, never()).delete(any());
    }


    // Request
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
}