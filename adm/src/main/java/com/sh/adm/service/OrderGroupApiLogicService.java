package com.sh.adm.service;

import com.sh.adm.ifs.CrudInterface;
import com.sh.adm.model.dto.Address;
import com.sh.adm.model.entity.OrderGroup;
import com.sh.adm.model.entity.User;
import com.sh.adm.model.enumclass.OrderStatus;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.response.OrderGroupApiResponse;
import com.sh.adm.repository.DeliveryRepository;
import com.sh.adm.repository.OrderGroupRepository;
import com.sh.adm.repository.UserRepository;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RequiredArgsConstructor
public class OrderGroupApiLogicService implements CrudInterface<OrderGroupApiRequest, OrderGroupApiResponse> {

    private final OrderGroupRepository orderGroupRepository;
    private final DeliveryRepository deliveryRepository;
    private final UserRepository userRepository;

    @Override
    public Header<OrderGroupApiResponse> create(Header<OrderGroupApiRequest> request) {
        // 조회
        OrderGroupApiRequest requestBody = request.getData();
        Optional<User> getUser = userRepository.findById(requestBody.getUserId());

        // view form 태그 통해 받겠지
        if (getUser.get().getOrderGroupList().size() <= 0) {
            OrderGroup newOrderGroup = orderGroupRepository.save(OrderGroup.initOrderGroup(userRepository.getOne(requestBody.getUserId())));
            return response(newOrderGroup);
        }
        else {
//            OrderStatus.ORDERING, orderGroupList.get(-1)
            List<OrderGroup> orderGroupList = orderGroupRepository.findByUserId(requestBody.getUserId());
            List<OrderGroup> ordering = orderGroupList.stream().filter(orderGroup -> orderGroup.getStatus().equals(OrderStatus.ORDERING)).collect(Collectors.toUnmodifiableList());

            return response(null);
        }
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
        Optional<OrderGroup> byId = orderGroupRepository.findById(requestBody.getId());

        Address reqAddress = Address.of(requestBody.getCity(), requestBody.getStreet(), requestBody.getZipcode());

        return Optional.ofNullable(request.getData())
                .map( body -> {
                    return orderGroupRepository.findById(body.getId())
                            .map(orderGroup -> {
                                orderGroup.getDelivery().stream().filter(delivery -> !delivery.getReceiveAddress().equals(reqAddress))
                                        .map(deliveryRepository::save);
//                                .collect(Collectors.toList())
                                orderGroup.getTotalQuantity();
                                orderGroup.getTotalPrice();
                                return orderGroup;
                            }).map(this::response)
                            .orElseGet(() -> Header.error("No data existed"));
                }).orElseGet(() -> Header.error("No data existed"));
    }

    @Override
    public Header delete(Long id) {
        return null;
    }

    private Header<OrderGroupApiResponse> response(OrderGroup orderGroup) {
        OrderGroupApiResponse body = OrderGroupApiResponse.builder()
                .status(orderGroup.getStatus())
                .orderType(orderGroup.getOrderType())
                .paymentType(orderGroup.getPaymentType())
                .totalPrice(orderGroup.getTotalPrice())
                .totalQuantity(orderGroup.getTotalQuantity())
                .orderAt(orderGroup.getOrderAt())
                .build();
        return Header.OK(body);
//        return Header.OK(userApiResponse);
    }
}
