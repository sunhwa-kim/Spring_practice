package com.sh.adm.ordergroup.service;

import com.sh.adm.ordergroup.entity.OrderGroup;
import com.sh.adm.ordergroup.dto.OrderGroupApiResponse;
import com.sh.adm.ordergroup.repository.OrderGroupRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class OrderGroupViewServiceImpl implements OrderGroupViewService {

    private final OrderGroupRepository orderGroupRepository;

    @Override
    public Optional<OrderGroupApiResponse> readOrder(Long id) {
        return orderGroupRepository.findById(id)
                .map(this::response);
    }

    private OrderGroupApiResponse response(OrderGroup orderGroup) {
        OrderGroupApiResponse body = OrderGroupApiResponse.builder()
                .id(orderGroup.getId())
                .status(orderGroup.getStatus().getTitle())
                .orderType(orderGroup.getOrderType().getTitle())
                .paymentType(orderGroup.getPaymentType().getTitle())
                .totalPrice(orderGroup.getTotalPrice())
                .totalQuantity(orderGroup.getTotalQuantity())
                .orderAt(orderGroup.getOrderAt())
                .build();
        body.setOrder(orderGroup.getDelivery());
        return body;
    }
}
