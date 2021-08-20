package com.sh.adm.ordergroup.service;

import com.sh.adm.ordergroup.model.dto.OrderGroupApiRequest;
import com.sh.adm.ordergroup.model.dto.OrderGroupApiResponse;

import java.util.Optional;

public interface OrderGroupSaveService {
    OrderGroupApiResponse order(OrderGroupApiRequest request);

    Optional<OrderGroupApiResponse> modifyOrder(OrderGroupApiRequest request);

    void cancelOrder(Long id);
}
