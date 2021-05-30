package com.sh.adm.service.api.ordergroup;

import com.sh.adm.exception.ItemNotFoundException;
import com.sh.adm.exception.OrderGroupNotFoundException;
import com.sh.adm.exception.UserNotFoundException;
import com.sh.adm.model.network.request.OrderDetailApiRequest;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.response.OrderDetailApiResponse;
import com.sh.adm.model.network.response.OrderGroupApiResponse;

import java.util.Optional;

public interface OrderGroupSaveService {
    void addToOrderDetail(OrderDetailApiRequest request) throws ItemNotFoundException, UserNotFoundException, OrderGroupNotFoundException;

    OrderDetailApiResponse modifyOrderDetail(Long orderGroupId, OrderDetailApiRequest request);

    void deleteCart(OrderDetailApiRequest request);

    OrderGroupApiResponse order(OrderGroupApiRequest request);

    Optional<OrderGroupApiResponse> modifyOrder(OrderGroupApiRequest request);

    void cancelOrder(Long id);
}
