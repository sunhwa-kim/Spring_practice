package com.sh.adm.model.network.request;


import com.sh.adm.model.entity.Item;
import com.sh.adm.model.entity.OrderGroup;
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

    private String orderStatus;

    private LocalDateTime arrivalDate;

    private Integer quantity;

    private BigDecimal totalPrice;

    private Long orderGroupId;

    @NotEmpty(message="상품을 선택해 주세요")
    private Long itemId;

    @Builder
    public OrderDetailApiRequest(Long id, String orderStatus, LocalDateTime arrivalDate, Integer quantity, BigDecimal totalPrice, Long orderGroupId, Long item) {
        this.id = id;
        this.orderStatus = orderStatus;
        this.arrivalDate = arrivalDate;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.orderGroupId = orderGroupId;
        this.itemId = item;
    }
}
