package com.sh.adm.service;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.ifs.CrudInterface;
import com.sh.adm.model.entity.OrderGroup;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.response.OrderGroupApiResponse;
import com.sh.adm.repository.OrderGroupRepository;
import com.sh.adm.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import java.time.LocalDateTime;

public class OrderGroupApiLogicServiceTest extends AdmApplicationTests implements CrudInterface<OrderGroupApiRequest, OrderGroupApiResponse> {

    @Autowired
    OrderGroupRepository orderGroupRepository;
    @Autowired
    UserRepository userRepository;


    @Override
    @Test
    public Header<OrderGroupApiResponse> create(Header<OrderGroupApiRequest> request) {
        OrderGroupApiRequest body = request.getData();   // Optional

        if (body != null) {
            OrderGroup ogEntity = OrderGroup.builder()
                    .status(body.getStatus())
                    .orderType(body.getOrderType())
                    .revAddress(body.getRevAddress())
                    .revName(body.getRevName())
                    .paymentType(body.getPaymentType())
                    .totalPrice(body.getTotalPrice())
                    .totalQuantity(body.getTotalQuantity())
                    .orderAt(LocalDateTime.now())
                    .user(userRepository.getOne(body.getUserId()))   // 실제는 받지 않음
                    .build();
            OrderGroup newOG = orderGroupRepository.save(ogEntity);
            return response(newOG);
        }
        return Header.error("No data exsited");
    }

    @Override
    @Test
    public Header<OrderGroupApiResponse> read(Long id) {
        // 목록 중 클릭된 row의 id 받아서 상세 정보 제공

        return orderGroupRepository.findById(id)
                .map(this::response)
                .orElseGet(() -> Header.error("No data existed"));
    }

    @Override
    @Test
    public Header<OrderGroupApiResponse> update(Header<OrderGroupApiRequest> request) {
        // 상세정보에서 수정 -> id로 DB data -> upated -> response
        OrderGroupApiRequest body = request.getData();
        return orderGroupRepository.findById(body.getId())
                .map(entity -> {
                    entity.setStatus(body.getStatus())
                            .setOrderType(body.getOrderType())
                            .setRevAddress(body.getRevAddress())
                            .setRevName(body.getRevName())
                            .setPaymentType(body.getPaymentType())
                            .setTotalPrice(body.getTotalPrice())
                            .setTotalQuantity(body.getTotalQuantity())
                            .setOrderAt(body.getOrderAt())
                            .setArrivalDate(body.getArrivalDate())
                            .setUser(userRepository.getOne(body.getId()));
                    return entity;
                }).map(this::response)
                .orElseGet(() -> Header.error("No data existed"));
    }

    @Override
    @Test
    public Header delete(Long id) {
        return orderGroupRepository.findById(id)
                .map(entity -> {
                    orderGroupRepository.delete(entity);
                    return Header.OK();
                }).orElseGet(() -> Header.error("No data existed"));
    }

    private Header<OrderGroupApiResponse> response(OrderGroup og){
        OrderGroupApiResponse body = OrderGroupApiResponse.builder()
                .status(og.getStatus())
                .orderType(og.getOrderType())
                .revAddress(og.getRevAddress())
                .revName(og.getRevName())
                .paymentType(og.getPaymentType())
                .totalPrice(og.getTotalPrice())
                .totalQuantity(og.getTotalQuantity())
                .orderAt(og.getOrderAt())
                .arrivalDate(og.getArrivalDate())
                .build();

        return Header.OK(body);
    }
}
