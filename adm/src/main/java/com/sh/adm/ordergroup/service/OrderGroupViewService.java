package com.sh.adm.ordergroup.service;

import com.sh.adm.ordergroup.model.dto.OrderGroupApiResponse;

import java.util.Optional;

public interface OrderGroupViewService {

    Optional<OrderGroupApiResponse> readOrder(Long id);
}
