package com.sh.adm.service;

import com.sh.adm.ifs.CrudInterface;
import com.sh.adm.model.entity.OrderDetail;
import com.sh.adm.model.entity.OrderGroup;
import com.sh.adm.model.entity.User;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.response.OrderGroupApiResponse;
import com.sh.adm.model.network.response.UserApiResponse;
import com.sh.adm.repository.ItemRepository;
import com.sh.adm.repository.OrderDetailRepository;
import com.sh.adm.repository.OrderGroupRepository;
import com.sh.adm.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Description;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
public class OrderApiLogicService implements CrudInterface<OrderGroupApiRequest, OrderGroupApiResponse> {

    private final UserRepository userRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final OrderGroupRepository orderGroupRepository;

    @Override
    public Header<OrderGroupApiResponse> create(Header<OrderGroupApiRequest> request) {
        // 조회
        OrderGroupApiRequest requestBody = request.getData();
        User user = userRepository.findById(requestBody.getUserId()).orElseThrow(() -> new RuntimeException("No User data"));
        // 기본 장바구니 (사용자 처음 가입시)
        OrderGroup newOrderGroup = orderGroupRepository.save(OrderGroup.createOrderGroup(user));
        return Header.OK(response(newOrderGroup));
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
                .revAddress(orderGroup.getRevAddress())
                .revName(orderGroup.getRevName())
                .paymentType(orderGroup.getPaymentType())
                .totalPrice(orderGroup.getTotalPrice())
                .totalQuantity(orderGroup.getTotalQuantity())
                .orderAt(orderGroup.getOrderAt())
                .arrivalDate(orderGroup.getArrivalDate())
                .build();
        return body;
//        return Header.OK(userApiResponse);
    }
}
