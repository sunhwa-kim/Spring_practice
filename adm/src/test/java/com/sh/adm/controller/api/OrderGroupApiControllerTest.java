package com.sh.adm.controller.api;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.ifs.CrudInterface;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.response.OrderGroupApiResponse;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class OrderGroupApiControllerTest extends AdmApplicationTests implements CrudInterface<OrderGroupApiRequest, OrderGroupApiResponse> {

    @Autowired

    @Override
    @Test
    public Header<OrderGroupApiResponse> create(Header<OrderGroupApiRequest> request) {
        return null;
    }

    @Override
    public Header<OrderGroupApiResponse> read(Long id) {
        return null;
    }

    @Override
    public Header<OrderGroupApiResponse> update(Header<OrderGroupApiRequest> request) {
        return null;
    }

    @Override
    public Header delete(Long id) {
        return null;
    }
}
