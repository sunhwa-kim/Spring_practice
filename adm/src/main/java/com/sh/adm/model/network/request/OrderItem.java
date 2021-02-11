package com.sh.adm.model.network.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Getter
@NoArgsConstructor
public class OrderItem {
    private Long item_id;
    private int quantity;
    private BigDecimal eachItemTotalPrice;

    public static OrderItem of(Long item_id, int quantity, BigDecimal eachItemTotalPrice) {
        OrderItem orderItem = new OrderItem();
        orderItem.item_id = item_id;
        orderItem.quantity = quantity;
        orderItem.eachItemTotalPrice = eachItemTotalPrice;
        return orderItem;
    }
}
