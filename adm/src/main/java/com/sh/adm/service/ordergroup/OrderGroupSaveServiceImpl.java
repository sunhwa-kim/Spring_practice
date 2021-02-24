package com.sh.adm.service.ordergroup;

import com.sh.adm.exception.ItemNotFoundException;
import com.sh.adm.exception.OrderGroupNotFoundException;
import com.sh.adm.exception.UserNotFoundException;
import com.sh.adm.exception.dto.OrderDetailNotFoundException;
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
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import java.util.*;
import java.util.stream.IntStream;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class OrderGroupSaveServiceImpl implements OrderGroupSaveService{
    private final ItemRepository itemRepository;
    private final UserRepository userRepository;

    private final OrderDetailRepository orderDetailRepository;
    private final OrderGroupRepository orderGroupRepository;
    private final DeliveryRepository deliveryRepository;

    @Override
    public void addToOrderDetail(OrderDetailApiRequest request) {
        Item item = itemRepository.findById(request.getItemId()).orElseThrow(ItemNotFoundException::new);

        // 장바구니 생성
        if (ObjectUtils.isEmpty(request.getOrderGroupId())){
            OrderDetail orderDetail1 = OrderDetail.createOrderDetail(item, request.getQuantity());
            User user = userRepository.findById(request.getUserId()).orElseThrow(UserNotFoundException::new);  // TODO Controller
            orderGroupRepository.save(OrderGroup.createOrderGroup(user, orderDetail1));
            OrderDetail getOrderDetail = orderDetailRepository.save(orderDetail1);
        }
        else{ // 장바구니 내 상품 유/무
            OrderDetail orderDetail = orderDetailRepository.findByOrderGroupIdAndItemId(request.getItemId(), item.getId());
            if(ObjectUtils.isEmpty(orderDetail)){
                OrderGroup orderGroup = orderGroupRepository.findById(request.getOrderGroupId()).orElseThrow(OrderGroupNotFoundException::new);
                OrderDetail newOrderDetail = OrderDetail.createOrderDetail(item, request.getQuantity());
                newOrderDetail.setOrderGroup(orderGroup);
            }else{
                orderDetail.updateOrderDetail(item, request.getQuantity());
            }
        }
    }

    @Override
    public OrderDetailApiResponse modifyCart(OrderDetailApiRequest request) {
        OrderDetail orderDetail = orderDetailRepository.findByOrderGroupIdAndItemId(request.getOrderGroupId(), request.getItemId());
        if(ObjectUtils.isEmpty(orderDetail)) throw new OrderGroupNotFoundException();
        Item item = itemRepository.findById(request.getItemId()).orElseThrow(ItemNotFoundException::new);
        orderDetail.updateOrderDetail(item, request.getQuantity());
        return orderDetailResponse(request, orderDetail);
    }

    @Override
    public void deleteCart(OrderDetailApiRequest request) {
        OrderDetail orderDetail = orderDetailRepository.findByOrderGroupIdAndItemId(request.getOrderGroupId(), request.getItemId());
        if(ObjectUtils.isEmpty(orderDetail)) throw new OrderGroupNotFoundException();
        orderDetail.cancel();
        orderDetail.setOrderGroup(null);
        orderDetailRepository.delete(orderDetail);
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
            orderGroup.createOrder(delivery, body.getOrderType(), body.getPaymentType());
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
                .orderStatus(orderDetail.getStatus())
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
