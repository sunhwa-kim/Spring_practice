package com.sh.adm.service.ordergroup;

import com.sh.adm.model.entity.Delivery;
import com.sh.adm.model.entity.OrderGroup;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.OrderDetailApiRequest;
import com.sh.adm.model.network.response.OrderDetailApiResponse;
import com.sh.adm.model.network.response.OrderGroupApiResponse;
import com.sh.adm.repository.OrderGroupRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class OrderGroupViewServiceImpl implements OrderGroupViewService{

    private final OrderGroupRepository orderGroupRepository;

    @Override
    public Optional<OrderGroupApiResponse> readOrder(Long id) {
        return orderGroupRepository.findById(id)
                .map(this::response);
    }


    private OrderGroupApiResponse response(OrderGroup orderGroup) {
        OrderGroupApiResponse body = OrderGroupApiResponse.builder()
                .id(orderGroup.getId())
                .status(orderGroup.getStatus())
                .orderType(orderGroup.getOrderType())
                .paymentType(orderGroup.getPaymentType())
                .totalPrice(orderGroup.getTotalPrice())
                .totalQuantity(orderGroup.getTotalQuantity())
                .orderAt(orderGroup.getOrderAt())
                .build();
        body.setOrder(orderGroup.getDelivery());
        return body;
    }
}
