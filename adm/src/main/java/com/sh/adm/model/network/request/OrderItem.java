package com.sh.adm.model.network.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class OrderItem {
    private Long item_id;
    private int quantity;

    public static OrderItem of(Long item_id, int quantity) {
        OrderItem orderItem = new OrderItem();
        orderItem.item_id = item_id;
        orderItem.quantity = quantity;

        return orderItem;
    }
}
