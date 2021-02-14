package com.sh.adm.service;

import com.sh.adm.model.dto.Address;
import com.sh.adm.model.entity.*;
import com.sh.adm.model.enumclass.*;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.OrderDetailApiRequest;
import com.sh.adm.model.network.request.OrderDetailListApiRequest;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.request.OrderItem;
import com.sh.adm.model.network.response.OrderDetailApiResponse;
import com.sh.adm.model.network.response.OrderDetailListApiResponse;
import com.sh.adm.model.network.response.OrderGroupApiResponse;
import com.sh.adm.repository.*;
import lombok.extern.slf4j.Slf4j;
import org.assertj.core.util.Lists;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.IntStream;

import static org.assertj.core.api.BDDAssertions.then;
import static org.junit.jupiter.api.Assertions.assertAll;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@Slf4j
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
    DeliveryRepository deliveryRepository;
    @Mock
    UserRepository userRepository;

    @Captor
    ArgumentCaptor<OrderDetail> orderDetailCaptor;
    @Captor
    ArgumentCaptor<Delivery> deliveryCaptor;

    private BigDecimal itemPrice = new BigDecimal(900000);
    private String testCity = "서울시";


    @Test
    @DisplayName("사용자 첫 장바구니 담기")
    void createOrderGroupAndNewItemInsertOrderDetail() {
        when(itemRepository.findById(1L)).thenReturn(Optional.of(givenItem(100, givenPartner(givenCategory()))));
        when(userRepository.findById(1L)).thenReturn(Optional.of(givenUser()));
        orderGroupApiLogicService.addToOrderDetail(requestOrderDetail(null, null, 2));  //2개 주문
        verify(orderGroupRepository, times(1)).save(any(OrderGroup.class));
        verify(orderDetailRepository, times(1)).save(orderDetailCaptor.capture());
        assertAll(
                () -> then(orderDetailCaptor.getValue().getItem().getStockQuantity()).isEqualTo(98),
                () -> then(orderDetailCaptor.getValue().getQuantity()).isEqualTo(2),
                () -> then(orderDetailCaptor.getValue().getTotalPrice()).isEqualTo(itemPrice.multiply(BigDecimal.valueOf(2)))
                );
    }

    @Test
    @DisplayName("새 상품 장바구니 담기")
    void getOrderGroupIdAndNewItemInsertOrderDetail() {
        int orderCount = 3;
        Item item = givenItem(100, givenPartner(givenCategory()));
        Item item2 = givenItem(20, givenPartner(givenCategory()));
        // 사용자 요청 상품 조회
        when(itemRepository.findById(1L)).thenReturn(Optional.of( item ));
        // 장바구니 상품 조회
        when(orderDetailRepository.findByOrderGroupIdAndItemId(1L, 1L)).thenReturn(Optional.empty());   // entity 순서대로 작성
        // 장바구니 새 상품 담기
        when(orderGroupRepository.findById(1L)).thenReturn(Optional.of(OrderGroup.createOrderGroup(givenUser(), OrderDetail.createOrderDetail(item2,2))));

        Header<OrderDetailApiResponse> headerResponse = orderGroupApiLogicService.addToOrderDetail(requestOrderDetail(null, 1L, orderCount));
        OrderDetailApiResponse response = headerResponse.getData();
        assertAll(
                () -> then(response.getOrderItemQuantity()).isEqualTo(orderCount),
                () -> then(response.getTotalPrice()).isEqualTo(item.getPrice().multiply(BigDecimal.valueOf(orderCount)))
        );
    }

    @Test
    @DisplayName("기존 상품 장바구니 추가")
    void getOrderGroupIdAndUpdateOrderDetail() {
        int originalOrdercount = 5;
        int chageOrderCount = 10;
        Item item = givenItem(100-originalOrdercount, givenPartner(givenCategory()));
        when(itemRepository.findById(1L)).thenReturn(Optional.of( item ));
        when(orderDetailRepository.findByOrderGroupIdAndItemId(1L, 1L)).thenReturn(Optional.of(newOrderDetail(item,originalOrdercount)));
//        doReturn(Optional.of(newOrderDetail(item, originalOrdercount))).when(orderDetailRepository).findByOrderGroupIdAndItemId(1L, 1L);

        Header<OrderDetailApiResponse> headerResponse = orderGroupApiLogicService.addToOrderDetail(requestOrderDetail(1L, 1L, chageOrderCount));
        OrderDetailApiResponse response = headerResponse.getData();

        assertAll(
                () -> then(response.getTotalPrice()).isEqualTo(itemPrice.multiply(BigDecimal.valueOf(chageOrderCount))),
                () -> then(response.getOrderItemQuantity()).isEqualTo(chageOrderCount)
        );
    }

    @Test
    @DisplayName("장바구니 수정")
    void updateOrderDetailListbyOrderGroup() {
        List<OrderDetail> orderDetailList = givenOrderDetailList();
        when(orderDetailRepository.findByOrderGroupIdOrderByItemIdAsc(1L)).thenReturn(orderDetailList);
        // 테스트 변경 item_id = 0,1,2
        Header<OrderDetailListApiResponse> headerResponse = orderGroupApiLogicService.updateCart(requestOrderDetails());
        OrderDetailListApiResponse response = headerResponse.getData();

        IntStream.range(0,5).forEach(i-> {
            if(i<3){
                BigDecimal eachOfPrice = BigDecimal.valueOf(i+1).multiply(BigDecimal.valueOf((i+1)*10000)).multiply(BigDecimal.TEN);
                assertAll(
                            () -> then(response.getItems().get(i).getItem_id()).as("worng itemId "+i).isEqualTo(orderDetailList.get(i).getItem().getId()),
                            () -> then(response.getItems().get(i).getQuantity()).as("wrong quantity "+i).isEqualTo((i+1)*10),
                            () -> then(response.getItems().get(i).getEachItemTotalPrice()).as("wrong price "+i).isEqualTo(eachOfPrice)
                    );
            }
            else{
                assertAll(
                        () -> then(response.getItems().get(i).getItem_id()).as("worng itemId "+i).isEqualTo(orderDetailList.get(i).getItem().getId()),
                        () -> then(response.getItems().get(i).getQuantity()).as("wrong quantity "+i).isEqualTo(orderDetailList.get(i).getQuantity()),
                        () -> then(response.getItems().get(i).getEachItemTotalPrice()).as("wrong price "+i).isEqualTo(orderDetailList.get(i).getTotalPrice())
                );
            }
        });
    }

    @Test
    @DisplayName("주문")
    void orderTest() {
        List<OrderDetail> orderDetailList = givenOrderDetailList();
        BigDecimal resultOfPrice = BigDecimal.ZERO;

        AtomicInteger resultOfQuantity = new AtomicInteger();
        for (OrderDetail orderDetail : orderDetailList) {
            resultOfPrice = resultOfPrice.add(orderDetail.getTotalPrice());  // immutable
            resultOfQuantity.addAndGet(orderDetail.getQuantity());
        }

        when(orderGroupRepository.findById(1L)).thenReturn(Optional.of(givenOrderGroupList()));
        lenient().when(orderDetailRepository.findByOrderGroupIdOrderByCreatedAtDesc(1L)).thenReturn(Lists.newArrayList(orderDetailList));

        Header<OrderGroupApiResponse> order = orderGroupApiLogicService.order(requestOrderGroup(1L,testCity,OrderType.ALL, PaymentType.CARD));
        OrderGroupApiResponse response = order.getData();

        verify(deliveryRepository, times(1)).save(deliveryCaptor.capture());
        Integer finalResultOfQuantity = resultOfQuantity.get();
        BigDecimal finalResultOfPrice = resultOfPrice;
        assertAll(
                () -> then(response.getStatus()).as("주문 상태").isEqualTo(OrderStatus.CONFIRM),
                () -> then(response.getOrderType()).as("주문 타입").isEqualTo(OrderType.ALL),
                () -> then(deliveryCaptor.getValue().getReceiveAddress()).as("주문 주소").isEqualTo(Address.of(testCity,"100","12345")),
                () -> then(response.getRevName()).as("주문 명").isEqualTo("test"),
                () -> then(response.getPaymentType()).as("주문 지불타입").isEqualTo(PaymentType.CARD),
                () -> then(response.getTotalPrice()).as("주문 가격").isEqualTo(finalResultOfPrice),
                () -> then(response.getTotalQuantity()).as("주문 수량").isEqualTo(finalResultOfQuantity)
        );
    }

    @Test
    @DisplayName("주문 내역 확인")
    void readOrderTest() {
        when(orderGroupRepository.findById(1L)).thenReturn(Optional.of(givenOrder()));

        OrderGroupApiResponse response = orderGroupApiLogicService.readOrder(1L).getData();

        assertAll(
                () -> then(response.getStatus()).as("주문 상태").isEqualTo(OrderStatus.CONFIRM),
                () -> then(response.getRevName()).as("주문 수신명").isEqualTo("test"),
                () -> then(response.getRevAddress()).as("주문 주소").isEqualTo("서울시, 100, 12345"),
                () -> then(response.getOrderType()).as("주문 타입").isEqualTo(OrderType.ALL),
                () -> then(response.getPaymentType()).as("지불 타입").isEqualTo(PaymentType.CARD),
                () -> then(response.getTotalPrice()).as("주문 합계").isEqualTo(BigDecimal.valueOf(900000).multiply(BigDecimal.valueOf(5))),
                () -> then(response.getTotalQuantity()).as("주문 상품 개수").isEqualTo(5)
        );
    }

    @Test
    @DisplayName("주문 내역 수정")
    void modifyOrderTest() {
        when(orderGroupRepository.findById(1L)).thenReturn(Optional.of(givenOrder()));

        OrderGroupApiResponse response = orderGroupApiLogicService.modifyOrder(requestOrderGroup(1L, "대전시", OrderType.ALL, PaymentType.BANK_TRANSFER)).getData();

        assertAll(
                () -> then(response.getStatus()).as("주문 상태").isEqualTo(OrderStatus.CONFIRM),
                () -> then(response.getRevName()).as("주문 수신명").isEqualTo("test"),
                () -> then(response.getRevAddress()).as("주문 주소").isEqualTo("대전시, 100, 12345"),
                () -> then(response.getOrderType()).as("주문 타입").isEqualTo(OrderType.ALL),
                () -> then(response.getPaymentType()).as("지불 타입").isEqualTo(PaymentType.BANK_TRANSFER),
                () -> then(response.getTotalPrice()).as("주문 합계").isEqualTo(BigDecimal.valueOf(900000).multiply(BigDecimal.valueOf(5))),
                () -> then(response.getTotalQuantity()).as("주문 상품 개수").isEqualTo(5)
        );
    }

    @Test
    @DisplayName("주문 취소")
    void cancelOrderTest() {
        // 주문 후
        OrderGroup orderGroup = givenOrderGroupList();
        orderGroup.setOrder(Delivery.of(Address.of("서울시", "100", "12345"), "test", orderGroup));
        orderGroup.updateOrder(requestOrderGroup(1L,testCity, OrderType.ALL,PaymentType.CARD).getData());

        when(orderDetailRepository.findByOrderGroupIdOrderByCreatedAtDesc(1L)).thenReturn(Lists.newArrayList(orderGroup.getOrderDetails()));

        orderGroupApiLogicService.cancelOrder(1L);
        verify(orderDetailRepository,times(5)).delete(orderDetailCaptor.capture());
        then(orderDetailCaptor.getValue().getOrderGroup()).isNull();
        then(orderGroup.getStatus()).isEqualTo(OrderStatus.ORDERING);
        then(orderGroup.getTotalPrice()).isEqualTo(BigDecimal.ZERO);
    }

    private OrderDetail newOrderDetail(Item item, int orderItemCount) {
        if(item==null) return OrderDetail.createOrderDetail(givenItem(100, givenPartner(givenCategory())), orderItemCount);
        return OrderDetail.createOrderDetail(item, orderItemCount);
    }

    private List<OrderDetail> givenOrderDetailList() {
        List<OrderDetail> orderDetailList = new ArrayList<>();
        IntStream.rangeClosed(1,5).forEach(i ->{
            Item item = Item.builder().id((long) i-1 )
                    .title("test-item-" + i)
                    .status(ItemStatus.REGISTERED)
                    .name("item0" + i)
                    .title("노트북")
                    .content("2021 new")
                    .price(BigDecimal.valueOf(i).multiply(BigDecimal.valueOf(10000)))
                    .stockQuantity(100)
                    .brandName("S,LG,Mac")
                    .registeredAt(LocalDateTime.now().minusDays(5L))
                    .partner(givenPartner(givenCategory()))
                    .build();
            orderDetailList.add(OrderDetail.createOrderDetail(item, i));
        });
        return orderDetailList;
    }

    private OrderGroup givenOrderGroupList() {
        OrderGroup orderGroup = OrderGroup.createOrderGroup(givenUser(), givenOrderDetailList().get(0));
        IntStream.rangeClosed(1,4).forEach(i->orderGroup.setOrderDetails(givenOrderDetailList().get(i)));
        return orderGroup;
    }

    private OrderGroup givenOrder() {
        OrderGroup orderGroup = OrderGroup.createOrderGroup(givenUser(), newOrderDetail(null, 5));
        orderGroup.setOrder(Delivery.of(Address.of("서울시", "100", "12345"), "test", orderGroup));
        orderGroup.updateOrder(requestOrderGroup(1L,testCity, OrderType.ALL,PaymentType.CARD).getData());
        return orderGroup;
    }

    //  etc
    private User givenUser() {
        return User.of("test01", "pwd01", UserStatus.REGISTERED, "email@gmail.com", "010-1111-2222", null, LocalDateTime.now());
    }

    private int changeName = 1;
    private Item givenItem(int quantity, Partner partner) {
        return Item.builder()
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

    private Header<OrderDetailListApiRequest> requestOrderDetails() {
        List<OrderItem> orderingItems = new ArrayList<>();
        for (int i = 0; i < 3; i++) {
            BigDecimal eachOfPrice = BigDecimal.valueOf(i+1).multiply(BigDecimal.valueOf(10000)).multiply(BigDecimal.TEN);
            orderingItems.add(OrderItem.of((long)i, (i+1)*10, eachOfPrice));
        }
        return Header.OK(new OrderDetailListApiRequest(orderingItems, 1L));
    }

    private Header<OrderGroupApiRequest> requestOrderGroup(Long id, String city ,OrderType orderType, PaymentType paymentType) {
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