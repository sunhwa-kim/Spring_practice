package com.sh.adm.ordergroup.service;

import com.sh.adm.deliverry.entity.Delivery;
import com.sh.adm.deliverry.repository.DeliveryRepository;
import com.sh.adm.common.policy.discount.DiscountPolicy;
import com.sh.adm.ordergroup.exception.OrderGroupNotFoundException;
import com.sh.adm.orderdetail.entity.OrderDetail;
import com.sh.adm.orderdetail.repository.OrderDetailRepository;
import com.sh.adm.orderdetail.exception.OrderDetailNotFoundException;
import com.sh.adm.ordergroup.enumclass.OrderStatus;
import com.sh.adm.orderdetail.dto.OrderDetailListApiRequest;
import com.sh.adm.ordergroup.model.dto.OrderGroupApiRequest;
import com.sh.adm.user.model.network.request.OrderItem;
import com.sh.adm.orderdetail.dto.OrderDetailListApiResponse;
import com.sh.adm.ordergroup.model.dto.OrderGroupApiResponse;
import com.sh.adm.ordergroup.model.entity.OrderGroup;
import com.sh.adm.ordergroup.repository.OrderGroupRepository;
import com.sh.adm.user.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.IntStream;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class OrderGroupSaveServiceImpl implements OrderGroupSaveService {
    private final UserService userService;

    private final OrderDetailRepository orderDetailRepository;
    private final OrderGroupRepository orderGroupRepository;
    private final DeliveryRepository deliveryRepository;
    private final DiscountPolicy discountPolicy;

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
