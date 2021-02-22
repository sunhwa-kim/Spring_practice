package com.sh.adm.service.ordergroup;

import com.sh.adm.exception.ItemNotFoundException;
import com.sh.adm.exception.OrderGroupNotFoundException;
import com.sh.adm.exception.UserNotFoundException;
import com.sh.adm.model.entity.Item;
import com.sh.adm.model.entity.OrderDetail;
import com.sh.adm.model.entity.OrderGroup;
import com.sh.adm.model.entity.User;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.OrderDetailApiRequest;
import com.sh.adm.model.network.request.OrderDetailListApiRequest;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.request.OrderItem;
import com.sh.adm.model.network.response.OrderDetailApiResponse;
import com.sh.adm.model.network.response.OrderDetailListApiResponse;
import com.sh.adm.model.network.response.OrderGroupApiResponse;
import com.sh.adm.repository.ItemRepository;
import com.sh.adm.repository.OrderDetailRepository;
import com.sh.adm.repository.OrderGroupRepository;
import com.sh.adm.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class OrderGroupSaveServiceImpl implements OrderGroupSaveService{
    private final ItemRepository itemRepository;
    private final UserRepository userRepository;

    private final OrderDetailRepository orderDetailRepository;
    private final OrderGroupRepository orderGroupRepository;

    @Override
    public void addToOrderDetail(Header<OrderDetailApiRequest> request) throws ItemNotFoundException, UserNotFoundException, OrderGroupNotFoundException {
        OrderDetailApiRequest body = request.getData();
        Item item = itemRepository.findById(body.getItemId()).orElseThrow(ItemNotFoundException::new);

        // 사용자 가입 후 첫 장바구니
        if (ObjectUtils.isEmpty(body.getOrderGroupId())){
            OrderDetail orderDetail1 = OrderDetail.createOrderDetail(item, body.getQuantity());
            User user = userRepository.findById(body.getUserId()).orElseThrow(UserNotFoundException::new);  // TODO Controller
            orderGroupRepository.save(OrderGroup.createOrderGroup(user, orderDetail1));
            OrderDetail getOrderDetail = orderDetailRepository.save(orderDetail1);
        }
        else{ // 장바구니 있으나 상품 유무 별
            OrderDetail orderDetail = orderDetailRepository.findByOrderGroupIdAndItemId(body.getItemId(), item.getId());
            if(ObjectUtils.isEmpty(orderDetail)){
                OrderGroup orderGroup = orderGroupRepository.findById(body.getOrderGroupId()).orElseThrow(OrderGroupNotFoundException::new);
                OrderDetail newOrderDetail = OrderDetail.createOrderDetail(item, body.getQuantity());
                newOrderDetail.setOrderGroup(orderGroup);
            }else{
                orderDetail.updateOrderDetail(item, body.getQuantity());
            }
        }
    }

    @Override
    public OrderDetailListApiResponse updateCart(OrderDetailListApiRequest request) {
        List<OrderDetail> orderDetails = orderDetailRepository.findByOrderGroupIdOrderByItemIdAsc(request.getOrder_group_id());
        int length = orderDetails.size();
        if (length > 1) {
            List<OrderItem> bodyItems = request.getItems();
            bodyItems.sort(Comparator.comparing(OrderItem::getItem_id));
            if (length >= bodyItems.size()) {
                for (int i = 0; i < bodyItems.size(); i++) {
                    OrderDetail orderDetail = orderDetails.get(i);
                    OrderItem bodyItem = bodyItems.get(i);
                    orderDetail.updateOrderDetail(orderDetail.getItem(), bodyItem.getQuantity());
                }
            }
        }
        Optional<OrderDetailListApiResponse> response = orderDetailListApiResponse(orderDetails, request.getOrder_group_id());
        return response.orElseThrow(OrderGroupNotFoundException::new);
    }

    @Override
    public Optional<OrderGroupApiResponse> order(Header<OrderGroupApiRequest> request) {
        return Optional.empty();
    }

    @Override
    public Optional<OrderGroupApiResponse> modifyOrder(Header<OrderGroupApiRequest> request) {
        return Optional.empty();
    }

    @Override
    public void cancelOrder(Long id){
        OrderGroup orderGroup = orderGroupRepository.findById(id).orElseThrow(OrderGroupNotFoundException::new);
        orderGroup.cancel();
        orderGroupRepository.deleteById(id);
    }


    private Optional<OrderDetailApiResponse> orderDetailResponse(OrderDetail orderDetail) {
        return Optional.of(new OrderDetailApiResponse(orderDetail.getQuantity(),orderDetail.getTotalPrice()));
    }

    private Optional<OrderDetailListApiResponse> orderDetailListApiResponse(List<OrderDetail> orderDetails, Long orderGroupId) {
        List<OrderItem> orderItems = new ArrayList<>();
        for (OrderDetail orderDetail : orderDetails) {
            orderItems.add(OrderItem.of(orderDetail.getItem().getId(), orderDetail.getQuantity(), orderDetail.getTotalPrice()));
        }
        return Optional.of(new OrderDetailListApiResponse(orderItems, orderGroupId));
    }
}
