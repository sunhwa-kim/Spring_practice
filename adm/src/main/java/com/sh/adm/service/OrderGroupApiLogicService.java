package com.sh.adm.service;

import com.sh.adm.model.dto.Address;
import com.sh.adm.model.entity.*;
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
            User user = userRepository.findById(body.getUserId()).orElseThrow(() -> new RuntimeException("No Cart data"));

            orderGroupRepository.save(OrderGroup.createOrderGroup(user, orderDetail1));
            orderDetailRepository.save(orderDetail1);
//            log.info("check, item changed >> {}",item);
            return orderDetailResponse(orderDetail1);
        }
        
        // if order_group_id 존재 ->  item_id 조회
        // if  order_detail_id 존재 -> order_detail_id 에 item 수량 변경
        // else  order_detail_id 없음 -> order_detail 생성
        return orderDetailRepository.findByItemIdAndOrderGroupId(body.getItemId(), body.getId())
                .map(orderDetail -> {
                    orderDetail.updateOrderDetail(item, body.getQuantity());
//                    log.info("check, item changed >> {}",item);
                    return orderDetail;
                }).map(this::orderDetailResponse)
                .orElseGet(() ->
                        {
                            OrderGroup orderGroup = orderGroupRepository.findById(body.getOrderGroupId()).orElseThrow(() -> new RuntimeException("No Cart data"));
                            OrderDetail newOrderDetail = OrderDetail.createOrderDetail(item, body.getQuantity());
                            newOrderDetail.setOrderGroup(orderGroup);
//                            log.info("check, item changed >> {}",item);
                            return orderDetailResponse(newOrderDetail);
                        });
    }

    @Transactional
    public Header<OrderDetailListApiResponse> updateCart(Header<OrderDetailListApiRequest> request) {
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
                return orderDetailListApiResponseHeader(orderDetails);
            }
        }
        return Header.error("No data existed");
    }

    private Header<OrderDetailListApiResponse> orderDetailListApiResponseHeader(List<OrderDetail> orderDetails) {
        List<OrderItem> orderItems = new ArrayList<>();
        for (OrderDetail orderDetail : orderDetails) {
            orderItems.add(OrderItem.of(orderDetail.getItem().getId(), orderDetail.getQuantity()));
        }
        OrderDetailListApiResponse body = new OrderDetailListApiResponse(orderItems, orderDetails.get(0).getOrderGroup().getId());
        return Header.OK(body);
    }

    // 사용자 장바구니 조회
    @Transactional
    public Header<OrderGroupApiResponse> order(Header<OrderGroupApiRequest> request) {
        // 조회
        OrderGroupApiRequest body = request.getData();
        Address address = Address.of(body.getCity(), body.getStreet(), body.getZipcode());

        OrderGroup orderGroup = orderGroupRepository.findById(body.getId()).orElseThrow(() -> new RuntimeException("No Order data"));
        if( orderGroup.getStatus().equals(OrderStatus.ORDERING) ){
            List<OrderDetail> orderDetailList = orderDetailRepository.findByOrderGroupIdOrderByCreatedAtDesc(orderGroup.getId());
            Delivery delivery = new Delivery(address, body.getReceiveName(),orderGroup);
        // 주문 내역 정리
            orderGroup.takeAnOrder(delivery, orderDetailList);
            orderGroup.setOrderType(body.getOrderType());
            orderGroup.setPaymentType(body.getPaymentType());
            deliveryRepository.save(delivery);
            return response(orderGroup);
        }
        return Header.error("No data existed");
    }

    // 주문시 / 주문 후 주문확인 조회
    public Header<OrderGroupApiResponse> checkOrder(Long id) {
        return null;
    }

    // 상품 추가, 최종 주문 전 상태까지
    public Header<OrderGroupApiResponse> updateOrder(Header<OrderGroupApiRequest> request) {
        OrderGroupApiRequest requestBody = request.getData();
        Optional<OrderGroup> byId = orderGroupRepository.findById(requestBody.getId());

        Address reqAddress = Address.of(requestBody.getCity(), requestBody.getStreet(), requestBody.getZipcode());

        return Optional.ofNullable(request.getData())
                .map( body -> {
                    return orderGroupRepository.findById(body.getId())
                            .map(orderGroup -> {
                                orderGroup.getDelivery().stream().filter(delivery -> !delivery.getReceiveAddress().equals(reqAddress))
                                        .map(deliveryRepository::save);
                                return orderGroup;
                            }).map(this::response)
                            .orElseGet(() -> Header.error("No data existed"));
                }).orElseGet(() -> Header.error("No data existed"));
    }

    public Header cancelOrder(Long id) {
        return null;
    }


    private Header<OrderDetailApiResponse> orderDetailResponse(OrderDetail orderDetail) {
        log.info("new OrderDetail >> {}",orderDetail);
        return Header.OK(new OrderDetailApiResponse(orderDetail.getQuantity(),orderDetail.getTotalPrice()));
    }

    private Header<OrderGroupApiResponse> response(OrderGroup orderGroup) {
        OrderGroupApiResponse body = OrderGroupApiResponse.builder()
                .status(orderGroup.getStatus())
                .orderType(orderGroup.getOrderType())
                .paymentType(orderGroup.getPaymentType())
                .totalPrice(orderGroup.getTotalPrice())
                .totalQuantity(orderGroup.getTotalQuantity())
                .orderAt(orderGroup.getOrderAt())
                .build();
        return Header.OK(body);
    }
}
