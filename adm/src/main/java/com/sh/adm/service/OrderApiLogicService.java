package com.sh.adm.service;

import com.sh.adm.ifs.CrudInterface;
import com.sh.adm.model.entity.OrderGroup;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.response.OrderGroupApiResponse;
import com.sh.adm.repository.OrderDetailRepository;
import com.sh.adm.repository.OrderGroupRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class OrderApiLogicService implements CrudInterface<OrderGroupApiRequest, OrderGroupApiResponse> {

    private final OrderDetailRepository orderDetailRepository;
    private final OrderGroupRepository orderGroupRepository;

    @Override
    public Header<OrderGroupApiResponse> create(Header<OrderGroupApiRequest> request) {
        // 조회
        OrderGroupApiRequest requestBody = request.getData();
        return Header.OK();
    }

    // 사용자 장바구니 조회

    // 주문시 / 주문 후 주문확인 조회
    @Override
    public Header<OrderGroupApiResponse> read(Long id) {
        return null;
    }

    // 상품 추가, 최종 주문 전 상태까지
    @Override
    public Header<OrderGroupApiResponse> update(Header<OrderGroupApiRequest> request) {
        OrderGroupApiRequest requestBody = request.getData();





        return null;
    }

    @Override
    public Header delete(Long id) {
        return null;
    }

    private OrderGroupApiResponse response(OrderGroup orderGroup) {
        OrderGroupApiResponse body = OrderGroupApiResponse.builder()
                .status(orderGroup.getStatus())
                .orderType(orderGroup.getOrderType())
                .paymentType(orderGroup.getPaymentType())
                .totalPrice(orderGroup.getTotalPrice())
                .totalQuantity(orderGroup.getTotalQuantity())
                .orderAt(orderGroup.getOrderAt())
                .build();
        return body;
//        return Header.OK(userApiResponse);
    }
}
