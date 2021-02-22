package com.sh.adm.service.ordergroup;

import com.sh.adm.model.entity.OrderDetail;
import com.sh.adm.model.network.request.OrderDetailListApiRequest;
import com.sh.adm.model.network.request.OrderItem;
import com.sh.adm.model.network.response.OrderDetailListApiResponse;
import com.sh.adm.repository.OrderDetailRepository;
import com.sh.adm.repository.OrderGroupRepository;
import org.assertj.core.util.Lists;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.IntStream;
import java.util.stream.LongStream;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertAll;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;


@ExtendWith(MockitoExtension.class)
class OrderGroupSaveServiceImplTest {

    @InjectMocks
    OrderGroupSaveService orderGroupSaveService;
    @Mock
    OrderGroupRepository orderGroupRepository;
    @Mock
    OrderDetailRepository orderDetailRepository;




    @Test
    @DisplayName("장바구니 수정하기")
    void updateCartTest() {
        // 변경 전
        OrderDetailListApiRequest request = new OrderDetailListApiRequest(givenOrderItems(), 1L);
        OrderDetail mockOrderDetail = mock(OrderDetail.class);
        when(orderDetailRepository.findByOrderGroupIdOrderByItemIdAsc(1L)).thenReturn(Lists.newArrayList(mockOrderDetail));
        OrderDetailListApiResponse orderDetailListApiResponse = orderGroupSaveService.updateCart(request);

    }


    private List<OrderItem> givenOrderItems() {
        List<OrderItem> orderItemList = new ArrayList<>();
        IntStream.rangeClosed(0,1).forEach(i -> {
            OrderItem orderItem = OrderItem.of((long) i, i + 1, BigDecimal.TEN.multiply(BigDecimal.valueOf(i + 1)));
            orderItemList.add(orderItem);
        });
        orderItemList.add(OrderItem.of(2L, 5, BigDecimal.valueOf(500000)));
        return orderItemList;
    }

}