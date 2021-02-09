package com.sh.adm.model.network.response;

import com.sh.adm.model.network.request.OrderItem;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
public class OrderDetailListApiResponse {

    private List<OrderItem> items;

    private Long order_group_id;

    public OrderDetailListApiResponse(List<OrderItem> items, Long order_group_id) {
        this.items = items;
        this.order_group_id = order_group_id;
    }
}

