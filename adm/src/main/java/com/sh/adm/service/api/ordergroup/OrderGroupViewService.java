package com.sh.adm.service.api.ordergroup;

import com.sh.adm.model.network.response.OrderGroupApiResponse;

import java.util.Optional;

public interface OrderGroupViewService {

    Optional<OrderGroupApiResponse> readOrder(Long id);
}
