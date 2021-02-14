package com.sh.adm.service;

import com.sh.adm.model.dto.Address;
import com.sh.adm.model.entity.*;
import com.sh.adm.model.enumclass.DeliveryStatus;
import com.sh.adm.model.enumclass.OrderStatus;
import com.sh.adm.model.network.Header;
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

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Slf4j
@Service
@RequiredArgsConstructor
public class OrderGroupApiLogicService{

    private final OrderGroupRepository orderGroupRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final ItemRepository itemRepository;
    private final DeliveryRepository deliveryRepository;
    private final UserRepository userRepository;

    @Transactional
    public Header<OrderDetailApiResponse> addToOrderDetail(Header<OrderDetailApiRequest> request) {
        /**
         * 상품 목록 보며 사용자가 하나의 상품 장바구니 담기
         *  가입한 사용자의 첫 구입 ->  order_group_id 생성
         *  장바구니에 다른 새 상품 추가 ->  order_group_id 연결, order_detail_id 생성
         *  장바구니에 기존 상품 동일 추가 ->  orderDetail.updateOrderDetail() [수량 추가]
         */
        OrderDetailApiRequest body = request.getData();
        Item  item = itemRepository.findById(body.getItemId()).orElseThrow(() -> new RuntimeException("No item data"));

        if (ObjectUtils.isEmpty(body.getOrderGroupId())){
            OrderDetail orderDetail1 = OrderDetail.createOrderDetail(item, body.getQuantity());
            User user = userRepository.findById(body.getUserId()).orElseThrow(() -> new RuntimeException("No User Info"));

            orderGroupRepository.save(OrderGroup.createOrderGroup(user, orderDetail1));
            orderDetailRepository.save(orderDetail1);
            return orderDetailResponse(orderDetail1);
        }
        
        // if order_group_id 존재 ->  item_id 조회
        return orderDetailRepository.findByOrderGroupIdAndItemId(body.getItemId(), item.getId())
                .map(orderDetail -> {    // order_detail_id 에 item 수량 변경
                    orderDetail.updateOrderDetail(item, body.getQuantity());
                    log.info("check, item changed >> {}",item);
                    return orderDetail;
                }).map(this::orderDetailResponse)
                .orElseGet(() ->
                        { // order_detail 생성
                            OrderGroup orderGroup = orderGroupRepository.findById(body.getOrderGroupId()).orElseThrow(() -> new RuntimeException("No Cart data"));
                            OrderDetail newOrderDetail = OrderDetail.createOrderDetail(item, body.getQuantity());
                            newOrderDetail.setOrderGroup(orderGroup);
//                            log.info("check, item changed >> {}",item);
                            return orderDetailResponse(newOrderDetail);
                        });
    }

    @Transactional
    public Header<OrderDetailListApiResponse> updateCart(Header<OrderDetailListApiRequest> request) {
        // TODO 추가 상품 & 삭제 상품
        OrderDetailListApiRequest body = request.getData();
        List<OrderDetail> orderDetails = orderDetailRepository.findByOrderGroupIdOrderByItemIdAsc(body.getOrder_group_id());
        int length = orderDetails.size();
        if (length> 1) {
            List<OrderItem> bodyItems = body.getItems();
            bodyItems.sort(Comparator.comparing(OrderItem::getItem_id));
            if (length >= bodyItems.size()) {
                for (int i = 0; i < bodyItems.size(); i++) {
                    OrderDetail orderDetail = orderDetails.get(i);
                    OrderItem bodyItem = bodyItems.get(i);
                    if(orderDetail.getItem().getId().equals(bodyItem.getItem_id())
                            && (orderDetail.getQuantity() != bodyItem.getQuantity()) )
                        orderDetail.updateOrderDetail( orderDetail.getItem() ,bodyItem.getQuantity());
                }
                return orderDetailListApiResponseHeader(orderDetails, body.getOrder_group_id());
            }
        }
        return Header.error("No data exist");
    }

    // 사용자 장바구니 조회
    @Transactional
    public Header<OrderGroupApiResponse> order(Header<OrderGroupApiRequest> request) {
        // 조회
        OrderGroupApiRequest body = request.getData();

        OrderGroup orderGroup = orderGroupRepository.findById(body.getId()).orElseThrow(() -> new RuntimeException("No Order data"));
        if( orderGroup.getStatus().equals(OrderStatus.ORDERING) ){
            List<OrderDetail> orderDetailList = orderDetailRepository.findByOrderGroupIdOrderByCreatedAtDesc(orderGroup.getId());
            Delivery delivery = Delivery.of(Address.of(body.getCity(), body.getStreet(), body.getZipcode()), body.getReceiveName(),orderGroup);
        // 주문 내역 정리
            orderGroup.setOrder(delivery);
            orderGroup.updateOrder(body);
            deliveryRepository.save(delivery);
            return response(orderGroup, delivery);
        }
        return Header.error("No data exist");
    }

    // 주문시 / 주문 후 주문확인 조회
    @Transactional(readOnly = true)
    public Header<OrderGroupApiResponse> readOrder(Long id) {
        return orderGroupRepository.findById(id)
                .map(orderGroup -> response(orderGroup, orderGroup.getDelivery()))
                .orElseGet(() -> Header.error("No data exist"));
    }

    @Transactional
    public Header<OrderGroupApiResponse> modifyOrder(Header<OrderGroupApiRequest> request) {
        OrderGroupApiRequest requestBody = request.getData();
        return Optional.ofNullable(requestBody)
                .map(body -> {
                    OrderGroup orderGroup = orderGroupRepository.findById(body.getId()).orElseThrow(() -> new RuntimeException("No Order Information"));
                    orderGroup.updateOrder(body);
                    return orderGroup;
                }).map(orderGroup -> response(orderGroup,orderGroup.getDelivery()))
                .orElseGet(()->Header.error("No request data"));
    }

    @Transactional
    public Header cancelOrder(Long id) {
        // 장바구니 삭제
        // item 제고 원상복구
        return orderGroupRepository.findById(id)
                .map(orderGroup -> {
                    orderGroup.cancel();
                    int totalQuantity = orderGroup.getTotalQuantity();
                    orderGroupRepository.deleteById(id);
                    return 0;
                })
                .map(Header::OK)
                .orElseGet(() -> Header.error("No Data exist"));
    }

    private Header<OrderDetailApiResponse> orderDetailResponse(OrderDetail orderDetail) {
        return Header.OK(new OrderDetailApiResponse(orderDetail.getQuantity(),orderDetail.getTotalPrice()));
    }

    private Header<OrderDetailListApiResponse> orderDetailListApiResponseHeader(List<OrderDetail> orderDetails, Long orderGroupId) {
        List<OrderItem> orderItems = new ArrayList<>();
        for (OrderDetail orderDetail : orderDetails) {
            orderItems.add(OrderItem.of(orderDetail.getItem().getId(), orderDetail.getQuantity(), orderDetail.getTotalPrice()));
        }
        OrderDetailListApiResponse body = new OrderDetailListApiResponse(orderItems, orderGroupId);
        return Header.OK(body);
    }

    private Header<OrderGroupApiResponse> response(OrderGroup orderGroup, Delivery delivery) {
        OrderGroupApiResponse body = OrderGroupApiResponse.builder()
                .status(orderGroup.getStatus())
                .orderType(orderGroup.getOrderType())
                .paymentType(orderGroup.getPaymentType())
                .totalPrice(orderGroup.getTotalPrice())
                .totalQuantity(orderGroup.getTotalQuantity())
                .orderAt(orderGroup.getOrderAt())
                .build();
        body.setOrder(delivery);
        return Header.OK(body);
    }
}
