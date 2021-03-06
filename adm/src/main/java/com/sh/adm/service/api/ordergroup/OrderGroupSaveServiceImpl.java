package com.sh.adm.service.api.ordergroup;

import com.sh.adm.exception.ItemNotFoundException;
import com.sh.adm.exception.OrderGroupNotFoundException;
import com.sh.adm.exception.UserNotFoundException;
import com.sh.adm.exception.dto.OrderDetailNotFoundException;
import com.sh.adm.ifs.discount.DiscountPolicy;
import com.sh.adm.model.entity.*;
import com.sh.adm.model.enumclass.OrderStatus;
import com.sh.adm.model.network.request.OrderDetailApiRequest;
import com.sh.adm.model.network.request.OrderDetailListApiRequest;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.request.OrderItem;
import com.sh.adm.model.network.response.OrderDetailApiResponse;
import com.sh.adm.model.network.response.OrderDetailListApiResponse;
import com.sh.adm.model.network.response.OrderGroupApiResponse;
import com.sh.adm.repository.*;
import com.sh.adm.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.IntStream;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class OrderGroupSaveServiceImpl implements OrderGroupSaveService {
    private final ItemRepository itemRepository;
    private final UserRepository userRepository;
    private final UserService userService;

    private final OrderDetailRepository orderDetailRepository;
    private final OrderGroupRepository orderGroupRepository;
    private final DeliveryRepository deliveryRepository;
    private final DiscountPolicy discountPolicy;

    @Override
    public void addToOrderDetail(OrderDetailApiRequest request) {
        Item item = itemRepository.findById(request.getItemId()).orElseThrow(ItemNotFoundException::new);
        User user = userRepository.findById(request.getUserId()).orElseThrow(UserNotFoundException::new);
        int quantity = request.getQuantity();

        OrderGroup orderGroup = checkCartInOrderGroup(user);
        // 장바구니 생성
        if (ObjectUtils.isEmpty(orderGroup)){
            newCart(item, user, quantity);
        }
        else{ // 장바구니 내 상품 유/무
            Optional<OrderDetail> orderDetail = checkOrderDetail(OrderStatus.ORDERING, item.getId());
            if(orderDetail.isEmpty()){
                putInCart(item, orderGroup, quantity);
            }else{
                orderDetail.get().updateOrderDetail(item, quantity);
            }
        }
    }

    private OrderGroup checkCartInOrderGroup(User user) {
        List<OrderGroup> orderGroups = orderGroupRepository.findByStatusAndUserId(OrderStatus.ORDERING, user.getId());
        if(ObjectUtils.isEmpty(orderGroups)) return null;
        int size = orderGroups.size();
        int latestOrderGroupIdx = 0;
        for (int i = size-1; i>=1 ; i--) {
            if(orderGroups.get(i).getUpdatedAt().isAfter(orderGroups.get(i-1).getUpdatedAt())){
                latestOrderGroupIdx = (i-1);
            }
        }
        return orderGroups.get(latestOrderGroupIdx);
    }

    @Transactional
    private void newCart(Item item, User user, int quantity) {
        OrderDetail orderDetail1 = OrderDetail.createOrderDetail(item, quantity);
        orderGroupRepository.save(OrderGroup.createOrderGroup(user, orderDetail1));
        orderDetailRepository.save(orderDetail1);
    }
    private Optional<OrderDetail> checkOrderDetail(OrderStatus ordering, Long id) {
        return orderDetailRepository.findByOrderStatusAndItemId(ordering, id);
    }
    @Transactional
    private void putInCart(Item item, OrderGroup orderGroup, int quantity) {
        OrderDetail newOrderDetail = OrderDetail.createOrderDetail(item, quantity);
        newOrderDetail.setOrderGroup(orderGroup);
        orderDetailRepository.save(newOrderDetail);
    }

    @Override
    public OrderDetailApiResponse modifyOrderDetail(Long orderGroupId, OrderDetailApiRequest request) {
        Item item = itemRepository.findById(request.getItemId()).orElseThrow(ItemNotFoundException::new);
        OrderDetail orderDetail = orderDetailRepository.findByOrderGroupIdAndItemId(orderGroupId, item.getId()).orElseThrow(OrderDetailNotFoundException::new);
        orderDetail.updateOrderDetail(item, request.getQuantity());
        return orderDetailResponse(request, orderDetail);
    }


/*    @Override
    public OrderDetailApiResponse modifyCart(OrderDetailApiRequest request) {
        Optional<OrderDetail> orderDetail = orderDetailRepository.findByOrderGroupIdAndItemId(request.getOrderGroupId(), request.getItemId());
        if(!orderDetail.isEmpty()) throw new OrderGroupNotFoundException();
        Item item = itemRepository.findById(request.getItemId()).orElseThrow(ItemNotFoundException::new);
        orderDetail.get().updateOrderDetail(item, request.getQuantity());
        return orderDetailResponse(request, orderDetail.get());
    }*/

    @Override
    public void deleteCart(OrderDetailApiRequest request) {
        Optional<OrderDetail> orderDetail = orderDetailRepository.findByOrderGroupIdAndItemId(request.getOrderGroupId(), request.getItemId());
        if(orderDetail.isEmpty()) throw new OrderDetailNotFoundException();
        orderDetail.get().cancel();
        orderDetail.get().setOrderGroup(null);
        orderDetailRepository.delete(orderDetail.get());
    }


    // 장바구니 전체 변경-> 장바구니 내 상품 당 삭제/변경
    public OrderDetailListApiResponse updateCartList(OrderDetailListApiRequest request) {
        List<OrderDetail> orderDetails = orderDetailRepository.findByOrderGroupIdOrderByItemIdAsc(request.getOrder_group_id());
        int length = orderDetails.size();
        if (length > 0) {
            List<OrderItem> bodyItems = request.getItemList();
            if (length >= bodyItems.size()) {  // 추가 내역이 없는 경우
                IntStream.range(0,bodyItems.size())
                        .forEach(i -> {
                                    OrderDetail orderDetail = orderDetails.get(i);
                                    orderDetail.updateOrderDetail(orderDetail.getItem(), bodyItems.get(i).getQuantity());
                                });
            }
        }
        Optional<OrderDetailListApiResponse> response = orderDetailListApiResponse(orderDetails, request.getOrder_group_id());
        return response.orElseThrow(OrderGroupNotFoundException::new);
    }
    
    @Override
    public OrderGroupApiResponse order(OrderGroupApiRequest body) {
        // 조회
        OrderGroup orderGroup = orderGroupRepository.findById(body.getId()).orElseThrow(OrderGroupNotFoundException::new);
        Delivery delivery = new Delivery();
        // 주문 내역 정리
        if( orderGroup.getStatus().equals(OrderStatus.ORDERING) ){
            List<OrderDetail> orderDetailList = orderDetailRepository.findByOrderGroupId(body.getId());
            if (orderDetailList.size()==0) throw new OrderDetailNotFoundException();
            orderDetailList.forEach(OrderDetail::order);
            delivery = Delivery.of(body);

            // 주문 시점 domain 한 군데 -> 서비스 별 해당 엔티티
            orderGroup.createOrder(delivery, body.getOrderType(), body.getPaymentType());
            BigDecimal getDiscountedPrice = orderGroup.orderDiscount(discountPolicy);
            userService.point(orderGroup.getUser() , getDiscountedPrice);

            deliveryRepository.save(delivery);
        }
        // 주문 처리 후 응답
        Optional<OrderGroupApiResponse> response = orderGroupApiResponse(orderGroup, delivery);
        return response.orElseThrow(RuntimeException::new);
    }

    @Override
    public Optional<OrderGroupApiResponse> modifyOrder(OrderGroupApiRequest request) {
        // 배송지만 변경  (상품 변경은 주문 취소/삭제)
        OrderGroup orderGroup = orderGroupRepository.findById(request.getId()).orElseThrow(OrderGroupNotFoundException::new);
        orderGroup.updateOrder(request);
        return orderGroupApiResponse(orderGroup, orderGroup.getDelivery());
    }

    @Override
    public void cancelOrder(Long id){
        OrderGroup orderGroup = orderGroupRepository.findById(id).orElseThrow(OrderGroupNotFoundException::new);
        orderGroup.cancel();
        orderGroupRepository.deleteById(id);
    }


    private OrderDetailApiResponse orderDetailResponse(OrderDetailApiRequest request,OrderDetail orderDetail) {
        return OrderDetailApiResponse.builder()
                .id(request.getId())
                .orderStatus(orderDetail.getStatus().getTitle())
                .arrivalDate(orderDetail.getArrivalDate())
                .quantity(orderDetail.getQuantity())
                .totalPrice(orderDetail.getTotalPrice())
                .orderGroupId(request.getOrderGroupId())
                .itemId(orderDetail.getItem().getId())
                .build();
    }

    private Optional<OrderGroupApiResponse> orderGroupApiResponse(OrderGroup orderGroup, Delivery delivery) {
        String itemName = orderGroup.getOrderDetails().get(0).getItem().getName();
        OrderGroupApiResponse response = OrderGroupApiResponse.builder()
                .id(orderGroup.getId())
                .status(orderGroup.getStatus().getTitle())
                .orderType(orderGroup.getOrderType().getTitle())
                .receiveName(delivery.getReceiveName())
                .paymentType(orderGroup.getPaymentType().getTitle())
                .totalPrice(orderGroup.getTotalPrice())
                .totalQuantity(orderGroup.getTotalQuantity())
                .orderAt(orderGroup.getOrderAt())
                .arrivalDate(delivery.getArriveDate())
                .build();

        response.setOrder(delivery);
        response.setOrderDetailList(itemName);
        return Optional.of(response);
    }

    // 장바구니 전체 변경-> 장바구니 내 상품 당 삭제/변경
    private Optional<OrderDetailListApiResponse> orderDetailListApiResponse(List<OrderDetail> orderDetails, Long orderGroupId) {
        List<OrderItem> orderItems = new ArrayList<>();
        for (OrderDetail orderDetail : orderDetails) {
            orderItems.add(OrderItem.of(orderDetail.getItem().getId(), orderDetail.getQuantity(), orderDetail.getTotalPrice()));
        }
        return Optional.of(new OrderDetailListApiResponse(orderItems, orderGroupId));
    }
}
