package com.sh.adm.orderdetail.service;

import com.sh.adm.item.entity.Item;
import com.sh.adm.item.exception.ItemNotFoundException;
import com.sh.adm.item.repository.ItemRepository;
import com.sh.adm.orderdetail.entity.OrderDetail;
import com.sh.adm.ordergroup.model.entity.OrderGroup;
import com.sh.adm.ordergroup.enumclass.OrderStatus;
import com.sh.adm.orderdetail.dto.OrderDetailApiRequest;
import com.sh.adm.orderdetail.dto.OrderDetailApiResponse;
import com.sh.adm.orderdetail.exception.OrderDetailNotFoundException;
import com.sh.adm.orderdetail.repository.OrderDetailRepository;
import com.sh.adm.ordergroup.repository.OrderGroupRepository;
import com.sh.adm.user.model.entity.User;
import com.sh.adm.user.exception.UserNotFoundException;
import com.sh.adm.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class OrderDetailService {
    private final ItemRepository itemRepository;
    private final UserRepository userRepository;

    private final OrderDetailRepository orderDetailRepository;
    private final OrderGroupRepository orderGroupRepository;

    public void addToOrderDetail(OrderDetailApiRequest request) {
        Item item = itemRepository.findById(request.getItemId()).orElseThrow(ItemNotFoundException::new);
        User user = userRepository.findById(request.getUserId()).orElseThrow(UserNotFoundException::new);
        int quantity = request.getQuantity();

        OrderGroup orderGroup = checkCartInOrderGroup(user);
        // 장바구니 생성
        if (ObjectUtils.isEmpty(orderGroup)){
            newCart(item, user, quantity);
        }
        else{ // 장바구니 내 상품 유/무
            Optional<OrderDetail> orderDetail = checkOrderDetail(OrderStatus.ORDERING, item.getId());
            if(orderDetail.isEmpty()){
                putInCart(item, orderGroup, quantity);
            }else{
                orderDetail.get().updateOrderDetail(item, quantity);
            }
        }
    }

    private OrderGroup checkCartInOrderGroup(User user) {
        List<OrderGroup> orderGroups = orderGroupRepository.findByStatusAndUserId(OrderStatus.ORDERING, user.getId());
        if(ObjectUtils.isEmpty(orderGroups)) return null;
        int size = orderGroups.size();
        int latestOrderGroupIdx = 0;
        for (int i = size-1; i>=1 ; i--) {
            if(orderGroups.get(i).getUpdatedAt().isAfter(orderGroups.get(i-1).getUpdatedAt())){
                latestOrderGroupIdx = (i-1);
            }
        }
        return orderGroups.get(latestOrderGroupIdx);
    }

    @Transactional
    private void newCart(Item item, User user, int quantity) {
        OrderDetail orderDetail1 = OrderDetail.createOrderDetail(item, quantity);
        orderGroupRepository.save(OrderGroup.createOrderGroup(user, orderDetail1));
        orderDetailRepository.save(orderDetail1);
    }
    private Optional<OrderDetail> checkOrderDetail(OrderStatus ordering, Long id) {
        return orderDetailRepository.findByOrderStatusAndItemId(ordering, id);
    }
    @Transactional
    private void putInCart(Item item, OrderGroup orderGroup, int quantity) {
        OrderDetail newOrderDetail = OrderDetail.createOrderDetail(item, quantity);
        newOrderDetail.setOrderGroup(orderGroup);
        orderDetailRepository.save(newOrderDetail);
    }

    public OrderDetailApiResponse modifyOrderDetail(Long orderGroupId, OrderDetailApiRequest request) {
        Item item = itemRepository.findById(request.getItemId()).orElseThrow(ItemNotFoundException::new);
        OrderDetail orderDetail = orderDetailRepository.findByOrderGroupIdAndItemId(orderGroupId, item.getId()).orElseThrow(OrderDetailNotFoundException::new);
        orderDetail.updateOrderDetail(item, request.getQuantity());
        return orderDetailResponse(request, orderDetail);
    }

    public void deleteCart(OrderDetailApiRequest request) {
        Optional<OrderDetail> orderDetail = orderDetailRepository.findByOrderGroupIdAndItemId(request.getOrderGroupId(), request.getItemId());
        if(orderDetail.isEmpty()) throw new OrderDetailNotFoundException();
        orderDetail.get().cancel();
        orderDetail.get().setOrderGroup(null);
        orderDetailRepository.delete(orderDetail.get());
    }

    private OrderDetailApiResponse orderDetailResponse(OrderDetailApiRequest request,OrderDetail orderDetail) {
        return OrderDetailApiResponse.builder()
                .id(request.getId())
                .orderStatus(orderDetail.getStatus().getTitle())
                .arrivalDate(orderDetail.getArrivalDate())
                .quantity(orderDetail.getQuantity())
                .totalPrice(orderDetail.getTotalPrice())
                .orderGroupId(request.getOrderGroupId())
                .itemId(orderDetail.getItem().getId())
                .build();
    }

}
