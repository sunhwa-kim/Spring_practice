package com.sh.adm.service.ordergroup;

import com.sh.adm.exception.ItemNotFoundException;
import com.sh.adm.exception.OrderGroupNotFoundException;
import com.sh.adm.exception.UserNotFoundException;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.OrderDetailApiRequest;
import com.sh.adm.model.network.request.OrderDetailListApiRequest;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.response.OrderDetailListApiResponse;
import com.sh.adm.model.network.response.OrderGroupApiResponse;

import java.util.Optional;

public interface OrderGroupSaveService {
    void addToOrderDetail(Header<OrderDetailApiRequest> request) throws ItemNotFoundException, UserNotFoundException, OrderGroupNotFoundException;

    OrderDetailListApiResponse updateCart(OrderDetailListApiRequest request);

    Optional<OrderGroupApiResponse> order(Header<OrderGroupApiRequest> request);

    Optional<OrderGroupApiResponse> modifyOrder(Header<OrderGroupApiRequest> request);

    void cancelOrder(Long id);
}
