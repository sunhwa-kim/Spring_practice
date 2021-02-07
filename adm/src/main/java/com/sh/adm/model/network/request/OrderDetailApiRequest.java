package com.sh.adm.model.network.request;


import com.sh.adm.model.entity.Item;
import com.sh.adm.model.entity.OrderGroup;
import com.sh.adm.model.enumclass.OrderStatus;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
public class OrderDetailApiRequest {

    private Long id;

    private OrderStatus orderStatus;

    private LocalDateTime arrivalDate;

    private Integer quantity;

    private BigDecimal totalPrice;

    private Long userId;

    private Long orderGroupId;

    @NotEmpty(message="상품을 선택해 주세요")
    private Long itemId;

    @Builder
    public OrderDetailApiRequest(Long id, OrderStatus orderStatus, LocalDateTime arrivalDate, Integer quantity, BigDecimal totalPrice, Long userId,Long orderGroupId, Long item) {
        this.id = id;
        this.orderStatus = orderStatus;
        this.arrivalDate = arrivalDate;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.userId = userId;
        this.orderGroupId = orderGroupId;
        this.itemId = item;
    }
}
