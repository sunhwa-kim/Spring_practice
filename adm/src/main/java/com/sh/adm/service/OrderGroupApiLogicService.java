package com.sh.adm.service;

import com.sh.adm.ifs.CrudInterface;
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
    public Header<OrderDetailApiResponse> createOrderDetail(Header<OrderDetailApiRequest> request) {
        OrderDetailApiRequest body = request.getData();

        Optional<OrderDetail> getOrderDetail = orderDetailRepository.findByItemIdAndOrderGroupId(body.getItemId(), body.getOrderGroupId());
        Item getItem = itemRepository.getOne(body.getItemId());
        if( getOrderDetail.isEmpty() ) {
            OrderDetail orderDetail = OrderDetail.createOrderDetail(getItem, body.getQuantity());
            OrderGroup  getOrderGroup = orderGroupRepository.getOne(body.getOrderGroupId());
            getOrderGroup.setOrderDetails(orderDetail);
            /**
             * 영속성 컨택스트 : orderDetailRepository 결과 orderGroupId 정보 확인, orderGroupRepository 결과 orderDetail 확인
             */
            return Header.OK(new OrderDetailApiResponse(orderDetail.getItem().getId()));
        }
        else{
            getOrderDetail.get().updateAddOrderDetail(body.getQuantity(), getItem);
            return Header.OK(new OrderDetailApiResponse(request.getData().getItemId()));
        }
    }

    @Transactional
    public Header<OrderDetailApiResponse> updateCart(Long orderDetailId, int updatedCount) {

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
