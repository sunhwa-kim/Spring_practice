package com.sh.adm.service;

import com.sh.adm.model.entity.*;
import com.sh.adm.model.enumclass.ItemStatus;
import com.sh.adm.model.enumclass.OrderStatus;
import com.sh.adm.model.enumclass.UserStatus;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.OrderDetailApiRequest;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.response.OrderDetailApiResponse;
import com.sh.adm.repository.ItemRepository;
import com.sh.adm.repository.OrderDetailRepository;
import com.sh.adm.repository.OrderGroupRepository;
import com.sh.adm.repository.UserRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Random;

import static org.assertj.core.api.BDDAssertions.then;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class OrderGroupApiLogicServiceTest {

    @InjectMocks
    OrderGroupApiLogicService orderGroupApiLogicService;

    @Mock
    OrderGroupRepository orderGroupRepository;

    @Mock
    OrderDetailRepository orderDetailRepository;

    @Mock
    ItemRepository itemRepository;

    @Mock
    UserRepository userRepository;

/*    @Captor
    ArgumentCaptor<OrderGroup> argumentCaptor;*/
    /*        verify(orderGroupRepository, times(1)).flush(argumentCaptor.capture());
            assertAll(
                    () -> then(argumentCaptor.getValue().getTotalQuantity()).isEqualTo(5),
                    () -> then(argumentCaptor.getValue().getTotalPrice()).isEqualTo(90000*5)
            );*/
    @Test
    @DisplayName("order_group_id 없을 때")
    void FirstAddCart() {
        when(itemRepository.findById(1L)).thenReturn(Optional.of(givenItem(100, givenPartner(givenCategory()))));
        when(userRepository.getOne(1L)).thenReturn(givenUser());
        orderGroupApiLogicService.addToOrderDetail(requestOrderDetail(null, null, 2));  //2개 주문
        verify(orderGroupRepository, times(1)).save(any(OrderGroup.class));
        verify(orderDetailRepository, times(1)).save(any(OrderDetail.class));
    }

    @Test
    @DisplayName("상품 수량 변경 테스트")
    void changeItemQuantityInOrderDetail() {
        // 3 -> 5
        when(itemRepository.findById(1L)).thenReturn(Optional.of(givenItem(97, givenPartner(givenCategory()))));
        when(orderDetailRepository.findByItemIdAndOrderGroupId(1L, 1L)).thenReturn(Optional.of(newOrderDetail(3)));  // 원래 3래 주문
//        when(orderGroupRepository.findById(1L)).thenReturn(Optional.of(OrderGroup.createOrderGroup(givenUser(), newOrderDetail(3))));

        Header<OrderDetailApiResponse> response = orderGroupApiLogicService.addToOrderDetail(requestOrderDetail(null, 1L, 5));// 5개로 변경

        then(response.getData().getOrderItemQuantity()).isEqualTo(5);
    }

    @Test
    @DisplayName("새 상품 장바구니 담기")
    void addNewItemToOrderGroup() {
        when(orderDetailRepository.findByItemIdAndOrderGroupId(1L, 1L)).thenReturn(Optional.empty());
        when(itemRepository.findById(1L)).thenReturn(Optional.of(givenItem(100, givenPartner(givenCategory()))));

        // order_group_id 있고, item도 있어야
        Header<OrderDetailApiResponse> response = orderGroupApiLogicService.addToOrderDetail(requestOrderDetail(null, 1L, 5)); // 5개 주문

        then(response.getData().getOrderItemQuantity()).isEqualTo(5);

    }

/*
    @Test
    @DisplayName("장바구니 상품들 변경")
    void changeItemsConnectedOrderGroup() {

        List<OrderDetail> testNewOrderDetail = new ArrayList<>();
        for (int i = 0; i < 3; i++) {
            testNewOrderDetail.add(newOrderDetail(5));
        }
        when(orderDetailRepository.findByOrderGroupIdOrderByCreatedAtDesc(1L)).thenReturn(testNewOrderDetail);
        Header<List<OrderDetailsApiResponse>> responseList = orderGroupApiLogicService.updateCart(requestUpdateOrderDetails());
        List<OrderDetailsApiResponse> body = responseList.getData();

        body.forEach(System.out::println);
    }
*/


    private int item_count =100;
        private OrderDetail newOrderDetail(int orderItemCount) {
            int changeCount = 1;
        Item item = givenItem(item_count,givenPartner(givenCategory()));
            item_count -= 20;
        return OrderDetail.createOrderDetail(item, orderItemCount);
    }

    private User givenUser() {
        return User.of("test01", "pwd01", UserStatus.REGISTERED, "email@gmail.com", "010-1111-2222", null, LocalDateTime.now());
    }

    private int changeName = 1;
    private Item givenItem(int quantity, Partner partner) {
        return Item.builder()
                .status(ItemStatus.UNREGISTERED)
                .name("LG 노트북"+changeName++)
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

    private Header<List<OrderDetailApiRequest>> requestUpdateOrderDetails() {
        Random random = new Random();
        List<OrderDetailApiRequest> ret = new ArrayList<>();
        for (int i = 1; i < 4; i++) {
            ret.add(OrderDetailApiRequest.builder()
                    .orderStatus(OrderStatus.ORDERING)
                    .quantity(random.nextInt(10) + 1)
                    .userId(1L)
                    .orderGroupId(1L)
                    .itemId((long) i).build());
        }
        return Header.OK(ret);
    }


    private Header<OrderDetailApiRequest> requestOrderDetail(Long id, Long orderGroupId, int orderCount) {
        OrderDetailApiRequest.OrderDetailApiRequestBuilder builder = OrderDetailApiRequest.builder()
                .orderStatus(OrderStatus.ORDERING)
                .arrivalDate(LocalDateTime.now())
                .quantity(orderCount)
                .userId(1L)
                .orderGroupId(orderGroupId)
                .itemId(1L);

        if (id != null) {
            builder.id(id);
        }
        return Header.OK(builder.build());
    }

    private Header<OrderGroupApiRequest> requestOrderGroup(Long id) {
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
}