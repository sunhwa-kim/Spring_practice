package com.sh.adm.service;

import com.sh.adm.model.dto.Address;
import com.sh.adm.model.entity.Item;
import com.sh.adm.model.entity.OrderDetail;
import com.sh.adm.model.entity.OrderGroup;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.OrderDetailApiRequest;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.response.OrderDetailApiResponse;
import com.sh.adm.model.network.response.OrderDetailsApiResponse;
import com.sh.adm.model.network.response.OrderGroupApiResponse;
import com.sh.adm.repository.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class OrderGroupApiLogicService{

    private final OrderGroupRepository orderGroupRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final ItemRepository itemRepository;
    private final DeliveryRepository deliveryRepository;
    private final UserRepository userRepository;

    @Transactional
    public Header<OrderDetailApiResponse> addToOrderDetail(Header<OrderDetailApiRequest> request) {
        /**
         * 상품 목록 보며 사용자가 하나의 상품 장바구니 담기
         *  가입한 사용자의 첫 구입시
         *  장바구니에 다른 새 상품 추가시
         *  장바구니에 기존 상품 동일 추가시 - orderDetail.updateOrderDetail() [수량 추가]
         */
        OrderDetailApiRequest body = request.getData();
        Item  item = itemRepository.findById(body.getItemId()).orElseThrow(() -> new RuntimeException("No item data"));
        // if order_group_id 없음 -> OrderGroup.createOrderGroup( user, orderDetail)
//        int size = orderGroupRepository.findByStatusAndUserId(OrderStatus.ORDERING, body.getUserId()).size();
        if (ObjectUtils.isEmpty(body.getOrderGroupId())){
            OrderDetail orderDetail1 = OrderDetail.createOrderDetail(item, body.getQuantity());
            orderGroupRepository.save(OrderGroup.createOrderGroup(userRepository.getOne(body.getUserId()), orderDetail1));
            orderDetailRepository.save(orderDetail1);
            log.info("check, item changed >> {}",item);
            return Header.OK(new OrderDetailApiResponse(orderDetail1.getQuantity()));
        }
        
        // if order_group_id 존재 ->  item_id 조회
        // if  order_detail_id 존재 -> order_detail_id 에 item 수량 변경
        // else  order_detail_id 없음 -> order_detail 생성
        return orderDetailRepository.findByItemIdAndOrderGroupId(body.getItemId(), body.getOrderGroupId())
                .map(orderDetail -> {
                    orderDetail.updateOrderDetail(item, body.getQuantity());
                    log.info("check, item changed >> {}",item);
                    return orderDetail;
                }).map(this::orderDetailResponse)
                .map(Header::OK)
                .orElseGet(() ->
                        {
                            OrderDetail orderDetail1 = OrderDetail.createOrderDetail(item, body.getQuantity());
                            orderDetail1.setOrderGroup(orderGroupRepository.getOne(body.getOrderGroupId()));
                            log.info("check, item changed >> {}",item);
                            return Header.OK(orderDetailResponse(orderDetail1));
                        });
        /**
         *  orderDetail 저장 확인
         */
    }

    @Transactional
    public Header<List<OrderDetailsApiResponse>> updateCart(Header<List<OrderDetailApiRequest>> request) {
        /**
         * 장바구니 확인하기 - form 내 item 수량 변경시
         */

        List<OrderDetailApiRequest> req = request.getData();
        Long orderGroupId = req.get(0).getOrderGroupId();
        Set<Long> setOrderGroupId = new HashSet<>();
        Map<Long, Integer> itemMap = new HashMap<>();
        List<Map<Long, Integer>> itemList = new ArrayList<Map<Long,Integer>>();
        if(!req.isEmpty()){
            for (OrderDetailApiRequest body : req) {
                setOrderGroupId.add(body.getOrderGroupId());
                itemMap.put(body.getItemId(), body.getQuantity());
                itemList.add(itemMap);
            }
        }

        if(setOrderGroupId.size()==1){
            List<OrderDetail> getOrderDetails = orderDetailRepository.findByOrderGroupIdOrderByCreatedAtDesc(orderGroupId);
            if (getOrderDetails.size()<=0) return Header.error("No data existed");
            for (int i = 0; i < itemList.size(); i++) {
                Map<Long, Integer> bodyItem = itemList.get(i);
                OrderDetail orderDetail = getOrderDetails.get(i);
                Long itemId = orderDetail.getItem().getId();
                log.info("item value 확인 >>{}",bodyItem.get(itemId));
                if (!bodyItem.get(itemId).equals(orderDetail.getQuantity())) {
                    orderDetail.updateOrderDetail(orderDetail.getItem(), bodyItem.get(itemId).intValue());
                    orderDetail.getOrderGroup().getTotalQuantity();   // 영속성 컨텍스트 변경 감지 확인
                    orderDetail.getOrderGroup().getTotalPrice();
                }
            }
            return orderDetailsResponse(getOrderDetails);
        }
        return Header.error("No data existed");
    }

    public Header<OrderGroupApiResponse> order(Header<OrderGroupApiRequest> request) {
        // 조회

        // 장바구니 담는 상품 등록
        // OrderDetail 내 동일 item 없을 때



        // OrderDetail 내 동일 item 있을 때
        return response(null);
    }

    // 사용자 장바구니 조회

    // 주문시 / 주문 후 주문확인 조회
    public Header<OrderGroupApiResponse> checkOrder(Long id) {
        return null;
    }

    // 상품 추가, 최종 주문 전 상태까지
    public Header<OrderGroupApiResponse> updateOrder(Header<OrderGroupApiRequest> request) {
        OrderGroupApiRequest requestBody = request.getData();
        Optional<OrderGroup> byId = orderGroupRepository.findById(requestBody.getId());

        Address reqAddress = Address.of(requestBody.getCity(), requestBody.getStreet(), requestBody.getZipcode());

        return Optional.ofNullable(request.getData())
                .map( body -> {
                    return orderGroupRepository.findById(body.getId())
                            .map(orderGroup -> {
                                orderGroup.getDelivery().stream().filter(delivery -> !delivery.getReceiveAddress().equals(reqAddress))
                                        .map(deliveryRepository::save);
                                orderGroup.getTotalQuantity();
                                orderGroup.getTotalPrice();
                                return orderGroup;
                            }).map(this::response)
                            .orElseGet(() -> Header.error("No data existed"));
                }).orElseGet(() -> Header.error("No data existed"));
    }

    public Header cancelOrder(Long id) {
        return null;
    }

    private OrderDetailApiResponse orderDetailResponse(OrderDetail orderDetail) {
        log.info("new OrderDetail >> {}",orderDetail);
        return new OrderDetailApiResponse(orderDetail.getQuantity());
    }

    private Header<List<OrderDetailsApiResponse>> orderDetailsResponse(List<OrderDetail> orderDetails) {
        List<OrderDetailsApiResponse> body = orderDetails.stream().map(orderDetail -> {
            return OrderDetailsApiResponse.builder()
                    .orderStatus(orderDetail.getStatus())
                    .quantity(orderDetail.getQuantity())
                    .totalPrice(orderDetail.getTotalPrice())
                    .item(orderDetail.getItem().getId()).build();
        }).collect(Collectors.toUnmodifiableList());

        log.info("new OrderDetail >> {}",body);
        return Header.OK(body);
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
