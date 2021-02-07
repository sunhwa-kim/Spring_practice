package com.sh.adm.service;

import com.sh.adm.model.dto.Address;
import com.sh.adm.model.entity.Item;
import com.sh.adm.model.entity.OrderDetail;
import com.sh.adm.model.entity.OrderGroup;
import com.sh.adm.model.enumclass.OrderStatus;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.OrderDetailApiRequest;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.response.OrderDetailApiResponse;
import com.sh.adm.model.network.response.OrderGroupApiResponse;
import com.sh.adm.repository.*;
import lombok.RequiredArgsConstructor;
import org.aspectj.weaver.ast.Or;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

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
         *  가입한 사용자의 첫 구입시
         *  장바구니에 다른 새 상품 추가시
         *  장바구니에 기존 상품 동일 추가시 -  exception 이미 존재 ||  orderDetail.updateOrderDetail() [수량 추가]  ??
         */
        OrderDetailApiRequest body = request.getData();
        // if order_group_id 없음 -> OrderGroup.createOrderGroup( user, orderDetail)
        int size = orderGroupRepository.findByStatusAndUserId(OrderStatus.ORDERING, body.getUserId()).size();
        if (size <= 0){
            OrderDetail orderDetail1 = OrderDetail.createOrderDetail(itemRepository.getOne(body.getItemId()), body.getQuantity());
            OrderGroup.createOrderGroup(userRepository.getOne(body.getUserId()), orderDetail1);
            orderDetailRepository.save(orderDetail1);
            return Header.OK(new OrderDetailApiResponse(orderDetail1.getQuantity()));
        }
        
        // if order_group_id 존재 ->  item_id 조회
        // if order_detail_id 존재 -> order_detail_id 에 item 수량 변경
        orderDetailRepository.findByItemIdAndOrderGroupId(body.getItemId(), body.getOrderGroupId())
                .map(orderDetail -> {
                    orderDetail.updateOrderDetail(itemRepository.getOne(body.getItemId()), body.getQuantity());
                    OrderGroup getOrderGroup = orderGroupRepository.getOne(body.getOrderGroupId());
                    getOrderGroup.getTotalPrice();
                    getOrderGroup.getTotalQuantity();
                    return orderDetail.getQuantity();
                }).map(quantity -> new OrderDetailApiResponse(quantity))
                .map(Header::OK)
                .orElseGet(() ->
                        {
                            OrderDetail orderDetail1 = OrderDetail.createOrderDetail(itemRepository.getOne(body.getItemId()), body.getQuantity());
                            orderDetail1.setOrderGroup(orderGroupRepository.getOne(body.getOrderGroupId()));
                            return Header.OK(new OrderDetailApiResponse(orderDetail1.getQuantity()));
                        });
        /**
         *  orderDetail 저장 확인
         */
        return Header.error("Can't add to cart");
    }

    @Transactional
    public Header<OrderDetailApiResponse> updateCart(Long orderDetailId, int updatedCount) {
        /**
         * 장바구니 확인하기 - form 내 item 수량 변경시
         */

        return Header.OK(new OrderDetailApiResponse());
    }

    public Header<OrderGroupApiResponse> order(Header<OrderGroupApiRequest> request) {
        // 조회

        // 장바구니 담는 상품 등록
        // OrderDetail 내 동일 item 없을 때



        // OrderDetail 내 동일 item 있을 때
        return response(null);
    }

    // 사용자 장바구니 조회

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
//                                .collect(Collectors.toList())
                                orderGroup.getTotalQuantity();
                                orderGroup.getTotalPrice();
                                return orderGroup;
                            }).map(this::response)
                            .orElseGet(() -> Header.error("No data existed"));
                }).orElseGet(() -> Header.error("No data existed"));
    }

    public Header cancelOrder(Long id) {
        return null;
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
//        return Header.OK(userApiResponse);
    }
}
