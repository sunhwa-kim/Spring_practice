package com.sh.adm.service.ordergroup;

import com.sh.adm.exception.ItemNotFoundException;
import com.sh.adm.exception.OrderGroupNotFoundException;
import com.sh.adm.model.entity.*;
import com.sh.adm.model.enumclass.ItemStatus;
import com.sh.adm.model.enumclass.OrderStatus;
import com.sh.adm.model.network.request.OrderDetailApiRequest;
import com.sh.adm.model.network.request.OrderDetailListApiRequest;
import com.sh.adm.model.network.request.OrderItem;
import com.sh.adm.model.network.response.OrderDetailApiResponse;
import com.sh.adm.model.network.response.OrderDetailListApiResponse;
import com.sh.adm.repository.ItemRepository;
import com.sh.adm.repository.OrderDetailRepository;
import com.sh.adm.repository.OrderGroupRepository;
import lombok.extern.slf4j.Slf4j;
import org.assertj.core.util.Lists;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.IntStream;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatExceptionOfType;
import static org.junit.jupiter.api.Assertions.*;
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

    private BigDecimal itemPrice = BigDecimal.valueOf(10000);

    @Test
    @DisplayName("장바구니 수정하기")
    void updateCartTest() {
        // given
        OrderDetail orderDetail = givenOrderDetail(3);  // 변경 전
        // when
        OrderDetailApiRequest request = givenOrderDetailRequest(5); // 변경 후
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

        assertThatExceptionOfType(ItemNotFoundException.class)
                .isThrownBy(() -> orderGroupSaveService.modifyCart(request))
                .withMessage("해당 상품이 없습니다.");
    }


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

    private OrderGroup givenOrderGroup(OrderDetail orderDetail) {
        User mockUser = mock(User.class);
        OrderGroup orderGroup = OrderGroup.createOrderGroup(mockUser, orderDetail);
        return orderGroupRepository.save(orderGroup);
    }

    private OrderDetail givenOrderDetail(int orderItemCount) {
        Partner mockPartner = mock(Partner.class);
        return  OrderDetail.createOrderDetail(givenItem(100, mockPartner), orderItemCount);
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
}